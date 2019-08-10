# Documents: https://forum.aws.chdev.org/t/cant-access-documents-from-amazons3-server/1871

# retrieve filing history table for a company
get_filings <- function(company_number, key){
    baseurl <- "https://api.companieshouse.gov.uk/company/"
    url <- paste0(baseurl, company_number, "/filing-history")
    
    result <- httr::GET(url, httr::authenticate(key, ""))
    z <- jsonlite::fromJSON(httr::content(result, as = "text", encoding = "utf-8"), flatten = TRUE)
    
    filings <- z$items
    return(filings)
}

# download a pdf document from company filing history
get_document_pdf <- function(metadata_url, key, filename){
  auth <- paste0("Basic ", jsonlite::base64_enc(paste0(key, ":")))
  meta <- httr::GET(metadata_url, httr::add_headers(Authorization = auth))
  metaparsed <- jsonlite::fromJSON(httr::content(meta, as = "text", encoding = "utf-8"), flatten = TRUE)
  content_url <- metaparsed$links$document
  
  accept <- "application/pdf"
  
  content_get <- httr::GET(content_url, httr::add_headers(Authorization = auth, Accept = accept), httr::config(followlocation = FALSE))
  finalurl <- content_get$headers$location
  
  finaldoc <- httr::GET(finalurl, httr::add_headers(Accept = accept))
  writeBin(httr::content(finaldoc, "raw"), filename)
}





