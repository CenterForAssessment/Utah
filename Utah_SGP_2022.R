##############################################################################
###                                                                        ###
###               Utah 2022 Cohort and Baseline SGP analyses               ###
###              * Includes 2019 consecutive-year baselines *              ###
###                                                                        ###
##############################################################################

###   Load packages
require(SGP)
require(data.table)

###   Load dataq
load("Data/Utah_SGP.Rdata")

###   Modifications/Additions to SGPstateData

##  Add baseline matrices to `SGPstateData`
SGPstateData <- SGPmatrices::addBaselineMatrices("UT", "2021")

#   Remove science matrices with grades 4 and/or 5 - 2021 scale change!
sci.bsline.mtrx <-
    names(SGPstateData[["UT"]][["Baseline_splineMatrix"]][[
            "Coefficient_Matrices"]][["SCIENCE.BASELINE"]]
    )
keep.index <- NULL
for (mtrx in seq(sci.bsline.mtrx)) {
    if (!any(grepl(5, SGPstateData[["UT"]][["Baseline_splineMatrix"]][[
                          "Coefficient_Matrices"]][["SCIENCE.BASELINE"]][[
                              mtrx]]@Grade_Progression[[1]]
            )
        )
    ) {
        keep.index <- c(keep.index, mtrx)
    }
}

SGPstateData[["UT"]][["Baseline_splineMatrix"]][[
  "Coefficient_Matrices"]][["SCIENCE.BASELINE"]] <-
    SGPstateData[["UT"]][["Baseline_splineMatrix"]][[
        "Coefficient_Matrices"]][["SCIENCE.BASELINE"]][keep.index]


#####
###   PART A -- 2019 Consecutive Year Baseline SGPs
#####

###   Rename the skip-year SGP variables and objects

##    We can simply rename the BASELINE variables. We only have 2019/21 skip yr
# table(Utah_SGP@Data[!is.na(SGP_BASELINE),
#         .(CONTENT_AREA, YEAR), GRADE], exclude = NULL)
baseline.names <- grep("BASELINE", names(Utah_SGP@Data), value = TRUE)
setnames(Utah_SGP@Data,
         baseline.names,
         paste0(baseline.names, "_SKIP_YEAR"))

sgps.2019 <- grep(".2019.BASELINE", names(Utah_SGP@SGP[["SGPercentiles"]]))
names(Utah_SGP@SGP[["SGPercentiles"]])[sgps.2019] <-
    gsub(".2019.BASELINE",
         ".2019.SKIP_YEAR_BLINE",
         names(Utah_SGP@SGP[["SGPercentiles"]])[sgps.2019]
    )

pjct.2019 <- grep(".2019.BASELINE", names(Utah_SGP@SGP[["SGProjections"]]))
names(Utah_SGP@SGP[["SGProjections"]])[pjct.2019] <-
    gsub(".2019.BASELINE",
        ".2019.SKIP_YEAR_BLINE",
        names(Utah_SGP@SGP[["SGProjections"]])[pjct.2019]
    )

coef.2019 <- grep(".BASELINE", names(Utah_SGP@SGP[["Coefficient_Matrices"]]))
Utah_SGP@SGP[["Coefficient_Matrices"]] <-
    Utah_SGP@SGP$Coefficient_Matrices[-coef.2019]

###   Read in SGP Configuration Scripts and Combine
source("SGP_CONFIG/2022/PART_A/ELA.R")
source("SGP_CONFIG/2022/PART_A/SCIENCE.R")
source("SGP_CONFIG/2022/PART_A/MATHEMATICS.R")

UT_Baseline_Config_2019 <-
    c(ELA_2019.config,
      SCIENCE_2019.config,
      MATHEMATICS_2019.config,
      SEC_MATH_I_2019.config
    )

###   Parallel Config
parallel.config <-
    list(
        BACKEND = "PARALLEL",
        WORKERS = list(
            PERCENTILES = 21,
            BASELINE_PERCENTILES = 21,
            PROJECTIONS = 21,
            LAGGED_PROJECTIONS = 21
        )
    )


###   Run abcSGP analysis
Utah_SGP <-
    abcSGP(
        sgp_object = Utah_SGP,
        years = "2019",
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = UT_Baseline_Config_2019,
        sgp.percentiles = FALSE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = TRUE, #TRUE, # P50_PROJ_YEAR_1_CURRENT - Fair Trend
        sgp.projections.lagged.baseline = FALSE,
        simulate.sgps = FALSE,
        sgp.target.scale.scores = FALSE,
        parallel.config = parallel.config
    )


#####
###   PART B -- 2022 Cohort and Baseline SGP Analyses
#####

###   Load data
load("Data/Utah_Data_LONG_2022.Rdata")

###   Read in SGP Configuration Scripts and Combine
source("SGP_CONFIG/2022/PART_B/ELA.R")
source("SGP_CONFIG/2022/PART_B/SCIENCE.R")
source("SGP_CONFIG/2022/PART_B/MATHEMATICS.R")

UT_Config_2022 <-
    c(ELA_2022.config,
      SCIENCE_2022.config,
      MATHEMATICS_2022.config,
      SEC_MATH_I_2022.config
    )


###   Run updateSGP analysis
Utah_SGP <-
    updateSGP(
        what_sgp_object = Utah_SGP,
        with_sgp_data_LONG = Utah_Data_LONG_2022,
        years = "2022",
        steps = c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config = UT_Config_2022,
        sgp.percentiles = TRUE,
        sgp.projections = TRUE,
        sgp.projections.lagged = TRUE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = TRUE,
        sgp.projections.lagged.baseline = TRUE,
        sgp.target.scale.scores = TRUE,
        save.intermediate.results = FALSE,
        outputSGP.output.type = c("LONG_Data", "LONG_FINAL_YEAR_Data"),
        parallel.config = parallel.config
    )


###   Save results
save(Utah_SGP, file = "Data/Utah_SGP.Rdata")
