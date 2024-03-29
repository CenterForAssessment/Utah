################################################################################
###                                                                          ###
###     Utah Learning Loss Analyses -- 2019 Baseline Growth Percentiles      ###
###                                                                          ###
################################################################################

###   Load packages
require(SGP)
require(data.table)
require(SGPmatrices) # version 0.0-0.992 (9-3-2021) contains UT matrices

###   Load pre-COVID data with equated scores.
load("Data/Utah_SGP_LONG_Data_PreCOVID.Rdata")

###   Add single-cohort baseline matrices to SGPstateData
SGPstateData <- SGPmatrices::addBaselineMatrices("UT", "2021")
# load("Data/UT_Baseline_Matrices.Rdata")
# SGPstateData[["UT"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- UT_Baseline_Matrices

### NULL out assessment transition in 2019 (since already dealth with)
SGPstateData[["UT"]][["Assessment_Program_Information"]][["Assessment_Transition"]] <- NULL
SGPstateData[["UT"]][["Assessment_Program_Information"]][["Scale_Change"]] <- NULL
# SGPstateData[["UT"]][["Assessment_Program_Information"]][["CSEM"]] <- NULL

###   Read in BASELINE percentiles configuration scripts and combine
source("SGP_CONFIG/2019/BASELINE/Percentiles/ELA.R")
source("SGP_CONFIG/2019/BASELINE/Percentiles/SCIENCE.R")
source("SGP_CONFIG/2019/BASELINE/Percentiles/MATHEMATICS.R")

UT_2019_Baseline_Config <- c(
	ELA_2019.config,
	SCIENCE_2019.config,
	MATHEMATICS_2019.config,
	SEC_MATH_I_2019.config
)

#####
###   Run BASELINE SGP analysis - create new Utah_SGP object with historical data
#####

###   Temporarily set names of prior scores from sequential/cohort analyses
data.table::setnames(Utah_SGP_LONG_Data_PreCOVID,
	c("SCALE_SCORE_PRIOR", "SCALE_SCORE_PRIOR_STANDARDIZED"),
	c("SS_PRIOR_COHORT", "SS_PRIOR_STD_COHORT"))

Utah_SGP <- abcSGP(
        sgp_object = Utah_SGP_LONG_Data_PreCOVID,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = UT_2019_Baseline_Config,
        sgp.percentiles = FALSE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,  #  Skip year SGPs for 2021 comparisons
        sgp.projections.baseline = FALSE, #  Calculated in next step
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        parallel.config = list(
					BACKEND = "PARALLEL",
					WORKERS=list(BASELINE_PERCENTILES=12))
)

###   Re-set and rename prior scores (one set for sequential/cohort, another for skip-year/baseline)
data.table::setnames(Utah_SGP@Data,
  c("SCALE_SCORE_PRIOR", "SCALE_SCORE_PRIOR_STANDARDIZED", "SS_PRIOR_COHORT", "SS_PRIOR_STD_COHORT"),
  c("SCALE_SCORE_PRIOR_BASELINE", "SCALE_SCORE_PRIOR_STANDARDIZED_BASELINE", "SCALE_SCORE_PRIOR", "SCALE_SCORE_PRIOR_STANDARDIZED"))

outputSGP(Utah_SGP, output.type = "LONG_Data")

###   Save results
save(Utah_SGP, file="Data/Utah_SGP.Rdata")
