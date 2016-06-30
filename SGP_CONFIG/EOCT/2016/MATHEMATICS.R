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
#     sgp.norm.group.preference=1)
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
#     sgp.norm.group.preference=1)
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
#     sgp.norm.group.preference=1)
# )

#####################################################################################
SEC_MATH_I_2016.config <- list(
  SEC_MATH_I.2016 = list(
    sgp.content.areas=c('SEC_MATH_I','SEC_MATH_I'), # Repeater
    sgp.panel.years=as.character(2015:2016),
    sgp.grade.sequences=list(c('EOCT','EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0),
  
  SEC_MATH_I.2016 = list(
    sgp.content.areas=c(rep('MATHEMATICS', 5), 'SEC_MATH_I'),
    sgp.panel.years=as.character(2011:2016),
    sgp.grade.sequences=list(c(4:8,'EOCT')),
    # sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=1),
  
  ##  ACCELERATED (MATH 8 TAKEN IN SAME YEAR AS SEC_MATH_I)
  	SEC_MATH_I.2016 = list(
  		sgp.content.areas=c(rep('MATHEMATICS', 5), 'SEC_MATH_I'),
  		sgp.panel.years=as.character(2011:2016),
  		sgp.grade.sequences=list(c(3:7,'EOCT')),
  		sgp.projection.grade.sequences="NO_PROJECTIONS",
  		sgp.norm.group.preference=2)
  )
#############################################################
SEC_MATH_II_2016.config <- list(
  SEC_MATH_II.2016 = list(
    sgp.content.areas=c('SEC_MATH_II','SEC_MATH_II'), # Repeater
    sgp.panel.years=as.character(2015:2016),
    sgp.grade.sequences=list(c('EOCT','EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0),
  
 ## CANONICAL Progression.  Beginning in 2016 we can use 8th grade math (2014) as a prior.
  SEC_MATH_II.2016 = list(
    sgp.content.areas=c(rep('MATHEMATICS', 4), 'SEC_MATH_I', 'SEC_MATH_II'),  
    sgp.panel.years=as.character(2011:2016),
    sgp.grade.sequences=list(c(5:8, 'EOCT','EOCT')),
    # sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=1)
)
#############################################################
SEC_MATH_III_2016.config <- list(
  SEC_MATH_III.2016 = list(
    sgp.content.areas=c('SEC_MATH_III','SEC_MATH_III'), # Repeater
    sgp.panel.years=as.character(2015:2016),
    sgp.grade.sequences=list(c('EOCT','EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0),
  
  ## CANONICAL Progression
  SEC_MATH_III.2016 = list(
    sgp.content.areas=c(rep('MATHEMATICS', 3), 'SEC_MATH_I', 'SEC_MATH_II','SEC_MATH_III'),  
    sgp.panel.years=as.character(2011:2016),
    sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT', 'EOCT')),
    # sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=1)
)