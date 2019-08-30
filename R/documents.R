# Documents: https://forum.aws.chdev.org/t/cant-access-documents-from-amazons3-server/1871
Sys.setenv(http_proxy="http://10.85.4.54:8080", https_proxy="https://10.85.4.54:8080")

# retrieve filing history table for a company
get_filings <- function(company_number, key){
    baseurl <- "https://api.companieshouse.gov.uk/company/"
    url <- paste0(baseurl, company_number, "/filing-history")
    
    result <- httr::GET(url, httr::authenticate(key, ""))
    z <- jsonlite::fromJSON(httr::content(result, as = "text", encoding = "utf-8"), flatten = TRUE)
    
    filings <- z$items
    return(filings)
}

# check for availability of xbrl document
has_xbrl <- function(metadata_url){
  auth <- paste0("Basic ", jsonlite::base64_enc(paste0(key, ":")))
  meta <- httr::GET(metadata_url, httr::add_headers(Authorization = auth))
  metaparsed <- jsonlite::fromJSON(httr::content(meta, as = "text", encoding = "utf-8"), flatten = TRUE)
  x <- as.data.frame(unlist(purrr::map(metaparsed, unlist))) %>% row.names() %>% stringr::str_detect("xml") %>% sum()
  if (x > 0) return(TRUE) else return(FALSE)
}




# download a pdf document from company filing history
get_document <- function(metadata_url, key, type, filename){
  auth <- paste0("Basic ", jsonlite::base64_enc(paste0(key, ":")))
  meta <- httr::GET(metadata_url, httr::add_headers(Authorization = auth))
  metaparsed <- jsonlite::fromJSON(httr::content(meta, as = "text", encoding = "utf-8"), flatten = TRUE)
  content_url <- metaparsed$links$document
  
  if (type == "pdf") {accept <- "application/pdf"}
  if (type == "xbrl") {accept <- "application/xhtml+xml"}
   
  content_get <- httr::GET(content_url, httr::add_headers(Authorization = auth, Accept = accept), httr::config(followlocation = FALSE))
  finalurl <- content_get$headers$location
  
  finaldoc <- httr::GET(finalurl, httr::add_headers(Accept = accept))
  writeBin(httr::content(finaldoc, "raw"), filename)
}





