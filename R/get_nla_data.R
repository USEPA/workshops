library(readr)
library(dplyr)
library(lubridate)

nla_2007_site_url <- "https://www.epa.gov/sites/production/files/2014-01/nla2007_sampledlakeinformation_20091113.csv"
nla_2007_wc_url <- "https://www.epa.gov/sites/production/files/2014-10/nla2007_chemical_conditionestimates_20091123.csv"
nla_2007_secchi_url <- "https://www.epa.gov/sites/production/files/2014-10/nla2007_secchi_20091008.csv"

nla_2012_site_url <- "https://www.epa.gov/sites/production/files/2016-12/nla2012_wide_siteinfo_08232016.csv"
nla_2012_key_var_url <- "https://www.epa.gov/sites/production/files/2017-02/nla12_keyvariables_data.csv"
nla_2012_secchi_url <- "https://www.epa.gov/sites/production/files/2016-12/nla2012_secchi_08232016.csv"

nla_2007_site <- read_csv(nla_2007_site_url)
nla_2007_wc <- read_csv(nla_2007_wc_url)
nla_2007_secchi <- read_csv(nla_2007_secchi_url)
  
nla_2012_site <- read_csv(nla_2012_site_url)
nla_2012_key_var <- read_csv(nla_2012_key_var_url)
nla_2012_secchi <- read_csv(nla_2012_secchi_url)

nla_2007 <- nla_2007_site %>%
  left_join(nla_2007_wc, by = c("SITE_ID", "VISIT_NO", "LON_DD", "LAT_DD", "ST")) %>%
  left_join(nla_2007_secchi, by = c("SITE_ID", "VISIT_NO")) %>%
  rename_all(tolower) %>%
  select(site_id, visit_no, date_col, lon_dd, lat_dd, st, cntyname, ptl,
         ntl, chla, secchi = secmean) %>%
  filter(!is.na(chla)) %>%
  mutate(date_col = mdy(date_col))
  
write_csv(nla_2007, "data/nla_2007.csv")

nla_2012 <- nla_2012_site %>%
  left_join(nla_2012_key_var, by = c("SITE_ID", "VISIT_NO")) %>%
  left_join(nla_2012_secchi, by = c("SITE_ID", "VISIT_NO", "DATE_COL")) %>%
  rename_all(tolower) %>%
  select(site_id, visit_no, date_col,lon_dd = lon_dd83, lat_dd = lat_dd83, 
         state, cntyname, ptl = ptl_result, ntl = ntl_result, 
         chla = chlx_result, secchi) %>%
  filter(!is.na(chla)) %>%
  mutate(date_col = mdy(date_col))

write_csv(nla_2012, "data/nla_2012.csv")
