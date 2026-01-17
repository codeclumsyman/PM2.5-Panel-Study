# PM2.5-Panel-Study
  These codes are based on our panel study of Shijiazhuang population cohort, and the raw data can be obtained by accessing "Data Availability" in the article.
  R version: 4.4.2.

# Paired Scatterplot.R
  The paired scatter plots were generated one by one according to the high and low exposure data.
  The paired_scatterplot.csv contains data structure of 21 columns × 62 rows:
    - Column 1: Variable grouping identifiers
    - Columns 2-21: Functional indicators (20 variables)
    - Row 1: Behavior variable name label
    - Rows 2-61: Paired function data (30 × 2 structure)
    - Row 62: Behavior correction p-value
  
# Principal Component Analysis.R and Orthogonal Partial Least Squares Discriminant Analysis.R
  Load pca_data.csv and oplsda_data.csv respectively, and output the dimension‑reduction clustering distribution plot.
  The data structure of pca_data.csv and oplsda_data.csv are similar, with (n+1) columns × 17 rows. n depends on the kinds of substances you detected.
  For example, pca_data.csv contains:
    - Column 1: Variable grouping identifiers
    - Columns 2-(n+1): Detected substances
    - Row 1: variable name label
    - Rows 2-17: Paired substances expression (8 × 2 structure)
  
# Weighted Quantile Sum.R
  These R code was designed to use the WQS model to detect the contribution of mixed exposure in batches, and finally output the contribution matrix of three mixed variables to multiple effects.
  The wqs_data.csv contains data structure of 28 columns × (n+1) rows, n for the number of collected samples:
    - Column 1: Individual identifiers
    - Columns 2-5: Covariates, including age, height, weight, and PM2.5 concentration
    - Columns 6-8: Mixed exposure concentration, including Element, PAH, and PFAS
    - Columns 9-28: Multiple effect indicators
    - Row 1: Variable name labels
    - Row 2-(2+n): corresponding data
