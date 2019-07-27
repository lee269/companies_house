# Documents: https://forum.aws.chdev.org/t/cant-access-documents-from-amazons3-server/1871


library(here)
library(httr)
library(jsonlite)
library(plyr)

x <- readRDS(here::here("keys", "companies_house_keys.rds"))
key <- x[1,2]

company_number <- "00445790"

baseurl <- "https://api.companieshouse.gov.uk/company/"
url <- paste0(baseurl, company_number)


result <- GET(url, authenticate(key, ""))
z <- content(result, as = "text")
z1 <- fromJSON(z, flatten = TRUE)
z2 <- ldply(z1[["accounts"]][["next_accounts"]], data.frame)


fromJSON()