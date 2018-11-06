# Split training and testing
set.seed(2018)
train.pct <- 0.7

# Get training index
idx.train <- sample(1:nrow(dat), round(nrow(dat)*train.pct), replace = FALSE)

# Split data
ytrain <- dat$y_col_name[idx.train]
ytest <- dat$y_col_name[-idx.train]
dat$y_col_name <- NULL
xtrain <- dat[idx.train, ]
xtest <- dat[-idx.train, ]

