Sys.setenv(http_proxy="http://10.85.4.54:8080", https_proxy="https://10.85.4.54:8080")

library(dplyr)
library(here)

source(here::here("R", "documents.R"))

key <- readRDS(here::here("keys", "companies_house_keys.rds")) %>% .[1,2] %>% as.character()

tesco <- "00445790"
moss <- "07955170"
meatsnacks <- "06242292"

filings <- get_filings(moss, key, category = "accounts", items_per_page = "50")

url <- filings$links.document_metadata[1]


has_xbrl(url, key)

get_document(url, key, type = "pdf", filename = here::here("data", "moss.pdf"))
pdf <- here::here("data", "moss.pdf")

x <- magick::image_read_pdf(pdf) %>%
      magick::image_ocr(HOCR = TRUE) %>%
      purrr::map(hocr::hocr_parse) %>%
      purrr::map(hocr::tidy_tesseract) %>% 
      bind_rows()

z <- x %>% group_by(ocr_page_id, ocr_par_id, ocr_line_id) %>% summarise(line = paste(ocrx_word_value, collapse = " "))

