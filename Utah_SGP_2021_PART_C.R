################################################################################
###                                                                          ###
###        SGP LAGGED projections for skip year SGP analyses for 2021        ###
###                                                                          ###
################################################################################

###   Load packages
require(SGP)
require(SGPmatrices)

###   Load data
load("Data/Utah_SGP.Rdata")

###   Load configurations
source("SGP_CONFIG/2021/PART_C/ELA.R")
# source("SGP_CONFIG/2021/PART_C/SCIENCE.R")
source("SGP_CONFIG/2021/PART_C/MATHEMATICS.R")

UT_Config_2021_PartC <- c(
    ELA_2021.config,
    # SCIENCE_2021.config,
    MATHEMATICS_2021.config
)

###   Setup SGPstateData with baseline coefficient matrices grade specific projection sequences
##   Add Baseline matrices to SGPstateData and update SGPstateData
SGPstateData <- addBaselineMatrices("UT", "2021")

##    Establish required meta-data for LAGGED projection sequences
source("./SGP_CONFIG/2021/PART_C/UT_Lagged_Projections_MetaData.R")

### Run analysis

###   Parallel Config
##    Make NULL if using Windows! `parallel.config <- NULL`
parallel.config <- list(BACKEND="PARALLEL",
                        WORKERS=list(LAGGED_PROJECTIONS=8, SGP_SCALE_SCORE_TARGETS=8))

Utah_SGP <- abcSGP(
        Utah_SGP,
        years = "2021", # STILL need to add years now (after adding 2019 baseline projections).
        steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config=UT_Config_2021_PartC,
        sgp.percentiles=FALSE,
        sgp.projections=FALSE,
        sgp.projections.lagged=FALSE,
        sgp.percentiles.baseline=FALSE,
        sgp.projections.baseline=FALSE,
        sgp.projections.lagged.baseline=TRUE,
        sgp.target.scale.scores=FALSE,
        outputSGP.output.type=c("LONG_Data", "LONG_FINAL_YEAR_Data"),
        parallel.config=parallel.config
)

###   Save results
save(Utah_SGP, file="Data/Utah_SGP.Rdata")
