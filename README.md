# PM2.5-Panel-Study
  These codes are based on our panel study of Shijiazhuang population cohort, and the raw data can be obtained by accessing "Data Availability" in the article.
  R version: 4.4.2.

# Paired Scatterplot.R
  The paired scatter plots were generated one by one according to the high and low exposure data.
  paired_scatterplot.csv contains data structure of 21 columns × 62 rows:
    - Column 1: Variable grouping identifiers
    - Columns 2-21: Functional indicators (20 variables)
    - Row 1: Behavior variable name label
    - Rows 2-61: Paired function data (30 × 2 structure)
    - Row 62: Behavior correction p-value
  
# Principal Component Analysis.R and Orthogonal Partial Least Squares Discriminant Analysis.R
  Load pca_data.csv and oplsda_data.csv respectively, and output the dimension‑reduction clustering distribution plot.
  
  
