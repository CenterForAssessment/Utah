#+ include = FALSE, purl = FALSE, eval = FALSE
###############################################################################
###                                                                         ###
###        Code for cleaning and preparation of Utah 2026 LONG data         ###
###                                                                         ###
###############################################################################

###   Load packages
require(data.table)
require(SGP)

###   Read in USBE data file - ELA, Math and Science
Utah_Data_LONG_2026 <-
    fread(
        file = "./Data/Base_Files/USBE Longfile 2026.csv",
        colClasses = rep("character", 25),
        na.strings = "NULL"
    )

Utah_Data_LONG_2026[,
    c("YEAR", "ID") := NULL   #   `school_year`, `student_id` duplicates
]
setNamesSGP(Utah_Data_LONG_2026)

###   Re-construct `TestGradeLevel` from `TestSubject`
Utah_Data_LONG_2026[,
    TestGradeLevel := gsub("th.*|rd.*", "", TestSubject)
][TestGradeLevel == "Secondary Ma",
  TestGradeLevel := "EOCT"
]

###   Use `TestGradeLevel` for GRADE  --  See below re: ach lev mismatches
setnames(
    Utah_Data_LONG_2026,
    c("GRADE", "TestGradeLevel"),
    c("GradeEnrolled", "GRADE")
)

###   Make the SCALE_SCORE variable numeric and invalidate missing scores
#     table(Utah_Data_LONG_2026[, .(GRADE, VALID_CASE), CONTENT_AREA])
#     Utah_Data_LONG_2026[, as.list(summary(SCALE_SCORE)), keyby = .(CONTENT_AREA, GRADE)]

Utah_Data_LONG_2026[,
    SCALE_SCORE := as.numeric(SCALE_SCORE)
][ SCALE_SCORE == 0, SCALE_SCORE := NA
][ is.na(SCALE_SCORE), VALID_CASE := "INVALID_CASE"
]

###   Invalidate duplicates with multiple scores
# sgp.key <- c("VALID_CASE", "YEAR", "ID", "CONTENT_AREA")
# setkeyv(Utah_Data_LONG_2026, c(sgp.key, "GRADE", "SCALE_SCORE"))
# setkeyv(Utah_Data_LONG_2026, c(sgp.key, "GRADE"))
# dupl <-
#     duplicated(Utah_Data_LONG_2026, by = key(Utah_Data_LONG_2026))
# sum(dupl) # 5,533 WITHIN-GRADE duplicates - (take the record with the HIGHEST score)
# dups <- Utah_Data_LONG_2026[c(which(dupl), which(dupl) - 1),]
# setkeyv(dups, sgp.key) # All cases are already INVALID # table(dups$VALID_CASE)
# Utah_Data_LONG_2026[which(dupl) - 1, VALID_CASE := "INVALID_CASE"]

##    No need to INVALIDATE these kids - it will be sorted out through configs.
##    Good thing to check annually anyway.
# setkeyv(Utah_Data_LONG_2026, c(sgp.key, "SCALE_SCORE"))
# setkeyv(Utah_Data_LONG_2026, sgp.key)
# dupl <-
#     duplicated(Utah_Data_LONG_2026, by = key(Utah_Data_LONG_2026))
# sum(dupl)
#   1052 duplicates in '26


###
##  Tidy up data
###

###   Transform ACHIEVEMENT_LEVEL VARIABLE to character
Utah_Data_LONG_2026[,
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
##    2 mismatches in original '26, both in 9th grade.
##    Preserve incorrect USBE/Questar achievement level (Historical) variable.
##    KEEP and check EACH year for achievement level mismatches !!!
# table(Utah_Data_LONG_2026[,
#         .(ACHIEVEMENT_LEVEL, VALID_CASE), is.na(SCALE_SCORE)],
#       exclude = NULL)

setnames(Utah_Data_LONG_2026, "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_ORIGINAL")
Utah_Data_LONG_2026 <-
    SGP:::getAchievementLevel(Utah_Data_LONG_2026, state = "UT")
Utah_Data_LONG_2026[, ACHIEVEMENT_LEVEL :=
    factor(ACHIEVEMENT_LEVEL, ordered = TRUE,
           levels = c("Below", "Approaching", "Proficient", "Highly")
    ) |> as.character()
]

##    Investigate ACHIEVEMENT_LEVEL mismatches
# table(Utah_Data_LONG_2026[, VALID_CASE, ACHIEVEMENT_LEVEL_ORIGINAL], exclude = NULL)
# table(Utah_Data_LONG_2026[, ACHIEVEMENT_LEVEL, ACHIEVEMENT_LEVEL_ORIGINAL], exclude = NULL)
# table(Utah_Data_LONG_2026[
#         ACHIEVEMENT_LEVEL_ORIGINAL != ACHIEVEMENT_LEVEL &
#         VALID_CASE == "VALID_CASE",
#         .(ACHIEVEMENT_LEVEL, CONTENT_AREA), GRADE],
#       exclude = NULL)
# Utah_Data_LONG_2026[
#     !is.na(SCALE_SCORE) &
#     ACHIEVEMENT_LEVEL != ACHIEVEMENT_LEVEL_ORIGINAL,
#       as.list(summary(SCALE_SCORE)),
#     keyby =
#       c("CONTENT_AREA", "GRADE", "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_ORIGINAL")
# ]


###   Invalidate ACHIEVEMENT_LEVEL mismatches
##    We previously only invalidated grades 3:8. Continued in 2026.
# Utah_Data_LONG_2026[
#     GRADE %in% 3:8 &
#     ACHIEVEMENT_LEVEL_ORIGINAL != ACHIEVEMENT_LEVEL,
#         VALID_CASE := "INVALID_CASE"
# ]

##    Preserve incorrect(?) USBE/Questar achievement level (Historical) variable.
Utah_Data_LONG_2026[, ACHIEVEMENT_LEVEL := NULL]
setnames(Utah_Data_LONG_2026, "ACHIEVEMENT_LEVEL_ORIGINAL", "ACHIEVEMENT_LEVEL")
Utah_Data_LONG_2026[
    ACHIEVEMENT_LEVEL == "NA",
    ACHIEVEMENT_LEVEL := NA_character_
][
    CONTENT_AREA == "NA",
    CONTENT_AREA := NA_character_
]


##    Snapshot of grade-level participation rates
Utah_Data_LONG_2026[, VALID_CASE, GRADE] |> # .(VALID_CASE, CONTENT_AREA)
    table() |> prop.table(1) |>
        round(5) * 100


###   Tidy up Demographic Variables
##    - Student demographic variable consistency
##    - Camel Case Student NAMES
##    - Add in ENROLLMENT STATUS variables
Utah_Data_LONG_2026[,
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
# table(Utah_Data_LONG_2026[, ETHNICITY], exclude = NULL)


###   Ensure that all names are capitalized consistently (camel case)
##    - Convert NAME variables to factor so that we can just work with
##      the factor levels (much quicker!)

Utah_Data_LONG_2026[, LAST_NAME := factor(LAST_NAME)]
setattr(Utah_Data_LONG_2026$LAST_NAME, "levels",
        sapply(
            levels(Utah_Data_LONG_2026$LAST_NAME),
            capwords,  USE.NAMES = FALSE
        )
)
Utah_Data_LONG_2026[, LAST_NAME := as.character(LAST_NAME)]

Utah_Data_LONG_2026[, FIRST_NAME := factor(FIRST_NAME)]
setattr(Utah_Data_LONG_2026$FIRST_NAME, "levels",
        sapply(
            levels(Utah_Data_LONG_2026$FIRST_NAME),
            capwords, USE.NAMES = FALSE
        )
)
Utah_Data_LONG_2026[, FIRST_NAME := as.character(FIRST_NAME)]


###  Add in ENROLLMENT STATUS variables
Utah_Data_LONG_2026[, SCHOOL_ENROLLMENT_STATUS := "Enrolled School: Yes"]
Utah_Data_LONG_2026[, DISTRICT_ENROLLMENT_STATUS := "Enrolled District: Yes"]
Utah_Data_LONG_2026[, STATE_ENROLLMENT_STATUS := "Enrolled State: Yes"]


save(Utah_Data_LONG_2026, file = "Data/Utah_Data_LONG_2026.Rdata")


#' ## Data Preparation
#'
#' The data preparation step involves taking data provided by the USBE and
#' producing a `.Rdata` file that will subsequently be analyzed using the `SGP`
#' software. This process is carried out annually as new data becomes available.
#'
#' For the 2026 Utah RISE/UA+ data preparation and cleaning, we first modify
#' values of student demographic and achievement level variables to match with
#' values and factor levels that have been used in previous years or as
#' required to conform to the `SGP` package conventions.
#'
#' The data was also examined to identify invalid records.
#' Student records were flagged as "invalid" based on the following criteria:
#'
#' * Student records with a reported `ACHIEVEMENT_LEVEL` value outside of the
#'   corresponding scale score range. This issue did not impact elementary or
#'   middle school level students in 2026.
#' * Students with duplicate records. In these instances, a student's highest
#'   scale score is retained for the SGP analyses.
#' * Student records with grade levels matching un-tested grades are invalidated.
#'   No such students were found in the final data provided to The Center.
