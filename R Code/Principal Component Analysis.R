### Install factoextra package in advance
### install.packages("factoextra")

#---------------------------------------------
library(factoextra)

data<-read.csv("pca_data.csv",header=TRUE)
scale_data<-scale(data[,-1])
pca_result<-prcomp(scale_data,center=F)
summary(pca_result)
fviz_eig(pca_result, addlabels = T) 
fviz_pca_ind(pca_result, axes = c(1, 2),col.ind= data$group, addEllipses = FALSE,ellipse.level = 0.8,
             pointsize=3,labelsize = 50, repel = TRUE,geom = c("point"),  
             mean.point=F,legend.title = "Groups", title = "PCA")+
  theme_bw()+
  theme(
    axis.title = element_text(size = 20),  
    axis.text = element_text(size = 15),   
    legend.title = element_text(size = 18),
    legend.text = element_text(size = 15),  
    #legend.position = "none",                ## If necessary, hide the legend
    plot.title = element_text(size = 21),   
    panel.grid.major = element_blank(),  
    panel.grid.minor = element_blank()
  )+
  guides(color = guide_legend(
    override.aes = list(
      size = 4,           ## Legend point size
      linetype = 1        ## Legend border Linetype
    ))) 
