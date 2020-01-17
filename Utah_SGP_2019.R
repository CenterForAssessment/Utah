################################################################
###                                                          ###
###              Calculate SGPs for Utah - 2019              ###
###                                                          ###
################################################################

# 1. APPLICATIONS AND FILES TO LOAD ON SGP SERVER (D:/SGP/)
##### SGP documentation:
# http://cran.r-project.org/web/packages/SGP/SGP.pdf
##### Statistical software and development environment:
# R
# RStudio
##### Input data:
# v_sgp_longfile_20190811 - SY2019 - 2019 Accountability Only.sql (part of stored procedure in be_upass.acsdbstage)
##### High level controlling code:
# UTAH_SGP_2019.R (this file)
##### Valid course sequences:
# MATHEMATICS.R
# SCIENCE.R
##### Knots, boundaries, cutscores, etc.:
# SGPstateData.R (AVI: This meta-data will be included in an updated version of the SGP package)
##### To construct individual student growth plot report:
# MiKTeX
#	AD_SGP_GUIDE.pdf


# 2. FILES THAT WILL BE CREATED IN THE SGP PACKAGE (SGP/):
# Utah_Data_LONG_2019.Rdata
# Utah_SGP.Rdata
##### Data/
# Utah_SGP_LONG_Data.txt
# Utah_SGP_LONG_Data_2019.txt
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
require(data.table)

# 5. CONNECT TO WAREHOUSE AND EXTRACT INPUT DATA

##    Note: This process was conducted by USOE for 2019 data pull from warehouse.
##	  		The code below has not been verified, but is a leftover from 2014 code.

##    Note: This input data should consist of only the new 2019 data to be added to the data extracted in prior years.
##    	   In 2019 this also includes non_FAY student data from 2008-2014.

# require(RODBC)
# dbhandle <- odbcDriverConnect('driver={SQL Server}; server=acsdbstage; database=be_upass;')

# Utah_Data_LONG_2019 <- sqlQuery(dbhandle, 'SELECT * FROM v_sgp_longfile_20190811 - SY2019 - 2019 Accountability Only')

# write.csv(Utah_Data_LONG_2019, file='SGP_Longfile_2019.csv', row.names=FALSE)


# 6. DATA CLEANING AND PREP
#    SEE THE R SCRIPT Utah_Data_LONG_2019.R FOR DETAILS.

####
####
####

# 7. CALCULATE SGPs  --  2019 FAY and NON-FAY together
# 	USE updateSGP FUNCTION TO
#		A) ADD LONG DATA TO THE EXISTING SGP (S4) DATA OBJECT (prepareSGP step) and
#		B) PRODUCE SGP FOR BOTH GRADE-BASED AND EOCT TESTS (analyzeSGP step):


#   Load the 2014 - 2018 SAGE Data
load("./Data/Utah_SGP_LONG_Data-SAGE_ONLY_with_Demographics.Rdata")

#   Load the 2019 formatted data
load("./Data/Utah_Data_LONG_2019.Rdata")
# Utah_Data_LONG_2019[is.na(ACHIEVEMENT_LEVEL_FULL), VALID_CASE := "INVALID_CASE"]
Utah_Data_LONG_2019[GRADE %in% 3:8 & ACHIEVEMENT_LEVEL_FULL != ACHIEVEMENT_LEVEL, VALID_CASE := "INVALID_CASE"]
table(Utah_Data_LONG_2019[, VALID_CASE, GRADE])

# #   Trim down for RISE/Aspire Plus Analayses
# vars.to.keep <- union(names(Utah_Data_LONG_2019), grep("SGP|SCALE_SCORE|CATCH_UP|MOVE_UP", names(Utah_SGP@Data), value=TRUE))
# Utah_SGP@Data <- Utah_SGP@Data[YEAR %in% 2013:2018, vars.to.keep, with=FALSE]
# Utah_SGP@SGP <- NULL
# Utah_SGP@Summary <- NULL
# gc()

###
##   2019 Analyses - RISE Assessments only due to data delivery timeframe
###

# source("SGP_CONFIG/UT_2019.R")
# source("/Users/avi/Dropbox (SGP)/Github_Repos/Projects/Utah/SGP_CONFIG/UT_2019.R")
# source("/media/Data/Dropbox (SGP)/Github_Repos/Projects/Utah/sgp_config/UT_2019.R")

# UT_2019.config <- c(
# 	ELA_2019.config,
# 	MATHEMATICS_2019.config,
# 	SCIENCE_2019.config)

setwd("/Users/avi/Data/UT")
setwd("/media/Data/UT")

# SGPstateData[["UT"]][["SGP_Configuration"]][["sgp.projections.use.only.complete.matrices"]] <- FALSE
# SGPstateData[["UT"]][["SGP_Configuration"]][["sgp.cohort.size"]] <- 2000
# SGPstateData[["UT"]][["SGP_Configuration"]][["sgp.less.than.sgp.cohort.size.return"]] <- "<2000"

# SGPstateData[["UT"]][["SGP_Configuration"]][["content_area.projection.sequence"]] <- NULL
# SGPstateData[["UT"]][["SGP_Configuration"]][["grade.projection.sequence"]] <- NULL
# SGPstateData[["UT"]][["SGP_Configuration"]][["year_lags.projection.sequence"]] <- NULL


#####
##   Run analyses - add 2019 data through prepareSGP step and
##   calculate percentiles and projections through analyzeSGP step
#####

##   Set BIOLOGY priors to INVALID (Run EARTH_SCIENCE prior analyses first)
Utah_SGP_LONG_Data[CONTENT_AREA_ACTUAL == "BIOLOGY", VALID_CASE := "INVALID_CASE"]

Utah_SGP <- abcSGP(
	state="UT",
	sgp_object = rbindlist(list(Utah_SGP_LONG_Data, Utah_Data_LONG_2019), fill=TRUE),
	steps = c("prepareSGP", "analyzeSGP"), # , "combineSGP", "outputSGP"
	# sgp.config = UT_2019.config,
	years='2019',
	content_areas=c("ELA", "MATHEMATICS", "SCIENCE"),
	sgp.percentiles = TRUE,
	sgp.projections = TRUE,
	sgp.projections.lagged = TRUE,
	sgp.percentiles.baseline = FALSE,
	sgp.projections.baseline = FALSE,
	sgp.projections.lagged.baseline = FALSE,
	sgp.percentiles.equated = TRUE,
	simulate.sgps=FALSE,
	# sgp.target.scale.scores = TRUE,
	# outputSGP.output.type = c("LONG_FINAL_YEAR_Data"),
	parallel.config = list(
		BACKEND="PARALLEL", WORKERS=list(TAUS=12)))
			# WORKERS=list(PERCENTILES=10, PROJECTIONS = 10, LAGGED_PROJECTIONS = 4, SGP_SCALE_SCORE_TARGETS=4))
# )

save(Utah_SGP, file="Data/Utah_SGP.Rdata")

#####
###   SCIENCE Grade 10 with 2018 BIOLOGY prior
#####

options(warn=0)
require(SGP)
require(data.table)

###  Modify @Data for analysis with BIOLOGY priors
Utah_SGP@Data[CONTENT_AREA_ACTUAL == "BIOLOGY", VALID_CASE := "VALID_CASE"]
Utah_SGP@Data[CONTENT_AREA_ACTUAL == "EARTH_SCIENCE", VALID_CASE := "INVALID_CASE"]
Utah_SGP@Data[, SCALE_SCORE_EQUATED := NULL]

setkeyv(Utah_SGP@Data, SGP:::getKey(Utah_SGP@Data))

# names(Utah_SGP@SGP[["Coefficient_Matrices"]])[c(1,4)] <- c("SCIENCE_EARTH_SCIENCE.2019", "SCIENCE_EARTH_SCIENCE.2019.EQUATED")
Utah_SGP@SGP[["Coefficient_Matrices"]][["SCIENCE_EARTH_SCIENCE.2019"]] <- Utah_SGP@SGP[["Coefficient_Matrices"]][["SCIENCE.2019"]][1:5]
Utah_SGP@SGP[["Coefficient_Matrices"]][["SCIENCE_EARTH_SCIENCE.2019.EQUATED"]] <- Utah_SGP@SGP[["Coefficient_Matrices"]][["SCIENCE.2019.EQUATED"]][1:5]
Utah_SGP@SGP[["Coefficient_Matrices"]][["SCIENCE.2019"]] <- Utah_SGP@SGP[["Coefficient_Matrices"]][["SCIENCE.2019"]][-(1:5)]
Utah_SGP@SGP[["Coefficient_Matrices"]][["SCIENCE.2019.EQUATED"]] <- Utah_SGP@SGP[["Coefficient_Matrices"]][["SCIENCE.2019.EQUATED"]][-(1:5)]

# names(Utah_SGP@SGP[["Linkages"]])[3] <- "SCIENCE_EARTH_SCIENCE.2019"
Utah_SGP@SGP[["Linkages"]][["SCIENCE_EARTH_SCIENCE.2019"]] <- Utah_SGP@SGP[["Linkages"]][["SCIENCE.2019"]][6]
Utah_SGP@SGP[["Linkages"]][["SCIENCE.2019"]] <- Utah_SGP@SGP[["Linkages"]][["SCIENCE.2019"]][1:5]

Utah_SGP@SGP[["SGPercentiles"]][["SCIENCE.2019"]][, SGP_NORM_GROUP := gsub("2018/SCIENCE_9", "2018/EARTH_SCIENCE_9", SGP_NORM_GROUP)]
Utah_SGP@SGP[["SGPercentiles"]][["SCIENCE.2019.EQUATED"]][, SGP_NORM_GROUP_EQUATED := gsub("2018/SCIENCE_9", "2018/EARTH_SCIENCE_9", SGP_NORM_GROUP_EQUATED)]
Utah_SGP@SGP[["SGPercentiles"]][["SCIENCE.2019"]]$PREFERENCE <- 1L
Utah_SGP@SGP[["SGPercentiles"]][["SCIENCE.2019.EQUATED"]]$PREFERENCE <- 1L

Utah_SGP@SGP[["SGProjections"]][["SCIENCE.2019.LAGGED"]][GRADE==10, SGP_PROJECTION_GROUP := "ESCI_SCIENCE"]
Utah_SGP@SGP[["Knots_Boundaries"]] <- NULL # [["SCIENCE.2019"]]
# SGPstateData[["UT"]][["Achievement"]][["Knots_Boundaries"]][["SCIENCE.2019"]] <- NULL

###  Knots, Boundaries and Cutscores for Biology
SGPstateData[["UT"]][["Achievement"]][["Knots_Boundaries"]][["SCIENCE.2014"]][["knots_9"]] <- c(806, 826, 840, 857)
SGPstateData[["UT"]][["Achievement"]][["Knots_Boundaries"]][["SCIENCE.2014"]][["boundaries_9"]]<- c(615, 1030) # Same
SGPstateData[["UT"]][["Achievement"]][["Knots_Boundaries"]][["SCIENCE.2014"]][["loss.hoss_9"]] <- c(650, 999)  # Same
SGPstateData[["UT"]][["Achievement"]][["Cutscores"]][["SCIENCE.2014"]][["GRADE_9"]] <- c(840, 858)

# load("UT_Knots_Boundaries.Rdata")
# NULL out and start fresh ???
SGPstateData[["UT"]][["Achievement"]][["Knots_Boundaries"]][["ELA.2019"]] <- NULL # UT_Knots_Boundaries[["ELA.2019"]]
SGPstateData[["UT"]][["Achievement"]][["Knots_Boundaries"]][["SCIENCE.2019"]] <- NULL # UT_Knots_Boundaries[["SCIENCE.2019"]]
SGPstateData[["UT"]][["Achievement"]][["Knots_Boundaries"]][["MATHEMATICS.2019"]] <- NULL # UT_Knots_Boundaries[["MATHEMATICS.2019"]]

###  Biology based SCIENCE config
SCIENCE_2019.config <- list(
	SCIENCE.2019 = list(
		sgp.content.areas=rep('SCIENCE', 6),
		sgp.panel.years=as.character(2014:2019),
		sgp.grade.sequences=list(c('5', '6', '7', '8', '9', '10')),
		sgp.norm.group.preference=2,
		sgp.projection.sequence = "BIO_SCIENCE"
	)
)

table(Utah_SGP@Data[, YEAR, CATCH_UP_KEEP_UP_STATUS_3_YEAR])

Utah_SGP <- analyzeSGP(
	Utah_SGP,
	years='2019',
	sgp.config = SCIENCE_2019.config,
	sgp.percentiles = TRUE,
	sgp.projections = FALSE,
	sgp.projections.lagged = TRUE,
	sgp.percentiles.baseline = FALSE,
	sgp.projections.baseline = FALSE,
	sgp.projections.lagged.baseline = FALSE,
	sgp.percentiles.equated = TRUE,  ###  XXX  Have to re-do in order to get projections...
	simulate.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config = list(
		BACKEND="PARALLEL", WORKERS=list(TAUS=12)))
)

table(Utah_SGP@SGP[["SGPercentiles"]][["SCIENCE.2019"]][, PREFERENCE])
table(Utah_SGP@SGP[["SGProjections"]][["SCIENCE.2019.LAGGED"]][, SGP_PROJECTION_GROUP, GRADE]) # BIO_SCIENCE inserted through config
# Utah_SGP@SGP[["SGProjections"]][["SCIENCE.2019.LAGGED"]][GRADE==10 & SGP_PROJECTION_GROUP == "SCIENCE", SGP_PROJECTION_GROUP := "BIO_SCIENCE"]

table(grep("2018/SCIENCE_9", Utah_SGP@SGP[["SGPercentiles"]][["SCIENCE.2019"]][, SGP_NORM_GROUP], value=TRUE))
table(grep("2018/EARTH_SCIENCE_9", Utah_SGP@SGP[["SGPercentiles"]][["SCIENCE.2019"]][, SGP_NORM_GROUP], value=TRUE))

Utah_SGP@SGP[["SGPercentiles"]][["SCIENCE.2019"]][, SGP_NORM_GROUP := gsub("2018/SCIENCE_9", "2018/BIOLOGY_9", SGP_NORM_GROUP)]
Utah_SGP@SGP[["SGPercentiles"]][["SCIENCE.2019.EQUATED"]][, SGP_NORM_GROUP_EQUATED := gsub("2018/SCIENCE_9", "2018/BIOLOGY_9", SGP_NORM_GROUP_EQUATED)]
table(grep("2018/SCIENCE_9", Utah_SGP@Data[, SGP_NORM_GROUP], value=TRUE))

###  Cludge for Leslie
# names(Utah_SGP@SGP[["SGPercentiles"]])[c(1,5,6)] <- c("SCIENCE.2019.COHORT", "MATHEMATICS.2019.COHORT", "ELA.2019.COHORT")
# names(Utah_SGP@SGP[["SGPercentiles"]])[2:4] <- c("SCIENCE.2019", "MATHEMATICS.2019", "ELA.2019")
# for (ca in 2:4) setnames(Utah_SGP@SGP[["SGPercentiles"]][[ca]], gsub("_EQUATED", "", names(Utah_SGP@SGP[["SGPercentiles"]][[ca]])))
#
# names(Utah_SGP@SGP[["SGProjections"]][[1]]) # No changes needed

# SGPstateData[["UT"]][['SGP_Progression_Preference']] <- data.table(
# 	SGP_PROJECTION_GROUP = c("ESCI_SCIENCE", "BIO_SCIENCE"),
# 	PREFERENCE = c(1,2), key = "SGP_PROJECTION_GROUP")

# Utah_SGP@Data[, grep("SGP|SCALE_SCORE|CATCH_UP|MOVE_UP", names(Utah_SGP@Data), value=TRUE) := NULL]
Utah_SGP@Data[, VALID_CASE := "VALID_CASE"]
setkeyv(Utah_SGP@Data, SGP:::getKey(Utah_SGP@Data))

Utah_SGP <- combineSGP(Utah_SGP, years='2019', sgp.percentiles.equated=TRUE) # FALSE for Cludge

table(Utah_SGP@Data[, YEAR, CATCH_UP_KEEP_UP_STATUS_3_YEAR])

# for cludge rerun
# setnames(Utah_SGP@Data, c("SGP", "CATCH_UP_KEEP_UP_STATUS_3_YEAR"), c("ORIG", "CUKU_ORIG"))
# table(Utah_SGP@Data[, CUKU_ORIG, CATCH_UP_KEEP_UP_STATUS_3_YEAR])

save(Utah_SGP, file="Data/Utah_SGP-FINAL.Rdata")
outputSGP(Utah_SGP, output.type="LONG_FINAL_YEAR_Data")

Utah_SGP@Data[YEAR=='2019', as.list(summary(SGP)), keyby = c("CONTENT_AREA", "GRADE")]

table(Utah_SGP@Data[YEAR=='2019', is.na(SGP_TARGET_3_YEAR), CONTENT_AREA])
table(Utah_SGP@Data[YEAR=='2019' & is.na(SGP_TARGET_3_YEAR), CONTENT_AREA, GRADE])

table(Utah_SGP@Data[YEAR=='2019', SGP_TARGET_3_YEAR <= SGP, CATCH_UP_KEEP_UP_STATUS_3_YEAR])
table(Utah_SGP@Data[YEAR=='2019', SGP_TARGET_3_YEAR <= SGP_EQUATED, CATCH_UP_KEEP_UP_STATUS_3_YEAR])
table(Utah_SGP@Data[YEAR=='2019' & SGP_TARGET_3_YEAR > SGP_EQUATED, CATCH_UP_KEEP_UP_STATUS_3_YEAR, GRADE])
table(Utah_SGP@Data[YEAR=='2019' & SGP_TARGET_3_YEAR > SGP_EQUATED, CATCH_UP_KEEP_UP_STATUS_3_YEAR, ACHIEVEMENT_LEVEL])

table(Utah_SGP@Data[YEAR=='2019' & SGP_TARGET_3_YEAR > SGP & CATCH_UP_KEEP_UP_STATUS_3_YEAR == "Catch Up: Yes", ACHIEVEMENT_LEVEL, ACHIEVEMENT_LEVEL_PRIOR])
table(Utah_SGP@Data[YEAR=='2019' & SGP_TARGET_3_YEAR <= SGP & CATCH_UP_KEEP_UP_STATUS_3_YEAR == "Keep Up: No", ACHIEVEMENT_LEVEL, ACHIEVEMENT_LEVEL_PRIOR])
table(Utah_SGP@Data[YEAR=='2019' & SGP_TARGET_3_YEAR > SGP & CATCH_UP_KEEP_UP_STATUS_3_YEAR == "Catch Up: Yes", CONTENT_AREA, GRADE])
table(Utah_SGP@Data[YEAR=='2019' & SGP_TARGET_3_YEAR <= SGP & CATCH_UP_KEEP_UP_STATUS_3_YEAR == "Keep Up: No", CONTENT_AREA, GRADE])

Utah_SGP@Data[YEAR=='2019' & SGP_TARGET_3_YEAR <= SGP & CATCH_UP_KEEP_UP_STATUS_3_YEAR == "Keep Up: No", # & CONTENT_AREA == "SCIENCE",
								as.list(summary(SCALE_SCORE)), keyby = c("CONTENT_AREA", "GRADE")]


###
###   Data for Leslie
###

load("Data/Utah_SGP_LONG_Data_2019.Rdata")
setnames(Utah_SGP_LONG_Data_2019, SGPstateData[["UT"]][["Variable_Name_Lookup"]][["names.provided"]], SGPstateData[["UT"]][["Variable_Name_Lookup"]][["names.sgp"]])

names(Utah_SGP_LONG_Data_2019)

Utah_SGP_LONG_Data_2019[, c("SGP", "SGP_LEVEL", "SGP_NORM_GROUP", "CONTENT_AREA_ACTUAL") := NULL]
Utah_SGP_LONG_Data_2019[, grep("ORDER", names(Utah_SGP_LONG_Data_2019), value=T) := NULL]

setnames(Utah_SGP_LONG_Data_2019, c("SGP_EQUATED", "SGP_LEVEL_EQUATED", "SGP_NORM_GROUP_EQUATED"), c("SGP", "SGP_LEVEL", "SGP_NORM_GROUP"))

fwrite(Utah_SGP_LONG_Data_2019, file="./Data/Utah_SGP_LONG_Data_2019-PRELIM_v3.txt", sep="|")#, compress = "gzip")
zip(zipfile="./Data/Utah_SGP_LONG_Data_2019-PRELIM_v3.txt.zip", files="./Data/Utah_SGP_LONG_Data_2019-PRELIM_v3.txt", flags="-mq")
