###############################################################################
###                                                                         ###
###              SGP Configurations for 2026 SCIENCE subjects               ###
###                                                                         ###
###############################################################################

###   Cohort-referenced analyses
SCIENCE.2026.config <- list(
    SCIENCE.2026 <- list(
        sgp.content.areas = rep("SCIENCE", 3),
        sgp.panel.years = c("2024", "2025", "2026"),
        sgp.grade.sequences = list(
            c("4", "5"),
            c("4", "5", "6"), c("5", "6", "7"), c("6", "7", "8"),
            c("7", "8", "9"), c("8", "9", "10")
        )
    )
)
