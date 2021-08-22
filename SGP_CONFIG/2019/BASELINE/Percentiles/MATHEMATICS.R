################################################################################
###                                                                          ###
###           Skip-year SGP Configurations for 2019 Math subjects            ###
###                                                                          ###
################################################################################

MATHEMATICS_2019.config <- list(
	MATHEMATICS_2019 = list(
		sgp.content.areas=rep("MATHEMATICS", 3),
		sgp.panel.years=c("2016", "2017", "2019"),
		sgp.grade.sequences=list(c("3", "5"), c("3", "4", "6"), c("4", "5", "7"), c("5", "6", "8"), c("6", "7", "9"), c("7", "8", "10")),
		sgp.norm.group.preference=1L)
)

SEC_MATH_I_2019.config <- list(
	SEC_MATH_I_2019 = list(
		sgp.content.areas = c("MATHEMATICS", "MATHEMATICS", "SEC_MATH_I"),
		sgp.panel.years = c("2016", "2017", "2019"),
		sgp.grade.sequences = list(c("5", "6", "EOCT")),
		sgp.norm.group.preference = 1L)
)
