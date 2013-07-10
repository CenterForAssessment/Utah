#############################################################################
#############################################################################
####
####          Investigate Use of EOCT Course Progressions for Utah SGPs
####
#############################################################################
#############################################################################

### Load required libraries
library(SGP)

### Load Data - see Utah_Data_LONG for changes to Utah_Data_LONG (content area and grade) and creation of UT_EOCT_Knots_Bounds
load("Utah_Data_LONG-EOCT_Explore.Rdata")

load("UT_EOCT_Knots_Bounds.Rdata")
load("SGP_CONFIG/UT_SGP_Norm_Group_Preference.Rdata") # assuming you have SGP_CONFIG directory in your working directory

###
###  Prepare SGP Object:
###

Utah_EOCT_SGP <- prepareSGP(Utah_Data_LONG)

save(Utah_EOCT_SGP, file="Utah_EOCT_SGP.Rdata")


##########################################################################
##############################################################
####	analyzeSGP
##############################################################
##########################################################################


### Load required libraries
library(SGP)

load("Utah_EOCT_SGP.Rdata")


###
###  Grade level tests as usual with content areas specified:
###

Utah_EOCT_SGP <- analyzeSGP(Utah_EOCT_SGP,
						years=c('2011', '2012'),
						content_areas=c("ELA", "MATHEMATICS", "SCIENCE"),
						grades=3:11,
						sgp.percentiles.baseline=FALSE,
						sgp.projections.baseline= FALSE,
						sgp.projections.lagged.baseline=FALSE,
						simulate.sgps=FALSE,
						parallel.config=list(
							BACKEND="PARALLEL", 
							WORKERS=list(PERCENTILES=6, PROJECTIONS=4, LAGGED_PROJECTIONS=4)))


###
###		EOCT Analyses specified analyses with MAX priors available
###

### Load and create 2011 and 2012 EOCT Configuration
source("SGP_CONFIG/EOCT/2011/MATHEMATICS.R") # assuming you have SGP_CONFIG directory in your working directory
source("SGP_CONFIG/EOCT/2011/SCIENCE.R")

source("SGP_CONFIG/EOCT/2012/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2012/SCIENCE.R")

UT.config <- c( 
		EARTH_SCIENCE_2011.config, 
		BIOLOGY_2011.config, 
		CHEMISTRY_2011.config, 
		PHYSICS_2011.config,
		PRE_ALGEBRA_2011.config,
		ALGEBRA_I_2011.config, 
		GEOMETRY_2011.config,
		ALGEBRA_II_2011.config,
		
		EARTH_SCIENCE_2012.config, 
		BIOLOGY_2012.config, 
		CHEMISTRY_2012.config, 
		PHYSICS_2012.config,
		PRE_ALGEBRA_2012.config,
		ALGEBRA_I_2012.config, 
		GEOMETRY_2012.config,
		ALGEBRA_II_2012.config)
		
###  Add in the EOCT Knots and Bounds

SGPstateData[["UT"]][["Achievement"]][["Knots_Boundaries"]] <- c(SGPstateData[["UT"]][["Achievement"]][["Knots_Boundaries"]], UT_EOCT_Knots_Bounds)

Utah_EOCT_SGP <- analyzeSGP(Utah_EOCT_SGP,
						sgp.config=UT.config,
						sgp.percentiles=TRUE,
						sgp.projections=FALSE,
						sgp.projections.lagged=FALSE,
						sgp.percentiles.baseline=FALSE,
						sgp.projections.baseline= FALSE,
						sgp.projections.lagged.baseline=FALSE,
						simulate.sgps=FALSE,
						parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=12)))


#############################################################################
##############################################################
### 		 combineSGP
##############################################################
#############################################################################

SGPstateData[["UT"]][["SGP_Norm_Group_Preference"]] <- UT_SGP_Norm_Group_Preference

Utah_EOCT_SGP <- combineSGP(Utah_EOCT_SGP) 
						
save(Utah_EOCT_SGP, file="Data/Utah_EOCT_SGP.Rdata")


#############################################################################
##############################################################
###  		summarizeSGP  
##############################################################
#############################################################################

Utah_EOCT_SGP <- summarizeSGP(Utah_EOCT_SGP, parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SUMMARY=8)))

save(Utah_EOCT_SGP, file="Utah_EOCT_SGP.Rdata", compress="bzip2")


#############################################################################
###  	Output results to text files
#############################################################################

###  Data and Results
outputSGP(Utah_EOCT_SGP, output.type=c("LONG_Data", "WIDE_Data")

###  Summary Tables
#  This series of code 1) eliminates NA's in the ACH_LEVEL_PRIOR field, 2) removes an unwanted field, 3) sorts/keys the table, & 4) saves it.

#For All Students
s <-Utah_EOCT_SGP@Summary$SCHOOL_NUMBER$SCHOOL_NUMBER__EMH_LEVEL__CONTENT_AREA__YEAR__SCHOOL_ENROLLMENT_STATUS
s$PERCENT_AT_ABOVE_PROFICIENT_PRIOR_COUNT <- NULL
setkeyv(s,c("SCHOOL_NUMBER", "CONTENT_AREA"))
write.csv(s, file="SCHOOL_NUMBER__YEAR__CONTENT_AREA__EMH_LEVEL__SCHOOL_ENROLLMENT_STATUS.csv", row.names=FALSE)

#For Below Proficient Students
s <- Utah_EOCT_SGP@Summary$SCHOOL_NUMBER$SCHOOL_NUMBER__EMH_LEVEL__CONTENT_AREA__YEAR__ACHIEVEMENT_LEVEL_PRIOR__SCHOOL_ENROLLMENT_STATUS[!is.na(ACHIEVEMENT_LEVEL_PRIOR)]
s$PERCENT_AT_ABOVE_PROFICIENT_PRIOR_COUNT <- NULL
setkeyv(s, c("SCHOOL_NUMBER", "CONTENT_AREA"))
write.csv(s, file="SCHOOL_NUMBER__EMH_LEVEL__CONTENT_AREA__YEAR__ACHIEVEMENT_LEVEL_PRIOR__SCHOOL_ENROLLMENT_STATUS.csv", row.names=FALSE)


#############################################################################
##############################################################
### 		 visualizeSGP
##############################################################
#############################################################################

visualizeSGP(Utah_EOCT_SGP,
	state="UT",
	plot.types="studentGrowthPlot",
	sgPlot.demo.report=TRUE,
	sgPlot.produce.plots=TRUE,
	parallel.config=list(
	BACKEND="PARALLEL", 
	WORKERS=list(SG_PLOTS=6)))
	

visualizeSGP(Utah_EOCT_SGP,
	state="UT",
	plot.types="studentGrowthPlot",
	sgPlot.schools=c(132,168),
	sgPlot.produce.plots=TRUE,
	parallel.config=list(
	BACKEND="PARALLEL", 
	WORKERS=list(SG_PLOTS=6)))


