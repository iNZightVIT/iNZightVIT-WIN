## ---- include=FALSE-----------------------------------------------------------
source("chunk_opts.R")

## ---- echo=TRUE, eval=FALSE---------------------------------------------------
#  install.packages("validate")

## ---- echo=FALSE, include=!knitr::is_latex_output()---------------------------
knitr::asis_output("
[![Creative Commons License](https://i.creativecommons.org/l/by-nc/4.0/88x31.png)](https://creativecommons.org/licenses/by/4.0/)
")

## ---- include=FALSE-----------------------------------------------------------
source("chunk_opts.R")

## ---- include=FALSE, eval=knitr::is_latex_output()----------------------------
#  knitr::opts_chunk$set(comment=NA)

## -----------------------------------------------------------------------------
data(cars)
head(cars, 3)

## -----------------------------------------------------------------------------
library(validate)
rules <- validator(speed >= 0
                 , dist >= 0
                 , speed/dist <= 1.5
                 , cor(speed, dist)>=0.2)

## -----------------------------------------------------------------------------
out   <- confront(cars, rules)

## -----------------------------------------------------------------------------
summary(out)

## ----fig.height=7, fig.width=7, echo=!knitr::is_latex_output(), eval=!knitr::is_latex_output()----
plot(out)

## ---- label="validateplot", fig.height=5, fig.width=5, out.width="0.7\\textwidth", fig.align="center", echo=knitr::is_latex_output(), eval=knitr::is_latex_output(), fig.env="figure",fig.pos="!t", fig.cap="Plot of validation output."----
#  plot(out)

## -----------------------------------------------------------------------------
violating(cars, out[1:3])

## -----------------------------------------------------------------------------
df_out <- as.data.frame(out)
head(df_out, 3)

## ---- include=FALSE-----------------------------------------------------------
source("chunk_opts.R")

## -----------------------------------------------------------------------------
library(validate)
data(SBS2000)
head(SBS2000, 3)

## -----------------------------------------------------------------------------
is.character("hihi")
is.character(3)

## -----------------------------------------------------------------------------
rules <- validator(
    is.character(size)
  , is.numeric(turnover)
)
out <- confront(SBS2000, rules)
summary(out)

## -----------------------------------------------------------------------------
rule <- validator(
   !is.na(turnover)
 , !is.na(other.rev)
 , !is.na(profit)
)
out <- confront(SBS2000, rule)
summary(out)

## -----------------------------------------------------------------------------
rules <- validator( 
    !any(is.na(incl.prob))
    , all(is.na(vat)) )
out <- confront(SBS2000, rules)
summary(out) 

## -----------------------------------------------------------------------------
rules <- validator(
   nchar(as.character(size)) >= 2
 , field_length(id, n=5)
 , field_length(size, min=2, max=3)
)
out <- confront(SBS2000, rules)
summary(out)

## -----------------------------------------------------------------------------
dat <- data.frame(x = c("2.54","2.66","8.142","23.53"))

## -----------------------------------------------------------------------------
rule <- validator( number_format(x, format="d.dd"))
values(confront(dat, rule))

## -----------------------------------------------------------------------------
x <- c("12.123","123.12345")
number_format(x, min_dig=4)
number_format(x, max_dig=3)
number_format(x, min_dig=2, max_dig=4)
number_format(x, min_dig=2, max_dig=10)
# specify the decimal separator.
number_format("12,123", min_dig=2, dec=",")

## -----------------------------------------------------------------------------
rule <- validator(field_format(id, "RET*")
                , field_format(size, "sc?" ))
out  <- confront(SBS2000, rule)
summary(out)

## -----------------------------------------------------------------------------
rule <- validator(
          grepl("^sc[0-9]$", size)
        , field_format(id, "^RET\\d{2}$" , type="regex") )
summary(confront(SBS2000, rule))

## -----------------------------------------------------------------------------
rules <- validator(TO = turnover >= 0
                 , TC = total.costs >= 0)

## -----------------------------------------------------------------------------
rules <- rules + 
  validator(PR = in_range(incl.prob, min=0, max=1))

## -----------------------------------------------------------------------------
out <- confront(SBS2000, rules, lin.ineq.eps=0)

## -----------------------------------------------------------------------------
summary(out)

## -----------------------------------------------------------------------------
period = sprintf("2018Q%d", 1:4)
period

## -----------------------------------------------------------------------------
in_range(period, min="2017Q2", max = "2018Q2")

## -----------------------------------------------------------------------------
rule <- validator(size %in% c("sc0","sc1","sc2","sc3"))
out  <- confront(SBS2000, rule)
summary(out)

## -----------------------------------------------------------------------------
c(1, 3, NA) %in% c(1,2)
c(1, 3, NA) %vin% c(1,2)

## -----------------------------------------------------------------------------
rule <- validator(
  x %in% read.csv("codelist.csv")$code
)
## Or, equivalently
rule <- validator(
  valid_codes := read.csv("codelist.csv")$code
  , x %in% valid_codes
)


## -----------------------------------------------------------------------------
codelist <- c("sc0","sc1","sc2","sc3")
rule <- validator(size %in% valid_codes)
# pass the codelist
out <- confront(SBS2000, rule
              , ref=list(valid_codes=codelist))
summary(out)

## ---- include=FALSE-----------------------------------------------------------
source("chunk_opts.R")

## -----------------------------------------------------------------------------
library(validate)
data(samplonomy)
head(samplonomy, 3)

## -----------------------------------------------------------------------------
head(samplonomy,3)

## -----------------------------------------------------------------------------
rule <- validator(is_unique(region, period, measure))
out <- confront(samplonomy, rule)
# showing 7 columns of output for readability
summary(out)[1:7]

## -----------------------------------------------------------------------------
violating(samplonomy, out)

## -----------------------------------------------------------------------------
df <- data.frame(x = c(1,1), y = c("A",NA))
df

## -----------------------------------------------------------------------------
df <- data.frame(x=rep(1,3), y = c("A", NA, NA))
is_unique(df$x, df$y)

## -----------------------------------------------------------------------------
# y is unique, given x. But not by itself
df <- data.frame(x=rep(letters[1:2],each=3), y=rep(1:3,2))

# the split-apply-combine approach
unsplit(tapply(df$y, df$x, is_unique), df$x)

# the combined approach
is_unique(df$x, df$y)

## -----------------------------------------------------------------------------
rule <- validator(
  contains_at_least( 
      keys = data.frame(period = as.character(2014:2019))
    , by=list(region, measure) )
)
out <- confront(samplonomy, rule)
# showing 7 columns of output for readability
summary(out)[1:7]

## -----------------------------------------------------------------------------
head(violating(samplonomy, out))

## -----------------------------------------------------------------------------
years <- as.character(2014:2019)
quarters <- paste0("Q",1:4)

keyset <- expand.grid(
  region = c("Agria", "Induston")
  , period = sapply(years, paste0, quarters))

head(keyset)

## -----------------------------------------------------------------------------
rule <- validator(
          contains_at_least(keys=minimal_keys, by=measure) 
        )
out <- confront(samplonomy, rule
              , ref=list(minimal_keys=keyset))
# showing 7 columns of output for readability
summary(out)[1:7]

## -----------------------------------------------------------------------------
years <- as.character(2014:2019)
quarters <- paste0("Q",1:4)

keyset <- expand.grid(
  region  = c(
    "Agria" 
   ,"Crowdon"
   ,"Greenham"
   ,"Induston"
   ,"Mudwater"
   ,"Newbay"
   ,"Oakdale"
   ,"Samplonia"
   ,"Smokeley"
   ,"Wheaton"
  )
 ,period = c(years, sapply(years, paste0, quarters))
)
head(keyset)

## -----------------------------------------------------------------------------
rule <- validator(contains_exactly(all_keys, by=measure))
out  <- confront(samplonomy, rule
               , ref=list(all_keys=keyset))
# showing 7 columns of output for readability
summary(out)[1:7]

## -----------------------------------------------------------------------------
erroneous_records <- violating(samplonomy, out)
unique(erroneous_records$measure)

## -----------------------------------------------------------------------------
is_linear_sequence(c(1,2,3,4))
is_linear_sequence(c(8,6,4,2))
is_linear_sequence(c(2,4,8,16))

## -----------------------------------------------------------------------------
is_linear_sequence(c("2020Q1","2020Q2","2020Q3","2020Q4"))

## -----------------------------------------------------------------------------
is_linear_sequence(c("2020Q4","2020Q2","2020Q3","2020Q1"))

## -----------------------------------------------------------------------------
is_linear_sequence(c("2020Q4","2020Q2","2020Q3","2020Q1")
                 , begin = "2020Q2")

## -----------------------------------------------------------------------------
series <- c(1,2,3,4,1,2,3,3)
blocks <- rep(c("a","b"), each = 4)
is_linear_sequence(series, by = blocks)

## -----------------------------------------------------------------------------
in_linear_sequence(series, by = blocks)

## -----------------------------------------------------------------------------
is_linear_sequence(5)

## -----------------------------------------------------------------------------
blocks[8] <- "c"
data.frame(series = series, blocks = blocks)
in_linear_sequence(series, blocks)

## -----------------------------------------------------------------------------
in_linear_sequence(series, blocks, begin = 1, end = 4)

## -----------------------------------------------------------------------------
rule <- validator(
          in_linear_sequence(period
            , by = list(region, freq, measure))
        )
out  <- confront(samplonomy, rule)
summary(out)[1:7]

## ---- results='hide'----------------------------------------------------------
violating(samplonomy, out)

## ---- include=FALSE-----------------------------------------------------------
source("chunk_opts.R")

## -----------------------------------------------------------------------------
library(validate)
data(SBS2000)
head(SBS2000, 3)


## -----------------------------------------------------------------------------
rules <- validator(
          is_complete(id)
        , is_complete(id, turnover)
        , is_complete(id, turnover, profit )
        , all_complete(id)
)
out <- confront(SBS2000, rules)
# suppress last column for brevity
summary(out)[1:7]

## -----------------------------------------------------------------------------
rules <- validator(
    total.rev - profit == total.costs
  , turnover + other.rev == total.rev
  , profit <= 0.6*total.rev
)

out <- confront(SBS2000, rules)
summary(out)

## -----------------------------------------------------------------------------
out <- confront(SBS2000, rules, lin.ineq.eps=0, lin.eq.eps=0.01)
summary(out)

## -----------------------------------------------------------------------------
rule <- validator(if (staff >= 1) staff.costs >= 1)
out  <- confront(SBS2000, rule)
summary(out)

## -----------------------------------------------------------------------------
transactions <- data.frame(
   sender   = c("S21", "X34", "S45","Z22")
 , receiver = c("FG0", "FG2", "DF1","KK2")
 , value    = sample(70:100,4)
)

## -----------------------------------------------------------------------------
forbidden <- data.frame(sender="S*",receiver = "FG*")

## -----------------------------------------------------------------------------
rule <- validator(does_not_contain(glob(forbidden_keys)))
out <- confront(transactions, rule, ref=list(forbidden_keys=forbidden))
## Suppress columns for brevity
summary(out)[1:7]

## -----------------------------------------------------------------------------
violating(transactions, out)

## ---- include=FALSE-----------------------------------------------------------
source("chunk_opts.R")

## -----------------------------------------------------------------------------
library(validate)
data(SBS2000)
head(SBS2000, 3)

## -----------------------------------------------------------------------------
data(samplonomy)
head(samplonomy, 3)

## -----------------------------------------------------------------------------
rule <- validator(
    mean(profit, na.rm=TRUIE) >= 1
  , cor(turnover, staff, use="pairwise.complete.obs") > 0
)
out <- confront(SBS2000, rule)
# suppress some columns for brevity
summary(out)[1:7]

## -----------------------------------------------------------------------------
rule <- validator(
  turnover <= 10*do_by(turnover, by=size, fun=median, na.rm=TRUE)
)
out <- confront(SBS2000, rule)
# suppress some columns for brevity
summary(out)[1:7]

## -----------------------------------------------------------------------------
medians <- with(SBS2000, do_by(turnover, by=size, fun=median, na.rm=TRUE))
head(data.frame(size = SBS2000$size, median=medians))

## -----------------------------------------------------------------------------
d <- data.frame(
   hhid   = c(1,  1,  2,  1,  2,  2,  3 )
 , person = c(1,  2,  3,  4,  5,  6,  7 )
 , hhrole = c("h","h","m","m","h","m","m")
)
d

## -----------------------------------------------------------------------------
rule <- validator(exists_one(hhrole == "h", by=hhid))
out <- confront(d, rule)
# suppress some columns for brevity
summary(out)

## -----------------------------------------------------------------------------
violating(d, out)

## -----------------------------------------------------------------------------
violating(d, validator(exists_any(hhrole=="h",by=hhid) ))

## -----------------------------------------------------------------------------
rule <- validator(exists_one(region=="Samplonia", by=list(period, measure)))

## -----------------------------------------------------------------------------
out <- confront(samplonomy, rule)
# suppress some columns for brevity
summary(out)[1:7]

## -----------------------------------------------------------------------------
violating(samplonomy, out)

## -----------------------------------------------------------------------------
data(nace_rev2)
head(nace_rev2[1:4])

## -----------------------------------------------------------------------------
dat <- data.frame(
        nace   = c("01","01.1","01.11","01.12", "01.2")
      , volume = c(100 ,70    , 30    ,40     , 25    )
     )
dat

## -----------------------------------------------------------------------------
dat$check <- hierarchy(dat$volume, dat$nace, nace_rev2[3:4])
dat

## -----------------------------------------------------------------------------
samplonia <- data.frame(
    region   = c("Agria", "Induston"
               , "Wheaton", "Greenham"
               , "Smokely", "Mudwater", "Newbay", "Crowdon")
  , parent = c(rep("Samplonia",2), rep("Agria",2), rep("Induston",4))
) 
samplonia

## -----------------------------------------------------------------------------
data(samplonomy)
head(samplonomy)

## -----------------------------------------------------------------------------
rule <- validator(
  hierarchy(value, region, hierarchy=ref$codelist, by=list(period, measure))
)
out <- confront(samplonomy, rule, ref=list(codelist=samplonia))
summary(out)

## -----------------------------------------------------------------------------
warnings(out)

## -----------------------------------------------------------------------------
subset(samplonomy, region  == "Induston" & 
                   period  == "2018Q2"   & 
                   measure == "export")

## -----------------------------------------------------------------------------
i <- !duplicated(samplonomy[c("region","period","measure")])
samplonomy2 <- samplonomy[i, ]

out <- confront(samplonomy2, rule, ref=list(codelist=samplonia))
# suppress some columns for brevity
summary(out)[1:7]

## -----------------------------------------------------------------------------
rules <- validator(
   level0 = hierarchy(value, region, ref$level0, by=list(period, measure))
 , level1 = hierarchy(value, region, ref$level1, by=list(period, measure))
)
out <- confront(samplonomy2, rules
        , ref=list(level0=samplonia[1:2,], level1=samplonia[3:8,])
       )
summary(out)

## -----------------------------------------------------------------------------
violating(samplonomy2, out["level0"]) 

## -----------------------------------------------------------------------------
rules <- validator(
  part_whole_relation(value
    , labels=region
    , whole="Samplonia"
    , part =c("Agria","Induston")
    , by=list(measure, period)
  )
)

## -----------------------------------------------------------------------------
out <- confront(samplonomy, rules)
# suppress some columns for brevity
summary(out)[1:7]

## -----------------------------------------------------------------------------
violating(samplonomy, out)

## -----------------------------------------------------------------------------
subset(samplonomy, region=="Agria" & period == "2015" & measure == "gdp")

## -----------------------------------------------------------------------------
subset(samplonomy, region=="Induston" & freq == "A" & measure=="export")

## -----------------------------------------------------------------------------
rules <- validator(part_whole_relation(value
  , labels = period
  , whole  = rx("^\\d{4}$")
  , by = list(region, substr(period,1,4), measure) 
  ))
out <- confront(samplonomy, rules)

## -----------------------------------------------------------------------------
errors(out)
# suppress some columns for brevity
summary(out)[1:7]

## -----------------------------------------------------------------------------
lacking(samplonomy, out)

## -----------------------------------------------------------------------------
violating(samplonomy, out)

## ---- include=FALSE-----------------------------------------------------------
source("chunk_opts.R")

## -----------------------------------------------------------------------------
library(validate)
ii <- indicator(
    BMI = (weight/2.2046)/(height*0.0254)^2 
  , mh  = mean(height)
  , mw  = mean(weight))
out <- confront(women, ii)

## -----------------------------------------------------------------------------
out

## -----------------------------------------------------------------------------
summary(out)

## -----------------------------------------------------------------------------
head(add_indicators(women, out), 3)

## -----------------------------------------------------------------------------
women$id <- letters[1:15]

## -----------------------------------------------------------------------------
out <- confront(women, ii,key="id")
tail( as.data.frame(out) )

## ---- include=FALSE-----------------------------------------------------------
source("chunk_opts.R")

## ---- echo=FALSE--------------------------------------------------------------
library(validate)

## ---- eval=FALSE--------------------------------------------------------------
#  # basic range checks
#  speed >= 0
#  dist  >= 0
#  
#  # ratio check
#  speed / dist <= 1.5

## -----------------------------------------------------------------------------
rules <- validator(.file="myrules.R")

## -----------------------------------------------------------------------------
v <- validator(speed >= 0, dist>=0, speed/dist <= 1.5)
v

## -----------------------------------------------------------------------------
w <- v[c(1,3)]

## -----------------------------------------------------------------------------
w <- v[c("V1","V3")]

## -----------------------------------------------------------------------------
rules1 <- validator(speed>=0)
rules2 <- validator(dist >= 0)
all_rules <- rules1 + rules2

## -----------------------------------------------------------------------------
v[[3]]

## -----------------------------------------------------------------------------
rules <- validator(positive_speed = speed >= 0, ratio = speed/dist <= 1.5)
rules

## -----------------------------------------------------------------------------
names(rules)
names(rules)[1] <- "nonnegative_speed"

## -----------------------------------------------------------------------------
# add 'foo' to the first rule:
meta(rules[1],"foo") <- 1
# Add 'bar' to all rules
meta(rules,"bar") <- "baz"

## -----------------------------------------------------------------------------
v[[1]]

## -----------------------------------------------------------------------------
meta(v)

## -----------------------------------------------------------------------------
summary(v)

## -----------------------------------------------------------------------------
length(v)

## -----------------------------------------------------------------------------
variables(v)
variables(v,as="matrix")

## -----------------------------------------------------------------------------
rules <- validator(.file="myrules.yaml")
rules

## -----------------------------------------------------------------------------
rules1 <- rules[c(1,3)]
export_yaml(rules1, file="myrules2.yaml")

## -----------------------------------------------------------------------------
rules <- validator(speed >= 0, dist >= 0, speed/dist <= 1.5)
df <- as.data.frame(rules)

## -----------------------------------------------------------------------------
rules <- validator(.data=df)

## ----eval=FALSE---------------------------------------------------------------
#  ?syntax

## -----------------------------------------------------------------------------
sum_by(1:10, by = rep(c("a","b"), each=5) )

## -----------------------------------------------------------------------------
v  <- validator(height>0, weight>0,height/weight < 0.5)
cf <- confront(women, rules)
aggregate(cf) 

## -----------------------------------------------------------------------------
head(aggregate(cf,by='record'))

## -----------------------------------------------------------------------------
# rules with most violations sorting first:
sort(cf)

## -----------------------------------------------------------------------------
v <- validator(hite > 0, weight>0)
summary(confront(women, v))

## ----eval=TRUE, error=TRUE----------------------------------------------------
# this gives an error
confront(women, v, raise='all')

## -----------------------------------------------------------------------------
women1 <- women
rules <- validator(height == women_reference$height)
cf <- confront(women, rules, ref = list(women_reference = women1))
summary(cf)

## -----------------------------------------------------------------------------
rules <- validator( fruit %in% codelist )
fruits <-  c("apple", "banana", "orange")
dat <- data.frame(fruit = c("apple","broccoli","orange","banana"))
cf <- confront(dat, rules, ref = list(codelist = fruits))
summary(cf)

## ---- include=FALSE-----------------------------------------------------------
source("chunk_opts.R")

## ---- eval=FALSE--------------------------------------------------------------
#  v <- validator(height>0, weight> 0)
#  export_yaml(v,file="my_rules.yaml")

## ---- eval=FALSE--------------------------------------------------------------
#  df <- as.data.frame(v)

## ---- include=FALSE-----------------------------------------------------------
source("chunk_opts.R")

## ---- echo=FALSE--------------------------------------------------------------
library(validate)

## -----------------------------------------------------------------------------
library(validate)
data(SBS2000)
original <- SBS2000
version2 <- original
version2$other.rev <- abs(version2$other.rev)
version3 <- version2
version3$turnover[is.na(version3$turnover)] <- version3$vat[is.na(version3$turnover)]

## -----------------------------------------------------------------------------
cells(input = original, cleaned = version2, imputed = version3)

## -----------------------------------------------------------------------------
cells(input = original, cleaned = version2, imputed = version3
    , compare="sequential")

## -----------------------------------------------------------------------------
version4 <- version3
version4$turnover[is.na(version4$turnover)] <- median(version4$turnover, na.rm=TRUE)

# from kEUR to EUR
version5 <- version4
version5$staff.costs <- version5$staff.costs * 1000

## -----------------------------------------------------------------------------
out <- cells(input = original
           , cleaned = version2
           , vat_imp = version3
           , med_imp = version4
           , units   = version5)
par(mfrow=c(2,1))
barplot(out)
plot(out)

## -----------------------------------------------------------------------------
rules <- validator(other.rev >= 0
                 , turnover >= 0
                 , turnover + other.rev == total.rev
)

comparison <- compare(rules
                    , input = original
                    , cleaned = version2
                    , vat_imp = version3
                    , med_imp = version4
                    , units   = version5)
comparison

## -----------------------------------------------------------------------------
par(mfrow=c(2,1))
barplot(comparison)
plot(comparison)

## ---- eval=FALSE--------------------------------------------------------------
#  ## Contents of clean_supermarkets.R
#  library(validate)
#  
#  # 1. simulate reading data
#  data(SBS2000)
#  spm <- SBS2000[c("id","staff","turnover","other.rev","total.rev")]
#  
#  # 2. add a logger from 'validate'
#  start_log(spm, logger=lbj_cells())
#  
#  # 3. assume empty values should be filled with 0
#  spm <- transform(spm, other.rev = ifelse(is.na(other.rev),0,other.rev))
#  
#  # 4. assume that negative amounts have only a sign error
#  spm <- transform(spm, other.rev = abs(other.rev))
#  
#  # 5a. ratio estimator for staff conditional on turnover
#  Rhat <- with(spm, mean(staff,na.rm=TRUE)/mean(turnover,na.rm=TRUE))
#  
#  # 5b. impute 'staff' variable where possible using ratio estimator
#  spm <- transform(spm, staff = ifelse(is.na(staff), Rhat * turnover, staff))
#  
#  # 6. write output
#  write.csv(spm, "supermarkets_treated.csv", row.names = FALSE)

## -----------------------------------------------------------------------------
library(lumberjack)
run_file('clean_supermarkets.R')

## -----------------------------------------------------------------------------
logfile <- read.csv("spm_lbj_cells.csv")

## -----------------------------------------------------------------------------
logfile[3:4,]

## ---- eval=FALSE--------------------------------------------------------------
#  ## Contents of clean_supermarkets2.R
#  library(validate)
#  
#  #1.a simulate reading data
#  data(SBS2000, package="validate")
#  spm <- SBS2000[c("id","staff","other.rev","turnover","total.rev")]
#  
#  # 1.b Create rule set
#  rules <- validator(staff >= 0, other.rev>=0, turnover>=0
#                   , other.rev + turnover == total.rev)
#  
#  
#  # 2. add two loggers
#  start_log(spm, logger=lbj_cells())
#  start_log(spm, logger=lbj_rules(rules))
#  
#  ## The rest is the same as above ...

## -----------------------------------------------------------------------------
run_file("clean_supermarkets2.R")

## -----------------------------------------------------------------------------
read.csv("spm_lbj_rules.csv")[3:4,]

## ---- eval=FALSE--------------------------------------------------------------
#  stop_log(spm, logger="lbj_rules",file="my_output.csv")

## ---- include=FALSE-----------------------------------------------------------
source("chunk_opts.R")

