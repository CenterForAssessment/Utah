################################################################################
###                                                                          ###
###   SGPstateData grade specific skip-year (LAGGED) projection sequences    ###
###                                                                          ###
################################################################################

###   Establish required meta-data for LAGGED projection sequences
SGPstateData[["GA"]][["Growth"]][["System_Type"]] <- "Baseline Referenced"

SGPstateData[["UT"]][["Growth"]][["System_Type"]] <- "Baseline Referenced"
# SGPstateData[["UT"]][["Assessment_Program_Information"]][["Assessment_Transition"]] <- NULL

#  Establish required meta-data for LAGGED projection sequences
SGPstateData[["UT"]][["SGP_Configuration"]][["grade.projection.sequence"]] <- list(
    ELA_GRADE_3=c(3, 4, 5, 6, 7, 8, 9, 10),
    ELA_GRADE_4=c(3, 4, 5, 6, 7, 8, 9, 10),
    ELA_GRADE_5=c(3, 5, 6, 7, 8, 9, 10),
    ELA_GRADE_6=c(3, 4, 6, 7, 8, 9, 10),
    ELA_GRADE_7=c(3, 4, 5, 7, 8, 9, 10),
    ELA_GRADE_8=c(3, 4, 5, 6, 8, 9, 10),
    ELA_GRADE_9=c(3, 4, 5, 6, 7, 9, 10),
    ELA_GRADE_10=c(3, 4, 5, 6, 7, 8, 10),
    SCIENCE_GRADE_4=c(4, 5, 6, 7, 8, 9, 10),
    SCIENCE_GRADE_5=c(4, 5, 6, 7, 8, 9, 10),
    SCIENCE_GRADE_6=c(4, 6, 7, 8, 9, 10),
    SCIENCE_GRADE_7=c(4, 5, 7, 8, 9, 10),
    SCIENCE_GRADE_8=c(4, 5, 6, 8, 9, 10),
    SCIENCE_GRADE_9=c(4, 5, 6, 7, 9, 10),
    SCIENCE_GRADE_10=c(4, 5, 6, 7, 8, 10),
    MATHEMATICS_GRADE_3=c(3, 4, 5, 6, 7, 8, 9, 10),
    MATHEMATICS_GRADE_4=c(3, 4, 5, 6, 7, 8, 9, 10),
    MATHEMATICS_GRADE_5=c(3, 5, 6, 7, 8, 9, 10),
    MATHEMATICS_GRADE_6=c(3, 4, 6, 7, 8, 9, 10),
    MATHEMATICS_GRADE_7=c(3, 4, 5, 7, 8, 9, 10),
    MATHEMATICS_GRADE_8=c(3, 4, 5, 6, 8, 9, 10),
    MATHEMATICS_GRADE_9=c(3, 4, 5, 6, 7, 9, 10),
    MATHEMATICS_GRADE_10=c(3, 4, 5, 6, 7, 8, 10))
SGPstateData[["UT"]][["SGP_Configuration"]][["content_area.projection.sequence"]] <- list(
    ELA_GRADE_3=rep("ELA", 8),
    ELA_GRADE_4=rep("ELA", 8),
    ELA_GRADE_5=rep("ELA", 7),
    ELA_GRADE_6=rep("ELA", 7),
    ELA_GRADE_7=rep("ELA", 7),
    ELA_GRADE_8=rep("ELA", 7),
    ELA_GRADE_9=rep("ELA", 7),
    ELA_GRADE_10=rep("ELA", 7),
    SCIENCE_GRADE_4=rep("SCIENCE", 7),
    SCIENCE_GRADE_5=rep("SCIENCE", 7),
    SCIENCE_GRADE_6=rep("SCIENCE", 6),
    SCIENCE_GRADE_7=rep("SCIENCE", 6),
    SCIENCE_GRADE_8=rep("SCIENCE", 6),
    SCIENCE_GRADE_9=rep("SCIENCE", 6),
    SCIENCE_GRADE_10=rep("SCIENCE", 6),
    MATHEMATICS_GRADE_3=rep("MATHEMATICS", 8),
    MATHEMATICS_GRADE_4=rep("MATHEMATICS", 8),
    MATHEMATICS_GRADE_5=rep("MATHEMATICS", 7),
    MATHEMATICS_GRADE_6=rep("MATHEMATICS", 7),
    MATHEMATICS_GRADE_7=rep("MATHEMATICS", 7),
    MATHEMATICS_GRADE_8=rep("MATHEMATICS", 7),
    MATHEMATICS_GRADE_9= rep("MATHEMATICS", 7),
    MATHEMATICS_GRADE_10=rep("MATHEMATICS", 7))
SGPstateData[["UT"]][["SGP_Configuration"]][["max.forward.projection.sequence"]] <- list(
    ELA_GRADE_3=3,
    ELA_GRADE_4=3,
    ELA_GRADE_5=3,
    ELA_GRADE_6=3,
    ELA_GRADE_7=3,
    ELA_GRADE_8=3,
    ELA_GRADE_9=3,
    ELA_GRADE_10=3,
    SCIENCE_GRADE_4=3,
    SCIENCE_GRADE_5=3,
    SCIENCE_GRADE_6=3,
    SCIENCE_GRADE_7=3,
    SCIENCE_GRADE_8=3,
    SCIENCE_GRADE_9=3,
    SCIENCE_GRADE_10=3,
    MATHEMATICS_GRADE_3=3,
    MATHEMATICS_GRADE_4=3,
    MATHEMATICS_GRADE_5=3,
    MATHEMATICS_GRADE_6=3,
    MATHEMATICS_GRADE_7=3,
    MATHEMATICS_GRADE_8=3,
    MATHEMATICS_GRADE_9=3,
    MATHEMATICS_GRADE_10=3)
