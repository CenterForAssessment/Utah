#+ include = FALSE, purl = FALSE, eval = FALSE
###############################################################################
###                                                                         ###
###        Code for cleaning and preparation of Utah 2025 LONG data         ###
###                                                                         ###
###############################################################################

###   Load packages
require(data.table)
require(SGP)

###   Read in USBE data file - ELA, Math and Science
Utah_Data_LONG_2025 <-
    fread("./Data/Base_Files/Utah_Data_LONG_2025_AllSubjects.csv",
          colClasses = rep("character", 28),
          na.strings = "NULL"
    )

# setNamesSGP(Utah_Data_LONG_2025)

###   Use `TestGradeLevel` for GRADE  --  See below re: ach lev mismatches
# setnames(
#     Utah_Data_LONG_2025,
#     c("GRADE", "TestGradeLevel"),
#     c("GradeEnrolled", "GRADE")
# )
# Utah_Data_LONG_2025[CONTENT_AREA == "SEC_MATH_I", GRADE := "EOCT"]


###   Make the SCALE_SCORE variable numeric and invalidate missing scores
#     table(Utah_Data_LONG_2025[, .(VALID_CASE, GRADE), CONTENT_AREA])
#     Utah_Data_LONG_2025[, as.list(summary(SCALE_SCORE)), keyby = .(CONTENT_AREA, GRADE)]

Utah_Data_LONG_2025[,
    SCALE_SCORE := as.numeric(SCALE_SCORE)
][ SCALE_SCORE == 0, SCALE_SCORE := NA
][is.na(SCALE_SCORE), VALID_CASE := "INVALID_CASE"
]
# Utah_Data_LONG_2025[!is.na(SCALE_SCORE) & ACHIEVEMENT_LEVEL == "NA",]

###   Invalidate duplicates with multiple scores
# sgp.key <- c("VALID_CASE", "YEAR", "ID", "CONTENT_AREA")
# setkeyv(Utah_Data_LONG_2025, c(sgp.key, "GRADE", "SCALE_SCORE"))
# setkeyv(Utah_Data_LONG_2025, c(sgp.key, "GRADE"))
# dupl <-
#     duplicated(Utah_Data_LONG_2025, by = key(Utah_Data_LONG_2025))
# sum(dupl) # 5,533 WITHIN-GRADE duplicates - (take the record with the HIGHEST score)
# dups <- Utah_Data_LONG_2025[c(which(dupl), which(dupl) - 1),]
# setkeyv(dups, sgp.key) # All cases are already INVALID
# Utah_Data_LONG_2025[which(dupl) - 1, VALID_CASE := "INVALID_CASE"]

##    No need to INVALIDATE these kids - it will be sorted out through configs.
##    Good thing to check annually anyway.
# setkeyv(Utah_Data_LONG_2025, c(sgp.key, "SCALE_SCORE"))
# setkeyv(Utah_Data_LONG_2025, sgp.key)
# dupl <-
#     duplicated(Utah_Data_LONG_2025, by = key(Utah_Data_LONG_2025))
# sum(dupl) # 6681 CROSS-GRADE duplicates in v2
# #   1,138 VALID_CASES in '25

#    Invalidate out of grade records (0 in '25)
# Utah_Data_LONG_2025[
#     CONTENT_AREA == "SCIENCE" & GRADE == "3",
#     VALID_CASE := "INVALID_CASE"
# ]

###
##  Tidy up data
###

###   Transform ACHIEVEMENT_LEVEL VARIABLE to full and simplified versions
table(Utah_Data_LONG_2025[,
          .(ACHIEVEMENT_LEVEL, VALID_CASE),
          is.na(SCALE_SCORE)
      ],
      exclude = NULL
)

###   Invalidate mismatched Achievement Levels per Aaron B (10/1/19 email).
##
##    MANY mismatches in original 2025 again. This time due to students'
##    GRADE (enrollment) not matching the test administered.  DMackay provided
##    `TestGradeLevel` to correct. One (1) Grade 10 ELA case found in 2025.
##    Preserve incorrect USBE/Questar achievement level (Historical) variable.
##    KEEP and check EACH year for achievement level mismatches !!!

# setnames(Utah_Data_LONG_2025, "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_ORIGINAL")
# Utah_Data_LONG_2025 <-
#     SGP:::getAchievementLevel(Utah_Data_LONG_2025, state = "UT")
# Utah_Data_LONG_2025[, ACHIEVEMENT_LEVEL :=
#     factor(ACHIEVEMENT_LEVEL, ordered = TRUE,
#            levels = c("Below", "Approaching", "Proficient", "Highly")
#     ) |> as.character()
# ]

# ##    Investigate ACHIEVEMENT_LEVEL mismatches
# table(Utah_Data_LONG_2025[, VALID_CASE, ACHIEVEMENT_LEVEL_ORIGINAL], exclude = NULL)
# table(Utah_Data_LONG_2025[, ACHIEVEMENT_LEVEL, ACHIEVEMENT_LEVEL_ORIGINAL],
#       exclude = NULL)
# table(Utah_Data_LONG_2025[
#         ACHIEVEMENT_LEVEL_ORIGINAL != ACHIEVEMENT_LEVEL &
#         VALID_CASE == "VALID_CASE",
#         .(ACHIEVEMENT_LEVEL, CONTENT_AREA), GRADE],
#       exclude = NULL)
# Utah_Data_LONG_2025[
#     !is.na(SCALE_SCORE) &
#     ACHIEVEMENT_LEVEL != ACHIEVEMENT_LEVEL_ORIGINAL,
#       as.list(summary(SCALE_SCORE)),
#     keyby =
#       c("CONTENT_AREA", "GRADE", "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_ORIGINAL")
# ]

# ###   Invalidate ACHIEVEMENT_LEVEL mismatches
# ##    We previously only invalidated grades 3:8. Continued in 2025 (FIXED in v2 data).
# # Utah_Data_LONG_2025[
# #     GRADE %in% 3:8 &
# #     ACHIEVEMENT_LEVEL_ORIGINAL != ACHIEVEMENT_LEVEL,
# #         VALID_CASE := "INVALID_CASE"
# # ]

# # ##    Preserve incorrect USBE/Questar achievement level (Historical) variable.
# Utah_Data_LONG_2025[, ACHIEVEMENT_LEVEL := NULL]
# setnames(Utah_Data_LONG_2025, "ACHIEVEMENT_LEVEL_ORIGINAL", "ACHIEVEMENT_LEVEL")


##    Snapshot of grade-level participation rates
Utah_Data_LONG_2025[, VALID_CASE, GRADE] |> # .(VALID_CASE, CONTENT_AREA)
    table() |> prop.table(1) |>
         round(5) * 100


###   Tidy up Demographic Variables
###   Camel Case Student NAMES
###   Add in ENROLLMENT STATUS variables
##
##     ALL Done by David M in 2025


save(Utah_Data_LONG_2025, file = "Data/Utah_Data_LONG_2025.Rdata")


#' ## Data Preparation
#' 
#' The data preparation step involves taking data provided by the USBE and
#' producing a `.Rdata` file that will subsequently be analyzed using the `SGP`
#' software. This process is carried out annually as new data becomes available.
#' 
#' For the 2025 Utah RISE/UA+ data preparation and cleaning, we first modify
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
#'   scale score is retained for the SGP analyses.
#' * Student records with grade levels matching un-tested grades were
#'   invalidated. No such students were found in the final data provided to
#'   The Center.
