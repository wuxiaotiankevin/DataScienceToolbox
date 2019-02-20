library('biomaRt')
mart <- useDataset("hsapiens_gene_ensembl", useMart("ensembl"))
listAttributes(mart)

# change 'filters' for different input gene name system
# GENE_NAMES is the input, match its naming system with filters
g_list <- getBM(filters = "hgnc_symbol",
                attributes = c("ensembl_gene_id",
                               "hgnc_symbol"),
                values = GENE_NAMES, mart = mart)
