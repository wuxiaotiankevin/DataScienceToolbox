# download pdf in a page
url <- 'https://cs.brown.edu/courses/csci1270/lectures.html' # target url
odir <- 'D:/Dropbox (Brown)/2018Spring/SLBD/sql/' # output folder

# get right lines on page source
x <- scan(url, what="", sep="<")
these <- grep('.pdf', x, fixed=T)
x <- x[these]

# get pdf urls
idstart <- regexpr('/static/files', x, fixed=T)
idend <- regexpr('.pdf', x, fixed=T)
pdfu <- substr(x, idstart, idend+3)
baseUrl <- "https://cs.brown.edu/courses/csci1270"
pdfu <- paste0(baseUrl, pdfu)
  
# get file names
filenames <- strsplit(pdfu, '/')
for (i in 1:length(filenames)) {
  filenames[[i]] <- filenames[[i]][length(filenames[[i]])]
}

# download files
for (i in 1:length(pdfu)) {
  # download.file(pdfu[[i]], paste0(odir, filenames[[i]]), mode="wb")
  download.file(pdfu[[i]], paste0(odir, sprintf("%02d", i), filenames[[i]]), mode="wb")
}
