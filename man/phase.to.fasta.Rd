% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/phase.to.fasta.r
\name{phase.to.fasta}
\alias{PHASE.to.FASTA}
\alias{PHASE2FASTA}
\alias{phase.to.fasta}
\alias{phase2fasta}
\title{Converts haplotypes from PHASE output to FASTA format.}
\usage{
phase.to.fasta(input, output = NULL, filter = NULL)
}
\arguments{
\item{input}{output from PHASE (.out file),}

\item{output}{output filename (optional).}
}
\description{
Returns a FASTA file with all PHASE-derived haplotypes.
}
\examples{
\dontrun{
 con <- "~/Research/Behavior/results/2014-02-11_mh_aggr_chr36.phase.out"
 phase2fasta(input=con)
}
}
\author{
Marcin Kierczak \email{Marcin.Kierczak@imbim.uu.se}
}
\keyword{fasta,}
\keyword{gwas,}
\keyword{p-values}

