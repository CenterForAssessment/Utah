################################################################################
###                                                                          ###
###           Skip-year SGP Configurations for 2021 Math subjects            ###
###                                                                          ###
################################################################################

MATHEMATICS_2021.config <- list(
	MATHEMATICS_2021 = list(
		sgp.content.areas=rep("MATHEMATICS", 3),
		sgp.panel.years=c("2018", "2019", "2021"),
		sgp.grade.sequences=list(c("3", "5"), c("3", "4", "6"), c("4", "5", "7"), c("5", "6", "8"), c("6", "7", "9"), c("7", "8", "10")))
)

SEC_MATH_I_2021.config <- list(
	SEC_MATH_I_2021 = list(
		sgp.content.areas = c("MATHEMATICS", "MATHEMATICS", "SEC_MATH_I"),
		sgp.panel.years = c("2018", "2019", "2021"),
		sgp.grade.sequences = list(c("5", "6", "EOCT")))
)
