

# Description of R Code at /R

These R-markdown files provide the core workflow for the analysis of water quality effects on juvenile Atlantic Sturgeon leading to development of dissolved oxygen criteria values as outlines in EPA's document "Technical Support Document for the Final Rule: Water Quality Standards to Protect Aquatic Life in the Delaware River" (or "TSD").  The R-markdown files utilize user-defined R-functions that are created by R-scripts included in the repository at <root>/functions. A REAMDME file at <root>/functions describes the functions.

All programs are located in the sub-directory /R within the repository.

## R Packages

The code was run using R version R version 4.4.2 (2024-10-31 ucrt) "Pile of Leaves"  implemented in R Studio (2024.12.0 Build 467) running in Microsoft Windows 11 Enterprise (Version 10.0.22631 Build 22631) on a Dell Latitude 5340.

The code used the following R-packages.

|Package | Version | Used for |
| :--- | :---: | :---  |
| knitr | 1.50 | Processing R-markdown    |
| tidyverse | 2.0.0 | Data processing and graphing   |
| gt | 1.0.0  | Making tables    |
| lubridate | 1.9.4  | Processing dates  |
| wesanderson | 0.3.7  | Color palettes    |
| viridis | 0.6.5  |  Color palettes   |
| marelac | 2.1.11  | Gas solubility functions   |
| wql | 1.0.3 | Calculating salinity from conductivity   |
| qgam | 2.0.0  | Fitting quantile generalized additive models    |
| mgcv | 1.9-1  | Fitting generalized additive models |
| gratia |0.11.1  |Evaluating generalized additive models |
| modelr | 0.1.11  |Evaluating generalized additive models |
| EGRET | 3.0.11 | Obtaining water quality data from USGS data portal    |
| lmodel2 | 1.7-4 | Fitting Model II regressions  |
| here | 1.0.1 | Ensuring accurate paths to files |

## List of Programs (R Markdown)

### 2.2 Evaluate Mortality Models
This program illustrates why the survival model included in Niklitschek and Secor (2005) is a poor fit to the data and develops an alternative. The alternative survival model, which is a log-linear regression model is saved as a model object in an R data set (data/2.2 fit.mortality.v2.Rdata) that is used in programs 5.03 and 5.04 to obtain a value for minimum instantaneous mortality rate (Zmin) given POSAT and water temperature.

This program generates Figure 3 in the TSD.  Statistical details from this program are included as Figure A5-1 in the TSD.

### 5. Assimilate Chester WQ Time Series Data.Rmd
This program obtains the water quality time series data for Chester, PA from the USGS NWIS web page.  The data are plotted to faciliate evaluation of the data (eg. reasonableness), including ensuring that the data were read correctly and are in expected units. Linear interpolation is used to impute values where short periods of data may be missing.  The product is referred to as the "complete" time series because it does not contain any missing daily values, as required by the cohort model.  The program saves the resulting data as a .Rdata file. 

This program generates Figure A1-1 in the TSD.

### 5.01 Assimilate Penn Landing WQ Time Series Data.Rmd
This program reads a text file containing water quality data for the Delaware River at Penn's Landing.  The data were downloaded as .txt from the USGS NWIS web site. The data for Penn's Landing are somewhat different than for Chester in that USGS used a different variable for DO measurements at different locations, thus making the data pull more complex.  Therefore, a text file was saved. The program merges data from two different locations near Penn's Landing into a single time series and evaluates the merge graphically.  Data are evaluated using summary() to ensure that the values are as expected and frequency histograms show the number of data points in each month. Linear interpolation is used, following the same approach as for Chester data, to impute values where short periods of data are missing.  Imputation is not done for 2010, we believe has too much missing data during the summer to support a reliable simulation of the summer period using the cohort model.

This program generates Figure A1-2 in the TSD.

### 5.03 Simulate Cohort for Chester.Rmd
This program simulates the juvenile Atlantic Sturgeon cohort for each year in the Chester data set. Functions are loaded from .R files in the /functions folder including the bioenergetics model and the getMortality. The program transposes the data into an array with one column for each date and one row for each year to be simulated.  The imputed data start on June 1 (day 152). The simulation runs from July 1 to December 1, although most analysis only consider the period ending October 31.

The growth rate is determined at each time step using as_growth_model3, which requires water temperature (TEMP), posat (DO), salinity (SAL) and fish weight (GR).  Daily instantaneous minimum mortality is obtained from the empirical model (developed in program 2.2) by calling the function get.m.hypoxia(). At each time step, the weight and abundance in the subsequent time step is computed, while groth and mortality in the current time step is recorded.  If weight falls to less than the initial weight, it is maintained at the initial weight to prevent the growth model from failing and causing the simulation to crash.   

The size of fish on each date is compared with data on fish sized obtained from Ian Park (DNREC). This program generates Figure 6 in the TSD. 

The output file "5.03 Chester Cohort Simulation 2002-2022.Rdata" is saved in the data folder and used in later steps of the analysis.

### 5.04 Simulate Cohort for Penns Landing.Rmd
This program follows a parallel workflow to program 5.03, but using data from Penn's Landing.  

The output file "5.04 Penns Landing Cohort Simulation 2002-2022.Rdata" is created in the data folder.

### 6.0 Predict Restored DO Time Series
Jake Bransky (DRBC) developed an approach to predict an extended time series of restored DO based given simulations of the restored DO condition for only 3 years. This program follows a similar approach to estimate a restored DO time series at Chester and Penn's Landing for each year from 2002-2022.

This analysis requires data from Environmental Fluid Dynamics Code / Water Analysis Simulation Program (EFDC/WASP) simulations developed by DRBC.  The "Highest Attainable Dissolved Oxygen" scenarios simulate DO values that in this analysis we call "Restored DO." Because the full EFDC/WASP model results create large files, this program begins with a subset of data extracted from those results.  These include vertically averaged model simulation results at cell 31_116, which is the approximate location of the Chester water monitoring station, and cell 31_155, which is the approximate location the Penn's Landing water quality monitoring station.  The simulation model results were for latest (most updated) simulations available at the time the data was obtained.

This analysis uses a Generalized Additive Model (GAM) to models the restored DO condition as a smooth function of the observed condition.  The smooth function has a maximum of 3 knots (i.e., a "stiff smooth") so that the model does not over-fit the data while allowing the restored DO values to have a non-linear relationship with observed DO. A smooth non-linear effect of discharge from the Delaware River monitored at Trenton River, on the theory that the relationship between observed and restored DO may vary in relation to river discharge. 

The restored DO time series is saved as "data/6.0 Estimates of Restored DO.Rdata" and used in later steps of the analysis.

This program generates components of Figure A2-1 in the TSD (the final figure was produced in Adobe Illustrator).  Statistical details from this program are reported in Figure A2-2 and Figure A2-3 of the TSD.

### 6.01 Simulate Cohorts using Restored DO.Rmd
This program simulates cohort growth and survival given the modeled restored DO time series, which is loaded from "data/6.0 Estimates of Restored DO.Rdata".  The simulations run from July 1 to October 31.  A function is created to implement the simulations, then the function is uses for data from both Chester and Penn's Landing. Seasonal average potential growth rate, minimum mortality rate and daily instantaneous potential production (IPP) denoted by phi, are computed for each year. Habitat Suitability Index (HSI) is defined as =IPP. The program generates graphs of HSI for restored DO in each year at both sites.

The results are stored as data frames "restoredWQ" and "restoredHSI" in "data/6.01 Simulated HSI using Restored DO.Rdata." which is used in later steps of the analysis.

### 6.02 Calculate DO Percentiles for Observed and Restored DO.Rmd
This program combines the imputed complete time series of water quality observations at Chester and Penn's Landing and the identical data for restored DO time series and computes quantiles for POSAT and DO (mg/L) for the data from July 1 (doy=182) to October 31 (doy=304). A function is created to compute the percentiles by Site and type (Observed or Restored) for a given percentile, then the function is applied for vector of percentiles.  

The results are stored in program "data/6.02 DO and POSAT Percentiles.Rdata" and are used in later steps of the analysis.

### 6.03 Fit QGAMs Relating HSI to POSAT Percentiles.Rmd
This program loads the simulation results for observed DO values from programs 5.03 and 5.04 and calculates HSI for each year at each site. HSI values for restored DO are loaded from program 6.01. Percentiles for POSAT and DO (mg/L) are loaded from program 6.02.  The HSI values and percentiles are joined by type (observed vs. restored), site (Chester or Penn's Landing) and year (2002-2022, excluding 2010).  A function is created to fit a quantile generalized additive model (QGAM) using the qgam function from the qgam package.  The model pools data across "site", but fits separately for each percentile that is modeled (0.1 or 0.5) by type.  If type "Combined" is specified, a model is fitted using observed and restored data together.  Statistical output and diagnostics are presented for the QGAM models and the model fit is graphed with the original observations.

For each percentile, the program predicts the expected median HSI and associated standard errors of the median for every value of POSAT from the lowest to the highest and calculates the lowest value of each POSAT percentile (10th or 50th) that has HSI>0.  The program also considers the range of uncertainty for the predicted median HSI and calculates the POSAT percentile values associated with the mean-se being >0 (resulting in upper limit for POSAT with HSI>0) and the mean+si (resulting in a lower limit for POSAT with HSI>0). 

This program generates Figure 8 and Figure 9 in the TSD and the threshold values reported in Table 3.

### 6.04 Fit QGAMs Relating HSI to DO Percentiles.Rmd
This program follows the identical workflow for program 6.03, but uses DO (mg/L) instead of POSAT.  

This program generates Figure A7-1 and Figure A7-2 in the TSD and the threshold values reported in Table 5.

### 7.01 Evaluate Seasonal Attainment
These calculations are used in the economic analysis to determine whether additional waste water treatment plant controls are needed to attain EPA’s proposed criteria in each of the three seasons.

### 7.02 Compare Simulated Abundance with CPUE.Rmd
This program graphs simulated relative abundance on October 31 vs. CPUE measured in juvenile abundance surveys on the Delaware River and fits Model II regressions to quantify the functional relationship between the two variables.  

This program creates Figure 4 in the TSD.

### 7.03 Make bar graphs of HSI in Existing and Restored.Rmd
This program creates bar graphs showing modeled HSI and biomass change at each site under the existing DO and restored DO scenario.  

This program creates a PDF file that was modified with additional labels in Adobe Illustrator to make figure 7 in the TSD.

