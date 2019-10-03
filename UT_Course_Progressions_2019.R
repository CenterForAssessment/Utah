################################################################################
###                                                                          ###
###           Identify 2019 Progressions for Utah SAGE Assessments           ###
###                                                                          ###
################################################################################

library(SGP)
library(data.table)

# Load 2018 SGP data and the 2019 formatted data
load("./Data/Utah_SGP_LONG_Data-SAGE_ONLY_with_Demographics.Rdata")
load("./Data/Utah_Data_LONG_2019.Rdata")

setnames(Utah_SGP_LONG_Data, SGPstateData[["UT"]][["Variable_Name_Lookup"]][["names.provided"]], SGPstateData[["UT"]][["Variable_Name_Lookup"]][["names.sgp"]])
setnames(Utah_Data_LONG_2019, SGPstateData[["UT"]][["Variable_Name_Lookup"]][["names.provided"]], SGPstateData[["UT"]][["Variable_Name_Lookup"]][["names.sgp"]])


##  Identify only students with 2019 scores
ids <- unique(Utah_Data_LONG_2019[, ID])
Subset_Data_LONG <- rbindlist(list(
                      Utah_SGP_LONG_Data[ID %in% ids, list(ID, YEAR, CONTENT_AREA, GRADE, SCALE_SCORE, VALID_CASE)],
                      # Utah_SGP_LONG_Data[ID %in% ids & YEAR > 2013, list(ID, YEAR, CONTENT_AREA, GRADE, SCALE_SCORE, VALID_CASE)],
                      Utah_Data_LONG_2019[, list(ID, YEAR, CONTENT_AREA, GRADE, SCALE_SCORE, VALID_CASE)])) # CONTENT_AREA != "SEC_MATH_I"

table(Subset_Data_LONG[, CONTENT_AREA, YEAR])

##  Create list of 2019 course progressions by content domains.
ela.prog <- SGP::courseProgressionSGP(Subset_Data_LONG[grepl("ELA", CONTENT_AREA)], lag.direction="BACKWARD", year='2019')
math.prog<- SGP::courseProgressionSGP(Subset_Data_LONG[grepl("MATHEMATICS|SEC_MATH", CONTENT_AREA)], lag.direction="BACKWARD", year='2019') # |SEC_MATH
sci.prog <- SGP::courseProgressionSGP(Subset_Data_LONG[!grepl("MATHEMATICS|SEC_MATH|ELA", CONTENT_AREA)], lag.direction="BACKWARD", year='2019')


####
####     Mathematics
####

###  Find out which Math related content areas are present in the Spring 17 data
names(math.prog$BACKWARD[['2019']])

# ...

sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="MATHEMATICS.03"]$COUNT)   #  46022
sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="MATHEMATICS.03"]$COUNT)   #     84

sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.05[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="MATHEMATICS.04"]$COUNT)   #  46875
sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.05[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="MATHEMATICS.04"]$COUNT)   #     91
sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.05[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="MATHEMATICS.04" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="MATHEMATICS.03"]$COUNT)   #  44484

sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.06[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="MATHEMATICS.05"]$COUNT)   #  46388
sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.06[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="MATHEMATICS.05"]$COUNT)   #    172
sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.06[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="MATHEMATICS.05" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="MATHEMATICS.04"]$COUNT)   #  44035

sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.07[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="MATHEMATICS.06"]$COUNT)   #  41816
sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.07[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="MATHEMATICS.06"]$COUNT)   #    230
sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.07[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="MATHEMATICS.06" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="MATHEMATICS.05"]$COUNT)   #  39533

sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="MATHEMATICS.07"]$COUNT)   #  39269
sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="MATHEMATICS.07"]$COUNT)   #   2269
sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="MATHEMATICS.07" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="MATHEMATICS.06"]$COUNT)   #  36835

table(math.prog$BACKWARD[['2019']]$MATHEMATICS.09$CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)

sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.09[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="MATHEMATICS.08"]$COUNT)   #  39269
sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.09[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="MATHEMATICS.08"]$COUNT)   #     75
sum(math.prog$BACKWARD[['2019']]$MATHEMATICS.09[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="MATHEMATICS.08" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="MATHEMATICS.07"]$COUNT)   #  34990


###   Utah Aspire Plus Math Grade 9

UAP_Math_09 <- math.prog$BACKWARD[['2019']]$MATHEMATICS.09
table(UAP_Math_09$CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)
UAP_Math_09[COUNT > 1000]  #  Major progressions

###   Viable 1 Prior UAP_Math_09 Progressions
UAP_Math_09[, list(Total=sum(COUNT)), keyby="CONTENT_AREA_by_GRADE_PRIOR_YEAR.1"][!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]#[Total > 2500]
#      CONTENT_AREA_by_GRADE_PRIOR_YEAR.1    Total
# 1:                       MATHEMATICS.07       56
# 2:                       MATHEMATICS.08    37514
# 3:                      SEC_MATH_I.EOCT     2765
# 4:                     SEC_MATH_II.EOCT      126
# 5:                    SEC_MATH_III.EOCT        2

###   Viable 2 Prior UAP_Math_09 Progressions
UAP_Math_09[!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1) & !is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.2), list(Total=sum(COUNT)), keyby=c("CONTENT_AREA_by_GRADE_PRIOR_YEAR.1", "CONTENT_AREA_by_GRADE_PRIOR_YEAR.2")][Total > 500]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1   CONTENT_AREA_by_GRADE_PRIOR_YEAR.2   Total
# 1:                     MATHEMATICS.08                       MATHEMATICS.07   34990
# 2:                    SEC_MATH_I.EOCT                       MATHEMATICS.07    1529
# 3:                    SEC_MATH_I.EOCT                       MATHEMATICS.08    1110


###   Utah Aspire Plus Math Grade 10

UAP_Math_10 <- math.prog$BACKWARD[['2019']]$MATHEMATICS.10
table(UAP_Math_10$CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)
UAP_Math_10[COUNT > 1000]  #  Major progressions

###   Viable 1 Prior UAP_Math_10 Progressions
UAP_Math_10[, list(Total=sum(COUNT)), keyby="CONTENT_AREA_by_GRADE_PRIOR_YEAR.1"][!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]#[Total > 2500]
#      CONTENT_AREA_by_GRADE_PRIOR_YEAR.1    Total
# 1:                       MATHEMATICS.07       10
# 2:                       MATHEMATICS.08       75
# 3:                      SEC_MATH_I.EOCT    35305
# 4:                     SEC_MATH_II.EOCT     2934
# 5:                    SEC_MATH_III.EOCT        9

###   Viable 2 Prior UAP_Math_10 Progressions
UAP_Math_10[!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1) & !is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.2), list(Total=sum(COUNT)), keyby=c("CONTENT_AREA_by_GRADE_PRIOR_YEAR.1", "CONTENT_AREA_by_GRADE_PRIOR_YEAR.2")][Total > 500]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1   CONTENT_AREA_by_GRADE_PRIOR_YEAR.2   Total
# 1:                    SEC_MATH_I.EOCT                       MATHEMATICS.08   32524
# 2:                   SEC_MATH_II.EOCT                       MATHEMATICS.08     670
# 3:                   SEC_MATH_II.EOCT                      SEC_MATH_I.EOCT    2067


# ###   Secondary Math I (No Course Regression)
#
SEC_MATH_I <- math.prog$BACKWARD[['2019']]$SEC_MATH_I.EOCT[!grepl("SEC_MATH_II", CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]
table(SEC_MATH_I$CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)
SEC_MATH_I[COUNT > 1000]  #  Major progressions

###   Viable 1 Prior SEC_MATH_I Progressions
SEC_MATH_I[, list(Total=sum(COUNT)), keyby="CONTENT_AREA_by_GRADE_PRIOR_YEAR.1"][!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1 Total

###   Viable 2 Prior SEC_MATH_I Progressions
SEC_MATH_I[!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1) & !is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.2), list(Total=sum(COUNT)), keyby=c("CONTENT_AREA_by_GRADE_PRIOR_YEAR.1", "CONTENT_AREA_by_GRADE_PRIOR_YEAR.2")]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1 CONTENT_AREA_by_GRADE_PRIOR_YEAR.2 Total


####
####     ELA
####

###  Find out which grades are present in the Fall ELA data
names(ela.prog$BACKWARD[['2019']])

# ...

sum(ela.prog$BACKWARD[['2019']]$ELA.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.03"]$COUNT)   #  46183
sum(ela.prog$BACKWARD[['2019']]$ELA.04[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="ELA.03"]$COUNT)   #     50

sum(ela.prog$BACKWARD[['2019']]$ELA.05[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.04"]$COUNT)   #  47138
sum(ela.prog$BACKWARD[['2019']]$ELA.05[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="ELA.04"]$COUNT)   #     55
sum(ela.prog$BACKWARD[['2019']]$ELA.05[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.04" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="ELA.03"]$COUNT)   #  44651

sum(ela.prog$BACKWARD[['2019']]$ELA.06[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.05"]$COUNT)   #  46603
sum(ela.prog$BACKWARD[['2019']]$ELA.06[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="ELA.05"]$COUNT)   #     77
sum(ela.prog$BACKWARD[['2019']]$ELA.06[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.05" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="ELA.04"]$COUNT)   #  44158

sum(ela.prog$BACKWARD[['2019']]$ELA.07[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.06"]$COUNT)   #  44468
sum(ela.prog$BACKWARD[['2019']]$ELA.07[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="ELA.06"]$COUNT)   #     92
sum(ela.prog$BACKWARD[['2019']]$ELA.07[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.06" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="ELA.05"]$COUNT)   #  42058

sum(ela.prog$BACKWARD[['2019']]$ELA.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.07"]$COUNT)   #  42543
sum(ela.prog$BACKWARD[['2019']]$ELA.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="ELA.07"]$COUNT)   #    123
sum(ela.prog$BACKWARD[['2019']]$ELA.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.07" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="ELA.06"]$COUNT)   #  39920

table(ela.prog$BACKWARD[['2019']]$ELA.09$CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)
sum(ela.prog$BACKWARD[['2019']]$ELA.09[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.08"]$COUNT)   #  40286
sum(ela.prog$BACKWARD[['2019']]$ELA.09[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="ELA.08"]$COUNT)   #     39
sum(ela.prog$BACKWARD[['2019']]$ELA.09[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.08" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="ELA.07"]$COUNT)   #  37653


###   Utah Aspire Plus Ela Grade 9 & 10

ela.prog$BACKWARD[['2019']]$ELA.09[, list(Total=sum(COUNT)), keyby="CONTENT_AREA_by_GRADE_PRIOR_YEAR.1"][!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]
sum(ela.prog$BACKWARD[['2019']]$ELA.09[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.08"]$COUNT)   #  40286
sum(ela.prog$BACKWARD[['2019']]$ELA.09[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="ELA.08"]$COUNT)   #     39
sum(ela.prog$BACKWARD[['2019']]$ELA.09[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.08" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="ELA.07"]$COUNT)   #  37653

ela.prog$BACKWARD[['2019']]$ELA.10[, list(Total=sum(COUNT)), keyby="CONTENT_AREA_by_GRADE_PRIOR_YEAR.1"][!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]
sum(ela.prog$BACKWARD[['2019']]$ELA.10[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.09"]$COUNT)   #  37978
sum(ela.prog$BACKWARD[['2019']]$ELA.10[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="ELA.09"]$COUNT)   #     20
sum(ela.prog$BACKWARD[['2019']]$ELA.10[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="ELA.09" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="ELA.08"]$COUNT)  #  35169


####
####     Science
####

###  Find out which Math related content areas are present in the Spring 17 data
names(sci.prog$BACKWARD[['2019']])

# ...

sum(sci.prog$BACKWARD[['2019']]$SCIENCE.05[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="SCIENCE.04"]$COUNT)   #  47169
sum(sci.prog$BACKWARD[['2019']]$SCIENCE.05[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="SCIENCE.04"]$COUNT)   #     36

sum(sci.prog$BACKWARD[['2019']]$SCIENCE.06[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="SCIENCE.05"]$COUNT)   #  46569
sum(sci.prog$BACKWARD[['2019']]$SCIENCE.06[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="SCIENCE.05"]$COUNT)   #     95
sum(sci.prog$BACKWARD[['2019']]$SCIENCE.06[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="SCIENCE.05" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="SCIENCE.04"]$COUNT)   #  44219

sum(sci.prog$BACKWARD[['2019']]$SCIENCE.07[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="SCIENCE.06"]$COUNT)   #  44429
sum(sci.prog$BACKWARD[['2019']]$SCIENCE.07[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="SCIENCE.06"]$COUNT)   #    111
sum(sci.prog$BACKWARD[['2019']]$SCIENCE.07[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="SCIENCE.06" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="SCIENCE.05"]$COUNT)   #  42053

sum(sci.prog$BACKWARD[['2019']]$SCIENCE.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="SCIENCE.07"]$COUNT)   #  42465
sum(sci.prog$BACKWARD[['2019']]$SCIENCE.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1!="SCIENCE.07"]$COUNT)   #     99
sum(sci.prog$BACKWARD[['2019']]$SCIENCE.08[CONTENT_AREA_by_GRADE_PRIOR_YEAR.1=="SCIENCE.07" & CONTENT_AREA_by_GRADE_PRIOR_YEAR.2=="SCIENCE.06"]$COUNT)   #  39849


###   Utah Aspire Plus Science Grade 9

UAP_Sci_09 <- sci.prog$BACKWARD[['2019']]$SCIENCE.09
table(UAP_Sci_09$CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)
UAP_Sci_09[COUNT > 1000]  #  Major progressions

###   Viable 1 Prior UAP_Sci_09 Progressions
UAP_Sci_09[, list(Total=sum(COUNT)), keyby="CONTENT_AREA_by_GRADE_PRIOR_YEAR.1"][!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1   Total
# 1:                       BIOLOGY.EOCT       8
# 2:                     CHEMISTRY.EOCT       1
# 3:                 EARTH_SCIENCE.EOCT       6
# 4:                       PHYSICS.EOCT      10
# 5:                         SCIENCE.07      61
# 6:                         SCIENCE.08   40620

###   Viable 2 Prior UAP_Sci_09 Progressions
UAP_Sci_09[!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1) & !is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.2), list(Total=sum(COUNT)), keyby=c("CONTENT_AREA_by_GRADE_PRIOR_YEAR.1", "CONTENT_AREA_by_GRADE_PRIOR_YEAR.2")][Total > 2500]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1   CONTENT_AREA_by_GRADE_PRIOR_YEAR.2   Total
# 1:                         SCIENCE.08                           SCIENCE.07   37983


###   Utah Aspire Plus Science Grade 10

UAP_Sci_10 <- sci.prog$BACKWARD[['2019']]$SCIENCE.10
table(UAP_Sci_10$CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)
UAP_Sci_10[COUNT > 1000]  #  Major progressions

###   Viable 1 Prior UAP_Sci_10 Progressions
UAP_Sci_10[, list(Total=sum(COUNT)), keyby="CONTENT_AREA_by_GRADE_PRIOR_YEAR.1"][!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1)]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1   Total
# 1:                       BIOLOGY.EOCT   16833
# 2:                     CHEMISTRY.EOCT     306
# 3:                 EARTH_SCIENCE.EOCT   17784
# 4:                       PHYSICS.EOCT    2473
# 5:                         SCIENCE.08       5

###   Viable 2 Prior UAP_Sci_10 Progressions
UAP_Sci_10[!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1) & !is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.2), list(Total=sum(COUNT)), keyby=c("CONTENT_AREA_by_GRADE_PRIOR_YEAR.1", "CONTENT_AREA_by_GRADE_PRIOR_YEAR.2")][Total > 2500]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1   CONTENT_AREA_by_GRADE_PRIOR_YEAR.2   Total
# 1:                       BIOLOGY.EOCT                           SCIENCE.08   15662
# 2:                 EARTH_SCIENCE.EOCT                           SCIENCE.08   16428

###   Viable 3 Prior UAP_Sci_10 Progressions
UAP_Sci_10[!is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.1) & !is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.2) & !is.na(CONTENT_AREA_by_GRADE_PRIOR_YEAR.3), list(Total=sum(COUNT)), keyby=c("CONTENT_AREA_by_GRADE_PRIOR_YEAR.1", "CONTENT_AREA_by_GRADE_PRIOR_YEAR.2", "CONTENT_AREA_by_GRADE_PRIOR_YEAR.3")][Total > 2500]
#    CONTENT_AREA_by_GRADE_PRIOR_YEAR.1   CONTENT_AREA_by_GRADE_PRIOR_YEAR.2   CONTENT_AREA_by_GRADE_PRIOR_YEAR.3   Total
# 1:                       BIOLOGY.EOCT                           SCIENCE.08                           SCIENCE.07   15013
# 2:                 EARTH_SCIENCE.EOCT                           SCIENCE.08                           SCIENCE.07   15533
