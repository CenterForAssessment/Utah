# EOCT CONFIGURATION FILE - SECONDARY MATHEMATICS
#############################################################
SEC_MATH_I_2014.config <- list(
# REPEATER
	SEC_MATH_I.2014 = list(
		sgp.content.areas=c('PRE_ALGEBRA','ALGEBRA_I','SEC_MATH_I'),
		sgp.panel.years=as.character(2012:2014),
		sgp.grade.sequences=list(c('EOCT','EOCT','EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0),
	SEC_MATH_I.2014 = list(
		sgp.content.areas=c('ALGEBRA_I','SEC_MATH_I'),
		sgp.panel.years=as.character(2013:2014),
		sgp.grade.sequences=list(c('EOCT','EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
# AVI - The Math 8 to SEC Math I sequence will not come into play until 2015 when it is SAGE Math 8.
# 	    All CRT Math 8 was labeled as Pre-Algebra, so there will be no kids with CRT Grade 8 math to SEC Math I
# MATH 8 SEQUENCES (NEW NORM)
	# SEC_MATH_I.2014 = list(
		# sgp.content.areas=c(rep('MATHEMATICS', 5), 'SEC_MATH_I'),
		# sgp.panel.years=as.character(2009:2014),
		# sgp.grade.sequences=list(c(4:8, 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),
	# SEC_MATH_I.2014 = list(
		# sgp.content.areas=c(rep('MATHEMATICS', 4), 'SEC_MATH_I'),
		# sgp.panel.years=as.character(2010:2014),
		# sgp.grade.sequences=list(c(5:8, 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),	
	# SEC_MATH_I.2014 = list(
		# sgp.content.areas=c(rep('MATHEMATICS', 3), 'SEC_MATH_I'),
		# sgp.panel.years=as.character(2011:2014),
		# sgp.grade.sequences=list(c(6:8, 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=3),
	# SEC_MATH_I.2014 = list(
		# sgp.content.areas=c(rep('MATHEMATICS', 2), 'SEC_MATH_I'),
		# sgp.panel.years=as.character(2012:2014),
		# sgp.grade.sequences=list(c(7:8, 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=4),	
## VIA MATH 6 AND PRE-ALGEBRA - AVI - revisit this progression in 2015.  
# 	There may be kids that had 7th grade pre-algebra (2013), 8th grade Math (2014) and then SEC Math I (2015), but not a feasible progression in 2014
	# SEC_MATH_I.2014 = list(
		# sgp.content.areas=c(rep('MATHEMATICS', 3), 'PRE_ALGEBRA', 'MATHEMATICS', 'SEC_MATH_I'),
		# sgp.panel.years=as.character(2009:2014),
		# sgp.grade.sequences=list(c(4:6, 'EOCT', 8, 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),
	# SEC_MATH_I.2014 = list(
		# sgp.content.areas=c(rep('MATHEMATICS', 2), 'PRE_ALGEBRA', 'MATHEMATICS', 'SEC_MATH_I'),
		# sgp.panel.years=as.character(2010:2014),
		# sgp.grade.sequences=list(c(5:6, 'EOCT', 8, 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),
	# SEC_MATH_I.2014 = list(
		# sgp.content.areas=c('MATHEMATICS', 'PRE_ALGEBRA', 'MATHEMATICS', 'SEC_MATH_I'),
		# sgp.panel.years=as.character(2011:2014),
		# sgp.grade.sequences=list(c(6, 'EOCT', 8, 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=3),
# # ONLY MATH 8
	# SEC_MATH_I.2014 = list(
		# sgp.content.areas=c('MATHEMATICS', 'SEC_MATH_I'),
		# sgp.panel.years=as.character(2013:2014),
		# sgp.grade.sequences=list(c(8, 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=5),
# PRE-ALGEBRA SEQUENCES (VIA MATH 7)
	SEC_MATH_I.2014 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 4), 'PRE_ALGEBRA', 'SEC_MATH_I'),
		sgp.panel.years=as.character(2009:2014),
		sgp.grade.sequences=list(c(4:7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	SEC_MATH_I.2014 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 3), 'PRE_ALGEBRA', 'SEC_MATH_I'),
		sgp.panel.years=as.character(2010:2014),
		sgp.grade.sequences=list(c(5:7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	SEC_MATH_I.2014 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2), 'PRE_ALGEBRA', 'SEC_MATH_I'),
		sgp.panel.years=as.character(2011:2014),
		sgp.grade.sequences=list(c(6:7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	SEC_MATH_I.2014 = list(
		sgp.content.areas=c('MATHEMATICS', 'PRE_ALGEBRA', 'SEC_MATH_I'),
		sgp.panel.years=as.character(2012:2014),
		sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
# ONLY PRE-ALGEBRA
	SEC_MATH_I.2014 = list(
		sgp.content.areas=c('PRE_ALGEBRA', 'SEC_MATH_I'),
		sgp.panel.years=as.character(2012:2014),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5)
)
#############################################################
SEC_MATH_II_2014.config <- list(
# RETREATER
	  SEC_MATH_II_2014 = list(
		sgp.content.areas=c('ALGEBRA_II', 'SEC_MATH_II'),  
		sgp.panel.years=as.character(2013:2014),
		sgp.grade.sequences=list(c('EOCT','EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0),
# REPEATER
  SEC_MATH_II_2014 = list(
		sgp.content.areas=c('GEOMETRY', 'SEC_MATH_II'),  
		sgp.panel.years=as.character(2013:2014),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0),
# PRE-ALGEBRA SEQUENCES
# EXCLUDING MATH 7
	SEC_MATH_II_2014 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 3), 'PRE_ALGEBRA', 'ALGEBRA_I', 'SEC_MATH_II'),
		sgp.panel.years=as.character(2009:2014),
		sgp.grade.sequences=list(c(4:6, 'EOCT', 'EOCT', 'EOCT')),  
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	SEC_MATH_II_2014 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2), 'PRE_ALGEBRA', 'ALGEBRA_I', 'SEC_MATH_II'),
		sgp.panel.years=as.character(2010:2014),
		sgp.grade.sequences=list(c(5:6, 'EOCT', 'EOCT', 'EOCT')),  
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	SEC_MATH_II_2014 = list(
		sgp.content.areas=c('MATHEMATICS', 'PRE_ALGEBRA', 'ALGEBRA_I', 'SEC_MATH_II'),
		sgp.panel.years=as.character(2011:2014),
		sgp.grade.sequences=list(c(6, 'EOCT', 'EOCT', 'EOCT')),  
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
# INCLUDING MATH 7
	SEC_MATH_II_2014 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 3), 'PRE_ALGEBRA', 'ALGEBRA_I', 'SEC_MATH_II'),
		sgp.panel.years=as.character(2009:2014),
		sgp.grade.sequences=list(c(5:7, 'EOCT', 'EOCT', 'EOCT')),  
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	SEC_MATH_II_2014 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2), 'PRE_ALGEBRA', 'ALGEBRA_I', 'SEC_MATH_II'),
		sgp.panel.years=as.character(2010:2014),
		sgp.grade.sequences=list(c(6:7, 'EOCT', 'EOCT', 'EOCT')),  
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	SEC_MATH_II_2014 = list(
		sgp.content.areas=c('MATHEMATICS', 'PRE_ALGEBRA', 'ALGEBRA_I', 'SEC_MATH_II'),
		sgp.panel.years=as.character(2011:2014),
		sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT', 'EOCT')),  
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
# INCLUDING MATH 8 BUT EXCLUDING MATH 7
# AVI - again, no grade 8 Math, so this progression is not feasible.
	# SEC_MATH_II_2014 = list(
		# sgp.content.areas=c(rep('MATHEMATICS', 2), 'PRE_ALGEBRA', 'MATHEMATICS', 'ALGEBRA_I', 'SEC_MATH_II'),
		# sgp.panel.years=as.character(2009:2014),
		# sgp.grade.sequences=list(c(5:6, 'EOCT', 8, 'EOCT', 'EOCT')),  
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),
	# SEC_MATH_II_2014 = list(
		# sgp.content.areas=c('MATHEMATICS', 'PRE_ALGEBRA', 'MATHEMATICS', 'ALGEBRA_I', 'SEC_MATH_II'),
		# sgp.panel.years=as.character(2010:2014),
		# sgp.grade.sequences=list(c(6, 'EOCT', 8, 'EOCT', 'EOCT')),  
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),
# INCLUDING MATH 8 AND INCLUDING MATH 7
	# SEC_MATH_II_2014 = list(
		# sgp.content.areas=c(rep('MATHEMATICS', 2), 'PRE_ALGEBRA', 'MATHEMATICS', 'ALGEBRA_I', 'SEC_MATH_II'),
		# sgp.panel.years=as.character(2009:2014),
		# sgp.grade.sequences=list(c(6:7, 'EOCT', 8, 'EOCT', 'EOCT')),  
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),
	# SEC_MATH_II_2014 = list(
		# sgp.content.areas=c('MATHEMATICS', 'PRE_ALGEBRA', 'MATHEMATICS', 'ALGEBRA_I', 'SEC_MATH_II'),
		# sgp.panel.years=as.character(2010:2014),
		# sgp.grade.sequences=list(c(7, 'EOCT', 8, 'EOCT', 'EOCT')),  
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),
# ONLY PRE-ALGEBRA
	SEC_MATH_II_2014 = list(
		sgp.content.areas=c('PRE_ALGEBRA', 'ALGEBRA_I', 'SEC_MATH_II'),
		sgp.panel.years=as.character(2012:2014),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),  
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	# SEC_MATH_II_2014 = list(
		# sgp.content.areas=c('PRE_ALGEBRA', 'MATHEMATICS', 'ALGEBRA_I', 'SEC_MATH_II'),
		# sgp.panel.years=as.character(2011:2014),
		# sgp.grade.sequences=list(c('EOCT', 8, 'EOCT', 'EOCT')),  
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=3),
# MATH 8 SEQUENCES
# AVI - No 8th grade Math.  These progressions get covered above in c(*, 'PRE_ALGEBRA', 'MATHEMATICS', 'ALGEBRA_I', 'SEC_MATH_II')
	# SEC_MATH_II_2014 = list(
		# sgp.content.areas=c(rep('MATHEMATICS'),4), 'ALGEBRA_I', 'SEC_MATH_II'),
		# sgp.panel.years=as.character(2009:2014),
		# sgp.grade.sequences=list(c(5:8, 'EOCT', 'EOCT')),  
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),
	# SEC_MATH_II_2014 = list(
		# sgp.content.areas=c(rep('MATHEMATICS'),3), 'ALGEBRA_I', 'SEC_MATH_II'),
		# sgp.panel.years=as.character(2010:2014),
		# sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT')),  
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),
	# SEC_MATH_II_2014 = list(
		# sgp.content.areas=c(rep('MATHEMATICS'),2), 'ALGEBRA_I', 'SEC_MATH_II'),
		# sgp.panel.years=as.character(2011:2014),
		# sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT')),  
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=3),
	# SEC_MATH_II_2014 = list(
		# sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'SEC_MATH_II'),
		# sgp.panel.years=as.character(2012:2014),
		# sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),  
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=4),
# ONLY ALGEBRA I
	SEC_MATH_II_2014 = list(
		sgp.content.areas=c('ALGEBRA_I','SEC_MATH_II'),
		sgp.panel.years=as.character(2013:2014),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),  
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5)
)
#############################################################
SEC_MATH_III.config <- list(
# REPEATER:
  SEC_MATH_III.2014 = list(
		sgp.content.areas=c('ALGEBRA_II','SEC_MATH_III'),  
		sgp.panel.years=as.character(2013:2014),
		sgp.grade.sequences=list(c('EOCT','EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0),
# VIA MATH 6, SKIPPING MATH 7 (MATH 8 IS NOT APPLICABLE BECAUSE IT DID NOT BECOME AVAILABLE UNTIL 2012)
	SEC_MATH_III.2014 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2),'PRE_ALGEBRA','ALGEBRA_I','GEOMETRY','SEC_MATH_III'),
		sgp.panel.years=as.character(2009:2014),
		sgp.grade.sequences=list(c(5:6,'EOCT','EOCT','EOCT','EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	SEC_MATH_III.2014 = list(
		sgp.content.areas=c('MATHEMATICS','PRE_ALGEBRA','ALGEBRA_I','GEOMETRY','SEC_MATH_III'),
		sgp.panel.years=as.character(2010:2014),
		sgp.grade.sequences=list(c(6,'EOCT','EOCT','EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
# VIA MATH 7
	SEC_MATH_III.2014 = list(
		sgp.content.areas=c(rep('MATHEMATICS',2),'PRE_ALGEBRA','ALGEBRA_I','GEOMETRY','SEC_MATH_III'),
		sgp.panel.years=as.character(2009:2014),
		sgp.grade.sequences=list(c(6:7,'EOCT','EOCT','EOCT','EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	SEC_MATH_III.2014 = list(
		sgp.content.areas=c('MATHEMATICS','PRE_ALGEBRA','ALGEBRA_I','GEOMETRY','SEC_MATH_III'),
		sgp.panel.years=as.character(2010:2014),
		sgp.grade.sequences=list(c(7,'EOCT','EOCT','EOCT','EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
#
	SEC_MATH_III.2014 = list(
		sgp.content.areas=c('PRE_ALGEBRA','ALGEBRA_I','GEOMETRY','SEC_MATH_III'),
		sgp.panel.years=as.character(2011:2014),
		sgp.grade.sequences=list(c('EOCT','EOCT','EOCT','EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	SEC_MATH_III.2014 = list(
		sgp.content.areas=c('ALGEBRA_I','GEOMETRY','SEC_MATH_III'),
		sgp.panel.years=as.character(2012:2014),
		sgp.grade.sequences=list(c('EOCT','EOCT','EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	SEC_MATH_III.2014 = list(
		sgp.content.areas=c('GEOMETRY','SEC_MATH_III'),
		sgp.panel.years=as.character(2013:2014),
		sgp.grade.sequences=list(c('EOCT','EOCT','EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5)	
)