# download pdf in a page
url <- 'http://www.icsa.org/icsa/publication/previous-icsa-bulletin-issues' # target url
odir <- 'C:/Users/Xiatian Wu/Downloads/' # output folder

# get right lines on page source
x <- scan(url, what="", sep="<")
these <- grep('.pdf', x, fixed=T)
x <- x[these]

# get pdf urls
idstart <- regexpr('https://icsaimage.files.', x, fixed=T)
idend <- regexpr('.pdf', x, fixed=T)
pdfu <- substr(x, idstart, idend+3)

# get file names
filenames <- strsplit(pdfu, '/')
for (i in 1:length(filenames)) {
  filenames[[i]] <- filenames[[i]][length(filenames[[i]])]
}

# download files
for (i in 1:length(pdfu)) {
  download.file(pdfu[[i]], paste0(odir, filenames[[i]]), mode="wb")
}
