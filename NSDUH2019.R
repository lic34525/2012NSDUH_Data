ls()
# "PUF2019_100920"
D <- PUF2019_100920

NSUDH2019 <- subset(D, select=
c("ndssansp", "ndssdnsp", "ftnddnsp", "dnicnsp", "cigavgm" 	# Nicotine Dep
, "depndalc", "abusealc", "abodalc", "alcyrtot"			# Alcohol
, "depndmrj", "abodmrj", "mrdaypyr", "mrdaypmo", "mjyrtot"	# Marijuana

# continue here as much as you want#

))