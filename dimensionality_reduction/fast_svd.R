# a fast implementation of PCA for calculating the first several, but not all, PCs.
# see https://stats.stackexchange.com/questions/134282/relationship-between-svd-and-pca-how-to-use-svd-to-perform-pca
# for math

fast.pca <- function(data, n.pc = 2, scale = TRUE) {
  # data is sample by variable
  # n.pc is number of PCs to be calculated
  # return a list, with PCs res$x
  res <- list()
  res$center <- apply(data, 2, mean)
  res$scale <- apply(data, 2, sd)
  # we must center the data for quick calculation
  data <- sweep(data, 2, res$center, FUN = '-')
  # scale the data
  if (scale == TRUE) {
    data <- sweep(data, 2, res$scale, FUN = '/')
  }

  # svd
  # calculate the first pcs
  data.svd <- svd(data, nu = n.pc, nv = 0)
  res$x <- data.svd$u %*% diag(data.svd$d[1:n.pc])

  return(res)
}



data <- matrix(rnorm(100), nrow = 20, ncol = 5)
tmp1 <- fast.pca(data)
tmp1$center
tmp1$scale
tmp1$x
plot(tmp1$x)

tmp2 <- prcomp(data, center = TRUE, scale. = TRUE)
tmp2$center
tmp2$scale
tmp2$x
plot(tmp2$x[, 1:2])

n <- 1000
p <- 5000
data <- matrix(rnorm(n*p), nrow = n, ncol = p)
system.time(fast.pca(data))
system.time(prcomp(data, center = TRUE, scale. = TRUE))
