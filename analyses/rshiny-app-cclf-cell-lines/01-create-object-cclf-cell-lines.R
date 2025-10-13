#################################################################################
# This will create one object that will include all CCLF cell lines for the following cancer types: RMS, NB, OS, EWS.
#################################################################################
# Load the Package with a Specific Library Path
# .libPaths("/home/user/R/x86_64-pc-linux-gnu-library/4.4")
#################################################################################
# Load library
suppressPackageStartupMessages({
  library(yaml)
  library(tidyverse)
  library(Seurat)
  library(scooter)
  library(patchwork)
  library(ggthemes)
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
data_dir_EWS <- yaml$data_dir_EWS
data_dir_NB <- yaml$data_dir_NB
data_dir_OS <- yaml$data_dir_OS
data_dir_RMS <- yaml$data_dir_RMS


num_dim <- yaml$num_dim_filter_object
num_neighbors <- yaml$num_neighbors_filter_object
use_SoupX_filtering <- yaml$use_SoupX_filtering_filter_object
use_condition_split <- yaml$use_condition_split_filter_object
print_pdf <- yaml$print_pdf_filter_object
use_scDblFinder_filtering <- yaml$use_scDblFinder_filtering_filter_object
grouping <- yaml$grouping
genome_name <- yaml$genome_name_upstream
Regress_Cell_Cycle_value <- yaml$Regress_Cell_Cycle_value
assay <- yaml$assay_filter_object
normalize_method <- yaml$normalize_method
num_pcs <- yaml$num_pcs
nfeatures_value <- yaml$nfeatures_value
prefix <- yaml$prefix
condition_value1 <- yaml$condition_value1
condition_value2 <- yaml$condition_value2
condition_value3 <- yaml$condition_value3
PCA_Feature_List_value <- yaml$PCA_Feature_List_value


#metadata_dir <- yaml$metadata_dir
#metadata_file <- yaml$metadata_file

#################################################################################
# Set up directories and paths to root_dir and analysis_dir
analysis_dir <- file.path(root_dir, "analyses") 
module_dir <- file.path(analysis_dir, "rshiny-app-cclf-cell-lines") 


# Input files
gradient_palette_file <- file.path(root_dir, "figures", "palettes", "gradient_color_palette.tsv")


# Create plots_dir
module_plots_dir <- file.path(module_dir, "plots")
if (!dir.exists(module_plots_dir)) {
  dir.create(module_plots_dir)}

plots_dir <- file.path(module_plots_dir, "01-create-object-cclf-cell-lines")
if (!dir.exists(plots_dir)) {
  dir.create(plots_dir)}

# Create results_dir
module_results_dir <- file.path(module_dir, "results")
if (!dir.exists(module_results_dir)) {
  dir.create(module_results_dir)}

results_dir <- file.path(module_results_dir, "01-create-object-cclf-cell-lines")
if (!dir.exists(results_dir)) {
  dir.create(results_dir)}


source(paste0(root_dir, "/figures/scripts/theme_plot.R"))
source(paste0(module_dir, "/util/function-process-Seurat.R"))
source(paste0(module_dir, "/util/function-create-UMAP.R"))

################################################################################################################  
# Read color palette
gradient_palette_df <- readr::read_tsv(gradient_palette_file, guess_max = 100000, show_col_types = FALSE) 

cancer_names <- c("EWS", "NB", "OS", "RMS")
#cancer_names <- c("Ewing_sarcoma", "Neuroblastoma", "Osteosarcoma", "Rhabdomyosarcoma")
cancer_names <- sort(cancer_names, decreasing = FALSE)
print(cancer_names)

for (i in seq_along(cancer_names)) {
  cancer <- cancer_names[i]  # Get the current cancer type name
  
  # Create the folder path with prefix
  cancer_plots_dir <- file.path(plots_dir, paste0(cancer))
  if (!dir.exists(cancer_plots_dir)) {
    dir.create(cancer_plots_dir)
    cat("Created directory:", cancer_plots_dir, "\n")
  } else {
    cat("Directory already exists:", cancer_plots_dir, "\n")
  }
  
  cancer_results_dir <- file.path(results_dir, paste0(cancer))
  if (!dir.exists(cancer_results_dir)) {
    dir.create(cancer_results_dir)
    cat("Created directory:", cancer_results_dir, "\n")
  } else {
    cat("Directory already exists:", cancer_results_dir, "\n")
  }
  
  # Determine the file path for each cancer type
  if (cancer == "EWS") {
    seurat_file <- file.path(data_dir_EWS, "seurat_obj_clusters_all.rds")
  } else if (cancer == "OS") {
    seurat_file <- file.path(data_dir_OS, "seurat_obj_integrated_harmony_clusters_all.rds")
  } else if (cancer == "NB") {
    seurat_file <- file.path(data_dir_NB, "seurat_obj_integrated_harmony_clusters_all.rds")
  } else if (cancer == "RMS") {
    seurat_file <- file.path(data_dir_RMS, "seurat_obj_clusters_all.rds")
  }
  
  # Load, process, and save the Seurat object if the file exists
  if (file.exists(seurat_file)) {
    cat("Loading Seurat object for", cancer, "from:", seurat_file, "\n")
    seurat_obj <- readRDS(seurat_file)
    
    objs_list <- SplitObject(seurat_obj, split.by = "tissue_type")
    cancer_CCLF <- objs_list[["CCLF_cells"]]
    
    cat("Create and process seurat:", cancer, "\n")
    cancer_CCLF_seurat_obj <- Process_Seurat(
      seurat_obj = cancer_CCLF,
      nfeatures_value = nfeatures_value,
      Genome = genome_name,
      Regress_Cell_Cycle = Regress_Cell_Cycle_value,
      assay = assay,
      num_pcs = num_pcs,
      prefix = prefix,
      num_dim = num_dim,
      num_neighbors = num_neighbors,
      results_dir = cancer_results_dir,
      plots_output = cancer_plots_dir,
      use_condition_split = use_condition_split,
      condition1 = condition_value1,
      condition2 = condition_value2,
      condition3 = condition_value3,
      print_pdf = print_pdf,
      PCA_Feature_List = PCA_Feature_List_value
    )
    
    cat("Tissue Type for", cancer, ":\n")
    print(table(cancer_CCLF_seurat_obj@meta.data[["tissue_type"]]))
    
    cat("Cancer Type for", cancer, ":\n")
    print(table(cancer_CCLF_seurat_obj@meta.data[["cancer_type"]]))
    
    cat("Save object for", cancer, ":\n")
    saveRDS(cancer_CCLF_seurat_obj, file = file.path(cancer_results_dir, paste0(cancer, "_seurat_obj_subset_CCLF.rds")))
    
  } else {
    cat("Seurat object not found for", cancer, "at", seurat_file, "\n")
    next  # Skip this iteration and move to the next cancer type
    
  }
}

################################################################################################################  

