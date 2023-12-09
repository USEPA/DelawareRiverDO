
# Data Files
The comma-delimited text files in this folder contain data created as output by R scripts located in the /R folder.  The files are described below.

## 5.02 seasonal WQ stats.2012-2022.csv
This file contains estimates of the seasonal distribution of water quality variables in the seasons defined for the purposes of the dissolved oxygen rule calculated for the period 2012-2022 using the data obtained directly from USGS (i.e., no interpolation or other imputation)

| Parameter | Description |
| :--- | :--- |
| row number | not used |
| param | Water quality parameter (Salinity (unitless), Water Temperature (degrees C), Dissolved Oxygen (mg/L), Percent Oxygen Saturation (unitless)) |
| site | Site name (Chester or Penn's Landing) |
| min | seasonal minimum value |
| p.25 | the 25th percentile value |
| med | the median value |
| mean | the mean value |
| p.75 | the 75th percentiles value |
| max | the maximum value |

## 5.02 seasonal WQ stats.csv
This file contains estimates of the seasonal distribution of water quality variables in the seasons defined for the purposes of the dissolved oxygen rule calculated for the period 2002-2022 using the data obtained directly from USGS (i.e., no interpolation or other imputation)


| Parameter | Description |
| :--- | :--- |
| row number | not used |
| param | Water quality parameter (Salinity (unitless), Water Temperature (degrees C), Dissolved Oxygen (mg/L), Percent Oxygen Saturation (unitless)) |
| site | Site name (Chester or Penn's Landing) |
| min | seasonal minimum value |
| p.25 | the 25th percentile value |
| med | the median value |
| mean | the mean value |
| p.75 | the 75th percentiles value |
| max | the maximum value |

## 6.03 Predicted PP and POSAT percentiles.csv
This data file contains comma-separated values for posat percentiles, predicted median instantaneous potential production resulting from quantile generalized additive model (QGAM) fits to data from 2002-2022 (excluding 2010) for both observed DO and restored DO, and associated standard errors of the estimated medians. QGAM models were fitted to 10th percentiles and median only. The variables are defined as:

| Variable | Description |
| :--- | :--- |
| row number |   | 
| posat | i quantile of percent oxygen saturation, where the quantile is defined in the variable percentile |
| pp.pred | predicted median potential production (per day) |
| se | standard error of estimated median potential production (per day) |
| percentile | quantile identifier (0.1 or 0.50) |
| type | Observed DO or Restored DO |

## 6.04 Predicted PP and DO percentiles.Rdata 
This data file contains comma-separated values for dissolved oxygen (mg/L) percentiles, predicted median instantaneous potential production resulting from quantile generalized additive model (QGAM) fits to data from 2002-2022 (excluding 2010) for both observed DO and restored DO, and associated standard errors of the estimated medians. QGAM models were fitted to 10th percentiles and median only. The variables are defined as:

| Variable | Description |
| :--- | :--- |
| row number |   |
| do | i quantile of dissolved oxygen concentration (mg/L), where the quantile is defined in the variable percentile |
| pp.pred | predicted median potential production (per day) |
| se | standard error of estimated median potential production (per day) |
| percentile | quantile identifier (0.1 or 0.50) |
| type | Observed DO or Restored DO |

## 7.01 Seasonal Criteria Assessment Analysis.csv
This data file contains comma-separated values resulting from an analysis water quality observations from Chester and Penn's Landing to determine the degree of attainment of a 10th percentile criterion value of 66% and a criterion for the seasonal median of 74% oxygen saturation.  Note that this analysis was done to support the economic analysis and is not an assessment or the result of a recommended assessment methodology. The variables are defined as follows:

| Variable | Description |
| :--- | :--- |
| row number |    |
| site | Site name |
| assess_year | year of assessment | 
| season | Seasonal period (Overwinter, Spawning, or Growth) |
| n | number of water quality measurements |
| p.10 | 10th percentile of percent oxygen saturation |
| p.50 | Median percent oxygen saturation |
| days_lt_66 | Number of days that dissolved oxygen was less than 66% |
| days_lt_74 | Number of days that dissolved oxygen was less than 674% |
| attains.10 | Logical variable if the number of days with percent oxygen saturation  less than 66% is less than the allowed number of days |
| attains.50 | Logical variable if the number of days with percent oxygen saturation less than 74% is less than the allowed number of days, if applicable |
| attains | Logical variable indicating if both attains.10 and attains.50 are true |
 
