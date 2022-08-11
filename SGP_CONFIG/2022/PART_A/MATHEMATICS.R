###############################################################################
###                                                                         ###
###      Spring 2019 MATHEMATICS consecutive-year baseline SGP configs      ###
###                                                                         ###
###############################################################################

MATHEMATICS_2019.config <- list(
    MATHEMATICS.2019 = list(
        sgp.content.areas = rep("MATHEMATICS", 3),
        sgp.panel.years = c("2017", "2018", "2019"),
        sgp.grade.sequences = list(
            c("3", "4"), c("3", "4", "5"),
            c("4", "5", "6"), c("5", "6", "7"), c("6", "7", "8"),
            c("7", "8", "9"), c("8", "9", "10")
        )
    )
)

SEC_MATH_I_2019.config <- list(
    SEC_MATH_I.2019 = list(
        sgp.content.areas = c(rep("MATHEMATICS", 2), "SEC_MATH_I"),
        sgp.panel.years = c("2017", "2018", "2019"),
        sgp.grade.sequences = list(c("6", "7", "EOCT")),
        sgp.projection.baseline.grade.sequences = list("NO_PROJECTIONS")
    )
)
