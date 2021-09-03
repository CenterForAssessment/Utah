################################################################################
###                                                                          ###
###                Utah COVID Skip-year SGP analyses for 2021                ###
###                                                                          ###
################################################################################

###   Load packages
require(SGP)
require(data.table)
require(SGPmatrices)

###   Load data
load("Data/Utah_SGP.Rdata")
load("Data/Utah_Data_LONG_2021.Rdata")

###   Add Baseline matrices to SGPstateData
SGPstateData <- addBaselineMatrices("UT", "2021")
# load("Data/UT_Baseline_Matrices.Rdata")
# SGPstateData[["UT"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- UT_Baseline_Matrices

###   Read in SGP Configuration Scripts and Combine
source("SGP_CONFIG/2021/PART_A/ELA.R")
# source("SGP_CONFIG/2021/PART_A/SCIENCE.R")
source("SGP_CONFIG/2021/PART_A/MATHEMATICS.R")

UT_Config_2021_PartA <- c(
  ELA_2021.config,
  # SCIENCE_2021.config,
  MATHEMATICS_2021.config,
  SEC_MATH_I_2021.config
)

###   Parallel Config
parallel.config <- list(BACKEND="PARALLEL",
                        WORKERS=list(
                          PERCENTILES=8, BASELINE_PERCENTILES=8,
                          PROJECTIONS=8, LAGGED_PROJECTIONS=8,
                          SGP_SCALE_SCORE_TARGETS=8))

#####
###   Run updateSGP analysis
#####

Utah_SGP <- updateSGP(
        what_sgp_object = Utah_SGP,
        with_sgp_data_LONG = Utah_Data_LONG_2021,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = UT_Config_2021_PartA,
        sgp.percentiles = TRUE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = FALSE,
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)

### Copy SCALE_SCORE_PRIOR and SCALE_SCORE_PRIOR_STANDARDIZED to BASELINE counter parts
Utah_SGP@Data[YEAR=="2021", SCALE_SCORE_PRIOR_BASELINE:=SCALE_SCORE_PRIOR]
Utah_SGP@Data[YEAR=="2021", SCALE_SCORE_PRIOR_STANDARDIZED_BASELINE:=SCALE_SCORE_PRIOR_STANDARDIZED]

###   Save results
save(Utah_SGP, file="Data/Utah_SGP.Rdata")
