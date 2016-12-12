## START iNZight

# Things you might want to change

# options(papersize="a4")
# options(editor="notepad")
# options(pager="internal")

# set the default help type
# options(help_type="text")
options(help_type="html") ##, warn = -1)

# set a site library
# .Library.site <- file.path(chartr("\\", "/", R.home()), "site-library")

# set a CRAN mirror
# local({r <- getOption("repos")
#       r["CRAN"] <- "http://my.local.cran"
#       options(repos=r)})


# setting CRAN mirror to UoA
local({
  r <- getOption("repos")
  r["CRAN"] <- "http://cran.stat.auckland.ac.nz"
  options(repos = r)
})

# Sometimes we have the case where packages can't be found,
# this could be due to R_HOME being in the wrong place (i.e.
# current dir instead of proper R_HOME dir). To counteract this,
# we set the R_HOME along with the libPath.
Sys.setenv("R_HOME" = file.path(getwd(), "prog_files"))
.libPaths(file.path(getwd(), "prog_files", "library"))

pkgs <- c("hextri")
if (any(!pkgs %in% utils::installed.packages()[, "Package"])) {
    cat("\nInstalling additional packages ...\n\n")
    utils::install.packages(pkgs)
}


grDevices::dev.new(width = 5, height = 2)
grid::grid.newpage()
# Will try to draw a raster if possible, otherwise an array of pixels

try({
  suppressWarnings({
    splashImg <- png::readPNG(file.path(getwd(), "prog_files", "images", "inzight-banner.png"),
                              exists("rasterImage"))
  })
  grid::grid.raster(splashImg)#, width = grid::unit(360, "points"), height = grid::unit(60, "points"))
}, silent = TRUE)

message("(Dept of Statistics, Uni. of Auckland)")
message("")
message("Please wait while iNZight loads...")

suppressMessages(suppressWarnings({
  library(iNZight)
}))

# Killing the splash screen, assigning to remove print
tmp <- grDevices::dev.off()
rm(tmp)

# Let's go!
suppressWarnings({
  iNZight(disposeR = TRUE)
})
# the `disposeR = TRUE` makes sure when a user closes iNZight, they
# close the entire R session (but not if they open it through R!)
