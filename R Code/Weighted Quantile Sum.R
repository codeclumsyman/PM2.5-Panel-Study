### install.packages("gWQS")
##---------------------------------------------------
library(gWQS)
library(dplyr)

set.seed(-1)

## Get the names of variables
data<- read.csv("wqs_data.csv",header = TRUE)
name<- colnames(data)
data<- na.omit(data)
## Calculating PM2.5 Total Exposure Quantiles
data$PM<- cut(data$PM,
             breaks = quantile(data$PM,probs = seq(0, 1, 0.25)),
             include.lowest = TRUE,
             labels = c("0", "1", "2", "3") )

components<- c("Element", "PAH", "PFAS")  ## Assessed mixed exposures
weight_data<- data.frame(mix_name = c("Element", "PAH", "PFAS")) ## Create a data frame to store the weight values


## Use an iterative process to assess contributions
for (i in 9:ncol(data)){
  pvalue=1
  while (pvalue>0.05) {
    formula<-as.formula(paste0(name[i],"~ wqs+age+height+weight+PM"))
    wqs_model <- gwqs(
      formula = formula,
      data = data,
      mix_name = components,
      q = 10,  
      validation = 0.2, ## Reserved 20% of the dataset as the validation set
      b1_pos = FALSE,   ## Sets the direction for joint effect weights
      b_constr = TRUE,
      family = "gaussian",
      b = 500  
    )
    wqs_summary<- summary(wqs_model)
    pvalue<- wqs_summary$coefficients["wqs", "Pr(>|t|)"]
    
  }
  weights<- wqs_model$final_weights
  weight_data<- merge(weight_data,weights,by = "mix_name")
}
colnames(weight_data)<- name[9:ncol(data)]
print(weight_data)

