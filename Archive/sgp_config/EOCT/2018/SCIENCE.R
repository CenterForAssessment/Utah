###########################################################################
###                                                                     ###
###      Utah EOCT CONFIGURATION FILE  -  2018 HIGH SCHOOL SCIENCE      ###
###                                                                     ###
###########################################################################


	EARTH_SCIENCE_2018.config <- list(
	  EARTH_SCIENCE.2018 = list(
	    sgp.content.areas=c(rep('SCIENCE', 4), 'EARTH_SCIENCE'),
	    sgp.panel.years=as.character(2014:2018),
	    sgp.grade.sequences=list(c(5:8, 'EOCT')),
	    # sgp.exact.grade.progression=TRUE,
	    sgp.norm.group.preference=1)
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
	    # sgp.exact.grade.progression=TRUE,
			sgp.projection.sequence = 'SCIENCE_BIO',
	    sgp.norm.group.preference=1),
	# VIA EARTH SCIENCE
	  BIOLOGY.2018 = list(
	    sgp.content.areas=c(rep('SCIENCE',3), 'EARTH_SCIENCE', 'BIOLOGY'),
	    sgp.panel.years=as.character(2014:2018),
	    sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT')),
		# sgp.projection.grade.sequences='NO_PROJECTIONS', # Canonical progression
	    sgp.norm.group.preference=1),
	# VIA CHEMISTRY
		BIOLOGY.2018 = list(
			sgp.content.areas=c('CHEMISTRY', 'BIOLOGY'),
			sgp.panel.years=as.character(2017:2018),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.projection.sequence = 'CHEM_BIO', #  Not enough kids in this progression for 2018
			sgp.norm.group.preference=1),
	# VIA PHYSICS
		BIOLOGY.2018 = list(
			sgp.content.areas=c('PHYSICS', 'BIOLOGY'),
			sgp.panel.years=as.character(2017:2018),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.projection.sequence = 'PHYS_BIO', #  Not enough kids in this progression for 2018
			sgp.norm.group.preference=1)
	)

#############################################################

	CHEMISTRY_2018.config <- list(
	# VIA BIOLOGY
	  CHEMISTRY.2018 = list(
	    sgp.content.areas=c(rep('SCIENCE', 3), 'BIOLOGY', 'CHEMISTRY'),
	    sgp.panel.years=as.character(2014:2018),
	    sgp.grade.sequences=list(c(6:8, 'EOCT', 'EOCT')),
	    sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences='NO_PROJECTIONS',
	    sgp.norm.group.preference=1),
		CHEMISTRY.2018 = list(
			sgp.content.areas=c(rep('SCIENCE', 2), 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2015:2018),
			sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences='NO_PROJECTIONS',
			sgp.norm.group.preference=2),
		CHEMISTRY.2018 = list(
		  sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
		  sgp.panel.years=as.character(2016:2018),
		  sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
		  sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences='NO_PROJECTIONS',
		  sgp.norm.group.preference=3),

		CHEMISTRY.2018 = list(
			sgp.content.areas=c(rep('SCIENCE', 2), 'EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2014:2018),
			sgp.grade.sequences=list(c('7', '8', 'EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
		# sgp.projection.grade.sequences='NO_PROJECTIONS', # Canonical progression
			sgp.norm.group.preference=4),
		CHEMISTRY.2018 = list(
			sgp.content.areas=c('SCIENCE', 'EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2015:2018),
			sgp.grade.sequences=list(c('8', 'EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences='NO_PROJECTIONS',
			sgp.norm.group.preference=5),
		CHEMISTRY.2018 = list(
			sgp.content.areas=c('EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2016:2018),
			sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences='NO_PROJECTIONS',
			sgp.norm.group.preference=6),

		CHEMISTRY.2018 = list(
			sgp.content.areas=c('BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2017:2018),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.norm.group.preference=7),
	# VIA PHYSICS
		CHEMISTRY.2018 = list(
			sgp.content.areas=c('PHYSICS', 'CHEMISTRY'),
			sgp.panel.years=as.character(2017:2018),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.projection.sequence = 'PHYS_CHEM', #  Not enough kids in this progression for 2018
			sgp.norm.group.preference=8)
	)

#############################################################

	PHYSICS_2018.config <- list(
	# VIA CHEMISTRY
	  PHYSICS.2018 = list(
	    sgp.content.areas=c(rep('SCIENCE',2), 'BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
	    sgp.panel.years=as.character(2014:2018),
	    sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT', 'EOCT')),
	    sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences='NO_PROJECTIONS',
	    sgp.norm.group.preference=1),
		PHYSICS.2018 = list(
			sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
			sgp.panel.years=as.character(2015:2018),
			sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences='NO_PROJECTIONS',
			sgp.norm.group.preference=2),
		PHYSICS.2018 = list(
		  sgp.content.areas=c('SCIENCE', 'EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
		  sgp.panel.years=as.character(2014:2018),
		  sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT', 'EOCT', 'EOCT')),
		  sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences='NO_PROJECTIONS', #  Not enough kids for CANONICAL progression in 2018
		  sgp.norm.group.preference=3),
		PHYSICS.2018 = list(
			sgp.content.areas=c('BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
			sgp.panel.years=as.character(2016:2018),
			sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences='NO_PROJECTIONS',
			sgp.norm.group.preference=4),
		PHYSICS.2018 = list(
		  sgp.content.areas=c('CHEMISTRY', 'PHYSICS'),
		  sgp.panel.years=as.character(2017:2018),
		  sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.projection.grade.sequences='NO_PROJECTIONS', # Not enough kids for CANONICAL progression in 2018
		  sgp.norm.group.preference=5),
	# VIA BIOLOGY
	  PHYSICS.2018 = list(
	    sgp.content.areas=c(rep('SCIENCE',3), 'BIOLOGY', 'PHYSICS'),
	    sgp.panel.years=as.character(2014:2018),
	    sgp.grade.sequences=list(c(6:8,'EOCT','EOCT')),
	    # sgp.exact.grade.progression=TRUE, #  Fewer than 3,000 kids - no need for 'nested' sgp.exact.grade.progression
			sgp.projection.sequence = 'BIO_PHYS',
	    sgp.norm.group.preference=1)
	)
