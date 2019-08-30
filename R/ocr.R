Sys.setenv(http_proxy="http://10.85.4.54:8080", https_proxy="https://10.85.4.54:8080")

library(pdftools)
library(here)
library(purrr)
library(tesseract)
library(dplyr)

# convert a pdf into individual page images
pdf_to_png <- function(file){
    curwd <- getwd()  
    filename <- stringr::str_split(file, "/") %>% unlist() %>% .[length(.)]
    filepath <- stringr::str_remove(file, paste0("/", filename)) 
    setwd(filepath)
    pdftools::pdf_convert(file, format = "png", dpi = 300)
    setwd(curwd)
}

# All in one ocr - if struggles with large pdfs, can be broken into pages etc later
# bbox output definintion:http://kba.cloud/hocr-spec/1.2/#bbox
ocr_pdf <- function(file){
x <- magick::image_read_pdf(file) %>% 
     magick::image_convert(colorspace = "gray") %>% 
     # magick::image_deskew() %>% 
     magick::image_trim() %>% 
     magick::image_ocr_data()
return(x)
}


