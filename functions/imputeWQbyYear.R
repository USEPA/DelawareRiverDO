
# Create a function to impute missing values for the data in one year
# required the input time series to exist as "ts_input"

# Create a function to impute missing values for the data in one year.
imputeByYear <- function(Year) {
  
  tmp <- ts_input %>% 
    filter(year==Year,between(yday(date),152,334)) %>% 
    mutate(doy=yday(date))
  
  # impute any missing values
  doy <- seq(152,334,by=1)
  spCond.mean <- approx(tmp$doy,tmp$spCond.mean,xout=doy) %>% .[[2]]
  wt.mean <- approx(tmp$doy,tmp$wt.mean,xout=doy) %>% .[[2]]
  do.mgL.mean <- approx(tmp$doy,tmp$do.mgL.mean,xout=doy) %>% .[[2]]
  tmp <- cbind(doy,spCond.mean,wt.mean,do.mgL.mean) %>% 
    data.frame() %>% 
    mutate(year=Year)
  
  # Calculate salinity 
  # USGS data is in microSiemans per centimeter
  tmp <- tmp %>% mutate(salinity.mean = ec2pss(ec=spCond.mean/1000,t=wt.mean,p = 0))
  
  # Calculate percent oxygen saturation.
  # If salinity is less than 1, use APHA method that does not use salinity. APHA
  # method is the standard for fresh water application.
  # If salinity is >=1, then use "Weiss" method, which considers salinity, and is 
  # the standard formula in marine sciences (Soetert and Petzoldt 2020).
  
  # Soetaert K, Petzoldt T (2020). _marelac: Tools for Aquatic Sciences_. R package
  # version 2.1.10, <https://CRAN.R-project.org/package=marelac>.
  tmp <- tmp %>% mutate(posat.mean=ifelse(
    salinity.mean<1,do.mgL.mean*100/gas_O2sat(t=wt.mean,method="APHA"),
    do.mgL.mean*100/gas_O2sat(S=salinity.mean,t=wt.mean,method="Weiss")
  ))
  return(tmp)
}
