#+ include = FALSE, purl = FALSE, eval = FALSE
##############################################################################
###                                                                        ###
###               Utah 2024 Cohort and Baseline SGP analyses               ###
###                                                                        ###
##############################################################################

###   Load packages
require(SGP)
require(data.table)

###   Load data
load("Data/Utah_SGP.Rdata")
load("Data/Utah_Data_LONG_2024.Rdata")

###   Modifications/Additions to `SGPstateData`
##    Add baseline matrices
##    (`SGPmatrices` package modified to remove Grades 4 & 5 Science) 
SGPstateData <- SGPmatrices::addBaselineMatrices("UT", "2021")


#####
###   2024 Cohort and Baseline SGP Analyses
#####

###   Read in SGP Configuration Scripts and Combine
source("SGP_CONFIG/2024/ELA.R")
source("SGP_CONFIG/2024/SCIENCE.R")
source("SGP_CONFIG/2024/MATHEMATICS.R")

UT_Config_2024 <-
    c(ELA.2024.config,
      SCIENCE.2024.config,
      MATHEMATICS.2024.config,
      SEC_MATH_I.2024.config
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
        with_sgp_data_LONG = Utah_Data_LONG_2024,
        years = "2024",
        steps = c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config = UT_Config_2024,
        simulate.sgps = FALSE,
        sgp.percentiles = TRUE,
        sgp.projections = TRUE,
        sgp.projections.lagged = TRUE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = TRUE,
        sgp.projections.lagged.baseline = TRUE,
        sgp.target.scale.scores = TRUE,
        outputSGP.output.type = c("LONG_Data", "LONG_FINAL_YEAR_Data"),
        save.intermediate.results = FALSE,
        parallel.config = utah.par.config
    )


###   Add R session info & save results (`cfaDocs` version 0.0-1.12 or later)
source(
    system.file(
        "rmarkdown", "shared_resources", "rmd", "R_Session_Info.R",
        package = "cfaDocs"
    )
)
Utah_SGP@Version$session_platform <- list("2024" = session_platform)
Utah_SGP@Version$attached_pkgs    <- list("2024" = attached_pkgs)
Utah_SGP@Version$namespace_pkgs   <- list("2024" = namespace_pkgs)

save(Utah_SGP, file = "Data/Utah_SGP.Rdata")


#' ### Conduct SGP analyses
#'
#' All data analysis is conducted using the [`R` Software Environment](http://www.r-project.org/)
#' in conjunction with the [`SGP` package](http://sgp.io/). Cohort- and
#' baseline-referenced SGPs were calculated concurrently for the 2024 Utah
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
#' #### 2024 Growth Analyses
#'
#' "Consecutive-year" growth percentiles were calculated for grades 4 through 10
#' ELA and mathematics, and grades 5 through 10 science. Both cohort and baseline
#' referenced growth model versions use up to two prior years' scores (i.e. 2022
#' and 2023) where available.
#'
#' In the calculation workflow, we first add pre-calculated baseline matrices
#' to the Utah entry in the `SGPstateData` object using the `addBaselineMatrices`
#' function from the `SGPmatrices` package (which also serves as a repository for
#' the baseline matrices). The 2024 configuration scripts were loaded and combined
#' into a single list object that serves to specify the exact analyses to be run.
#'
#' We use the [`updateSGP`](https://www.rdocumentation.org/packages/SGP/versions/2.0-0.0/topics/updateSGP)
#' function to ***a)*** prepare the `Utah_SGP` object saved from the 2023 growth
#' analyses and add the cleaned and formatted 2024 data (`prepareSGP`), ***b)*** 
#' calculate 2024 consecutive-year cohort- and baseline-referenced SGP estimates
#' and growth projections, ***c)*** merge the results into the master longitudinal
#' data set ([`combineSGP`](https://www.rdocumentation.org/packages/SGP/versions/2.0-0.0/topics/combineSGP)
#' step). and ***d)*** save the results in both `.Rdata` and pipe delimited versions
#' ([`outputSGP`](https://www.rdocumentation.org/packages/SGP/versions/2.0-0.0/topics/outputSGP)
#' step).