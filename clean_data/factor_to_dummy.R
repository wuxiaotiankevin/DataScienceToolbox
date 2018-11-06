# Convert factor to dummy
library(fastDummies)

# Get dummy for factor columns
dat <- fastDummies::dummy_cols(dat)

# Drop factor columns
idx.drop <- which(sapply(dat, class)=='factor')
dat <- dat[, -idx.drop]
