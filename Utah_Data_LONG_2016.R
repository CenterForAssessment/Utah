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

Utah_Data_LONG_2016 <- fread("Data/Base_Files/Utah_SGP_Long_Data_2016.csv", colClasses=rep("character", 22))
Utah_Data_LONG_2016_NAMES <- fread("Data/Base_Files/Utah_SGP_Long_Data_2016_ColumnHeadings.csv", colClasses=rep("character", 22))

setnames(Utah_Data_LONG_2016, names(Utah_Data_LONG_2016_NAMES))

Utah_Data_LONG_2016[, SCHOOL_ENROLLMENT_STATUS := 'Enrolled School: Yes']
Utah_Data_LONG_2016[, DISTRICT_ENROLLMENT_STATUS := 'Enrolled District: Yes']
Utah_Data_LONG_2016[, STATE_ENROLLMENT_STATUS := 'Enrolled State: Yes']

### Final cleaning needed for File Randy uploaded

# TRANSFORM PROFICIENCY LEVEL VARIABLES TO R FACTORS
Utah_Data_LONG_2016$ACHIEVEMENT_LEVEL <- factor(Utah_Data_LONG_2016$ACHIEVEMENT_LEVEL, levels=0:4, 
	labels=c(NA, "Level 1", "Level 2", "Level 3", "Level 4"), ordered=TRUE)

Utah_Data_LONG_2016$ACHIEVEMENT_LEVEL_FULL <- Utah_Data_LONG_2016$ACHIEVEMENT_LEVEL

levels(Utah_Data_LONG_2016$ACHIEVEMENT_LEVEL) <- c(NA, "BP", "BP", "P", "A")

# table(Utah_Data_LONG_2016$ACHIEVEMENT_LEVEL, exclude=NULL)
# table(Utah_Data_LONG_2016$ACHIEVEMENT_LEVEL_FULL, exclude=NULL)

save(Utah_Data_LONG_2016, file="Data/Utah_Data_LONG_2016.Rdata")

