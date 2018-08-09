## run this to get all the necessary packages and get them updated and all that jazz

pkglib <- file.path("prog_files", "library")
pkgversions <- installed.packages(pkglib)[, 'Version']

repos <- c('http://r.docker.stat.auckland.ac.nz/R', 'https://cran.stat.auckland.ac.nz')
if (!requireNamespace('packrat')) install.packages('packrat', repos = repos[2])
if (!requireNamespace('devtools')) install.packages('devtools', repos = repos[2])

ap <- available.packages(repos = repos)
srclib <- .libPaths()[1]
inzpkgs <- c('iNZight', 'iNZightPlots', 'iNZightModules', 'iNZightTools',
             'iNZightRegression', 'iNZightMR', 'iNZightTS', 'vit')

extrapkgs <- packrat:::getPackageDependencies(inzpkgs, srclib, ap, 
                                              fields = c('Depends', 'Imports', 'Suggests', 'LinkingTo'))
extrapkgs <- extrapkgs[!extrapkgs %in% c("Acinonyx", 'iNZightMaps')]
deps <- c(extrapkgs, packrat:::recursivePackageDependencies(unique(c(inzpkgs, extrapkgs)), srclib, ap))

missing <- deps[!deps %in% names(pkgversions)]

pkgu <- pkgversions[names(pkgversions) %in% rownames(ap)]
outdated <- names(pkgu)[ap[names(pkgu), 'Version'] > pkgu]

grab <- unique(c(missing, outdated))

download.packages(grab, pkglib, repos = repos, type = 'win.binary')
