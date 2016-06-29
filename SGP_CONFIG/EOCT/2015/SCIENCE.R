#############################################################
##  EOCT CONFIGURATION FILE - SECONDARY SCIENCE
#############################################################

	EARTH_SCIENCE_2015.config <- list(
		EARTH_SCIENCE.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 5), 'EARTH_SCIENCE'),
			sgp.panel.years=as.character(2010:2015),
			sgp.grade.sequences=list(c(4:8, 'EOCT')),
			sgp.projection.sequence = "EARTH_SCIENCE", # Not really needed for canonical progressions, but include anyway to be explicit
			sgp.norm.group.preference=1)
	)
#############################################################	
	BIOLOGY_2015.config <- list(
		# REPEATER
		BIOLOGY.2015 = list(
			sgp.content.areas=c('BIOLOGY', 'BIOLOGY'), 
			sgp.panel.years=as.character(2014:2015),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.projection.grade.sequences="NO_PROJECTIONS",
			# sgp.projection.sequence = "BIO_BIO", # Can't do repeaters now with EOCT.
			sgp.norm.group.preference=0),

		# VIA EARTH SCIENCE
		# 	BIOLOGY.2015 = list( # Max Percentile order of 5! Now also encoded in SGPstateData
		# 			sgp.content.areas=c(rep('SCIENCE', 5), 'EARTH_SCIENCE', 'BIOLOGY'),
		# 			sgp.panel.years=as.character(2009:2015),
		# 			sgp.grade.sequences=list(c(4:8, 'EOCT', 'EOCT')),
		# 			# sgp.projection.grade.sequences="NO_PROJECTIONS",
		# 			sgp.norm.group.preference=1),  
		BIOLOGY.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 4), 'EARTH_SCIENCE', 'BIOLOGY'),
			sgp.panel.years=as.character(2010:2015),
			sgp.grade.sequences=list(c(5:8, 'EOCT', 'EOCT')),
			sgp.projection.sequence = "BIOLOGY",
			sgp.norm.group.preference=1),  
		
		# VIA GRADE 8
		BIOLOGY.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 5), 'BIOLOGY'),
			sgp.panel.years=as.character(2010:2015),
			sgp.grade.sequences=list(c(4:8, 'EOCT')),
			sgp.projection.sequence = 'SCIENCE_BIO',
			sgp.norm.group.preference=2),  # Next Year make this preference = 2.  Set to 1 to produce same data originally provided to USOE (1 student affected)

		# VIA CHEMISTRY
		BIOLOGY.2015 = list(
			sgp.content.areas=c('CHEMISTRY', 'BIOLOGY'),
			sgp.panel.years=as.character(2014:2015),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.projection.sequence = "CHEM_BIO",
			sgp.norm.group.preference=3),	

	# VIA PHYSICS
		BIOLOGY.2015 = list(
			sgp.content.areas=c('PHYSICS', 'BIOLOGY'),
			sgp.panel.years=as.character(2014:2015),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.projection.sequence = "PHYS_BIO",
			sgp.norm.group.preference=4)
	)

#############################################################

	CHEMISTRY_2015.config <- list(
		# VIA EARTH SCIENCE, BIOLOGY	
		CHEMISTRY.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 3), 'EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2010:2015),
			sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT', 'EOCT')),
			sgp.projection.sequence = "CHEMISTRY",
			sgp.norm.group.preference=1),  
		
		# VIA GRADE 8, BIOLOGY	
		CHEMISTRY.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 4), 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2010:2015),
			sgp.grade.sequences=list(c(5:8, 'EOCT', 'EOCT')),
			sgp.projection.grade.sequences="NO_PROJECTIONS", # No need here since config above contains 'BIOLOGY', 'CHEMISTRY'
			sgp.norm.group.preference=1),  # Also pref = 1 because it contains the 'BIOLOGY', 'CHEMISTRY' subset from config above

	# VIA PHYSICS
		CHEMISTRY.2015 = list(
			sgp.content.areas=c('PHYSICS', 'CHEMISTRY'),
			sgp.panel.years=as.character(2014:2015),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.projection.sequence = "PHYS_CHEM",
			sgp.norm.group.preference=3)
	)
	
#############################################################
	
	PHYSICS_2015.config <- list(
	# VIA CHEMISTRY
		PHYSICS.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 2), 'EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
			sgp.panel.years=as.character(2010:2015),
			sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT', 'EOCT', 'EOCT')),
			sgp.projection.sequence = "PHYSICS",
			sgp.norm.group.preference=1),  # Made #2 to produce same data originally provided to USOE.  Next Year make CHEMISTRY 1

		PHYSICS.2015 = list(
			sgp.content.areas=c(rep('SCIENCE', 3), 'BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
			sgp.panel.years=as.character(2010:2015),
			sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT', 'EOCT')),
			sgp.projection.grade.sequences="NO_PROJECTIONS", # No need here since config above contains 'CHEMISTRY', 'PHYSICS'
			sgp.norm.group.preference=1),

	# VIA BIOLOGY
	PHYSICS.2015 = list( # NOT ENOUGH STUDENTS - 2015 -  ONLY 'BIOLOGY', 'PHYSICS'
		sgp.content.areas=c(rep('SCIENCE',3), 'EARTH_SCIENCE', 'BIOLOGY', 'PHYSICS'),
		sgp.panel.years=as.character(2010:2015),
		sgp.grade.sequences=list(c(6:8,'EOCT','EOCT','EOCT')),
		sgp.projection.sequence = "BIO_PHYS",
		sgp.norm.group.preference=3), # Next Year make CHEMISTRY 1 and BIO 2
	
	PHYSICS.2015 = list( # NOT ENOUGH STUDENTS - 2015 -  ONLY 'BIOLOGY', 'PHYSICS'
			sgp.content.areas=c(rep('SCIENCE',4), 'BIOLOGY', 'PHYSICS'),
			sgp.panel.years=as.character(2010:2015),
			sgp.grade.sequences=list(c(5:8,'EOCT','EOCT')),
			sgp.projection.grade.sequences="NO_PROJECTIONS",
			sgp.norm.group.preference=3)
	)
	