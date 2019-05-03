# UMAP testing
# 
iris.data = iris[, grep("Sepal|Petal", colnames(iris))]
iris.labels = iris[, "Species"]

library(umap)

iris.umap = umap(iris.data)
