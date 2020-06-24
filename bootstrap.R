ca <- commandArgs(trailingOnly = TRUE)

cat (" * cleaning old files\n")
if (dir.exists("prog_files")) unlink("prog_files", TRUE, TRUE)

## download installer
R_VERSION <- as.character(getRversion())
R_VERSION_SHORT <- paste(strsplit(R_VERSION, "\\.")[[1]][1:2], collapse = ".")
INST_FILE <- sprintf("R-%s-win.exe", R_VERSION)
LOCAL_DIR <- file.path("~", ".wine", "drive_c", "Program Files", "R",
    sprintf("R-%s", R_VERSION)
)
LIBPATH <- file.path("prog_files", "library")
if (!dir.exists(LOCAL_DIR)) {
    inst.file <- file.path(
        "https://cran.stat.auckland.ac.nz/bin/windows/base/old",
        R_VERSION,
        INST_FILE
    )
    cat(" * downloading installer\n")
    download.file(inst.file, INST_FILE, quiet = TRUE)
    cat(" * installing into ~/.wine\n")
    system(sprintf("wine %s", INST_FILE))
    unlink(INST_FILE)
}
cat (" * using R version ", R_VERSION, " (R-", R_VERSION_SHORT, ")\n", sep = "")

BRANCH <- system("git rev-parse --abbrev-ref HEAD", TRUE)
cat(" * on branch", BRANCH, "\n")

## move it into place
cat(" * copying into prog_files\n")
x <- dir.create("prog_files")
subdirs <- c("bin", "doc", "etc", "include", "library", "modules",
    "share", "src", "Tcl")
for (dir in subdirs)
    x <- file.copy(
        file.path(LOCAL_DIR, dir),
        file.path("prog_files"),
        recursive = TRUE
    )
x <- dir.create(file.path("prog_files", "images"))
cat(" * copying assets\n")
x <- file.copy(
    file.path("assets", "images"),
    file.path("prog_files"),
    recursive = TRUE
)
x <- file.copy(
    file.path("assets", "vit"),
    file.path("prog_files"),
    recursive = TRUE
)
x <- file.copy(
    file.path("assets", ".Rprofile"),
    file.path("prog_files")
)
# copy the Rconsole file with MDI=no setting
x <- file.copy(
    file.path("assets", "Rconsole"),
    file.path("prog_files/etc"),
    overwrite = TRUE
)


## run this to get all the necessary packages and get them updated and
## all that jazz
cat(" * compiling list of required packages\n")
pkglib <- file.path("prog_files", "library")
pkgversions <- installed.packages(pkglib)[, 'Version']

repos <- c('https://r.docker.stat.auckland.ac.nz',
    #'https://cran.stat.auckland.ac.nz'
    'https://cran.csiro.au'
)
if (!requireNamespace('packrat', quietly = TRUE))
    install.packages('packrat', repos = repos[2])
if (!requireNamespace('devtools', quietly = TRUE))
    install.packages('devtools', repos = repos[2])
if (!requireNamespace('git2r', quietly = TRUE))
    install.packages('git2r', repos = repos[2])

ap <- available.packages(repos = repos)
# srclib <- LIBPATH #.libPaths()[1]
inzpkgs <- c('iNZight', 'iNZightPlots', 'iNZightModules', 'iNZightTools',
             'iNZightRegression', 'iNZightMR', 'iNZightTS', 'vit')
if (grepl("maps", BRANCH)) inzpkgs <- c(inzpkgs, "iNZightMaps")
if (length(ca) > 0)
    inzpkgs <- c(inzpkgs, ca)

extrapkgs <- packrat:::getPackageDependencies(inzpkgs, LIBPATH, ap,
    fields = c('Depends', 'Imports', 'Suggests', 'LinkingTo'))

## dev version install (if not master)
dev.deps <- character()
if (!grepl("master", BRANCH)) {
    cat(" * on dev branch, installing package dev dependencies\n")
    for (pkg in inzpkgs) {
        desc <- remotes:::load_pkg_description(
            file.path("..", pkg)
        )
        dev.deps <- unique(c(dev.deps,
            remotes:::parse_deps(desc$depends)$name,
            remotes:::parse_deps(desc$imports)$name,
            remotes:::parse_deps(desc$suggests)$name
        ))
    }
    dev.deps <- dev.deps[!dev.deps %in% c(inzpkgs, extrapkgs)]
}

extrapkgs <- extrapkgs[extrapkgs != "Acinonyx"]
if (!'iNZightMaps' %in% inzpkgs) {
    extrapkgs <- extrapkgs[extrapkgs != "iNZightMaps"]
    extrapkgs <- extrapkgs[extrapkgs != "sf"]
}

## Installing additional packages specified on command line ...
deps <- unique(c(inzpkgs, extrapkgs,  dev.deps,
    suppressWarnings(packrat:::recursivePackageDependencies(
        unique(c(inzpkgs, extrapkgs, dev.deps)),
        LIBPATH,
        ap
    ))
))

writeLines(deps, "packages.txt")

missing <- deps[!deps %in% names(pkgversions)]

pkgu <- pkgversions[names(pkgversions) %in% rownames(ap)]
outdated <- names(pkgu)[ap[names(pkgu), 'Version'] > pkgu]

grab <- sort(unique(c(missing, outdated)))

cat(" * downloading packages\n")
pkgs <- download.packages(grab, pkglib,
    repos = repos,
    type = 'win.binary',
    quiet = TRUE
)

## unzip
cat(" * extracting packages into place\n")
x <- apply(pkgs, 1, function(pkg) {
    pkgd <- file.path("prog_files", "library", pkg[1])
    if (dir.exists(pkgd)) unlink(pkgd, TRUE, TRUE)
    unzip(pkg[2], exdir = file.path("prog_files", "library"))
    unlink(pkg[2])
})

## and stick gtk into place
cat(" * copying GTK library\n")
x <- file.copy(
    file.path("assets", "gtk"),
    file.path("prog_files", "library", "RGtk2"),
    recursive = TRUE
)

## install pandoc ...
# wine install pandoc-2.9.2.1/pandoc.exe

if (!grepl("master", BRANCH)) {
    cat(" * install dev versions of iNZight packages ... ")
    system(sprintf(
        "cd ../dev && make all replace keepMaps=%s WINV=%s > /dev/null 2>&1",
        ifelse(grepl("maps", BRANCH), "true", "false"),
        R_VERSION_SHORT
    ))
    cat("done\n")
}

## and then install the latest versions of things ...
cat(" * Bootstrapping complete.\n")
