##    Changes/Additions for '25 Scale and Content Changes
##    Add knots/bounds forELA:

###   Load packages
require(data.table)

load("Data/Utah_Data_LONG_2025.Rdata")
load("Data/Utah_Data_LONG_2026.Rdata")
Utah_Data_ELA_2025  <- Utah_Data_LONG_2025[CONTENT_AREA == "ELA"]
Utah_Data_ELA_2026  <- Utah_Data_LONG_2026[CONTENT_AREA == "ELA"]

UT_ELA_2025_KBs <-
    SGP:::createKnotsBoundaries(
        rbindlist(list(Utah_Data_ELA_2025, Utah_Data_ELA_2026), use.names = TRUE, fill = TRUE)
    )[["ELA"]]

save(UT_ELA_2025_KBs, file = "Data/UT_ELA_2025_KBs.rda")
