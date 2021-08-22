################################################################################
###                                                                          ###
###           Identify 2018 Progressions for Utah SAGE Assessments           ###
###                                                                          ###
################################################################################

library(SGP)
library(data.table)

# Load 2017 SGP data and the 2018 formatted data
load("Data/Utah_SGP_LONG_Data.Rdata")
load("Data/Utah_Data_LONG_2018.Rdata")


##  Identify only students with 2018 scores
ids <- unique(Utah_Data_LONG_2018[YEAR=="2018", ID])
Subset_Data_LONG <- rbindlist(list(
                      Utah_SGP_LONG_Data[ID %in% ids, list(ID, YEAR, CONTENT_AREA, GRADE, SCALE_SCORE, VALID_CASE)],
                      Utah_Data_LONG_2018[, list(ID, YEAR, CONTENT_AREA, GRADE, SCALE_SCORE, VALID_CASE)]))

Subset_Data_LONG <- Subset_Data_LONG[YEAR > 2012]

##  Create list of 2018 course progressions by content domains.
ela.prog <- SGP::courseProgressionSGP(Subset_Data_LONG[grepl("ELA", CONTENT_AREA)], lag.direction="BACKWARD", year='2018')
math.prog<- SGP::courseProgressionSGP(Subset_Data_LONG[grepl("MATHEMATICS|SEC_MATH", CONTENT_AREA)], lag.direction="BACKWARD", year='2018')

sci.prog<- SGP::courseProgressionSGP(Subset_Data_LONG[!grepl("MATHEMATICS|SEC_MATH|ALGEBRA|GEOMETRY|ELA", CONTENT_AREA)], lag.direction="BACKWARD", year='2018')


####
####     Mathematics
####

###  Find out which Math related content areas are present in the Spring 17 data
names(math.prog$BACKWARD[['2018']])

# ...

sum(math.prog$BACKWARD[['2018']]$MATHEMATICS.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="MATHEMATICS.07"]$COUNT)   #  39,201
sum(math.prog$BACKWARD[['2018']]$MATHEMATICS.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="MATHEMATICS.07"]$COUNT)   #   1,341
sum(math.prog$BACKWARD[['2018']]$MATHEMATICS.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="MATHEMATICS.07" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="MATHEMATICS.06"]$COUNT)   #  36828

###   Secondary Math I (No Course Regression)

SEC_MATH_I <- math.prog$BACKWARD[['2018']]$SEC_MATH_I.EOCT[!grepl("SEC_MATH_II", CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]
table(SEC_MATH_I$CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)
SEC_MATH_I[COUNT > 1000]  #  Major progressions

###   Viable 1 Prior (Spring 17) SEC_MATH_I Progressions
SEC_MATH_I[, list(Total=sum(COUNT)), keyby="CONTENT_AREA_by_GRADE_PRIOR_YEAR.1"][!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1 Total
# 1:                     MATHEMATICS.06    80
# 2:                     MATHEMATICS.07  1710
# 3:                     MATHEMATICS.08 38024
# 4:                    SEC_MATH_I.EOCT  1124

###   Viable 2 Prior SEC_MATH_I Progressions
SEC_MATH_I[!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1) & !is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.2), list(Total=sum(COUNT)), keyby=c("CONTENT_AREA_by_GRADE_PRIOR_YEAR.1", "CONTENT_AREA_by_GRADE_PRIOR_YEAR.2")][Total > 3000]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1 CONTENT_AREA_by_GRADE_PRIOR_YEAR.2 Total
# 1:                     MATHEMATICS.08                     MATHEMATICS.07 34655


###   Secondary Math 2 (No Course Regression)

SEC_MATH_II <- math.prog$BACKWARD[['2018']]$SEC_MATH_II.EOCT[!grepl("SEC_MATH_III", CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]
table(SEC_MATH_II$CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)
SEC_MATH_II[COUNT > 100]  #  Major progressions

###   Viable 1 Prior (Spring 17) SEC_MATH_II Progressions
SEC_MATH_II[, list(Total=sum(COUNT)), keyby="CONTENT_AREA_by_GRADE_PRIOR_YEAR.1"][!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1 Total
# 1:                     MATHEMATICS.06     8
# 2:                     MATHEMATICS.07    56
# 3:                     MATHEMATICS.08   840
# 4:                    SEC_MATH_I.EOCT 35234
# 5:                   SEC_MATH_II.EOCT   365

###   Viable 2 Prior SEC_MATH_II Progressions
SEC_MATH_II[!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1) & !is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.2), list(Total=sum(COUNT)), keyby=c("CONTENT_AREA_by_GRADE_PRIOR_YEAR.1", "CONTENT_AREA_by_GRADE_PRIOR_YEAR.2")][Total > 3000]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1   CONTENT_AREA_by_GRADE_PRIOR_YEAR.2   Total
# 1:                    SEC_MATH_I.EOCT                       MATHEMATICS.08   31151


###   Secondary Math 3

SEC_MATH_III <- math.prog$BACKWARD[['2018']]$SEC_MATH_III.EOCT
table(SEC_MATH_III$CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)
SEC_MATH_III[COUNT > 1000]  #  Major progressions

###   Viable 1 Prior (Spring 17) Progressions
SEC_MATH_III[, list(Total=sum(COUNT)), keyby="CONTENT_AREA_by_GRADE_PRIOR_YEAR.1"][!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1   Total
# 1:                     MATHEMATICS.07       3
# 2:                     MATHEMATICS.08      59
# 3:                    SEC_MATH_I.EOCT     687
# 4:                   SEC_MATH_II.EOCT    7863
# 5:                  SEC_MATH_III.EOCT      54

###   Viable 2 Prior (Spring 17 + Spring 16) SEC_MATH_I Progressions
SEC_MATH_III[!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1) & !is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.2), list(Total=sum(COUNT)), keyby=c("CONTENT_AREA_by_GRADE_PRIOR_YEAR.1", "CONTENT_AREA_by_GRADE_PRIOR_YEAR.2")][Total > 1500]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1 CONTENT_AREA_by_GRADE_PRIOR_YEAR.2 Total
# 1:                   SEC_MATH_II.EOCT                    SEC_MATH_I.EOCT  6833



####
####     ELA
####

###  Find out which grades are present in the Fall ELA data
names(ela.prog$BACKWARD[['2018']])

# ...

sum(ela.prog$BACKWARD[['2018']]$ELA.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.07"]$COUNT)   #  41,955
sum(ela.prog$BACKWARD[['2018']]$ELA.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="ELA.07"]$COUNT)   #      98
sum(ela.prog$BACKWARD[['2018']]$ELA.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.07" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="ELA.06"]$COUNT)   #  39597

sum(ela.prog$BACKWARD[['2018']]$ELA.09[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.08"]$COUNT)   #  40,364
sum(ela.prog$BACKWARD[['2018']]$ELA.09[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="ELA.08"]$COUNT)   #     119
sum(ela.prog$BACKWARD[['2018']]$ELA.09[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.08" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="ELA.07"]$COUNT)   #  38175

sum(ela.prog$BACKWARD[['2018']]$ELA.10[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.09"]$COUNT)   #  36,632
sum(ela.prog$BACKWARD[['2018']]$ELA.10[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="ELA.09"]$COUNT)   #     308
sum(ela.prog$BACKWARD[['2018']]$ELA.10[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.09" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="ELA.08"]$COUNT)  #  34305

sum(ela.prog$BACKWARD[['2018']]$ELA.11[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.10"]$COUNT)   #   1,929
sum(ela.prog$BACKWARD[['2018']]$ELA.11[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="ELA.10"]$COUNT)   #      47
sum(ela.prog$BACKWARD[['2018']]$ELA.11[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.10" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="ELA.09"]$COUNT) # 1711


####
####     Science
####

###  Find out which Math related content areas are present in the Spring 17 data
names(sci.prog$BACKWARD[['2018']])

# ...

sum(sci.prog$BACKWARD[['2018']]$SCIENCE.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="SCIENCE.07"]$COUNT)   #  42,106
sum(sci.prog$BACKWARD[['2018']]$SCIENCE.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="SCIENCE.07"]$COUNT)   #     104
sum(sci.prog$BACKWARD[['2018']]$SCIENCE.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="SCIENCE.07" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="SCIENCE.06"]$COUNT)   #  39714

###   EARTH_SCIENCE (No Course Regression)

EARTH_SCIENCE <- sci.prog$BACKWARD[['2018']]$EARTH_SCIENCE.EOCT
table(EARTH_SCIENCE$CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)
EARTH_SCIENCE[COUNT > 1000]  #  Major progressions

###   Viable 1 Prior (Spring 17) EARTH_SCIENCE Progressions
EARTH_SCIENCE[, list(Total=sum(COUNT)), keyby="CONTENT_AREA_by_GRADE_PRIOR_YEAR.1"][!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1 Total
# 1:                       BIOLOGY.EOCT   890
# 2:                     CHEMISTRY.EOCT    70
# 3:                 EARTH_SCIENCE.EOCT   128
# 4:                       PHYSICS.EOCT   101
# 5:                         SCIENCE.06     1
# 6:                         SCIENCE.07    18
# 7:                         SCIENCE.08 19014


###   Viable 2 Prior EARTH_SCIENCE Progressions
EARTH_SCIENCE[!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1) & !is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.2), list(Total=sum(COUNT)), keyby=c("CONTENT_AREA_by_GRADE_PRIOR_YEAR.1", "CONTENT_AREA_by_GRADE_PRIOR_YEAR.2")][Total > 3000]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1 CONTENT_AREA_by_GRADE_PRIOR_YEAR.2 Total
# 1:                         SCIENCE.08                         SCIENCE.07 17775


###   BIOLOGY

BIOLOGY <- sci.prog$BACKWARD[['2018']]$BIOLOGY.EOCT
table(BIOLOGY$CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)
BIOLOGY[COUNT > 1000]  #  Major progressions

###   Viable 1 Prior (Spring 17) BIOLOGY Progressions
BIOLOGY[, list(Total=sum(COUNT)), keyby="CONTENT_AREA_by_GRADE_PRIOR_YEAR.1"][!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1 Total
# 1:                       BIOLOGY.EOCT   791
# 2:                     CHEMISTRY.EOCT   652
# 3:                 EARTH_SCIENCE.EOCT 16237
# 4:                       PHYSICS.EOCT  2173  XXX  No BIO_PHYS
# 5:                         SCIENCE.06     1
# 6:                         SCIENCE.07    20
# 7:                         SCIENCE.08 17398

###   Viable 2 Prior BIOLOGY Progressions
BIOLOGY[!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1) & !is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.2), list(Total=sum(COUNT)), keyby=c("CONTENT_AREA_by_GRADE_PRIOR_YEAR.1", "CONTENT_AREA_by_GRADE_PRIOR_YEAR.2")][Total > 3000]
# CONTENT_AREA_by_GRADE_PRIOR_YEAR.1 CONTENT_AREA_by_GRADE_PRIOR_YEAR.2 Total
# 1:                 EARTH_SCIENCE.EOCT                         SCIENCE.08 15023
# 2:                         SCIENCE.08                         SCIENCE.07 16578


###   Chemistry

CHEMISTRY <- sci.prog$BACKWARD[['2018']]$CHEMISTRY.EOCT
table(CHEMISTRY$CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)
CHEMISTRY[COUNT > 1000]  #  Major progressions

###   Viable 1 Prior (Spring 17) CHEMISTRY Progressions
CHEMISTRY[, list(Total=sum(COUNT)), keyby="CONTENT_AREA_by_GRADE_PRIOR_YEAR.1"][!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1 Total
# 1:                       BIOLOGY.EOCT 12801
# 2:                     CHEMISTRY.EOCT   234
# 3:                 EARTH_SCIENCE.EOCT   762
# 4:                       PHYSICS.EOCT  1966  XXX  No PHYS_CHEM
# 5:                         SCIENCE.06     1
# 6:                         SCIENCE.07     4
# 7:                         SCIENCE.08   283

###   Viable 2 Prior CHEMISTRY Progressions
CHEMISTRY[!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1) & !is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.2), list(Total=sum(COUNT)), keyby=c("CONTENT_AREA_by_GRADE_PRIOR_YEAR.1", "CONTENT_AREA_by_GRADE_PRIOR_YEAR.2")][Total > 3000]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1   CONTENT_AREA_by_GRADE_PRIOR_YEAR.2   Total
# 1:                    BIOLOGY.EOCT                       SCIENCE.08   8703


###   Physics

PHYSICS <- sci.prog$BACKWARD[['2018']]$PHYSICS.EOCT
table(PHYSICS$CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)
PHYSICS[COUNT > 1000]  #  Major progressions

###   Viable 1 Prior (Spring 17) Progressions
PHYSICS[, list(Total=sum(COUNT)), keyby="CONTENT_AREA_by_GRADE_PRIOR_YEAR.1"][!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1   Total
# 1:                       BIOLOGY.EOCT  4575
# 2:                     CHEMISTRY.EOCT  2888  XXX  Potential Problem!  Disrupts the canonical progression...
# 3:                 EARTH_SCIENCE.EOCT   597
# 4:                       PHYSICS.EOCT   136
# 5:                         SCIENCE.07    10
# 6:                         SCIENCE.08  2690

###   Viable 2 Prior (Spring 17 + Spring 16) BIOLOGY Progressions
PHYSICS[!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1) & !is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.2), list(Total=sum(COUNT)), keyby=c("CONTENT_AREA_by_GRADE_PRIOR_YEAR.1", "CONTENT_AREA_by_GRADE_PRIOR_YEAR.2")][Total > 1500]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1 CONTENT_AREA_by_GRADE_PRIOR_YEAR.2 Total
# 1:                       BIOLOGY.EOCT                         SCIENCE.08  3369
# 2:                     CHEMISTRY.EOCT                       BIOLOGY.EOCT  2465
# 3:                         SCIENCE.08                         SCIENCE.07  2579
