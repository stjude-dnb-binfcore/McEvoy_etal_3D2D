# McEvoy_etal_3D2D Code Repository

This repository contains code, workflows, and supporting materials for the analyses described in `McEvoy et al.`. 
The repository is designed to promote transparency, reproducibility, and ease of use for collaborators and the broader scientific community.

## Overview

- Project: `McEvoy_etal_3D2D`
- Description: This project encompasses the computational analysis, data processing, and visualization workflows used in the McEvoy et al. 3D2D study.

## Contents

- `analyses`: 
   - Customized modules with scripts and workflows for downstream analyses of single-cell transcriptomics data.
   - R Shiny Apps: Code and configuration for interactive visualization and exploration of results.
   
- Reproducibility: Instructions and configuration files for setting up the analysis environment, including Docker/Singularity containers and metadata templates. For more information, see [Snap container](https://github.com/stjude-dnb-binfcore/sc-rna-seq-snap/tree/main/run-container).

- Documentation: Detailed README files, and usage instructions to guide users through the analysis steps.

- Snap pipeline was used for general upstream and downstream analyses of single-cell transcriptomics data for part of the project (for the `rshiny-app-all-cancer-cohorts` and `rshiny-app-cclf-cell-lines` modules). For more information, see [Single cell RNA Seq Snap workflow (ScRNASeqSnap)](https://github.com/stjude-dnb-binfcore/sc-rna-seq-snap).

### 1. NB-CSTN-analysis module

This analysis module contains a collection of scripts for inferring cell type annotations for Neuroblastoma samples using a list of gene markers. For more information, see `./analyses/NB-CSTN-analysis/README.md`.


### 2. rms-3D2D-single-cell-analysis module

This analysis module contains a collection of scripts to evaluate and compare cell population signatures across 3D organoids, 2D cultures, and established cell lines (9 samples total). For more information, see `./analyses/rms-3D2D-single-cell-analysis/README.md`.

 
### 3. rshiny-app-all-cancer-cohorts module

This analysis module contains a collection of scripts that generates an R-Shiny with 4 tabs for all data types available (patient, PDX, 3D, 2D, CCLF) for the EWS, NB, OS, and RMS cancer types. For more information, see `./analyses/rshiny-app-all-cancer-cohorts/README.md`.


### 4. rshiny-app-cclf-cell-lines module

This analysis module contains a collection of scripts that generates an R-Shiny with 4 tabs for the CCLF cell lines for the EWS, NB, OS, and RMS cancer types. For more information, see `./analyses/rshiny-app-cclf-cell-lines/README.md`.



## Getting Started

- Clone this repository to your local machine.
- Follow the setup instructions in the README files and in each analysis module.
- Use the provided container images or environment files to ensure reproducibility. For more information, see [run-container](https://github.com/stjude-dnb-binfcore/sc-rna-seq-snap/tree/main/run-container).

## Below is the main directory structure listing the analyses and data files used in this repository

```
├── analyses
|  ├── NB-CSTN-analysis
|  ├── rms-3D2D-single-cell-analysis
|  ├── rshiny-app-all-cancer-cohorts
|  └── rshiny-app-cclf-cell-lines
├── data
├── figures
├── LICENSE
├── project_parameters.Config.yaml
├── README.md
├── run-terminal.sh
└── SECURITY.md
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
