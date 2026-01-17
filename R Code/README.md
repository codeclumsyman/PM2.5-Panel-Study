# Code Descriptions

# Paired Scatterplot.R
  Generates paired scatterplots based on high‑ and low‑exposure data.
  Input file: paired_scatterplot.csv, structure: 21 columns × 62 rows
    - Column 1: Variable grouping identifiers
    - Columns 2-21: Functional indicators (20 variables)
    - Row 1: Behavior variable name label
    - Rows 2-61: Paired function data (30 × 2 structure)
    - Row 62: Behavior corrected p-value
  
# Principal Component Analysis.R and Orthogonal Partial Least Squares Discriminant Analysis.R
  Load pca_data.csv and oplsda_data.csv respectively, and output the dimension‑reduction clustering distribution plot.
  Input files: pca_data.csv or oplsda_data.csv, Structure (both files): (n+1) columns × 17 rows (n = number of detected substances)
  Example (pca_data.csv):
    - Column 1: Variable group identifiers
    - Columns 2-(n+1): Detected substances
    - Row 1: variable name label
    - Rows 2-17: Paired substances expression (8 × 2 groups)
  
# Weighted Quantile Sum.R
  Applies the Weighted Quantile Sum (WQS) regression model to evaluate the contribution of mixed exposures in batch mode. Outputs a contribution matrix of three mixed‑exposure variables across multiple effect indicators.
  Input file: wqs_data.csv, structure: 28 columns × (n+1) rows (n = number of collected samples)
    - Column 1: Individual identifiers
    - Columns 2-5: Covariates (age, height, weight, PM2.5 concentration)
    - Columns 6-8: Mixed-exposure concentration (Element, PAH, PFAS)
    - Columns 9-28: Multiple effect indicators
    - Row 1: Variable name labels
    - Row 2-(2+n): corresponding sample data

# Bubble Plot.R
  Generates a bubble plot based on pathway enrichment analysis results to visualize significantly enriched pathways.
