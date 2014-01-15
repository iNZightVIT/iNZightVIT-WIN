### R code from vignette source 'latticistFrogs.Rnw'

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
library(DAAG)
## coerce numeric 0/1 to factor (happens in latticist())
frogs$pres.abs <- factor(frogs$pres.abs)
dat <- frogs
datArg <- quote(frogs)
## persistent variables
spec <- list()
plotCalls <- list()
plotNum <- 0


###################################################
### code chunk number 2: latticistFrogs.Rnw:72-74 (eval = FALSE)
###################################################
##   spec <- list()
##   latticist(frogs, spec = spec)


###################################################
### code chunk number 3: latticistFrogs.Rnw:76-80
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 4: latticistFrogs.Rnw:83-84
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 5: latticistFrogs.Rnw:93-96
###################################################
  spec <- list(varSubset = c("altitude", "distance",  "NoOfPools",
           "NoOfSites", "avrain", "meanmin", "meanmax"),
               defaultPlot = "splom")


###################################################
### code chunk number 6: latticistFrogs.Rnw:98-102
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 7: latticistFrogs.Rnw:105-106
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 8: latticistFrogs.Rnw:115-117
###################################################
  spec$groups <- "altitude"
  spec$defaultPlot <- "parallel"


###################################################
### code chunk number 9: latticistFrogs.Rnw:119-123
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 10: latticistFrogs.Rnw:126-127
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 11: latticistFrogs.Rnw:136-138
###################################################
  spec$yvar <- "northing"
  spec$xvar <- "easting"


###################################################
### code chunk number 12: latticistFrogs.Rnw:140-144
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 13: latticistFrogs.Rnw:147-148
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 14: latticistFrogs.Rnw:157-159
###################################################
  spec$aspect <- "iso"
  spec$doLines <- FALSE


###################################################
### code chunk number 15: latticistFrogs.Rnw:161-165
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 16: latticistFrogs.Rnw:168-169
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 17: latticistFrogs.Rnw:178-179
###################################################
  spec$groups <- "pres.abs"


###################################################
### code chunk number 18: latticistFrogs.Rnw:181-185
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 19: latticistFrogs.Rnw:188-189
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 20: latticistFrogs.Rnw:198-199
###################################################
  spec$zvar <- "altitude"


###################################################
### code chunk number 21: latticistFrogs.Rnw:201-205
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 22: latticistFrogs.Rnw:208-209
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 23: latticistFrogs.Rnw:246-247
###################################################
  writePlotCallsAppendix(plotCalls)


