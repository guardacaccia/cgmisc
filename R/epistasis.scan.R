##'@title epistasisScan
##'
##'@description Scans for epistasis between a specified SNP and all others.  
##'@param data a gwaa.data class object as used by \code{\link[GenABEL]{gwaa.data-class}}
##'@param SNP The name or index of one marker/SNP in data
##'@param trait.name The name of a phenotype in data
##'@param pheno A vector with phenotypes
##'@details The function fits a linear model, including interaction term, between SNP and all other markers in data.
##'@return a list with all the models (lm-objects), 
##'the p-values of all models and coefficients, and the genomic coordinates of all scanned SNPs.
##'@author Simon Forsberg  <\email{simon.forsberg@@slu.se}>
##'@export epistasis.scan

epistasis.scan <- function(data, SNP, trait.name = NULL, pheno = NULL){
  #Performs an interaction scan, using SNP as a covariate
  SNP.geno <- as.genotype.gwaa.data(data[,SNP])
  if(!is.null(trait.name)){
    pheno <- data@phdata[,trait.name]
  } else if(is.null(pheno)){
    stop("trait.name or pheno must be specified")
  }
  output <- list(models=list(), SNP1.p=c(), SNP2.p=c(), interaction.p=c(), model.p=c(), map=c())
  output$map <- data@gtdata@map
  
  pb <- txtProgressBar(style=3)
  for(SNP2 in 1:data@gtdata@nsnps){
    SNP2.geno <- as.genotype.gwaa.data(data[,SNP2])
    model <- lm(pheno ~ SNP.geno[,1]*SNP2.geno[,1] )
    model.sum <- summary(model)
    
    #Get the p-values
    #pVal.interaction <- anova(model)$'Pr(>F)'[3] #The p-value of the interaction term
    pVal.SNP1 <- NA
    pVal.SNP2 <- NA
    pVal.interaction <- NA
    if(nrow(model.sum$coefficients) == 4){
      pVal.SNP1 <- model.sum$coefficients[2,4]
      pVal.SNP2 <- model.sum$coefficients[3,4]
      pVal.interaction <- model.sum$coefficients[4,4]
    } else if(nrow(model.sum$coefficients) == 3){
      #print(GWASdata@gtdata@snpnames[SNP2])
      pVal.SNP1 <- model.sum$coefficients[2,4]
      pVal.SNP2 <- model.sum$coefficients[3,4]
    } else if(nrow(model.sum$coefficients) == 2){
      #print(GWASdata@gtdata@snpnames[SNP2])
      pVal.SNP1 <- model.sum$coefficients[2,4]
    }
    pVal.model <- pf(model.sum$fstatistic[1], model.sum$fstatistic[2], model.sum$fstatistic[3], lower.tail=F) #The p-value of the model
    
    #Wrap up the output
    output$models[[SNP2]] <- model
    output$SNP1.p[SNP2] <- pVal.SNP1
    output$SNP2.p[SNP2] <- pVal.SNP2
    output$interaction.p[SNP2] <- pVal.interaction
    output$model.p[SNP2] <- pVal.model
    setTxtProgressBar(pb, SNP2/data@gtdata@nsnps)
  }
  close(pb)
  return(output)
}
