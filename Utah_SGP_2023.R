#+ include = FALSE, purl = FALSE, eval = FALSE
##############################################################################
###                                                                        ###
###               Utah 2023 Cohort and Baseline SGP analyses               ###
###                                                                        ###
##############################################################################

###   Load packages
require(SGP)
require(data.table)

###   Load data
load("Data/Utah_SGP.Rdata")
Utah_SGP@SGP$Error_Reports <- NULL

###   Modifications/Additions to SGPstateData

##  Add baseline matrices to `SGPstateData`
SGPstateData <- SGPmatrices::addBaselineMatrices("UT", "2021")

#   Remove science matrices with grades 4 and/or 5 - 2021 scale change!
sci.bsline.mtrx <-
    names(
        SGPstateData[["UT"]][["Baseline_splineMatrix"]][[
            "Coefficient_Matrices"]][["SCIENCE.BASELINE"]]
    )
keep.index <- NULL
for (mtrx in seq(sci.bsline.mtrx)) {
    if (!any(
          grepl(5,
                SGPstateData[["UT"]][["Baseline_splineMatrix"]][[
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
###   PART A -- 2023 Cohort SGP Analyses
#####

###   Load data
load("Data/Utah_Data_LONG_2023.Rdata")

###   Read in SGP Configuration Scripts and Combine
# source("SGP_CONFIG/2023/ELA.R")
# source("SGP_CONFIG/2023/SCIENCE.R")
# source("SGP_CONFIG/2023/MATHEMATICS.R")

UT_Config_2023 <-
    c(ELA.2023.config,
      SCIENCE.2023.config,
      MATHEMATICS.2023.config,
      SEC_MATH_I.2023.config
    )

utah.par.config <-
    list(
        BACKEND = "PARALLEL",
        WORKERS = list(
            PERCENTILES = 10, BASELINE_PERCENTILES = 10,
            PROJECTIONS = 8, LAGGED_PROJECTIONS = 8)
    )

###   Run updateSGP analysis
Utah_SGP <-
    updateSGP(
        what_sgp_object = Utah_SGP,
        with_sgp_data_LONG = Utah_Data_LONG_2023,
        years = "2023",
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = UT_Config_2023,
        simulate.sgps = FALSE,
        sgp.percentiles = TRUE,
        sgp.projections = TRUE,
        sgp.projections.lagged = TRUE,
        sgp.percentiles.baseline = FALSE,
        sgp.projections.baseline = FALSE,
        sgp.projections.lagged.baseline = FALSE,
        sgp.target.scale.scores = TRUE,
        save.intermediate.results = FALSE,
        parallel.config = utah.par.config
    )


#####
###   PART B -- 2023 Baseline SGP Analyses
#####

UT_Baseline_Config_2023 <-
    c(ELA.2023.config,
      SCIENCE_Baseline.2023.config,
      MATHEMATICS.2023.config,
      SEC_MATH_I_Baseline.2023.config
    )


###   Run abcSGP analysis
Utah_SGP <-
    abcSGP(
        sgp_object = Utah_SGP,
        years = "2023",
        steps = c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config = UT_Baseline_Config_2023,
        sgp.percentiles = FALSE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = TRUE,
        sgp.projections.lagged.baseline = TRUE,
        simulate.sgps = FALSE,
        sgp.target.scale.scores = FALSE,
        outputSGP.output.type = c("LONG_Data", "LONG_FINAL_YEAR_Data"),
        parallel.config = utah.par.config
    )


###   Save results
save(Utah_SGP, file = "Data/Utah_SGP.Rdata")


#' ### Conduct SGP analyses
#'
#' All data analysis is conducted using the [`R` Software Environment](http://www.r-project.org/)
#' in conjunction with the [`SGP` package](http://sgp.io/). Cohort- and
#' baseline-referenced SGPs were calculated separately for the 2023 Utah
#' RISE/UA+ growth model analyses. Each part of the 2023 analyses were
#' completed in these 4 steps:
#'
#' 1. `prepareSGP`
#' 2. `analyzeSGP`
#' 3. `combineSGP`
#' 4. `outputSGP`
#'
#' Because these steps are almost always conducted simultaneously, the `SGP`
#' package has "wrapper" functions, `abcSGP` and `updateSGP`, that combine
#' the above steps into a single function call and simplify the source code
#' associated with the data analysis. Documentation for all SGP functions are
#' [available online.](https://cran.r-project.org/web/packages/SGP/SGP.pdf)
#'
#' #### 2023 Growth Analyses
#'
#' In the 2023 analyses, we calculated "consecutive-year" cohort-referenced
#' SGPs concurrently for grades 4 through 10 ELA and mathematics, and
#' grades 5 through 10 science. Both SGP analysis versions use up to
#' two prior years' scores (i.e. 2021 and 2022) where available.
#'
#' In the calculation workflow, we first add pre-calculated baseline matrices
#' to the Utah entry in the `SGPstateData` object using the `addBaselineMatrices`
#' function from the `SGPmatrices` package (which also serves as a repository for
#' the baseline matrices). The 2023 configuration scripts were loaded and combined
#' into a single list object that serves to specify the exact analyses to be run.
#'
#' We use the [`updateSGP`](https://www.rdocumentation.org/packages/SGP/versions/2.0-0.0/topics/updateSGP)
#' function to ***a)*** prepare the `Utah_SGP` object saved from the 2022 growth
#' analyses and add the cleaned and formatted 2023 data (`prepareSGP`), ***b)*** 
#' calculate 2023 consecutive-year cohort- and baseline-referenced SGP estimates
#' and growth projections, ***c)*** merge the results into the master longitudinal data set ([`combineSGP`](https://www.rdocumentation.org/packages/SGP/versions/2.0-0.0/topics/combineSGP)
#' step). and ***d)*** save the results in both `.Rdata` and pipe delimited versions
#' ([`outputSGP`](https://www.rdocumentation.org/packages/SGP/versions/2.0-0.0/topics/outputSGP)
#'
#' #### 2023 Analyses, Part B
#' step).