# Package Development Script

library(usethis)
library(devtools)
library(roxygen2)

# Create Package
#tmp <- file.path("FILEPATH", "TestContR")
#create_package(tmp)

use_mit_license("Alfredo G Marquez")
pckg_list <- c("random","tidyverse","reshape2")
use_package( "random", type = "Import")
use_package( "tidyverse", type = "Import")
use_package( "reshape2", type = "Import")

# After adding roxygen2 params to function in R folder
devtools::document()

use_tidy_versions()
use_vignette("Group Selection")
use_readme_rmd()
use_testthat()


