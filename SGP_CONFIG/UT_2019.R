################################################################################
###                                                                          ###
###       Scripts for 2019 Utah RISE and Aspire Plus SGP Configurations      ###
###                                                                          ###
################################################################################

###  5 priors MAX for all analyses

ELA_2019.config <- list(
	ELA.2019 = list(
		sgp.content.areas=rep('ELA', 6),
		sgp.panel.years=as.character(2014:2019),
		sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('3', '4', '5', '6'), c('3', '4', '5', '6', '7'), c('3', '4', '5', '6', '7', '8'), # RISE
														 c('4', '5', '6', '7', '8', '9'), c('5', '6', '7', '8', '9', '10')), # Aspire Plus
		sgp.norm.group.preference=1
	)
)

MATHEMATICS_2019.config <- list(
	MATHEMATICS.2019 = list(
		sgp.content.areas=rep('MATHEMATICS', 6),
		sgp.panel.years=as.character(2014:2019),
		sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('3', '4', '5', '6'), c('3', '4', '5', '6', '7'), c('3', '4', '5', '6', '7', '8'), # RISE
														 c('4', '5', '6', '7', '8', '9'), c('5', '6', '7', '8', '9', '10')), # Aspire Plus
		sgp.norm.group.preference=1
	)
)

	# MATHEMATICS_UAP_9.2019 = list(
	# 	sgp.content.areas=rep('MATHEMATICS', 6),
	# 	sgp.panel.years=as.character(2014:2019),
	# 	sgp.grade.sequences=list(c('4', '5', '6', '7', '8', '9')),
	# 	sgp.norm.group.preference=1
	# ),
	# MATHEMATICS_UAP_9.2019 = list( # Just below 3000 threshold
	# 	sgp.content.areas=c('SEC_MATH_I', 'MATHEMATICS'),
	# 	sgp.panel.years=as.character(2018:2019),
	# 	sgp.grade.sequences=list(c('EOCT', '9')),
	# 	sgp.norm.group.preference=2
	# ),

	# MATHEMATICS_UAP_10.2019 = list(
	# 	sgp.content.areas=c(rep('MATHEMATICS', 4), 'SEC_MATH_I', 'MATHEMATICS'),
	# 	sgp.panel.years=as.character(2014:2019),
	# 	sgp.grade.sequences=list(c('5', '6', '7', '8', 'EOCT', '10')),
	# 	sgp.norm.group.preference=1,
	# 	sgp.projection.sequence = "MATH_UAP10"
	# ),
	# MATHEMATICS_UAP_10.2019 = list( # Just below 3000 threshold
	# 	sgp.content.areas=c('SEC_MATH_II', 'MATHEMATICS'),
	# 	sgp.panel.years=as.character(2018:2019),
	# 	sgp.norm.group.preference=2,
	# 	sgp.grade.sequences=list(c('EOCT', '10'))
	# )
# )

SCIENCE_2019.config <- list(
	SCIENCE.2019 = list(
		sgp.content.areas=rep('SCIENCE', 6),
		sgp.panel.years=as.character(2014:2019),
		sgp.grade.sequences=list(c('4', '5'), c('4', '5', '6'), c('4', '5', '6', '7'), c('4', '5', '6', '7', '8'), # RISE
														 c('4', '5', '6', '7', '8', '9'), c('5', '6', '7', '8', '9', '10')), # Aspire Plus
		sgp.norm.group.preference=1,
		sgp.projection.sequence = "ESCI_SCIENCE"
	)
)

# 	SCIENCE_UAP_9.2019 = list(
# 		sgp.content.areas=rep('SCIENCE', 6),
# 		sgp.panel.years=as.character(2014:2019),
# 		sgp.grade.sequences=list(c('4', '5', '6', '7', '8', '9'))
# 	),
#
# 	SCIENCE_UAP_10.2019 = list(
# 		sgp.content.areas=c(rep('SCIENCE', 4), 'EARTH_SCIENCE', 'SCIENCE'),
# 		sgp.panel.years=as.character(2014:2019),
# 		sgp.grade.sequences=list(c('5', '6', '7', '8', 'EOCT', '10')),
# 		sgp.norm.group.preference=1,
# 		sgp.projection.sequence = "EARTH_SCI_UAP10"
# 	),
# 	SCIENCE_UAP_10.2019 = list(
# 		sgp.content.areas=c(rep('SCIENCE', 4), 'BIOLOGY', 'SCIENCE'),
# 		sgp.panel.years=as.character(2014:2019),
# 		sgp.grade.sequences=list(c('5', '6', '7', '8', 'EOCT', '10')),
# 		sgp.norm.group.preference=2,
# 		sgp.projection.sequence = "BIOLOGY_UAP10"
# 	),
# 	SCIENCE_UAP_10.2019 = list( # Below 3000 threshold
# 		sgp.content.areas=c('PHYSICS', 'SCIENCE'),
# 		sgp.panel.years=as.character(2018:2019),
# 		sgp.grade.sequences=list(c('EOCT', '10')),
# 		sgp.norm.group.preference=3,
# 		sgp.projection.sequence = "PHYSICS_UAP10"
# 	)
# )
