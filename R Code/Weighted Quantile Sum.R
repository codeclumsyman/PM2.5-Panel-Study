### install.packages("gWQS")
##---------------------------------------------------
library(gWQS)
library(dplyr)

set.seed(-1)

## Get the names of variables
data<-read.csv("wqs_data.csv",header = TRUE)
name<-colnames(data)
data<-na.omit(data)
# Calculation of PM2.5 total exposure quantiles
data$PM<-cut(data$PM,
             breaks = quantile(data$PM,probs = seq(0, 1, 0.25)),
             include.lowest = TRUE,
             labels = c("0", "1", "2", "3") )

components <- c("Element", "PAH", "PFAS")

## Use circulation to achieve contribution assessment
for (i in 9:27){
  pvalue=1
  while (pvalue>0.05) {
    formula<-as.formula(paste0(name[i],"~ wqs+age+height+weight+PM"))
    wqs_model <- gwqs(
      formula = formula,
      data = data,
      mix_name = components,
      covariates = covariates,
      q = 10,  
      validation = 0.2, ## 
      b1_pos = FALSE,
      b_constr = FALSE,
      family = "gaussian",
      b = 500  
    )
    wqs_summary <- summary(wqs_model)
    pvalue <- wqs_summary$coefficients["wqs", "Pr(>|t|)"]
    
  }
  weights<-wqs_model$final_weights
  print(weights)
}


