###########################################################################
###                                                                     ###
###     Utah EOCT CONFIGURATION FILE  -  2018 SECONDARY MATHEMATICS     ###
###                                                                     ###
###########################################################################


SEC_MATH_I_2018.config <- list(
	# REPEATER
	SEC_MATH_I.2018 = list(
		sgp.content.areas=c('SEC_MATH_I','SEC_MATH_I'),
		sgp.panel.years=as.character(2017:2018),
		sgp.grade.sequences=list(c('EOCT','EOCT')),
		sgp.norm.group.preference=0),

	# CANONICAL
	SEC_MATH_I.2018 = list(
	  sgp.content.areas=c(rep('MATHEMATICS', 4), 'SEC_MATH_I'),
	  sgp.panel.years=as.character(2014:2018),
	  sgp.grade.sequences=list(c(5:8,'EOCT')),
	  sgp.norm.group.preference=1),

	# ACCELERATED (MATH 8 TAKEN IN SAME YEAR AS SEC_MATH_I)
	SEC_MATH_I.2018 = list(
	  sgp.content.areas=c(rep('MATHEMATICS', 4), 'SEC_MATH_I'),
	  sgp.panel.years=as.character(2014:2018),
	  sgp.grade.sequences=list(c(4:7,'EOCT')),
	  sgp.norm.group.preference=2)
)

#############################################################

SEC_MATH_II_2018.config <- list(
	# REPEATER
	SEC_MATH_II.2018 = list(
		sgp.content.areas=c('SEC_MATH_II','SEC_MATH_II'),
		sgp.panel.years=as.character(2017:2018),
		sgp.grade.sequences=list(c('EOCT','EOCT')),
		sgp.norm.group.preference=0),

	# CANONICAL
	SEC_MATH_II_2018 = list(
	  sgp.content.areas=c(rep('MATHEMATICS', 3), 'SEC_MATH_I', 'SEC_MATH_II'),
	  sgp.panel.years=as.character(2014:2018),
	  sgp.grade.sequences=list(c(6:8,'EOCT','EOCT')),
	  sgp.norm.group.preference=1)
)

#############################################################

SEC_MATH_III_2018.config <- list(
	# REPEATER
  SEC_MATH_III.2018 = list(
		sgp.content.areas=c('SEC_MATH_III','SEC_MATH_III'),
		sgp.panel.years=as.character(2017:2018),
		sgp.grade.sequences=list(c('EOCT','EOCT')),
		sgp.norm.group.preference=0),

	# CANONICAL
  SEC_MATH_III_2018 = list(
    sgp.content.areas=c(rep('MATHEMATICS', 2),'SEC_MATH_I','SEC_MATH_II','SEC_MATH_III'),
    sgp.panel.years=as.character(2014:2018),
    sgp.grade.sequences=list(c(7:8,'EOCT','EOCT','EOCT')),
    sgp.norm.group.preference=1)
)
