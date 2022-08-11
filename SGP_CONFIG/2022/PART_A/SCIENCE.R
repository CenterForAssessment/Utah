###############################################################################
###                                                                         ###
###        Spring 2019 SCIENCE consecutive-year baseline SGP configs        ###
###                                                                         ###
###############################################################################

SCIENCE_2019.config <- list(
    SCIENCE.2019 = list(
        sgp.content.areas = rep("SCIENCE", 3),
        sgp.panel.years = c("2017", "2018", "2019"),
        sgp.grade.sequences = list(
            # c("4", "5"), c("4", "5", "6"), c("5", "6", "7"),
            # Nothing with grades 4 or 5 - 2021 scale change
            c("6", "7"), c("6", "7", "8"),
            c("7", "8", "9"), c("8", "9", "10")
        )
    )
)
