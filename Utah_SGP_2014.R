# 1. APPLICATIONS AND FILES TO LOAD ON SGP SERVER (D:/SGP/)
##### SGP documentation:
# http://cran.r-project.org/web/packages/SGP/SGP.pdf
##### Statistical software and development environment:
# R
# RStudio
##### Input data:
# v_sgp_longfile.sql (part of stored procedure in be_upass.acsdbstage)
##### High level controlling code:
# UTAH_SGP_2014.R (this file)	
##### Valid course sequences:
# MATHEMATICS.R
# SCIENCE.R
##### Knots, boundaries, cutscores, etc.:
# SGPstateData.R (AVI: This meta-data will be included in an updated version of the SGP package)
##### To construct individual student growth plot report:
# MiKTeX
#	AD_SGP_GUIDE.pdf

# 2. FILES THAT WILL BE CREATED BY SGP (SGP/):
# Utah_Data_LONG.Rdata
# Utah_SGP.Rdata
##### Data/
# Utah_SGP_LONG_Data.txt
# Utah_SGP_WIDE_Data.txt
# SchoolView/ ["Tables used for representation in SchoolView"]
##### Visualizations/studentGrowthPlots/
# Default folder structure for PDF output of visualizeSGP(),
# with one subfolder for each school labeled by school_id
# and one file for each student labeled by ssid

# 3. SET WORKING DIRECTORY
setwd("D:/SGP")

# 4. LOAD REQUIRED PACKAGES
install.packages('devtools')
require(devtools) # Provides the install function for GitHub
install_github('centerforassessment/SGP')
require(SGP)
require(data.table)

# 5. CONNECT TO WAREHOUSE AND EXTRACT INPUT DATA
#    Note: This input data should consist on only the new 2014 data to be added to the data extracted in 2013.
require(RODBC)
dbhandle <- odbcDriverConnect('driver={SQL Server}; server=acsdbstage; database=be_upass;')
Utah_Data_LONG_2014 <- sqlQuery(dbhandle, 'SELECT * FROM v_sgp_longfile')
Utah_Data_LONG_2014 <- data.frame(Utah_Data_LONG_2014) # This step may be redundant?  Check the class first to see if it is already a data.frame:  class(Utah_Data_LONG_2014)
write.csv(Utah_Data_LONG_2014, file='SGP_Longfile_2.csv', row.names=FALSE)

# 6. DATA CLEANING AND PREP
#    SEE THE R SCRIPT Utah_Data_LONG_2014.R FOR DETAILS.

# 7. USE updateSGP FUNCTION TO A) ADD 2014 LONG DATA TO THE EXISTING SGP (S4) DATA OBJECT (prepareSGP step) and B) PRODUCE SGP FOR GRADE-BASED TESTS (analyzeSGP step):
load("Utah_SGP.Rdata") # This is the SGP object Andrew produced in Fall 2013 and cleaned in Utah_Data_LONG_2014.R
load("Utah_Data_LONG_2014.Rdata") # This is the 2014 data object produced in Utah_Data_LONG_2014.R

Utah_SGP <- updateSGP(
		what_sgp_object = Utah_SGP,
		with_sgp_data_LONG = Utah_Data_LONG_2014,
		content_areas=c("ELA", "MATHEMATICS", "SCIENCE"),
		years='2014',
		grades=3:11,
		steps = c("prepareSGP", "analyzeSGP"),
		sgp.percentiles = TRUE,
		sgp.projections = FALSE,
		sgp.projections.lagged = FALSE,
		sgp.percentiles.baseline = FALSE,
		sgp.projections.baseline = FALSE,
		sgp.projections.lagged.baseline = FALSE,
		simulate.sgps=FALSE,
		save.intermediate.results=FALSE,
		goodness.of.fit.print="GROB",
		parallel.config=list(BACKEND="FOREACH", TYPE="doParallel", WORKERS=list(PERCENTILES=12)))

# 8. LOAD 2014 EOCT FILES CONFIGURATION:
source("MATHEMATICS.R")
source("SCIENCE.R")

# 9. CONSTRUCT LIST FOR sgp.config ARGUMENT FROM CONFIGURATION FILES:
UT.config <- c(
EARTH_SCIENCE_2014.config, 
BIOLOGY_2014.config, 
CHEMISTRY_2014.config, 
PHYSICS_2014.config,
SEC_MATH_I_2014.config,
SEC_MATH_II_2014.config,
SEC_MATH_III_2014.config)

# 10. PRODUCE SGP FOR COURSE-BASED TESTS
Utah_SGP <- analyzeSGP(
Utah_SGP,
sgp.config=UT.config,
simulate.sgps=FALSE,
sgp.projections = FALSE,
sgp.projections.lagged = FALSE,
sgp.percentiles.baseline = FALSE,
sgp.projections.baseline = FALSE,
sgp.projections.lagged.baseline = FALSE,
parallel.config=list(BACKEND="FOREACH", TYPE="doParallel", WORKERS=list(PERCENTILES=12)))

save(Utah_SGP, file="Utah_SGP.Rdata")

# 11. MERGE LONG DATA WITH SGP RESULTS
Utah_SGP <- combineSGP(
Utah_SGP,
years='2014',
sgp.projections = FALSE,
sgp.projections.lagged = FALSE,
sgp.percentiles.baseline = FALSE,
sgp.projections.baseline = FALSE,
sgp.projections.lagged.baseline = FALSE)
# max.sgp.target.years.forward=3) # There are no lagged projections due to assessment program change
# parallel.config=NULL # Parallel configuration only used when sgp.target.scale.scores is set to TRUE
save(Utah_SGP, file="Utah_SGP.Rdata")

# 12. CALCULATE SUMMARY STATISTICS TO BE STORED IN DATA OBJECT AND USED ELSEWHERE IN APPLICATION
Utah_SGP <- summarizeSGP(
Utah_SGP,
parallel.config=list(BACKEND="FOREACH", TYPE="doParallel", WORKERS=list(SUMMARY=14)))
save(Utah_SGP, file="Utah_SGP.Rdata")

# 13. EXPORT DATA FROM SGP OBJECT @Data SLOT AS PIPE-DELIMITED FILE IN VARIOUS FORMATS
outputSGP(
Utah_SGP,
output.type = c("LONG_Data", "WIDE_Data"))

# 14. LOAD SGP OUTPUT INTO DATA WAREHOUSE
# SGP/Data/Utah_SGP_LONG_Data.txt -> be_upass.acsdbstage.sgp_raw

# 15. CONSTRUCT INDIVIDUAL STUDENT REPORT (STUDENT GROWTH PLOTS)
# This may be commented out in the initial run
visualizeSGP(
Utah_SGP,
state = "UT",
plot.types = c("studentGrowthPlot"),
sgPlot.save.sgPlot.data = TRUE,
sgPlot.front.page = "AD_SGP_GUIDE.pdf", # Serves as introduction to the report
# sgPlot.cleanup = FALSE, # If not set to FALSE, all reports will be deleted on completion of run.  This shouldn't be an issue with MiKTeX installed.
sgPlot.produce.plots = TRUE,
sgPlot.zip = TRUE,
parallel.config=list(BACKEND="FOREACH", TYPE="doParallel", WORKERS=20))
