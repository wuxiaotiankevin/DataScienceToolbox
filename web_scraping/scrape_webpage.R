x <- scan(url, what="", sep="\n")
# remove <>
x <- gsub("<[^<>]*>", "", x)