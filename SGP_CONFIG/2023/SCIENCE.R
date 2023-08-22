###############################################################################
###                                                                         ###
###              SGP Configurations for 2023 SCIENCE subjects               ###
###                                                                         ###
###############################################################################

###   Cohort-referenced analyses
SCIENCE.2023.config <- list(
    SCIENCE.2023 <- list(
        sgp.content.areas = rep("SCIENCE", 3),
        sgp.panel.years = c("2021", "2022", "2023"),
        sgp.grade.sequences = list(
            c("4", "5"),
            c("4", "5", "6"), c("5", "6", "7"), c("6", "7", "8"),
            c("7", "8", "9"), c("8", "9", "10")
        )
    )
)

###   Baseline-referenced analyses
SCIENCE_Baseline.2023.config <- list(
    SCIENCE_Baseline.2023 <- list(
        sgp.content.areas = rep("SCIENCE", 3),
        sgp.panel.years = c("2021", "2022", "2023"),
        sgp.grade.sequences = list(
            c("6", "7"), c("6", "7", "8"),
            c("7", "8", "9"), c("8", "9", "10")
        )
    )
)