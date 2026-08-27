#+ include = FALSE, purl = FALSE, eval = FALSE
##############################################################################
###                                                                        ###
###               Utah 2026 Cohort and Baseline SGP analyses               ###
###                                                                        ###
##############################################################################

###   Load packages
require(SGP)
require(data.table)

###   Load data
load("Data/Utah_SGP.Rdata")
load("Data/Utah_Data_LONG_2026.Rdata")
Utah_SEC_MATH_2026  <- Utah_Data_LONG_2026[CONTENT_AREA == "SEC_MATH_I"]
Utah_Data_LONG_2026 <- Utah_Data_LONG_2026[!CONTENT_AREA %in% "SEC_MATH_I"]

###   Read in SGP configuration scripts used in various steps
# source("SGP_CONFIG/2026/ELA.R")
# source("SGP_CONFIG/2026/SCIENCE.R")
# source("SGP_CONFIG/2026/MATHEMATICS.R")

UT_Config_2026 <-
    c(ELA.2026.config,
      SCIENCE.2026.config,
      MATHEMATICS.2026.config
    )

###   Parallel processing for Mac/Linux
utah.par.config <-
    list(
        WORKERS = list(
            PERCENTILES = 10, BASELINE_PERCENTILES = 10,
            PROJECTIONS = 8, LAGGED_PROJECTIONS = 8,
            SGP_SCALE_SCORE_TARGETS = 8
        )
    )


#####
###   2026 ELA Equated/Cohort-Referenced SGP Analyses
#####

###   Modifications/Additions to `SGPstateData` for step 2
##    Add baseline matrices
##    (`SGPmatrices` package modified to remove Grades 4 & 5 Science)
SGPstateData <- SGPmatrices::addBaselineMatrices("UT", "2021")
##    Remove ELA Baselines. Scale/Content changes in '25
SGPstateData[["UT"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]][["ELA.BASELINE"]] <-
  SGPstateData[["UT"]][["Assessment_Program_Information"]][["Assessment_Transition"]] <-
    NULL
SGPstateData[["UT"]][["Assessment_Program_Information"]][["Scale_Change"]] <-
    list(ELA = 2025)

##    Knots and Bounds for ELA post scale changes (ADD to `SGPstateData`)
load("Data/UT_ELA_2025_KBs.rda")
SGPstateData[["UT"]][["Achievement"]][["Knots_Boundaries"]][["ELA.2025"]] <-
    UT_ELA_2025_KBs

###   Run updateSGP analysis
Utah_SGP <-
    updateSGP(
        what_sgp_object = Utah_SGP,
        with_sgp_data_LONG = Utah_Data_LONG_2026,
        overwrite.existing.data = FALSE,
        years = "2026",
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = UT_Config_2026,
        simulate.sgps = FALSE,
        sgp.percentiles = TRUE,
        sgp.projections = TRUE,
        sgp.projections.lagged = TRUE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = TRUE,
        sgp.projections.lagged.baseline = TRUE,
        sgp.target.scale.scores = TRUE,
        save.intermediate.results = FALSE,
        parallel.config = utah.par.config
    )


#####
###   2026 Secondary Math Cohort-Referenced SGP Analyses
#####

###   Temporary modifications/additions to `SGPstateData` for step 3
##    SEC_MATH_I Meta-data Changes/Additions
SGPstateData[["UT"]][["SGP_Configuration"]][["sgp.cohort.size"]] <- 1000
SGPstateData[["UT"]][["Achievement"]][["Knots_Boundaries"]][["MATHEMATICS"]][["knots_7"]] <-
    c(492, 515, 531, 551)  #  from '25 internal review
SGPstateData[["UT"]][["Achievement"]][["Knots_Boundaries"]][["MATHEMATICS"]][["knots_8"]] <-
    c(517, 543, 566, 593)  #  from '26 internal review


###   Run updateSGP analysis
Utah_SGP <-
    updateSGP(
        what_sgp_object = Utah_SGP,
        with_sgp_data_LONG = Utah_SEC_MATH_2026,
        overwrite.existing.data = FALSE,
        years = "2026",
        steps = c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config = SEC_MATH_I.2026.config,
        simulate.sgps = FALSE,
        sgp.percentiles = TRUE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = FALSE,
        sgp.projections.lagged.baseline = FALSE,
        outputSGP.output.type = c("LONG_Data", "LONG_FINAL_YEAR_Data"),
        save.intermediate.results = FALSE#,
        # parallel.config = utah.par.config
    )


###   Add R session info & save results (`cfaDocs` version 0.0-1.12 or later)
source(
    system.file(
        "rmarkdown", "shared_resources", "rmd", "R_Session_Info.R",
        package = "cfaDocs"
    )
)

Utah_SGP@Version[["session_platform"]][["2026"]] <- session_platform
Utah_SGP@Version[["attached_pkgs"]][["2026"]]    <- attached_pkgs
Utah_SGP@Version[["namespace_pkgs"]][["2026"]]   <- namespace_pkgs

save(Utah_SGP, file = "Data/Utah_SGP.Rdata")


#' ### Conduct SGP analyses
#'
#' All data analysis is conducted using the [`R` Software Environment](http://www.r-project.org/)
#' in conjunction with the [`SGP` package](http://sgp.io/). Cohort- and
#' baseline-referenced SGPs were calculated concurrently for the 2026 Utah
#' RISE/UA+ growth model analyses following these four steps:
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
#' #### 2026 Growth Analyses
#'
#' "Consecutive-year" growth percentiles were calculated for grades 4 through 10
#' ELA and mathematics, and grades 5 through 10 science. Both cohort and baseline
#' referenced growth model versions use up to two prior years' scores (i.e. 2024
#' and 2025) where available.
#'
#' In the calculation workflow, we first add pre-calculated baseline matrices
#' to the Utah entry in the `SGPstateData` object using the `addBaselineMatrices`
#' function from the `SGPmatrices` package (which also serves as a repository for
#' the baseline matrices). The 2026 configuration scripts were loaded and combined
#' into a single list object that serves to specify the exact analyses to be run.
#'
#' We use the [`updateSGP`](https://www.rdocumentation.org/packages/SGP/versions/2.0-0.0/topics/updateSGP)
#' function to ***a)*** prepare the `Utah_SGP` object saved from the 2025 growth
#' analyses and add the cleaned and formatted 2026 data (`prepareSGP`), ***b)***
#' calculate 2026 consecutive-year cohort- and baseline-referenced SGP estimates
#' and growth projections, ***c)*** merge the results into the master longitudinal
#' data set ([`combineSGP`](https://www.rdocumentation.org/packages/SGP/versions/2.0-0.0/topics/combineSGP)
#' step), and ***d)*** save the results in both `.Rdata` and pipe delimited versions
#' ([`outputSGP`](https://www.rdocumentation.org/packages/SGP/versions/2.0-0.0/topics/outputSGP)
#' step).
