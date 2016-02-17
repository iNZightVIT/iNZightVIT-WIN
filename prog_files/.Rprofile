## UPDATE iNZightVIT:

Sys.setenv("R_HOME" = file.path(getwd()))
.libPaths(file.path(getwd(), "library"))

local({
  r <- getOption("repos")
  r["CRAN"] <- "http://cran.stat.auckland.ac.nz"
  options(repos = r)
})

## Update modules in the Documents/iNZightVIT/modules directory:
lib <- file.exists(file.path("~", "iNZightVIT", "modules"))
if (!file.exists(lib)) lib <- NULL

library(utils)

source("https://www.stat.auckland.ac.nz/~wild/downloads/iNZight/update.R")
updateDistribution(lib = lib)
