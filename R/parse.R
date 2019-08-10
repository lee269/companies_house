Sys.setenv(http_proxy="http://10.85.4.54:8080", https_proxy="https://10.85.4.54:8080")

# install.packages("reticulate")
# https://github.com/ONSBigData/parsing_company_accounts
# Sys.which("python")
reticulate::use_python("/usr/bin/python3.6", required = TRUE)

extract_data <- function(statement){
require(reticulate)
require(here)

source_python(here("python", "xbrl_parser.py"))

x <- process_account(statement)
y <- flatten_data(x)
return(y)
}

