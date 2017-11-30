#############################################################
# EOCT CONFIGURATION FILE - SECONDARY MATHEMATICS
#############################################################

SEC_MATH_I_2017.config <- list(
	SEC_MATH_I.2017 = list(
		sgp.content.areas=c('SEC_MATH_I', 'SEC_MATH_I'), #Repeater
		sgp.panel.years=as.character(2016:2017),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0),
	SEC_MATH_I.2017 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 3), 'SEC_MATH_I'),
		sgp.panel.years=as.character(2014:2017),
		sgp.grade.sequences=list(c(6:8, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS", # max.order.for.projection = 1
		sgp.norm.group.preference=1),
	SEC_MATH_I.2017 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2), 'SEC_MATH_I'),
		sgp.panel.years=as.character(2015:2017),
		sgp.grade.sequences=list(c(7:8, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS", # max.order.for.projection = 1
		sgp.norm.group.preference=2),
	SEC_MATH_I.2017 = list(
	  sgp.content.areas=c('MATHEMATICS', 'SEC_MATH_I'),
	  sgp.panel.years=as.character(2016:2017),
	  sgp.grade.sequences=list(c(8, 'EOCT')),
	  sgp.exact.grade.progression=TRUE,
	  sgp.norm.group.preference=3),
# ACCELERATED (MATH 8 TAKEN IN SAME YEAR AS SEC_MATH_I)
	SEC_MATH_I.2017 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2), 'SEC_MATH_I'),
		sgp.panel.years=as.character(2015:2017),
		sgp.grade.sequences=list(c(6:7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS", # max.order.for.projection = 1
		sgp.norm.group.preference=1),
	SEC_MATH_I.2017 = list(
		sgp.content.areas=c('MATHEMATICS', 'SEC_MATH_I'),
		sgp.panel.years=as.character(2016:2017),
		sgp.grade.sequences=list(c(7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2)
)
#############################################################
SEC_MATH_II_2017.config <- list(
	SEC_MATH_II.2017 = list(
		sgp.content.areas=c('SEC_MATH_II', 'SEC_MATH_II'), #Repeater
		sgp.panel.years=as.character(2016:2017),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0),
	SEC_MATH_II_2017 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2), 'SEC_MATH_I', 'SEC_MATH_II'),
		sgp.panel.years=as.character(2014:2017),
		sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS", # max.order.for.projection = 1
		sgp.norm.group.preference=1),
	SEC_MATH_II_2017 = list(
		sgp.content.areas=c('MATHEMATICS', 'SEC_MATH_I', 'SEC_MATH_II'),
		sgp.panel.years=as.character(2015:2017),
		sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS", # max.order.for.projection = 1
		sgp.norm.group.preference=2),
	SEC_MATH_II_2017 = list(
	  sgp.content.areas=c('SEC_MATH_I', 'SEC_MATH_II'),
	  sgp.panel.years=as.character(2016:2017),
	  sgp.grade.sequences=list(c('EOCT', 'EOCT')),
	  sgp.exact.grade.progression=TRUE,
	  sgp.norm.group.preference=3)
)
#############################################################
SEC_MATH_III_2017.config <- list(
  SEC_MATH_III.2017 = list(
		sgp.content.areas=c('SEC_MATH_III', 'SEC_MATH_III'), #Repeater
		sgp.panel.years=as.character(2016:2017),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0),
	SEC_MATH_III_2017 = list(
		sgp.content.areas=c('MATHEMATICS', 'SEC_MATH_I', 'SEC_MATH_II', 'SEC_MATH_III'),
		sgp.panel.years=as.character(2014:2017),
		sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT','EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS", # max.order.for.projection = 1
		sgp.norm.group.preference=1),
  SEC_MATH_III.2017 = list(
		sgp.content.areas=c('SEC_MATH_I', 'SEC_MATH_II', 'SEC_MATH_III'),
		sgp.panel.years=as.character(2015:2017),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS", # max.order.for.projection = 1
		sgp.norm.group.preference=2),
  SEC_MATH_III.2017 = list(
    sgp.content.areas=c('SEC_MATH_II', 'SEC_MATH_III'),
    sgp.panel.years=as.character(2016:2017),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.exact.grade.progression=TRUE,
    sgp.norm.group.preference=3)
)
