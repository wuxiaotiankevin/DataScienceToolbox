# Plot ROC Curve
library(ggplot2)
library(plotROC)
library(pROC)

# ROC
dat.plt <- data.frame(y=ytest, pred=pred.test)
p1 <- ggplot(dat.plt, aes(d = y, m = pred)) + geom_roc(n.cuts = 0)
p1

# AUC
library(pROC)
roc_obj <- roc(dat.plt$y, dat.plt$pred)
auc(roc_obj)
