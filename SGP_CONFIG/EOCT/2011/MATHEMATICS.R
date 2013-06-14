#####################################################################################
###
### 	Scripts associated with 2011 EOCT MATHEMATICS: 
###			PRE_ALGEBRA, ALGEBRA_I, GEOMETRY & ALGEBRA_II
###
#####################################################################################


PRE_ALGEBRA_2011.config <- list(
	PRE_ALGEBRA.2011 = list(
		sgp.content.areas=c('PRE_ALGEBRA', 'PRE_ALGEBRA'),  #  Repeaters - this is a policy decision  
		sgp.panel.years=as.character(2010:2011),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0),

	PRE_ALGEBRA.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 4), 'PRE_ALGEBRA'),
		sgp.panel.years=as.character(2007:2011),
		sgp.grade.sequences=list(c(3:6, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	PRE_ALGEBRA.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 3), 'PRE_ALGEBRA'),
		sgp.panel.years=as.character(2008:2011),
		sgp.grade.sequences=list(c(4:6, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	PRE_ALGEBRA.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2), 'PRE_ALGEBRA'),
		sgp.panel.years=as.character(2009:2011),
		sgp.grade.sequences=list(c(5:6, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	PRE_ALGEBRA.2011 = list(
		sgp.content.areas=c('MATHEMATICS', 'PRE_ALGEBRA'),
		sgp.panel.years=as.character(2009:2011),
		sgp.grade.sequences=list(c(6, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),

	PRE_ALGEBRA.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 5), 'PRE_ALGEBRA'),
		sgp.panel.years=as.character(2006:2011),
		sgp.grade.sequences=list(c(3:7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	PRE_ALGEBRA.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 4), 'PRE_ALGEBRA'),
		sgp.panel.years=as.character(2007:2011),
		sgp.grade.sequences=list(c(4:7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	PRE_ALGEBRA.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 3), 'PRE_ALGEBRA'),
		sgp.panel.years=as.character(2008:2011),
		sgp.grade.sequences=list(c(5:7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	PRE_ALGEBRA.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2), 'PRE_ALGEBRA'),
		sgp.panel.years=as.character(2009:2011),
		sgp.grade.sequences=list(c(6:7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	PRE_ALGEBRA.2011 = list(
		sgp.content.areas=c('MATHEMATICS', 'PRE_ALGEBRA'),
		sgp.panel.years=as.character(2010:2011),
		sgp.grade.sequences=list(c(7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5)
)

	###  Alg I without pre-algebra was missing originally.  Added 5/31/13
	
ALGEBRA_I_2011.config <- list(
# No pre-alg prior:
	ALGEBRA_I.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 4), 'ALGEBRA_I'),
		sgp.panel.years=as.character(2007:2011),
		sgp.grade.sequences=list(c(3:6, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	ALGEBRA_I.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 3), 'ALGEBRA_I'),
		sgp.panel.years=as.character(2008:2011),
		sgp.grade.sequences=list(c(4:6, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	ALGEBRA_I.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2), 'ALGEBRA_I'),
		sgp.panel.years=as.character(2009:2011),
		sgp.grade.sequences=list(c(5:6, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	ALGEBRA_I.2011 = list(
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=as.character(2009:2011),
		sgp.grade.sequences=list(c(6, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),

	ALGEBRA_I.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 5), 'ALGEBRA_I'),
		sgp.panel.years=as.character(2006:2011),
		sgp.grade.sequences=list(c(3:7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	ALGEBRA_I.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 4), 'ALGEBRA_I'),
		sgp.panel.years=as.character(2007:2011),
		sgp.grade.sequences=list(c(4:7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	ALGEBRA_I.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 3), 'ALGEBRA_I'),
		sgp.panel.years=as.character(2008:2011),
		sgp.grade.sequences=list(c(5:7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	ALGEBRA_I.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2), 'ALGEBRA_I'),
		sgp.panel.years=as.character(2009:2011),
		sgp.grade.sequences=list(c(6:7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	ALGEBRA_I.2011 = list(
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=as.character(2010:2011),
		sgp.grade.sequences=list(c(7, 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),


#  Pre-alg prior:
	ALGEBRA_I.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 4), 'PRE_ALGEBRA', 'ALGEBRA_I'),
		sgp.panel.years=as.character(2006:2011),
		sgp.grade.sequences=list(c(3:6, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	ALGEBRA_I.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 3), 'PRE_ALGEBRA', 'ALGEBRA_I'),
		sgp.panel.years=as.character(2007:2011),
		sgp.grade.sequences=list(c(4:6, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	ALGEBRA_I.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2), 'PRE_ALGEBRA', 'ALGEBRA_I'),
		sgp.panel.years=as.character(2008:2011),
		sgp.grade.sequences=list(c(5:6, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	ALGEBRA_I.2011 = list(
		sgp.content.areas=c('MATHEMATICS', 'PRE_ALGEBRA', 'ALGEBRA_I'),
		sgp.panel.years=as.character(2009:2011),
		sgp.grade.sequences=list(c(6, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),

	ALGEBRA_I.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 5), 'PRE_ALGEBRA', 'ALGEBRA_I'),
		sgp.panel.years=as.character(2005:2011),
		sgp.grade.sequences=list(c(3:7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	ALGEBRA_I.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 4), 'PRE_ALGEBRA', 'ALGEBRA_I'),
		sgp.panel.years=as.character(2006:2011),
		sgp.grade.sequences=list(c(4:7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	ALGEBRA_I.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 3), 'PRE_ALGEBRA', 'ALGEBRA_I'),
		sgp.panel.years=as.character(2007:2011),
		sgp.grade.sequences=list(c(5:7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	ALGEBRA_I.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2), 'PRE_ALGEBRA', 'ALGEBRA_I'),
		sgp.panel.years=as.character(2008:2011),
		sgp.grade.sequences=list(c(6:7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	ALGEBRA_I.2011 = list(
		sgp.content.areas=c('MATHEMATICS', 'PRE_ALGEBRA', 'ALGEBRA_I'),
		sgp.panel.years=as.character(2009:2011),
		sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),

	ALGEBRA_I.2011 = list(
		sgp.content.areas=c('PRE_ALGEBRA', 'ALGEBRA_I'),
		sgp.panel.years=as.character(2010:2011),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=6)
)

GEOMETRY_2011.config <- list(
	GEOMETRY.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 4), 'PRE_ALGEBRA', 'ALGEBRA_I', 'GEOMETRY'),
		sgp.panel.years=as.character(2005:2011),
		sgp.grade.sequences=list(c(3:6, 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	GEOMETRY.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 3), 'PRE_ALGEBRA', 'ALGEBRA_I', 'GEOMETRY'),
		sgp.panel.years=as.character(2006:2011),
		sgp.grade.sequences=list(c(4:6, 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	GEOMETRY.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2), 'PRE_ALGEBRA', 'ALGEBRA_I', 'GEOMETRY'),
		sgp.panel.years=as.character(2007:2011),
		sgp.grade.sequences=list(c(5:6, 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	GEOMETRY.2011 = list(
		sgp.content.areas=c('MATHEMATICS', 'PRE_ALGEBRA', 'ALGEBRA_I', 'GEOMETRY'),
		sgp.panel.years=as.character(2008:2011),
		sgp.grade.sequences=list(c(6, 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),

	GEOMETRY.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 4), 'PRE_ALGEBRA', 'ALGEBRA_I', 'GEOMETRY'),
		sgp.panel.years=as.character(2005:2011),
		sgp.grade.sequences=list(c(4:7, 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	GEOMETRY.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 3), 'PRE_ALGEBRA', 'ALGEBRA_I', 'GEOMETRY'),
		sgp.panel.years=as.character(2006:2011),
		sgp.grade.sequences=list(c(5:7, 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	GEOMETRY.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2), 'PRE_ALGEBRA', 'ALGEBRA_I', 'GEOMETRY'),
		sgp.panel.years=as.character(2007:2011),
		sgp.grade.sequences=list(c(6:7, 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	GEOMETRY.2011 = list(
		sgp.content.areas=c('MATHEMATICS', 'PRE_ALGEBRA', 'ALGEBRA_I', 'GEOMETRY'),
		sgp.panel.years=as.character(2008:2011),
		sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),

	GEOMETRY.2011 = list(
		sgp.content.areas=c('PRE_ALGEBRA', 'ALGEBRA_I', 'GEOMETRY'),
		sgp.panel.years=as.character(2009:2011),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),
	GEOMETRY.2011 = list(
		sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY'),
		sgp.panel.years=as.character(2010:2011),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=6)
)


ALGEBRA_II_2011.config <- list(
	ALGEBRA_II.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 3), 'PRE_ALGEBRA', 'ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II'),
		sgp.panel.years=as.character(2005:2011),
		sgp.grade.sequences=list(c(5:7, 'EOCT', 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	ALGEBRA_II.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2), 'PRE_ALGEBRA', 'ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II'),
		sgp.panel.years=as.character(2006:2011),
		sgp.grade.sequences=list(c(6:7, 'EOCT', 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	ALGEBRA_II.2011 = list(
		sgp.content.areas=c('MATHEMATICS', 'PRE_ALGEBRA', 'ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II'),
		sgp.panel.years=as.character(2007:2011),
		sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),

	ALGEBRA_II.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 3), 'PRE_ALGEBRA', 'ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II'),
		sgp.panel.years=as.character(2005:2011),
		sgp.grade.sequences=list(c(4:6, 'EOCT', 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	ALGEBRA_II.2011 = list(
		sgp.content.areas=c(rep('MATHEMATICS', 2), 'PRE_ALGEBRA', 'ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II'),
		sgp.panel.years=as.character(2006:2011),
		sgp.grade.sequences=list(c(5:6, 'EOCT', 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	ALGEBRA_II.2011 = list(
		sgp.content.areas=c('MATHEMATICS', 'PRE_ALGEBRA', 'ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II'),
		sgp.panel.years=as.character(2007:2011),
		sgp.grade.sequences=list(c(6, 'EOCT', 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),

	ALGEBRA_II.2011 = list(
		sgp.content.areas=c('PRE_ALGEBRA', 'ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II'),
		sgp.panel.years=as.character(2008:2011),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	ALGEBRA_II.2011 = list(
		sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY', 'ALGEBRA_II'),
		sgp.panel.years=as.character(2009:2011),
		sgp.grade.sequences=list(c('EOCT', 'EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),
	ALGEBRA_II.2011 = list(
		sgp.content.areas=c('GEOMETRY', 'ALGEBRA_II'),
		sgp.panel.years=as.character(2010:2011),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=6)
)