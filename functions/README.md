
# User-Defined Functions

The following R-scripts are included at <root>/functions and are used in the analysis workflow.

## Atlantic Sturgeon Growth Model Function v3 (2023-06-13).R

This R-script creates the user-defined R function as_growth_model3.

### Usage

as_growth_model3(TEMP=NULL,SAL=NULL,DO=NULL,GR=NULL,output=c("Growth","Energy Balance","Energy Content","Routine Metabolism","Food Consumption","Egestion Ratio","Excretion", and "Postprandial Metabolism"))

### Arguments

| Parameter | Description |
| :---   |    :---                                                      |          
|TEMP    | water temperature in °C                                      |
|SAL     | salinity (dimensionless)                                     |
|DO      | percent oxygen saturation (dimensionless)                    |
|GR      | fish weight in grams                                         |
|output  | output to be returned.  Growth rate (per day) is the default.|

### Details

This is the bioenergetics model from Niklitschek and Secor (2009), adapted from code provided by the authors.

### References

Niklitschek, E. J. and D. H. Secor (2009). "Dissolved oxygen, temperature and salinity effects on the ecophysiology and survival of juvenile Atlantic sturgeon in estuarine waters: II. Model development and testing." Journal of Experimental Marine Biology and Ecology 381: S161-S172. https://doi.org/10.1016/j.jembe.2009.07.019

## get_mortality.R

This R-script loads the data file "2.2 fit.mortality.v2.Rdata" be loaded, creating a model object called fit.mortality, and creates a function that uses the model object and returns an estimate of daily instantanous mortality caused by low oxygen as function of percent oxygen saturation and water temperature.

### Usage

get.m.hypoxia(POSAT=NULL, wt=NULL)

### Arguments

| Parameter | Description |
| :---   |    :--- |          
|TEMP    | water temperature in °C | 
|POSAT   |  percent oxygen saturation (dimensionless) |

### Details

This function implements the predict function to predict a log-transformed and recoded estimate of instantaneous daily mortality. The function back-transforms the estimate via the exp() function and subtracts the small constant that was added to accommodate zero-mortality in a log-transformed model. In the unlikely case that this results in a negative morality rate, the returned rate is set to zero.  The function returns the estimate daily instantaneous mortality rate due to the interaction between water temperature and low oxygen (Zmin).  The concept of Zmin was first described by Niklitschek and Secor (2005).

### References

Niklitschek, E. J. and D. H. Secor (2005). "Modeling spatial and temporal variation of suitable nursery habitats for Atlantic sturgeon in the Chesapeake Bay." Estuarine, Coastal and Shelf Science 64(1): 135-148. http://doi.org/10.1016/j.ecss.2005.02.012

## imputeWQbyYear.R

This script takes a daily time series of water quality and uses linear interpolation to impute salinity, dissolved oxygen, and water temperature for any values that are missing during the period from June 1 to November 30 in a single year. The function requires that a data frame called ts_input be present in the Global Environment. The data frame ts_input must contain at a minimum the following variables:

| Variable | Description |
| :--- | :--- |
| date | sampling date |
| spCond.mean | Specific conductivity at 24 degrees (µS/cm) |
| wt.mean | Water temperature (degrees C) | 
| do.mgL.mean | Dissolved oxygen concentration (mg/L) |

The function returns a data frame containing the following variables:

| Variable | Description |
| :--- | :--- |
| doy | sampling day of year |
| spCond.mean | Specific conductivity at 24 degrees (µS/cm) |
| wt.mean | Water temperature (degrees C) | 
| do.mgL.mean | Dissolved oxygen concentration (mg/L) |
| year | sampling year |
| salinity.mean | Salinty (unitless) |
| posat.mean | Percent oxygen saturation (unitless) |

The function uses the ec2pss function in the wql package to compute salinity from specific conductivity and the gas_O2sat function to compute percent oxygen saturation.  If salinity is less than 1, the function uses APHA method for computing oxygen solubility while the Weiss method is used for higher salinity.  For further information, see documentation for the gas_O2sat function.






### Usage

imputeWQbyYear(year)




