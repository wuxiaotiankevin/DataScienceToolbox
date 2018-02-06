library(XML)
library(RCurl)

u <- "https://en.wikipedia.org/wiki/List_of_S%26P_500_companies"
xData <- getURL(u)
tabs <- readHTMLTable(xData)
sp500.names <- tabs[[1]]