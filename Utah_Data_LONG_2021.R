################################################################################
####                                                                        ####
####        Code for cleaning and preparation of Utah 2021 LONG data        ####
####                                                                        ####
################################################################################

library(SGP)
library(data.table)

###   Read in USBE data files (tab delimited .txt converted directly from .xlsx)

Utah_Data_LONG_2021 <- fread("./Data/Base_Files/Long_File_2021v3.txt", colClasses=rep("character", 25), na.strings = "NULL") # Math and ELA (NO science)
Utah_Data_LONG_2021[, c("YEAR", "ID") := NULL] # duplicated variables (school_year, student_id)
setNamesSGP(Utah_Data_LONG_2021)

###   Invalidate duplicates with multiple scores
Utah_Data_LONG_2021[is.na(SCALE_SCORE), VALID_CASE := "INVALID_CASE"]
setkeyv(Utah_Data_LONG_2021, c("VALID_CASE", "YEAR", "ID", "CONTENT_AREA", "GRADE", "SCALE_SCORE"))
setkeyv(Utah_Data_LONG_2021, c("VALID_CASE", "YEAR", "ID", "CONTENT_AREA", "GRADE"))
sum(duplicated(Utah_Data_LONG_2021[VALID_CASE != "INVALID_CASE"], by=key(Utah_Data_LONG_2021))) # 13210 duplicates - (((take the record with the HIGHEST score)))
dups <- data.table(Utah_Data_LONG_2021[unique(c(which(duplicated(Utah_Data_LONG_2021, by=key(Utah_Data_LONG_2021)))-1, which(duplicated(Utah_Data_LONG_2021, by=key(Utah_Data_LONG_2021))))), ], key=key(Utah_Data_LONG_2021))

Utah_Data_LONG_2021[which(duplicated(Utah_Data_LONG_2021, by=key(Utah_Data_LONG_2021)))-1, VALID_CASE:="INVALID_CASE"] # Some NA scores as well (move from INVALID_ to DUPLICATE_CASE)



###
##  Tidy up data (Same steps for ELA/MATHEMATICS data as for SCIENCE)
###

###  Fix 9th grade values
Utah_Data_LONG_2021[GRADE=="09", GRADE := "9"]

###  Make the SCALE_SCORE variable numeric
Utah_Data_LONG_2021[, SCALE_SCORE := as.numeric(SCALE_SCORE)]

###   Transform ACHIEVEMENT_LEVEL VARIABLE to full and simplified versions
table(Utah_Data_LONG_2021[, ACHIEVEMENT_LEVEL, is.na(SCALE_SCORE)], exclude=NULL)
Utah_Data_LONG_2021[, ACHIEVEMENT_LEVEL := factor(ACHIEVEMENT_LEVEL, levels=0:4,
	labels=c(NA, "Below", "Approaching", "Proficient", "Highly"), ordered=TRUE)]

###   Check this again in 2021...
###  Invalidate mismatched Achievement Levels per Aaron B (10/1/19 email)

setnames(Utah_Data_LONG_2021, "ACHIEVEMENT_LEVEL", "ACHIEVEMENT_LEVEL_FULL") # Preserve incorrect USBE/Questar Achievement Level var in "FULL" (Historical) variable
Utah_Data_LONG_2021 <- SGP:::getAchievementLevel(Utah_Data_LONG_2021, state="UT")
# Utah_Data_LONG_2021[, ACHIEVEMENT_LEVEL := gsub(" Proficient", "", ACHIEVEMENT_LEVEL)]
Utah_Data_LONG_2021[, ACHIEVEMENT_LEVEL := factor(ACHIEVEMENT_LEVEL, levels = c("Below", "Approaching", "Proficient", "Highly"), ordered=TRUE)]

table(Utah_Data_LONG_2021[, ACHIEVEMENT_LEVEL, ACHIEVEMENT_LEVEL_FULL], exclude=NULL)
Utah_Data_LONG_2021[, as.list(summary(SCALE_SCORE)), keyby=c("CONTENT_AREA", "GRADE", "ACHIEVEMENT_LEVEL")]

##   Reset the class of the ACHIEVEMENT_LEVEL variables to character
Utah_Data_LONG_2021[, ACHIEVEMENT_LEVEL := as.character(ACHIEVEMENT_LEVEL)]
Utah_Data_LONG_2021[, ACHIEVEMENT_LEVEL_FULL := as.character(ACHIEVEMENT_LEVEL_FULL)]

###  Invalidate mismatched Achievement Levels per Aaron B (10/1/19 email)
Utah_Data_LONG_2021[GRADE %in% 3:8 & ACHIEVEMENT_LEVEL_FULL != ACHIEVEMENT_LEVEL, VALID_CASE := "INVALID_CASE"]
table(Utah_Data_LONG_2021[, VALID_CASE, GRADE])

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

# setnames(Utah_Data_LONG_2021, c("IsSpecialEd", "IsFRL", "IsELL"), c("IEP_STATUS", "FRL_STATUS", "ELL_STATUS"))
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

###  Check for duplicate cases  --  0 in 2021 RISE/Aspire Plus Data
# setkeyv(Utah_Data_LONG_2021, c(SGP:::getKey(Utah_Data_LONG_2021), "SCALE_SCORE"))
# setkeyv(Utah_Data_LONG_2021, SGP:::getKey(Utah_Data_LONG_2021))
# sum(duplicated(Utah_Data_LONG_2021[VALID_CASE != "INVALID_CASE"], by=key(Utah_Data_LONG_2021))) # 0 duplicates with valid GTIDs - (((take the highest score if any exist)))
# dups <- data.table(Utah_Data_LONG_2021[unique(c(which(duplicated(Utah_Data_LONG_2021, by=key(Utah_Data_LONG_2021)))-1, which(duplicated(Utah_Data_LONG_2021, by=key(Utah_Data_LONG_2021))))), ], key=key(Utah_Data_LONG_2021))
# Utah_Data_LONG_2021[which(duplicated(Utah_Data_LONG_2021, by=key(Utah_Data_LONG_2021)))-1, VALID_CASE := "INVALID_CASE"]

###   Save prepared data sets
Utah_Data_LONG_2021[, c("ID", "YEAR", "preferred_score", "MISSING") := NULL] # Remove redundant variables and preferred_score (all 1's and didn't save in SAGE)

#  Remove single SEC_MATH_I case
# Utah_Data_LONG_2021 <- Utah_Data_LONG_2021[CONTENT_AREA != "SEC_MATH_I"]

save(Utah_Data_LONG_2021, file="Data/Utah_Data_LONG_2021.Rdata")


#####
#####   Create a SAGE subset for RISE/Utah Aspire Plus analyses
#####

load("./Data/Archive/SAGE_Pre_2021/Utah_SGP_LONG_Data.Rdata")
load("./Data/Utah_Data_LONG_2021.Rdata")

Utah_Demographics <- fread("./Data/Base_Files/sage_demographics.csv", colClasses=rep("character", 17))
setnames(Utah_Demographics, toupper(names(Utah_Demographics)))
setnames(Utah_Demographics,
	c("SCHOOL_YEAR", "STUDENT_ID", "DISTRICT_ID", "RACE", "LOW_INCOME", "SPECIAL_ED"),
	c("YEAR", "ID", "DISTRICT_NUMBER", "ETHNICITY", "FRL_STATUS", "IEP_STATUS"))

setnames(Utah_Data_LONG_2021, SGPstateData[["UT"]][["Variable_Name_Lookup"]][["names.provided"]], SGPstateData[["UT"]][["Variable_Name_Lookup"]][["names.sgp"]])

demographics.to.merge <- names(Utah_Demographics)[c(4:8,12:17)]
vars.to.keep <- union(names(Utah_Data_LONG_2021), grep("SGP|SCALE_SCORE|CATCH_UP|MOVE_UP", names(Utah_SGP_LONG_Data), value=TRUE))
vars.to.keep <- setdiff(vars.to.keep, c(demographics.to.merge, "school_id"))

##   Add in Demographic Variables to 2015-2018 Data
Utah_LONG_Data_1518 <- copy(Utah_SGP_LONG_Data[YEAR %in% 2015:2018, vars.to.keep, with=FALSE])

##   Tidy up demographic variables to match 2021 Utah data / SGP conventions
Utah_Demographics[, ELL_STATUS := as.character(factor(ELL_STATUS, levels = 0:1, labels = c("ELL: No", "ELL: Yes")))]
Utah_Demographics[, IEP_STATUS := as.character(factor(IEP_STATUS, levels = 0:1, labels = c("IEP: No", "IEP: Yes")))]
Utah_Demographics[, FRL_STATUS := as.character(factor(FRL_STATUS, levels = 0:1, labels = c("Free Reduced Lunch: No", "Free Reduced Lunch: Yes")))]

Utah_SGP_LONG_Data[, ETHNICITY := as.character(factor(ETHNICITY,
	labels = c("American Indian", "Asian", "AfAm/Black", "Hispanic/Latino", "Multiple Races", "Pacific Islander", "Unknown", "White")))]

##   Merge demographic variables with 2015 - 2018 data
Utah_LONG_Data_1518[Utah_Demographics, on = .(YEAR, ID), c(demographics.to.merge) := mget(demographics.to.merge)]

#   Combine 2014 data (with existing demographic info) into data
Utah_LONG_Data <- rbindlist(list(Utah_SGP_LONG_Data[YEAR == 2014, names(Utah_LONG_Data_1518)[-c(33, 39)], with=FALSE], Utah_LONG_Data_1518), fill=TRUE) # 33, 39 = SCHOOL_ID, ETHNIC_HISPANIC

table(Utah_LONG_Data[, YEAR, is.na(GENDER)])
table(Utah_LONG_Data[YEAR==2018, is.na(SGP), is.na(FRL_STATUS)])

##   Reset the class of the ACHIEVEMENT_LEVEL variables to character
Utah_LONG_Data[, ACHIEVEMENT_LEVEL := as.character(ACHIEVEMENT_LEVEL)]
Utah_LONG_Data[, ACHIEVEMENT_LEVEL_FULL := as.character(ACHIEVEMENT_LEVEL_FULL)]

##   Set up CONTENT_AREA_ACTUAL for EOCT priors used in 2021
Utah_LONG_Data[, CONTENT_AREA_ACTUAL := CONTENT_AREA]
Utah_LONG_Data[CONTENT_AREA %in% c("SEC_MATH_I", "BIOLOGY", "EARTH_SCIENCE"), GRADE := "9"]
Utah_LONG_Data[CONTENT_AREA == "SEC_MATH_II", GRADE := "10"]
Utah_LONG_Data[CONTENT_AREA %in% c("SEC_MATH_I", "SEC_MATH_II"), CONTENT_AREA := "MATHEMATICS"]
Utah_LONG_Data[CONTENT_AREA %in% c("BIOLOGY", "EARTH_SCIENCE"), CONTENT_AREA := "SCIENCE"]

##   Remove priors from grade 11 and other EOCTs
Utah_LONG_Data <- Utah_LONG_Data[CONTENT_AREA %in% c("ELA", "MATHEMATICS", "SCIENCE") & GRADE %in% 3:10,]

setnames(Utah_LONG_Data, SGPstateData[["UT"]][["Variable_Name_Lookup"]][["names.sgp"]], SGPstateData[["UT"]][["Variable_Name_Lookup"]][["names.provided"]], skip_absent=TRUE)
setnames(Utah_LONG_Data, "SCHOOL_ID", "school_id")

##   Rename new prior data object and save
rm(Utah_SGP_LONG_Data)
assign("Utah_SGP_LONG_Data", Utah_LONG_Data)
save(Utah_SGP_LONG_Data, file="./Data/Utah_SGP_LONG_Data-SAGE_ONLY_with_Demographics.Rdata")
