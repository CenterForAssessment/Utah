################################################################################
####                                                                        ####
####        Code for cleaning and preparation of Utah 2021 LONG data        ####
####                                                                        ####
################################################################################

library(SGP)
library(data.table)

###   Read in USBE data files (tab delimited .txt converted directly from .xlsx)
Utah_Data_LONG_2021 <- fread("./Data/Base_Files/Long File with Enrollment Data v2.csv", colClasses=rep("character", 25), na.strings = "NULL") # Math and ELA (NO science)
Utah_Data_LONG_2021[, c("YEAR", "ID") := NULL] # duplicated variables (school_year, student_id)
setnames(Utah_Data_LONG_2021, "IsSpeciealEd", "IsSpecialEd")
setNamesSGP(Utah_Data_LONG_2021)

###   Fix leading 0s in GRADE
Utah_Data_LONG_2021[, GRADE := gsub("^0", "", GRADE)]


###   Invalidate duplicates with multiple scores
Utah_Data_LONG_2021[is.na(SCALE_SCORE), VALID_CASE := "INVALID_CASE"]
setkeyv(Utah_Data_LONG_2021, c("VALID_CASE", "YEAR", "ID", "CONTENT_AREA", "GRADE", "SCALE_SCORE"))
setkeyv(Utah_Data_LONG_2021, c("VALID_CASE", "YEAR", "ID", "CONTENT_AREA", "GRADE"))
sum(duplicated(Utah_Data_LONG_2021[VALID_CASE != "INVALID_CASE"], by=key(Utah_Data_LONG_2021))) # 20711 duplicates - (((take the record with the HIGHEST score)))
# dups <- data.table(Utah_Data_LONG_2021[unique(c(which(duplicated(Utah_Data_LONG_2021, by=key(Utah_Data_LONG_2021)))-1, which(duplicated(Utah_Data_LONG_2021, by=key(Utah_Data_LONG_2021))))), ], key=key(Utah_Data_LONG_2021))
Utah_Data_LONG_2021[which(duplicated(Utah_Data_LONG_2021, by=key(Utah_Data_LONG_2021)))-1, VALID_CASE:="INVALID_CASE"] # Some NA scores as well (move from INVALID_ to DUPLICATE_CASE)

setkeyv(Utah_Data_LONG_2021, c("VALID_CASE", "YEAR", "ID", "CONTENT_AREA", "SCALE_SCORE"))
setkeyv(Utah_Data_LONG_2021, c("VALID_CASE", "YEAR", "ID", "CONTENT_AREA"))
sum(duplicated(Utah_Data_LONG_2021[VALID_CASE != "INVALID_CASE"], by=key(Utah_Data_LONG_2021))) # 717 CROSS-GRADE duplicates - (((take the record with the HIGHEST score)))
# dups <- data.table(Utah_Data_LONG_2021[unique(c(which(duplicated(Utah_Data_LONG_2021, by=key(Utah_Data_LONG_2021)))-1, which(duplicated(Utah_Data_LONG_2021, by=key(Utah_Data_LONG_2021))))), ], key=key(Utah_Data_LONG_2021))
Utah_Data_LONG_2021[which(duplicated(Utah_Data_LONG_2021, by=key(Utah_Data_LONG_2021)))-1, VALID_CASE:="INVALID_CASE"] # Some NA scores as well (move from INVALID_ to DUPLICATE_CASE)


###
##  Tidy up data (Same steps for ELA/MATHEMATICS data as for SCIENCE)
###

###  Make the SCALE_SCORE variable numeric
Utah_Data_LONG_2021[, SCALE_SCORE := as.numeric(SCALE_SCORE)]

###   Transform ACHIEVEMENT_LEVEL VARIABLE to full and simplified versions
table(Utah_Data_LONG_2021[, ACHIEVEMENT_LEVEL, is.na(SCALE_SCORE)], exclude=NULL)
Utah_Data_LONG_2021[, ACHIEVEMENT_LEVEL := factor(ACHIEVEMENT_LEVEL, levels=0:4,
	labels=c(NA, "Below", "Approaching", "Proficient", "Highly"), ordered=TRUE)]

##    Invalidate mismatched Achievement Levels per Aaron B (10/1/19 email)
##    Only 2 cases (G9 ELA) - we only invalidated grades 3:8 previously, so continue with that.
# setnames(Utah_Data_LONG_2021, "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_FULL") # Preserve incorrect USBE/Questar Achievement Level var in "FULL" (Historical) variable
# Utah_Data_LONG_2021 <- SGP:::getAchievementLevel(Utah_Data_LONG_2021, state="UT")
# Utah_Data_LONG_2021[, ACHIEVEMENT_LEVEL := factor(ACHIEVEMENT_LEVEL, levels = c("Below", "Approaching", "Proficient", "Highly"), ordered=TRUE)]
# table(Utah_Data_LONG_2021[, VALID_CASE, ACHIEVEMENT_LEVEL_FULL], exclude=NULL)
# table(Utah_Data_LONG_2021[, ACHIEVEMENT_LEVEL, ACHIEVEMENT_LEVEL_FULL], exclude=NULL)
# table(Utah_Data_LONG_2021[as.character(ACHIEVEMENT_LEVEL) != as.character(ACHIEVEMENT_LEVEL_FULL), CONTENT_AREA, GRADE], exclude=NULL)
# Utah_Data_LONG_2021[!is.na(SCALE_SCORE), as.list(summary(SCALE_SCORE)), keyby=c("CONTENT_AREA", "GRADE", "ACHIEVEMENT_LEVEL")]

##   Reset the class of the ACHIEVEMENT_LEVEL variables to character
Utah_Data_LONG_2021[, ACHIEVEMENT_LEVEL := as.character(ACHIEVEMENT_LEVEL)]
# Utah_Data_LONG_2021[, ACHIEVEMENT_LEVEL_FULL := as.character(ACHIEVEMENT_LEVEL_FULL)]

###  Invalidate mismatched Achievement Levels per Aaron B (10/1/19 email)
##    Only 2 cases (G9 ELA) - we only invalidated grades 3:8 previously, so continue with that.
# Utah_Data_LONG_2021[GRADE %in% 3:8 & ACHIEVEMENT_LEVEL_FULL != ACHIEVEMENT_LEVEL, VALID_CASE := "INVALID_CASE"]
round(prop.table(table(Utah_Data_LONG_2021[, VALID_CASE, GRADE]), 1)*100, 2) # snapshot of grade-level participation rates

###   Tidy up Demographic Variables
table(Utah_Data_LONG_2021[, ETHNICITY])
Utah_Data_LONG_2021[, ETHNICITY := as.character(factor(ETHNICITY,
	labels = c("Asian", "AfAm/Black", "White", "Hispanic/Latino", "American Indian", "Multiple Races", "Pacific Islander")))]

# A = 'Asian'
# B = 'AfAm/Black'
# C = 'White'
# H = 'Hispanic/Latino'
# I = 'American Indian'
# M = 'Multiple Races'
# P = 'Pacific Islander'

Utah_Data_LONG_2021[, ELL_STATUS := as.character(factor(ELL_STATUS, levels = 0:1, labels = c("ELL: No", "ELL: Yes")))]
Utah_Data_LONG_2021[, IEP_STATUS := as.character(factor(IEP_STATUS, levels = 0:1, labels = c("IEP: No", "IEP: Yes")))]
Utah_Data_LONG_2021[, FRL_STATUS := as.character(factor(FRL_STATUS, levels = 0:1, labels = c("Free Reduced Lunch: No", "Free Reduced Lunch: Yes")))]


###  Ensure that all names are capitalized consistently (camel case)
###  Convert NAME variables to factor so that we can just work with the factor levels (much quicker!)

Utah_Data_LONG_2021[, LAST_NAME := factor(LAST_NAME)]
Utah_Data_LONG_2021[, FIRST_NAME := factor(FIRST_NAME)]
levels(Utah_Data_LONG_2021$LAST_NAME) <- sapply(levels(Utah_Data_LONG_2021$LAST_NAME), capwords)
levels(Utah_Data_LONG_2021$FIRST_NAME)<- sapply(levels(Utah_Data_LONG_2021$FIRST_NAME), capwords)

##   Reset the class of the NAME variables to character
Utah_Data_LONG_2021[, LAST_NAME := as.character(LAST_NAME)]
Utah_Data_LONG_2021[, FIRST_NAME := as.character(FIRST_NAME)]


###  Add in ENROLLMENT STATUS variables
Utah_Data_LONG_2021[, SCHOOL_ENROLLMENT_STATUS := 'Enrolled School: Yes']
Utah_Data_LONG_2021[, DISTRICT_ENROLLMENT_STATUS := 'Enrolled District: Yes']
Utah_Data_LONG_2021[, STATE_ENROLLMENT_STATUS := 'Enrolled State: Yes']

save(Utah_Data_LONG_2021, file="Data/Utah_Data_LONG_2021.Rdata")
