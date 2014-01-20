\name{NEWS}
\title{NEWS file for the iNZightRegression package}
\encoding{UTF-8}

\section{Changes in version 0.0.2-20130122}{
  \subsection{NEW FEATURES}{
    \itemize{
      \item First release of new package. Contains model fitting subset
      used for the 'iNZight' package.
  
      \item Added 'histogramArray' and 'qqplotArray' plots to show how
      residuals from a model compare to the residuals *generated* from
      that model.
  
      \item New margin of error calculation functions. Initially written
      by Danny Chang. Used for comparison between levels of a
      factor. 'moecalc' has a few standard methods that can be used:
      'print', 'plot', and 'summary'. In addition, a 'multicomp' method
      has been added which is a useful tabulation of multiple comparison
      output. Note however with 'multicomp' that the p-values are
      currently *unadjusted*.
  
      \item New summary output, 'iNZightSummary'. Includes several changes
      compared to the R-base model summary output. These include the
      following:
  
      \itemize{
  
        \item Now showing the factor itself in the output, not just rows
        for coefficients for levels of the factor.
  
        \item When a factor is included in a model, the summary output
        will show the name of the factor and show the p-value for the
        factor (based on Type-III sums of squares). This p-value is not
        affected by further use of the factor (i.e. in an
        interaction). Sometimes this p-value cannot be calculated
        (i.e. when there are unobserved factor level combinations) and the
        p-value will be omitted.
  
        \item The baseline level of a factor is now shown, with an
        estimate of 0.
  
        \item All p-value output for levels of a factor is indented to the
        right by two characters to distinguish it from being a level.
  
        \item The output for each factor level is now just the level name
        and not the name of the variable concatenated with the level
        name. The level name is also indented by two characters, again to
        distinguish it from the variable itself.
  
        \item Removing F-statistic and associated p-value as it's mostly
        useless. It only shows us whether nothing is correlated with the
        response variable, i.e. whether we're completely wasting our time.
  
        \item Removed model call output and residual output. Replaced with
        "Model for:" (plus response name).
  
      }
  
      \item Added a new 'plot.lm' function. The main difference being that
      it includes bootstrapped smoothers in its output as well as the
      regular trend lines. Also includes plots based on the 's20x'
      package's 'normcheck' function.
  
      \item Added partial residual plots. Most useful for determining
      whether the inclusion of a transformation of a variable is
      necessary. For example, adding a logged or polynomial explanatory
      variable to the model.
  
      \item Adding bootstrapped estimates to 'iNZightSummary'. Accessed by
      calling the function with 'method="bootstrap"'.

    }
  }
  \subsection{BUG FIXES}{
    \itemize{
      \item Using 'loess' for smoothers instead of 'lowess' (newer and
      more robust).
    }
  }
}
