## UPDATE iNZightVIT:

Sys.setenv("R_HOME" = file.path(getwd()))
.libPaths(file.path(getwd(), "library"))

local({
  r <- getOption("repos")
  r["CRAN"] <- "http://cran.stat.auckland.ac.nz"
  options(repos = r)
})

library(utils)

source("https://www.stat.auckland.ac.nz/~wild/downloads/iNZight/update.R")
updateDistribution()

cat("\n")
cat("         You can now close this window and run iNZightVIT.\n\n\n")
