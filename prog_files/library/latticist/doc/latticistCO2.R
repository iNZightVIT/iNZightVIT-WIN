### R code from vignette source 'latticistCO2.Rnw'

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
dat <- CO2
datArg <- quote(CO2)
## persistent variables
spec <- list()
plotCalls <- list()
plotNum <- 0


###################################################
### code chunk number 2: latticistCO2.Rnw:72-74 (eval = FALSE)
###################################################
##   spec <- list()
##   latticist(CO2, spec = spec)


###################################################
### code chunk number 3: latticistCO2.Rnw:76-80
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 4: latticistCO2.Rnw:83-84
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 5: latticistCO2.Rnw:93-94
###################################################
  spec$yvar <- "uptake"


###################################################
### code chunk number 6: latticistCO2.Rnw:96-100
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 7: latticistCO2.Rnw:103-104
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 8: latticistCO2.Rnw:113-114
###################################################
  spec$xvar <- "conc"


###################################################
### code chunk number 9: latticistCO2.Rnw:116-120
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 10: latticistCO2.Rnw:123-124
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 11: latticistCO2.Rnw:133-134
###################################################
  spec$groups <- "Treatment"


###################################################
### code chunk number 12: latticistCO2.Rnw:136-140
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 13: latticistCO2.Rnw:143-144
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 14: latticistCO2.Rnw:153-154
###################################################
  spec$cond <- "Type"


###################################################
### code chunk number 15: latticistCO2.Rnw:156-160
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 16: latticistCO2.Rnw:163-164
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 17: latticistCO2.Rnw:173-174
###################################################
  spec$cond <- "Plant"


###################################################
### code chunk number 18: latticistCO2.Rnw:176-180
###################################################
  plotNum <- plotNum + 1
  plotCalls[[plotNum]] <-
    latticistCompose(dat, spec = spec, datArg = datArg)
  writeCallAndRef(plotCalls[[plotNum]], plotNum)


###################################################
### code chunk number 19: latticistCO2.Rnw:183-184
###################################################
  print(eval(plotCalls[[plotNum]]))


###################################################
### code chunk number 20: latticistCO2.Rnw:221-222
###################################################
  writePlotCallsAppendix(plotCalls)


