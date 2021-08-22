################################################################################
###                                                                          ###
###   Configurations for STRAIGHT (skip-year) SCIENCE projections in 2019    ###
###                                                                          ###
################################################################################

SCIENCE_2019.config <- list(
    SCIENCE.2019 = list(
        sgp.content.areas=rep("SCIENCE", 2),
        sgp.baseline.content.areas=rep("SCIENCE", 2),
        sgp.panel.years=c("2017", "2019"),
        sgp.baseline.panel.years=c("2017", "2019"),
        sgp.grade.sequences=list(c("4", "6")),
        sgp.baseline.grade.sequences=list(c("4", "6")),
        sgp.projection.baseline.content.areas="SCIENCE",
        sgp.projection.baseline.panel.years="2019",
        sgp.projection.baseline.grade.sequences=list(c("4")),
        sgp.projection.sequence="SCIENCE_GRADE_4"),
    SCIENCE.2019 = list(
        sgp.content.areas=rep("SCIENCE", 3),
        sgp.baseline.content.areas=rep("SCIENCE", 3),
        sgp.baseline.panel.years=c("2016", "2017", "2019"),
        sgp.panel.years=c("2016", "2017", "2019"),
        sgp.grade.sequences=list(c("4", "5", "7")),
        sgp.baseline.grade.sequences=list(c("4", "5", "7")),
        sgp.projection.baseline.content.areas=rep("SCIENCE", 2),
        sgp.projection.baseline.panel.years=c("2018", "2019"),
        sgp.projection.baseline.grade.sequences=list(c("4", "5")),
        sgp.projection.sequence="SCIENCE_GRADE_5"),
    SCIENCE.2019 = list(
        sgp.content.areas=rep("SCIENCE", 3),
        sgp.baseline.content.areas=rep("SCIENCE", 3),
        sgp.baseline.panel.years=c("2016", "2017", "2019"),
        sgp.panel.years=c("2016", "2017", "2019"),
        sgp.grade.sequences=list(c("5", "6", "8")),
        sgp.baseline.grade.sequences=list(c("5", "6", "8")),
        sgp.projection.baseline.content.areas=rep("SCIENCE", 2),
        sgp.projection.baseline.panel.years=c("2018", "2019"),
        sgp.projection.baseline.grade.sequences=list(c("5", "6")),
        sgp.projection.sequence="SCIENCE_GRADE_6"),
    SCIENCE.2019 = list(
        sgp.content.areas=rep("SCIENCE", 3),
        sgp.baseline.content.areas=rep("SCIENCE", 3),
        sgp.baseline.panel.years=c("2016", "2017", "2019"),
        sgp.panel.years=c("2016", "2017", "2019"),
        sgp.grade.sequences=list(c("6", "7", "9")),
        sgp.baseline.grade.sequences=list(c("6", "7", "9")),
        sgp.projection.baseline.content.areas=rep("SCIENCE", 2),
        sgp.projection.baseline.panel.years=c("2018", "2019"),
        sgp.projection.baseline.grade.sequences=list(c("6", "7")),
        sgp.projection.sequence="SCIENCE_GRADE_7"),
    SCIENCE.2019 = list(
        sgp.content.areas=rep("SCIENCE", 3),
        sgp.baseline.content.areas=rep("SCIENCE", 3),
        sgp.baseline.panel.years=c("2016", "2017", "2019"),
        sgp.panel.years=c("2016", "2017", "2019"),
        sgp.grade.sequences=list(c("7", "8", "10")),
        sgp.baseline.grade.sequences=list(c("7", "8", "10")),
        sgp.projection.baseline.content.areas=rep("SCIENCE", 2),
        sgp.projection.baseline.panel.years=c("2018", "2019"),
        sgp.projection.baseline.grade.sequences=list(c("7", "8")),
        sgp.projection.sequence="SCIENCE_GRADE_8")
)
