#+ include = FALSE, purl = FALSE, eval = FALSE
###############################################################################
###                                                                         ###
###        Code for cleaning and preparation of Utah 2022 LONG data         ###
###                                                                         ###
###############################################################################

library(SGP)
library(data.table)

###   Read in USBE data file - ELA, Math and Science
Utah_Data_LONG_2022 <-
    fread("./Data/Base_Files/Long File with Enrollment Data 2022 v3.csv",
          colClasses = rep("character", 25),
          na.strings = "NULL"
    )
Utah_Data_LONG_2022[, c("YEAR", "ID") := NULL] # school_year, student_id duplicates
setNamesSGP(Utah_Data_LONG_2022)

###   Fix leading 0s in GRADE
# Utah_Data_LONG_2022[, GRADE := gsub("^0", "", GRADE)]

###   Invalidate duplicates with multiple scores
Utah_Data_LONG_2022[is.na(SCALE_SCORE), VALID_CASE := "INVALID_CASE"]
# setkeyv(Utah_Data_LONG_2022,
#         c("VALID_CASE", "YEAR", "ID", "CONTENT_AREA", "GRADE", "SCALE_SCORE"))
# setkeyv(Utah_Data_LONG_2022,
#         c("VALID_CASE", "YEAR", "ID", "CONTENT_AREA", "GRADE"))
# sum(duplicated(Utah_Data_LONG_2022[VALID_CASE != "INVALID_CASE"],
#                by = key(Utah_Data_LONG_2022))) # 0 in 2022

setkeyv(Utah_Data_LONG_2022,
        c("VALID_CASE", "YEAR", "ID", "CONTENT_AREA", "SCALE_SCORE")
)
setkeyv(Utah_Data_LONG_2022,
        c("VALID_CASE", "YEAR", "ID", "CONTENT_AREA")
)
dupl <- duplicated(Utah_Data_LONG_2022[VALID_CASE != "INVALID_CASE"],
                   by = key(Utah_Data_LONG_2022)
        )
# sum(dupl) # 895 CROSS-GRADE duplicates - (((take the record with the HIGHEST score)))
# dups <-
#     data.table(Utah_Data_LONG_2022[unique(c(which(dupl) - 1, which(dupl))), ],
#                key = key(Utah_Data_LONG_2022))
Utah_Data_LONG_2022[which(dupl) - 1, VALID_CASE := "INVALID_CASE"]


###
##  Tidy up data
###

###  Make the SCALE_SCORE variable numeric
Utah_Data_LONG_2022[, SCALE_SCORE := as.numeric(SCALE_SCORE)]

###   Transform ACHIEVEMENT_LEVEL VARIABLE to full and simplified versions
table(Utah_Data_LONG_2022[,
          ACHIEVEMENT_LEVEL,
          is.na(SCALE_SCORE)
      ],
      exclude = NULL
)
Utah_Data_LONG_2022[, ACHIEVEMENT_LEVEL :=
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
setnames(Utah_Data_LONG_2022, "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_FULL")
Utah_Data_LONG_2022 <-
    SGP:::getAchievementLevel(Utah_Data_LONG_2022, state = "UT")
Utah_Data_LONG_2022[, ACHIEVEMENT_LEVEL :=
    factor(ACHIEVEMENT_LEVEL, ordered = TRUE,
           levels = c("Below", "Approaching", "Proficient", "Highly")
    )
]

##   Reset the class of the ACHIEVEMENT_LEVEL variables to character
Utah_Data_LONG_2022[, ACHIEVEMENT_LEVEL :=
                        as.character(ACHIEVEMENT_LEVEL)
]
Utah_Data_LONG_2022[, ACHIEVEMENT_LEVEL_FULL :=
                        as.character(ACHIEVEMENT_LEVEL_FULL)
]
# table(Utah_Data_LONG_2022[, VALID_CASE, ACHIEVEMENT_LEVEL_FULL])
# table(Utah_Data_LONG_2022[, ACHIEVEMENT_LEVEL, ACHIEVEMENT_LEVEL_FULL],
#       exclude = NULL)
# table(Utah_Data_LONG_2022[ACHIEVEMENT_LEVEL_FULL != ACHIEVEMENT_LEVEL,
#                           CONTENT_AREA, GRADE], exclude = NULL)
# #   All ACHIEVEMENT_LEVEL mismatches are INVALID_CASEs
# Utah_Data_LONG_2022[!is.na(SCALE_SCORE) &
#                     is.na(ACHIEVEMENT_LEVEL) &
#                     !is.na(ACHIEVEMENT_LEVEL_FULL),
#                         as.list(summary(SCALE_SCORE)),
#                     keyby = c("CONTENT_AREA", "GRADE", "VALID_CASE")]
##    We only invalidated grades 3:8 previously, so continue with that.
# Utah_Data_LONG_2022[GRADE %in% 3:8 & ACHIEVEMENT_LEVEL_FULL != ACHIEVEMENT_LEVEL,
#                         VALID_CASE := "INVALID_CASE"]
Utah_Data_LONG_2022[, ACHIEVEMENT_LEVEL := NULL]
setnames(Utah_Data_LONG_2022, "ACHIEVEMENT_LEVEL_FULL", "ACHIEVEMENT_LEVEL")

##    Snapshot of grade-level participation rates
# Utah_Data_LONG_2022[, VALID_CASE, GRADE] |> # .(VALID_CASE, CONTENT_AREA)
#     table() |> prop.table(1) |>
#         (\(.) {. * 100})() |> round(2)


###   Tidy up Demographic Variables
table(Utah_Data_LONG_2022[, ETHNICITY], exclude = NULL)
Utah_Data_LONG_2022[, ETHNICITY :=
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

Utah_Data_LONG_2022[, ELL_STATUS :=
    as.character(
        factor(ELL_STATUS,
               levels = 0:1,
               labels = c("ELL: No", "ELL: Yes")
        )
    )
]
Utah_Data_LONG_2022[, IEP_STATUS :=
    as.character(
        factor(IEP_STATUS,
               levels = 0:1,
               labels = c("IEP: No", "IEP: Yes")
        )
    )
]
Utah_Data_LONG_2022[, FRL_STATUS :=
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
# setattr(Utah_Data_LONG_2022$LAST_NAME, "levels",
#         sapply(levels(Utah_Data_LONG_2022$LAST_NAME),
#                capwords, USE.NAMES = FALSE)
# )
# setattr(Utah_Data_LONG_2022$FIRST_NAME, "levels",
#         sapply(levels(Utah_Data_LONG_2022$FIRST_NAME), capwords)
# )

Utah_Data_LONG_2022[, LAST_NAME := factor(LAST_NAME)]
levels(Utah_Data_LONG_2022$LAST_NAME) <-
    sapply(
        levels(Utah_Data_LONG_2022$LAST_NAME),
        capwords,
        USE.NAMES = FALSE
    )
Utah_Data_LONG_2022[, LAST_NAME := as.character(LAST_NAME)]

Utah_Data_LONG_2022[, FIRST_NAME := factor(FIRST_NAME)]
levels(Utah_Data_LONG_2022$FIRST_NAME) <-
    sapply(
        levels(Utah_Data_LONG_2022$FIRST_NAME),
        capwords,
        USE.NAMES = FALSE
    )
Utah_Data_LONG_2022[, FIRST_NAME := as.character(FIRST_NAME)]


###  Add in ENROLLMENT STATUS variables
Utah_Data_LONG_2022[, SCHOOL_ENROLLMENT_STATUS := "Enrolled School: Yes"]
Utah_Data_LONG_2022[, DISTRICT_ENROLLMENT_STATUS := "Enrolled District: Yes"]
Utah_Data_LONG_2022[, STATE_ENROLLMENT_STATUS := "Enrolled State: Yes"]

save(Utah_Data_LONG_2022, file = "Data/Utah_Data_LONG_2022.Rdata")


#####
###   New Knots and Bounds for Science Scale Change (in 2021)
#####

load("Data/Utah_Data_LONG_2021.Rdata")
req.vars <- c(SGP:::getKey(Utah_Data_LONG_2022), "SCALE_SCORE")

Utah_KB_Data <-
    rbindlist(
        list(
            Utah_Data_LONG_2021[
                VALID_CASE == "VALID_CASE" &
                CONTENT_AREA == "SCIENCE" &
                GRADE %in% c(4, 5),
                  ..req.vars
            ],
            Utah_Data_LONG_2022[
                VALID_CASE == "VALID_CASE" &
                CONTENT_AREA == "SCIENCE" &
                GRADE %in% c(4, 5),
                  ..req.vars
            ]
        )
    )

el.kbs <- createKnotsBoundaries(Utah_KB_Data)[["SCIENCE"]]

mh.kbs <-
    SGPstateData[["UT"]][["Achievement"]][["Knots_Boundaries"]][["SCIENCE"]]
mh.kbs <- mh.kbs[grep("_6|_7|_8|_9|_10", names(mh.kbs))]

# allow sort by numeric component
nmb <- gsub("[^0-9]", "", names(mh.kbs)) # remove everything except 0-9
nmb <- as.numeric(nmb)

UT_Science_Knots_Bounds_2021 <-
    list(
        SCIENCE.2021 = c(el.kbs, mh.kbs[order(nmb)])
    )

###   Save updated knots and bounds (move to SGPstateData repo for SGP package)
save(UT_Science_Knots_Bounds_2021,
     file = "Data/UT_Science_Knots_Bounds_2021.rda")


#' ## Data Preparation
#' 
#' The data preparation step involves taking data provided by the USBE and
#' producing a `.Rdata` file that will subsequently be analyzed using the `SGP`
#' software. This process is carried out annually as new data becomes available.
#' 
#' For the 2022 Utah RISE/UA+ data preparation and cleaning, we first modify
#' values of student demographic and achievement level variables to match with
#' values and factor levels that have been used in previous years or as
#' required to conform to the `SGP` package conventions.
#' 
#' The data was also examined to identify invalid records. 
#' Student records were flagged as "invalid" based on the following criteria:
#'
#' * Student records with a reported `ACHIEVEMENT_LEVEL` value outside of the
#'   corresponding scale score range. This issue has been present in previous
#'   years, but did not impact any student records in 2022.
#' * Students with duplicate records. In these instances, a student's highest
#'   scale score is retained as the "valid" case for the SGP analyses.