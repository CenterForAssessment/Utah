#+ include = FALSE, purl = FALSE, eval = FALSE
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
###   PART A -- 2019 Consecutive Year Baseline SGPs
#####

###   Rename the skip-year SGP variables and objects

##    We can simply rename the BASELINE variables. We only have 2019/21 skip yr
# table(Utah_SGP@Data[!is.na(SGP_BASELINE),
#         .(CONTENT_AREA, YEAR), GRADE], exclude = NULL)
baseline.names <- grep("BASELINE", names(Utah_SGP@Data), value = TRUE)
setnames(
    Utah_SGP@Data,
    baseline.names,
    paste0(baseline.names, "_SKIP_YEAR")
)

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
            PERCENTILES = 8,
            BASELINE_PERCENTILES = 8,
            PROJECTIONS = 4,
            LAGGED_PROJECTIONS = 2
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
        outputSGP.output.type = c("LONG_Data", "LONG_FINAL_YEAR_Data")#,
        # parallel.config = parallel.config
    )


###   Save results
save(Utah_SGP, file = "Data/Utah_SGP.Rdata")


#' ### Conduct SGP analyses
#'
#' All data analysis is conducted using the [`R` Software Environment](http://www.r-project.org/)
#' in conjunction with the [`SGP` package](http://sgp.io/). Cohort- and
#' baseline-referenced SGPs were calculated in two parts for the 2022 Utah
#' RISE/UA+ growth model analyses. Each part of the 2022 analyses were completed
#' in these 4 steps:
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
#' #### 2022 Analyses, Part A
#'
#' In the first part of the 2022 analyses, we first calculated "consecutive-year"
#' baseline-referenced SGPs for grades 4 through 10 in ELA, mathematics and
#' science.^[Science SGPs begin at grade 5 as there is no 3<sup>rd</sup> grade test.]
#' These baseline SGP analyses use up to three consecutive years of data (i.e. 2018
#' and 2017 as priors and 2019 as the current year), meaning they are roughly
#' analogous to the original 2019 cohort-referenced analyses. These analyses are
#' necessary to provide a direct comparison with the 2022 baseline-referenced
#' results.
#'
#' These analyses also differ from the 2019 baseline-referenced growth analyses
#' conducted in 2021, which were skip-year analyses (i.e. 2017 and 2016 used as
#' priors with 2019 as the current year) used to compare with the 2021 skip-year
#' SGP analyses that used 2019 and 2018 (if/when available) as priors for the
#' 2021 scores.
#'
#' In the calculation workflow, we first added the pre-calculated baseline matrices
#' to the Utah entry in the `SGPstateData` object using the `addBaselineMatrices`
#' function from the `SGPmatrices` package (which also serves as a repository for
#' the baseline matrices). The 2019 configuration scripts were loaded and combined
#' into a single list object that serves to specify the exact analyses to be run.
#'
#' We then used the [`abcSGP`](https://www.rdocumentation.org/packages/SGP/versions/2.0-0.0/topics/abcSGP)
#' function to ***a)*** prepare and validate the `Utah_SGP` data object contents
#' ([`prepareSGP`](https://www.rdocumentation.org/packages/SGP/versions/2.0-0.0/topics/prepareSGP)
#' step), ***b)*** calculate 2019 consecutive-year baseline SGP estimates
#' ([`analyzeSGP`](https://www.rdocumentation.org/packages/SGP/versions/2.0-0.0/topics/analyzeSGP)
#' step) and ***c)*** merge the results into the master longitudinal data set
#' ([`combineSGP`](https://www.rdocumentation.org/packages/SGP/versions/2.0-0.0/topics/combineSGP)
#' step).
#'
#' #### 2022 Analyses, Part B
#'
#' In the second part of the 2022 analyses, we calculate "consecutive-year"
#' cohort- and baseline-referenced SGPs concurrently for grades 4 through 10 ELA
#' and mathematics, and grades 5 through 10 science. Both SGP analysis versions
#' use only a single prior (i.e. 2021).
#'
#' In the calculation workflow, we again first add the pre-calculated baseline
#' matrices to `SGPstateData` via the `SGPmatrices` package and load the 2022
#' configuration scripts to specify the analyses.
#'
#' In this part we use the [`updateSGP`](https://www.rdocumentation.org/packages/SGP/versions/2.0-0.0/topics/updateSGP)
#' function to ***a)*** prepare the `Utah_SGP` object used in Part A and add
#' the cleaned and formatted 2022 data (`prepareSGP`), ***b)*** calculate 2022
#' consecutive-year cohort- and baseline-referenced SGP estimates and growth
#' projections (`analyzeSGP` step), ***c)*** merge the results into the master
#' longitudinal data set (`combineSGP` step) and ***d)*** save the results in
#' both `.Rdata` and pipe delimited versions ([`outputSGP`](https://www.rdocumentation.org/packages/SGP/versions/2.0-0.0/topics/outputSGP) step).