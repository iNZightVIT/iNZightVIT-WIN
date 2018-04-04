# Version 2.0
__Release date__: 18 Janary 2018

Massive overhaul of the mapping module, using ggplot2 and sf packages.



***
# Version 1.1
__Release date__: 11 July, 2016

## New Features

- Integrated all graphics with the iNZightPlots package
- Faster drawing of maps, and include subset-by variables
- Add shape methods for colouring regions of a map

## Patches

### Version 1.1-1 - 30/09/2016

- pass the current environment to `iNZightPlot` so `data=` works

### Version 1.1-2 - 19/11/2016

- fix up an issue where longitude value range was too large at 0 and +-180

### Version 1.1-3 - 10/04/2017

- fix bug where difference in range approx 0 but not quite

***
# Version 1.0
__Release date__: 24 February, 2016

- Plot geographical data on a map with the simplest of commands.
- Uses iNZightPlots for the base layouts, and only modifies the internal plots.
- Can currently handle coordinate and country data.
