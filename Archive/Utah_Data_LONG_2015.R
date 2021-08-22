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

Utah_Data_LONG_2015 <- fread("Data/Base_Files/SGP_Longfile_2015.csv", colClasses=rep("character", 20))
setnames(Utah_Data_LONG_2015, c('VALID_CASE', 'SchoolYear', 'StudentID', 'TestSubjectID', 'TestSubject', 'SubjectArea', 'StudentGradeLevel', 'YEAR', 'ID', 'CONTENT_AREA', 'GRADE', 'SCALE_SCORE', 'ACHIEVEMENT_LEVEL', 'DISTRICT_NUMBER', 'SCHOOL_NUMBER', 'DISTRICT_NAME', 'SCHOOL_NAME', 'LAST_NAME', 'FIRST_NAME', 'SSID'))

Utah_Data_LONG_2015[, SCHOOL_ENROLLMENT_STATUS := 'Enrolled School: Yes']
Utah_Data_LONG_2015[, DISTRICT_ENROLLMENT_STATUS := 'Enrolled District: Yes']
Utah_Data_LONG_2015[, STATE_ENROLLMENT_STATUS := 'Enrolled State: Yes']

### Final cleaning needed for File Randy uploaded

# TRANSFORM PROFICIENCY LEVEL VARIABLES TO R FACTORS
Utah_Data_LONG_2015$ACHIEVEMENT_LEVEL <- factor(Utah_Data_LONG_2015$ACHIEVEMENT_LEVEL, levels=0:4, 
	labels=c(NA, "Level 1", "Level 2", "Level 3", "Level 4"), ordered=TRUE)

Utah_Data_LONG_2015$ACHIEVEMENT_LEVEL_FULL <- Utah_Data_LONG_2015$ACHIEVEMENT_LEVEL

levels(Utah_Data_LONG_2015$ACHIEVEMENT_LEVEL) <- c(NA, "BP", "BP", "P", "A")

table(Utah_Data_LONG_2015$ACHIEVEMENT_LEVEL, exclude=NULL)
table(Utah_Data_LONG_2015$ACHIEVEMENT_LEVEL_FULL, exclude=NULL)

#  INVALIDate cases with GRADE = 2
Utah_Data_LONG_2015[which(GRADE==2), VALID_CASE := "INVALID_CASE"]

#  Fix 2014 and 2015 8th Grade Math (Labeled as "PRE_ALGEBRA")
Utah_Data_LONG_2015[which(CONTENT_AREA=="PRE_ALGEBRA" & YEAR %in% 2014:2015), GRADE := "8"]
Utah_Data_LONG_2015[which(CONTENT_AREA=="PRE_ALGEBRA" & YEAR %in% 2014:2015), CONTENT_AREA := "MATHEMATICS"]


### Identify duplicate and unique cases from prior years

load("~/Dropbox/SGP/Utah/Data/Utah_SGP.Rdata")

UT <- copy(Utah_SGP@Data)
setnames(UT, c("test_subject", "school_year", "student_id", "test_subject_id"), c("TestSubject", "SchoolYear", "StudentID", "TestSubjectID"))

UT[, NOTES := "Original data."] #Old
Utah_Data_LONG_2015[, NOTES := "Original data."] # "X - Added 2015"
Utah_Data_LONG_2015[which(YEAR != 2015), NOTES := "Provided in 2015 as additional prior data."] # "X - Added 2015"
Utah_Data_LONG_2015[, ACHIEVEMENT_LEVEL := as.character(ACHIEVEMENT_LEVEL)]

ALL_SAGE <- rbind(UT, Utah_Data_LONG_2015, fill=TRUE)
setkeyv(ALL_SAGE, c(key(UT), "NOTES"))
setkeyv(ALL_SAGE, key(UT))
dim(ALL_SAGE[!duplicated(ALL_SAGE)])
UT.D <- ALL_SAGE[c(which(duplicated(ALL_SAGE))-1, which(duplicated(ALL_SAGE)))]
ALL_SAGE <- ALL_SAGE[!duplicated(ALL_SAGE)]

table(ALL_SAGE$NOTES, ALL_SAGE$YEAR, ALL_SAGE$VALID_CASE)
table(UT.D$NOTES, UT.D$YEAR, UT.D$VALID_CASE)

UT_PRIORS <- ALL_SAGE[which(!YEAR %in% c(2014, 2015) & NOTES != "Original data.")][, names(Utah_Data_LONG_2015), with=FALSE]

###  Subset the data to be fed directly into updateSGP
Utah_Data_LONG_2015 <- ALL_SAGE[YEAR %in% c(2014, 2015)][, names(Utah_Data_LONG_2015), with=FALSE]
Utah_Data_LONG_2015 <- Utah_Data_LONG_2015[-which(YEAR == 2014 & NOTES == "Original data.")]

###  Save data object.
save(Utah_Data_LONG_2015, file="Data/Base_Files/Utah_Data_LONG_2015.Rdata")


###  Add the additional priors for 2014 non-FAY into the Utah_SGP@Data slot and re-save SGP object
Utah_SGP@Data <- rbindlist(list(UT, UT_PRIORS), fill=TRUE)
Utah_SGP@Data[, NOTES := factor(NOTES)]
Utah_SGP@Data[, EMH_LEVEL := NULL]
Utah_SGP@Data[, GRADE_PRIOR := NULL]
Utah_SGP@Data[, ACHIEVEMENT_LEVEL_PRIOR2 := NULL]

save(Utah_SGP, file="Data/Utah_SGP.Rdata")

###  Create Knots and Boundaries for SAGE Tests

ALL_SAGE[, SCALE_SCORE := as.numeric(SCALE_SCORE)]
sage.kbs <- createKnotsBoundaries(ALL_SAGE[YEAR %in% c(2014, 2015)])
str(sage.kbs[["MATHEMATICS"]])


###  Format and clean the Non-FAY data

Utah_Data_LONG_2015_nonFAY <- fread("Data/Base_Files/SGP 2015 Supplemental - Missing SGP Longfile (plus nonFAY 2008-2009).csv", colClasses=rep("character", 22))

Utah_Data_LONG_2015_nonFAY[, SCHOOL_ENROLLMENT_STATUS := 'Enrolled School: No']
Utah_Data_LONG_2015_nonFAY[, DISTRICT_ENROLLMENT_STATUS := 'Enrolled District: No']
Utah_Data_LONG_2015_nonFAY[, STATE_ENROLLMENT_STATUS := 'Enrolled State: Yes']

### Final cleaning needed for file Randy uploaded

# TRANSFORM PROFICIENCY LEVEL VARIABLES TO R FACTORS
Utah_Data_LONG_2015_nonFAY$ACHIEVEMENT_LEVEL <- factor(Utah_Data_LONG_2015_nonFAY$ACHIEVEMENT_LEVEL, levels=0:4, 
																								labels=c(NA, "Level 1", "Level 2", "Level 3", "Level 4"), ordered=TRUE)

Utah_Data_LONG_2015_nonFAY$ACHIEVEMENT_LEVEL_FULL <- Utah_Data_LONG_2015_nonFAY$ACHIEVEMENT_LEVEL

levels(Utah_Data_LONG_2015_nonFAY$ACHIEVEMENT_LEVEL) <- c(NA, "BP", "BP", "P", "A")

#  INVALIDate cases with GRADE = 2
Utah_Data_LONG_2015_nonFAY[which(GRADE==2), VALID_CASE := "INVALID_CASE"]

Utah_Data_LONG_2015_nonFAY[, NOTES := "Student Non-FAY."] # "X - Added 2015"
Utah_Data_LONG_2015_nonFAY[which(YEAR != 2015), NOTES := "Provided in 2015 Non-FAY as additional prior data."] # "X - Added 2015"

##		Final changes to Non-FAY data and Utah_SGP object
nonFAY <- rbindlist(list(UT, UT_PRIORS, Utah_Data_LONG_2015[YEAR=='2015'], Utah_Data_LONG_2015_nonFAY), fill=TRUE)
setkeyv(nonFAY, c(key(UT), "NOTES"))
setkeyv(nonFAY, key(UT))
dim(nonFAY[!duplicated(nonFAY) & NOTES != 'Student Non-FAY.'])

Utah_Data_LONG_2015_nonFAY <- nonFAY[!duplicated(nonFAY) & NOTES == 'Student Non-FAY.' & YEAR == '2015']
save(Utah_Data_LONG_2015_nonFAY, file="Data/Base_Files/Utah_Data_LONG_2015_nonFAY.Rdata")

