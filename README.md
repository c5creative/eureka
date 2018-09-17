# eureka
Collection of useful bits used to elucidate pesky little mysteries

## NGS / RNA-Seq

### Mapped reads dissapear when counting reads (HT-Seq, FeatureCouts)
- https://www.biostars.org/p/117363/
- https://www.biostars.org/p/110352/

## Batch effects in RNA-Seq

From Michael Love (DESeq2) - https://support.bioconductor.org/p/76099/

Batch effects are gene-specific, and DESeq2 fits gene-specific coefficients for the batch term. If you want to get an idea how much batch variability contributes to a PCA plot, I've recommended the following approach on the support site before: variance stabilize the counts, apply limma's removeBatchEffect to assay(vsd), then use plotPCA to plot the residuals.

```
# Make some simulated data with a batch effect:
dds <- makeExampleDESeqDataSet(betaSD=1,interceptMean=10)
dds$batch <- factor(rep(c("A","B"),each=6))

# VST, remove batch effect, then plotPCA:

vsd <- vst(dds)
plotPCA(vsd, "batch")
assay(vsd) <- limma::removeBatchEffect(assay(vsd), vsd$batch)
plotPCA(vsd, "batch")
```
