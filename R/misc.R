Sys.setenv(http_proxy="http://10.85.4.54:8080", https_proxy="https://10.85.4.54:8080")

library(dplyr)
library(here)

source(here::here("R", "documents.R"))

key <- readRDS(here::here("keys", "companies_house_keys.rds")) %>% .[1,2] %>% as.character()

filings <- get_filings("07955170", key)

aa <- filings %>% filter(type == "AA") %>% select(links.document_metadata)
url <- aa[1, 1]

has_xbrl(url)

get_document(url, key, type = "pdf", filename = here::here("data", "test.pdf"))

pdf <- here::here("data", "test.pdf")
meta <- pdftools::pdf_info(here::here("data", "test.pdf"))

x <- magick::image_read_pdf(pdf) %>% magick::image_ocr_data()
  magick::image_convert(colorspace = "gray") %>% 
  magick::image_trim() %>% 
  # magick::image_deskew() %>% 
  magick::image_ocr()

?tesseract::ocr_data()

z <- ocr_pdf(pdf)