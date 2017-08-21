##########################################################
####
#### Code for cleaning and preparation of Utah LONG data
####
##########################################################

library(SGP)
library(data.table)

### Set working directory

### Read in USOE .csv file
##  NOTE:  The text "ASCENT, INC.," had to be changed to "ASCENT INC." (remove commas - caused problems with the .CSV format)

Utah_Data_LONG_2017 <- fread("Data/Base_Files/SGP Longfile 2017 (20170818).csv", colClasses=rep("character", 18))
Utah_Data_LONG_2017_NAMES <- fread("Data/Base_Files/SGP Longfile 2017 Header.csv", colClasses=rep("character", 18))

setnames(Utah_Data_LONG_2017, names(Utah_Data_LONG_2017_NAMES))

Utah_Data_LONG_2017[, SCHOOL_ENROLLMENT_STATUS := 'Enrolled School: Yes']
Utah_Data_LONG_2017[, DISTRICT_ENROLLMENT_STATUS := 'Enrolled District: Yes']
Utah_Data_LONG_2017[, STATE_ENROLLMENT_STATUS := 'Enrolled State: Yes']

### Final cleaning needed for File Randy uploaded

# TRANSFORM PROFICIENCY LEVEL VARIABLES TO R FACTORS
Utah_Data_LONG_2017$ACHIEVEMENT_LEVEL <- factor(Utah_Data_LONG_2017$ACHIEVEMENT_LEVEL, levels=1:4,
	labels=c("Level 1", "Level 2", "Level 3", "Level 4"), ordered=TRUE)

Utah_Data_LONG_2017[, ACHIEVEMENT_LEVEL_FULL := as.character(ACHIEVEMENT_LEVEL)]

levels(Utah_Data_LONG_2017$ACHIEVEMENT_LEVEL) <- c("BP", "BP", "P", "A")
Utah_Data_LONG_2017[, ACHIEVEMENT_LEVEL := as.character(ACHIEVEMENT_LEVEL)]

Utah_Data_LONG_2017[, IDMismatch := NULL]
Utah_Data_LONG_2017[, preferred_score := NULL]

###  Check for duplicate cases
# setkeyv(Utah_Data_LONG_2017, c(SGP:::getKey(Utah_Data_LONG_2017), "SCALE_SCORE"))
# setkeyv(Utah_Data_LONG_2017, SGP:::getKey(Utah_Data_LONG_2017))
# sum(duplicated(Utah_Data_LONG_2017[VALID_CASE != "INVALID_CASE"], by=key(Utah_Data_LONG_2017))) # 0 duplicates with valid GTIDs - (((take the highest score if any exist)))
# dups <- data.table(Utah_Data_LONG_2017[unique(c(which(duplicated(Utah_Data_LONG_2017, by=key(Utah_Data_LONG_2017)))-1, which(duplicated(Utah_Data_LONG_2017, by=key(Utah_Data_LONG_2017))))), ], key=key(Utah_Data_LONG_2017))
# Utah_Data_LONG_2017[which(duplicated(Utah_Data_LONG_2017, by=key(Utah_Data_LONG_2017)))-1, VALID_CASE := "INVALID_CASE"]

save(Utah_Data_LONG_2017, file="Data/Utah_Data_LONG_2017.Rdata")
