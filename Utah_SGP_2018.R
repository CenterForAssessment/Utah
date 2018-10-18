#########################################################
###
### Calculate SGPs for Utah - 2018
###
##########################################################

# 1. APPLICATIONS AND FILES TO LOAD ON SGP SERVER (D:/SGP/)
##### SGP documentation:
# http://cran.r-project.org/web/packages/SGP/SGP.pdf
##### Statistical software and development environment:
# R
# RStudio
##### Input data:
# v_sgp_longfile_20180811 - SY2018 - 2018 Accountability Only.sql (part of stored procedure in be_upass.acsdbstage)
##### High level controlling code:
# UTAH_SGP_2018.R (this file)
##### Valid course sequences:
# MATHEMATICS.R
# SCIENCE.R
##### Knots, boundaries, cutscores, etc.:
# SGPstateData.R (AVI: This meta-data will be included in an updated version of the SGP package)
##### To construct individual student growth plot report:
# MiKTeX
#	AD_SGP_GUIDE.pdf


# 2. FILES THAT WILL BE CREATED IN THE SGP PACKAGE (SGP/):
# Utah_Data_LONG_2018.Rdata
# Utah_SGP.Rdata
##### Data/
# Utah_SGP_LONG_Data.txt
# Utah_SGP_LONG_Data_2018.txt
##### Visualizations/studentGrowthPlots/
# Default folder structure for PDF output of visualizeSGP(),
# with one subfolder for each school labeled by school_id
# and one file for each student labeled by ssid


# 3. SET WORKING DIRECTORY
setwd("D:/SGP")


# 4. INSTALL AND LOAD LATEST REQUIRED PACKAGES
update.packages(ask = FALSE, checkBuilt = TRUE)
devtools::install_github("centerforassessment/SGP", build_vignettes=FALSE)

require(SGP)


# 5. CONNECT TO WAREHOUSE AND EXTRACT INPUT DATA

##    Note: This process was conducted by USOE for 2018 data pull from warehouse.
##	  		The code below has not been verified, but is a leftover from 2014 code.

##    Note: This input data should consist of only the new 2018 data to be added to the data extracted in 2013 and 2014.
##    	   In 2018 this also includes non_FAY student data from 2008-2014.

# require(RODBC)
# dbhandle <- odbcDriverConnect('driver={SQL Server}; server=acsdbstage; database=be_upass;')

# Utah_Data_LONG_2018 <- sqlQuery(dbhandle, 'SELECT * FROM v_sgp_longfile_20180811 - SY2018 - 2018 Accountability Only')

# write.csv(Utah_Data_LONG_2018, file='SGP_Longfile_2018.csv', row.names=FALSE)


# 6. DATA CLEANING AND PREP
#    SEE THE R SCRIPT Utah_Data_LONG_2018.R FOR DETAILS.

####
####
####

# 7. CALCULATE SGPs  --  2018 FAY and NON-FAY together
# 	USE updateSGP FUNCTION TO
#		A) ADD LONG DATA TO THE EXISTING SGP (S4) DATA OBJECT (prepareSGP step) and
#		B) PRODUCE SGP FOR BOTH GRADE-BASED AND EOCT TESTS (analyzeSGP step):

# Load the 2017 SGP object
load("Data/Utah_SGP.Rdata")

# Load the 2018 formatted data
load("Data/Utah_Data_LONG_2018.Rdata")

###
##  2018 Analyses - (All students including non-FAY)
###

source("SGP_CONFIG/EOGT/UT_EOGT_2018.R")
source("SGP_CONFIG/EOCT/2018/MATHEMATICS.R")

UT.config <- c(
	ELA_2018.config,
	MATHEMATICS_2018.config,

	SEC_MATH_I_2018.config,
	SEC_MATH_II_2018.config,
	SEC_MATH_III_2018.config)


##  Run analyses - add 2018 data through prepareSGP step and
##  calculate percentiles and projections through analyzeSGP step

Utah_SGP <- updateSGP(
	what_sgp_object = Utah_SGP,
	with_sgp_data_LONG = Utah_Data_LONG_2018,
	steps = c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
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
	outputSGP.output.type = c("LONG_FINAL_YEAR_Data"),
	parallel.config = list(
		BACKEND="PARALLEL", WORKERS=list(
			PERCENTILES=12, PROJECTIONS = 8, LAGGED_PROJECTIONS = 8, SGP_SCALE_SCORE_TARGETS=8))
)

save(Utah_SGP, file="Data/Utah_SGP.Rdata")

visualizeSGP(
	Utah_SGP,
	plot.types=c("growthAchievementPlot"))


####
###   SCIENCE Analyses (October 2018)
####

source("SGP_CONFIG/EOGT/UT_EOGT_2018.R")
source("SGP_CONFIG/EOCT/2018/SCIENCE.R")

UT.config <- c(
	SCIENCE_2018.config,

	EARTH_SCIENCE_2018.config,
	BIOLOGY_2018.config,
	CHEMISTRY_2018.config,
	PHYSICS_2018.config)

SGPstateData[["UT"]][["SGP_Configuration"]][["sgp.projections.use.only.complete.matrices"]] <- FALSE


	Utah_SGP <- updateSGP(
		what_sgp_object = Utah_SGP,
		with_sgp_data_LONG = Utah_Data_LONG_2018,
		steps = c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP", "summarizeSGP"),
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
			BACKEND="PARALLEL", WORKERS=list(
				PERCENTILES=12, PROJECTIONS = 8, LAGGED_PROJECTIONS = 8, SGP_SCALE_SCORE_TARGETS=8, SUMMARY=12))
	)


# 8. LOAD SGP OUTPUT INTO DATA WAREHOUSE
# Data/Utah_SGP_LONG_Data.txt -> be_upass.acsdbstage.sgp_raw


# 9. PRODUCE INDIVIDUAL STUDENT REPORTS (STUDENT GROWTH PLOTS)

###  Produce the "Demo" set of student reports

visualizeSGP(
	Utah_SGP,
	plot.types=c("bubblePlot", "studentGrowthPlot", "growthAchievementPlot"),
	sgPlot.front.page = "Visualizations/Misc/USOE_Cover.pdf", # Serves as introduction to the report
	sgPlot.header.footer.color="#0B6E8D", # Need to change to match USOE_Cover.pdf
	sgPlot.demo.report = TRUE,
	sgPlot.year.span = 2,
	sgPlot.plot.test.transition=FALSE,
	gaPlot.content_areas=c("ELA", "MATHEMATICS", "SCIENCE")
)

###  If you only want to show one Science progression (the canonical Science to Earth Science to Biology, etc.) then first REMOVE the Science to Bio projections:
# Utah_SGP@SGP$SGProjections$SCIENCE.2018 <-
# 	Utah_SGP@SGP$SGProjections$SCIENCE.2018[SGP_PROJECTION_GROUP != "SCIENCE_BIO"]

# visualizeSGP(
# 	Utah_SGP,
# 	plot.types=c("studentGrowthPlot"),
# 	sgPlot.front.page = "Visualizations/Misc/USOE_Cover.pdf", # Serves as introduction to the report
# 	sgPlot.demo.report = TRUE)


# 10. Add in the 40th Percentile Targets

require(data.table)

###  Load 2018 data produced in outputSGP step:
load("Data/Utah_SGP_LONG_Data_2018.Rdata")

### Add in CURRENT Projections

tmp.list.current <- list()
my.variable.names <- c("ID", "SGP_PROJECTION_GROUP", "P40_PROJ_YEAR_1_CURRENT")
my.projection.table.names <- c("ELA.2018",
	"MATHEMATICS.2018", "SEC_MATH_I.2018", "SEC_MATH_II.2018")#, # "SEC_MATH_III.2018",
	# "SCIENCE.2018", "EARTH_SCIENCE.2018", "BIOLOGY.2018", "CHEMISTRY.2018")
for (i in my.projection.table.names) {
	tmp.list.current[[i]] <- data.table(
			VALID_CASE="VALID_CASE",
			CONTENT_AREA=unlist(strsplit(i, "\\."))[1],
			# YEAR="2018",
			Utah_SGP@SGP$SGProjections[[i]][, my.variable.names, with=FALSE])
}

###  Merge projection/target data in.  Do this seperately so that 8th grade students get their prior merged in (no current target).
tmp.projections.c <- data.table(rbindlist(tmp.list.current), key=c("ID", "CONTENT_AREA"))

setnames(tmp.projections.c, c("SGP_PROJECTION_GROUP", "P40_PROJ_YEAR_1_CURRENT"), c("TARGET_CONTENT_AREA", "TARGET_SCALE_SCORE"))
setkeyv(tmp.projections.c, c("VALID_CASE", "CONTENT_AREA", "ID"))
setkeyv(Utah_SGP_LONG_Data_2018, c("VALID_CASE", "CONTENT_AREA", "ID"))

###  Now need to keep SCIENCE's multiple projections
Utah_SGP_LONG_Data_2018_FORMATTED <- tmp.projections.c[
	Utah_SGP_LONG_Data_2018[,list(VALID_CASE, CONTENT_AREA, GRADE, ID, SGP, ACHIEVEMENT_LEVEL, SCALE_SCORE_PRIOR, SCALE_SCORE)],
	allow.cartesian=TRUE] #keep all CURRENT students (allow.cartesian=TRUE)

table.key <- c("VALID_CASE", "CONTENT_AREA", "TARGET_CONTENT_AREA", "GRADE", "SCALE_SCORE")
setkeyv(Utah_SGP_LONG_Data_2018_FORMATTED, table.key)

Target_Table <- unique(Utah_SGP_LONG_Data_2018_FORMATTED, by=table.key)[,list(GRADE, CONTENT_AREA, TARGET_CONTENT_AREA, SCALE_SCORE, TARGET_SCALE_SCORE)]
setkey(Target_Table, GRADE, CONTENT_AREA, TARGET_CONTENT_AREA, SCALE_SCORE)

Target_Table <- Target_Table[!is.na(TARGET_SCALE_SCORE)]
table(Target_Table[, TARGET_CONTENT_AREA, CONTENT_AREA])

###  Save for Math and ELA
write.table(Target_Table, file="/media/Data/Dropbox (SGP)/Github_Repos/Projects/Utah/Misc/Utah_SGP_Scale_Score_Target_Table_2018-ELA_Math.csv", sep=",", row.names=FALSE, na="", quote=FALSE)

###  Additional QC and steps for Science
Target_Table[which(TARGET_CONTENT_AREA == "BIO_PHYS"), TARGET_CONTENT_AREA := "PHYSICS"]
Target_Table[which(TARGET_CONTENT_AREA == "SCIENCE_BIO"), TARGET_CONTENT_AREA := "BIOLOGY"]

Target_Table <- Target_Table[-which(GRADE != 8 & CONTENT_AREA == "SCIENCE" & TARGET_CONTENT_AREA == "BIOLOGY"),][!is.na(TARGET_SCALE_SCORE)] # Only 8th grade Science will have a different 1 year target.

write.table(Target_Table, file="/media/Data/Dropbox (SGP)/Github_Repos/Projects/Utah/Misc/Utah_SGP_Scale_Score_Target_Table_2018.csv", sep=",", row.names=FALSE, na="", quote=FALSE)
