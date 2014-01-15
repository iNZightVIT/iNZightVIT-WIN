## latticist: a Lattice-based exploratory visualisation GUI
##
## Copyright (c) 2008 Felix Andrews <felix@nfrac.org>
## GPL version 2 or newer

writeCallAndRef <- function(plotCall, plotNum)
{
  plotStr <- deparse(plotCall, control = NULL, width = 500)
  plotStr <- toString(paste(plotStr, collapse = ""),
                      width = 44)
  cat("\\code{", sanitize(plotStr, fancy.tilde = TRUE),
      "}", "\n", sep = "")
#  cat("\\verb#", plotStr, "#", "\n", sep = "")
  cat("$\\to$~\\emph{p.}~\\pageref{code:", plotNum, "}",
      "\n", sep = "")
  cat("\\label{plot:", plotNum, "}", "\n", sep = "")
  cat("\n")
}

writePlotCallsAppendix <- function(plotCalls)
{
    for (i in seq_along(plotCalls)) {
        x <- plotCalls[[i]]
        txt <- deparse(x, control = NULL, width = 500)
        txt <- sub('^ +', '', txt) ## strip leading spaces
        txt <- paste(txt, collapse = " ")
        cat(paste("\\subsection{", i, "}", sep = ""),
            "\\begin{frame}[fragile]",
            "\\frametitle{Appendix: Code}",
            paste("\\label{code:", i, "}", sep = ""),
            paste("Code to produce the plot on ",
                  "page~\\pageref{plot:", i, "}:", sep = ""),
            "\\smallskip",
            "",
#  cat("\\noindent")
            paste("\\code{",
                  sanitize(txt),
                  "}", sep = ""),
#            "\\begin{Schunk}",
#            "\\begin{Soutput}",
#            paste(deparse(x, control = NULL, width = 32),
#                  collapse = "\n"),
#            "\\end{Soutput}",
#            "\\end{Schunk}",
            "\\end{frame}",
            "",
            sep = "\n")
    }
}

## copied from xtable:::print.xtable (xtable_1.5-4)
## by David Dahl
sanitize <- function(str, fancy.tilde = FALSE) {
    result <- str
    result <- gsub("\\\\", "SANITIZE.BACKSLASH", result)
    result <- gsub("$", "\\$", result, fixed = TRUE)
    result <- gsub(">", "$>$", result, fixed = TRUE)
    result <- gsub("<", "$<$", result, fixed = TRUE)
    result <- gsub("|", "$|$", result, fixed = TRUE)
    result <- gsub("{", "\\{", result, fixed = TRUE)
    result <- gsub("}", "\\}", result, fixed = TRUE)
    result <- gsub("%", "\\%", result, fixed = TRUE)
    result <- gsub("&", "\\&", result, fixed = TRUE)
    result <- gsub("_", "\\_", result, fixed = TRUE)
    result <- gsub("#", "\\#", result, fixed = TRUE)
    result <- gsub("^", "\\verb|^|", result, fixed = TRUE)
    if (fancy.tilde) {
        result <- gsub("~", "$\\sim$", result, fixed = TRUE)
    } else {
        result <- gsub("~", "\\~{}", result, fixed = TRUE)
    }
    result <- gsub("SANITIZE.BACKSLASH", "$\\backslash$",
                   result, fixed = TRUE)
    return(result)
}

