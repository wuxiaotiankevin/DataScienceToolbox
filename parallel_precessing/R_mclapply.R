library(parallel)

tmp <- mclapply(1:runs, function(x) estOne(dat[, x]), mc.cores=cores)
out <- simplify2array(tmp)