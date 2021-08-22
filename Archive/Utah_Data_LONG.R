##########################################################
####
#### Code for preparation of Utah LONG data
####
##########################################################

library(SGP)
library(data.table)

### Set working directory

### Read in USOE .Rdata file
load("Utah_Data_LONG.Rdata")

### Final cleaning needed for File Andrew uploaded 7/31/13

## Convert ALL 8th grade math to Pre-Algebra
Utah_Data_LONG <- data.table(Utah_Data_LONG)
Utah_Data_LONG[which(CONTENT_AREA == 'MATHEMATICS' & GRADE == 8), GRADE := 'EOCT']
Utah_Data_LONG[which(CONTENT_AREA == 'MATHEMATICS' & GRADE == 'EOCT'), CONTENT_AREA := 'PRE_ALGEBRA']
table(Utah_Data_LONG$GRADE, Utah_Data_LONG$CONTENT_AREA, Utah_Data_LONG$YEAR, Utah_Data_LONG$VALID_CASE)

##  All 0s appear to be Algebra II scores of 0.  All are INVALID CASES too
Utah_Data_LONG$ACHIEVEMENT_LEVEL <- factor(Utah_Data_LONG$ACHIEVEMENT_LEVEL, levels=0:4, 
	labels=c(NA, "Level 1", "Level 2", "Level 3", "Level 4"), ordered=TRUE)

Utah_Data_LONG$ACHIEVEMENT_LEVEL_FULL <- Utah_Data_LONG$ACHIEVEMENT_LEVEL

levels(Utah_Data_LONG$ACHIEVEMENT_LEVEL) <- c(NA, "BP", "BP", "P", "A")

table(Utah_Data_LONG$ACHIEVEMENT_LEVEL, exclude=NULL)
table(Utah_Data_LONG$ACHIEVEMENT_LEVEL_FULL, exclude=NULL)

###  Clean up the ETHNICITY Lables
levels(Utah_Data_LONG$ETHNICITY) <- c("African American", "African American", "American Indian", "Asian", "White", "Hispanic/Latino", "Hispanic/Latino", "Multiple Races", "Pacific Islander", "Unknown", "White")

###  Save data object.
save(Utah_Data_LONG, file="Utah_Data_LONG-2013_FINAL.Rdata")
