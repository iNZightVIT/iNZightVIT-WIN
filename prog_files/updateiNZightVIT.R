# This is the update script for WINDOWS
library(RCurl)

# First set up some global variables that will be used by the updater function
Sys.setenv("R_HOME" = file.path(getwd(), "prog_files"))
.libPaths(file.path(getwd(), "prog_files", "library"))
isWindows <- TRUE
isLinux <- FALSE
isOSX <- FALSE
OSstring <- "Windows"
downloadMethod <- getOption("download.file.method", default = "auto")
utils::setInternet2(TRUE)
useOldR <- FALSE  # this can be set to TRUE for versions that need to
                  # stick with an old version of R

UPDATER_VERSION <- numeric_version(1.0)
updater.location <- file.path(getwd(), "prog_files", "updateiNZightVIT.R")
update.ext <- "-WIN"  # this will be "-WIN", "-MAC", "-MAC-snowleopard" etc...

source_https <- function(url, ...) {
  # load package
    require(RCurl)

  # Download the new file to a temporary location and source it.
    sapply(c(url, ...), function(u) {
        text <- getURL(u, followlocation = TRUE,
                       cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
        ftmp <- tempfile()
        con <- file(ftmp, open = "w")
        writeLines(text, con)
        close(con)
        source(ftmp)
    })
}
source_https("https://www.stat.auckland.ac.nz/~wild/downloads/iNZight/update.R")
#source(file.choose())  # this is for debugging
updateDistribution()
