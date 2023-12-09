# Raw Data

This folder contains raw data that was imported from text files for use in the analysis.  Additional data from EFDC/WASP simulation models was obtained from the Delaware River Basin Commission as text files, however these datafiles are too large to be included at github. Additionally, only data for 2 model cells was needed for the analysis.  Therefore, these data are stored as an R data file (in the data folder).  Water quality data from Chester was obtained via a web-services call to the USGS NWIS data portal.  The resulting data frame, is stored without modification as an R data file in the data folder. Data with a small number of observations, such as estimates of sturgeon mortality rates obtained from scientific literature, are embedded in R code using c().  The files here are described below:

## Annual Fish Survey data.xlsx
This Microsoft Excel workbook contains the juvenile Abundance Survey Data as provided to EPA by Jake Bransky (DRBC).

## create_yoy_survey_data.R
This R code file creates a data frame containing catch-per-unit effort data from juvenile abundance surveys conduced by the state of Delaware and provided by Ian Pak (DNREC) and Jake Bransky (DRBC).  The data are extracted from the workbook Annual Fish Survey data.xlsx.  The code produces a data frame called yoy.survey containing variables defined below:

| Variable | Description |
| :--- | :---|
| year | sampling year |
| yoy.cpue.100 | Catch per unit effort of young-of-the-year juvenile Atlantic Sturgeon multiplied by 1000 |
| yoy.marcus.hook.1000 | Catch per unit effort of young-of-the-year juvenile Atlantic Sturgeon near Marcus Hook multiplied by 1000 |

## PennsLandingDV (retrieved 2023-03-09.txt)
This file contains the raw data obtained from the USGS NWIS data portal and saved as .txt.  The file contains USGS's original self-documenting file header.
