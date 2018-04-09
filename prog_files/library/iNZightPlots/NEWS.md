# Version 2.7
__Release date__: 23 March 2017

## Major Changes

- introduction of the exportation of SVG and interactive HTML documents

## Bug Fixes

- various


## Patches

### Patch 2.7.1 - 02/06/2017
- Mosly adjustments and improvements to the SVG and HTML export functionality
- Changes to dependency structure - made SVG/HTML functions suggested instead of imports
- Bumped R version up to 3.0
- Default line type for all trends is now 1; user can choose alternatives

### Patch 2.7.2 - 18/08/2017
- Changes to ensure CRAN checks pass
- More bug fixes in `exportX()` functions
- Single subset interactive plots and scatterplot maps now available

### Patch 2.7.3 - 02/10/2017
- Just a few more improvements for interactive plots.

### Patch 2.7.4 - 08/12/2017

- More interactive plot/SVG fixes

### Patch 2.7.5 - 23/01/2018

- More fixes and features for interactive plots


***
# Version 2.6
__Release date__: 12 December 2016

## Major Changes

- implementation of statistical hypothesis tests

## Minor Changes

- adjust grid lines to be less distracting
- allow legend to be hidden (`hide.legend`, logical)

## Bug Fixes

- fix critical bug in inference output where CI's and p-values for reorded factors wern't reordered!
- fix issue where confidence intervals for two-way table row proportions were ordered incorrectly

***
# Version 2.5
__Release date__: 5 September 2016

## Major Changes

- made it possible to create new methods for plots (as done in
  iNZightMaps).
- allow any colour function to be specified (at least, any
  that take a single argument `n`)
- allow colour by in hex plots


## Minor Changes

- changes to resizing algorithm (optional change between the
  two)
- background color now applies to INSIDE the plot, not the
  entire graphics window
- allow setting symbol by a variable
- hex is now the default plot for large data sets
- size of "large" data sets increased to 5001
- allow control of line type
- change the g1/g2 group labels to light/dark gray respectively. Can use `col.sub = c("g1col", "g2col")` to adjust them.


## Bug Fixes

- subsetting bug fix in dot plots and histograms
- many other minor bugs fixed while implementing changes


## Patches

### 2.5.1 - 23/09/2016

- Fix a bug causing two-way bar plots to fail in presence of empty levels


***
# Changes in Version 2.3
__Release date__: 1 October 2015

## Minor Changes

- new argument added for dotplots to allow group labels to be
  placed inside the plot, rather than in the axis margin: `internal.labels=TRUE`

### Patch 2.3.1 - 06/10/2015

- fix how viewports are named

### Patch 2.3.2 - 08/10/2015

- fix a bug that prevented comparison lines to be drawn on
  categorical dotplots

### Patch 2.3.3 - 13/10/2015

- fix a bug where adding comparison intervals would break the
  plot if any of the subgroups in a dotplot were too small. New
  behaviour ignores small groups and only compares large ones.

### Patch 2.3.4 - 13/10/2015

- continuing from 2.3.3, but now use independent covariances

### Patch 2.3.4 - 13/10/2015

- FIX for Lite: dotplots by factor labels now also on histograms

### Patch 2.3.5 - 28/10/2015

- fix the "number of missing observations" shown in summary output

### Patch 2.3.7 - 02/11/2015

- no longer redraws dotplots; instead, passes a logical
  attribute for whether or not the scaling has changed (and
  therefore that the plot should be redrawn).

### Patch 2.3.8 - 16/11/2015

- fix bug in `colby` if the variable has only one unique value


***
# Changes in Version 2.2
__Release date__: 14 September 2015

## New Features - Survey Design

- confidence intervals for histograms and bar plots
- comparison intervals for histograms broken down by a factor
- summary information for all basic plots (histograms, bar plots, and scatter plots)


## Bug Fixes

- fixes a bug where missing information on barplots and scatter plots would cause the plotting function to die
- fixes a bug in the printing of summary objects
- fixes a bug where the minimum value of a single numeric variable summary was ommited
- and various other small Bug Fixes



***
# Changes in Version 2.1
__Release date__: 04 August 2015

## New Features

- allow zooming of plots with the new `zoom`
  argument. Works for both univariate and bivariate plots, and a
  related funcionality for 'zooming in' on bars in a barplot.


### Patch 2.1-1: 28 August 2015

- fix a bug that occurs when all survey weights are equal



***
# Changes in Version 2.0.6
__Release date__: 03 August 2015

## Bug Fixes

- fix an issue where requesting summary of 'dotplots' resulted
  in creating a new device, which resulted in errors on the Shiny
  server.



***
# Changes in Version 2.0.5
__Release date__: 27 July 2015

## New Features

- additional arguments `xlim` and `ylim` allow users to
  specify the range of values shown on the plot

## Bug Fixes

- several issues for dotplots have been fixed

- weighting variable used when drawing a scatter plot of
  survey data

- `conf` now corresponds to Year 12 intervals in dot plot
  inferences (previously, `comp` corresponded to this interval)


***
# Changes in Version 2.0.3
__Release date__: 01 July 2015

## Bug Fixes

- fix up the order of bars in segmented bar plots to
  correspond to the legend

***
# Changes in Version 2.0.2
__Release date__: 24 June 2015

## Minor Changes

- remove facility where the colour-by variable is ignored if
  there are 'too many' levels---this is now left up to users to
  decide if colour by a particular variable makes sense of not.


***
# Changes in Version 2.0.1
__Release date__: 16 June 2015

## Minor Changes

- Dotplot locating implemented using new methodology, with the
  additional argument `label.extreme = numeric(2)`, allowing users
  to specify how many lower and upper points to identify,
  respectively.

- equivalently, extreme points (by using Mahalanobis'
  distance) can be labelled on scatter plots using `label.extreme =
  numeric(1)`.


## Bug Fixes

- fixed a small bug that stopped inference from working in
  dotplots when `x` is a factor and `y` is the numeric variable.

- fix a bug that caused `nbins = 0` in some cases.


***
# Changes in Version 2.0
__Release date__: 26 May 2015

## Major Changes

- The entire package has been rewritten to accomodate complex
  survey designs. At present, survey objects are not fully
  supported, however the functionality will be added over time.

- A huge reduction in computation requirements for plots to
  increase efficiency.

- Algorithms used to compute inference intervals have been
  modified to use iNZightMR for comparisons.

- lots of other changes to layout and presentation

- added additional arguments `locate`, `locate.id`,
  `locate.col` (and others) for locating points by IDs.
  This is used in the improved locator functinoality in the main
  `iNZight` program.

## Minor Changes

- the `col.by` and `size.by` arguments have been
  replaced by `colby` and `sizeby`

- documentation has been added for several of the functions (finally!)


***
# Changes in Version 1.0.3

## Bug Fixes

- specifying `g2.level` with numbers wasn't working, has been fixed for plots,
  summary and inference information.

- added more space to the y-axis on scatter plots


***
# Changes in Version 1.0.2

## Bug Fixes

- An error where the response was printed instead of the
  x-variable name in summary output for quadratic curves has been
  fixed.


***
# Changes in Version 1.0.1

## Minor Changes

- The type of plot used can be specified by setting the
  `largesample` argument. When set to `TRUE`, it uses the histogram
  or grid-density plot; when `FALSE` it uses the dotplot or scatter
  plot. If set to `NULL`, it uses the sample size to determine which
  plot to draw (default).

- To allow identification features and any additional features
  to be added to plots afterwards, the last viewport is the one
  surrounding the main plot (excluding the plot labels and
  legend). Note that this only works if the data haven't been broken
  down by `g1`.

- Display which variables cannot be plot due to too many
  levels, as well as the number of levels, when attempting to draw
  bar plot. (max levels = 101).

- Trend lines and smoothers added to the legend.

- Alternative method of shading grid-tiles on the grid-density
  plot using quantiles rather than absolute counts. This prevents
  large counts having too large of an influence.


## Bug Fixes

- A bug where the grid-density plot is not using the correct scale has been fixed.




***
# Version 1.0

- New major release of iNZightPlots released, completely rewritten using `grid`
