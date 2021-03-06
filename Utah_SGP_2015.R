#########################################################
###
### Calculate SGPs for Utah - 2015
###
##########################################################

# 1. APPLICATIONS AND FILES TO LOAD ON SGP SERVER (D:/SGP/)
##### SGP documentation:
# http://cran.r-project.org/web/packages/SGP/SGP.pdf
##### Statistical software and development environment:
# R
# RStudio
##### Input data:
# v_sgp_longfile_20150811 - SY2015 - 2015 Accountability Only.sql (part of stored procedure in be_upass.acsdbstage)
##### High level controlling code:
# UTAH_SGP_2015.R (this file)	
##### Valid course sequences:
# MATHEMATICS.R
# SCIENCE.R
##### Knots, boundaries, cutscores, etc.:
# SGPstateData.R (AVI: This meta-data will be included in an updated version of the SGP package)
##### To construct individual student growth plot report:
# MiKTeX
#	AD_SGP_GUIDE.pdf


# 2. FILES THAT WILL BE CREATED IN THE SGP PACKAGE (SGP/):
# Utah_Data_LONG_2015.Rdata
# Utah_SGP.Rdata
##### Data/
# Utah_SGP_LONG_Data.txt
# Utah_SGP_LONG_Data_2015.txt
##### Visualizations/studentGrowthPlots/
# Default folder structure for PDF output of visualizeSGP(),
# with one subfolder for each school labeled by school_id
# and one file for each student labeled by ssid


# 3. SET WORKING DIRECTORY
setwd("D:/SGP")


# 4. INSTALL AND LOAD LATEST REQUIRED PACKAGES
update.packages(ask="No")
devtools::install_github('centerforassessment/SGP')

require(SGP)
require(data.table)


# 5. CONNECT TO WAREHOUSE AND EXTRACT INPUT DATA

##    Note: This process was conducted by USOE for 2015 data pull from warehouse.  
##	  		The code below has not been verified, but is a leftover from 2014 code.

##    Note: This input data should consist of only the new 2015 data to be added to the data extracted in 2013 and 2014.
##    	   In 2015 this also includes non_FAY student data from 2008-2014.

# require(RODBC)
# dbhandle <- odbcDriverConnect('driver={SQL Server}; server=acsdbstage; database=be_upass;')

# Utah_Data_LONG_2015 <- sqlQuery(dbhandle, 'SELECT * FROM v_sgp_longfile_20150811 - SY2015 - 2015 Accountability Only')

# write.csv(Utah_Data_LONG_2015, file='SGP_Longfile_2015.csv', row.names=FALSE)


# 6. DATA CLEANING AND PREP
#    SEE THE R SCRIPT Utah_Data_LONG_2015.R FOR DETAILS.


# 7. CALCULATE SGPs IN 3 STEPS (2014 NON-FAY, 2015 FAY AND 2015 NON-FAY)
# 	USE updateSGP FUNCTION TO 
#		A) ADD LONG DATA TO THE EXISTING SGP (S4) DATA OBJECT (prepareSGP step) and 
#		B) PRODUCE SGP FOR BOTH GRADE-BASED AND EOCT TESTS (analyzeSGP step):

# Load the 2014 SGP object with new prior data added in the 2015 data preparation step.
load("Data/Utah_SGP.Rdata") 

# Load the 2015 data object
load("Data/Base_Files/Utah_Data_LONG_2015.Rdata") 


# 7A.  2014 NON-FAY

##  Source the 2014 config files and creat list to supply to sgp.config argument.
##  Note:  the 2014 EOGT config file was writtin in 2015 for this purpose.

source("SGP_CONFIG/EOGT/UT_EOGT_2014.R")
source('SGP_CONFIG/EOCT/2014/MATHEMATICS.R')
source('SGP_CONFIG/EOCT/2014/SCIENCE.R')

UT.2014.config <- c(
	ELA_2014.config,
	SCIENCE_2014.config,
	MATHEMATICS_2014.config,

	EARTH_SCIENCE_2014.config, 
	BIOLOGY_2014.config, 
	CHEMISTRY_2014.config, 
	PHYSICS_2014.config,

	SEC_MATH_I_2014.config,
	SEC_MATH_II_2014.config,
	SEC_MATH_III_2014.config)

setwd("Utah")

##  Don't enforce max order for 2014.  Set to 5 for 2015 later.
##  The 2014 ELA SGPs contain up to 6 priors.
SGPstateData[["UT"]][["SGP_Configuration"]][["max.order.for.percentile"]] <- NULL

##  Run analyses - add 2014 data through prepareSGP step and 
##  calculate percentiles and projections through analyzeSGP step

Utah_SGP <- updateSGP(
	what_sgp_object=Utah_SGP,
	with_sgp_data_LONG=Utah_Data_LONG_2015[YEAR=='2014'],# Supply ONLY the 2014 data.
	steps=c("prepareSGP", "analyzeSGP"),
	sgp.config=UT.2014.config,
	sgp.percentiles = TRUE,
	sgp.projections = FALSE,
	sgp.projections.lagged = FALSE,
	sgp.percentiles.baseline = FALSE,
	sgp.projections.baseline = FALSE,
	sgp.projections.lagged.baseline = FALSE,
	simulate.sgps=FALSE,
	save.intermediate.results=FALSE,
	goodness.of.fit.print=FALSE,
	overwrite.existing.data=FALSE,
	sgp.use.my.coefficient.matrices=TRUE, 
	outputSGP.output.type="LONG_FINAL_YEAR_Data"
)

# 7B.  2015 FAY STUDENTS

source("SGP_CONFIG/EOGT/UT_EOGT_2015.R")
source("SGP_CONFIG/EOCT/2015/SCIENCE.R")
source("SGP_CONFIG/EOCT/2015/MATHEMATICS.R")

UT.config <- c(
	ELA_2015.config, 
	SCIENCE_2015.config, 
	MATHEMATICS_2015.config, 
	
	EARTH_SCIENCE_2015.config, 
	BIOLOGY_2015.config, 
	CHEMISTRY_2015.config, 
	PHYSICS_2015.config,

	SEC_MATH_I_2015.config,
	SEC_MATH_II_2015.config,
	SEC_MATH_III_2015.config)

##  Reset max.order.for.percentile to 5 again
SGPstateData[["UT"]][["SGP_Configuration"]][["max.order.for.percentile"]] <- 5

##  Reset return.prior.scale.score.standardized to TRUE.  Gets set to FALSE in above call to updateSGP
SGPstateData[["UT"]][["SGP_Configuration"]][["return.prior.scale.score.standardized"]] <- TRUE

##  Run analyses - add 2015 data through prepareSGP step and 
##  calculate percentiles and projections through analyzeSGP step

Utah_SGP <- updateSGP(
	what_sgp_object=Utah_SGP,
	with_sgp_data_LONG=Utah_Data_LONG_2015[YEAR=='2015'],# Supply ONLY the 2015 data for analysis.
	steps=c("prepareSGP", "analyzeSGP"),
	sgp.config=UT.config,
	sgp.percentiles = TRUE,
	sgp.projections = TRUE,
	sgp.projections.lagged = TRUE,
	sgp.percentiles.baseline = FALSE,
	sgp.projections.baseline = FALSE,
	sgp.projections.lagged.baseline = FALSE,
	simulate.sgps=FALSE,
	save.intermediate.results=FALSE,
	overwrite.existing.data=FALSE,
	parallel.config=list(
		BACKEND="FOREACH", TYPE="doParallel", WORKERS=12)
)

# 7C.  2015 NON-FAY STUDENTS

## Load the non-FAY cleaned data
load("Data/Base_Files/Utah_Data_LONG_2015_nonFAY.Rdata")

Utah_SGP <- updateSGP(
	what_sgp_object=Utah_SGP,
	with_sgp_data_LONG=Utah_Data_LONG_2015_nonFAY,
	steps=c("prepareSGP", "analyzeSGP"),
	sgp.config=UT.config,
	sgp.percentiles.baseline = FALSE,
	sgp.projections.baseline = FALSE,
	sgp.projections.lagged.baseline = FALSE,
	simulate.sgps=FALSE,
	save.intermediate.results=FALSE,
	goodness.of.fit.print=FALSE,
	overwrite.existing.data=FALSE,
	sgp.use.my.coefficient.matrices=TRUE,
	outputSGP.output.type="LONG_FINAL_YEAR_Data"
)


# 8. MERGE LONG DATA WITH SGP RESULTS

Utah_SGP <- combineSGP(
	Utah_SGP,
	sgp.percentiles.baseline = FALSE,
	sgp.projections.baseline = FALSE,
	sgp.projections.lagged.baseline = FALSE,
	sgp.target.scale.scores = TRUE,
	sgp.config=UT.config[sapply(UT.config, function(x) is.null(x[["sgp.projection.grade.sequences"]]))],
	parallel.config=list(
		BACKEND="FOREACH", TYPE="doParallel",
			WORKERS=list(SGP_SCALE_SCORE_TARGETS=12))
)


# 9. CALCULATE SUMMARY STATISTICS TO BE STORED IN DATA OBJECT AND USED ELSEWHERE IN APPLICATION

Utah_SGP <- summarizeSGP(
	Utah_SGP,
	parallel.config=list(
		BACKEND="FOREACH", TYPE="doParallel", 
		WORKERS=list(SUMMARY=12))
)

save(Utah_SGP, file="Data/Utah_SGP.Rdata")


# 10. EXPORT DATA FROM SGP OBJECT @Data SLOT AS PIPE-DELIMITED FILE IN VARIOUS FORMATS

outputSGP(Utah_SGP, output.type = c("LONG_Data", "LONG_FINAL_YEAR_Data"))


# 11. LOAD SGP OUTPUT INTO DATA WAREHOUSE
# Data/Utah_SGP_LONG_Data.txt -> be_upass.acsdbstage.sgp_raw


# 12. PRODUCE INDIVIDUAL STUDENT REPORTS (STUDENT GROWTH PLOTS)

###  Ensure that all names are capitalized consistently (camel case)
###  Convert NAME variables to factor so that we can just work with the factor levels (much quicker!)

Utah_SGP@Data[, LAST_NAME := factor(LAST_NAME)]
Utah_SGP@Data[, FIRST_NAME := factor(FIRST_NAME)]
Utah_SGP@Data[, SCHOOL_NAME := factor(SCHOOL_NAME)]

levels(Utah_SGP@Data$LAST_NAME) <- sapply(levels(Utah_SGP@Data$LAST_NAME), capwords)
levels(Utah_SGP@Data$FIRST_NAME) <-sapply(levels(Utah_SGP@Data$FIRST_NAME), capwords)
tmp.sch.levels<-sapply(levels(Utah_SGP@Data$SCHOOL_NAME), capwords, special.words=c("HS", "MS", "CS", "CBA", "UT", "SUCCESS", "DSU", "SUU", "AMES", "BSTA", "CBTU", "GTI", "NUAMES", "SPED", "UCAS", "YIC"), USE.NAMES=FALSE)

###  Fix some of the Schools.  There might be others (?)
tmp.sch.levels <- gsub("Mckinley", "McKinley", tmp.sch.levels)
tmp.sch.levels <- gsub("Mcmillan", "McMillan", tmp.sch.levels)
tmp.sch.levels <- gsub("Mcpolin", "McPolin", tmp.sch.levels)
tmp.sch.levels <- gsub("Inc ,", "Inc.,", tmp.sch.levels)
tmp.sch.levels <- gsub("Eschool@provo", "eSchool@Provo", tmp.sch.levels)
tmp.sch.levels <- gsub("SUCCESS School", "Success School", tmp.sch.levels)

levels(Utah_SGP@Data$SCHOOL_NAME) <- tmp.sch.levels

###  Reset the class of the NAME variables to character 
Utah_SGP@Data[, LAST_NAME := as.character(LAST_NAME)]
Utah_SGP@Data[, FIRST_NAME := as.character(FIRST_NAME)]
Utah_SGP@Data[, SCHOOL_NAME := as.character(SCHOOL_NAME)]

###  Set SGPstateData to NOT include the front page in the School Catalogs produced
###  This is now included in the UT entry of SGPstateData.  Set to NULL to include it in the catalog if wanted.

# SGPstateData[["UT"]][["Student_Report_Information"]][["Include_Front_Page_in_School_Catalog"]] <- FALSE

###  Produce the "Demo" set of student reports

visualizeSGP(
	Utah_SGP,
	plot.types=c("bubblePlot", "studentGrowthPlot"),
	sgPlot.front.page = "Misc/USOE_Cover.pdf", # Serves as introduction to the report
	sgPlot.header.footer.color="#0B6E8D", # Will need to change to match USOE_Cover.pdf
	sgPlot.demo.report = TRUE,
	sgPlot.year.span = 2,
	sgPlot.plot.test.transition=FALSE)
)

Utah_SGP@Data[, GRADE := as.numeric(GRADE)]

visualizeSGP(
	Utah_SGP,
	plot.types="growthAchievementPlot",
	gaPlot.content_areas=c("ELA", "MATHEMATICS", "SCIENCE")
)


###
###    Add in the 40th Percentile Targets
###

Utah_SGP@SGP$SGProjections <- Utah_SGP@SGP$SGProjections[c(1:28, 37:54)]

source("/media/Data/Dropbox/Github_Repos/Projects/Utah/sgp_config/EOGT/UT_EOGT_2015.R")
source("/media/Data/Dropbox/Github_Repos/Projects/Utah/sgp_config/EOCT/2015/MATHEMATICS.R")
source("/media/Data/Dropbox/Github_Repos/Projects/Utah/sgp_config/EOCT/2015/SCIENCE.R")

UT.config <- c(
	ELA_2015.config, 
	SCIENCE_2015.config, 
	MATHEMATICS_2015.config, 
	
	EARTH_SCIENCE_2015.config, 
	BIOLOGY_2015.config, 
	CHEMISTRY_2015.config, 
	PHYSICS_2015.config,

	SEC_MATH_I_2015.config,
	SEC_MATH_II_2015.config,
	SEC_MATH_III_2015.config)

SGPstateData[["UT"]][["Growth"]][["Cutscores"]][["Cuts"]] <- c(40, 60)

Utah_SGP <- analyzeSGP(
		Utah_SGP,
		sgp.config=UT.config,

		sgp.projections = TRUE,

		sgp.percentiles = FALSE,
		sgp.projections.lagged = FALSE,
		sgp.percentiles.baseline = FALSE,
		sgp.projections.baseline = FALSE,
		sgp.projections.lagged.baseline = FALSE,
		simulate.sgps=FALSE,
		goodness.of.fit.print=FALSE)

### Add in CURRENT Projections
library(data.table)
tmp.list.current <- list()
my.variable.names <- c("ID", "SGP_PROJECTION_GROUP", "P40_PROJ_YEAR_1_CURRENT")
my.projection.table.names <- c("ELA.2015", 
	"MATHEMATICS.2015", "SEC_MATH_I.2015", "SEC_MATH_II.2015",# "SEC_MATH_III.2015", 
	"SCIENCE.2015", "BIOLOGY.2015", "EARTH_SCIENCE.2015", "CHEMISTRY.2015")
for (i in my.projection.table.names) {
	tmp.list.current[[i]] <- data.table(
			VALID_CASE="VALID_CASE",
			CONTENT_AREA=unlist(strsplit(i, "\\."))[1],
			# YEAR="2015",
			Utah_SGP@SGP$SGProjections[[i]][,my.variable.names, with=FALSE])
}

###  Merge projection/target data in.  Do this seperately so that 8th grade students get their prior merged in (no current target).
tmp.projections.c <- data.table(rbindlist(tmp.list.current), key=c("ID", "CONTENT_AREA"))

setnames(tmp.projections.c, c("SGP_PROJECTION_GROUP", "P40_PROJ_YEAR_1_CURRENT"), c("TARGET_CONTENT_AREA", "TARGET_SCALE_SCORE"))
setkeyv(tmp.projections.c, c("VALID_CASE", "CONTENT_AREA", "ID"))
setkeyv(Utah_SGP_LONG_Data_2015, c("VALID_CASE", "CONTENT_AREA", "ID"))

###  Now need to keep SCIENCE's multiple projections
Utah_SGP_LONG_Data_2015_FORMATTED <- tmp.projections.c[
	Utah_SGP_LONG_Data_2015[,list(VALID_CASE, CONTENT_AREA, GRADE, ID, SGP, ACHIEVEMENT_LEVEL, SCALE_SCORE_PRIOR, SCALE_SCORE)], 
	allow.cartesian=TRUE] #keep all CURRENT students (allow.cartesian=TRUE)

setkey(Utah_SGP_LONG_Data_2015_FORMATTED, VALID_CASE, CONTENT_AREA, TARGET_CONTENT_AREA, GRADE, SCALE_SCORE)

Target_Table <- unique(Utah_SGP_LONG_Data_2015_FORMATTED)[,list(GRADE, CONTENT_AREA, TARGET_CONTENT_AREA, SCALE_SCORE, TARGET_SCALE_SCORE)]
setkey(Target_Table, GRADE, CONTENT_AREA, TARGET_CONTENT_AREA, SCALE_SCORE)

Target_Table[!is.na(TARGET_SCALE_SCORE)]

Target_Table[which(TARGET_CONTENT_AREA == "BIO_PHYS"), TARGET_CONTENT_AREA := "PHYSICS"]
Target_Table[which(TARGET_CONTENT_AREA == "SCIENCE_BIO"), TARGET_CONTENT_AREA := "BIOLOGY"]

Target_Table <- Target_Table[-which(GRADE != 8 & CONTENT_AREA == "SCIENCE" & TARGET_CONTENT_AREA == "BIOLOGY"),][!is.na(TARGET_SCALE_SCORE)] # Only 8th grade Science will have a different 1 year target.

write.table(Target_Table, file="Dropbox (SGP)/Github_Repos/Projects/Utah/Misc/Utah_SGP_Scale_Score_Target_Table.csv", sep=",", row.names=FALSE, na="", quote=FALSE)
