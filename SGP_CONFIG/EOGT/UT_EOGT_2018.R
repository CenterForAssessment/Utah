#############################################################
##  End-of-Grade Test CONFIGURATION FILE - 2018
#############################################################

###  5 Priors MAX for End-of-Grade Analyses

ELA_2018.config <- list(
	ELA.2018 = list(
		sgp.content.areas=rep('ELA', 6),
		sgp.panel.years=as.character(2013:2018),
		sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('3', '4', '5', '6'), c('3', '4', '5', '6', '7'), c('3', '4', '5', '6', '7', '8'), c('4', '5', '6', '7', '8', '9'), c('5', '6', '7', '8', '9', '10'), c('6', '7', '8', '9', '10', '11'))
	)
)

SCIENCE_2018.config <- list(
	SCIENCE.2018 = list(
		sgp.content.areas=rep('SCIENCE', 5),
		sgp.panel.years=as.character(2014:2018),
		sgp.grade.sequences=list(c('4', '5'), c('4', '5', '6'), c('4', '5', '6', '7'), c('4', '5', '6', '7', '8')),
		sgp.projection.sequence = c("SCIENCE", "SCIENCE_BIO")
	)
)

MATHEMATICS_2018.config <- list(
	MATHEMATICS.2018 = list(
		sgp.content.areas=rep('MATHEMATICS', 6),
		sgp.panel.years=as.character(2013:2018),
		sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('3', '4', '5', '6'), c('3', '4', '5', '6', '7'), c('3', '4', '5', '6', '7', '8'))
	)
)
