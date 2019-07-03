Sys.setenv(http_proxy="http://10.85.4.54:8080", https_proxy="https://10.85.4.54:8080")

library(here)
library(companieshr)

x <- readRDS("~/Documents/companies_house_keys.rds")
key <- x[1,2]


x <- companies_house_collect(companies = "00445790", auth_api_key = key) 
z <- x$results_df


z1 <- CompanySearch("Tesco", mkey = key)
