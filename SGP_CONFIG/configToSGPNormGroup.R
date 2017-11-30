###################################################################################################
###
### Script to convert SGP configurations for EOCT analyses to SGP_NORM_GROUP preference tables
###
###################################################################################################

### Load packages

require("data.table")
options(error=recover)

setwd("~/SGP_Projects/Utah")

### utility function

configToSGPNormGroup <- function(sgp.config) {
	if ("sgp.norm.group.preference" %in% names(sgp.config)) {
		if ("sgp.exact.grade.progression" %in% names(sgp.config)) {
			# tmp.norm.group.baseline <-
			tmp.norm.group <- paste(sgp.config$sgp.panel.years, paste(sgp.config$sgp.content.areas,
				unlist(sgp.config$sgp.grade.sequences), sep="_"), sep="/")
			tmp.data.all <- data.table(
				SGP_NORM_GROUP=paste(tmp.norm.group, collapse="; "),
				# SGP_NORM_GROUP_BASELINE=paste(tmp.norm.group.baseline, collapse="; "),
				PREFERENCE=as.integer(sgp.config$sgp.norm.group.preference)
			)
		} else {
			tmp.data.all <- data.table()
			for (g in 1:length(sgp.config$sgp.grade.sequences)) {
				l <- length(sgp.config$sgp.grade.sequences[[g]])
				# tmp.norm.group.baseline <-
				tmp.norm.group <- paste(tail(sgp.config$sgp.panel.years, l),
					paste(tail(sgp.config$sgp.content.areas, l), unlist(sgp.config$sgp.grade.sequences[[g]]), sep="_"), sep="/")

		        tmp.data <- data.table(
					SGP_NORM_GROUP=paste(tmp.norm.group, collapse="; "),
					# SGP_NORM_GROUP_BASELINE=paste(tmp.norm.group.baseline, collapse="; "),
					PREFERENCE= sgp.config$sgp.norm.group.preference*100)

		        if (length(tmp.norm.group) > 2) {
			        for (n in 1:(length(tmp.norm.group)-2)) {
						tmp.data <- rbind(tmp.data, data.table(
							SGP_NORM_GROUP=paste(tail(tmp.norm.group, -n), collapse="; "),
							# SGP_NORM_GROUP_BASELINE=paste(tail(tmp.norm.group.baseline, -n), collapse="; "),
							PREFERENCE= (sgp.config$sgp.norm.group.preference*100)+n))
					}
				}
				tmp.data.all <- rbind(tmp.data.all, tmp.data)
			}
		}
		return(unique(tmp.data.all))
	} else {
		return(NULL)
	}
}

### Load and create 2011 and 2012 EOCT Configuration

source("SGP_CONFIG/EOCT/2011/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2011/SCIENCE.R")

source("SGP_CONFIG/EOCT/2012/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2012/SCIENCE.R")

source("SGP_CONFIG/EOCT/2013/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2013/SCIENCE.R")

source("SGP_CONFIG/EOCT/2014/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2014/SCIENCE.R")

source("SGP_CONFIG/EOCT/2015/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2015/SCIENCE.R")

source("SGP_CONFIG/EOCT/2016/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2016/SCIENCE.R")

UT_EOCT_2011.config <- c(
		EARTH_SCIENCE_2011.config,
		BIOLOGY_2011.config,
		CHEMISTRY_2011.config,
		PHYSICS_2011.config,
		PRE_ALGEBRA_2011.config,
		ALGEBRA_I_2011.config,
		GEOMETRY_2011.config,
		ALGEBRA_II_2011.config)

UT_EOCT_2012.config <- c(
		EARTH_SCIENCE_2012.config,
		BIOLOGY_2012.config,
		CHEMISTRY_2012.config,
		PHYSICS_2012.config,
		PRE_ALGEBRA_2012.config,
		ALGEBRA_I_2012.config,
		GEOMETRY_2012.config,
		ALGEBRA_II_2012.config)

UT_EOCT_2013.config <- c(
		EARTH_SCIENCE_2013.config,
		BIOLOGY_2013.config,
		CHEMISTRY_2013.config,
		PHYSICS_2013.config,
		PRE_ALGEBRA_2013.config,
		ALGEBRA_I_2013.config,
		GEOMETRY_2013.config,
		ALGEBRA_II_2013.config)

UT_EOCT_2014.config <- c(
		EARTH_SCIENCE_2014.config,
		BIOLOGY_2014.config,
		CHEMISTRY_2014.config,
		PHYSICS_2014.config,

		SEC_MATH_I_2014.config,
		SEC_MATH_II_2014.config,
		SEC_MATH_III_2014.config)

UT_EOCT_2015.config <- c(
	EARTH_SCIENCE_2015.config,
	BIOLOGY_2015.config,
	CHEMISTRY_2015.config,
	PHYSICS_2015.config,

	SEC_MATH_I_2015.config,
	SEC_MATH_II_2015.config,
	SEC_MATH_III_2015.config)

UT_EOCT_2016.config <- c(
	EARTH_SCIENCE_2016.config,
	BIOLOGY_2016.config,
	CHEMISTRY_2016.config,
	PHYSICS_2016.config,

	SEC_MATH_I_2016.config,
	SEC_MATH_II_2016.config,
	SEC_MATH_III_2016.config)

### Create configToNormGroup data.frame

tmp.configToNormGroup <- lapply(UT_EOCT_2011.config, configToSGPNormGroup)
UT_SGP_Norm_Group_Preference_2011 <- data.table(
					YEAR="2011",
					rbindlist(tmp.configToNormGroup))


tmp.configToNormGroup <- lapply(UT_EOCT_2012.config, configToSGPNormGroup)
UT_SGP_Norm_Group_Preference_2012 <- data.table(
					YEAR="2012",
					rbindlist(tmp.configToNormGroup))

tmp.configToNormGroup <- lapply(UT_EOCT_2013.config, configToSGPNormGroup)
UT_SGP_Norm_Group_Preference_2013 <- data.table(
					YEAR="2013",
					rbindlist(tmp.configToNormGroup))

tmp.configToNormGroup <- lapply(UT_EOCT_2014.config, configToSGPNormGroup)
UT_SGP_Norm_Group_Preference_2014 <- data.table(
					YEAR="2014",
					rbindlist(tmp.configToNormGroup))

tmp.configToNormGroup <- lapply(UT_EOCT_2015.config, configToSGPNormGroup)
UT_SGP_Norm_Group_Preference_2015 <- data.table(
					YEAR="2015",
					rbindlist(tmp.configToNormGroup))

tmp.configToNormGroup <- lapply(UT_EOCT_2016.config, configToSGPNormGroup)
UT_SGP_Norm_Group_Preference_2016 <- data.table(
					YEAR="2016",
					rbindlist(tmp.configToNormGroup))

UT_SGP_Norm_Group_Preference <- rbindlist(list(
					UT_SGP_Norm_Group_Preference_2011,
					UT_SGP_Norm_Group_Preference_2012,
					UT_SGP_Norm_Group_Preference_2013,
					UT_SGP_Norm_Group_Preference_2014,
					UT_SGP_Norm_Group_Preference_2015,
					UT_SGP_Norm_Group_Preference_2016))

UT_SGP_Norm_Group_Preference$SGP_NORM_GROUP <- as.factor(UT_SGP_Norm_Group_Preference$SGP_NORM_GROUP)

#  Look at ALGEBRA_II Norm Preference to see how this works...
tail(UT_SGP_Norm_Group_Preference, 14)

### Save result

setkey(UT_SGP_Norm_Group_Preference, YEAR, SGP_NORM_GROUP, PREFERENCE)
setkey(UT_SGP_Norm_Group_Preference, YEAR, SGP_NORM_GROUP)
UT_SGP_Norm_Group_Preference <- unique(UT_SGP_Norm_Group_Preference)
save(UT_SGP_Norm_Group_Preference, file="SGP_CONFIG/UT_SGP_Norm_Group_Preference.Rdata")
