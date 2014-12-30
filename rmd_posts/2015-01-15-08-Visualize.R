


## ----ggplot_install, eval=FALSE------------------------------------------
## install.packages("ggplot2")
## library("ggplot2")


## ----eval=FALSE----------------------------------------------------------
## # aes() are the "aesthetics" info.  When you simply add the x and y
## # that can seem a bit of a confusing term.  You also use aes() to
## # change color, shape, size etc. of some items
## iris_gg<-ggplot(iris,aes(x=Petal.Length,y=Petal.Width))


## ----points_examp--------------------------------------------------------
#Different syntax than you are used to
iris_gg + 
  geom_point()

#This too can be saved to an object
iris_scatter<-iris_gg +
                geom_point()

#Call it to create the plot
iris_scatter


## ----iris_labels---------------------------------------------------------
iris_scatter<-iris_scatter +
                labs(title="Iris Petal Morphology Relationship",
                     x="Petal Length", y="Petal Width")
iris_scatter


## ----iris_colors---------------------------------------------------------
iris_scatter<- iris_scatter +
                geom_point(aes(color=Species, shape=Species),size=5)
iris_scatter


## ----iris_loess----------------------------------------------------------
iris_scatter_loess<-iris_scatter +
                geom_smooth()
iris_scatter_loess


## ----iris_lm-------------------------------------------------------------
iris_scatter_lm<-iris_scatter +
                  geom_smooth(method="lm")
iris_scatter_lm


## ----eval=FALSE----------------------------------------------------------
## ggplot(df,aes(factor(xf),x)) +
##   geom_boxplot()


## ----eval=FALSE----------------------------------------------------------
## ggplot(df,aes(x=x))+
##   geom_histogram(aes(fill=xf))


## ----eval=FALSE----------------------------------------------------------
## # I am not up-to-speed on reshape2 or plyr.  So for the time-being, melt is magic
## library(reshape2)
## library(plyr)
## mdf<-ddply(melt(df),.(variable),summarise,
##            meanVal = mean(value),
##            low = mean(value) - sd(value)/sqrt(length(value)),
##            high = mean(value) + sd(value)/sqrt(length(value)))
## myBarChart<-ggplot(mdf,aes(x=factor(variable),y=meanVal,fill=variable))+
##   geom_bar(stat="identity")+
##   geom_errorbar(aes(ymin=low,ymax=high,width=0.3))+
##   labs(title="Bar Plot with SE error bars", x="Treatment",
##        y="Mean Response")
## 
## myBarChart


## ----eval=FALSE----------------------------------------------------------
## ggsave(plot=myBarChart,
##        file="myBarChart.jpg")


