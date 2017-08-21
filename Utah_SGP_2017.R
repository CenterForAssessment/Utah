#########################################################
###
### Calculate SGPs for Utah - 2017
###
##########################################################

# 1. APPLICATIONS AND FILES TO LOAD ON SGP SERVER (D:/SGP/)
##### SGP documentation:
# http://cran.r-project.org/web/packages/SGP/SGP.pdf
##### Statistical software and development environment:
# R
# RStudio
##### Input data:
# v_sgp_longfile_20170811 - SY2017 - 2017 Accountability Only.sql (part of stored procedure in be_upass.acsdbstage)
##### High level controlling code:
# UTAH_SGP_2017.R (this file)
##### Valid course sequences:
# MATHEMATICS.R
# SCIENCE.R
##### Knots, boundaries, cutscores, etc.:
# SGPstateData.R (AVI: This meta-data will be included in an updated version of the SGP package)
##### To construct individual student growth plot report:
# MiKTeX
#	AD_SGP_GUIDE.pdf


# 2. FILES THAT WILL BE CREATED IN THE SGP PACKAGE (SGP/):
# Utah_Data_LONG_2017.Rdata
# Utah_SGP.Rdata
##### Data/
# Utah_SGP_LONG_Data.txt
# Utah_SGP_LONG_Data_2017.txt
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
# require(data.table)


# 5. CONNECT TO WAREHOUSE AND EXTRACT INPUT DATA

##    Note: This process was conducted by USOE for 2017 data pull from warehouse.
##	  		The code below has not been verified, but is a leftover from 2014 code.

##    Note: This input data should consist of only the new 2017 data to be added to the data extracted in 2013 and 2014.
##    	   In 2017 this also includes non_FAY student data from 2008-2014.

# require(RODBC)
# dbhandle <- odbcDriverConnect('driver={SQL Server}; server=acsdbstage; database=be_upass;')

# Utah_Data_LONG_2017 <- sqlQuery(dbhandle, 'SELECT * FROM v_sgp_longfile_20170811 - SY2017 - 2017 Accountability Only')

# write.csv(Utah_Data_LONG_2017, file='SGP_Longfile_2017.csv', row.names=FALSE)


# 6. DATA CLEANING AND PREP
#    SEE THE R SCRIPT Utah_Data_LONG_2017.R FOR DETAILS.


# 7. CALCULATE SGPs  --  2017 FAY and NON-FAY together
# 	USE updateSGP FUNCTION TO
#		A) ADD LONG DATA TO THE EXISTING SGP (S4) DATA OBJECT (prepareSGP step) and
#		B) PRODUCE SGP FOR BOTH GRADE-BASED AND EOCT TESTS (analyzeSGP step):

# Load the 2016 SGP object with new prior data added in the 2017 data preparation step.
load("Data/Utah_SGP.Rdata")



# Load the 2017 formatted data
load("Data/Utah_Data_LONG_2017.Rdata")


# 7.  2017 Analyses - (All students including non-FAY)

source("SGP_CONFIG/EOGT/UT_EOGT_2017.R")
source("SGP_CONFIG/EOCT/2017/SCIENCE.R")
source("SGP_CONFIG/EOCT/2017/MATHEMATICS.R")

UT.config <- c(
	ELA_2017.config,
	SCIENCE_2017.config,
	MATHEMATICS_2017.config,

	EARTH_SCIENCE_2017.config,
	BIOLOGY_2017.config,
	CHEMISTRY_2017.config,
	PHYSICS_2017.config,

	SEC_MATH_I_2017.config,
	SEC_MATH_II_2017.config,
	SEC_MATH_III_2017.config)


##  Run analyses - add 2017 data through prepareSGP step and
##  calculate percentiles and projections through analyzeSGP step

Utah_SGP <- updateSGP(
	what_sgp_object = Utah_SGP,
	with_sgp_data_LONG = Utah_Data_LONG_2017,
	steps = c("prepareSGP", "analyzeSGP", "combineSGP", "summarizeSGP", "outputSGP"),
	sgp.config = UT.config,
	sgp.percentiles = TRUE,
	sgp.projections = TRUE,
	sgp.projections.lagged = TRUE,
	sgp.percentiles.baseline = FALSE,
	sgp.projections.baseline = FALSE,
	sgp.projections.lagged.baseline = FALSE,
	simulate.sgps=FALSE,
	sgp.target.scale.scores = TRUE,
	save.intermediate.results = FALSE,
	overwrite.existing.data = FALSE,
	outputSGP.output.type = c("LONG_Data", "LONG_FINAL_YEAR_Data", "WIDE_Data"),
	parallel.config = list(
		BACKEND="FOREACH", TYPE="doParallel",
		WORKERS=list(PERCENTILES=12, PROJECTIONS =12, LAGGED_PROJECTIONS = 12, SGP_SCALE_SCORE_TARGETS=12, SUMMARY=12))
)

save(Utah_SGP, file="Data/Utah_SGP.Rdata")

# 8. LOAD SGP OUTPUT INTO DATA WAREHOUSE
# Data/Utah_SGP_LONG_Data.txt -> be_upass.acsdbstage.sgp_raw


# 9. PRODUCE INDIVIDUAL STUDENT REPORTS (STUDENT GROWTH PLOTS)

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
	plot.types=c("bubblePlot", "studentGrowthPlot", "growthAchievementPlot"),
	sgPlot.front.page = "Misc/USOE_Cover.pdf", # Serves as introduction to the report
	sgPlot.header.footer.color="#0B6E8D", # Will need to change to match USOE_Cover.pdf
	sgPlot.demo.report = TRUE,
	sgPlot.year.span = 2,
	sgPlot.plot.test.transition=FALSE,
	gaPlot.content_areas=c("ELA", "MATHEMATICS", "SCIENCE")
)

###  Create student report DEMO catalog
Utah_SGP@SGP$SGProjections$SCIENCE.2017 <-
	Utah_SGP@SGP$SGProjections$SCIENCE.2017[SGP_PROJECTION_GROUP != "SCIENCE_BIO"]

visualizeSGP(
	Utah_SGP,
	plot.types=c("studentGrowthPlot"),
	sgPlot.front.page = "Visualizations/Misc/USOE_Cover.pdf", # Serves as introduction to the report
	sgPlot.demo.report = TRUE)


# 10. Add in the 40th Percentile Targets

require(data.table)

###  Load 2017 data produced in outputSGP step:
load("Data/Utah_SGP_LONG_Data_2017.Rdata")

### Add in CURRENT Projections

tmp.list.current <- list()
my.variable.names <- c("ID", "SGP_PROJECTION_GROUP", "P40_PROJ_YEAR_1_CURRENT")
my.projection.table.names <- c("ELA.2017",
	"MATHEMATICS.2017", "SEC_MATH_I.2017", "SEC_MATH_II.2017",# "SEC_MATH_III.2017",
	"SCIENCE.2017", "BIOLOGY.2017", "EARTH_SCIENCE.2017", "CHEMISTRY.2017")
for (i in my.projection.table.names) {
	tmp.list.current[[i]] <- data.table(
			VALID_CASE="VALID_CASE",
			CONTENT_AREA=unlist(strsplit(i, "\\."))[1],
			# YEAR="2017",
			Utah_SGP@SGP$SGProjections[[i]][,my.variable.names, with=FALSE])
}

###  Merge projection/target data in.  Do this seperately so that 8th grade students get their prior merged in (no current target).
tmp.projections.c <- data.table(rbindlist(tmp.list.current), key=c("ID", "CONTENT_AREA"))

setnames(tmp.projections.c, c("SGP_PROJECTION_GROUP", "P40_PROJ_YEAR_1_CURRENT"), c("TARGET_CONTENT_AREA", "TARGET_SCALE_SCORE"))
setkeyv(tmp.projections.c, c("VALID_CASE", "CONTENT_AREA", "ID"))
setkeyv(Utah_SGP_LONG_Data_2017, c("VALID_CASE", "CONTENT_AREA", "ID"))

###  Now need to keep SCIENCE's multiple projections
Utah_SGP_LONG_Data_2017_FORMATTED <- tmp.projections.c[
	Utah_SGP_LONG_Data_2017[,list(VALID_CASE, CONTENT_AREA, GRADE, ID, SGP, ACHIEVEMENT_LEVEL, SCALE_SCORE_PRIOR, SCALE_SCORE)],
	allow.cartesian=TRUE] #keep all CURRENT students (allow.cartesian=TRUE)

setkey(Utah_SGP_LONG_Data_2017_FORMATTED, VALID_CASE, CONTENT_AREA, TARGET_CONTENT_AREA, GRADE, SCALE_SCORE)

Target_Table <- unique(Utah_SGP_LONG_Data_2017_FORMATTED)[,list(GRADE, CONTENT_AREA, TARGET_CONTENT_AREA, SCALE_SCORE, TARGET_SCALE_SCORE)]
setkey(Target_Table, GRADE, CONTENT_AREA, TARGET_CONTENT_AREA, SCALE_SCORE)

Target_Table[!is.na(TARGET_SCALE_SCORE)]

Target_Table[which(TARGET_CONTENT_AREA == "BIO_PHYS"), TARGET_CONTENT_AREA := "PHYSICS"]
Target_Table[which(TARGET_CONTENT_AREA == "SCIENCE_BIO"), TARGET_CONTENT_AREA := "BIOLOGY"]

Target_Table <- Target_Table[-which(GRADE != 8 & CONTENT_AREA == "SCIENCE" & TARGET_CONTENT_AREA == "BIOLOGY"),][!is.na(TARGET_SCALE_SCORE)] # Only 8th grade Science will have a different 1 year target.

write.table(Target_Table, file="/media/Data/Dropbox (SGP)/Github_Repos/Projects/Utah/Misc/Utah_SGP_Scale_Score_Target_Table_2017.csv", sep=",", row.names=FALSE, na="", quote=FALSE)
