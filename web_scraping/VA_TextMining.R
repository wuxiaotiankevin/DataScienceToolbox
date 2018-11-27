# Text Mining
# by Kevin with guidence from Mike
# 20150827

setwd('D:/Brown/2015_Summer/TextMining')

# Set key words
# Case insensitive
# This is the disease of interest
keyword1 <- "colon cancer"
keyword2 <- "aids"
# Banks
# Mental health
bank1 <- c("depression",
           "eating disorder",
           "bipolar",
           "PTSD",
           "post-traumatic"
)
# Cardiovascular
bank2 <- c("defibrillator",
           "angina",
           "stroke")
# Infectious diseases
bank3 <- c("AIDS",
           "HIV",
           "influenza",
           "zoster")


# Function for keyword search

# searchkw <- function(keyword1, keyword2, bank1, bank2, bank3) {

# Create search url
keyword <- paste(gsub(" ", "+",  keyword1), "OR", 
                 gsub(" ", "+",  keyword2), sep="+")
url <- paste("https://clinicaltrials.gov/ct2/show?term=", 
             keyword, "&rank=0", sep="")

# Get total number of the search with the keywords
res1 <- scan(url, what="", sep="\n")
idx <- grep('results-summary', res1, fixed=TRUE)
totnum <- gsub("<[^<>]*>", "", res1[idx])
totnum <- gsub("for:", "", gsub("[^f]*of", "", totnum), fixed=T)
totnum <- as.numeric(totnum)

# Convert bank to lower case
bank1 <- tolower(bank1)
bank2 <- tolower(bank2)
bank3 <- tolower(bank3)

out <- data.frame()

# Extract information from each clinical trial
for (i in 1:totnum) {
  # Update url
  url <- sub(paste("rank=", i-1, sep="") , paste("rank=", i, sep="") , url)
  # Create the two urls needed
  urlstudy <- sub("show?", "show/study?", url)
  urlrecord <- sub("show?", "show/record?", url)
  try({
    study <- scan(urlstudy, what="", sep="\n")
    record <- scan(urlrecord, what="", sep="\n")
    #       Sys.sleep(1)
  })
  # Name of study
  idx <- grep('<title>', study, fixed=T)
  name <- gsub("<[^<>]*>", "", study[idx])
  name <- sub("^ *", "", name)
  name <- sub(" - Full Text View - ClinicalTrials.gov", "", name)
  #     nameout <- c(nameout, name)
  
  # Clinical trials identifier
  idx <- grep('<div class="identifier">', study, fixed=TRUE)
  ctid <- gsub("<[^<>]*>", "", study[idx])
  ctid <- gsub("^ *", "", ctid)
  #     ctidout <- c(ctidout, ctid)
  #   if (length(ctid) == 0) {ctidout <- c(ctidout, "NA")}
  
  # Status
  idx <- grep('recruiting-status', study, fixed=TRUE)
  status <- gsub("^ *", "", study[idx+1])
  
  # Sample size
  idx <- grep('<td headers="enrollmentInfoData" style="padding-left:1em">', study, fixed=TRUE)
  sampsiz <- gsub("<[^<>]*>", "", study[idx]) 
  if (length(sampsiz)==0) {sampsiz <- "NA"}
  sampsiz <- gsub("^ *", "", sampsiz)[1]
  if (attr(regexpr(' ', sampsiz, fixed=TRUE), "match.length")==1) {sampsiz <- "NA"}
  
  # Enrollment, Study Start Date, Primary Completion Date, and Study Completion Date
  idx <- grep('Enrollment:</td>', study, fixed=TRUE)
  enroll <- gsub("<[^<>]*>", "", study[idx+1])
  enroll <- gsub("^ *", "", enroll)
  if (length(enroll)==0) {
    enroll <- 'NA'
  }
  
  idx <- grep('Study Start Date:</td>', study, fixed=TRUE)
  start_date <- gsub("<[^<>]*>", "", study[idx+1])
  start_date <- gsub("^ *", "", start_date)
  if (length(start_date)==0) {
    start_date <- 'NA'
  }
  
  idx <- grep('Primary Completion Date:</td>', study, fixed=TRUE)
  prim_comp_date <- gsub("<[^<>]*>", "", study[idx+1])
  prim_comp_date <- gsub("^ *", "", prim_comp_date)
  if (length(prim_comp_date)==0) {
    prim_comp_date <- 'NA'
  }
  
  idx <- grep('Study Completion Date:</td>', study, fixed=TRUE)
  study_comp_date <- gsub("<[^<>]*>", "", study[idx+1])
  study_comp_date <- gsub("^ *", "", study_comp_date)
  if (length(study_comp_date)==0) {
    study_comp_date <- 'NA'
  }
  
  # Veterans or not?
  veteran <- sum(attr(regexpr("Veterans Affairs", study, fixed=TRUE), "match.length")!=-1)!=0
  
  # Results or not?
  results <- sum(attr(regexpr("No Study Results Posted", study, fixed=TRUE), "match.length")!=-1)==0

  # Keyword bank search in inclusion criteria
  idx11 <- grep('<!-- eligibility_section -->', study, fixed=TRUE)
  idx21 <- grep('<!-- location_section -->', study, fixed=TRUE)
  idx12 <- grep('Inclusion Criteria:</p>', study, fixed=TRUE)
  idx22 <- grep('Exclusion Criteria:</p>', study, fixed=TRUE)
  
  eligsec <- tolower(study[max(idx11, idx12):min(idx21, idx22)])
  bankser <- numeric()
  
  for (j in 1:length(bank1)) {
    bankser <- c(bankser, as.numeric(sum(attr(regexpr(bank1[j], 
                                                      eligsec, fixed=TRUE), "match.length")!=-1)!=0))
  }
  
  for (j in 1:length(bank2)) {
    bankser <- c(bankser, as.numeric(sum(attr(regexpr(bank2[j], 
                                                      eligsec, fixed=TRUE), "match.length")!=-1)!=0))
  }
  
  for (j in 1:length(bank3)) {
    bankser <- c(bankser, as.numeric(sum(attr(regexpr(bank3[j], 
                                                      eligsec, fixed=TRUE), "match.length")!=-1)!=0))
  }

  out <- rbind(out, cbind(ctid, name, t(bankser), sampsiz, status, enroll, start_date, prim_comp_date, study_comp_date, veteran, results))
}

colnames(out)[1:2] <- c("Clinical Trial ID", "Name")
colnames(out)[3:(2+length(bank1))] <- bank1
colnames(out)[(3+length(bank1)):(2+length(bank1)+length(bank2))] <- bank2
colnames(out)[(3+length(bank1)+length(bank2)):
                (2+length(bank1)+length(bank2)+length(bank3))] <- bank3
colnames(out)[3+length(bank1)+length(bank2)+length(bank3)] <- "Sample Size"
colnames(out)[4+length(bank1)+length(bank2)+length(bank3)] <- "Status"
colnames(out)[5+length(bank1)+length(bank2)+length(bank3)] <- "Enrollment"
colnames(out)[6+length(bank1)+length(bank2)+length(bank3)] <- "Study Start Date"
colnames(out)[7+length(bank1)+length(bank2)+length(bank3)] <- "Primary Completion Date"
colnames(out)[8+length(bank1)+length(bank2)+length(bank3)] <- "Study Completion Date"
colnames(out)[9+length(bank1)+length(bank2)+length(bank3)] <- "Veteran"
colnames(out)[10+length(bank1)+length(bank2)+length(bank3)] <- "Results"

#   return(out)
# }

out <- searchkw(keyword1, keyword2, bank1, bank2, bank3)

write.csv(out, 'output2.csv', row.names=FALSE)
