###############################################################################
###                                                                         ###
###            SGP Configurations for 2022 MATHEMATICS subjects             ###
###                                                                         ###
###############################################################################

MATHEMATICS_2022.config <- list(
    MATHEMATICS.2022 <- list(
        sgp.content.areas = c("MATHEMATICS", "MATHEMATICS"),
        sgp.panel.years = c("2021", "2022"),
        sgp.grade.sequences = list(
            c("3", "4"), c("4", "5"),
            c("5", "6"), c("6", "7"), c("7", "8"),
            c("8", "9"), c("9", "10")
        )
    )
)

SEC_MATH_I_2022.config <- list(
    SEC_MATH_I_2022 = list(
        sgp.content.areas = c("MATHEMATICS", "SEC_MATH_I"),
        sgp.panel.years = c("2021", "2022"),
        sgp.grade.sequences = list(
            c("6", "EOCT"), c("7", "EOCT"), c("8", "EOCT")
        ),
        sgp.baseline.grade.sequences = list(c("6", "7", "EOCT")),
        sgp.projection.grade.sequences = as.list(rep("NO_PROJECTIONS", 3)),
        sgp.projection.baseline.grade.sequences = as.list(rep("NO_PROJECTIONS", 3)) #list("NO_PROJECTIONS")
    )
)
