##########################################################
####
#### Code for preparation of Utah LONG data
####
##########################################################

library(data.table)

### Set working directory

### Read in USOE .csv file
Utah_Data_LONG_2014 <- fread("~/Dropbox/SGP/Utah/Data/Base_Files/SGP_Longfile_2.csv", colClasses=rep("character", 27))

### Final cleaning needed for File Randy uploaded 10/31/14

##  All 0s appear to be Algebra II scores of 0.  All are INVALID CASES too
Utah_Data_LONG_2014$ACHIEVEMENT_LEVEL <- factor(Utah_Data_LONG_2014$ACHIEVEMENT_LEVEL, levels=0:4, 
	labels=c(NA, "Level 1", "Level 2", "Level 3", "Level 4"), ordered=TRUE)

Utah_Data_LONG_2014$ACHIEVEMENT_LEVEL_FULL <- Utah_Data_LONG_2014$ACHIEVEMENT_LEVEL

levels(Utah_Data_LONG_2014$ACHIEVEMENT_LEVEL) <- c(NA, "BP", "BP", "P", "A")

table(Utah_Data_LONG_2014$ACHIEVEMENT_LEVEL, exclude=NULL)
table(Utah_Data_LONG_2014$ACHIEVEMENT_LEVEL_FULL, exclude=NULL)

Utah_Data_LONG_2014$GT_STATUS <- NA

###  Save data object.
save(Utah_Data_LONG_2014, file="Data/Utah_Data_LONG_2014.Rdata")


###  Clean up the Demographic variable lables in the 2013 SGP object:

##  ETHNICITY
#  Existing levels: "African American", "American Indian", "Asian", "Hispanic/Latino", "Multiple Races", "Pacific Islander", "Unknown", "White"
#  Provided levels: "American Indian", "Asian", "Black", "Hispanic", "More Than One Race", "Pacific Islander", "White" (No Unknown)

levels(Utah_SGP@Data$ETHNICITY) <- c("Black", "American Indian", "Asian", "Hispanic", "More Than One Race", "Pacific Islander", "Unknown", "White")

levels(Utah_SGP@Data$FRL_STATUS) <- c("Free Reduced Lunch: No", "Free Reduced Lunch: Yes")
levels(Utah_SGP@Data$IEP_STATUS) <- c("IEP: No", "IEP: Yes")
levels(Utah_SGP@Data$GT_STATUS) <- c("GT: No", "GT: Yes")


###  Save data object.
save(Utah_SGP, file="Data/Utah_SGP.Rdata")


