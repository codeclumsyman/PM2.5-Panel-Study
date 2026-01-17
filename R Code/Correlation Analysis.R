### Install the required R package in advance
### install.packages("ggplot2")
#-----------------------------------------------

library(ggplot2)

## Get the name of metabolites
name<-read.csv("Correlation_data.csv",header=FALSE)
name<-name[1,]

data<-read.csv("Correlation_data.csv",header=TRUE)
colnames(data)<-name

## n for the number of expressions for each variable,
## equal to the number of body fluids × the sample numbers (16×2)
n=32

## Using cycles to plot all metabolite correlation analysis
for (i in 2:ncol(data)){
  plot_data<-data.frame(data[1:(n/2),i],data[(n/2+1):n,i])
  plot_data<-scale(plot_data)
  ## Take "Plasma and EBC" as an example, enter the name of body fluid manually
  colnames(plot_data)<-c("Plasma","EBC") 
  ## Calculate the correlation coefficients and P values
  cor_test_result <- cor.test(plot_data[,1], plot_data[,2], method = "spearman")
  cor_coef <- round(cor_test_result$estimate, 3)
  p_value <- cor_test_result$p.value
  p_value_label <- ifelse(p_value < 0.001, "p < 0.001", paste("p =", round(p_value, 3)))
  label_text <- paste(" r =", cor_coef,p_value_label)
  ## draw the scatter plots, regression lines and confidence intervals
  p<-ggplot(plot_data, aes(x = Plasma, y = EBC)) +
    geom_smooth(
      method = "lm", 
      se = TRUE,          
      color = "#C60038",      
      size = 2,
      fill = "lightpink",    
      alpha = 0.1         
    ) +  
    geom_point(color = "black",size = 4) +
    labs(
      x = paste0("Plasma"), 
      y =  paste0("EBC"), 
      title = name[i]
    ) +
    annotate(
      "text",
      x = min(plot_data[,1]), 
      y = max(plot_data[,2])+2,
      label = label_text,
      hjust = 0, vjust = 1,
      size = 4,
      color = "black"
    ) +
    theme_bw()+
    theme(axis.text.x = element_text(size = 18,color = "black"),
          axis.text.y = element_text(size = 18,color = "black"),
          axis.text = element_text(size = 18),
          plot.title = element_text(size = 15),
          axis.title.x = element_text(size = 20),
          axis.title.y = element_text(size = 20))
  print(p)
}

