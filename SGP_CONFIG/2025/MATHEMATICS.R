###############################################################################
###                                                                         ###
###            SGP Configurations for 2025 MATHEMATICS subjects             ###
###                                                                         ###
###############################################################################

MATHEMATICS.2025.config <- list(
    MATHEMATICS.2025 <- list(
        sgp.content.areas = rep("MATHEMATICS", 3),
        sgp.panel.years = c("2023", "2024", "2025"),
        sgp.grade.sequences = list(
            c("3", "4"), c("3", "4", "5"),
            c("4", "5", "6"), c("5", "6", "7"), c("6", "7", "8"),
            c("7", "8", "9"), c("8", "9", "10")
        ),
        sgp.norm.group.preference = 0L
    )
)

SEC_MATH_I.2025.config <- list(
    SEC_MATH_I.2025 = list(
        sgp.content.areas = c("MATHEMATICS", "MATHEMATICS", "SEC_MATH_I"),
        sgp.panel.years = c("2023", "2024", "2025"),
        sgp.grade.sequences = list(
            c("5", "6", "EOCT"), c("6", "7", "EOCT"), c("7", "8", "EOCT")
        ),
        sgp.projection.grade.sequences = as.list(rep("NO_PROJECTIONS", 3)),
        sgp.norm.group.preference = 1L
    )
)
