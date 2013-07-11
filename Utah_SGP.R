#############################################################################
#############################################################################
####
####          Create 2011 & 2012 SGPs for Utah
####
#############################################################################
#############################################################################

### Load required libraries
library(SGP)

### Load Data and Specialized Functions:
load("Utah_Data_LONG.Rdata")

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


### Load required libraries
library(SGP)

load("Utah_SGP.Rdata")


#  This call to analyzeSGP runs both percentiles and lagged projections.  Some times I run these separately 
#  to ease memory use issues (set each one to TRUE individually and then re-run analyzeSGP).

Utah_SGP <- analyzeSGP(Utah_SGP,
                       state="UT",
                       years=2010:2012,
                       sgp.percentiles=TRUE,
                       sgp.projections= TRUE,
                       sgp.projections.lagged = TRUE, 
                       sgp.percentiles.baseline=FALSE,
                       sgp.projections.baseline = FALSE,
                       sgp.projections.lagged.baseline= FALSE,
                       simulate.sgps=FALSE,
                       parallel.config=list(
                           BACKEND="PARALLEL", #TYPE="SNOW", # SNOW works for Windows.
                           WORKERS=list(PERCENTILES=6, PROJECTIONS=4, LAGGED_PROJECTIONS=3)))


#############################################################################
##############################################################
### 		 combineSGP
##############################################################
#############################################################################

Utah_SGP <- combineSGP(Utah_SGP) 
						
save(Utah_SGP, file="Utah_SGP.Rdata")


#############################################################################
##############################################################
###  		summarizeSGP  
##############################################################
#############################################################################

Utah_SGP <- summarizeSGP(Utah_SGP, parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SUMMARY=8)))

save(Utah_SGP, file="Utah_SGP.Rdata", compress="bzip2")


#############################################################################
###  	Output results to text files
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
	

visualizeSGP(Utah_SGP,
	state="UT",
	plot.types="studentGrowthPlot",
	sgPlot.schools=c(132,168),
	sgPlot.produce.plots=TRUE,
	parallel.config=list(
	BACKEND="PARALLEL", 
	WORKERS=list(SG_PLOTS=6)))


