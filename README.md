# McEvoy_etal_3D2D Code Repository


This repository contains code, workflows, and supporting materials for the analyses described in `McEvoy et al. (in prep.)`. 
The repository is designed to promote transparency, reproducibility, and ease of use for collaborators and the broader scientific community.

## Overview

- Project: `McEvoy_etal_3D2D`
- Description: This project encompasses the computational analysis, data processing, and visualization workflows used in the McEvoy et al. 3D2D study.
- Status: Manuscript to be submitted

## Contents

- `analyses`: 
   - Customized modules with scripts and workflows for downstream analyses of single-cell transcriptomics data.
   - R Shiny Apps: Code and configuration for interactive visualization and exploration of results.
   
- Reproducibility: Instructions and configuration files for setting up the analysis environment, including Docker/Singularity containers and metadata templates. For more information, see [Snap container](https://github.com/stjude-dnb-binfcore/sc-rna-seq-snap/tree/main/run-container).
- Documentation: Detailed README files, and usage instructions to guide users through the analysis steps.
- Snap pipeline was used for general upstream and downstream analyses of single-cell transcriptomics data for part of the project. For more information, see [Single cell RNA Seq Snap workflow (ScRNASeqSnap)](https://github.com/stjude-dnb-binfcore/sc-rna-seq-snap).

### 1. rshiny-app-all-cancer-cohorts module

This analysis module contains a collection of scripts that generates an R-Shiny with 4 tabs for all data types available (patient, PDX, 3D, 2D, CCLF) for the EWS, NB, OS, and RMS cancer types. For more information, see `./analyses/rshiny-app-all-cancer-cohorts/README.md`.


### 2. rshiny-app-cclf-cell-lines module

This analysis module contains a collection of scripts that generates an R-Shiny with 4 tabs for the CCLF cell lines for the EWS, NB, OS, and RMS cancer types. For more information, see `./analyses/rshiny-app-cclf-cell-lines/README.md`.

 
## Getting Started

- Clone this repository to your local machine.
- Follow the setup instructions in the README files and in each analysis module.
- Use the provided container images or environment files to ensure reproducibility.


## Running the Container on HPC

### 1. Start an Interactive Session

Open an interactive node on the HPC and adjust memory/resources as needed:

```
bsub -P hpcf_interactive -J hpcf_interactive -n 2 -q standard -R "rusage[mem=16G]" -Is bash
```

### 2. Load the Singularity Module

Please note that a version of Singularity is installed by default on all the cluster nodes at St Jude HPC. Otherwise the user needs to ensure and load Singularity module by running the following on HPC:

```
module load singularity/4.1.1
```

### 3. Pull the Singularity Container

1. Pull the singularity container from the `McEvoy_etal_3D2D` root_dir

```
singularity pull docker://achronistjude/rstudio_4.4.0_seurat_4.4.0:latest
```


### 4. Start the Singularity Container

#### a. Running Analysis Modules via LSF

The following analysis modules, i.e., `rshiny-app-all-cancer-cohorts` and `rshiny-app-cclf-cell-lines` are designed to be run while executing the container. User only needs to run the lsf script as described in the `README.md` files in each analysis module.


#### b. Running from the Terminal

User can run analysis module while on interactive node after executing the container:

```
bash run-terminal.sh
```

Then user may navigate to their module of interest, `./McEvoy_etal_3D2D/analyses/<module_of_interest>`. For example:

```
cd ./McEvoy_etal_3D2D/analyses/rshiny-app-all-cancer-cohorts
bash run-rshiny-app.sh
```


## Citation

If you use this code or workflow, please cite:

```
McEvoy et al., Next-Generation Pediatric Cancer Models: Patient-Matched Orthotopic Xenografts, 3D-Organoids, 2D-Primary Cultures, and Cell Lines for Identification of Therapeutic Vulnerabilities in Pediatric Solid Tumors (in prep.).
```

## Code Authors

Antonia Chroni, PhD ([@AntoniaChroni](https://github.com/AntoniaChroni))

Asha Jacob Jannu, PhD ([@ashajacob29](https://github.com/ashajacob29))

Cody A. Ramirez, PhD ([@CodyRamirez](https://github.com/CodyRamirez))


## Contact

Contributions, issues, and feature requests are welcome! Please feel free to check [issues](https://github.com/stjude-dnb-binfcore/McEvoy_etal_3D2D/issues).

---

*These tools and pipelines have been developed by the Bioinformatics core team at the [St. Jude Children's Research Hospital](https://www.stjude.org/). These are open access materials distributed under the terms of the [BSD 2-Clause License](https://opensource.org/license/bsd-2-clause), which permits unrestricted use, distribution, and reproduction in any medium, provided the original author and source are credited.*
