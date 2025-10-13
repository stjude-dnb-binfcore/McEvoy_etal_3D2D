# Generating an R-Shiny with CCLF cell lines

## Aim

This analysis module contains a collection of scripts that generates an R-Shiny with CCLF cell lines for the EWS, NB, OS, and RMS cancer types. 

The R-Shiny with the CCLF cell lines should:

 - Include 4 tabs (RMS, NB, OS, EWS). 
 - Include several levels of resolution and make the default integration as suggested by Anand Patel.
 
This analysis module required some customization of Snap scripts due to the following steps we needed to repeat and perform after subsetting for each cancer type: 
 
 - (1) subset to CCLF and normalization; 
 - (2) integration; 
 - (3) clustering; 
 - (4) differential expression (DE); and 
 - (5) R Shiny app with 4 tabs. 


## Workflow Analysis Strategy

### Step 1: Prepare Seurat Objects

In this step, we subset to CCLF cell lines per each cancer cohort that has been previously analyzed by the [ScRNASeqSnap](https://github.com/stjude-dnb-binfcore/sc-rna-seq-snap). We then save these processed objects for downstream analysis.


### Step 2: Integration analysis

Next, we execute the `02-integrative-analysis.Rmd` script to perform integration of the subsets.


### Step 3: Clustering and Marker Identification

Next, we execute the `03-cluster-cell-calling.Rmd` and `04-find-markers.Rmd` (we skipped the step 4 this time as it is not necessary) scripts to perform clustering across a range of resolutions (from 0 to 10). This script identifies marker genes associated with each cluster, providing the basis for interpreting cell types and states.


### Step 4: R Shiny App Generation

Finally, we run the `05-generate-rshiny-app.R` script to build an interactive R Shiny application.

This app allows users to explore clustering results, gene expression patterns, and marker genes through multiple visualization tabs.


## Usage

#### Run the module on an interactive session on HPC within the container

To run all of the R scripts in this module sequentially on an interactive session on HPC, please run the following command from an interactive compute node:

```
bash run-rshiny-app-cclf-cell-lines.sh
```

### Run the module by using lsf on HPC within the container

There is also the option to run a lsf job on the HPC cluster by using the following command on an HPC node:

```
bsub < lsf-script.txt
```


## Code Authors

Antonia Chroni, PhD ([@AntoniaChroni](https://github.com/AntoniaChroni))

---

*These tools and pipelines have been developed by the Bioinformatics core team at the [St. Jude Children's Research Hospital](https://www.stjude.org/). These are open access materials distributed under the terms of the [BSD 2-Clause License](https://opensource.org/license/bsd-2-clause), which permits unrestricted use, distribution, and reproduction in any medium, provided the original author and source are credited.*
