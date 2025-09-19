
# Data Sets

## 2.2 fit.mortality.vs.Rdata
This contains a model object relating minimum daily instantaneous mortality rate to percent oxygen saturation and water temperature.  The model object is used with the predict function in simulations to provide mortality estimates.

## 5. Chester_1961-2023.Rdata
This data file contains two data frames, both containing water quality data for the Delaware River at Chester. The data frame drChester contains the unmodified data frame obtained via the USGS NWIS data portal. The data frame drCHester_ctdo contains data after further processing. The following variables are included:

| Variable | Description |
| :--- | :--- |
| agency_cd | Agency providing the data (always USGS) |
| site_no | Site identifier (always 1477050) |
| spCond.mean | Daily mean specific conductivity, unfiltered, at 25 degrees C. (µS/cm) |
| wt.mean | Daily mean water temperature, degrees C |
| do.mgL.mean | Daily mean dissolved oxygen concentration, mg/L |
| date | Date YYYY-MM-DD as R date |

## 5.01 Delaware River at Penn Landing.Rdata
This data file contains two data frames, both containing water quality data for the Delaware River at Penn's Landing. The data frame drPenn contains the unmodified data frame obtained after reading the raw data file raw/PennsLandingDC (retrieved 2023-03-09).txt". The data frame drPenn_ctdo contains that data after further processing. The following variables are included:

| Variable | Description |
| :--- | :--- |
| agency_cd | Agency providing the data (always USGS) |
| site_no | Site identifier (always 1467200) |
| date | Date YYYY-MM-DD as R date |
| spCond.mean | Daily mean specific conductivity, unfiltered, at 25 degrees C. (µS/cm) |
| wt.mean | Daily mean water temperature, degrees C |
| do.mgL.mean | Daily mean dissolved oxygen concentration, mg/L |

## 5.0 DR_Chester_Summer_Complete.Rdata
This data file contains the data frame drc_summer, which includes a time series of water quality in the Delaware River at Chester from June 1 to November 30 in each year from 2002-2022 with no days missing.  Any missing values were imputed from the original data using linear interpolation.  The variables are:

| Variable | Description |
| :--- | :--- |
| doy | Day of year |
| spCond.mean | Daily mean specific conductivity, unfiltered, at 25 degrees C. (µS/cm) |
| wt.mean | Daily mean water temperature, degrees C |
| do.mgL.mean | Daily mean dissolved oxygen concentration, mg/L |
| year | Year that data is for |
| salinity.mean | Calculated daily mean salinity (unitless) |
| posat.mean | Calculated daily mean percent oxygen saturation |

## 5.01 DR_Penn_Penn_Landing_Summer_Complete 2002-2022.Rdata
This data file contains the data frame drpl_summer, which includes a time series of water quality in the Delaware River at Penn's Landing from June 1 to November 30 in each year from 2002-2022 except for 2010, with no days missing. Any missing values were imputed from the original data using linear interpolation. The variables are:

| Variable | Description |
| :--- | :--- |
| doy | Day of year |
| spCond.mean | Daily mean specific conductivity, unfiltered, at 25 degrees C. (µS/cm) |
| wt.mean | Daily mean water temperature, degrees C |
| do.mgL.mean | Daily mean dissolved oxygen concentration, mg/L |
| year | Year that data is for |
| salinity.mean | Calculated daily mean salinity (unitless) |
| posat.mean | Calculated daily mean percent oxygen saturation |

## 5.03 Chester Cohort Simulation 2002-2022.Rdata
This data file contains the data frame sim.Chester.Zmin which contains the results of the cohort model simulation for Chester for 2002-2022 using observed dissolved oxygen.  The variables are:

| Variable | Description |
| :--- | :--- |
| doy | Day of year |
| year | Year that data is for |
| abundance | simulated abundance (initial value is 10000) |
| weight | simulated fish weight (grams) |
| growth | simulated instantenous potential growth rate (per day) |
| mortality | simulated instantaneous minimum mortality rate (per day) |

## 5.04 Penns Landing Cohort Simulation 2002-2022.Rdata
This data file contains the data frame sim.Chester.Zmin which contains the results of the cohort model simulation for Chester for 2002-2022 (excluding 2010) using observed dissolved oxygen.  The variables are:

| Variable | Description |
| :--- | :--- |
| doy | Day of year |
| year | Year that data is for |
| abundance | simulated abundance (initial value is 10000) |
| weight | simulated fish weight (grams) |
| growth | simulated instantaneous potential growth rate (per day) |
| mortality | simulated instantaneous minimum mortality rate (per day) |


## 6.0 Estimates of Restored DO.Rdata
This file contains the data frame restoredWQ which includes a time series of water quality in the Delaware River at Chester and Penn's Landing from June 1 to November 30 in each year from 2002-2022 (excluding 2010) with no days missing. Dissolved oxygen and Percent oxygen saturation values are modeled value of the restored DO, while other values are observed values.

| Variable | Description |
| :--- | :--- |
| Site | Water quality monitoring site name |
| date | date as R date |
| doy | Day of year |
| year | Year that data is for |
| do.mean | Daily mean dissolved oxygen concentration, mg/L |
| wt.mean | Daily mean water temperature, degrees C |
| sal.mean | Calculated daily mean salinity (unitless) |
| posat.mean | Calculated daily mean percent oxygen saturation |

## 6.01 Simulated HSI using Restored DO.Rdata
This data file contains two data frames restoredWQ (which is the same as in data set 6.0) and restoredHSI which contains July 1 to Octover 31 average values from the cohort model simulation for Chester and Penn's Landing for 2002-2022 using restored dissolved oxygen values.  The variables are:

| Variable | Description |
| :--- | :--- |
| doy | Day of year |
| year | Year that data is for |
| mean.phi | Instantenous production potential (per day) |
| mean.growth | Mean simulated instantaneous potential growth rate (per day) |
| mean.Zmin | Mean simulated instantaneous minimum mortality rate (per day) |
| Site | Water quality monitoring site name |

## 6.02 DO and POSAT Percentiles.Rdata
This data file contains the data frame called percentiles that contains calculated 0.01, 0.1, 0.25 and 0.50 quantiles of dissolved oxygen (do) and percent oxygen saturation (posat) for the period from July 1 to October 31 in each year for the observed DO time series and the restored DO time series. The variables are defined as:

| Variable | Description |
| :--- | :--- |
| type | Observed or Restored |
| Site | Water quality monitoring site name |
| year | Year that data is for |
| do | quantiles of dissolved oxygen (mg/L) |
| posat | quantiles of percent oxygen saturation |
| percentiles | quantile identifier (0.01, 0.1, 0.25 or 0.50) |

## 6.03 Predicted PP and POSAT percentiles.Rdata
This data file contains the data frame q.predictions.POSAT that contains posat percentiles, predicted median instantaneous potential production resulting from quantile generalized additive model (QGAM) fits to data from 2002-2022 (excluding 2010) for both observed DO and restored DO, and associated standard errors of the estimated medians. QGAM models were fitted to 10th percentiles and median only. The variables are defined as:

| Variable | Description |
| :--- | :--- |
| posat | i quantile of percent oxygen saturation, where the quantile is defined in the variable percentile |
| pp.pred | predicted median potential production (per day) |
| se | standard error of estimated median potential production (per day) |
| percentile | quantile identifier (0.1 or 0.50) |
| type | Observed DO or Restored DO |

## 6.04 Predicted PP and DO percentiles.Rdata 
This data file contains the data frame q.predictions.DO that contains dissolved oxygen concentration (mg/L) percentiles, predicted median instantaneous potential production resulting from quantile generalized additive model (QGAM) fits to data from 2002-2022 (excluding 2010) for both observed DO and restored DO, and associated standard errors of the estimated medians. QGAM models were fitted to 10th percentiles and median only. The variables are defined as:

| Variable | Description |
| :--- | :--- |
| do | i quantile of dissolved oxygen concentration (mg/L), where the quantile is defined in the variable percentile |
| pp.pred | predicted median potential production (per day) |
| se | standard error of estimated median potential production (per day) |
| percentile | quantile identifier (0.1 or 0.50) |
| type | Observed DO or Restored DO |

## HADO_Results_at_Chester_and_Penn_Landing.Rdata
This data file contains the data frame HADO_WQ which contains daily average values of vertically-averaged (i.e., k-averaged) water quality predictions from DRBC's EFDC/WASP simulation model that were output at a 2-hour interval. Model outputs were created by DRBC on 2023-04-24 for the 2012 and 2019 simulations and on 2023-05-04 for the 2018 simulation.  Outputs were extracted for the IJ indices corresponding to the Chester and Penn's Landing monitoring sites as provided by DRBC in the file G7pt2_3D_lookUp_Tables.xlsx (tab USGS). The variables are defined as:

| Variable | Description |
| :--- | :--- |
| date | date and time as POSIXct |
| IJ | Model cell index |
| DO | daily average dissolved oxygen concentration (mg/L) |
| WT | daily average water temperature (degrees C) |
| SAL | daily average salinity (unitless) |
| Site | Site name |

## 7.08 NItrogen from HADO.Rdata  
This file includes a subset of 2019 EFDC/WASP simulation model results for ammonia nitrogen and nitrate plus nitrite.  The file contains vertically averaged data from the HADO scenario with actual wastewater flows.  The data are further subsetted to include only data from zones 2 and 3 of the Delaware River.

| Variable | Description |
| :--- | :--- |
| zone | Delaware River Zone ID  |
| J | EFDC grid along-channel grid index  |
| date | date |
| NH34 | daily average ammonia nitrogen (mg-N/L) |
| NO23 | daily average nitrate plus nitrite  (mg-N/L) |
| din | dissolved inorganic nitrogen = NH34 + NO23 (mg-N/L) |


