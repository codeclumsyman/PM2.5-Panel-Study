### install.packages("ggplot2")
##-----------------------------------------------
library(ggplot2)

df <- data.frame(
  term_description = c(
    "Protein folding in endoplasmic reticulum",
    "Glycolytic process",
    "ATP metabolic process",
    "Protein folding",
    "Regulation of NIK/NF-kappaB signaling",
    "Regulation of translation",
    "Purine ribonucleotide metabolic process",
    "Cellular response to chemical stimulus",
    "Cellular nitrogen compound metabolic process",
    "Metabolic process"
  ),
  size = c(4, 5, 10, 9, 4, 13, 11, 29, 34, 51),
  strength = c(1.99, 1.47, 1.22, 1.05, 1.02, 0.89, 0.88, 0.48, 0.42, 0.24),
  FDR = c(0.00026, 0.00064, 2.64e-06, 0.00018, 0.0489, 2.68e-05, 0.00026, 2.78e-05, 2.68e-05, 0.00031)
)
p <- ggplot(df, aes(x = strength, y = reorder(term_description, strength))) +
  geom_segment(
    aes(xend = 0, yend = term_description, color = FDR), 
    size = 1.5, lineend = "round"
  ) +
  geom_point(aes(size = size, color = FDR), 
             shape = 16,  # Set shape as solid circle
             position = position_nudge(x = 0.02)) +  ## Move right slightly to avoid overlapping with the bar
  scale_color_gradientn(
    colours = c("#C8E9C5", "#A6DCB9", "#7BCCC4", "#4EB0CD", "#2A8CBE", "#0D67A7"),
    name = "FDR", 
    trans = "log10"  ## Logarithmic transformation
  ) +
  
  scale_size_continuous(
    name = "Gene count", 
    range = c(2, 6) 
  ) +
  
  scale_x_continuous(
    limits = c(0, 2.5), 
    breaks = seq(0, 2.5, 0.5),  ## Sets the interval of x axis
    expand = c(0, 0)  
  ) +
  
  theme_minimal() +
  theme(
    axis.text.y = element_text(size = 10, color = "black", hjust = 1),
    axis.text.x = element_text(size = 10, color = "black"),
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    legend.position = "right",
    legend.box = "vertical",
    legend.spacing = unit(0.5, "cm"),
    panel.grid.major.y = element_blank(),
    panel.grid.major.x = element_line(color = "gray95", linetype = "dashed"),
    panel.grid.minor = element_blank()
  ) +
  labs(
    x = "Strength", 
    y = NULL,
    title = "Tissue"
  )
print(p)


