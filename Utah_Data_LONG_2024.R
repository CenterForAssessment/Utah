#+ include = FALSE, purl = FALSE, eval = FALSE
###############################################################################
###                                                                         ###
###        Code for cleaning and preparation of Utah 2024 LONG data         ###
###                                                                         ###
###############################################################################

library(SGP)
library(data.table)

###   Read in USBE data file - ELA, Math and Science
Utah_Data_LONG_2024 <-
    fread("./Data/Base_Files/Utah_Data_LONG_2024.csv",
          colClasses = rep("character", 25),
          na.strings = "NULL"
    )
Utah_Data_LONG_2024[, c("YEAR", "ID") := NULL] # school_year, student_id duplicates
# setnames(Utah_Data_LONG_2024, "IsSpeciealEd", "IsSpecialEd", skip_absent = TRUE)
setNamesSGP(Utah_Data_LONG_2024)

###   Fix leading 0s in GRADE
Utah_Data_LONG_2024[, GRADE := gsub("^0", "", GRADE)]

###   Make the SCALE_SCORE variable numeric and invalidate missing scores
#     table(Utah_Data_LONG_2024[, .(VALID_CASE, GRADE), CONTENT_AREA])
#     All 9th and 10th graders
Utah_Data_LONG_2024[, SCALE_SCORE := as.numeric(SCALE_SCORE)]
Utah_Data_LONG_2024[is.na(SCALE_SCORE), VALID_CASE := "INVALID_CASE"]

###   Invalidate duplicates with multiple scores
sgp.key <- c("VALID_CASE", "YEAR", "ID", "CONTENT_AREA")
setkeyv(Utah_Data_LONG_2024, c(sgp.key, "GRADE", "SCALE_SCORE"))
setkeyv(Utah_Data_LONG_2024, c(sgp.key, "GRADE"))
dupl <-
    duplicated(Utah_Data_LONG_2024, by = key(Utah_Data_LONG_2024))
sum(dupl) # 8 CROSS-GRADE duplicates - (take the record with the HIGHEST score)
Utah_Data_LONG_2024[which(dupl) - 1, VALID_CASE := "INVALID_CASE"]

setkeyv(Utah_Data_LONG_2024, c(sgp.key, "SCALE_SCORE"))
setkeyv(Utah_Data_LONG_2024, sgp.key)
dupl <-
    duplicated(Utah_Data_LONG_2024, by = key(Utah_Data_LONG_2024))
sum(dupl) # 0 CROSS-GRADE duplicates - (take the record with the HIGHEST score)
Utah_Data_LONG_2024[which(dupl) - 1, VALID_CASE := "INVALID_CASE"]

###   Invalidate out of grade records (2 in 2024)
Utah_Data_LONG_2024[
    CONTENT_AREA == "SCIENCE" & GRADE == "3",
    VALID_CASE := "INVALID_CASE"
]

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
Utah_Data_LONG_2024[, ACHIEVEMENT_LEVEL :=
    factor(ACHIEVEMENT_LEVEL,
           ordered = TRUE,
           levels = 0:4,
           labels = c(NA, "Below", "Approaching", "Proficient", "Highly")
    )
]

###   Invalidate mismatched Achievement Levels per Aaron B (10/1/19 email).
##
##    MANY mismatches in 2024 again. Only invalidated grades 3:8 previously, so
##    continue with that. Preserve incorrect USBE/Questar Achievement Level
##    var in "*_FULL" (Historical) variable

setnames(Utah_Data_LONG_2024, "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_FULL")
Utah_Data_LONG_2024 <-
    SGP:::getAchievementLevel(Utah_Data_LONG_2024, state = "UT")
Utah_Data_LONG_2024[, ACHIEVEMENT_LEVEL :=
    factor(ACHIEVEMENT_LEVEL, ordered = TRUE,
           levels = c("Below", "Approaching", "Proficient", "Highly")
    )
]

##   Reset the class of the ACHIEVEMENT_LEVEL variables to character
Utah_Data_LONG_2024[,
    ACHIEVEMENT_LEVEL := as.character(ACHIEVEMENT_LEVEL)
][, ACHIEVEMENT_LEVEL_FULL := as.character(ACHIEVEMENT_LEVEL_FULL)
]

###   Investigate ACHIEVEMENT_LEVEL mismatches
table(Utah_Data_LONG_2024[, VALID_CASE, ACHIEVEMENT_LEVEL_FULL])
table(Utah_Data_LONG_2024[, ACHIEVEMENT_LEVEL, ACHIEVEMENT_LEVEL_FULL],
      exclude = NULL)
table(Utah_Data_LONG_2024[
        ACHIEVEMENT_LEVEL_FULL != ACHIEVEMENT_LEVEL &
        VALID_CASE == "VALID_CASE",
        .(ACHIEVEMENT_LEVEL, CONTENT_AREA), GRADE],
      exclude = NULL)
Utah_Data_LONG_2024[
    !is.na(SCALE_SCORE) &
    ACHIEVEMENT_LEVEL != ACHIEVEMENT_LEVEL_FULL,
      as.list(summary(SCALE_SCORE)),
    keyby =
      c("CONTENT_AREA", "GRADE", "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_FULL")
]

###   Invalidate ACHIEVEMENT_LEVEL mismatches
##    We previously only invalidated grades 3:8. Continued in 2024 (CONFIRM).
Utah_Data_LONG_2024[
    GRADE %in% 3:8 &
    ACHIEVEMENT_LEVEL_FULL != ACHIEVEMENT_LEVEL,
        VALID_CASE := "INVALID_CASE"
]
# Utah_Data_LONG_2024[, ACHIEVEMENT_LEVEL := NULL] # Keep this until decision made on mismatch
# setnames(Utah_Data_LONG_2024, "ACHIEVEMENT_LEVEL_FULL", "ACHIEVEMENT_LEVEL")


##    Snapshot of grade-level participation rates
Utah_Data_LONG_2024[, VALID_CASE, GRADE] |> # .(VALID_CASE, CONTENT_AREA)
    table() |> prop.table(1) |>
         round(5) * 100


###   Tidy up Demographic Variables
table(Utah_Data_LONG_2024[, ETHNICITY], exclude = NULL)
Utah_Data_LONG_2024[, ETHNICITY :=
    as.character(
        factor(ETHNICITY,
               labels = c("Asian", "AfAm/Black", "White",
                          "Hispanic/Latino", "American Indian",
                          "Multiple Races", "Pacific Islander")
        )
    )
]
# A = "Asian"
# B = "AfAm/Black"
# C = "White"
# H = "Hispanic/Latino"
# I = "American Indian"
# M = "Multiple Races"
# P = "Pacific Islander"

Utah_Data_LONG_2024[,
    ELL_STATUS :=
    as.character(
        factor(ELL_STATUS,
               levels = 0:1,
               labels = c("ELL: No", "ELL: Yes")
        )
    )
][, IEP_STATUS :=
    as.character(
        factor(IEP_STATUS,
               levels = 0:1,
               labels = c("IEP: No", "IEP: Yes")
        )
    )
][, FRL_STATUS :=
    as.character(
        factor(FRL_STATUS,
               levels = 0:1,
               labels = c("Free Reduced Lunch: No",
                          "Free Reduced Lunch: Yes")
        )
    )
]


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
#'   corresponding scale score range. This issue was found to impact six (6)
#'   student records
#'   - Students with duplicate records. In these instances, a student's highest
#'     scale score is retained as the "valid" case for the SGP analyses.
#' * Student records with grade levels matching un-tested grades were
#'   invalidated. Two (2) students identified as third graders had assessment
#'   records for science, and science testing does not begin until grade 4.
