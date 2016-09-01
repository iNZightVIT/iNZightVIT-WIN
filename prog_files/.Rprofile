## UPDATE iNZightVIT:

VERSION = 1.0

Sys.setenv("R_HOME" = file.path(getwd()))
.libPaths(file.path(getwd(), "library"))

## Update modules in the Documents/iNZightVIT/modules directory:
lib <- file.exists(file.path("~", "iNZightVIT", "modules"))
if (!file.exists(lib)) lib <- NULL

library(utils)

source("https://raw.githubusercontent.com/iNZightVIT/dev/master/update.R")
updateDistribution(lib = lib)
