# https://www.r-bloggers.com/upgrade-r-without-losing-your-packages/


# save old packages -------------------------------------------------------

tmp <- installed.packages()
installedpkgs <- as.vector(tmp[is.na(tmp[,"Priority"]), 1])
save(installedpkgs, file="installed_old.rda")


# reinstall after R update ------------------------------------------------

tmp <- installed.packages()
installedpkgs.new <- as.vector(tmp[is.na(tmp[,"Priority"]), 1])
load('./installed_old.rda')
missing <- setdiff(installedpkgs, installedpkgs.new)
install.packages(missing)
update.packages()


# reload from bioconductor ------------------------------------------------

chooseBioCmirror()
load("installed_old.rda")
tmp <- installed.packages()
installedpkgs.new <- as.vector(tmp[is.na(tmp[,"Priority"]), 1])
missing <- setdiff(installedpkgs, installedpkgs.new)
for (i in 1:length(missing)) BiocManager::install(missing[i])
