args <- commandArgs(trailingOnly = TRUE)
pca_preprocess <- args[1]
ica_preprocess <- args[2]

# nohup Rscript --no-save --no-restore --verbose R_CODE.R > R_CODE.Rout 2>&1 ARG1 ARG2 &
