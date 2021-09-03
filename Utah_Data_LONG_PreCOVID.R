#####################################################################################
###                                                                               ###
###   Utah Learning Loss Analyses -- Create Data for 2019 BASELINEs and Beyond    ###
###                                                                               ###
#####################################################################################

### NOTE: SCALE_SCORE is SCALE_SCORE_EQUATED in this file going forward. SCALE_SCORE_ORIGINAL is the original/actual scale score report on ISTEP+

### Load necessary packages
require(SGP)
require(data.table)

###   Load the results data from the 'official' 2019 SGP analyses
load("./Data/Archive/Pre_COVID_2019/Utah_SGP_LONG_Data.Rdata")

setnames(Utah_SGP_LONG_Data,
          c("SchoolYear", "StudentID", "SCALE_SCORE_EQUATED", "SCALE_SCORE", "ACHIEVEMENT_LEVEL_FULL", "ACHIEVEMENT_LEVEL"),
          c("YEAR", "ID", "SCALE_SCORE", "SCALE_SCORE_ACTUAL", "ACHIEVEMENT_LEVEL_ORIGINAL", "ACH_LEV_COLLAPSED"))
Utah_SGP_LONG_Data[, SCALE_SCORE := round(SCALE_SCORE, 0)]

Utah_SGP_LONG_Data <- Utah_SGP_LONG_Data[YEAR > 2015]

###  Check for duplicate cases  --  2040 old bio/earth sci duplicates -
setkeyv(Utah_SGP_LONG_Data, c("VALID_CASE", "CONTENT_AREA", "YEAR", "GRADE", "ID", "SCALE_SCORE"))
setkeyv(Utah_SGP_LONG_Data, c("VALID_CASE", "CONTENT_AREA", "YEAR", "GRADE", "ID"))
sum(duplicated(Utah_SGP_LONG_Data[VALID_CASE != "INVALID_CASE"], by=key(Utah_SGP_LONG_Data))) # 1178
dups <- data.table(Utah_SGP_LONG_Data[unique(c(which(duplicated(Utah_SGP_LONG_Data, by=key(Utah_SGP_LONG_Data)))-1, which(duplicated(Utah_SGP_LONG_Data, by=key(Utah_SGP_LONG_Data))))), ], key=key(Utah_SGP_LONG_Data))
Utah_SGP_LONG_Data[which(duplicated(Utah_SGP_LONG_Data, by=key(Utah_SGP_LONG_Data)))-1, VALID_CASE := "INVALID_CASE"]

setkeyv(Utah_SGP_LONG_Data, c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID", "SCALE_SCORE"))
setkeyv(Utah_SGP_LONG_Data, c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID"))
sum(duplicated(Utah_SGP_LONG_Data[VALID_CASE != "INVALID_CASE"], by=key(Utah_SGP_LONG_Data))) # 2079 duplicates with valid IDs - (((take the highest score if any exist)))
dups <- data.table(Utah_SGP_LONG_Data[unique(c(which(duplicated(Utah_SGP_LONG_Data, by=key(Utah_SGP_LONG_Data)))-1, which(duplicated(Utah_SGP_LONG_Data, by=key(Utah_SGP_LONG_Data))))), ], key=key(Utah_SGP_LONG_Data))
Utah_SGP_LONG_Data[which(duplicated(Utah_SGP_LONG_Data, by=key(Utah_SGP_LONG_Data)))-1, VALID_CASE := "INVALID_CASE"]


###   Switch to ACHIEVEMENT_LEVEL to new (all Equated) scale
Utah_SGP_LONG_Data[, ACH_LEV_COLLAPSED := NULL] # SAGE test ACH LEVs collapse to A/P/BP - Keep ACHIEVEMENT_LEVEL_FULL/ORIGINAL

SGPstateData[["UT"]][["Assessment_Program_Information"]][["Assessment_Transition"]] <- NULL
SGPstateData[["UT"]][["Assessment_Program_Information"]][["Scale_Change"]] <- NULL

ela.cuts <- SGPstateData[["UT"]][["Achievement"]][["Cutscores"]][["ELA.2019"]]
sci.cuts <- SGPstateData[["UT"]][["Achievement"]][["Cutscores"]][["SCIENCE.2019"]]
mth.cuts <- SGPstateData[["UT"]][["Achievement"]][["Cutscores"]][["MATHEMATICS.2019"]]

SGPstateData[["UT"]][["Achievement"]][["Cutscores"]] <- NULL
ela.cuts -> SGPstateData[["UT"]][["Achievement"]][["Cutscores"]][["ELA"]]
sci.cuts -> SGPstateData[["UT"]][["Achievement"]][["Cutscores"]][["SCIENCE"]]
mth.cuts -> SGPstateData[["UT"]][["Achievement"]][["Cutscores"]][["MATHEMATICS"]]
SGPstateData[["UT"]][["Achievement"]][["Cutscores"]][["SEC_MATH_I"]] <- list(GRADE_EOCT=c(478, 535, 591))

Utah_SGP_LONG_Data <- SGP:::getAchievementLevel(Utah_SGP_LONG_Data, state="UT")
# table(Utah_SGP_LONG_Data[, ACHIEVEMENT_LEVEL, ACHIEVEMENT_LEVEL_ORIGINAL])
# Utah_SGP_LONG_Data[YEAR == '2019', ACHIEVEMENT_LEVEL := ACHIEVEMENT_LEVEL_ORIGINAL]

### Test for BASELINE related variable in LONG data and NULL out if they exist
if (length(tmp.names <- grep("BASELINE|EQUATED", names(Utah_SGP_LONG_Data))) > 0) {
		Utah_SGP_LONG_Data[,eval(tmp.names):=NULL]
}

###   Create knots/boundaries in SGPstateData to use equated scale scores properly
##    Add in 2021 data to avoid LOSS/HOSS issues in 2021 analyses (ELA g 6:8 and SEC_MATH_I)
Utah_Data_LONG_2021 <- fread("./Data/Base_Files/Long_File_2021v3.txt", colClasses=rep("character", 25), na.strings = "NULL") # Math and ELA (NO science)
Utah_KB_Data <- rbindlist(list(Utah_SGP_LONG_Data[YEAR %in% 2017:2019], Utah_Data_LONG_2021), fill=TRUE, use.names = TRUE)

UT_Knots_Boundaries <- createKnotsBoundaries(Utah_KB_Data)
SGPstateData[["UT"]][["Achievement"]][["Knots_Boundaries"]] <- NULL
SGPstateData[["UT"]][["Achievement"]][["Knots_Boundaries"]] <- UT_Knots_Boundaries
SGPstateData[["UT"]][["SGP_Configuration"]][["sgp.cohort.size"]] <- NULL # 2 prior SEC_MATH_I has 2933 kids...
save(UT_Knots_Boundaries, file="Data/Archive/Pre_COVID_2019/UT_Knots_Boundaries-RISE_UAp.Rdata")

assign("Utah_SGP_LONG_Data_PreCOVID", Utah_SGP_LONG_Data)

new.name.order <- c(
        'VALID_CASE', 'YEAR', 'ID', 'CONTENT_AREA', 'CONTENT_AREA_ACTUAL', 'GRADE',
        'SCALE_SCORE_ACTUAL', 'ACHIEVEMENT_LEVEL_ORIGINAL', 'SCALE_SCORE', 'ACHIEVEMENT_LEVEL',
        'SCALE_SCORE_PRIOR', 'SCALE_SCORE_PRIOR_STANDARDIZED', 'ACHIEVEMENT_LEVEL_PRIOR',
        'SGP', 'SGP_ORDER_1', 'SGP_ORDER_2', 'SGP_ORDER_3', 'SGP_ORDER_4', 'SGP_ORDER_5',
        'SGP_LEVEL', 'SGP_NORM_GROUP', 'SGP_NOTE',
        'SGP_TARGET_3_YEAR', 'SGP_TARGET_MOVE_UP_STAY_UP_3_YEAR', 'SGP_PROJECTION_GROUP',
        'SGP_TARGET_3_YEAR_CONTENT_AREA', 'CATCH_UP_KEEP_UP_STATUS_3_YEAR', 'MOVE_UP_STAY_UP_STATUS_3_YEAR',
        'SGP_TARGET_3_YEAR_CURRENT', 'SGP_TARGET_MOVE_UP_STAY_UP_3_YEAR_CURRENT',
        'DISTRICT_NUMBER', 'SCHOOL_NUMBER', 'DISTRICT_NAME', 'SCHOOL_NAME',
        'SCHOOL_ENROLLMENT_STATUS', 'DISTRICT_ENROLLMENT_STATUS', 'STATE_ENROLLMENT_STATUS',
        'GENDER', 'ETHNICITY', 'FRL_STATUS', 'IEP_STATUS', 'ELL_STATUS', 'ETHNIC_HISPANIC',
        'LAST_NAME', 'FIRST_NAME', 'SSID', 'TestSubjectID', 'TestSubject', 'SubjectArea', 'school_id')

setcolorder(Utah_SGP_LONG_Data_PreCOVID, new.name.order)
save(Utah_SGP_LONG_Data_PreCOVID, file="Data/Utah_SGP_LONG_Data_PreCOVID.Rdata")
