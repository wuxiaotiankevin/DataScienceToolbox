import numpy as np
import pandas as pd
import xgboost as xgb

## run XGB
xg_train = xgb.DMatrix( Xtrain, label = Ytrain , missing=np.nan)
xg_test = xgb.DMatrix( Xtest , missing=np.nan)

# parameters
param = {'objective': 'multi:softprob', 'num_class': len(outputs), 'eval_metric': 'mlogloss', 'silent': 1}
param['eta'] = 0.06; param['max_depth'] = 3; param['min_child_weight'] = 12;
param['subsample'] = 0.85; param['colsample_bytree'] = 0.9;
num_round = 700

cv_fold = 3
bst_cv = xgb.cv(param, dtrain = xg_train, num_boost_round = num_round, 
                nfold = cv_fold, early_stopping_rounds=10, verbose_eval = True)

num_round = bst_cv.shape[0]
print 'Best num_round: ' + str(num_round)

# predict
bst = xgb.train(param, xg_train, num_round)
pred_xgb = bst.predict( xg_test ).reshape( Xtest.shape[0], len(outputs))

# get variable importance
fs = bst.get_fscore()
fsdf = pd.DataFrame.from_dict(fs.items())
fsdf.sort_values(by = 1, ascending = False, inplace = True)
fsdf.replace({'f': ''}, regex=True, inplace = True)
fsdf.ix[:, 0] = pd.to_numeric(fsdf.ix[:, 0])
fsdf.sort_values(by = 0, ascending = False)
fsdf.reset_index(inplace = True)
