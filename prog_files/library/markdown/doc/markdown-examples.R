
## ----read-code, include=FALSE--------------------------------------------
library(knitr)
opts_chunk$set(tidy = FALSE)  # otherwise \n will cause problems
read_chunk(system.file('examples', 'markdownExtensions.R', package = 'markdown'),
           labels = 'md-extensions')
read_chunk(system.file('examples', 'HTMLOptions.R', package = 'markdown'),
           labels = 'html-options')


## ------------------------------------------------------------------------
library(markdown)


## ----md-extensions-------------------------------------------------------


## ----html-options--------------------------------------------------------


## ----include=FALSE-------------------------------------------------------
options(markdown.HTML.header = system.file('misc', 'vignette.css', package='knitr'),
        markdown.HTML.options=markdownHTMLOptions(defaults=TRUE))


