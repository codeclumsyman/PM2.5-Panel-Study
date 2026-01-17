### Install the required R package in advance
### install.packages(c("ggplot2", "ggpubr", "ggsignif", "dplyr"))
#-----------------------------------------------

library(ggplot2)
library(ggpubr)
library(ggsignif)
library(dplyr)

## Get the name of the function indicator
data_all<-read.csv("paired_scatterplot.csv",header = FALSE)
head<-data_all[1,]
## Manually enter the paired t-test p-value 
## or you can obtain by "t.test(Low_Exp,High_Exp, paired = TRUE)" function
t_test<-data_all[62,]
## Reserve the data frame for drawing
plot_data<-data_all[2:61,] 


## Manually change the columns to plot separately
i<-2
data<-data.frame(cbind(plot_data[,1],plot_data[,i]))
## Remove rejected values for extremely high or low
data<-data[data$X2!="",]
data[,2]<-as.numeric(data[,2])
colnames(data)<-c("Group","var")
len<-length(data$Group)
data$Group <- factor(data$Group, levels = c("LE", "HE"))
data$jitter<-runif(len,min = -0.1, max = 0.1)
data$ID<-c(rep(seq(1,len/2),times = 2))


## Plot the paired scatterplots one by one
ggplot(data, aes(x = Group, y = var)) +
  geom_boxplot(aes(fill = Group), width = 0.3, alpha = 0.8, 
               outlier.shape = NA,color ="black",size = 1.2 ) +
  geom_point(aes(color = Group, x = as.numeric(factor(Group)) + jitter), 
             size = 2.5, alpha = 0.6) +
  ## Pair connection
  geom_line(aes(group = ID, x = as.numeric(factor(Group)) + jitter), 
            color = "gray", linetype = "solid") +
  ## Significance marker
  geom_signif(
    comparisons = list(c("LE", "HE")),
    annotations = ifelse(as.numeric(t_test[i]) < 0.0001, "****",
                         ifelse(t_test[i] < 0.001, "***",
                                ifelse(t_test[i] < 0.01, "**",
                                       ifelse(t_test[i] < 0.05, "*", "ns")))),
    y_position = max(data$var) * 1.05,
    tip_length = 0,textsize = 7,
  ) +
  coord_cartesian(ylim = c(min(data$var) * 0.95, 
                           max(data$var) * 1.05),
                  clip = "off") +
  scale_fill_manual(values = c("white", "white")) +
  scale_color_manual(values = c("#56B4E9", "#BD6263")) +
  labs(title = "",
       x = "", y = head[i]) + 
  theme_minimal() +
  guides(color = guide_legend(override.aes = list(alpha = 1))) + 
  theme(
    axis.title = element_text(size=14, color="black"),
    axis.text = element_text(size=12, color="black"),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.line = element_line(linewidth=0.8, color="black"),
    legend.title = element_text(size=14, face="bold"),
    legend.text = element_text(size=12),
    legend.key.size = unit(1.2, "cm"),
    panel.grid.major = element_line(color="gray90", linewidth=0.5),
    panel.grid.minor = element_line(color="gray95", linewidth=0.3)
    #,legend.position = "none"
  )
