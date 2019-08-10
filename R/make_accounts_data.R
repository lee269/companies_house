make_accounts_data <- function(url, file){
  require(here)
  require(stringr)
  require(tidyverse)
  require(rvest)
  
  source(here("R", "parse.R"))
  download.file(url, destfile = here("downloads", file))
  
  zipfile <- here("downloads", file)
  
  filelist <- unzip(zipfile, list = TRUE)
  filelist <- filelist %>% 
    separate(Name, into = c("part1", "part2", "companyno", "date"), sep = "_")
  
  fdm <- readRDS(here("data", "fdm.rds"))
  
  files <- fdm %>% 
    inner_join(filelist)
  
  files <- files %>% 
    mutate(account = paste(part1, part2, companyno, date, sep = "_"))
  
  g <- as.list(files$account)
  
  unzip(zipfile, files = files$account, exdir = here("downloads"))
  
  
  acs <- map_df(here("downloads", g), extract_data)
  
  
  map(here("downloads", g), file.remove)
  file.remove(zipfile)
  
  return(acs)
}