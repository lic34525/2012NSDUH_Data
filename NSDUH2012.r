setwd("C:/Users/SUNMEE KIM/Downloads")
load("34933-0001-Data.rda")
D <- da34933.0001
library(prettyR)

#------------------------------
#
# (1) Covariates: 
#
# 		Age groups - AGE2 (Exclude ~17years old for JOB variable)
# 		Gender - IRSEX
# 		Marital status - IRMARIT
# 		Race - NEWRACE2
#
#		Reference table: http://dx.doi.org/10.1016/j.drugalcdep.2016.07.001
#
#------------------------------

#----------
# AGE
#----------
lbls <- names(table(D$AGE2))
lbls <- (sub("^\\([0-9]+\\) +(.+$)", "\\1", lbls))
D$Age <- as.numeric(sub("^\\(0*([0-9]+)\\).+$", "\\1", D$AGE2))
D$Age <- add.value.labels(D$Age, lbls)

# !! IMPORTANT:
# !! Respondents aged ~17 are removed (why? SES JOB and Y)
rmID <- which(D$Age <7)
D <- D[-rmID,]

# Age -> Numeric
D$Age <- D$Age + 11
D$Age[D$Age==22] <- 22.5
D$Age[D$Age==23] <- 24.5
D$Age[D$Age==24] <- 27.5
D$Age[D$Age==25] <- 32
D$Age[D$Age==26] <- 42
D$Age[D$Age==24] <- 57
D$Age[D$Age==28] <- 65

#----------
# New Ethnic Groups
#----------
newd <- subset(D, select=c("NDSSANSP","NEWRACE2"))

newd$ethnic1 <- NULL
newd$ethnic2 <- NULL

newd[newd$NEWRACE2 == levels(newd$NEWRACE2)[1], "ethnic1"] = levels(newd$NEWRACE2)[1]
newd[newd$NEWRACE2 == levels(newd$NEWRACE2)[7], "ethnic1"] = levels(newd$NEWRACE2)[7]
newd[is.na(newd$ethnic1) == TRUE,"ethnic1"] = "NonHisp All"
newd$ethnic1 <- as.factor(newd$ethnic1)
levels(newd$ethnic1) <- c("(1)NonHisp White","(2)Hispanic","(3)NonHisp All")

newd[newd$ethnic1 == levels(newd$ethnic1)[1], "ethnic2"] = levels(newd$ethnic1)[1]
newd[newd$ethnic1 == levels(newd$ethnic1)[2], "ethnic2"] = levels(newd$ethnic1)[2]
newd[newd$ethnic1 == levels(newd$ethnic1)[3], "ethnic2"] = levels(newd$ethnic1)[1]

D$Ethnic1 <- newd$ethnic1	#boxplot(data=D, NDSSANSP~Ethnic1)
D$Ethnic2 <- newd$ethnic2	#boxplot(data=D, NDSSANSP~Ethnic2)

#----------
# FINAL
#----------
Covar <- subset(D, select=c("AGE2","Age","IRSEX","IRMARIT","NEWRACE2","Ethnic1","Ethnic2"))

#------------------------------
#
# (2) Possible Dependent Var.: (codebook pp.321-322)
#
# 		1> Nicotine dependence
#		NDSSANSP (continuous): ave score over 17 questions pertaining to five aspects of dependence
#		NDSSDNSP (binary): NDSSANSP in binary format
#		DNICNSP (binary): NICOTINE DEPENDENCE IN PAST MONTH using NDSSDNSP and FTNDDNSP
#
# 		2> Alcohol dependence
#		DEPNDALC (binary): ALCOHOL DEPENDENCE IN THE PAST YEAR
#		ABUSEALC (binary): ALCOHOL ABUSE 
#		ABODALC (binary): ALCOHOL ABUSE (ABUSEALC=1) OR DEPENDENCE (DEPNDALC=1) - PAST YEAR
#		TXNEDALC (binary): needing treatment for alcohol use in the past year
#							DEPNDALC=1, ABUSEALC=1, or SPECTALC=1
#
# 		3> Alcohol Use
#		NODR30A (cont.): USUAL # OF DRINKS PER DAY PAST 30 DAYS (p.59), cor= 0.0278
#		DR5DAY (cont.): # DAYS HAD 5 OR MORE DRINKS PAST 30 DAYS, cor=0.0458
#		
#------------------------------

# table(x,y): x will be rows
table(D$DNICNSP, D$DEPNDALC)	# focusing on "dependence"
table(D$DNICNSP, D$ABODALC)		# focusing on "PAST YEAR"
table(D$DNICNSP, D$TXNEDALC)	# focusing on "PAST YEAR"

#----------
# Corr tests
#----------

# continuous:
id <- which(D$NODR30A<100)	#Remove outliers or missing values (see p.59)
ttt <- D[id,]
stats::cor.test(ttt$NDSSANSP,ttt$NODR30A,use="complete.obs",method = c("pearson"))
stats::cor.test(ttt$NDSSANSP,ttt$DR5DAY,use="complete.obs",method = c("pearson"))

# binary: cal. phi coeff btw two binary variables
xx <- D$TXNEDALC
yy <- D$DNICNSP
sqrt( chisq.test(table(xx,yy), correct=FALSE)$statistic/length(xx) )
chisq.test(table(xx,yy), correct=FALSE)

xxx <- as.numeric(D$DEPNDALC)
yyy <- as.numeric(D$DNICNSP)
cor(xxx,yyy) # just to double check

#------------------------------
#
# (3) Possible predictors:
#
#		1> First use history
#			ALCTRY: AGE WHEN FIRST DRANK ALCOHOLIC BEVERAGE (p.56)
#			CIGTRY: AGE WHEN FIRST SMOKED A CIGARETTE (p.38)
# 			IRCIGAGE: CIGARETTE AGE OF FIRST USE (IMPUTATION-REVISED version of CIGTRY)
#			IRCGRAGE: CIGAR AGE OF FIRST USE
#			IRALCAGE: ALCOHOL AGE OF FIRST USE (IMPUTATION-REVISED version of ALCTRY)
#
#		2> Mental illness: 
#			WSPDSC2: (p.849) the worst distress score during the past year, based on nonspecific psychological distress scale (K6)
#			WHODASC3: (p.852) daily functional impairment due to problems with emotions, nerves, or mental health
#			MHSUTK_U: Serious Thoughts of Suicide in the Past Year, Coded as 1 if "yes"; coded as 0 otherwise.
#			AMDEY2_U: Past Year MDE major depressive episode, Coded as 1 if the criteria were met
#
#		3> Health condition history: a doctor or other medical professional has ever told you that you had
#			LIFHBP Len: 2 EVER HAD HIGH BLOOD PRESSURE
#			LIFASMA Len: 2 EVER HAD ASTHMA
#			LIFBRONC Len: 2 EVER HAD BRONCHITIS
#			LIFPNEU Len: 2 EVER HAD PNEUMONIA
#			LIFSTDS Len: 2 EVER HAD SEXUALLY TRANSMITTED DISEASE
#			LIFDIAB Len: 2 EVER HAD DIABETES
#			LIFHARTD Len: 2 EVER HAD HEART DISEASE
#			LIFSINUS Len: 2 EVER HAD SINUSITIS
#			LIFSLPAP Len: 2 EVER HAD SLEEP APNEA
#			LIFULCER Len: 2 EVER HAD ULCER OR ULCERS
#
#		4> Socioeconomic status (SES)
#
#
#

Classify respondetns into one of the belows based on "2012 WHODAS SMI Prediction Model (Appendix E)"
any mental illness [AMI]
serious mental illness [SMI]
moderate mental illness [MMI]
serious or moderate mental illness [SMMI]
low [i.e., mild] mental illness [LMI]

# ----------------------------------

ERA.X1 <- subset(D, select=c("IRCIGAGE","IRALCAGE"))


# --------
# Health condition
# --------
lbls <- sort(levels(D$LIFHBP))
lbls <- (sub("^\\([0-9]+\\) +(.+$)", "\\1", lbls))
D$LIFHBP <- as.numeric(sub("^\\(0*([0-9]+)\\).+$", "\\1", D$LIFHBP))
D$LIFHBP <- add.value.labels(D$LIFHBP, lbls)

#----------
# X3 Socioeconomic status (SES)
#----------

# 1) Education (years) - IREDUC2
lbls <- names(table(D$IREDUC2))
lbls <- (sub("^\\([0-9]+\\) +(.+$)", "\\1", lbls))
D$IREDUC2.num <- as.numeric(sub("^\\(0*([0-9]+)\\).+$", "\\1", D$IREDUC2))
D$IREDUC2.num <- add.value.labels(D$IREDUC2.num, lbls)
D$IREDUC2.num <- D$IREDUC2.num + 4
#boxplot(data=D, NDSSANSP~IREDUC2)

# 2) Insurance - IRINSUR4 (1:having any health insurance, 0:No)
lbls <- sort(levels(D$IRINSUR4),decreasing = TRUE)
lbls <- (sub("^\\([0-9]+\\) +(.+$)", "\\1", lbls))
D$IRINSUR4.num <- as.numeric(sub("^\\(0*([0-9]+)\\).+$", "\\1", D$IRINSUR4))
D$IRINSUR4.num[D$IRINSUR4.num==2] <- 0
D$IRINSUR4.num <- add.value.labels(D$IRINSUR4.num, lbls)

# 3) Family Income - IRFAMIN3 (1~7)
lbls <- sort(levels(D$IRFAMIN3))
lbls <- (sub("^\\([0-9]+\\) +(.+$)", "\\1", lbls))
D$IRFAMIN3.num <- as.numeric(sub("^\\(0*([0-9]+)\\).+$", "\\1", D$IRFAMIN3))
D$IRFAMIN3.num <- add.value.labels(D$IRFAMIN3.num, lbls)
#boxplot(data=D, NDSSANSP~IRFAMIN3)

# 4) Occupation - EMPSTAT4 (1:Employed, 0:not)
lbls <- names(table(D$EMPSTAT4))
lbls <- (sub("^\\([0-9]+\\) +(.+$)", "\\1", lbls))
D$EMPSTAT4.num <- as.numeric(sub("^\\(0*([0-9]+)\\).+$", "\\1", D$EMPSTAT4))
D$EMPSTAT4.num <- add.value.labels(D$EMPSTAT4.num, lbls)
D$Emplyoed <- D$EMPSTAT4.num
D$Emplyoed[which(D$Emplyoed==3)] <- 0
D$Emplyoed[which(D$Emplyoed==4)] <- 0
D$Emplyoed[which(D$Emplyoed==2)] <- 1





