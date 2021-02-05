ls()
# "PUF2019_100920"
D <- PUF2019_100920

NSUDH2019 <- subset(D, select=
c("QUESTID2"    # ID info
, "ndssansp", "ndssdnsp", "ftnddnsp", "dnicnsp", "cigavgm"    # Nicotine Dep
, "depndalc", "abusealc", "abodalc", "alcyrtot"   # Alcohol
, "depndmrj", "abodmrj", "mrdaypyr", "mrdaypmo", "mjyrtot"    # Marijuana
, "ircigage", "iralcage", "irmjage"  #First Use History
, "WSPDSC2", "WHODASC3", "SMIPP_U", "AMDEY2_U"  #Mental Illness
, "nonabovev", "asthmaevr", "copdever", "hivaidsev", "diabetevr", "hrtcondev"  #Health Consition History
, "IRINSUR4", "IRFAMIN3"  #SES
))

write.csv(NSUDH2019,"NSUDH2019.csv", row.names = FALSE)
