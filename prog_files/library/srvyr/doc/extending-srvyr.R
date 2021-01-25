## ----setup, echo = FALSE------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

if (!require(convey) | !require(laeken)) {
  knitr::opts_chunk$set(eval = FALSE)
  message("Missing convey and laeken packages. Install them to run vignette.")
}

data("eusilc", package = "laeken")
if (!exists("eusilc")) {
  knitr::opts_chunk$set(eval = FALSE)
  message("Did not find 'eusilc' data in laeken package, cannot continue.")
}

## -----------------------------------------------------------------------------
# S3 generic function
survey_gini <- function(
  x, na.rm = FALSE, vartype = c("se", "ci", "var", "cv"), ...
) {
  if (missing(vartype)) vartype <- "se"
  vartype <- match.arg(vartype, several.ok = TRUE)
  .svy <- srvyr::set_survey_vars(srvyr::cur_svy(), x)
  
  out <- convey::svygini(~`__SRVYR_TEMP_VAR__`, na.rm = na.rm, design = .svy)
  out <- srvyr::get_var_est(out, vartype)
  out
}

## -----------------------------------------------------------------------------
# Example from ?convey::svygini
suppressPackageStartupMessages({
  library(srvyr)
  library(survey)
  library(convey)
  library(laeken)
})
data(eusilc) ; names( eusilc ) <- tolower( names( eusilc ) )

# Setup for survey package
des_eusilc <- svydesign(
  ids = ~rb030, 
  strata = ~db040,  
  weights = ~rb050, 
  data = eusilc
)
des_eusilc <- convey_prep(des_eusilc)

# Setup for srvyr package
srvyr_eusilc <- eusilc %>% 
  as_survey(
    ids = rb030,
    strata = db040,
    weights = rb050
  ) %>%
  convey_prep()

## Ungrouped
# Calculate ungrouped for survey package
svygini(~eqincome, design = des_eusilc)

# Use new function from summarize
srvyr_eusilc %>% 
  summarize(eqincome = survey_gini(eqincome))

## Groups
# Calculate by groups for survey
survey::svyby(~eqincome, ~rb090, des_eusilc, convey::svygini)

# Use new function from summarize
srvyr_eusilc %>% 
  group_by(rb090) %>%
  summarize(eqincome = survey_gini(eqincome))


