#+ include = FALSE, purl = FALSE, eval = FALSE
###############################################################################
###                                                                         ###
###        Code for cleaning and preparation of Utah 2023 LONG data         ###
###                                                                         ###
###############################################################################

library(SGP)
library(data.table)

###   Read in USBE data file - ELA, Math and Science
Utah_Data_LONG_2023 <-
    fread("./Data/Base_Files/Utah_Data_LONG_2023.csv",
          colClasses = rep("character", 25),
          na.strings = "NULL"
    )
Utah_Data_LONG_2023[, c("YEAR", "ID") := NULL] # school_year, student_id duplicates
setNamesSGP(Utah_Data_LONG_2023)

###   Fix leading 0s in GRADE
Utah_Data_LONG_2023[, GRADE := gsub("^0", "", GRADE)]

###   Invalidate duplicates with multiple scores
Utah_Data_LONG_2023[is.na(SCALE_SCORE), VALID_CASE := "INVALID_CASE"]
sgp.key <- c("VALID_CASE", "YEAR", "ID", "CONTENT_AREA")
setkeyv(Utah_Data_LONG_2023, c(sgp.key, "GRADE", "SCALE_SCORE"))
setkeyv(Utah_Data_LONG_2023, c(sgp.key, "GRADE"))
dupl <-
    duplicated(
        Utah_Data_LONG_2023[VALID_CASE != "INVALID_CASE"],
        by = key(Utah_Data_LONG_2023)
    )
sum(dupl) # 6 CROSS-GRADE duplicates - (take the record with the HIGHEST score)
Utah_Data_LONG_2023[which(dupl) - 1, VALID_CASE := "INVALID_CASE"]

setkeyv(Utah_Data_LONG_2023, c(sgp.key, "SCALE_SCORE"))
setkeyv(Utah_Data_LONG_2023, sgp.key)
dupl <-
    duplicated(
        Utah_Data_LONG_2023[VALID_CASE != "INVALID_CASE"],
        by = key(Utah_Data_LONG_2023)
    )
sum(dupl) # 0 CROSS-GRADE duplicates - (take the record with the HIGHEST score)
Utah_Data_LONG_2023[which(dupl) - 1, VALID_CASE := "INVALID_CASE"]

###   Invalidate out of grade records (2 in 2023)
Utah_Data_LONG_2023[
    CONTENT_AREA == "SCIENCE" & GRADE == "3",
    VALID_CASE := "INVALID_CASE"
]

###
##  Tidy up data
###

###  Make the SCALE_SCORE variable numeric
Utah_Data_LONG_2023[, SCALE_SCORE := as.numeric(SCALE_SCORE)]

###   Transform ACHIEVEMENT_LEVEL VARIABLE to full and simplified versions
table(Utah_Data_LONG_2023[,
          ACHIEVEMENT_LEVEL,
          is.na(SCALE_SCORE)
      ],
      exclude = NULL
)
Utah_Data_LONG_2023[, ACHIEVEMENT_LEVEL :=
    factor(ACHIEVEMENT_LEVEL,
           ordered = TRUE,
           levels = 0:4,
           labels = c(NA, "Below", "Approaching", "Proficient", "Highly")
    )
]

##    Invalidate mismatched Achievement Levels per Aaron B (10/1/19 email)
##    Only 2 cases (G9 ELA) - we only invalidated grades 3:8 previously, so
##    continue with that. Preserve incorrect USBE/Questar Achievement Level
##    var in "*_FULL" (Historical) variable
setnames(Utah_Data_LONG_2023, "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_FULL")
Utah_Data_LONG_2023 <-
    SGP:::getAchievementLevel(Utah_Data_LONG_2023, state = "UT")
Utah_Data_LONG_2023[, ACHIEVEMENT_LEVEL :=
    factor(ACHIEVEMENT_LEVEL, ordered = TRUE,
           levels = c("Below", "Approaching", "Proficient", "Highly")
    )
]

##   Reset the class of the ACHIEVEMENT_LEVEL variables to character
Utah_Data_LONG_2023[, ACHIEVEMENT_LEVEL :=
                        as.character(ACHIEVEMENT_LEVEL)
]
Utah_Data_LONG_2023[, ACHIEVEMENT_LEVEL_FULL :=
                        as.character(ACHIEVEMENT_LEVEL_FULL)
]
table(Utah_Data_LONG_2023[, VALID_CASE, ACHIEVEMENT_LEVEL_FULL])
table(Utah_Data_LONG_2023[, ACHIEVEMENT_LEVEL, ACHIEVEMENT_LEVEL_FULL],
      exclude = NULL)
table(Utah_Data_LONG_2023[ACHIEVEMENT_LEVEL_FULL != ACHIEVEMENT_LEVEL,
                          CONTENT_AREA, GRADE], exclude = NULL)
#   All ACHIEVEMENT_LEVEL mismatches are INVALID_CASEs
# Utah_Data_LONG_2023[
#     !is.na(SCALE_SCORE) &
#     is.na(ACHIEVEMENT_LEVEL) &
#     !is.na(ACHIEVEMENT_LEVEL_FULL),
#         as.list(summary(SCALE_SCORE)),
#     keyby = c("CONTENT_AREA", "GRADE", "VALID_CASE")
# ]
# #    We only invalidated grades 3:8 previously, so continue with that.
# Utah_Data_LONG_2023[
#     GRADE %in% 3:8 &
#     ACHIEVEMENT_LEVEL_FULL != ACHIEVEMENT_LEVEL,
#         VALID_CASE := "INVALID_CASE"
# ]
Utah_Data_LONG_2023[, ACHIEVEMENT_LEVEL := NULL]
setnames(Utah_Data_LONG_2023, "ACHIEVEMENT_LEVEL_FULL", "ACHIEVEMENT_LEVEL")

##    Snapshot of grade-level participation rates
# Utah_Data_LONG_2023[, VALID_CASE, GRADE] |> # .(VALID_CASE, CONTENT_AREA)
#     table() |> prop.table(1) |>
#          round(5) * 100


###   Tidy up Demographic Variables
table(Utah_Data_LONG_2023[, ETHNICITY], exclude = NULL)
Utah_Data_LONG_2023[, ETHNICITY :=
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

Utah_Data_LONG_2023[, ELL_STATUS :=
    as.character(
        factor(ELL_STATUS,
               levels = 0:1,
               labels = c("ELL: No", "ELL: Yes")
        )
    )
]
Utah_Data_LONG_2023[, IEP_STATUS :=
    as.character(
        factor(IEP_STATUS,
               levels = 0:1,
               labels = c("IEP: No", "IEP: Yes")
        )
    )
]
Utah_Data_LONG_2023[, FRL_STATUS :=
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

##  Causing seg faults with v3 data... ???
# setattr(Utah_Data_LONG_2023$LAST_NAME, "levels",
#         sapply(levels(Utah_Data_LONG_2023$LAST_NAME),
#                capwords, USE.NAMES = FALSE)
# )
# setattr(Utah_Data_LONG_2023$FIRST_NAME, "levels",
#         sapply(levels(Utah_Data_LONG_2023$FIRST_NAME), capwords)
# )

Utah_Data_LONG_2023[, LAST_NAME := factor(LAST_NAME)]
levels(Utah_Data_LONG_2023$LAST_NAME) <-
    sapply(
        levels(Utah_Data_LONG_2023$LAST_NAME),
        capwords,
        USE.NAMES = FALSE
    )
Utah_Data_LONG_2023[, LAST_NAME := as.character(LAST_NAME)]

Utah_Data_LONG_2023[, FIRST_NAME := factor(FIRST_NAME)]
levels(Utah_Data_LONG_2023$FIRST_NAME) <-
    sapply(
        levels(Utah_Data_LONG_2023$FIRST_NAME),
        capwords,
        USE.NAMES = FALSE
    )
Utah_Data_LONG_2023[, FIRST_NAME := as.character(FIRST_NAME)]


###  Add in ENROLLMENT STATUS variables
Utah_Data_LONG_2023[, SCHOOL_ENROLLMENT_STATUS := "Enrolled School: Yes"]
Utah_Data_LONG_2023[, DISTRICT_ENROLLMENT_STATUS := "Enrolled District: Yes"]
Utah_Data_LONG_2023[, STATE_ENROLLMENT_STATUS := "Enrolled State: Yes"]

save(Utah_Data_LONG_2023, file = "Data/Utah_Data_LONG_2023.Rdata")


#' ## Data Preparation
#' 
#' The data preparation step involves taking data provided by the USBE and
#' producing a `.Rdata` file that will subsequently be analyzed using the `SGP`
#' software. This process is carried out annually as new data becomes available.
#' 
#' For the 2023 Utah RISE/UA+ data preparation and cleaning, we first modify
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
