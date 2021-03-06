% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/get.LD.colors.r
\name{get.ld.colors}
\alias{get.LD.colors}
\alias{get.ld.colors}
\title{Plot results of \code{get.LD.colors}}
\usage{
get.ld.colors(data, chr, index.snp, region = NULL)
}
\arguments{
\item{data}{an object of the \code{\link[GenABEL]{gwaa.data-class}}}

\item{chr}{number of chromosome of interest}

\item{index.snp}{numeric index of the index marker}

\item{region}{a region for which to obtain LD colors}

\item{wes.par}{parameters for package wesanderson}
}
\value{
a list with four vectors: 1) LD-based colors, 2) pch values, 3) color scale and 4) breakpoints.
}
\description{
Returns colour scale based on LD to a chosen index marker.
}
\examples{
\dontrun{get.LD.colors(data, chr = 38, index.snp=270)
 }
}
\author{
Marcin Kierczak <\email{Marcin.Kierczak@imbim.uu.se}>
}
\seealso{
\code{\link[cgmisc]{plot.pac}}
}
\keyword{LD,}
\keyword{colours}
\keyword{plot,}

