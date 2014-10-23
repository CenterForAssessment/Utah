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
# SGPstateData.R
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
install_github('SGP','SchoolView')
require(SGP)
require(car)
require(foreign)
require(data.table)

# 5. CONNECT TO WAREHOUSE AND EXTRACT INPUT DATA
require(RODBC)
dbhandle <- odbcDriverConnect('driver={SQL Server}; server=acsdbstage; database=be_upass;')
UT_2014_LONG <- sqlQuery(dbhandle, 'SELECT * FROM v_sgp_longfile')
save(UT_2014_LONG, file = 'Utah_Data_LONG.Rdata')

# 6. TRANSFORM PROFICIENCY LEVEL VARIABLES TO R FACTORS
load("Utah_Data_LONG.Rdata")
Utah_Data_LONG <- data.frame(Utah_Data_LONG)
Utah_Data_LONG$ACHIEVEMENT_LEVEL <- factor(Utah_Data_LONG$ACHIEVEMENT_LEVEL, levels=1:4, labels=c("Level 1", "Level 2", "Level 3", "Level 4"), ordered=TRUE)
Utah_Data_LONG$ACHIEVEMENT_LEVEL_FULL <- Utah_Data_LONG$ACHIEVEMENT_LEVEL levels(Utah_Data_LONG$ACHIEVEMENT_LEVEL) <- c("BP", "BP", "P", "A")
save(Utah_Data_LONG, file="Utah_Data_LONG.Rdata")

# 7. CONSTRUCT SGP (S4) DATA OBJECT, PUTTING LONG DATA INTO @data SLOT:
Utah_SGP <- prepareSGP(Utah_Data_LONG, state = "UT")
save(Utah_SGP, file="Utah_SGP.Rdata")

# 8. PRODUCE SGP FOR GRADE-BASED TESTS
Utah_SGP <- analyzeSGP(
Utah_SGP,
state = 'UT',
years=c('2014'),
content_areas=c("ELA", "MATHEMATICS", "SCIENCE"),
grades=3:11,
simulate.sgps=FALSE,
parallel.config=list(BACKEND="PARALLEL",WORKERS=list(PERCENTILES=22,PROJECTIONS=18,LAGGED_PROJECTIONS=12)),
verbose.output=TRUE) # Verbose diagnostic messages

# 9. LOAD 2014 EOCT FILES CONFIGURATION:
source("MATHEMATICS.R")
source("SCIENCE.R")

# 10. CONSTRUCT CONFIGURATION FILE:
UT.config <- c(
EARTH_SCIENCE_2014.config, 
BIOLOGY_2014.config, 
CHEMISTRY_2014.config, 
PHYSICS_2014.config,
SECONDARY_MATH_I_2014.config,
SECONDARY_MATH_II_2014.config,
SECONDARY_MATH_III_2014.config)

# 11. PRODUCE SGP FOR COURSE-BASED TESTS
Utah_SGP <- analyzeSGP(
Utah_SGP,
sgp.config=UT.config,
simulate.sgps=FALSE,
parallel.config=list(BACKEND="PARALLEL",WORKERS=list(PERCENTILES=20)))
save(Utah_SGP, file="Utah_SGP.Rdata")

# 12. MERGE LONG DATA WITH SGP RESULTS AND CACULATE GROWTH-TO-STANDARD (GTS) TARGETS AND STATUS INDICATORS
Utah_SGP <- combineSGP(
Utah_SGP,
max.sgp.target.years.forward=3) # Project forward three years from the lagged (2013) score for GTS calculations
parallel.config=NULL # Parallel configuration only used when sgp.target.scale.scores is set to TRUE
save(Utah_SGP, file="Utah_SGP.Rdata")

# 13. CALCULATE SUMMARY STATISTICS TO BE STORED IN DATA OBJECT AND USED ELSEWHERE IN APPLICATION
Utah_SGP <- summarizeSGP(
Utah_SGP,
parallel.config=list(BACKEND="PARALLEL",WORKERS=list(SUMMARY=14)))
save(Utah_SGP, file="Utah_SGP.Rdata")

# 14. EXPORT DATA FROM SGP OBJECT @Data SLOT AS PIPE-DELIMITED FILE IN VARIOUS FORMATS
outputSGP(
Utah_SGP,
output.type = c("LONG_Data", "WIDE_Data", "SchoolView"),
outputSGP.directory = "Data")

# 15. LOAD SGP OUTPUT INTO DATA WAREHOUSE
# SGP/Data/LONG_Data.txt -> be_upass.acsdbstage.sgp_raw

# 16. CONSTRUCT INDIVIDUAL STUDENT REPORT (STUDENT GROWTH PLOTS)
# This may be commented out in the initial run
visualizeSGP(
Utah_SGP,
state = "UT",
plot.types = c("studentGrowthPlot"),
sgPlot.save.sgPlot.data = TRUE,
sgPlot.front.page = "AD_SGP_GUIDE.pdf", # Serves as introduction to the report
sgPlot.cleanup = FALSE, # If not set to FALSE, all reports will be deleted on completion of run
sgPlot.produce.plots = TRUE,
sgPlot.zip = TRUE,
parallel.config=list(TYPE="SOCK",BACKEND="PARALLEL",WORKERS=2))