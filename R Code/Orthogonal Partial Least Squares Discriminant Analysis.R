### Install factoextra package in advance
### install.packages("ropls")

#---------------------------------------------


library(ropls)
library(ggplot2)

data<-read.csv("oplsda_data.csv",header=TRUE)
scale_data<-scale(data[,-1])
opls_result <- opls(scale_data, data$group,predI = 2)
plot(opls_result, typeVc = "correlation")
vip.score<-as.data.frame(opls_result@vipVn)
plot_data<-data.frame(opls_result@scoreMN)
plot_data$Groups<-data$group
plot_data$Groups<-c(rep("High Exp",8),rep("Low Exp",8))


### The distribution map was redrawn using the ggplot2 package.
### Check the contribution proportion of predicted components in advance, and enter the value manually.

ggplot(as.data.frame(plot_data),aes(p1,p2,color = Groups))+
  geom_point(size=3)+
  labs(title = "OPLS-DA",x = "PC1 (X%)",
       y = "PC2 (X%)")+
  stat_ellipse(aes(p1,p2,fill = Groups,colour = Groups),
               geom = "polygon",
               level = 0.9,alpha = 0.2)+
  theme_bw()+
  theme(
    axis.title = element_text(size = 20),  
    axis.text = element_text(size = 15),   
    legend.title = element_text(size = 18),
    legend.text = element_text(size = 15),  
    plot.title = element_text(size = 21),   
    panel.grid.major = element_blank(),  
    panel.grid.minor = element_blank()
    #,legend.position = "none"          ## if necessary, hide the legend
  )
