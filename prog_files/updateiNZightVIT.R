library(utils)
if (!"RCurl" %in% rownames(installed.packages()))
    install.packages("RCurl")
library(RCurl)

source_https <- function(url, ...) {
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
updateDistribution()
