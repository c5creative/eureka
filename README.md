# eureka
Collection of useful bits used to elucidate pesky little mysteries

## NGS / scRNA-Seq

### Getting ZINB-WaVE and Seurat working
- Rmd - https://github.com/c5creative/eureka/blob/master/zinbwave-seurat.rmd
- KnitR - http://htmlpreview.github.io/?https://github.com/c5creative/eureka/blob/master/zinbwave-seurat.html


## NGS / RNA-Seq

### Mapped reads disappear when counting reads (HT-Seq, FeatureCouts)
- https://www.biostars.org/p/117363/
- https://www.biostars.org/p/110352/

## Batch effects in RNA-Seq

### In DESeq2
From Michael Love (DESeq2) - https://support.bioconductor.org/p/76099/

Batch effects are gene-specific, and DESeq2 fits gene-specific coefficients for the batch term. If you want to get an idea how much batch variability contributes to a PCA plot, I've recommended the following approach on the support site before: variance stabilize the counts, apply limma's removeBatchEffect to assay(vsd), then use plotPCA to plot the residuals.

```R
# Make some simulated data with a batch effect:
dds <- makeExampleDESeqDataSet(betaSD=1,interceptMean=10)
dds$batch <- factor(rep(c("A","B"),each=6))

# VST, remove batch effect, then plotPCA:

vsd <- vst(dds)
plotPCA(vsd, "batch")
assay(vsd) <- limma::removeBatchEffect(assay(vsd), vsd$batch)
plotPCA(vsd, "batch")
```

### DASC
DASC is an R package used for identifying batches and classifying samples into different batches in a high dimensional gene expression dataset. The batch information can be further used as a covariate in conjunction with other variables of interest among standard bioinformatics analysis like differential expression analysis. https://github.com/zhanglabNKU/DASC


## R

### Rtools 3.5 is incompatible with R 3.5 in Windows
Fix posted at https://community.rstudio.com/t/error-dependency-transformr-is-not-available-for-package-gganimate/11134/3
```R
# Set path of Rtools
Sys.setenv(PATH = paste(Sys.getenv("PATH"), "*InstallDirectory*/Rtools/bin/",
                       "*InstallDirectory*/Rtools/mingw_64/bin", sep = ";")) #for 64 bit version
Sys.setenv(BINPREF = "*InstallDirectory*/Rtools/mingw_64/bin")
library(devtools)

#Manually "force" version to be accepted 
assignInNamespace("version_info", c(devtools:::version_info, list("3.5" = list(version_min = "3.3.0", version_max = "99.99.99", path = "bin"))), "devtools")
find_rtools() # is TRUE now

# Now you can install transformr then gganimate
devtools::install_github("thomasp85/transformr")
devtools::install_github("dgrtwo/gganimate")
```

## Random links
* https://hbctraining.github.io/DGE_workshop/lessons/05_DGE_DESeq2_analysis2.html
* https://dwheelerau.com/2014/02/17/how-to-use-deseq2-to-analyse-rnaseq-data/
* https://drsimonj.svbtle.com/visualising-residuals


