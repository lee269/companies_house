Sys.setenv(http_proxy="http://10.85.4.54:8080", https_proxy="https://10.85.4.54:8080")

library(here)
library(stringr)
library(tidyverse)
library(rvest)

ch_url <- "http://download.companieshouse.gov.uk/en_monthlyaccountsdata.html"

page <- read_html(ch_url)

monthly_url <- page %>% html_nodes("a") %>% html_attr("href") %>% str_subset("Accounts_Monthly_Data") %>% paste0("http://download.companieshouse.gov.uk/", .)
monthly_file <- page %>% html_nodes("a") %>% html_attr("href") %>% str_subset("Accounts_Monthly_Data")

download.file(monthly_url[1], destfile = here("downloads", monthly_file[1]))
