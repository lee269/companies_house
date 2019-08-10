# Sys.setenv(http_proxy="http://10.85.4.54:8080", https_proxy="https://10.85.4.54:8080")

library(reticulate)
library(dplyr)
reticulate::use_python(python = '/Library/Frameworks/Python.framework/Versions/3.7/bin/python3', required = TRUE)

source(here::here("R", "documents.R"))
# source_python(here::here("python", "xbrl_parser.py"))

key <- readRDS(here::here("keys", "companies_house_keys.rds")) %>% .[1,2] %>% as.character()

# Get some pdfs to attempt to parse
meatsnacks <- "06242292"
filings <- get_filings(meatsnacks, key)
filings <- filings %>% filter(type =="AA")
ac <- filings$links.document_metadata
for (i in 1:length(ac)) {
  get_document_pdf(ac[i], key, here::here("data", paste0("meatsnacks", i, ".pdf")))
                   }



reticulate::source_python(here::here("python", "xbrl_image_parser.py"))
x <- process_PDF(here::here("data", "meatsnacks1.pdf"))

files <- list.files(path = here::here("data"), full.names = TRUE)
x <- purrr::map_df(files, process_PDF)

 
