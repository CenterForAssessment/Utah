# EOCT CONFIGURATION FILE - HIGH SCHOOL SCIENCE
#############################################################
	EARTH_SCIENCE_2018.config <- list(
	  EARTH_SCIENCE.2018 = list(
	    sgp.content.areas=c(rep('SCIENCE', 4), 'EARTH_SCIENCE'),
	    sgp.panel.years=as.character(2014:2018),
	    sgp.grade.sequences=list(c(5:8, 'EOCT')),
	    sgp.exact.grade.progression=TRUE,
	    sgp.norm.group.preference=1),
		EARTH_SCIENCE.2018 = list(
			sgp.content.areas=c(rep('SCIENCE', 3), 'EARTH_SCIENCE'),
			sgp.panel.years=as.character(2015:2018),
			sgp.grade.sequences=list(c(6:8, 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=2),
		EARTH_SCIENCE.2018 = list(
		  sgp.content.areas=c(rep('SCIENCE', 2), 'EARTH_SCIENCE'),
		  sgp.panel.years=as.character(2016:2018),
		  sgp.grade.sequences=list(c(7:8, 'EOCT')),
		  sgp.exact.grade.progression=TRUE,
		  sgp.norm.group.preference=3),
		EARTH_SCIENCE.2018 = list(
			sgp.content.areas=c('SCIENCE', 'EARTH_SCIENCE'),
			sgp.panel.years=as.character(2017:2018),
			sgp.grade.sequences=list(c(8, 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=4)
	)
#############################################################	
	BIOLOGY_2018.config <- list(
	# REPEATER
		BIOLOGY.2018 = list(
			sgp.content.areas=c('BIOLOGY', 'BIOLOGY'), 
			sgp.panel.years=as.character(2017:2018),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=0),  
	# VIA GRADE 8
	  BIOLOGY.2018 = list(
	    sgp.content.areas=c(rep('SCIENCE', 4), 'BIOLOGY'),
	    sgp.panel.years=as.character(2014:2018),
	    sgp.grade.sequences=list(c(5:8, 'EOCT')),
	    sgp.exact.grade.progression=TRUE,
	    sgp.norm.group.preference=1),
		BIOLOGY.2018 = list(
			sgp.content.areas=c(rep('SCIENCE', 3), 'BIOLOGY'),
			sgp.panel.years=as.character(2015:2018),
			sgp.grade.sequences=list(c(6:8, 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=2),
	  BIOLOGY.2018 = list(
	    sgp.content.areas=c(rep('SCIENCE', 2), 'BIOLOGY'),
	    sgp.panel.years=as.character(2016:2018),
	    sgp.grade.sequences=list(c(7:8, 'EOCT')),
	    sgp.exact.grade.progression=TRUE,
	    sgp.norm.group.preference=3), 
		BIOLOGY.2018 = list(
			sgp.content.areas=c('SCIENCE', 'BIOLOGY'),
			sgp.panel.years=as.character(2017:2018),
			sgp.grade.sequences=list(c(8, 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=4),
	# VIA EARTH SCIENCE
	  BIOLOGY.2018 = list(
	    sgp.content.areas=c(rep('SCIENCE',3), 'EARTH_SCIENCE', 'BIOLOGY'),
	    sgp.panel.years=as.character(2014:2018),
	    sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT')),
	    sgp.exact.grade.progression=TRUE,
	    sgp.norm.group.preference=1),
		BIOLOGY.2018 = list(
			sgp.content.areas=c(rep('SCIENCE',2), 'EARTH_SCIENCE', 'BIOLOGY'),
			sgp.panel.years=as.character(2015:2018),
			sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=2),
	  BIOLOGY.2018 = list(
	    sgp.content.areas=c('SCIENCE', 'EARTH_SCIENCE', 'BIOLOGY'),
	    sgp.panel.years=as.character(2016:2018),
	    sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
	    sgp.exact.grade.progression=TRUE,
	    sgp.norm.group.preference=3), 
		BIOLOGY.2018 = list(
			sgp.content.areas=c('EARTH_SCIENCE', 'BIOLOGY'),
			sgp.panel.years=as.character(2017:2018),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=4),
	# VIA CHEMISTRY
		BIOLOGY.2018 = list(
			sgp.content.areas=c('CHEMISTRY', 'BIOLOGY'),
			sgp.panel.years=as.character(2017:2018),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=1),	
	# VIA PHYSICS
		BIOLOGY.2018 = list(
			sgp.content.areas=c('PHYSICS', 'BIOLOGY'),
			sgp.panel.years=as.character(2017:2018),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=1)
	)
#############################################################
	CHEMISTRY_2018.config <- list(
	# VIA BIOLOGY
	  CHEMISTRY.2018 = list(
	    sgp.content.areas=c(rep('SCIENCE',3), 'BIOLOGY', 'CHEMISTRY'),
	    sgp.panel.years=as.character(2014:2018),
	    sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT')),
	    sgp.exact.grade.progression=TRUE,
	    sgp.norm.group.preference=1),
		CHEMISTRY.2018 = list(
			sgp.content.areas=c(rep('SCIENCE',2), 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2015:2018),
			sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=2),
		CHEMISTRY.2018 = list(
		  sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
		  sgp.panel.years=as.character(2016:2018),
		  sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
		  sgp.exact.grade.progression=TRUE,
		  sgp.norm.group.preference=3), 
		CHEMISTRY.2018 = list(
			sgp.content.areas=c('EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2016:2018),
			sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=4),
		CHEMISTRY.2018 = list(
			sgp.content.areas=c('BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2017:2018),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=5),
	# VIA PHYSICS
		CHEMISTRY.2018 = list(
			sgp.content.areas=c('PHYSICS', 'CHEMISTRY'),
			sgp.panel.years=as.character(2017:2018),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=1)
	)
#############################################################
	PHYSICS_2018.config <- list(
	# VIA CHEMISTRY
	  PHYSICS.2018 = list(
	    sgp.content.areas=c(rep('SCIENCE',2), 'BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
	    sgp.panel.years=as.character(2014:2018),
	    sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT', 'EOCT')),
	    sgp.exact.grade.progression=TRUE,
	    sgp.norm.group.preference=1),
		PHYSICS.2018 = list(
			sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
			sgp.panel.years=as.character(2015:2018),
			sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=2),
		PHYSICS.2018 = list(
		  sgp.content.areas=c('EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
		  sgp.panel.years=as.character(2015:2018),
		  sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT')),
		  sgp.exact.grade.progression=TRUE,
		  sgp.norm.group.preference=3),
		PHYSICS.2018 = list(
			sgp.content.areas=c('BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
			sgp.panel.years=as.character(2016:2018),
			sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=4),
		PHYSICS.2018 = list(
		  sgp.content.areas=c('CHEMISTRY', 'PHYSICS'),
		  sgp.panel.years=as.character(2017:2018),
		  sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		  sgp.exact.grade.progression=TRUE,
		  sgp.norm.group.preference=5),
	# VIA BIOLOGY
	  PHYSICS.2018 = list(
	    sgp.content.areas=c(rep('SCIENCE',3), 'BIOLOGY', 'PHYSICS'),
	    sgp.panel.years=as.character(2014:2018),
	    sgp.grade.sequences=list(c(6:8,'EOCT','EOCT')),
	    sgp.exact.grade.progression=TRUE,
	    sgp.norm.group.preference=1),
		PHYSICS.2018 = list(
			sgp.content.areas=c(rep('SCIENCE',2), 'BIOLOGY', 'PHYSICS'),
			sgp.panel.years=as.character(2015:2018),
			sgp.grade.sequences=list(c(7:8,'EOCT','EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=2),
	  PHYSICS.2018 = list(
	    sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'PHYSICS'),
	    sgp.panel.years=as.character(2016:2018),
	    sgp.grade.sequences=list(c(8,'EOCT','EOCT')),
	    sgp.exact.grade.progression=TRUE,
	    sgp.norm.group.preference=3),
		PHYSICS.2018 = list(
			sgp.content.areas=c('EARTH_SCIENCE', 'BIOLOGY', 'PHYSICS'),
			sgp.panel.years=as.character(2016:2018),
			sgp.grade.sequences=list(c('EOCT','EOCT','EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=4),
		PHYSICS.2018 = list(
			sgp.content.areas=c('BIOLOGY', 'PHYSICS'),
			sgp.panel.years=as.character(2017:2018),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=5)
	)