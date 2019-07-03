Sys.setenv(http_proxy="http://10.85.4.54:8080", https_proxy="https://10.85.4.54:8080")

# 2 possible packages
# https://github.com/joaomicunha/companieshr
# https://github.com/MatthewSmith430/CompaniesHouse

library(devtools)
install_github("joaomicunha/companieshr")
install_github("MatthewSmith430/CompaniesHouse")
