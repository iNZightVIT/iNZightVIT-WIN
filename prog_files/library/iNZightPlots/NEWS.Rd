\name{NEWS}
\title{NEWS file for the iNZightPlots package}
\encoding{UTF-8}

\section{Changes in Version 1.0.3}{
  \subsection{BUG FIXES}{
    \itemize{
      \item specifying `g2.level` with numbers wasn't working, has been fixed for plots,
      summary and inference information.

      \item added more space to the y-axis on scatter plots
    }
  }
}

\section{Changes in Version 1.0.2}{
  \subsection{BUG FIXES}{
    \itemize{
      \item An error where the response was printed instead of the
      x-variable name in summary output for quadratic curves has been
      fixed.
    }
  }
}


\section{Changes in Version 1.0.1}{
  \subsection{MINOR CHANGES}{
    \itemize{
      \item The type of plot used can be specified by setting the
      `largesample` argument. When set to `TRUE`, it uses the histogram
      or grid-density plot; when `FALSE` it uses the dotplot or scatter
      plot. If set to `NULL`, it uses the sample size to determine which
      plot to draw (default).

      \item To allow identification features and any additional features
      to be added to plots afterwards, the last viewport is the one
      surrounding the main plot (excluding the plot labels and
      legend). Note that this only works if the data haven't been broken
      down by `g1`.

      \item Display which variables cannot be plot due to too many
      levels, as well as the number of levels, when attempting to draw
      bar plot. (max levels = 101).

      \item Trend lines and smoothers added to the legend.

      \item Alternative method of shading grid-tiles on the grid-density
      plot using quantiles rather than absolute counts. This prevents
      large counts having too large of an influence.
    }
  }

  \subsection{BUG FIXES}{
    \itemize{
      \item A bug where the grid-density plot is not using the correct scale
      has been fixed.
    }
  }
}




\section{MAJOR RELEASE VERSION 1.0.0}{
  \itemize{
    \item New major release of iNZightPlots released, completely rewritten
    using `grid`.
  }
}