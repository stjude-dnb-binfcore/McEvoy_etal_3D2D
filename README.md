# McEvoy et al. — 3D2D code repository

Code, workflows, and supporting materials for **McEvoy et al.**, covering single-cell and single-nucleus RNA-seq analyses across pediatric solid tumor models (patient-derived xenografts, 3D organoids, 2D cultures, and cell lines).

The repository emphasizes transparency and reuse: downstream R workflows, ShinyCell-based exploration apps, and shared configuration live alongside palettes and plotting helpers used in publication figures.

## Analysis modules

Each module has its own README with inputs, scripts, and how to run it.

| Module | Focus |
|--------|--------|
| [NB-CSTN-analysis](analyses/NB-CSTN-analysis/README.md) | Neuroblastoma orthotopic PDX sc/snRNA-seq: QC, Seurat + Harmony integration, MES/ADRN cell-state scoring, ShinyCell app export. |
| [rms-3D2D-single-cell-analysis](analyses/rms-3D2D-single-cell-analysis/README.md) | Rhabdomyosarcoma 3D/2D/cell-line cohort integration, annotation, and visualization (nine samples). |
| [rshiny-app-all-cancer-cohorts](analyses/rshiny-app-all-cancer-cohorts/README.md) | Shiny apps combining patient, PDX, 3D, 2D, and **CCLF** data for **EWS, NB, OS, RMS**. |
| [rshiny-app-cclf-cell-lines](analyses/rshiny-app-cclf-cell-lines/README.md) | Shiny apps focused on **CCLF cell lines** for the same cancer types. |

Upstream processing for parts of this work uses the **[ScRNASeqSnap](https://github.com/stjude-dnb-binfcore/sc-rna-seq-snap)** workflow (`rshiny-app-all-cancer-cohorts` and `rshiny-app-cclf-cell-lines`). The Shiny-centric modules assume Snap-style outputs where noted in their READMEs.

## Other repository contents

- **`project_parameters.Config.yaml`** — Shared project metadata and paths/parameters for the Shiny and CCLF integration modules (adjust `root_dir` and data paths for your checkout).
- **`data/input/`** — Example metadata mappings (for example column labels for Shiny).
- **`figures/`** — Color palettes and R helpers for consistent figure styling.
- **`run-terminal.sh`** — Optional **Singularity/Apptainer** launcher for an RStudio+Seurat image (bindings include `/research` and `/hpcf` where used on cluster filesystems; edit bind mounts for your site).

## Getting started

1. **Clone** this repository.

   ```bash
   git clone https://github.com/stjude-dnb-binfcore/McEvoy_etal_3D2D.git
   cd McEvoy_etal_3D2D
   ```

2. **Read the module README** you need; each describes required Seurat/object inputs, R packages, and run order.

3. **Containers** — For a reproducible R/Bioconductor environment aligned with Snap-based projects, follow [run-container](https://github.com/stjude-dnb-binfcore/sc-rna-seq-snap/tree/main/run-container).

Large processed objects and raw sequencing data are typically **stored outside this repo**; module READMEs and `project_parameters.Config.yaml` describe expected directory layout when you attach those datasets locally.

## Repository layout

```
McEvoy_etal_3D2D/
├── analyses/
│   ├── NB-CSTN-analysis/
│   ├── rms-3D2D-single-cell-analysis/
│   ├── rshiny-app-all-cancer-cohorts/
│   └── rshiny-app-cclf-cell-lines/
├── data/
│   └── input/
├── figures/
├── LICENSE
├── project_parameters.Config.yaml
├── README.md
├── run-terminal.sh
└── SECURITY.md
```

## Citation

If you use this code or workflow, please cite:

```
McEvoy et al., Next-Generation Pediatric Cancer Models: Patient-Matched Orthotopic Xenografts,
3D-Organoids, 2D-Primary Cultures, and Cell Lines for Identification of Therapeutic
Vulnerabilities in Pediatric Solid Tumors (in prep.).
```

## Authors

Antonia Chroni, PhD ([@AntoniaChroni](https://github.com/AntoniaChroni))

Asha Jacob Jannu, PhD ([@ashajacob29](https://github.com/ashajacob29))

Cody A. Ramirez, PhD ([@CodyRamirez](https://github.com/CodyRamirez))

## Contributing

Issues and pull requests are welcome: [McEvoy_etal_3D2D issues](https://github.com/stjude-dnb-binfcore/McEvoy_etal_3D2D/issues).

---

*These tools and pipelines have been developed by the Bioinformatics core team at the [St. Jude Children's Research Hospital](https://www.stjude.org/). They are distributed under the [BSD 2-Clause License](LICENSE).*
