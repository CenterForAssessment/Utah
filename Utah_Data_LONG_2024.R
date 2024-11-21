#+ include = FALSE, purl = FALSE, eval = FALSE
###############################################################################
###                                                                         ###
###        Code for cleaning and preparation of Utah 2024 LONG data         ###
###                                                                         ###
###############################################################################

###   Load packages
library(data.table)
library(SGP)

###   Read in USBE data file - ELA, Math and Science
Utah_Data_LONG_2024 <-
    fread("./Data/Base_Files/Utah_Data_LONG_2024.csv",
          colClasses = rep("character", 26),
          na.strings = "NULL"
    )
Utah_Data_LONG_2024[,
    c("YEAR", "ID") := NULL   #   `school_year`, `student_id` duplicates
]
setNamesSGP(Utah_Data_LONG_2024)

###   Use `TestGradeLevel` for GRADE  --  See below re: ach lev mismatches
setnames(
    Utah_Data_LONG_2024,
    c("GRADE", "TestGradeLevel"),
    c("GradeEnrolled", "GRADE")
)
Utah_Data_LONG_2024[CONTENT_AREA == "SEC_MATH_I", GRADE := "EOCT"]

##    Fix leading 0s in GRADE
# Utah_Data_LONG_2024[, GRADE := gsub("^0", "", GRADE)]


###   Make the SCALE_SCORE variable numeric and invalidate missing scores
#     table(Utah_Data_LONG_2024[, .(VALID_CASE, GRADE), CONTENT_AREA])
#     All 9th and 10th graders
Utah_Data_LONG_2024[, SCALE_SCORE := as.numeric(SCALE_SCORE)]
Utah_Data_LONG_2024[
    SCALE_SCORE == 0, SCALE_SCORE := NA
][is.na(SCALE_SCORE), VALID_CASE := "INVALID_CASE"
]
# Utah_Data_LONG_2024[SCALE_SCORE == 0, VALID_CASE := "INVALID_CASE"]
# Utah_Data_LONG_2024[is.na(SCALE_SCORE), VALID_CASE := "INVALID_CASE"]

###   Invalidate duplicates with multiple scores
sgp.key <- c("VALID_CASE", "YEAR", "ID", "CONTENT_AREA")
setkeyv(Utah_Data_LONG_2024, c(sgp.key, "GRADE", "SCALE_SCORE"))
setkeyv(Utah_Data_LONG_2024, c(sgp.key, "GRADE"))
dupl <-
    duplicated(Utah_Data_LONG_2024, by = key(Utah_Data_LONG_2024))
sum(dupl) # 0 WITHIN-GRADE duplicates - (take the record with the HIGHEST score)
# Utah_Data_LONG_2024[which(dupl) - 1, VALID_CASE := "INVALID_CASE"]

##    No need to INVALIDATE these kids - it will be sorted out through configs.
##    Good thing to check annually anyway.
# setkeyv(Utah_Data_LONG_2024, c(sgp.key, "SCALE_SCORE"))
# setkeyv(Utah_Data_LONG_2024, sgp.key)
# dupl <-
#     duplicated(Utah_Data_LONG_2024, by = key(Utah_Data_LONG_2024))
# sum(dupl) # 0 CROSS-GRADE duplicates in v2 - (take the record with the HIGHEST score)
# Utah_Data_LONG_2024[which(dupl) - 1, VALID_CASE := "INVALID_CASE"]


##    Invalidate out of grade records (0 in 2024)
##    Originally 2 in SCIENCE, but issue fixed in v2 data with `TestGradeLevel`
# Utah_Data_LONG_2024[
#     CONTENT_AREA == "SCIENCE" & GRADE == "3",
#     VALID_CASE := "INVALID_CASE"
# ]

###
##  Tidy up data
###

###   Transform ACHIEVEMENT_LEVEL VARIABLE to full and simplified versions
table(Utah_Data_LONG_2024[,
          ACHIEVEMENT_LEVEL,
          is.na(SCALE_SCORE)
      ],
      exclude = NULL
)
Utah_Data_LONG_2024[,
    ACHIEVEMENT_LEVEL :=
        factor(
            x = ACHIEVEMENT_LEVEL,
            ordered = TRUE,
            levels = 0:4,
            labels = c(NA, "Below", "Approaching", "Proficient", "Highly")
        ) |> as.character()
]

###   Invalidate mismatched Achievement Levels per Aaron B (10/1/19 email).
##
##    MANY mismatches in original 2024 again. This time due to students'
##    GRADE (enrollment) not matching the test administered.  DMackay provided
##    `TestGradeLevel` to correct. One (1) Grade 10 ELA case found in 2024.
##    Preserve incorrect USBE/Questar achievement level (Historical) variable.
##    KEEP and check EACH year for achievement level mismatches !!!

# setnames(Utah_Data_LONG_2024, "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_FULL")
# Utah_Data_LONG_2024 <-
#     SGP:::getAchievementLevel(Utah_Data_LONG_2024, state = "UT")
# Utah_Data_LONG_2024[, ACHIEVEMENT_LEVEL :=
#     factor(ACHIEVEMENT_LEVEL, ordered = TRUE,
#            levels = c("Below", "Approaching", "Proficient", "Highly")
#     ) |> as.character()
# ]

# ##    Investigate ACHIEVEMENT_LEVEL mismatches
# table(Utah_Data_LONG_2024[, VALID_CASE, ACHIEVEMENT_LEVEL_FULL], exclude = NULL)
# table(Utah_Data_LONG_2024[, ACHIEVEMENT_LEVEL, ACHIEVEMENT_LEVEL_FULL],
#       exclude = NULL)
# table(Utah_Data_LONG_2024[
#         ACHIEVEMENT_LEVEL_FULL != ACHIEVEMENT_LEVEL &
#         VALID_CASE == "VALID_CASE",
#         .(ACHIEVEMENT_LEVEL, CONTENT_AREA), GRADE],
#       exclude = NULL)
# Utah_Data_LONG_2024[
#     !is.na(SCALE_SCORE) &
#     ACHIEVEMENT_LEVEL != ACHIEVEMENT_LEVEL_FULL,
#       as.list(summary(SCALE_SCORE)),
#     keyby =
#       c("CONTENT_AREA", "GRADE", "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_FULL")
# ]

# ###   Invalidate ACHIEVEMENT_LEVEL mismatches
# ##    We previously only invalidated grades 3:8. Continued in 2024 (FIXED in v2 data).
# Utah_Data_LONG_2024[
#     GRADE %in% 3:8 &
#     ACHIEVEMENT_LEVEL_FULL != ACHIEVEMENT_LEVEL,
#         VALID_CASE := "INVALID_CASE"
# ]

# ##    Preserve incorrect USBE/Questar achievement level (Historical) variable.
# Utah_Data_LONG_2024[, ACHIEVEMENT_LEVEL := NULL]
# setnames(Utah_Data_LONG_2024, "ACHIEVEMENT_LEVEL_FULL", "ACHIEVEMENT_LEVEL")


##    Snapshot of grade-level participation rates
Utah_Data_LONG_2024[, VALID_CASE, GRADE] |> # .(VALID_CASE, CONTENT_AREA)
    table() |> prop.table(1) |>
         round(5) * 100


###   Tidy up Demographic Variables
Utah_Data_LONG_2024[,
    ELL_STATUS :=
      factor(
            x = ELL_STATUS,
            levels = 0:1,
            labels = c("ELL: No", "ELL: Yes")
      ) |> as.character()
][, IEP_STATUS :=
      factor(
            x = IEP_STATUS,
            levels = 0:1,
            labels = c("IEP: No", "IEP: Yes")
      ) |> as.character()
][, FRL_STATUS :=
      factor(
            x = FRL_STATUS,
            levels = 0:1,
            labels = c("Free Reduced Lunch: No", "Free Reduced Lunch: Yes")
      ) |> as.character()
][, ETHNICITY :=
      factor(
            x = ETHNICITY,
            labels  = c("Asian", "AfAm/Black", "White",
                        "Hispanic/Latino", "American Indian",
                        "Multiple Races", "Pacific Islander")
      ) |> as.character()
]
# A = "Asian"
# B = "AfAm/Black"
# C = "White"
# H = "Hispanic/Latino"
# I = "American Indian"
# M = "Multiple Races"
# P = "Pacific Islander"
# table(Utah_Data_LONG_2024[, ETHNICITY], exclude = NULL)



###   Ensure that all names are capitalized consistently (camel case)
###   Convert NAME variables to factor so that we can just work with
###   the factor levels (much quicker!)

Utah_Data_LONG_2024[, LAST_NAME := factor(LAST_NAME)]
setattr(Utah_Data_LONG_2024$LAST_NAME, "levels",
        sapply(
            levels(Utah_Data_LONG_2024$LAST_NAME),
            capwords,  USE.NAMES = FALSE
        )
)
Utah_Data_LONG_2024[, LAST_NAME := as.character(LAST_NAME)]

Utah_Data_LONG_2024[, FIRST_NAME := factor(FIRST_NAME)]
setattr(Utah_Data_LONG_2024$FIRST_NAME, "levels",
        sapply(
            levels(Utah_Data_LONG_2024$FIRST_NAME),
            capwords, USE.NAMES = FALSE
        )
)
Utah_Data_LONG_2024[, FIRST_NAME := as.character(FIRST_NAME)]


###  Add in ENROLLMENT STATUS variables
Utah_Data_LONG_2024[, SCHOOL_ENROLLMENT_STATUS := "Enrolled School: Yes"]
Utah_Data_LONG_2024[, DISTRICT_ENROLLMENT_STATUS := "Enrolled District: Yes"]
Utah_Data_LONG_2024[, STATE_ENROLLMENT_STATUS := "Enrolled State: Yes"]

save(Utah_Data_LONG_2024, file = "Data/Utah_Data_LONG_2024.Rdata")


#' ## Data Preparation
#' 
#' The data preparation step involves taking data provided by the USBE and
#' producing a `.Rdata` file that will subsequently be analyzed using the `SGP`
#' software. This process is carried out annually as new data becomes available.
#' 
#' For the 2024 Utah RISE/UA+ data preparation and cleaning, we first modify
#' values of student demographic and achievement level variables to match with
#' values and factor levels that have been used in previous years or as
#' required to conform to the `SGP` package conventions.
#' 
#' The data was also examined to identify invalid records. 
#' Student records were flagged as "invalid" based on the following criteria:
#'
#' * Student records with a reported `ACHIEVEMENT_LEVEL` value outside of the
#'   corresponding scale score range. This issue was found to impact about 1,000
#'   student records. However, when the *grade assessed* was substituted for the
#'   original `GRADE` data, the issue was found to only impact a single student.
#' * Students with duplicate records. In these instances, a student's highest
#'   scale score is retained as the "valid" case for the SGP analyses.
#' * Student records with grade levels matching un-tested grades were
#'   invalidated. No such students were found in the final data provided to
#'   The Center.
