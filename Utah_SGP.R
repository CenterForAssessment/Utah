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
load("Utah_Data_LONG-2013_FINAL.Rdata")

###
###  Prepare SGP Object:
###

Utah_SGP <- prepareSGP(Utah_Data_LONG)

###  Save data object.
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
###		EOCT Analyses specified analyses
###

### Load and create 2011, 2012 & 2013 EOCT Configuration

source("SGP_CONFIG/EOCT/2011/MATHEMATICS.R")
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

outputSGP(Utah_SGP, output.type=c("LONG_Data", "WIDE_Data")

#############################################################################
##############################################################
### 		 visualizeSGP
##############################################################
#############################################################################

# visualizeSGP(Utah_SGP,
	# plot.types="studentGrowthPlot",
	# sgPlot.demo.report=TRUE,
	# sgPlot.produce.plots=TRUE,
	# parallel.config=list(
	# BACKEND="PARALLEL", 
	# WORKERS=list(SG_PLOTS=6)))

visualizeSGP(Utah_SGP,
	plot.types="growthAchievementPlot",
	gaPlot.content_areas=c("ELA", "MATHEMATICS", "SCIENCE"),
	gaPlot.years=c("2011", "2012", "2013"),
	gaPlot.format="presentation",
	parallel.config=list(
		BACKEND="PARALLEL", 
		WORKERS=list(GA_PLOTS=6)))
