################################################################################
###                                                                          ###
###       SGP STRAIGHT projections for skip year SGP analyses for 2021       ###
###                                                                          ###
################################################################################

###   Load packages
require(SGP)
require(SGPmatrices)

###   Load data
load("Data/Utah_SGP.Rdata")

###   Load configurations
source("SGP_CONFIG/2021/PART_B/ELA.R")
source("SGP_CONFIG/2021/PART_B/SCIENCE.R")
source("SGP_CONFIG/2021/PART_B/MATHEMATICS.R")

UT_Config_2021_PartB <- c(
    ELA_2021.config,
    SCIENCE_2021.config,
    MATHEMATICS_2021.config
)

###   Setup SGPstateData with baseline coefficient matrices grade specific projection sequences
##    Add Baseline matrices
SGPstateData <- addBaselineMatrices("UT", "2021")

##    Establish required meta-data for STRAIGHT projection sequences
source("./SGP_CONFIG/2021/PART_B/UT_Straight_Projections_MetaData.R")

###   Run analysis

###   Parallel Config
##    Make NULL if using Windows! `parallel.config <- NULL`
parallel.config <- list(BACKEND="PARALLEL",
                        WORKERS=list(PROJECTIONS=6, SGP_SCALE_SCORE_TARGETS=6))

##    Need to add BASELINE straight target variables first (for combineSGP):
Utah_SGP@Data$SGP_TARGET_BASELINE_3_YEAR <- as.integer(NA)
# Utah_SGP@Data$SGP_TARGET_BASELINE_3_YEAR_CURRENT <- as.integer(NA)

Utah_SGP <- abcSGP(
        Utah_SGP,
        years = "2021", # need to add years now (after adding 2019 baseline projections).  Why?
        steps=c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config=UT_Config_2021_PartB,
        sgp.percentiles=FALSE,
        sgp.projections=FALSE,
        sgp.projections.lagged=FALSE,
        sgp.percentiles.baseline=FALSE,
        sgp.projections.baseline=TRUE,
        sgp.projections.lagged.baseline=FALSE,
        sgp.target.scale.scores=TRUE,
        parallel.config=parallel.config
)

###   Save results
save(Utah_SGP, file="Data/Utah_SGP.Rdata")
