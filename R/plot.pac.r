##' @title Plot p-values of allele count differences between populations.
##' 
##' @description Plots p-values of allele count differences between populations.
##' @author Marcin Kierczak <\email{Marcin.Kierczak@@imbim.uu.se}>
##' @param data an object of the \code{\link[GenABEL]{gwaa.data-class}}, 
##' @param allele.cnt an object of the \code{\link[pac.result]{pac.result-class}} class,
##' @param plot.LD a logical indicating whether LD pattern should be plotted on top of p-values (experimental),
##' @param ...
##' @details Plots p-values of allele count differences between populations.
##' @return null 
##' @examples
##'  \dontrun{
##'  }
##' @keywords plot, allele counts, populations
##' @export
plot.pac <- function(data, allele.cnt, plot.LD=FALSE,...) { 
  chromosomes <- sort(unique(as.numeric(levels(data@gtdata@chromosome))))
  if (length(chromosomes) > 1) {
    if (plot.LD) {
      warning("More than one chromosome supplied. Cannot plot LD pattern.")
      plot.LD <- F
    }
    chr.mid <- c()
    for (chr in chromosomes) {
      coord <- which(as.numeric(data@gtdata@chromosome) == chr)
      chr.mid <- get.chr.midpoints(data)
    }
    color <- (as.numeric(data@gtdata@chromosome)%% 2) + 1
    color[color == 1] <- "slateblue"
    color[color == 2] <- "grey"
    pvals <- allele.cnt@p.values
    plot(-log10(pvals), type='h', col=color, xlab="Chromosome", ylab=expression(paste(-log[10],"(p-value)")), xaxt='n', bty='n', las=2, ...)
    axis(1, at=chr.mid, labels=unique(chromosomes))
  } else {
    range <- max(data@gtdata@map) - min(data@gtdata@map) 
    if (range < 1e6) {
      divisor <- 1e3
      prefix <- "kbp"
    } else {
      divisor <- 1e6
      prefix <- "Mbp"
    }
    axis.start <- min(data@gtdata@map)
    axis.stop <- max(data@gtdata@map)
    pvals <- allele.cnt@p.values
    index.snp <- which(allele.cnt@p.values == min(allele.cnt@p.values, na.rm = T ))[1]
    # Do plotting
    plot(-log10(pvals), type='h', col="darkgrey", xlab=prefix, ylab=expression(paste(-log[10],"(p-value)")), xaxt='n', bty='n', las=2, ...)
    # Plot LD-colored points
    if (plot.LD) {
      colors <- get.LD.colors(data, chr=chromosomes[1], index.snp)
      points(-log10(pvals), col=as.character(colors[[1]]), pch=as.numeric(colors[[2]]), cex=.7)    
    }
    tmp <- seq(0,length(data@gtdata@map), by=100)
    axis(1, at=tmp, 
         labels=round(seq(axis.start,axis.stop, along.with=tmp)/divisor,digits=2))
  }
}