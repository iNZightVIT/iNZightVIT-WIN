### R code from vignette source 'latticistAids2.Rnw'

###################################################
### code chunk number 1: preliminaries
###################################################
if (!file.exists("figs")) dir.create("figs")
library(latticist)
ltheme <- custom.theme.2()
ltheme$strip.background$col <- grey(7:1 / 8)
ltheme$strip.shingle$col <- grey(6:0 / 8)
lattice.options(default.theme = ltheme)
ps.options(pointsize = 12)
options(width = 45, continue = " ")
source("common.R")
## set up data object
library(MASS)
dat <- Aids2
datArg <- quote(Aids2)
## persistent variables
spec <- list()
plotCalls <- list()
plotNum <- 0


###################################################
### code chunk number 2: latticistAids2.Rnw:72-74 (eval = FALSE)
###################################################
##   spec <- list()
##   latticist(Aids2, spec = spec)


###################################################
### code chunk number 3: latticistAids2.Rnw:76-80
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 4: latticistAids2.Rnw:83-84
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 5: latticistAids2.Rnw:93-94
###################################################
  spec$xvar <- "T.categ"


###################################################
### code chunk number 6: latticistAids2.Rnw:96-100
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 7: latticistAids2.Rnw:103-104
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 8: latticistAids2.Rnw:113-115
###################################################
  spec$groups <- "status"
  spec$subset <- "T.categ != 'hs'"


###################################################
### code chunk number 9: latticistAids2.Rnw:117-121
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 10: latticistAids2.Rnw:124-125
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 11: latticistAids2.Rnw:134-135
###################################################
  spec <- list(yvar = "T.categ", xvar = "status")


###################################################
### code chunk number 12: latticistAids2.Rnw:137-141
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 13: latticistAids2.Rnw:144-145
###################################################
  eval(plotCalls[[plotNum]])


###################################################
### code chunk number 14: latticistAids2.Rnw:154-155
###################################################
  spec <- list(yvar = "T.categ", xvar = "age")


###################################################
### code chunk number 15: latticistAids2.Rnw:157-161
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 16: latticistAids2.Rnw:164-165
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 17: latticistAids2.Rnw:174-176
###################################################
  spec <- list(yvar = "jitter(age)", xvar = "diag",
               zvar = "death", doSegments = TRUE)


###################################################
### code chunk number 18: latticistAids2.Rnw:178-182
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 19: latticistAids2.Rnw:185-186
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 20: latticistAids2.Rnw:195-196
###################################################
  spec$groups <- "diag"


###################################################
### code chunk number 21: latticistAids2.Rnw:198-202
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 22: latticistAids2.Rnw:205-206
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 23: latticistAids2.Rnw:215-216
###################################################
  spec$cond <- "T.categ"


###################################################
### code chunk number 24: latticistAids2.Rnw:218-222
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 25: latticistAids2.Rnw:225-226
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 26: latticistAids2.Rnw:235-237
###################################################
  spec <- list(xvar = "age", yvar = "(death - diag)",
               subset = "status == 'D'", doHexbin = TRUE)


###################################################
### code chunk number 27: latticistAids2.Rnw:239-243
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 28: latticistAids2.Rnw:246-247
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 29: latticistAids2.Rnw:256-259
###################################################
  spec <- modifyList(spec, list(cond = "T.categ",
                                x.relation = "free",
                                doLines = FALSE))


###################################################
### code chunk number 30: latticistAids2.Rnw:261-265
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 31: latticistAids2.Rnw:268-269
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 32: latticistAids2.Rnw:320-321
###################################################
  writePlotCallsAppendix(plotCalls)


