
## ----eval=FALSE----------------------------------------------------------
## help(package = 'YourPackage', help_type = 'html')


## ----hello, results='asis'-----------------------------------------------
cat('_hello_ **markdown**!', '\n')


## ------------------------------------------------------------------------
1+1
10:1
rnorm(5)^2
strsplit('hello, markdown vignettes', '')


## ------------------------------------------------------------------------
n=300; set.seed(123)
par(mar=c(4,4,.1,.1))
plot(rnorm(n), rnorm(n), pch=21, cex=5*runif(n), col='white', bg='gray')


## ----css, eval=FALSE-----------------------------------------------------
## options(markdown.HTML.stylesheet = 'path/to/a/custom/style.css')


## ----header--------------------------------------------------------------
options(markdown.HTML.header = system.file('misc', 'vignette.css', package='knitr'))


