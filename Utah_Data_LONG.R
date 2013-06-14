##########################################################
####
#### Code for preparation of Utah LONG data
####
##########################################################

library(SGP)
require(car)

library(foreign)

# Set working directory
setwd("C:/Utah_SGP_100512/Data")

### Read in SPSS file (or load already save Utah_Data_LONG)
Utah_Data_LONG <- read.spss("C:/Utah_SGP_100512/Data/Utah_Data_LONG.sav", to.data.frame = TRUE, use.value.labels = TRUE)

gc()

Utah_Data_LONG=data.frame(Utah_Data_LONG)

#Trim white space

trimWhiteSpace <- function(line) gsub("(^ +)|( +$)", "", line)

Utah_Data_LONG[['FIRST_NAME']]<- trimWhiteSpace(Utah_Data_LONG[['FIRST_NAME']])
Utah_Data_LONG[['LAST_NAME']] <- trimWhiteSpace(Utah_Data_LONG[['LAST_NAME']])
Utah_Data_LONG[['VALID_CASE']] <- trimWhiteSpace(Utah_Data_LONG[['VALID_CASE']])
Utah_Data_LONG[['ACHIEVEMENT_LEVEL']] <- trimWhiteSpace(Utah_Data_LONG[['ACHIEVEMENT_LEVEL']])
Utah_Data_LONG[['YEAR']] <- trimWhiteSpace(Utah_Data_LONG[['YEAR']])
Utah_Data_LONG[['ID']] <- trimWhiteSpace(Utah_Data_LONG[['ID']])
Utah_Data_LONG[['SCHOOL_NUMBER']] <- trimWhiteSpace(Utah_Data_LONG[['SCHOOL_NUMBER']])
Utah_Data_LONG[['SCALE_SCORE']] <- trimWhiteSpace(Utah_Data_LONG[['SCALE_SCORE']])
Utah_Data_LONG[['CONTENT_AREA']] <- trimWhiteSpace(Utah_Data_LONG[['CONTENT_AREA']])
Utah_Data_LONG[['SCHOOL_NAME']] <- trimWhiteSpace(Utah_Data_LONG[['SCHOOL_NAME']])
Utah_Data_LONG[['DISTRICT_NAME']] <- trimWhiteSpace(Utah_Data_LONG[['DISTRICT_NAME']])
Utah_Data_LONG[['DISTRICT_NUMBER']] <- trimWhiteSpace(Utah_Data_LONG[['DISTRICT_NUMBER']])
Utah_Data_LONG[['EMH_LEVEL']] <- trimWhiteSpace(Utah_Data_LONG[['EMH_LEVEL']])
Utah_Data_LONG[['DISTRICT_ENROLLMENT_STATUS']] <- trimWhiteSpace(Utah_Data_LONG[['DISTRICT_ENROLLMENT_STATUS']])
Utah_Data_LONG[['SCHOOL_ENROLLMENT_STATUS']] <- trimWhiteSpace(Utah_Data_LONG[['SCHOOL_ENROLLMENT_STATUS']])
Utah_Data_LONG[['STATE_ENROLLMENT_STATUS']] <- trimWhiteSpace(Utah_Data_LONG[['STATE_ENROLLMENT_STATUS']])
Utah_Data_LONG[['SUBGROUP']] <- trimWhiteSpace(Utah_Data_LONG[['SUBGROUP']])
Utah_Data_LONG[['TEST_NAME']] <- trimWhiteSpace(Utah_Data_LONG[['TEST_NAME']])
Utah_Data_LONG[['GENDER']] <- trimWhiteSpace(Utah_Data_LONG[['GENDER']])
Utah_Data_LONG[['SUBGROUP']] <- trimWhiteSpace(Utah_Data_LONG[['SUBGROUP']])
Utah_Data_LONG[['ETHNICITY']] <- trimWhiteSpace(Utah_Data_LONG[['ETHNICITY']])
Utah_Data_LONG[['FRL_STATUS']] <- trimWhiteSpace(Utah_Data_LONG[['FRL_STATUS']])
Utah_Data_LONG[['IEP_STATUS']] <- trimWhiteSpace(Utah_Data_LONG[['IEP_STATUS']])
Utah_Data_LONG[['ELL_STATUS']] <- trimWhiteSpace(Utah_Data_LONG[['ELL_STATUS']])
Utah_Data_LONG[['GT_STATUS']] <- trimWhiteSpace(Utah_Data_LONG[['GT_STATUS']])
Utah_Data_LONG[['TEST_MEDIUM']] <- trimWhiteSpace(Utah_Data_LONG[['TEST_MEDIUM']])

### Clean up the longfile - Specify classes

Utah_Data_LONG$ID <-as.integer(Utah_Data_LONG$ID)

Utah_Data_LONG$GRADE <- as.integer(Utah_Data_LONG$GRADE)

Utah_Data_LONG$SCHOOL_NUMBER <- as.integer(Utah_Data_LONG$SCHOOL_NUMBER)

Utah_Data_LONG$DISTRICT_NUMBER <- as.integer(Utah_Data_LONG$DISTRICT_NUMBER)

Utah_Data_LONG$SCALE_SCORE <- as.integer(Utah_Data_LONG$SCALE_SCORE)

Utah_Data_LONG$VALID_CASE <- factor(Utah_Data_LONG$VALID_CASE)

Utah_Data_LONG$YEAR <- as.integer(Utah_Data_LONG$YEAR)

Utah_Data_LONG$CONTENT_AREA <- recode(Utah_Data_LONG$CONTENT_AREA,
"'MATHEMATICS'='MATHEMATICS';
'ELA'='ELA';
'SCIENCE'='SCIENCE'")

Utah_Data_LONG$CONTENT_AREA <- factor(Utah_Data_LONG$CONTENT_AREA)

Utah_Data_LONG$ACHIEVEMENT_LEVEL <- factor(Utah_Data_LONG$ACHIEVEMENT_LEVEL, levels=1:4, 
	labels=c("Level 1", "Level 2", "Level 3", "Level 4"), ordered=TRUE)

Utah_Data_LONG$EMH_LEVEL <- factor(Utah_Data_LONG$EMH_LEVEL)

Utah_Data_LONG$STATE_ENROLLMENT_STATUS <- factor(Utah_Data_LONG$STATE_ENROLLMENT_STATUS)

Utah_Data_LONG$DISTRICT_ENROLLMENT_STATUS <- factor(Utah_Data_LONG$DISTRICT_ENROLLMENT_STATUS)

Utah_Data_LONG$SCHOOL_ENROLLMENT_STATUS <- factor(Utah_Data_LONG$SCHOOL_ENROLLMENT_STATUS)

Utah_Data_LONG$SUBGROUP <- factor(Utah_Data_LONG$SUBGROUP)
levels(Utah_Data_LONG$SUBGROUP) <- c("No", "Yes")

Utah_Data_LONG$GENDER <- factor(Utah_Data_LONG$GENDER)
levels(Utah_Data_LONG$GENDER) <- c("F", "M")

Utah_Data_LONG$FRL_STATUS <- factor(Utah_Data_LONG$FRL_STATUS)
levels(Utah_Data_LONG$FRL_STATUS) <- c("No", "Yes")

Utah_Data_LONG$IEP_STATUS <- factor(Utah_Data_LONG$IEP_STATUS)
levels(Utah_Data_LONG$IEP_STATUS) <- c("No", "Yes")

Utah_Data_LONG$ELL_STATUS <- factor(Utah_Data_LONG$ELL_STATUS)
levels(Utah_Data_LONG$ELL_STATUS) <- c("No", "Yes")

Utah_Data_LONG$GT_STATUS <- factor(Utah_Data_LONG$GT_STATUS)
levels(Utah_Data_LONG$GT_STATUS) <- c("No", "Yes")

Utah_Data_LONG$ACHIEVEMENT_LEVEL_FULL <- Utah_Data_LONG$ACHIEVEMENT_LEVEL
levels(Utah_Data_LONG$ACHIEVEMENT_LEVEL) <- c("BP", "BP", "P", "A")


Utah_Data_LONG$TEST_MEDIUM <- factor(Utah_Data_LONG$TEST_MEDIUM)
levels(Utah_Data_LONG$TEST_MEDIUM) <- c("CRT", "NWEA", "UAA")

Utah_Data_LONG$BP <- NULL

Utah_Data_LONG$ETHNICITY <- factor(Utah_Data_LONG$ETHNICITY)
levels(Utah_Data_LONG$ETHNICITY) <- c("African American", "American Indian", "Asian", "Hispanic/Latino", "Multiple Races", "Pacific Islander", "Unknown", "White")

save(Utah_Data_LONG, file="Utah_Data_LONG.Rdata", compress=TRUE)






