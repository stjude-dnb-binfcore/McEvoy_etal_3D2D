#################################################################################
# This will run all scripts in the module
#################################################################################
# Load the Package with a Specific Library Path
# .libPaths("/home/user/R/x86_64-pc-linux-gnu-library/4.4")
#################################################################################
# Load library
suppressPackageStartupMessages({
  library(yaml)
  library(data.table)
  library(tidyverse)
  library(Seurat)
  library(Matrix)
  library(reticulate)
  library(gridExtra)
  library(glue)
  library(R.utils)
  library(shiny)
  library(shinyhelper)
  library(DT)
  library(magrittr)
  library(ggdendro)
  library(ShinyCell)
  library(RColorBrewer)
})

#################################################################################
# load config file
configFile <- paste0("../../project_parameters.Config.yaml")
if (!file.exists(configFile)){
  cat("\n Error: configuration file not found:", configFile)
  stop("Exit...")}

# read `yaml` file defining the `params` of the project and strategy analysis
yaml <- read_yaml(configFile)
#################################################################################
# Parameters
root_dir <- yaml$root_dir
PROJECT_NAME <- yaml$PROJECT_NAME
PI_NAME <- yaml$PI_NAME
condition_value <- yaml$condition_value
assay <- yaml$assay_filter_object

#################################################################################
# Set up directories and paths to root_dir and analysis_dir
analysis_dir <- file.path(root_dir, "analyses") 
module_dir <- file.path(analysis_dir, "rshiny-app-cclf-cell-lines") 

# Create results_dir
module_results_dir <- file.path(module_dir, "results")

results_dir <- file.path(module_results_dir, "05-generate-rshiny-app")
if (!dir.exists(results_dir)) {
  dir.create(results_dir)}

################################################################################
### library(ShinyCell) ### ### ### ### ### ### ### ### ### ### ### ### ### ### #
################################################################################
# It was downloaded from here: https://github.com/SGDDNB/ShinyCell/blob/master/R
# We modified the function to account for any type of assay
source(paste0(module_dir, "/util/makeShinyFiles_assay.R"))

################################################################################################################
cancer_names <- c("EWS", "NB", "OS", "RMS")
cancer_names <- sort(cancer_names, decreasing = FALSE)
print(cancer_names)
#cancer_names = "EWS"
################################################################################################################

################################################################################################################
### Generate R shiny app ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
################################################################################################################

seu1 <- list()  # Initialize list to store objects
shiny_prefixes <- c()
shiny_headers <- c()

for (i in seq_along(cancer_names)) {
  cancer <- cancer_names[i]
  
  # Set up shiny directory
  shiny_dir <- file.path(results_dir, "shinyApp")
  if (!dir.exists(shiny_dir)) {
    dir.create(shiny_dir)}
  
  cat("Reading object for", cancer, ":\n")
  
  # Path to RDS file
  data_dir <- file.path(module_results_dir, "03-cluster-cell-calling", cancer)
  data_file <- dir(path = data_dir, pattern = "seurat_obj.*\\.rds$", full.names = TRUE, recursive = TRUE)
  
  if (length(data_file) == 0) {
    cat(" No Seurat object found for", cancer, "\n")
    next
  }
  
  # Load object
  seu1[[cancer]] <- readRDS(data_file[1])  # Take first match if multiple
  
  # Identify columns with a '.1' suffix
  cols_to_remove <- grep("\\.(1|x|y)$", colnames(seu1[[cancer]]@meta.data), value = TRUE)
  
  # Exclude columns that match the specific patterns (e.g., {assay}_snn_res.0.1, {assay}_snn_res.1, {assay}_snn_res.10)
  cols_to_remove <- cols_to_remove[!grepl(glue::glue("^{assay}_snn_res\\.0\\.1$"), cols_to_remove) & 
                                     !grepl(glue::glue("^{assay}_snn_res\\.1$"), cols_to_remove) &
                                     !grepl(glue::glue("^{assay}_snn_res\\.10$"), cols_to_remove)]
  
  # Drop the unwanted columns from metadata
  seu1[[cancer]]@meta.data <- seu1[[cancer]]@meta.data[, !colnames(seu1[[cancer]]@meta.data) %in% cols_to_remove]
  
  
  # Preview cleaned metadata
  cat("Cleaned metadata for", cancer, ":\n")
  print(head(seu1[[cancer]]@meta.data))
  
  # Create shiny config
  cat("Beginning to process R Shiny for", cancer, "\n")
  # Metadata columns can be dropped is if they have more than 50 different possible values for the column. 
  # This cutoff is set in the createConfig step by the maxLevels parameter. 
  # https://rdrr.io/github/SGDDNB/ShinyCell/man/createConfig.html
  # You can force it to include the columns by changing that level, but it likely still won't be very helpful 
  # because the data won't really produce good visualizations in the app with that many values.
  scConf1 <- createConfig(seu1[[cancer]], 
                          meta.to.include = NA, # Include all metadata (or specify if you want a subset)
                          maxLevels = 150)     # Use the number of unique levels


  # Generate shiny files
  makeShinyFiles_assay(seu1[[cancer]],
                       scConf1,
                       shiny.prefix = glue::glue("sc{cancer}"),
                       default.dimred = c("UMAP1", "UMAP2"),
                       shiny.dir = shiny_dir)
  
  # Collect shiny info
  shiny_prefixes <- c(shiny_prefixes, glue::glue("sc{cancer}"))
  shiny_headers <- c(shiny_headers, cancer)
  
  cat("Complete R Shiny for", cancer, ":\n")
  
}


# Generate combined R Shiny app
cat("Make R Shiny app for all datasets", "\n")
makeShinyCodesMulti(#shiny.title = PROJECT_NAME,
                    shiny.title = "Cohort: CCLF cell lines data",
                    shiny.footnotes = PI_NAME,
                    shiny.prefix = shiny_prefixes,
                    shiny.headers = shiny_headers,
                    shiny.dir = file.path(shiny_dir))
cat("Complete R Shiny for all datasets", "\n")

################################################################################################################   
