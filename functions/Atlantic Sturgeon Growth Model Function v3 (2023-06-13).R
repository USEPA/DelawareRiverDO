
#  	ATLANTIC STURGEON BIOENERGETIC MODEL
##
# 	REFERENCE: Niklitschek E.J. & Secor D.H. 2009. Dissolved oxygen, temperature and salinity effects on the ecophysiology and survival 
# 			of juvenile Atlantic sturgeon in estuarine waters: II. Model development and testing. Journal of Experimental Marine Biology 
# 			and Ecology 381: S161-S172.
# 	SCRIPT : 20110803
# 	LAST UPDATE: 20140702
#   Programmer: Edwin Niklitschek; edwin.niklitschek@ulagos.cl
#
#   Code edited by J. Hagy, hagy.jim@epa.gov
#   Last Updated 2023-10-03
#   Version 3
#

as_growth_model3 <- function(TEMP,SAL,DO,GR,output="Growth",parmSet=0) {

# DEFINING FISH WEIGHT AND OBSERVED CONSUMPTION

#Fish weight is passed to the function as GR
#Fish total length is calculated using a regression model

# Total Length
CJ_OBS <- 0   # IF YOU DECLARE THIS VARIABLE EQUAL TO 0, THE MODEL ASSUMES MAXIMUM CONSUMPTION RATE (CMAX) 
RATION <- 1 # IF YOU DECLARE THIS VARIABLE EQUAL TO 1, THE MODEL ASSUMES p-value=1

#----------------------------------------------------------------------	
# BIOENERGETICS PARAMETERS
#----------------------------------------------------------------------

## ROUTINE METABOLISM

## ROUTINE METABOLISM  -- from Original Code
# arm  <-  0.522    # Allometric intercept (scaling coefficient)
# brm  <-  -0.17    # Allometric slope
# tk1rm  <-  0.141  # Reaction rate multiplier at the lowest tested temperature (6°C)
# tk4rm  <-  0.796  # this is not defined in Table S1
# crm  <-  1.0      # Dissolved oxygen response shape parameter 
# drm  <-  1.048    # Proportionality constant for reaction rate at lowest DOSAT (listed as 0.75 +/ 0.097 in Suppl. Info)
# grm  <-  0.748    # Proportionality constant for DOCRM (listed as 0.27 in Suppl. Info) 
# hrm  <-  0.268    # Hyper-osmotic response coefficient (listed as 0.4 in Suppl. Info)
# irm  <-  0.352    # Hypo-osmotic response coefficient (Listed as 9+/3.2 in Suppl. Info)
# smin  <-  9.166   # Salinity at which minimum osmoregulation cost is predicted (Listed as 0.52 in Suppl. Info)

# Parameters from search algorithm
arm  <-  0.5002514    # Allometric intercept (scaling coefficient)
brm  <-  -0.1592636    # Allometric slope
tk1rm  <-  0.1402602  # Reaction rate multiplier at the lowest tested temperature (6°C)
tk4rm  <-  0.8735251  # this is not defined in Table S1
crm  <-  1.00478      # Dissolved oxygen response shape parameter 
drm  <-  0.9910955    # Proportionality constant for reaction rate at lowest DOSAT (listed as 0.75 +/ 0.097 in Suppl. Info)
grm  <-  0.6    # This value was constrained to be "compatible" with FC parameters, leading to appropriate shape in growth response
hrm  <-  0.268    # Not varied because data set had only 1 salinity
irm  <-  0.352    # Not varied because data set had only 1 salinity
smin  <-  9.166   # Not varied because data set had only 1 salinity

# GSA <- -0.17       # Specific gill surface area listed in Table S1

## FOOD CONSUMPTION
jfc <- 0.359
kfc <- 0.247
# Parameters from search algorithm
#afc <- 1.275562 
bfc <- -0.212965
tk1fc <- 0.1189157
tk4fc <- 0.2426624
tl98fc <- 25.48278 
cfc <- 1.150659
dfc <- 3.139969
#gfc <- 0.6371692  

afc <- 1.275562*0.95  # reduce food consumption by 5% to balance growth
gfc <- 0.6  # should be similar to grm to avoid strange shaped curves

## EGESTION
geg <- 0      # ration size effect exponent
# parameters from search algorithm
aeg <- 0.2937 # scale parameter for egestion
ceg <- -0.733167 # dissolved oxygen effect exponent
deg <- -0.4842387 # temperature effect exponent

## EXCRETION
aex <- 0.055703 *1.5
bex <- -0.29
cex <- 0.0392 *1.5

## SDA
asda <- 0.1657

## AM
aact <- 0.29

## Constants
S4 <- 29  # S4 was missing in later equations, assumed lower case s was an error
S1 <- 1   # S1 was missing in later equations, assumed lower case s was an error

do1 <- 25

#----------------------------------------------------------------------
# PARAMETER VARIATIONS  - used only for optimization
#----------------------------------------------------------------------

if (parmSet>0) {
    print("Optimization not supported in Version 3. Default parameters will be used.")
}

#----------------------------------------------------------------------
# MODELING
#----------------------------------------------------------------------

#----------------------------------------------------------------------  
# RM MODEL (Routine Metabolism)
#----------------------------------------------------------------------  

## RM Model Constants
rt1 <- 6
rt4 <- 28
s4 <- 29
s1 <- 1
do1 <- 25
b1 <- -0.158  # allometric exponent for gill surface area
ox <- 13.55 # oxycalorific coefficient 

## FT
y1 <- (1/(rt4-rt1))*log(tk4rm*(1-tk1rm)/(tk1rm*(1-tk4rm)))
ey1 <- exp(y1*(TEMP-rt1))
FTrm <- tk1rm*ey1/(1+tk1rm*(ey1-1))

## FS
FSArm <- 1 + 0.01*exp(hrm*(GR^b1)*(SAL-smin))  # responds to hyper-osmotic conditions and increases with salinity.
FSBrm <- 1 + 0.01*exp(irm*(GR^b1)*(smin-SAL))  # responds to hypo-osmotic conditions and decrases with salinity.
FSrm <- FSArm*FSBrm/1.0201  # product reflects interaction between two exponential curves 

## FO
#DOCrm <- 100*(1-crm*exp(-FTrm*FSrm)) # in supplemental information, this is listed as grm, not crm
DOCrm <- 100*(1-grm*exp(-FTrm*FSrm))
KO1rm <- 1-drm*exp(FTrm*FSrm-1)
dorel <- (DOCrm-DO)/100
SLrm <- (.98-KO1rm)/((.02*(DOCrm-do1))^crm)
FOrm <- ifelse(dorel>0,(0.98-SLrm*dorel^crm)/0.98,1)  

KRM=FOrm*FSrm*FTrm
# Calculation of routine metabolism depends on fish size in grams (GR)
# so substitute actual size here when running the model
RM=GR*(arm*GR^brm)*KRM*24*ox/1000  

#----------------------------------------------------------------------  
# FC MODEL (Food Consumption)
#----------------------------------------------------------------------  

## FC model constants		
ct1 <- 6
ct4 <- 29

## FT
cy1 <- (1/(tl98fc-ct1))*log(0.98*(1-tk1fc)/(0.02*tk1fc))    #Ya
ecy1 <- exp(cy1*(TEMP-ct1))
cka <- tk1fc*ecy1/(1+tk1fc*(ecy1-1))  # Ka

cy2 <- (1/(ct4-tl98fc))*log(0.98*(1-tk4fc)/(0.02*tk4fc))  # Yb
ecy2 <- exp(cy2*(ct4-TEMP))
ckb <- tk4fc*ecy2/(1+tk4fc*(ecy2-1))

FTfc <- cka*ckb 

## FS
CKS1 <- jfc*GR^-b1
# CKS1 approaches 1 as GR increases to large values.  But, it becomes >1
# and when CKS1 is >=1, then YA is a NaN.  So, here we set it to 0.99
# at large values of GR  
CKS1[CKS1>=1] <- 0.99
CKS4 <- kfc*GR^-b1

YA <- (1/(smin-S1))*log(0.98*(1-CKS1)/(CKS1*0.02))
EYA <- exp(YA*(SAL-S1))
KSA <- CKS1*EYA/(1+CKS1*(EYA-1))   # Response to hyper-osmotic conditions, decreases with salinity

YB <- (1/(S4-smin))*log(0.98*(1-CKS4)/(CKS4*0.02))
EYB <- exp(YB*(S4-SAL))
KSB <- CKS4*EYB/(1+CKS4*(EYB-1))  # Response to hypo-osmostic conditions, increases with salinity
FSfc <- (KSA*KSB)/(1) 

## FO
DOCfc <- 100*(1-gfc*exp(-KRM))
KO1fc <- 1-dfc*exp(KRM-1)
dorel <- (DOCfc-DO)/100
SLfc <- (.98-KO1fc)/((0.02*(DOCfc-do1))^cfc)
FOfc <- ifelse(dorel>0,(0.98-SLfc*dorel^cfc)/0.98,1) 

CJG_MAX <- (afc*GR^bfc)*FTfc*FSfc*FOfc
CJ_MAX <- GR*CJG_MAX
CJG_PRED <- RATION*CJG_MAX
CJ_PRED <- CJG_PRED*GR  # predicted consumption in kJ/d

if (CJ_OBS==0) {
  CJ=CJ_PRED
} else { CJ=CJ_OBS }

#----------------------------------------------------------------------  
# EGESTION MODEL
#----------------------------------------------------------------------  

E <- aeg*(TEMP/6)^ceg*(DO/DOCrm)^deg*RATION^geg 
EG <- E*CJ

#----------------------------------------------------------------------  
# EXCRETION MODEL
#----------------------------------------------------------------------  

# Depends on fish size
#EX <- aex*GR^bex*RM+cex*CJ
EX <- aex*RM^bex+cex*CJ

#----------------------------------------------------------------------  
# SDA MODEL (Postprandial Metabolism)
#----------------------------------------------------------------------  

SDA <- (CJ-EG)*asda

#----------------------------------------------------------------------  	
# ACTIVE METABOLISM 
#----------------------------------------------------------------------  

AM <- CJ_MAX*aact 

#----------------------------------------------------------------------  
# ENERGY CONTENT
#----------------------------------------------------------------------  

# Depends on fish size
#TL <- ifelse(is.na(TL),exp((log(GR)+6.1488)/3.113),TL)
# could replace this with a function from Ian Park data ...
# or check it against it
TL <- exp((log(GR)+6.1488)/3.113)
LNL <- log(TL)
WS <- TL/exp((log(GR)+6.1488)/3.113) # should be equal to 1 in this model
ENEC <- exp(-1.0065+1.0336*log(WS)+0.6807*LNL)

#----------------------------------------------------------------------  
# GROWTH
#----------------------------------------------------------------------  

GKJ_PRED <- CJ-RM-EG-SDA-EX-AM
G_PRED <- log((GR+GKJ_PRED/ENEC)/GR)

#----------------------------------------------------------------------  

# Set predicted growth to zero if fish weight is zero
G_PRED[GR==0] <- 0

# SEND OUTPUT

if (output=="Growth") {
  return(G_PRED) 
} else if (output=="Energy Balance") {
  return(GKJ_PRED)
} else if (output=="Energy Content") {
  return(ENEC)
} else if (output=="Routine Metabolism") {
  return(RM/GR)
} else if (output=="Food Consumption") {
  return(CJ/GR)
} else if (output=="Egestion Ratio") {
  return(E)
} else if (output=="Excretion") {
  return(EX/GR)
} else if (output=="Postprandial Metabolism") {
  return(SDA/GR)
} else {
  print("Invalid Output Specified.  Valid outputs include Growth,\n
         Energy Balance, Energy Content,Routine Metabolism,\n
         Food Consumption, Egestion Ratio, Excretion,and\n
         Postprandial Metabolism ")
  return(NULL)
}

# END OF FUNCTION
}
