# Sometimes we have the case where packages can't be found,
# this could be due to R_HOME being in the wrong place (i.e.
# current dir instead of proper R_HOME dir). To counteract this,
# we set the R_HOME along with the libPath.
isOSX <- .Platform$OS.type != "windows" && Sys.info()["sysname"] == "Darwin"
if (.Platform$OS.type == "windows") {
    Sys.setenv("R_HOME" = file.path(getwd(), "prog_files"))
    .libPaths(file.path(getwd(), "prog_files", "library"))
    isWindows <- TRUE
    isLinux <- FALSE
    OSstring <- "Windows"
    downloadMethod <- getOption("download.file.method", default = "auto")
    utils::setInternet2(TRUE)
} else if (isOSX) {
    isWindows <- FALSE
    isLinux <- FALSE
    .libPaths(Sys.getenv("R_LIBRARIES"))
    # For some reason utils isn't being attached on load
    # so we need to do it explicitly
    library(utils)
    OSstring <- "OSX"
    downloadMethod <- "curl"
} else {
    isWindows <- FALSE
    isLinux <- TRUE
    OSstring <- "Linux"
    downloadMethod <- "wget"
    stop("Updater not supported on this platform")
}

# Define updater function
updateDistribution <- function() {
    # Increment each time the updater needs to be changed
    UPDATER_VERSION <- numeric_version("0.3")

    # Set CRAN to UoA for updating
    uoaCRAN <- structure("http://cran.stat.auckland.ac.nz",
                         names = "CRAN")
    currCRAN <- getOption("repos")
    if (currCRAN["CRAN"] != uoaCRAN) {
        options(repos = uoaCRAN)
        on.exit(options(repos = currCRAN))
    }

    versionsURL <- "https://www.stat.auckland.ac.nz/~wild/downloads/iNZight/versions.txt"
    download.file(versionsURL, "prog_files/versions.txt", method = downloadMethod)
    v <- read.csv("prog_files/versions.txt", header = TRUE, stringsAsFactors = FALSE)

    # Check whether the updater itself needs replacing
    updaterLoc <-
        if (isWindows)
            file.path(getwd(), "prog_files", "updateiNZightVIT.R")
        else
            Sys.getenv("R_PROFILE")

    HOMEPAGE <- "http://www.stat.auckland.ac.nz/~wild/iNZight/"
    FILE_EXT <- ".zip"
    #    if (.Platform$OS.type == "windows")
    #        ".zip"
    #    else
    #        ".tar.gz"
    FILE_TYPE <- "win.binary"
    #    if (FILE_EXT == "zip")
    #        "win.binary"
    #    else
    #        "source"

    # If the updater needs to be updated, present a message box
    # and give instructions to start again
    newestUpdater <- numeric_version(v[1, "Version"])
    if (UPDATER_VERSION < newestUpdater) {
        webUpdaterLoc <-
            paste("https://www.stat.auckland.ac.nz/~wild/downloads/iNZight/",
                  v[1, "Name"], sep = "")
        download.file(webUpdaterLoc, updaterLoc, method = downloadMethod)
        if (isOSX) {
            cat("A new version of the iNZightVIT updater has been downloaded\n\nClose R and run the updater script again to use it.\n")
            return()
        }
        library(tcltk)
        retval <- tk_messageBox(type = "ok",
                                message = "A new version of the iNZightVIT updater has been downloaded\n\nClick OK to close R.\n\nRun the updater script once it has closed.",
                                caption = "Updated iNZightVIT Updater",
                                default = "ok",
                                icon = "info")
        if (retval == "ok")
            return()
    }

    # Remove updater check row
    v <- v[-1, ]

    # First check whether we have a sufficient version of R
    R.rowv <- v$Version[v$Name == "R"]
    if (getRversion() < R.rowv) {
        if (isOSX) {
            cat("A new release of iNZightVIT is required, visiting the website now.\n")
            browseURL(HOMEPAGE)
            return()
        }
        library(tcltk)
        retval <- tk_messageBox(type = "ok",
                                message = "A new release of iNZightVIT is required.\n\nClick OK to visit the iNZightVIT website and download a new copy.",
                                caption = "Update iNZightVIT",
                                default = "ok",
                                icon = "info")
        if (retval == "ok")
            browseURL(HOMEPAGE)
        return()
    }

    # Remove the R version row, no longer necessary
    v <- v[v$Name != "R", ]

    # Just update everything first
    success <- try(update.packages(ask = FALSE), TRUE)
    if (inherits(success, "try-error")) {
        if (isOSX) {
            cat("An error has occurred, perhaps a new version of iNZightVIT is required, visiting the website now.\n")
            browseURL(HOMEPAGE)
            return()
        }
        library(tcltk)
        retval <- tk_messageBox(type = "ok",
                                message = "An error has occurred updating iNZightVIT.\n\nClick OK to visit the iNZightVIT website to download a new copy.",
                                caption = "Update iNZightVIT",
                                default = "ok",
                                icon = "error")
        if (retval == "ok")
            browseURL(HOMEPAGE)
        return()
    }

    # Now going to check each package & version in turn
    for (i in 1:nrow(v)) {
        r <- v[i, ]

        # Found a platform-specific package that is not required for our
        # platform. "" is the special case applying to all platforms.
        if (OSstring != r$Platform & r$Platform != "")
            next

        # If the package is not available on CRAN
        # e.g. iNZight, vit
        # Have to manually specify gWidgets packages as using dev version
        if (! r$Name %in% rownames(available.packages()) |
            r$Name %in% c("gWidgets2", "gWidgets2RGtk2")) {
            getNewPackage <-
                if (r$Name %in% rownames(installed.packages()))
                    package_version(r$Version) > packageVersion(r$Name)
                else
                    TRUE

            if (getNewPackage) {
                urlprefix <-
                    sprintf("http://www.stat.auckland.ac.nz/~wild/downloads/iNZight/%s.%s/",
                            getRversion()$major, getRversion()$minor)
                fn <- paste(r$Name, FILE_EXT, sep = "")

                # If OSX, we need to be able to install from zip.
                # Just means we don't verify on install, just unzip to
                # the right directory.
                # **Must have $R_LIBRARIES set in the .command file**
                if (isOSX) {
                    fileurl <- paste(urlprefix, fn, sep = "")
                    filepath <- file.path(getwd(), fn)
                    # Download
                    download.file(fileurl, filepath, method = downloadMethod)
                    # "Install" -- just unzipping a precompiled binary
                    system(sprintf("unzip -oq %s -d %s", filepath, Sys.getenv("R_LIBRARIES")))
                    # Remove
                    file.remove(filepath)
                    next
                }

                # Assume Windows from now on
                tmploc <- file.path(tempdir(), fn)
                download.file(paste(urlprefix, fn, sep = ""),
                              destfile = tmploc, method = downloadMethod)
                success <- try(install.packages(tmploc, repos = NULL, type = FILE_TYPE), TRUE)
                if (inherits(success, "try-error")) {
                    if (isOSX) {
                        cat("An error has occurred, perhaps a new version of iNZightVIT is required, visiting the website now.\n")
                        browseURL(HOMEPAGE)
                        return()
                    }
                    library(tcltk)
                    retval <- tk_messageBox(type = "ok",
                                            message = "An error has occurred updating iNZightVIT.\n\nClick OK to visit the iNZightVIT website and download a new copy.",
                                            caption = "Update iNZightVIT",
                                            default = "ok",
                                            icon = "error")
                    if (retval == "ok")
                        browseURL(HOMEPAGE)
                    file.remove(tmploc)
                    return()
                } else {
                    cat(paste("Installed package:", r$Name), "\n")
                }
                file.remove(tmploc)
            }
        } else {
            # Package is on CRAN

            # Install from CRAN if we don't have it
            if (! r$Name %in% rownames(installed.packages())) {
                success <- try(install.packages(r$Name, dependencies = TRUE), TRUE)
                if (inherits(success, "try-error")) {
                    if (isOSX) {
                        cat("An error has occurred, perhaps a new version of iNZightVIT is required, visiting the website now.\n")
                        browseURL(HOMEPAGE)
                        return()
                    }
                    library(tcltk)
                    retval <- tk_messageBox(type = "ok",
                                            message = "An error has occurred updating iNZightVIT.\n\nClick OK to visit the iNZightVIT website and download a new copy.",
                                            caption = "Update iNZightVIT",
                                            default = "ok",
                                            icon = "error")
                    if (retval == "ok")
                        browseURL(HOMEPAGE)
                    return()
                } else {
                    cat(paste("Installed new package:", r$Name), "\n")
                }
            }
        }
    }

    cat("\n\n")
    cat("==================\n")
    cat("\n")
    cat("Updating complete.\n")
    cat("\n")
    cat("==================\n")
    cat("\n")
}

# Actually do the updating
updateDistribution()
