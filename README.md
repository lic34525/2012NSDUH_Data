2012NSDUH_Data
====================================================

This repository contains a general description on the modified dataset based on data from [The 2012 National Survey on Drug Use and Health (NSDUH)](https://datafiles.samhsa.gov/study-dataset/national-survey-drug-use-and-health-2012-nsduh-2012-ds0001-nid13763) by United States Department of Health and Human Services, Substance Abuse and Mental Health Services Administration.

Author(s)
-------
-   **Sunmee Kim** <sunmee.kim@mail.mcgill.ca>

About the 2012 NSDUH 
----------
- Download the original data and codebook ("34933-0001-Codebook.pdf") here: [National Survey on Drug Use and Health, 2012 (ICPSR 34933)](https://www.icpsr.umich.edu/icpsrweb/NAHDAP/studies/34933#)
- From January through December 2012
- Interviewed residents aged 12 and older in American households.
- The respondents were asked to answer various questions concerning their use of substances (e.g., cigarettes, alcohol, illicit drugs, etc.), mental and physical health issues, and sociodemographic characteristics.

About the 'NSDUH_final.csv' file
====================================================

NOTE: Based on [the terms of use, redistribution of ICPSR data](https://www.icpsr.umich.edu/icpsrweb/content/datamanagement/policies/redistribute.html), the 'NSDUH_final.csv' file is currently deleted from this repository.
----------

- This modified dataset includes 37869 obs. of  39 variables
- If you are an R user, you may use the code: read.csv("NSDUH_final.csv", header = T, sep = ",", na.strings=c("NA"))

1. Covariates (moderators)
-------
- age, gender, marital status, race

2. Dependent variables
-------
- Nicotine (Cigarette) Dependence (See the codebook pp.826-):

  * NDSSANSP (continuous): ave. score over 17 questions of Nicotine Dependence Syndrome Scale (NDSS)
NDSSDNSP (binary): nicotine dependent (=1) or not; NDSSANSP in binary format; the NDSS score was less than 2.75 or missing, then the respondent was determined to be non-dependent (see p.827)
FTNDDNSP (binary): nicotine dependent (=1) or not; using Fagerstrom Test of Nicotine Dependence (FTND)
DNICNSP (binary): Using both the NDSS and the FTND, a respondent was defined as having nicotine (cigarette) dependence in the past month, if he or she met either the NDSS (NDSSDNSP=1) or FTND (FTNDDNSP=1) criteria for dependence.
CIGAVGM (continuous): # OF CIGARETTES SMOKED PER USER IN PAST MONTH
Alcohol
DEPNDALC (binary): alcohol dependent (=1) or not in the past year
ABUSEALC (binary): alcohol abuse (=1) or not in the past year
ABODALC (binary): alcohol abuse (ABUSEALC=1) OR dependence (DEPNDALC=1) - PAST YEAR
ALCAVGM (continuous): # OF ALC BEVS DRANK PER USER IN PAST MONTH
TOTDRINK (continuous): TOTAL # OF DAYS USED ALCOHOL IN PAST 12 MOS
Marijuana
DEPNDMRJ (binary): MARIJUANA DEPENDENCE IN THE PAST YEAR
ABODMRJ (binary): MARIJUANA ABUSE OR DEPENDENCE - PAST YEAR; “No/Unknown (ABUSEMRJ=0 and DEPNDMRJ=0)” “Yes (ABUSEMRJ=1 or DEPNDMRJ=1)”
MJYRAVE (continuous): # DAYS USED MARIJUANA/HASHISH PAST 12 MONTHS (On how many days in the past 12 months did you use marijuana or hashish?); more frequencies than MJMONAVE
MJMONAVE (continuous): # DAYS PER MOS USED MARIJUANA/HASHISH PAST 12 MOS (On average, how many days did you use marijuana or hashish each month during the past 12 months?)
TOTMJ(continuous): TOTAL # OF DAYS USED MARIJUANA IN PAST 12 MOS
3. Predictors
First use history
IRCIGAGE: CIGARETTE AGE OF FIRST USE (mean=15.81); IMPUTATION-REVISED version of CIGTRY, where CIGTRY: AGE WHEN FIRST SMOKED A CIGARETTE (p.38)
IRALCAGE: ALCOHOL AGE OF FIRST USE (mean=16.82); IMPUTATION-REVISED version of ALCTRY, where ALCTRY: AGE WHEN FIRST DRANK ALCOHOLIC BEVERAGE (p.56)
IRMJAGE: MARIJUANA AGE OF FIRST USE (mean=16.94); IMPUTATION-REVISED MARIJUANA AGE OF FIRST USE, where MJAGE: AGE WHEN FIRST USED MARIJUANA/HASHISH (p.60)
Mental illness
WSPDSC2: (p.849) the worst distress score during the past year, based on nonspecific psychological distress scale (K6)
WHODASC3: (p.852) daily functional impairment due to problems with emotions, nerves, or mental health
MHSUTK_U: Serious Thoughts of Suicide in the Past Year, Coded as 1 if “yes”; coded as 0 otherwise.
AMDEY2_U: Past Year MDE major depressive episode, Coded as 1 if the criteria were met
Health condition history: a doctor or other medical professional has ever told you that you had
LIFHBP: EVER HAD HIGH BLOOD PRESSURE; YES=1, NO=0
LIFASMA: EVER HAD ASTHMA
LIFBRONC: EVER HAD BRONCHITIS
LIFPNEU: EVER HAD PNEUMONIA
LIFSTDS: EVER HAD SEXUALLY TRANSMITTED DISEASE
LIFDIAB: EVER HAD DIABETES
LIFHARTD: EVER HAD HEART DISEASE
LIFSINUS: EVER HAD SINUSITIS
LIFSLPAP: EVER HAD SLEEP APNEA
LIFULCER: EVER HAD ULCER OR ULCERS
Socioeconomic status (SES)
IREDUC2.num: IMPUTATION REVISED EDUCATION; Fifth grade or less (=5), Sixth grade (=6), Seventh (=7), …
IRINSUR4: a respondent is classified as having any health insurance = 1 ; otherwise 0
IRFAMIN3.num: IMP.REVISED - family income; Less than $10,000 (=1), $10,000 - $19,999 (=2), $20,000 - $29,999 (=3), …
Emplyoed: IMPUTATION REVISED EMPLOYMENT STATUS 18+; 1 = Employed full or part time, 0 = Unemployed
