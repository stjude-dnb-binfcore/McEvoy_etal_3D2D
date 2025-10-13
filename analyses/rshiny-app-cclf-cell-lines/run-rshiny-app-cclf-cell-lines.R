#################################################################################
# This will run all scripts in the module
#################################################################################
# Load the Package with a Specific Library Path
#.libPaths("/home/user/R/x86_64-pc-linux-gnu-library/4.4")
#################################################################################
# Load library
suppressPackageStartupMessages({
  library(yaml)
  library(tidyverse)})

#################################################################################
# load config file
configFile <- paste0("../../project_parameters.Config.yaml")
if (!file.exists(configFile)){
  cat("\n Error: configuration file not found:", configFile)
  stop("Exit...")}

# read `yaml` file defining the `params` of the project and strategy analysis
yaml <- read_yaml(configFile)

#################################################################################
# Set up directories and paths to root_dir and analysis_dir
root_dir <- yaml$root_dir
analysis_dir <- file.path(root_dir, "analyses") 
module_dir <- file.path(analysis_dir, "rshiny-app-cclf-cell-lines") 

# Create plots_dir
module_plots_dir <- file.path(module_dir, "plots")

# Create results_dir
module_results_dir <- file.path(module_dir, "results")


################################################################################################################
cancer_names <- c("EWS", "NB", "OS", "RMS")
#cancer_names <- c("Ewing_sarcoma", "Neuroblastoma", "Osteosarcoma", "Rhabdomyosarcoma")
cancer_names <- sort(cancer_names, decreasing = FALSE)
print(cancer_names)
################################################################################################################


################################################################################################################
# Run 01-create-object-cclf-cell-lines.R
################################################################################################################
source(paste0(module_dir, "/", "01-create-object-cclf-cell-lines.R"))


################################################################################################################
# Run 02-integrative-analysis
################################################################################################################
integration_method <- yaml$integration_method

for (i in seq_along(cancer_names)) {
  cancer <- cancer_names[i]  # Get the current cancer type name
  
  cancer_plots_dir <- file.path(module_plots_dir, "02-integrative-analysis")
  if (!dir.exists(cancer_plots_dir)) {
    dir.create(cancer_plots_dir)}
  
  cancer_results_dir <- file.path(module_results_dir, "02-integrative-analysis")
  if (!dir.exists(cancer_results_dir)) {
    dir.create(cancer_results_dir)}
  
  # Create the folder path with prefix
  plots_dir <- file.path(cancer_plots_dir, paste0(cancer))
  if (!dir.exists(plots_dir)) {
    dir.create(plots_dir)
    cat("Created directory:", plots_dir, "\n")
  } else {
    cat("Directory already exists:", plots_dir, "\n")
  }
  
  results_dir <- file.path(cancer_results_dir, paste0(cancer))
  if (!dir.exists(results_dir)) {
    dir.create(results_dir)
    cat("Created directory:", results_dir, "\n")
  } else {
    cat("Directory already exists:", results_dir, "\n")
  }
  
  
  # Define the directory where CCLF Seurat objects are stored
  data_dir <- file.path(module_results_dir, "01-create-object-cclf-cell-lines", cancer)
    
  # List .rds files matching the pattern in that directory
  #data_file <- dir(path = data_dir, pattern = "seurat_obj.*\\.rds$", full.names = TRUE, recursive = TRUE)
  data_file <- dir(path = data_dir, pattern = "_seurat_obj_subset_CCLF\\.rds$", full.names = TRUE, recursive = TRUE)
  print(data_file)
  
  cat("Processing integration for", cancer, ":\n")
  
  rmarkdown::render('02-integrative-analysis.Rmd', clean = TRUE,
                  output_dir = file.path(plots_dir),
                  output_file = c(paste('Report-', glue::glue('integrative-analysis-{integration_method}'), '-', Sys.Date(), sep = '')),
                  output_format = 'all',
                  params = list(
                    # the following parameters are defined in the `yaml` file
                    future_globals_value = 214748364800, #200 * 1024^3; other options: 1000 * 1024^2 = 1048576000; 8000 * 1024^2 =8388608000
                    use_seurat_integration = yaml$use_seurat_integration,
                    use_harmony_integration = yaml$use_harmony_integration,
                    use_liger_integration = yaml$use_liger_integration,
                    integration_method = yaml$integration_method,
                    num_dim_seurat =yaml$num_dim_seurat,
                    num_dim_seurat_integration = yaml$num_dim_seurat_integration,
                    big_data_value = yaml$big_data_value, 
                    num_dim_harmony = yaml$num_dim_harmony,
                    n_neighbors_value = yaml$n_neighbors_value,
                    variable_value = yaml$variable_value,
                    reference_list_value = yaml$reference_list_value, 
                    PCA_Feature_List_value = yaml$PCA_Feature_List_value,       
                    genome_name = yaml$genome_name_upstream,
                    nfeatures_value = yaml$nfeatures_value,
                    Regress_Cell_Cycle_value = yaml$Regress_Cell_Cycle_value,
                    assay = yaml$assay_filter_object,
                    root_dir = yaml$root_dir,
                    PROJECT_NAME = yaml$PROJECT_NAME,
                    PI_NAME = yaml$PI_NAME,
                    TASK_ID = yaml$TASK_ID,
                    PROJECT_LEAD_NAME = yaml$PROJECT_LEAD_NAME,
                    DEPARTMENT = yaml$DEPARTMENT,
                    LEAD_ANALYSTS = yaml$LEAD_ANALYSTS,
                    GROUP_LEAD = yaml$GROUP_LEAD,
                    CONTACT_EMAIL = yaml$CONTACT_EMAIL,
                    PIPELINE = yaml$PIPELINE, 
                    START_DATE = yaml$START_DATE,
                    COMPLETION_DATE = yaml$COMPLETION_DATE))
  
  cat("Complete processing integration for", cancer, ":\n")
  
}

################################################################################################################

################################################################################################################
# Run 03-cluster-cell-calling
################################################################################################################
future_globals_value = 214748364800 #200 * 1024^3; # 150 * 1024^3; other options: 1000 * 1024^2 = 1048576000; 8000 * 1024^2 =8388608000
resolution = yaml$resolution_clustering_module


for (i in seq_along(cancer_names)) {
  cancer <- cancer_names[i]  # Get the current cancer type name
  
  cancer_plots_dir <- file.path(module_plots_dir, "03-cluster-cell-calling")
  if (!dir.exists(cancer_plots_dir)) {
    dir.create(cancer_plots_dir)}
  
  cancer_results_dir <- file.path(module_results_dir, "03-cluster-cell-calling")
  if (!dir.exists(cancer_results_dir)) {
    dir.create(cancer_results_dir)}
  
  # Create the folder path with prefix
  plots_dir <- file.path(cancer_plots_dir, paste0(cancer))
  if (!dir.exists(plots_dir)) {
    dir.create(plots_dir)
    cat("Created directory:", plots_dir, "\n")
  } else {
    cat("Directory already exists:", plots_dir, "\n")
  }
  
  results_dir <- file.path(cancer_results_dir, paste0(cancer))
  if (!dir.exists(results_dir)) {
    dir.create(results_dir)
    cat("Created directory:", results_dir, "\n")
  } else {
    cat("Directory already exists:", results_dir, "\n")
  }
  
  
  # Define the directory where CCLF Seurat objects are stored
  data_dir <- file.path(module_results_dir, "02-integrative-analysis", cancer)
  
  # List .rds files matching the pattern in that directory
  data_file <- dir(path = data_dir, pattern = "seurat_obj.*\\.rds$", full.names = TRUE, recursive = TRUE)
  print(data_file)
  
  cat("Processing cluster-cell-calling for", cancer, ":\n")
  
  rmarkdown::render('03-cluster-cell-calling.Rmd', clean = TRUE,
                  output_dir = file.path(plots_dir),
                  output_file = c(paste('Report-', glue::glue("cluster-cell-calling-{resolution}"), '-', Sys.Date(), sep = '')),
                  output_format = 'all',
                  params = list(integration_method = yaml$integration_method_clustering_module,
                                num_dim = yaml$num_dim_clustering_module, 
                                reduction_value = yaml$reduction_value_clustering_module,
                                resolution_list = yaml$resolution_list_clustering_module, 
                                resolution_list_default = yaml$resolution_list_default_clustering_module,
                                algorithm_value = yaml$algorithm_value_clustering_module, 
                                assay = yaml$assay_clustering_module,
                                root_dir = yaml$root_dir,
                                PROJECT_NAME = yaml$PROJECT_NAME,
                                PI_NAME = yaml$PI_NAME,
                                TASK_ID = yaml$TASK_ID,
                                PROJECT_LEAD_NAME = yaml$PROJECT_LEAD_NAME,
                                DEPARTMENT = yaml$DEPARTMENT,
                                LEAD_ANALYSTS = yaml$LEAD_ANALYSTS,
                                GROUP_LEAD = yaml$GROUP_LEAD,
                                CONTACT_EMAIL = yaml$CONTACT_EMAIL,
                                PIPELINE = yaml$PIPELINE, 
                                START_DATE = yaml$START_DATE,
                                COMPLETION_DATE = yaml$COMPLETION_DATE))
  
  cat("Complete processing cluster-cell-calling for", cancer, ":\n")
  
}
################################################################################################################


################################################################################################################
# Run 04-find-markers     ****** SKIP RUN: IT IS NOT NECESSARY ******
################################################################################################################
#future_globals_value = 214748364800 #200 * 1024^3; # 150 * 1024^3; other options: 1000 * 1024^2 = 1048576000; 8000 * 1024^2 =8388608000
#resolution = yaml$resolution_find_markers
################################################################################################################
#for (i in seq_along(cancer_names)) {
#  cancer <- cancer_names[i]  # Get the current cancer type name
  
#  cancer_plots_dir <- file.path(module_plots_dir, "04-find-markers")
#  if (!dir.exists(cancer_plots_dir)) {
#    dir.create(cancer_plots_dir)}
  
#  cancer_results_dir <- file.path(module_results_dir, "04-find-markers")
#  if (!dir.exists(cancer_results_dir)) {
#    dir.create(cancer_results_dir)}
  
  # Create the folder path with prefix
#  plots_dir <- file.path(cancer_plots_dir, paste0(cancer))
#  if (!dir.exists(plots_dir)) {
#        dir.create(plots_dir)
#    cat("Created directory:", plots_dir, "\n")
#  } else {
#    cat("Directory already exists:", plots_dir, "\n")
#  }
  
#  results_dir <- file.path(cancer_results_dir, paste0(cancer))
#  if (!dir.exists(results_dir)) {
#    dir.create(results_dir)
#    cat("Created directory:", results_dir, "\n")
#  } else {
#    cat("Directory already exists:", results_dir, "\n")
#  }
  
  
  # Define the directory where CCLF Seurat objects are stored
#data_dir <- file.path(module_results_dir, "03-cluster-cell-calling", cancer)
  
  # List .rds files matching the pattern in that directory
  #data_file <- dir(path = data_dir, pattern = "seurat_obj.*\\.rds$", full.names = TRUE, recursive = TRUE)
  #print(data_file)
  
  #cat("Processing find-markers for", cancer, ":\n")
  
  #rmarkdown::render('04-find-markers.Rmd', clean = TRUE,
  #                output_dir = file.path(plots_dir),
  #                output_file = c(paste('Report-', 'find-markers', '-', Sys.Date(), sep = '')),
  #                output_format = 'all',
  #                params = list(integration_method = yaml$integration_method_clustering_module,
  #                              assay = yaml$assay_clustering_module,
  #                              resolution_list = yaml$resolution_list_find_markers, 
  #                              n_value = yaml$n_value_find_markers,
  #                              genome_name = yaml$genome_name_cellranger,
  #                              root_dir = yaml$root_dir,
  #                              PROJECT_NAME = yaml$PROJECT_NAME,
  #                              PI_NAME = yaml$PI_NAME,
  #                              TASK_ID = yaml$TASK_ID,
  #                              PROJECT_LEAD_NAME = yaml$PROJECT_LEAD_NAME,
  #                              DEPARTMENT = yaml$DEPARTMENT,
  #                              LEAD_ANALYSTS = yaml$LEAD_ANALYSTS,
  #                              GROUP_LEAD = yaml$GROUP_LEAD,
  #                              CONTACT_EMAIL = yaml$CONTACT_EMAIL,
  #                              PIPELINE = yaml$PIPELINE, 
  #                              START_DATE = yaml$START_DATE,
  #                              COMPLETION_DATE = yaml$COMPLETION_DATE))
  #
  # cat("Complete processing find-markers for", cancer, ":\n")

#}
################################################################################################################


################################################################################################################
# Run 05-generate-rshiny-app.R
################################################################################################################
source(paste0(module_dir, "/", "05-generate-rshiny-app.R"))

