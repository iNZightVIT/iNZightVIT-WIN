# Version 2.3
__Release date__: 23 January 2018


## Beta release: New __Maps__ module for plotting geographic regional data

The new maps module is an overhaul of the previous one, with much more control
over maps and options for graphs.

## Minor Changes

- __Time series__: now using `ggplot2` for several of the graphs.

## Patches

### 2.3-1 - 12/02/2018
- fix bugs in time series modules for annual data and manual time specification

***

# Version 2.2
__Release date__: 18 August, 2017

## BETA RELEASE: New + Improved _Model Fitting_ module

As we have done with the Multiple Response and Time Series modules,
we've completely redesigned the interface for model fitting with iNZight.

- More intuitive user experience
- Responsive modelling: summary and plots of fitted models are provided as you build them
- ... and more to come!


__Please note__: that this _is_ a beta release, and therefore expect some things to not work.
Let us know what you did to break it so we can fix it, or if there's anything else you'd like to see,
or not see, just let us know!


## Patches

### 2.2.0-1 - 23/08/2017
- bug fixes: bootstrapping, residual plots
- better handling of errors
- extra features, etc

### 2.2.0-2 - 25/08/2017
- code history for model fitting module
- more bug fixes

### 2.2.0-3 - 20/10/2017

- \[TS Module\] display error message when time series is missing values (or fails some other way)

***

# Version 2.1
__Release date__: 23 March, 2017

## Major Changes

- Release of newly designed Time Series module. All the usual features, but a far nicer interface, and a smoothness-slider!


## Patches

### 2.1.1 - 02/06/2017

- Fix updatePlot return value so it works with `iNZightPlots`'s `exportXXX()` functions

***

# Version 2.0
__Release date__: 11 July, 2016

## Major Changes

- Redesigned Multiple Response Module
- Redesigned Maps module
- Change how module dependencies are imported (using `::`)

## Patches

### 2.0-1 - 05/09/2016

- Fix depreciation of `add3rdmouseButtonDropMenu` to `addRightclickDropMenu` in `gWidgets2` package.

### 2.0-2 - 23/09/2016

- Catch fatal errors in trying to guess TS information

***
# Version 1.2
__Release date__: 25 August, 2015

## Bug Fixes

- Import entire `iNZightTools` package


***
# Version 1.1
__Release date__: 22 April, 2015

Updated to conincide with the release of iNZight version 2.1.


***
# Version 1.0.8
__Release date__: 18 March, 2015

## Bug Fixes

- fix a bug where iNZightTS wasn't being imported properly


***
# Version 1.0.7
__Release date__: 23 February, 2015

## Bug Fixes

- remove `RGL` from `NAMESPACE` completely


***
# Version 1.0.6
__Release date__: 4 February, 2015

## Bug Fixes

- fix an issue where RGL causes R on some Windows 8 machines to crash


***
# Version 1.0.5
__Release date__: 27 November, 2014

## Minor Changes

- add scrollbars to Time Series window if it doesn't fit on
  the screen


***
# Version 1.0.4

- along with change in iNZightTS, allow x-label on more plots


***
# Verson 1.0.3

## New Features

- the pairs plot, or scatter plot matrix, now takes a grouping variable.
- 2-variable explore plots in the Quick Explore menu

## Minor Changes

- Changes to the time series module to allow specification of
  multiplicative time series models.
- Add y-axis label functionality.


***
# Version 1.0.2

## Minor Changes

- the pairs/scatter plot matrix draws a jittered dotplot rather than a
  barcode plot.


***
# Version 1.0.1

- Minor changes in package information and structure.


***
# Version 1.0

This is the first release of this package, although it was previously
bundled inside the iNZight package.

## Major Changes

- The model fitting module

  - Rewritten in `gWidgets2`
  - Allows users to specify general linear models, and survey
  	designs for analysis of survey data.
  - Users can change the data type from numeric to categorical, and vice verca.
  - Confounding variables can be specified separately.
