\name{NEWS}
\title{NEWS file for the iNZightModules package}
\encoding{UTF-8}

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