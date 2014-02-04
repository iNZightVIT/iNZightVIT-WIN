\name{NEWS}
\title{NEWS file for the iNZightPlots package}
\encoding{UTF-8}

\section{Changes in version 1.0.1}{
  \subsection{MAJOR CHANGES}{
    \item It is now possible to plot all levels of both subsetting
    variables against each other in a matrix, allowing all
    combinations to be seen in a single plot.
  }

  \subsection{MINOR CHANGES}{
    \item Quantile smoothers can be added using the `quant.smooth`
    argument. This adds 50th, 25th, and 10th percentile smoothers to
    plots, dependent on the sample size.
  }
}

\section{Changes in version 1.0.0}{
  \subsection{MAJOR CHANGES}{
    \itemize{

      \item The plotting functionality has been rewritten in a
      standalone pacakge.

      \item Plots are now using the `grid` package.

      \item New behaviour for large sample sizes. For univariate data,
      histograms are used instead of dot plots; for bivariate
      (numeric) data, grid-density plots are drawn instead of
      scatterplots.

      
      
    }
  }
}

  \subsection{MINOR CHANGES}{
    \itemize{

      \item Grid lines have been added to inference information on
      dotplots and bar plots.
      
      \item Bar plots of two variables now have their bars widths
      proportional to the sample size, known also as a spine plot.
      
      \item Transparency can be altered for scatterplots and dot
      plots. For large sample sizes, this affects the scale of contract
      between low and high density cells in the grid-density plot.      
    }
  }
}

\section{OLD VERSION UPDATES}{
  The `iNZightPlots` code was originally bound with the `iNZight`
  package, however has now been separated.

  The following update history has been included as much of it has some
  significance to the plotting functionality rather than the GUI.
}

\section{Changes in version 1.0.2-20130913}{
  \subsection{BUG FIXES}{
    \itemize{

      \item Bugfix for boxplots with Year 12 Inference bars. They were
      previously being calculated with an `n` equal to the population,
      not the sample size of each group. Thanks for Derek Smith for
      reporting the bug, this evidently been in iNZight for a long
      time.

    }
  }
}

\section{Changes in version 1.0.2-20130306}{
  \subsection{MINOR CHANGES}{
    \itemize{

      \item Using 'fivenum' for quartiles instead of 'summary'. This
      will produce correct output instead of a close approximation.

    }
  }
}

\section{Changes in version 1.0.2-20130227}{
  \subsection{MINOR CHANGES}{
    \itemize{

      \item When using 'Get Summary' or 'Get Inference', use 5
      significant figures, instead of rounding to a number of decimal
      places.

    }
  }
}

\section{Changes in version 1.0.2-20130122}{
  \subsection{NEW FEATURES}{
    \itemize{

      \item Model fitting functionality largely broken off into a new
      package: 'iNZightRegression'. 'iNZightRegression' aims to make all
      of the model fitting functionality easily available in an R
      console.

      \item Use new 'iNZightSummary' function for summary
      output. Intended for use as a direct replacement for
      'print.summary'. (From 'iNZightRegression')

      \item When using 'Get Inference', now also show an
      F-statistic. Also shows the degrees of freedom and the associated
      p-value.

      \item Removed 'Anova', 'Goodness of Fit', 'Drop Observations', and
      'Prediction' from model fitting.

      \item Adding partial residual plots. (From 'iNZightRegression')

      \item Adding modified 'plot.lm' plots. Adds bootstrap smoothers to
      the plots. (From 'iNZightRegression')

      \item Adding 'histogramArray' and 'qqplotArray' functions to show
      the differences between residuals in our data and residuals
      *randomly generated* from our model.

      \item Removed added effects plots, removes dependency on 'effects'
      package.

      \item Adding margin of error plots, along with associated multiple
      pairwise comparison output. These are accessed via the 'Factor
      Levels' menu.

    }
  }
  \subsection{BUG FIXES}{
    \itemize{

      \item Ensure 'gWidgets' is using the 'RGtk2' toolkit.

    }
  }
}

\section{Changes in version 1.0.2-20121109}{
  \subsection{BUG FIXES}{
    \itemize{

      \item 'gpairs' wasn't loading the 'barcode' dependency
      correctly. As a result we now explicity load the 'barcode'
      package. This fixes scatter plots with a mixture of continuous and
      categorical variables.

      \item When producing bootstrap inferences on two variables (1
      cont, 1 cat), the estimate of the median was erroneously using the
      mean. Reported by Jim Hogan.

    }
  }
}

\section{Changes in version 1.0.2-20121008}{
  \subsection{NEW FEATURES}{
    \itemize{

      \item Added updating mechanism to keep iNZight up to date without
      grabbing the entire distribution. This can be called by running
      'updateiNZight()'. The iNZightVIT distribution does include a
      script 'UPDATE_iNZightVIT.bat' ('UPDATE_iNZightVIT.command' for
      OSX) to automate this task.

      \item Added a new function 'iNZightBugReport()', which
      provides instructions for creating a bug report.

      \item Version strings are tagged with a date. This is exposed in
      the main window title.

    }
  }

  \subsection{MISC}{
    \itemize{

      \item Reworked the dependency structure of iNZight. This should
      make it slightly faster to load and prints less to the console.

    }
  }

  \subsection{BUG FIXES}{
    \itemize{

      \item Exporting data now uses the correct output formats.

      \item Because of the alpha bug with the 'windows()' device, use
      opaque lines for the 'Compare Series' Time Series feature
      (equivalent in colour to a single line previously).

    }
  }
}

\section{Changes in version 1.0.2-20120822}{
  \subsection{NEW FEATURES}{
    \itemize{

      \item Better handling of large datasets. The data-view is now
      disabled in favour of variable-view only from 200,000 cells.

      \item Added a data reshaping function (from columns per group to
      cases by variable) to "Manipulate variables".

    }
  }
}

\section{Changes in version 1.0.2-20120725}{
  \subsection{NEW FEATURES}{
    \itemize{
      \item A Time Series module added to iNZight (under Advanced).
    }
  }
}

\section{Changes in version 1.0.2-20120417}{
  \subsection{BUG FIXES}{
    \itemize{
      \item Various fixes.
    }
  }
}