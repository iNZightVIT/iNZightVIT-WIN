\name{NEWS}
\title{NEWS file for the iNZightPlots package}
\encoding{UTF-8}


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
    }
  }
}




\section{MAJOR RELEASE VERSION 1.0.0}{
  New major release of iNZightPlots released, completely rewritten using `grid`.
}