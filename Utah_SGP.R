#############################################################################
#############################################################################
####
####    Create 2011, 2012 & 2013 SGPs for Utah.
####    Grade level subjects and EOCT Course Progressions.
####
#############################################################################
#############################################################################

### Load required libraries
library(SGP)
library(data.table)
### Load Data - see Utah_Data_LONG.R for details
load("Utah_Data_LONG.Rdata")

## Convert 8th grade math to Pre-Algebra
Utah_Data_LONG <- data.table(Utah_Data_LONG)
Utah_Data_LONG[which(CONTENT_AREA == 'MATHEMATICS' & GRADE == 8 & YEAR == 2013), GRADE := 'EOCT']
Utah_Data_LONG[which(CONTENT_AREA == 'MATHEMATICS' & GRADE == 'EOCT' & YEAR == 2013), CONTENT_AREA := 'PRE_ALGEBRA']
table(Utah_Data_LONG$GRADE, Utah_Data_LONG$CONTENT_AREA, Utah_Data_LONG$YEAR, Utah_Data_LONG$VALID_CASE)

###
###  Prepare SGP Object:
###

Utah_SGP <- prepareSGP(Utah_Data_LONG)

save(Utah_SGP, file="Utah_SGP.Rdata")


##########################################################################
##############################################################
####	analyzeSGP
##############################################################
##########################################################################

###
###  Grade level tests as usual with content areas specified:
###

Utah_SGP <- analyzeSGP(Utah_SGP,
						years=c('2011', '2012', '2013'),
						content_areas=c("ELA", "MATHEMATICS", "SCIENCE"),
						grades=3:11,
						sgp.percentiles.baseline=FALSE,
						sgp.projections.baseline= FALSE,
						sgp.projections.lagged.baseline=FALSE,
						simulate.sgps=FALSE,
						parallel.config=list(
							BACKEND="PARALLEL", 
							WORKERS=list(PERCENTILES=22, PROJECTIONS=18, LAGGED_PROJECTIONS=12)))


###
###		EOCT Analyses specified analyses with MAX priors available
###

### Load and create 2011 and 2012 EOCT Configuration
source("SGP_CONFIG/EOCT/2011/MATHEMATICS.R") # assuming you have SGP_CONFIG directory in your working directory
source("SGP_CONFIG/EOCT/2011/SCIENCE.R")

source("SGP_CONFIG/EOCT/2012/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2012/SCIENCE.R")

source("SGP_CONFIG/EOCT/2013/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2013/SCIENCE.R")

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
		ALGEBRA_II_2012.config,
				
		EARTH_SCIENCE_2013.config, 
		BIOLOGY_2013.config, 
		CHEMISTRY_2013.config, 
		PHYSICS_2013.config,
		PRE_ALGEBRA_2013.config,
		ALGEBRA_I_2013.config, 
		GEOMETRY_2013.config,
		ALGEBRA_II_2013.config)
		

Utah_SGP <- analyzeSGP(Utah_SGP,
						sgp.config=UT.config,
						sgp.percentiles=TRUE,
						sgp.projections=FALSE,
						sgp.projections.lagged=FALSE,
						sgp.percentiles.baseline=FALSE,
						sgp.projections.baseline= FALSE,
						sgp.projections.lagged.baseline=FALSE,
						simulate.sgps=FALSE,
						parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=14)))


#############################################################################
##############################################################
### 		 combineSGP
##############################################################
#############################################################################

Utah_SGP <- combineSGP(Utah_SGP) 
						
#############################################################################
##############################################################
###  		summarizeSGP  
##############################################################
#############################################################################

Utah_SGP <- summarizeSGP(Utah_SGP, parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SUMMARY=14)))

save(Utah_SGP, file="Utah_SGP.Rdata")

#############################################################################
##############################################################
###  	Output results to text files
##############################################################
#############################################################################

###  Data and Results
outputSGP(Utah_SGP, output.type=c("LONG_Data", "WIDE_Data")

###  Summary Tables
#  This series of code 1) eliminates NA's in the ACH_LEVEL_PRIOR field, 2) removes an unwanted field, 3) sorts/keys the table, & 4) saves it.

#For All Students
s <-Utah_SGP@Summary$SCHOOL_NUMBER$SCHOOL_NUMBER__EMH_LEVEL__CONTENT_AREA__YEAR__SCHOOL_ENROLLMENT_STATUS
s$PERCENT_AT_ABOVE_PROFICIENT_PRIOR_COUNT <- NULL
setkeyv(s,c("SCHOOL_NUMBER", "CONTENT_AREA"))
write.csv(s, file="SCHOOL_NUMBER__YEAR__CONTENT_AREA__EMH_LEVEL__SCHOOL_ENROLLMENT_STATUS.csv", row.names=FALSE)

#For Below Proficient Students
s <- Utah_SGP@Summary$SCHOOL_NUMBER$SCHOOL_NUMBER__EMH_LEVEL__CONTENT_AREA__YEAR__ACHIEVEMENT_LEVEL_PRIOR__SCHOOL_ENROLLMENT_STATUS[!is.na(ACHIEVEMENT_LEVEL_PRIOR)]
s$PERCENT_AT_ABOVE_PROFICIENT_PRIOR_COUNT <- NULL
setkeyv(s, c("SCHOOL_NUMBER", "CONTENT_AREA"))
write.csv(s, file="SCHOOL_NUMBER__EMH_LEVEL__CONTENT_AREA__YEAR__ACHIEVEMENT_LEVEL_PRIOR__SCHOOL_ENROLLMENT_STATUS.csv", row.names=FALSE)


#############################################################################
##############################################################
### 		 visualizeSGP
##############################################################
#############################################################################

visualizeSGP(Utah_SGP,
	state="UT",
	plot.types="studentGrowthPlot",
	sgPlot.demo.report=TRUE,
	sgPlot.produce.plots=TRUE,
	parallel.config=list(
	BACKEND="PARALLEL", 
	WORKERS=list(SG_PLOTS=6)))
