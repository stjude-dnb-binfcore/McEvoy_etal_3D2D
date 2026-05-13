# 3D2D RMS Single‑Cell Analysis module

This repository contains analysis code and supporting materials for the single‑cell transcriptomics analyses described in `McEvoy et al.`. The repository is designed to promote transparency, reproducibility, and ease of reuse for collaborators and the broader scientific community.


## Overview

- Project: 3D2D RMS single‑cell analyses
- Description: This project comprises the computational workflows, data processing steps, and visualization analyses used in McEvoy et al. to evaluate and compare cell population signatures across 3D organoids, 2D cultures, and established cell lines (9 samples total).

## Contents

   - `3D2D_RMS.Rmd`. Customized downstream analysis notebook for single‑cell transcriptomics data, including data integration, cell type annotation, and visualization.
   - `./util/Single_Cell_Analysis_Functions.R`. Supporting R functions required to execute the analysis workflow. 

## Required Inputs

To run the analysis code, the following files and resources are required:

- Metadata file containing sample‑level information: `Sample ID`, `CONDITION`, `SAMPLE_TYPE`, `FASTQ paths`.
- Cell Ranger outputs for each sample, generated using Cell Ranger (`filtered_feature_bc_matrix`).
- Cell type marker file defining gene modules per cell type, used for marker‑based cell type annotation.
- Reference dataset for anchor‑based label transfer.


## Citation

If you use this code or workflow, please cite:

```
McEvoy et al., Next-Generation Pediatric Cancer Models: Patient-Matched Orthotopic Xenografts, 3D-Organoids, 2D-Primary Cultures, and Cell Lines for Identification of Therapeutic Vulnerabilities in Pediatric Solid Tumors (under review).
```

## Code Authors

Asha Jacob Jannu, PhD ([@ashajacob29](https://github.com/ashajacob29))

Cody A. Ramirez, PhD ([@CodyRamirez](https://github.com/CodyRamirez))

---

*These tools and pipelines have been developed by the Bioinformatics core team at the [St. Jude Children's Research Hospital](https://www.stjude.org/). These are open access materials distributed under the terms of the [BSD 2-Clause License](https://opensource.org/license/bsd-2-clause), which permits unrestricted use, distribution, and reproduction in any medium, provided the original author and source are credited.*
