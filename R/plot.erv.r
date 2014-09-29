##' @title Plot endogenous retroviral sequences in canine genome.
##' 
##' @description Plot endogenous retroviral sequences (ERV) in canine genome.
##' @author Marcin Kierczak <\email{Marcin.Kierczak@@imbim.uu.se}>, Patric Jern <\email{Patric.Jern@@imbim.uu.se}>
##' @param chr chromosome, e.g. "chr17", 
##' @param coords a vector of coordinates,
##' @param src source database, currently only canFam3 is supported,
##' @param scale scaling factors for x and y axis.
##' @details Plots -log10(score) on the y axis (the higher the score is, the more probable that the hit represents an actual ERV)
##' and coordinates in Mbp on the x axis. Width of the bars covers entire ERV. 
##' @return null 
##' @examples
##'  \dontrun{plot.erv("chr16", coords=c(1e6,2e6))
##'  }
##' @keywords plot, ERV
##' @export

plot.erv <- function(chr=NA, coords=c(NA,NA), src="canFam3cgmisc.db", scale=c(.2,.1)) {
  require("RSQLite")
  src <- system.file("extdata", src, package = "cgmisc")
  if (is.na(chr)) {
    stop("Chromosome not valid.")
  }
  sqlite    <- dbDriver("SQLite")
  db <- dbConnect(sqlite, src)
  query <- ""
  query <- paste("SELECT * FROM ERV WHERE chromosome == '", chr, "'", sep = "")
  if (!is.na(coords[1])) {
    query <- paste(query, " AND start >= ", coords[1], sep = "")
  }
  if (!is.na(coords[2])) {
    query <- paste(query, " AND end <= ", coords[2], sep = "")
  }
  result <- dbGetQuery(db, query)
  tmp <- log10(result$score)
  my.ylim <- c(0, max(tmp) + scale[2] * max(tmp))
  my.xlim <- c(min(result$start) - scale[1]*min(result$start), max(result$end) + scale[1]*max(result$end))
  plot(0, xlim = my.xlim, ylim=my.ylim, type='n', bty='n', las=1, xaxs='i', xaxt='n', xlab="Mbp", ylab="-log10(score)")
  grid()
  p <- pretty(my.xlim)
  axis(1, at = p, labels=p/1e6)
  for (i in 1:dim(result)[1]) {
    r <- result[i,]
    polygon(c(r$start, r$end, r$end, r$start, r$start), 
            c(0,0,log10(r$score), log10(r$score), 0), col = "slateblue", border = NA)
  }
  retval <- dbDisconnect(db)
}
