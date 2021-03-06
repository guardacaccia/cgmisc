% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/get.erv.r
\name{get.erv}
\alias{get.erv}
\title{Get endogenous retroviral sequences in canine genome}
\usage{
get.erv(chr = NA, coords = c(NA, NA), src = "canFam3cgmisc.db")
}
\arguments{
\item{chr}{chromosome, e.g. "chr17",}

\item{coords}{a vector of coordinates,}

\item{src}{source database, currently only canFam3 is supported.}
}
\value{
a dataframe containing the following columns: id, chromosome, strand, start, end, length, score, subgenes (names)
}
\description{
Returns a list of endogenous retroviral sequences (ERV) in a predefined chunk of the canine genome.
}
\examples{
\dontrun{get.erv("chr16", coords=c(1e6,2e6))
 }
}
\author{
Marcin Kierczak <\email{Marcin.Kierczak@imbim.uu.se}>, Patric Jern <\email{Patric.Jern@imbim.uu.se}>
}
\keyword{ERV}
\keyword{get,}

