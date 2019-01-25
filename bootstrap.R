## read yaml config
config <- yaml::read_yaml("pkg_versions.yml")

if (dir.exists('prog_files')) unlink('prog_files', TRUE, TRUE)

## download R installer
R_VERSION = config$r_version
INST_FILE = sprintf("R-%s-win.exe", R_VERSION)
LOCAL_DIR <- file.path(
    "~", ".wine", "drive_c", "Program Files", "R", sprintf("R-%s", R_VERSION)
)
# this will let us cache R?
if (!dir.exists(LOCAL_DIR)) {
    dir.create(LOCAL_DIR, recursive = TRUE)
    inst.file <- file.path("https://cran.rstudio.com/bin/windows/base", INST_FILE)
    cat(" * downloading installer\n")
    download.file(inst.file, INST_FILE, quiet = TRUE)
    cat(" * installing R\n")
    if (.Platform$OS.type == "windows") {
        cat(" - can't do that on windows yet")
    } else {
        system(sprintf("wine %s", INST_FILE))
    }
    unlink(INST_FILE)
}

## move it into place
cat(" * copying into prog_files\n")
x <- dir.create("prog_files")
subdirs <- c("bin", "doc", "etc", "include", "library", "modules", "share", "src", "Tcl")
for (dir in subdirs)
    x <- file.copy(file.path(LOCAL_DIR, dir), file.path("prog_files"), recursive = TRUE)
x <- dir.create(file.path("prog_files", "images"))
cat(" * copying assets\n")

x <- file.copy(file.path("assets", "images"), file.path("prog_files"), recursive = TRUE)
x <- file.copy(file.path("assets", "inzight_profile.R"), file.path(".Rprofile"))
dir.create(file.path("prog_files", "vit"))
x <- file.copy(file.path("assets", "vit_profile.R"), file.path("prog_files", "vit", ".Rprofile"))
x <- file.copy(file.path("assets", "update_profile.R"), file.path("prog_files", ".Rprofile"))


## run this to get all the necessary packages and get them updated and all that jazz
# cat(" * compiling list of required packages\n")
# pkglib <- file.path("prog_files", "library")
# pkgversions <- installed.packages(pkglib)[, 'Version']

# repos <- c('https://r.docker.stat.auckland.ac.nz', 'https://cran.stat.auckland.ac.nz')
# if (!requireNamespace('packrat', quietly = TRUE)) install.packages('packrat', repos = repos[2])
# if (!requireNamespace('devtools', quietly = TRUE)) install.packages('devtools', repos = repos[2])

# ap <- available.packages(repos = repos)
# srclib <- .libPaths()[1]
# inzpkgs <- c('iNZight', 'iNZightPlots', 'iNZightModules', 'iNZightTools',
#              'iNZightRegression', 'iNZightMR', 'iNZightTS', 'vit')
# if (length(ca) > 0)
#     inzpkgs <- c(inzpkgs, ca)

# extrapkgs <- packrat:::getPackageDependencies(inzpkgs, srclib, ap, 
#                                               fields = c('Depends', 'Imports', 'Suggests', 'LinkingTo'))
# if (!'iNZightMaps' %in% inzpkgs) {
#     extrapkgs <- extrapkgs[extrapkgs != "iNZightMaps"]
#     extrapkgs <- extrapkgs[extrapkgs != "sf"]
# }
# extrapkgs <- extrapkgs[extrapkgs != "Acinonyx"]

# ## Installing additional packages specified on command line ...
# deps <- unique(c(inzpkgs, extrapkgs, packrat:::recursivePackageDependencies(unique(c(inzpkgs, extrapkgs)), srclib, ap)))
# print(deps)

# missing <- deps[!deps %in% names(pkgversions)]

# pkgu <- pkgversions[names(pkgversions) %in% rownames(ap)]
# outdated <- names(pkgu)[ap[names(pkgu), 'Version'] > pkgu]

# grab <- unique(c(missing, outdated))

# cat(" * downloading packages\n")
# pkgs <- download.packages(grab, pkglib, repos = repos, type = 'win.binary', quiet = TRUE)

# ## unzip
# cat(" * extracting packages into place\n")
# x <- apply(pkgs, 1, function(pkg) {
#     pkgd <- file.path("prog_files", "library", pkg[1]) 
#     if (dir.exists(pkgd)) unlink(pkgd, TRUE, TRUE)
#     unzip(pkg[2], exdir = file.path("prog_files", "library"))
#     unlink(pkg[2])
# })

# ## and stick gtk into place 
# cat(" * copying GTK library\n")
# x <- file.copy(file.path("assets", "gtk"), file.path("prog_files", "library", "RGtk2"), recursive = TRUE)

# ## and then install the latest versions of things ...
# cat(" * Done!\n\nNow go to `dev` and install the development iNZight packages\nif this isn't the master release\n")
