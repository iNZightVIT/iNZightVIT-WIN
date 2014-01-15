
## ----cool, results='asis'------------------------------------------------
library(knitr)
kable(mtcars, 'html', table.attr='id="mtcars_table"')


## ------------------------------------------------------------------------
options(markdown.HTML.header = unlist(
  sapply(system.file('misc', c('vignette.css', 'datatables.txt'), package = 'knitr'), readLines)
  )
)


## ----boring, results='asis'----------------------------------------------
kable(head(mtcars), 'html')


