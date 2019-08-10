Sys.setenv(http_proxy="http://10.85.4.54:8080", https_proxy="https://10.85.4.54:8080")

library(here)
library(stringr)
library(tidyverse)
library(rvest)

source(here("R", "make_accounts_data.R"))
source(here("R", "parse.R"))

ch_url <- "http://download.companieshouse.gov.uk/en_monthlyaccountsdata.html"
page <- read_html(ch_url)

monthly_url <- page %>% html_nodes("a") %>% html_attr("href") %>% str_subset("Accounts_Monthly_Data") %>% paste0("http://download.companieshouse.gov.uk/", .)
monthly_file <- page %>% html_nodes("a") %>% html_attr("href") %>% str_subset("Accounts_Monthly_Data")


for(i  in 4:length(monthly_file)){
accounts <- map2_df(monthly_url[i], monthly_file[i], make_accounts_data)
saveRDS(accounts, here("data", paste0("accounts", i, ".rds")))
}

