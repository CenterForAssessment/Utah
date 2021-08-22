#####################################################################################
###                                                                               ###
###            Utah Learning Loss Analyses -- Create Baseline Matrices            ###
###                                                                               ###
#####################################################################################

### NOTE: SCALE_SCORE is SCALE_SCORE_EQUATED in this file going forward. SCALE_SCORE_ORIGINAL is the original/actual scale score report on ISTEP+

### Load necessary packages
require(SGP)
require(data.table)

###   Load the results data from the 'official' 2019 SGP analyses
load("Data/Utah_SGP_LONG_Data_PreCOVID.Rdata")

###   Create a smaller subset of the LONG data to work with.
Utah_Baseline_Data <- data.table(Utah_SGP_LONG_Data_PreCOVID[, c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID", "GRADE", "SCALE_SCORE", "ACHIEVEMENT_LEVEL"),])

###   Read in Baseline SGP Configuration Scripts and Combine
source("SGP_CONFIG/2019/BASELINE/Matrices/ELA.R")
source("SGP_CONFIG/2019/BASELINE/Matrices/SCIENCE.R")
source("SGP_CONFIG/2019/BASELINE/Matrices/MATHEMATICS.R")

UT_BASELINE_CONFIG <- c(
	ELA_BASELINE.config,
  SCIENCE_BASELINE.config,
	MATHEMATICS_BASELINE.config,
	SEC_MATH_I_BASELINE.config
)

###
###   Create Baseline Matrices

Utah_SGP <- prepareSGP(Utah_Baseline_Data, create.additional.variables=FALSE)

UT_Baseline_Matrices <- baselineSGP(
				Utah_SGP,
				sgp.baseline.config=UT_BASELINE_CONFIG,
				return.matrices.only=TRUE,
				calculate.baseline.sgps=FALSE,
				goodness.of.fit.print=FALSE,
				parallel.config = list(
					BACKEND="PARALLEL", WORKERS=list(TAUS=15))
)

###   Save results
save(UT_Baseline_Matrices, file="Data/UT_Baseline_Matrices.Rdata")
