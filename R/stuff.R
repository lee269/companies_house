Sys.setenv(http_proxy="http://10.85.4.54:8080", https_proxy="https://10.85.4.54:8080")

library(here)
library(companieshr)
library(CompaniesHouse)
library(purrr)

x <- readRDS(here("keys", "companies_house_keys.rds"))
key <- x[1,2]


z <- CompanySearch("Unilever", mkey = key)

cos <- unique(as.vector(z$company.number))

CompanyNetwork(cos, mkey = key, YEAR = 2018)

