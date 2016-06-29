#############################################################
##  End-of-Grade Test CONFIGURATION FILE - 2015
#############################################################

ELA_2015.config <- list(
	ELA.2015 = list(
		sgp.content.areas=rep('ELA', 6),
		sgp.panel.years=as.character(2010:2015),
		sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('3', '4', '5', '6'), c('3', '4', '5', '6', '7'), c('3', '4', '5', '6', '7', '8'), c('4', '5', '6', '7', '8', '9'), c('5', '6', '7', '8', '9', '10'), c('6', '7', '8', '9', '10', '11'))
	)
)

SCIENCE_2015.config <- list(
	SCIENCE.2015 = list(
		sgp.content.areas=rep('SCIENCE', 5),
		sgp.panel.years=as.character(2011:2015),
		sgp.grade.sequences=list(c('4', '5'), c('4', '5', '6'), c('4', '5', '6', '7'), c('4', '5', '6', '7', '8')),
		sgp.projection.sequence = c("SCIENCE", "SCIENCE_BIO")
	)
)

MATHEMATICS_2015.config <- list(
	MATHEMATICS.2015 = list(
		sgp.content.areas=rep('MATHEMATICS', 6),
		sgp.panel.years=as.character(2010:2015),
		sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('3', '4', '5', '6'), c('3', '4', '5', '6', '7'), c('3', '4', '5', '6', '7', '8'))
	)
)
