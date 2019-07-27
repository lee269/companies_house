Sys.setenv(http_proxy="http://10.85.4.54:8080", https_proxy="https://10.85.4.54:8080")

library(here)
library(companieshr)
library(purrr)


# wrapper from companieshr package and add delay to avoid rate limiting
chc <- function(cos, key){
       x <- companies_house_collect(companies = cos, auth_api_key = key)
       Sys.sleep(0.6)
       return(x$results_df)
}

# Get API key
x <- readRDS(here("keys", "companies_house_keys.rds"))
key <- as.character(x[1,2])

# get dataframe of company numbers
cono <- readRDS(here("data", "CompanyNumber.rds"))

cos1 <- cono

# Harvest company profiles
z <- map_dfr(cos1, ~ chc(cos = .x, key = key))

# saveRDS(z, here("data", "company_profiles.rds"))
