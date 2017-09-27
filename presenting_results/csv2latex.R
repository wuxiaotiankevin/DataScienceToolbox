library(stargazer)
# read table in
tab <- read.csv("./table1.csv")
# convert to latex format
sink("./table1.txt")
stargazer(tab,
          summary = FALSE, rownames = FALSE,
          title="Comparison between Two Representations")
sink()