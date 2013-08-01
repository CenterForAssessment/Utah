#####################################################################################
###
### 	Scripts associated with 2013 EOCT SCIENCE: 
###			EARTH_SCIENCE, BIOLOGY, CHEMISTRY & PHYSICS
###
#####################################################################################

EARTH_SCIENCE_2013.config <- list(
	EARTH_SCIENCE.2013 = list(
		sgp.content.areas=c(rep('SCIENCE', 5), 'EARTH_SCIENCE'), 
		sgp.panel.years=as.character(2008:2013),
		sgp.grade.sequences=list(c(4:8, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),  
	EARTH_SCIENCE.2013 = list(
		sgp.content.areas=c(rep('SCIENCE', 4), 'EARTH_SCIENCE'), 
		sgp.panel.years=as.character(2009:2013),
		sgp.grade.sequences=list(c(5:8, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),  
	EARTH_SCIENCE.2013 = list(
		sgp.content.areas=c(rep('SCIENCE', 3), 'EARTH_SCIENCE'), 
		sgp.panel.years=as.character(2010:2013),
		sgp.grade.sequences=list(c(6:8, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),  
	EARTH_SCIENCE.2013 = list(
		sgp.content.areas=c(rep('SCIENCE', 2), 'EARTH_SCIENCE'), 
		sgp.panel.years=as.character(2011:2013),
		sgp.grade.sequences=list(c(7:8, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),  
	EARTH_SCIENCE.2013 = list(
		sgp.content.areas=c('SCIENCE', 'EARTH_SCIENCE'), 
		sgp.panel.years=as.character(2012:2013),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5)
)

BIOLOGY_2013.config <- list(
	BIOLOGY.2013 = list(
		sgp.content.areas=c(rep('SCIENCE', 5), 'BIOLOGY'), 
		sgp.panel.years=as.character(2008:2013),
		sgp.grade.sequences=list(c(4:8, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),  
	BIOLOGY.2013 = list(
		sgp.content.areas=c(rep('SCIENCE', 4), 'BIOLOGY'), 
		sgp.panel.years=as.character(2009:2013),
		sgp.grade.sequences=list(c(5:8, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),  
	BIOLOGY.2013 = list(
		sgp.content.areas=c(rep('SCIENCE', 3), 'BIOLOGY'), 
		sgp.panel.years=as.character(2010:2013),
		sgp.grade.sequences=list(c(6:8, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),  
	BIOLOGY.2013 = list(
		sgp.content.areas=c(rep('SCIENCE', 2), 'BIOLOGY'), 
		sgp.panel.years=as.character(2011:2013),
		sgp.grade.sequences=list(c(7:8, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),  
	BIOLOGY.2013 = list(
		sgp.content.areas=c('SCIENCE', 'BIOLOGY'), 
		sgp.panel.years=as.character(2012:2013),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),  

	# BIOLOGY.2013 = list(
		# sgp.content.areas=c(rep('SCIENCE', 5), 'EARTH_SCIENCE', 'BIOLOGY'), 
		# sgp.panel.years=as.character(2007:2013),
		# sgp.grade.sequences=list(c(4:8, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),  
	BIOLOGY.2013 = list(
		sgp.content.areas=c(rep('SCIENCE', 4), 'EARTH_SCIENCE', 'BIOLOGY'), 
		sgp.panel.years=as.character(2008:2013),
		sgp.grade.sequences=list(c(5:8, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),  
	BIOLOGY.2013 = list(
		sgp.content.areas=c(rep('SCIENCE', 3), 'EARTH_SCIENCE', 'BIOLOGY'), 
		sgp.panel.years=as.character(2009:2013),
		sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),  
	BIOLOGY.2013 = list(
		sgp.content.areas=c(rep('SCIENCE', 2), 'EARTH_SCIENCE', 'BIOLOGY'), 
		sgp.panel.years=as.character(2010:2013),
		sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),  
	BIOLOGY.2013 = list(
		sgp.content.areas=c('SCIENCE', 'EARTH_SCIENCE', 'BIOLOGY'), 
		sgp.panel.years=as.character(2011:2013),
		sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),  
	BIOLOGY.2013 = list(
		sgp.content.areas=c('EARTH_SCIENCE', 'BIOLOGY'), 
		sgp.panel.years=as.character(2012:2013),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=7)
)


CHEMISTRY_2013.config <- list(
	# CHEMISTRY.2013 = list(
		# sgp.content.areas=c(rep('SCIENCE', 5), 'BIOLOGY', 'CHEMISTRY'), 
		# sgp.panel.years=as.character(2007:2013),
		# sgp.grade.sequences=list(c(4:8, 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),  
	CHEMISTRY.2013 = list(
		sgp.content.areas=c(rep('SCIENCE', 4), 'BIOLOGY', 'CHEMISTRY'), 
		sgp.panel.years=as.character(2008:2013),
		sgp.grade.sequences=list(c(5:8, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),  
	CHEMISTRY.2013 = list(
		sgp.content.areas=c(rep('SCIENCE', 3), 'BIOLOGY', 'CHEMISTRY'), 
		sgp.panel.years=as.character(2009:2013),
		sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),  
	CHEMISTRY.2013 = list(
		sgp.content.areas=c(rep('SCIENCE', 2), 'BIOLOGY', 'CHEMISTRY'), 
		sgp.panel.years=as.character(2010:2013),
		sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),  
	CHEMISTRY.2013 = list(
		sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'CHEMISTRY'), 
		sgp.panel.years=as.character(2011:2013),
		sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),  

	# CHEMISTRY.2013 = list(
		# sgp.content.areas=c(rep('SCIENCE', 5), 'EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'), 
		# sgp.panel.years=as.character(2006:2013),
		# sgp.grade.sequences=list(c(4:8, 'EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=1),  
	# CHEMISTRY.2013 = list(
		# sgp.content.areas=c(rep('SCIENCE', 4), 'EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'), 
		# sgp.panel.years=as.character(2007:2013),
		# sgp.grade.sequences=list(c(5:8, 'EOCT', 'EOCT', 'EOCT')),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=2),  
	CHEMISTRY.2013 = list(
		sgp.content.areas=c(rep('SCIENCE', 3), 'EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'), 
		sgp.panel.years=as.character(2008:2013),
		sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),  
	CHEMISTRY.2013 = list(
		sgp.content.areas=c(rep('SCIENCE', 2), 'EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'), 
		sgp.panel.years=as.character(2009:2013),
		sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),  
	CHEMISTRY.2013 = list(
		sgp.content.areas=c('SCIENCE', 'EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'), 
		sgp.panel.years=as.character(2010:2013),
		sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),  
	CHEMISTRY.2013 = list(
		sgp.content.areas=c('EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'), 
		sgp.panel.years=as.character(2011:2013),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=6),  
	CHEMISTRY.2013 = list(
		sgp.content.areas=c('BIOLOGY', 'CHEMISTRY'), 
		sgp.panel.years=as.character(2012:2013),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=7),  

	CHEMISTRY.2013 = list(
		sgp.content.areas=c('PHYSICS', 'CHEMISTRY'), 
		sgp.panel.years=as.character(2012:2013),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
)
  	

PHYSICS_2013.config <- list(
	PHYSICS.2013 = list(
		sgp.content.areas=c('BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
		sgp.panel.years=as.character(2011:2013),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),  
	PHYSICS.2013 = list(
		sgp.content.areas=c('CHEMISTRY', 'PHYSICS'),
		sgp.panel.years=as.character(2012:2013),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),  

	PHYSICS.2013 = list(
		sgp.content.areas=c('BIOLOGY', 'PHYSICS'),
		sgp.panel.years=as.character(2012:2013),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1)
)
