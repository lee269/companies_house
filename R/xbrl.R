# install.packages("finstr")
# library(devtools)
# install_github("bergant/finstr")

library(XBRL)
library(finstr)
library(here)
library(dplyr)

options(stringsAsFactors = FALSE)


# filing <- "Prod223_2441_00020830_20190228.html"
filing <- here("data", "Prod223_2441_09892803_20181031.html")

data(xbrl_data_aapl2013)

xbrl <- XBRL()
xbrl$setCacheDir("XBRLcache")
xbrl$openInstance(filing)

xbrl$getSchemaName()
xbrl$processSchema("https://xbrl.frc.org.uk/FRS-102/2014-09-01/FRS-102-2014-09-01.xsd")
xbrl$processContexts()
xbrl$processUnits()
xbrl$processFacts()
xbrl$processFootnotes()
xbrl$closeInstance()
xbrl.vars <- xbrl$getResults()

elements <- xbrl.vars$element
facts <- xbrl.vars$fact





xbrl_get_statements(xbrl.vars)


x <- xbrl$getResults()
# element <- 
# role <- 
# calculation <- 
context <- xbrl$processContexts() 
fact <- xbrl$processFacts()
# label <- 
units <- xbrl$processUnits()


inst <- "https://www.sec.gov/Archives/edgar/data/21344/000002134413000050/ko-20130927.xml"
xbrl <- XBRL()
xbrl$openInstance(inst)



xbrl.vars <- xbrlDoAll(inst, cache.dir="XBRLcache", prefix.out="out", verbose=TRUE)
z <- xbrl_get_statements(xbrl.vars)
xbrl_get_data()

# http://download.companieshouse.gov.uk/Accounts_Bulk_Data-2019-07-23.zip

