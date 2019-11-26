library(readr)
library(dplyr)
library(httr)

nla_2007_site_url <- "https://www.epa.gov/sites/production/files/2014-01/nla2007_sampledlakeinformation_20091113.csv"
nla_2007_wc_url <- "https://www.epa.gov/sites/production/files/2014-10/nla2007_chemical_conditionestimates_20091123.csv"
nla_2007_secchi_url <- "https://www.epa.gov/sites/production/files/2014-10/nla2007_secchi_20091008.csv"

nla_2012_site_url <- "https://www.epa.gov/sites/production/files/2016-12/nla2012_wide_siteinfo_08232016.csv"
nla_2012_key_var_url <- "https://www.epa.gov/sites/production/files/2017-02/nla12_keyvariables_data.csv"
nla_2012_secchi_url <- "https://www.epa.gov/sites/production/files/2016-12/nla2012_secchi_08232016.csv"

nla_2007_site <- read_csv(nla_2007_site_url)
nla_2007_wc <- read_csv(nla_2007_wc_url)
nla_2007_secchi <- read_csv(nla_2007_secchi_url)
  
nla_2012_site <- read_csv()
nla_2012_key_var <- read_csv()
nla_2012_secchi <- read_csv()