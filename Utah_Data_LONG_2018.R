##########################################################
####
#### Code for cleaning and preparation of Utah LONG data
####
##########################################################

library(SGP)
library(data.table)

### Set working directory

### Read in USOE .csv file

Utah_Data_LONG_2018 <- fread("Data/Base_Files/SGP Longfile 2018 v20180809.csv", colClasses=rep("character", 15))
# Utah_Data_LONG_2018 <- fread("Data/Base_Files/SGP Longfile 2018 v20181020.csv", colClasses=rep("character", 15)) # Load SCIENCE data sent seperately (October?)

###
##  Tidy up data (Same steps for ELA/MATHEMATICS data as for SCIENCE)
###

###  Add in ENROLLMENT STATUS variables
Utah_Data_LONG_2018[, SCHOOL_ENROLLMENT_STATUS := 'Enrolled School: Yes']
Utah_Data_LONG_2018[, DISTRICT_ENROLLMENT_STATUS := 'Enrolled District: Yes']
Utah_Data_LONG_2018[, STATE_ENROLLMENT_STATUS := 'Enrolled State: Yes']

###   Transform ACHIEVEMENT_LEVEL VARIABLE to full and simplified versions
Utah_Data_LONG_2018$ACHIEVEMENT_LEVEL <- factor(Utah_Data_LONG_2018$ACHIEVEMENT_LEVEL, levels=1:4,
	labels=c("Level 1", "Level 2", "Level 3", "Level 4"), ordered=TRUE)

Utah_Data_LONG_2018[, ACHIEVEMENT_LEVEL_FULL := as.character(ACHIEVEMENT_LEVEL)]

levels(Utah_Data_LONG_2018$ACHIEVEMENT_LEVEL) <- c("BP", "BP", "P", "A")
Utah_Data_LONG_2018[, ACHIEVEMENT_LEVEL := as.character(ACHIEVEMENT_LEVEL)]

###  Make the SCALE_SCORE variable numeric
Utah_Data_LONG_2018[, SCALE_SCORE := as.numeric(SCALE_SCORE)]


###  Ensure that all names are capitalized consistently (camel case)
###  Convert NAME variables to factor so that we can just work with the factor levels (much quicker!)

Utah_Data_LONG_2018[, LAST_NAME := factor(LAST_NAME)]
Utah_Data_LONG_2018[, FIRST_NAME := factor(FIRST_NAME)]

levels(Utah_Data_LONG_2018$LAST_NAME) <- sapply(levels(Utah_Data_LONG_2018$LAST_NAME), capwords)
levels(Utah_Data_LONG_2018$FIRST_NAME) <-sapply(levels(Utah_Data_LONG_2018$FIRST_NAME), capwords)

##   Reset the class of the NAME variables to character
Utah_Data_LONG_2018[, LAST_NAME := as.character(LAST_NAME)]
Utah_Data_LONG_2018[, FIRST_NAME := as.character(FIRST_NAME)]


###  Check for duplicate cases
# setkeyv(Utah_Data_LONG_2018, c(SGP:::getKey(Utah_Data_LONG_2018), "SCALE_SCORE"))
# setkeyv(Utah_Data_LONG_2018, SGP:::getKey(Utah_Data_LONG_2018))
# sum(duplicated(Utah_Data_LONG_2018[VALID_CASE != "INVALID_CASE"], by=key(Utah_Data_LONG_2018))) # 0 duplicates with valid GTIDs - (((take the highest score if any exist)))
# dups <- data.table(Utah_Data_LONG_2018[unique(c(which(duplicated(Utah_Data_LONG_2018, by=key(Utah_Data_LONG_2018)))-1, which(duplicated(Utah_Data_LONG_2018, by=key(Utah_Data_LONG_2018))))), ], key=key(Utah_Data_LONG_2018))
# Utah_Data_LONG_2018[which(duplicated(Utah_Data_LONG_2018, by=key(Utah_Data_LONG_2018)))-1, VALID_CASE := "INVALID_CASE"]

###   Save prepared data sets
#  ELA/MATHEMATICS Data
save(Utah_Data_LONG_2018, file="Data/Utah_Data_LONG_2018.Rdata")

#  SCIENCE Data
save(Utah_Data_LONG_2018, file="Data/Utah_Data_LONG_SCIENCE_2018.Rdata")
