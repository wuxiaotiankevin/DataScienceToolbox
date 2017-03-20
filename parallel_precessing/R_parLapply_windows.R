# parallel computing for windows machine
library(parallel)
cl <- makeCluster(getOption("cl.cores", 4))
clusterExport(cl=cl, varlist=c('var1', 'var2'), envir = environment())
out <- parLapply(cl, 1:max_idx, oneRun)
stopCluster(cl)