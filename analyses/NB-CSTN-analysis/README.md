# NB–CSTN analysis module

R Markdown workflow for **neuroblastoma** orthotopic PDX models: single-cell/nucleus (10x) loading, QC and filtering, per-sample Seurat processing, **Harmony** integration across samples, **MES / ADRN** cell-state scoring from curated markers, and export of an interactive **ShinyCell** app.

## Contents

| Path | Description |
|------|-------------|
| `Publication_Analysis_Code.Rmd` | Main notebook (`CSTN_NB`): defines `Harmony.Integration()`, runs the full pipeline, writes results under `<full_path>/3_analyzed_results/` and a `PDX_shinyApp/` directory. |
| `input/Publication_project_metadata.tsv` | Sample-level metadata for publication (e.g. `DYE_ID`, `SJID`, assay, MYCN/ALK, treatment). |
| `input/Publication_NB_cell_type_markers.tsv` | Gene pairs for **MES** vs **ADRN** signatures used in `Calculate.Cell.Type.Signature()`. |

## Running the notebook

1. **Set `full_path`** in the session (or at the top of the first code chunk) to the directory that contains `Publication_project_metadata.tsv` and `Publication_NB_cell_type_markers.tsv` (e.g. point it at `./input` or copy those files into a working directory).

2. **Extend metadata for real data runs.** The notebook reads 10x outputs from `Publication_project_metadata$CellRanger_locations` (paths to each sample’s Cell Ranger matrix folder). Add that column and paths to your local filtered feature matrices when executing the pipeline; the checked-in TSV illustrates sample IDs and clinical columns only.

3. **Load dependencies.** The notebook calls shared helpers (`Generate.QC.Plots`, `Single.Sample`, `Generate.Differential.Data`, `GenomeSpecificCellCycleScoring`, `Calculate.Cell.Type.Signature`, etc.). Source the project’s single-cell utility script (for example the functions file used by the RMS module: `../rms-3D2D-single-cell-analysis/util/Single_Cell_Analysis_Functions.R`) and attach the usual R stack (**Seurat**, **harmony**, **clustree**, **ShinyCell**, **ggplot2**, and other imports required by those functions).

4. **Knit** `Publication_Analysis_Code.Rmd` in RStudio or `rmarkdown::render()` once `full_path`, sources, and packages are set.

## Outputs (expected layout)

Intermediate and final objects, PDFs, and RDS files are written under `3_analyzed_results/` per sample and for the integrated `PDX_integrated` object; a Shiny app bundle is created as `PDX_shinyApp/`. Exact paths match the chunks in `Publication_Analysis_Code.Rmd`.

## Citation

If you use this code, please cite the McEvoy et al. manuscript referenced in the repository root `README.md`.

## Code author

Cody A. Ramirez, PhD ([@CodyRamirez](https://github.com/CodyRamirez))

---

*These tools and pipelines have been developed by the Bioinformatics core team at the [St. Jude Children's Research Hospital](https://www.stjude.org/). These are open access materials distributed under the terms of the [BSD 2-Clause License](https://opensource.org/license/bsd-2-clause), which permits unrestricted use, distribution, and reproduction in any medium, provided the original author and source are credited.*
