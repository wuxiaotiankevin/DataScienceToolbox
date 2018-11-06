# xgboost training

# Initialize xgboost data object
# Need xtrain, xtest to be matrices
dtrain <- xgb.DMatrix(data = xtrain, label=ytrain)
dtest <- xgb.DMatrix(data = xtest, label=ytest)

# Train with cross validation
param <- list(nthread = 2,
              max_depth = 3,
              eta = 1,
              objective = "binary:logistic",
              eval_metric = "auc",
              metrics = list("rmse","auc"))
cv <- xgb.cv(params = param,
             data = dtrain,
             nrounds = 100,
             nfold = 5,
             early_stopping_rounds = 10)
print(cv)

# Train based on CV best iteration
watchlist <- list(train = dtrain, eval = dtest)
bst <- xgb.train(param, dtrain, nrounds = cv$best_iteration, watchlist)

# Predict on test set
pred <- predict(bst, dtest)

# Importance plot
importance_matrix <- xgb.importance(colnames(xtrain), model = bst)
xgb.plot.importance(importance_matrix)
