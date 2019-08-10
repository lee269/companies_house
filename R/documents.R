# Documents: https://forum.aws.chdev.org/t/cant-access-documents-from-amazons3-server/1871
Sys.setenv(http_proxy="http://10.85.4.54:8080", https_proxy="https://10.85.4.54:8080")

library(here)
library(httr)
library(jsonlite)
library(plyr)

x <- readRDS(here::here("keys", "companies_house_keys.rds"))
key <- x[1,2]

company_number <- "00445790"


get_filings <- function(company_number, key){
  
    baseurl <- "https://api.companieshouse.gov.uk/company/"
    url <- paste0(baseurl, company_number, "/filing-history")
    
    result <- httr::GET(url, authenticate(key, ""))
    z <- jsonlite::fromJSON(content(result, as = "text", encoding = "utf-8"), flatten = TRUE)
    
    filings <- z$items
    return(filings)
}

x <- get_filings("04996999", key)

docurl <- x$links.document_metadata[1]
auth <- paste0("Basic ", base64_enc(paste0(key, ":")))

meta <- GET(docurl, add_headers(Authorization = auth))
metaparsed <- jsonlite::fromJSON(content(meta, as = "text", encoding = "utf-8"), flatten = TRUE)



mpurl <- metaparsed$links$document
accept <- "application/pdf"
test <- GET(mpurl, add_headers(Authorization = auth, Accept = accept), config(followlocation = FALSE))
finalurl <- test$headers$location

finaldoc <- GET(finalurl, add_headers(Accept = accept))
writeBin(content(finaldoc, "raw"), here("data", "test.pdf"))

