#############################################################
##  EOCT CONFIGURATION FILE - SECONDARY SCIENCE
#############################################################

EARTH_SCIENCE_2016.config <- list(
  EARTH_SCIENCE.2016 = list(
    sgp.content.areas=c(rep('SCIENCE', 5), 'EARTH_SCIENCE'),
    sgp.panel.years=as.character(2011:2016),
    sgp.grade.sequences=list(c(4:8, 'EOCT')),
    sgp.projection.sequence = "EARTH_SCIENCE", # Not really needed for canonical progressions, but include anyway to be explicit
    sgp.norm.group.preference=1)
)

###########
# SAGE ONLY
# EARTH_SCIENCE_2016.config <- list(
#   EARTH_SCIENCE.2016 = list(
#     sgp.content.areas=c(rep('SCIENCE', 2), 'EARTH_SCIENCE'),
#     sgp.panel.years=as.character(2014:2016),
#     sgp.grade.sequences=list(c(7:8, 'EOCT')),
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=1),
# )

#############################################################	
BIOLOGY_2016.config <- list(
  # REPEATER
  BIOLOGY.2016 = list(
    sgp.content.areas=c('BIOLOGY', 'BIOLOGY'), 
    sgp.panel.years=as.character(2015:2016),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0),  
  
  # VIA EARTH SCIENCE
  BIOLOGY.2016 = list(
    sgp.content.areas=c(rep('SCIENCE', 4), 'EARTH_SCIENCE', 'BIOLOGY'),
    sgp.panel.years=as.character(2011:2016),
    sgp.grade.sequences=list(c(5:8, 'EOCT', 'EOCT')),
    sgp.projection.sequence = "BIOLOGY",
    sgp.norm.group.preference=1),  
  
  # VIA GRADE 8
  BIOLOGY.2016 = list(
    sgp.content.areas=c(rep('SCIENCE', 5), 'BIOLOGY'),
    sgp.panel.years=as.character(2011:2016),
    sgp.grade.sequences=list(c(4:8, 'EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=2),
  
  # VIA CHEMISTRY
  BIOLOGY.2016 = list(
    sgp.content.areas=c('CHEMISTRY', 'BIOLOGY'),
    sgp.panel.years=as.character(2015:2016),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
      sgp.projection.sequence = "CHEM_BIO",
    sgp.norm.group.preference=3),	
  
  # VIA PHYSICS
  BIOLOGY.2016 = list(
    sgp.content.areas=c('PHYSICS', 'BIOLOGY'),
    sgp.panel.years=as.character(2015:2016),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
      sgp.projection.sequence = "PHYS_BIO",
    sgp.norm.group.preference=4)
)

###########
# SAGE ONLY
# BIOLOGY_2016.config <- list(
#   # REPEATER
#   BIOLOGY.2016 = list(
#     sgp.content.areas=c('BIOLOGY', 'BIOLOGY'), 
#     sgp.panel.years=as.character(2015:2016),
#     sgp.grade.sequences=list(c('EOCT', 'EOCT')),
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=0),  
#   
#   # VIA EARTH SCIENCE
#   BIOLOGY.2016 = list(
#   	sgp.content.areas=c('SCIENCE', 'EARTH_SCIENCE', 'BIOLOGY'),
#   	sgp.panel.years=as.character(2014:2016),
#   	sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
#   	sgp.projection.grade.sequences="NO_PROJECTIONS",
#   	sgp.norm.group.preference=1),
# 
#   # SKIP EARTH SCIENCE
#   BIOLOGY.2016 = list(
#     sgp.content.areas=c(rep('SCIENCE', 2), 'BIOLOGY'),
#     sgp.panel.years=as.character(2014:2016),
#     sgp.grade.sequences=list(c(7:8, 'EOCT')),
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=2),
#   
#   # VIA CHEMISTRY
#   BIOLOGY.2016 = list(
#     sgp.content.areas=c('CHEMISTRY', 'BIOLOGY'),
#     sgp.panel.years=as.character(2015:2016),
#     sgp.grade.sequences=list(c('EOCT', 'EOCT')),
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=3),	
#   
#   # VIA PHYSICS
#   BIOLOGY.2016 = list(
#     sgp.content.areas=c('PHYSICS', 'BIOLOGY'),
#     sgp.panel.years=as.character(2015:2016),
#     sgp.grade.sequences=list(c('EOCT', 'EOCT')),
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=4)
# )

#############################################################

CHEMISTRY_2016.config <- list(
  # VIA EARTH SCIENCE, BIOLOGY	
  CHEMISTRY.2016 = list(
    sgp.content.areas=c(rep('SCIENCE', 3), 'EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
    sgp.panel.years=as.character(2011:2016),
    sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT', 'EOCT')),
    sgp.projection.sequence = "CHEMISTRY",
    sgp.norm.group.preference=1),  
  
  # VIA GRADE 8, BIOLOGY	
  CHEMISTRY.2016 = list(
    sgp.content.areas=c(rep('SCIENCE', 4), 'BIOLOGY', 'CHEMISTRY'),
    sgp.panel.years=as.character(2011:2016),
    sgp.grade.sequences=list(c(5:8, 'EOCT', 'EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS", # No need here since config above contains 'BIOLOGY', 'CHEMISTRY' progression
    sgp.norm.group.preference=2),

  # VIA PHYSICS
  CHEMISTRY.2016 = list(
    sgp.content.areas=c('PHYSICS', 'CHEMISTRY'),
    sgp.panel.years=as.character(2015:2016),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.projection.sequence = "PHYS_CHEM",
    sgp.norm.group.preference=3)
)

###########
# SAGE ONLY
# CHEMISTRY_2016.config <- list(
#   # VIA EARTH SCIENCE, BIOLOGY	
#   CHEMISTRY.2016 = list(
#     sgp.content.areas=c('EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
#     sgp.panel.years=as.character(2014:2016),
#     sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=1),  
#     
#   # VIA PHYSICS
#   CHEMISTRY.2016 = list(
#     sgp.content.areas=c('PHYSICS', 'CHEMISTRY'),
#     sgp.panel.years=as.character(2015:2016),
#     sgp.grade.sequences=list(c('EOCT', 'EOCT')),
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=3)
# )

#############################################################

PHYSICS_2016.config <- list(
  # VIA CHEMISTRY
  PHYSICS.2016 = list(
    sgp.content.areas=c(rep('SCIENCE', 2), 'EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
    sgp.panel.years=as.character(2011:2016),
    sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT', 'EOCT', 'EOCT')),
    sgp.projection.sequence = "PHYSICS",
    sgp.norm.group.preference=1),  # Made #2 to produce same data originally provided to USOE.  Next Year make CHEMISTRY 1
  
  PHYSICS.2016 = list(
    sgp.content.areas=c(rep('SCIENCE', 3), 'BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
    sgp.panel.years=as.character(2011:2016),
    sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT', 'EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS", # No need here since config above contains 'CHEMISTRY', 'PHYSICS'
    sgp.norm.group.preference=1),
  
  # VIA BIOLOGY
  PHYSICS.2016 = list(
    sgp.content.areas=c(rep('SCIENCE',3), 'EARTH_SCIENCE', 'BIOLOGY', 'PHYSICS'),
    sgp.panel.years=as.character(2011:2016),
    sgp.grade.sequences=list(c(6:8,'EOCT','EOCT','EOCT')),
    sgp.projection.sequence = "BIO_PHYS",
    sgp.norm.group.preference=3), # Next Year make CHEMISTRY 1 and BIO 2
  
  PHYSICS.2016 = list(
    sgp.content.areas=c(rep('SCIENCE',4), 'BIOLOGY', 'PHYSICS'),
    sgp.panel.years=as.character(2011:2016),
    sgp.grade.sequences=list(c(5:8,'EOCT','EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=3)
)

###########
# SAGE ONLY
# PHYSICS_2016.config <- list(
#   # VIA CHEMISTRY
#   PHYSICS.2016 = list(
#     sgp.content.areas=c('BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
#     sgp.panel.years=as.character(2014:2016),
#     sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=1),

#   
#   # VIA BIOLOGY
#   PHYSICS.2016 = list(
#     sgp.content.areas=c('EARTH_SCIENCE', 'BIOLOGY', 'PHYSICS'),
#     sgp.panel.years=as.character(2014:2016),
#     sgp.grade.sequences=list(c('EOCT','EOCT','EOCT')),
#     sgp.projection.grade.sequences="NO_PROJECTIONS",
#     sgp.norm.group.preference=3)
# )