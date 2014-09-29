##' @title Plots LD decay pattern for a given data
##' 
##' @description Function plots the LD decay with distance between markers for a given data. 
##' LD is measured using r2 statistics.
##' @author Marcin Kierczak <\email{Marcin.Kierczak@@imbim.uu.se}>
##' @param data a  \code{\link[GenABEL]{gwaa.data-class}} object 
##' @param N number of bins used to partition the distance between markers
##' @param dmin minimal distance to consider
##' @param maximal distance to consider
##' @param ... the remaining parameters that pass to the plot function
##' @return NULL
##' @examples \dontrun{
##' dat <- dat[,dat@@gtdata@@chromosome == 3]
##' plot.LD.decay(data=dat, N=200, dmin=0, dmax=1e6, main="Chr3")
##' }
##' @keywords LD, LD decay, plot, r2
##' @export plot.LD.decay
plot.LD.decay <- function(data, N=200, dmin=NA, dmax=NA, ...){
  m <- as.matrix(data@gtdata@map)
  dm <- as.matrix(dist(m, diag=T))
  dm <- dm[upper.tri(dm)]
  r2m <- r2fast(data)
  r2m <- r2m[upper.tri(r2m)]
  # filtering
  if (!is.na(dmin) & !is.na(dmax)) {
    toKeep <- which(dm < dmax & dm > dmin) 
    dm <- dm[toKeep]
    r2m <- r2m[toKeep]
  }
  bpts <- pretty(dm, n=N)
  INDEX <- cut(dm, bpts, include.lowest = T)
  pts <- tapply(r2m, INDEX, mean)
  pts2 <- tapply(r2m, INDEX, median)
  dist <- bpts[1:length(pts)]
  plot(dist, pts, cex=.5, col='olivedrab', xlab="distance in bp", ylab="r2", type='n', las=1, bty='n', ...)
  grid()
  abline(v=seq(1,max(dist), by=1e6), lty=3, col="grey")
  points(dist, pts, type='l', cex=.5, col='olivedrab')
  points(dist, pts2, type='l', cex=.5, col='tomato')
  legend("topright", bty='n', legend=c("mean", "median"), col=c("olivedrab","tomato"), lty=1)
}