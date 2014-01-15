### R code from vignette source 'latticistEmployment.Rnw'

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
dat <- Employment
datArg <- quote(Employment)
## persistent variables
spec <- list()
plotCalls <- list()
plotNum <- 0


###################################################
### code chunk number 2: latticistEmployment.Rnw:71-73 (eval = FALSE)
###################################################
##   spec <- list()
##   latticist(Employment, spec = spec)


###################################################
### code chunk number 3: latticistEmployment.Rnw:75-79
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 4: latticistEmployment.Rnw:82-83
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 5: latticistEmployment.Rnw:92-93
###################################################
  spec$defaultPlot <- "parallel"


###################################################
### code chunk number 6: latticistEmployment.Rnw:95-99
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 7: latticistEmployment.Rnw:102-103
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 8: latticistEmployment.Rnw:112-113
###################################################
  spec$groups <- "EmploymentStatus"


###################################################
### code chunk number 9: latticistEmployment.Rnw:115-119
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 10: latticistEmployment.Rnw:122-123
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 11: latticistEmployment.Rnw:132-134
###################################################
  spec <- list(xvar = "LayoffCause",
               yvar = "EmploymentLength")


###################################################
### code chunk number 12: latticistEmployment.Rnw:136-140
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 13: latticistEmployment.Rnw:143-144
###################################################
  eval(plotCalls[[plotNum]])


###################################################
### code chunk number 14: latticistEmployment.Rnw:153-154
###################################################
  spec$groups <- "EmploymentStatus"


###################################################
### code chunk number 15: latticistEmployment.Rnw:156-160
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 16: latticistEmployment.Rnw:163-164
###################################################
  eval(plotCalls[[plotNum]])


###################################################
### code chunk number 17: latticistEmployment.Rnw:173-176
###################################################
  spec <- list(xvar = "EmploymentStatus",
               yvar = "EmploymentLength",
               cond = "LayoffCause")


###################################################
### code chunk number 18: latticistEmployment.Rnw:178-182
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 19: latticistEmployment.Rnw:185-186
###################################################
  eval(plotCalls[[plotNum]])


###################################################
### code chunk number 20: latticistEmployment.Rnw:195-196
###################################################
  spec$doSeparateStrata <- FALSE


###################################################
### code chunk number 21: latticistEmployment.Rnw:198-202
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 22: latticistEmployment.Rnw:205-206
###################################################
  eval(plotCalls[[plotNum]])


###################################################
### code chunk number 23: latticistEmployment.Rnw:258-259
###################################################
  writePlotCallsAppendix(plotCalls)


