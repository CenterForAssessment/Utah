#############################################################
##  End-of-Grade Test CONFIGURATION FILE - 2016
#############################################################

ELA_2016.config <- list(
	ELA.2016 = list(
		sgp.content.areas=rep('ELA', 6),
		sgp.panel.years=as.character(2011:2016),
		sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('3', '4', '5', '6'), c('3', '4', '5', '6', '7'), c('3', '4', '5', '6', '7', '8'), c('4', '5', '6', '7', '8', '9'), c('5', '6', '7', '8', '9', '10'), c('6', '7', '8', '9', '10', '11'))
	)
)

SCIENCE_2016.config <- list(
	SCIENCE.2016 = list(
		sgp.content.areas=rep('SCIENCE', 5),
		sgp.panel.years=as.character(2012:2016),
		sgp.grade.sequences=list(c('4', '5'), c('4', '5', '6'), c('4', '5', '6', '7'), c('4', '5', '6', '7', '8')),
		sgp.projection.sequence = c("SCIENCE", "SCIENCE_BIO")
	)
)

MATHEMATICS_2016.config <- list(
	MATHEMATICS.2016 = list(
		sgp.content.areas=rep('MATHEMATICS', 6),
		sgp.panel.years=as.character(2011:2016),
		sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('3', '4', '5', '6'), c('3', '4', '5', '6', '7'), c('3', '4', '5', '6', '7', '8'))
	)
)


###########
# SAGE ONLY
# ELA_2016.config <- list(
# 	ELA.2016 = list(
# 		sgp.content.areas=rep('ELA', 3),
# 		sgp.panel.years=as.character(2014:2016),
# 		sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('4', '5', '6'), c('5', '6', '7'), c('6', '7', '8'), c('7', '8', '9'), c('8', '9', '10'), c('9', '10', '11'))
# 	)
# )

# SCIENCE_2016.config <- list(
# 	SCIENCE.2016 = list(
# 		sgp.content.areas=rep('SCIENCE', 3),
# 		sgp.panel.years=as.character(2014:2016),
# 		sgp.grade.sequences=list(c('4', '5'), c('4', '5', '6'), c('5', '6', '7'), c('6', '7', '8')),
# 		sgp.projection.sequence = c("SCIENCE", "SCIENCE_BIO")
# 	)
# )

# MATHEMATICS_2016.config <- list(
# 	MATHEMATICS.2016 = list(
# 		sgp.content.areas=rep('MATHEMATICS', 3),
# 		sgp.panel.years=as.character(2014:2016),
# 		sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('4', '5', '6'), c('5', '6', '7'), c('6', '7', '8'))
# 	)
# )
