###########################################################################
###                                                                     ###
###      Utah EOCT CONFIGURATION FILE  -  2018 HIGH SCHOOL SCIENCE      ###
###                                                                     ###
###########################################################################

	EARTH_SCIENCE_2017.config <- list(
		EARTH_SCIENCE.2017 = list(
			sgp.content.areas=c(rep('SCIENCE', 3), 'EARTH_SCIENCE'),
			sgp.panel.years=as.character(2014:2017),
			sgp.grade.sequences=list(c(6:8, 'EOCT')),
			sgp.norm.group.preference=0)
	)

#############################################################

	BIOLOGY_2017.config <- list(
		# REPEATER
		BIOLOGY.2017 = list(
			sgp.content.areas=c('BIOLOGY', 'BIOLOGY'),
			sgp.panel.years=as.character(2016:2017),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.norm.group.preference=0),

		# VIA GRADE 8
		BIOLOGY.2017 = list(
			sgp.content.areas=c(rep('SCIENCE', 3), 'BIOLOGY'),
			sgp.panel.years=as.character(2014:2017),
			sgp.grade.sequences=list(c(6:8, 'EOCT')),
			sgp.projection.grade.sequences="SCIENCE_BIO",
			sgp.norm.group.preference=1),

	# CANONICAL - VIA EARTH SCIENCE
		BIOLOGY.2017 = list(
			sgp.content.areas=c(rep('SCIENCE', 2), 'EARTH_SCIENCE', 'BIOLOGY'),
			sgp.panel.years=as.character(2014:2017),
			sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT')),
			# sgp.projection.grade.sequences="NO_PROJECTIONS", # Canonical progression
			sgp.norm.group.preference=2),

	# VIA CHEMISTRY
		BIOLOGY.2017 = list(
			sgp.content.areas=c('CHEMISTRY', 'BIOLOGY'),
			sgp.panel.years=as.character(2016:2017),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.norm.group.preference=3,
			sgp.projection.sequence = "CHEM_BIO"),

	# VIA PHYSICS
		BIOLOGY.2017 = list(
			sgp.content.areas=c('PHYSICS', 'BIOLOGY'),
			sgp.panel.years=as.character(2016:2017),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.norm.group.preference=4,
			sgp.projection.sequence = "PHYS_BIO")
	)

#############################################################
	CHEMISTRY_2017.config <- list(
	# VIA BIOLOGY
		CHEMISTRY.2017 = list(
			sgp.content.areas=c(rep('SCIENCE',2), 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2014:2017),
			sgp.grade.sequences=list(c(7:8, 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences="NO_PROJECTIONS",
			sgp.norm.group.preference=1),
		CHEMISTRY.2017 = list(
		  sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
		  sgp.panel.years=as.character(2015:2017),
		  sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
		  sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences="NO_PROJECTIONS",
	  	sgp.norm.group.preference=2),

		CHEMISTRY.2017 = list(
			sgp.content.areas=c('EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2015:2017),
			sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences="NO_PROJECTIONS",
			sgp.norm.group.preference=3),

		CHEMISTRY.2017 = list( #  Combined cohorts with Science and Earth Sci 2nd priors
			sgp.content.areas=c('BIOLOGY', 'CHEMISTRY'),
			sgp.panel.years=as.character(2016:2017),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			# sgp.projection.grade.sequences="NO_PROJECTIONS", # Canonical progression
			sgp.norm.group.preference=4),

	# VIA PHYSICS
		CHEMISTRY.2017 = list(
			sgp.content.areas=c('PHYSICS', 'CHEMISTRY'),
			sgp.panel.years=as.character(2016:2017),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.norm.group.preference=1,
			sgp.projection.sequence = "PHYS_CHEM")
	)

#############################################################

	PHYSICS_2017.config <- list(
		# VIA CHEMISTRY
		PHYSICS.2017 = list(
			sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
			sgp.panel.years=as.character(2014:2017),
			sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences="NO_PROJECTIONS",
			sgp.norm.group.preference=1),
		PHYSICS.2017 = list(
		  sgp.content.areas=c('EARTH_SCIENCE', 'BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
		  sgp.panel.years=as.character(2014:2017),
		  sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT')),
		  sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences="NO_PROJECTIONS",
		  sgp.norm.group.preference=2),
		PHYSICS.2017 = list(
			sgp.content.areas=c('BIOLOGY', 'CHEMISTRY', 'PHYSICS'),
			sgp.panel.years=as.character(2015:2017),
			sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences="NO_PROJECTIONS",
			sgp.norm.group.preference=3),
		PHYSICS.2017 = list(
		  sgp.content.areas=c('CHEMISTRY', 'PHYSICS'),
		  sgp.panel.years=as.character(2016:2017),
		  sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			# sgp.projection.grade.sequences="NO_PROJECTIONS", # Canonical progression
		  sgp.norm.group.preference=4),

	# VIA BIOLOGY
		PHYSICS.2017 = list(
			sgp.content.areas=c(rep('SCIENCE', 2), 'BIOLOGY', 'PHYSICS'),
			sgp.panel.years=as.character(2014:2017),
			sgp.grade.sequences=list(c(7:8, 'EOCT','EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences="NO_PROJECTIONS",
			sgp.norm.group.preference=1),
	  PHYSICS.2017 = list(
			sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'PHYSICS'),
			sgp.panel.years=as.character(2015:2017),
			sgp.grade.sequences=list(c(8, 'EOCT','EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences="NO_PROJECTIONS",
			sgp.norm.group.preference=2),
		PHYSICS.2017 = list(
			sgp.content.areas=c('EARTH_SCIENCE', 'BIOLOGY', 'PHYSICS'),
			sgp.panel.years=as.character(2015:2017),
			sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
			sgp.exact.grade.progression=TRUE,
			sgp.projection.grade.sequences="NO_PROJECTIONS",
			sgp.norm.group.preference=3),
		PHYSICS.2017 = list(
			sgp.content.areas=c('BIOLOGY', 'PHYSICS'),
			sgp.panel.years=as.character(2016:2017),
			sgp.grade.sequences=list(c('EOCT', 'EOCT')),
			sgp.norm.group.preference=4,
			sgp.projection.sequence = "BIO_PHYS")
	)
