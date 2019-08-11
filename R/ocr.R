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
     magick::image_deskew() %>% 
     magick::image_trim() %>% 
     magick::image_ocr_data()
return(x)
}

pdf <- here::here("data", "meatsnacks4.pdf")
meta <- pdf_info(here::here("data", "meatsnacks4.pdf"))

pages <- meta$pages
pdf_to_png(here::here("data", "meatsnacks1.pdf"))

magick::image_read(here::here("data", "meatsnacks1_15.png")) %>% 
  magick::image_convert(colorspace = "gray") %>% 
  magick::image_trim %>% 
  magick::image_deskew() %>% 
  magick::image

?tesseract::ocr_data()

