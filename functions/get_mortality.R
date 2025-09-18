# Mortality function for Atlantic Sturgeon Model

# New Mortality function
load(here("data","2.2 fit.mortality.v2.Rdata"))

get.m.hypoxia <- function(POSAT,WT) {
  m_do <- data.frame(posat=POSAT,t=WT) %>% predict(fit.mortality,.) %>% exp()-0.001
  m_do[m_do<0] <- 0
  return(m_do)
}