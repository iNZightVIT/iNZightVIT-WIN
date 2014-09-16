\name{NEWS}
\title{NEWS file for the iNZightModules package}
\encoding{UTF-8}

\section{Changes in version 1.0.4}{
  \subsection{MINOR CHANGES}{
    \itemize{
      \item along with change in iNZightTS, allow x-label on more plots
    }
  }
}

\section{Changes in version 1.0.3}{
  \subsection{NEW FEATURES}{
    \itemize{
      \item the pairs plot, or scatter plot matrix, now takes a grouping
      variable.

      \item  2-variable explore plots in the Quick Explore menu
    }
  }
  
  \subsection{MINOR CHANGES}{
    \itemize{
      \item Changes to the time series module to allow specification of
      multiplicative time series models.

      \item Add y-axis label functionality.
    }
  }
}

\section{Changes in version 1.0.2}{
  \subsection{MINOR CHANGES}{
    \itemize{
      \item the pairs/scatter plot matrix draws a jittered dotplot rather than a 
      barcode plot.
    }
  }
}

\section{Changes in version 1.0.1}{
  Minor changes in package information and structure.
}

\section{Changes in version 1.0.0}{
  This is the first release of this package, although it was previously
  bundled inside the iNZight package. 
  
  \subsection{MAJOR CHANGES}{
    \itemize{

      \item The model fitting module:
      \itemize{
	\item Rewritten in `gWidgets2`

	\item Allows users to specify general linear models, and survey
	designs for analysis of survey data.

	\item Users can change the data type from numeric <->
	categorical.

	\item Confounding variables can be specified separately.

	\item Probably quite a few other changes \ldots
      }

      \item Time series module rewritten in `gWidgets2`

      \item Multiple Response module rewritten in `gWidgets2`

      \item 3D scatter plot and comparison matrix plot have both been
      rewritten in `gWidgets2`.
      
    }
  }
}