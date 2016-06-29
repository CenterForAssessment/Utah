#############################################################
##  EOCT CONFIGURATION FILE - SECONDARY MATHEMATICS
#############################################################

# SAGE ONLY ##############################################################################
# SEC_MATH_I_2016.config <- list(
#   SEC_MATH_I.2016 = list(
#     sgp.content.areas=c('SEC_MATH_I','SEC_MATH_I'),
#     sgp.panel.years=as.character(2015:2016),
#     sgp.grade.sequences=list(c('EOCT','EOCT')),
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=0),
#   SEC_MATH_I.2016 = list(
#     sgp.content.areas=c(rep('MATHEMATICS', 2), 'SEC_MATH_I'),
#     sgp.panel.years=as.character(2014:2016),
#     sgp.grade.sequences=list(c(7:8, 'EOCT')),  
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=1),
#   SEC_MATH_I.2016 = list(
#     sgp.content.areas=c('MATHEMATICS', 'SEC_MATH_I'),
#     sgp.panel.years=as.character(2015:2016),
#     sgp.grade.sequences=list(c(8, 'EOCT')),  
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=2)
# )
# SEC_MATH_II_2016.config <- list(
#   SEC_MATH_II.2016 = list(
#     sgp.content.areas=c('SEC_MATH_II','SEC_MATH_II'),
#     sgp.panel.years=as.character(2015:2016),
#     sgp.grade.sequences=list(c('EOCT','EOCT')),
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=0),
#   SEC_MATH_II.2016 = list(
#     sgp.content.areas=c('MATHEMATICS', 'SEC_MATH_I', 'SEC_MATH_II'),
#     sgp.panel.years=as.character(2014:2016),
#     sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),  
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=1),
#   SEC_MATH_II.2016 = list(
#     sgp.content.areas=c('SEC_MATH_I', 'SEC_MATH_II'),
#     sgp.panel.years=as.character(2015:2016),
#     sgp.grade.sequences=list(c('EOCT', 'EOCT')),  
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=2)
# )
# SEC_MATH_III_2016.config <- list(
#   SEC_MATH_III.2016 = list(
#     sgp.content.areas=c('SEC_MATH_III','SEC_MATH_III'),
#     sgp.panel.years=as.character(2015:2016),
#     sgp.grade.sequences=list(c('EOCT','EOCT')),
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=0),
#   SEC_MATH_III.2016 = list(
#     sgp.content.areas=c('SEC_MATH_I','SEC_MATH_II','SEC_MATH_III'),
#     sgp.panel.years=as.character(2014:2016),
#     sgp.grade.sequences=list(c('EOCT','EOCT','EOCT')),
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=1),
#   SEC_MATH_III.2016 = list(
#     sgp.content.areas=c('SEC_MATH_II','SEC_MATH_III'),
#     sgp.panel.years=as.character(2015:2016),
#     sgp.grade.sequences=list(c('EOCT','EOCT')),
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=2)
# )

#####################################################################################
SEC_MATH_I_2016.config <- list(
  SEC_MATH_I.2016 = list(
    sgp.content.areas=c('SEC_MATH_I','SEC_MATH_I'), #Repeater
    sgp.panel.years=as.character(2015:2016),
    sgp.grade.sequences=list(c('EOCT','EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0),
  
  # 	SEC_MATH_I.2016 = list( # Max Percentile order of 5! Now also encoded in SGPstateData
  # 		sgp.content.areas=c(rep('MATHEMATICS', 6), 'SEC_MATH_I'),
  # 		sgp.panel.years=as.character(2009:2016),
  # 		sgp.grade.sequences=list(c(3:8,'EOCT')),
  # 		sgp.projection.grade.sequences=TRUE,
  # 		sgp.norm.group.preference=1),
  SEC_MATH_I.2016 = list(
    sgp.content.areas=c(rep('MATHEMATICS', 5), 'SEC_MATH_I'),
    sgp.panel.years=as.character(2011:2016),
    sgp.grade.sequences=list(c(4:8,'EOCT')),
    # sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=1)
  
  ##  ACCELERATED (MATH 8 TAKEN IN SAME YEAR AS SEC_MATH_I)
  ##  Not enough kids in these cohorts (888 Max)
  # 	SEC_MATH_I.2016 = list(
  # 		sgp.content.areas=c(rep('MATHEMATICS', 5), 'SEC_MATH_I'),
  # 		sgp.panel.years=as.character(2011:2016),
  # 		sgp.grade.sequences=list(c(3:7,'EOCT')),
  # 		# sgp.projection.grade.sequences="NO_PROJECTIONS",
  # 		sgp.norm.group.preference=1),
  # 		
  # 		...
  # 		
  # 	SEC_MATH_I.2016 = list(
  # 		sgp.content.areas=c('MATHEMATICS', 'SEC_MATH_I'),
  # 		sgp.panel.years=as.character(2015:2016),
  # 		sgp.grade.sequences=list(c(7,'EOCT')),
  # 		# sgp.projection.grade.sequences="NO_PROJECTIONS",
  # 		sgp.norm.group.preference=5)
)
#############################################################
SEC_MATH_II_2016.config <- list(
  SEC_MATH_II.2016 = list(
    sgp.content.areas=c('SEC_MATH_II','SEC_MATH_II'), # Repeater
    sgp.panel.years=as.character(2015:2016),
    sgp.grade.sequences=list(c('EOCT','EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0),
  
  # CANONICAL Progression.  Can only have 'SEC_MATH_II','SEC_MATH_III' since 8th grade Math was undefined in 2014 and prior
  # 	SEC_MATH_II.2016 = list(
  # 		sgp.content.areas=c(rep('MATHEMATICS', 4), 'SEC_MATH_I', 'SEC_MATH_II'),  
  # 		sgp.panel.years=as.character(2011:2016),
  # 		sgp.grade.sequences=list(c(5:8, 'EOCT','EOCT')),
  # 		# sgp.projection.grade.sequences="NO_PROJECTIONS",
  # 		sgp.norm.group.preference=1),
  SEC_MATH_II.2016 = list(
    sgp.content.areas=c('SEC_MATH_I', 'SEC_MATH_II'),  
    sgp.panel.years=as.character(2015:2016),
    sgp.grade.sequences=list(c('EOCT','EOCT')),
    # sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=3), # Make this pref large since the progression is only needed for projections (will be duplicated in sequences below)
  
  SEC_MATH_II.2016 = list(
    sgp.content.areas=c(rep('MATHEMATICS', 3), 'PRE_ALGEBRA', 'SEC_MATH_I', 'SEC_MATH_II'),
    sgp.panel.years=as.character(2011:2016),
    sgp.grade.sequences=list(c(5:7, 'EOCT', 'EOCT', 'EOCT')),  
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=2)
)
#############################################################
SEC_MATH_III_2016.config <- list(
  SEC_MATH_III.2016 = list(
    sgp.content.areas=c('SEC_MATH_III','SEC_MATH_III'), # Repeater - NOT ENOUGH KIDS IN 2015
    sgp.panel.years=as.character(2015:2016),
    sgp.grade.sequences=list(c('EOCT','EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0),
  
  #   # CANONICAL Progression.  Can only have 'SEC_MATH_II','SEC_MATH_III' in 2016 since 8th grade Math was undefined in 2014 and prior
  #   SEC_MATH_III.2016 = list(
  #   	sgp.content.areas=c(rep('MATHEMATICS', 3), 'SEC_MATH_I', 'SEC_MATH_II','SEC_MATH_III'),  
  #   	sgp.panel.years=as.character(2011:2016),
  #   	sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT', 'EOCT')),
  #   	# sgp.projection.grade.sequences="NO_PROJECTIONS",
  #   	sgp.norm.group.preference=1),
  
  SEC_MATH_III.2016 = list(
    sgp.content.areas=c('SEC_MATH_II','SEC_MATH_III'),  
    sgp.panel.years=as.character(2015:2016),
    sgp.grade.sequences=list(c('EOCT','EOCT')),
    # sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=3), # Make this pref large since the progression is only needed for projections (will be duplicated in sequences below)
  
  # VIA ALGEBRA 1
  SEC_MATH_III.2016 = list(
    sgp.content.areas=c(rep('MATHEMATICS', 2), 'PRE_ALGEBRA','ALGEBRA_I','SEC_MATH_II','SEC_MATH_III'),
    sgp.panel.years=as.character(c(2009:2013,2015:2016)),
    sgp.grade.sequences=list(c(5:6, 'EOCT','EOCT','EOCT','EOCT')),  
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=2),
  
  # SKIP ALGEBRA 1 - VIA Pre-Algebra
  SEC_MATH_III.2016 = list(
    sgp.content.areas=c(rep('MATHEMATICS', 3),'PRE_ALGEBRA','SEC_MATH_II','SEC_MATH_III'),
    sgp.panel.years=as.character(2014:2016),
    sgp.grade.sequences=list(c('EOCT','EOCT','EOCT')),  
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=2)
)