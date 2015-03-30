# EOCT CONFIGURATION FILE - HIGH SCHOOL SCIENCE
#############################################################
	EARTH_SCIENCE_2015.config <- list(
		EARTH_SCIENCE.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 5), 'EARTH_SCIENCE'),
			sgp.panel.years=as.character(2010:2015),
			sgp.grade.sequences=list(c(4:8, 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=1),  
		EARTH_SCIENCE.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 4), 'EARTH_SCIENCE'),
			sgp.panel.years=as.character(2011:2015),
			sgp.grade.sequences=list(c(5:8, 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=2),  
		EARTH_SCIENCE.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 3), 'EARTH_SCIENCE'),
			sgp.panel.years=as.character(2012:2015),
			sgp.grade.sequences=list(c(6:8, 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=3),  
		EARTH_SCIENCE.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 2), 'EARTH_SCIENCE'),
			sgp.panel.years=as.character(2013:2015),
			sgp.grade.sequences=list(c(7:8, 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=4),  
		EARTH_SCIENCE.2015 = list(
			sgp.content.areas=c('SCIENCE', 'EARTH_SCIENCE'),
			sgp.panel.years=as.character(2014:2015),
			sgp.grade.sequences=list(c(8, 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=5)
	)
#############################################################	
	BIOLOGY_2015.config <- list(
	# REPEATER
		BIOLOGY.2015 = list(
			sgp.content.areas=c('BIOLOGY', 'BIOLOGY'), 
			sgp.panel.years=as.character(2014:2015),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=0),  
	# VIA GRADE 8
		BIOLOGY.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 5), 'BIOLOGY'),
			sgp.panel.years=as.character(2010:2015),
			sgp.grade.sequences=list(c(4:8, 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=1),  
		BIOLOGY.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 4), 'BIOLOGY'),
			sgp.panel.years=as.character(2011:2015),
			sgp.grade.sequences=list(c(5:8, 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=2),  
		BIOLOGY.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 3), 'BIOLOGY'),
			sgp.panel.years=as.character(2012:2015),
			sgp.grade.sequences=list(c(6:8, 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=3),  
		BIOLOGY.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 2), 'BIOLOGY'),
			sgp.panel.years=as.character(2013:2015),
			sgp.grade.sequences=list(c(7:8, 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=4),  
		BIOLOGY.2015 = list(
			sgp.content.areas=c('SCIENCE', 'BIOLOGY'),
			sgp.panel.years=as.character(2014:2015),
			sgp.grade.sequences=list(c(8, 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=5),
	# VIA EARTH SCIENCE
		BIOLOGY.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 4), 'EARTH_SCIENCE', 'BIOLOGY'),
			sgp.panel.years=as.character(2010:2015),
			sgp.grade.sequences=list(c(5:8, 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=1),  
		BIOLOGY.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 3), 'EARTH_SCIENCE', 'BIOLOGY'),
			sgp.panel.years=as.character(2011:2015),
			sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=2),  
		BIOLOGY.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 2), 'EARTH_SCIENCE', 'BIOLOGY'),
			sgp.panel.years=as.character(2012:2015),
			sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=3),  
		BIOLOGY.2015 = list(
			sgp.content.areas=c('SCIENCE', 'EARTH_SCIENCE', 'BIOLOGY'),
			sgp.panel.years=as.character(2013:2015),
			sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=4),  
		BIOLOGY.2015 = list(
			sgp.content.areas=c('EARTH_SCIENCE', 'BIOLOGY'),
			sgp.panel.years=as.character(2014:2015),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=5),
	# VIA CHEMISTRY
		BIOLOGY.2015 = list(
			sgp.content.areas=c('CHEMISTRY', 'BIOLOGY'),
			sgp.panel.years=as.character(2014:2015),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=1),	
	# VIA PHYSICS
		BIOLOGY.2015 = list(
			sgp.content.areas=c('PHYSICS', 'BIOLOGY'),
			sgp.panel.years=as.character(2014:2015),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=1)
	)
#############################################################
	CHEMISTRY_2015.config <- list(
	# VIA GRADE 8, BIOLOGY	
		CHEMISTRY.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 4), 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2010:2015),
			sgp.grade.sequences=list(c(5:8, 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=1),  
		CHEMISTRY.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 3), 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2011:2015),
			sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=2),  
		CHEMISTRY.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 2), 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2012:2015),
			sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=3),  
		CHEMISTRY.2015 = list(
			sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2013:2015),
			sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=4),  
	# VIA EARTH SCIENCE, BIOLOGY	
		CHEMISTRY.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 3), 'EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2010:2015),
			sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=1),  
		CHEMISTRY.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 2), 'EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2011:2015),
			sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=2),  
		CHEMISTRY.2015 = list(
			sgp.content.areas=c('SCIENCE', 'EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'), 
			sgp.panel.years=as.character(2012:2015),
			sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=3),  
		CHEMISTRY.2015 = list(
			sgp.content.areas=c('EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2013:2015),
			sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=4),
	# VIA BIOLOGY
		CHEMISTRY.2015 = list(
			sgp.content.areas=c('BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2014:2015),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=5),
	# VIA PHYSICS
		CHEMISTRY.2015 = list(
			sgp.content.areas=c('PHYSICS', 'CHEMISTRY'),
			sgp.panel.years=as.character(2014:2015),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=1)
	)
#############################################################
	PHYSICS_2015.config <- list(
	# VIA CHEMISTRY
		PHYSICS.2015 = list(
			sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
			sgp.panel.years=as.character(2012:2015),
			sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=1),
		PHYSICS.2015 = list(
			sgp.content.areas=c('EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
			sgp.panel.years=as.character(2012:2015),
			sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=2),	
		PHYSICS.2015 = list(
			sgp.content.areas=c('BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
			sgp.panel.years=as.character(2013:2015),
			sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=3),
		PHYSICS.2015 = list(
			sgp.content.areas=c('CHEMISTRY', 'PHYSICS'),
			sgp.panel.years=as.character(2014:2015),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=4),
	# VIA BIOLOGY
		PHYSICS.2015 = list(
			sgp.content.areas=c(rep('SCIENCE',2), 'BIOLOGY', 'PHYSICS'),
			sgp.panel.years=as.character(2012:2015),
			sgp.grade.sequences=list(c(7:8,'EOCT','EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=1),
		PHYSICS.2015 = list(
			sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'PHYSICS'),
			sgp.panel.years=as.character(2013:2015),
			sgp.grade.sequences=list(c(8,'EOCT','EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=2),
		PHYSICS.2015 = list(
			sgp.content.areas=c('SCIENCE', 'EARTH_SCIENCE', 'BIOLOGY', 'PHYSICS'),
			sgp.panel.years=as.character(2012:2015),
			sgp.grade.sequences=list(c(8,'EOCT','EOCT','EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=1),
		PHYSICS.2015 = list(
			sgp.content.areas=c('EARTH_SCIENCE', 'BIOLOGY', 'PHYSICS'),
			sgp.panel.years=as.character(2013:2015),
			sgp.grade.sequences=list(c('EOCT','EOCT','EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=2),
		PHYSICS.2015 = list(
			sgp.content.areas=c('BIOLOGY', 'PHYSICS'),
			sgp.panel.years=as.character(2014:2015),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=3)
	)