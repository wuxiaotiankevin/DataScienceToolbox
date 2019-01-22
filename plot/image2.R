# plot matrix as is
image2 <- function(x, ...) {
  image(t(x)[,nrow(x):1], ...)
}
