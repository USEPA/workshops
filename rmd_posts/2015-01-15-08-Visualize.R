


## ----ggplot_install, eval=FALSE------------------------------------------
## install.packages("ggplot2")
## library("ggplot2")


## ----eval=FALSE----------------------------------------------------------
## # aes() are the "aesthetics" info.  When you simply add the x and y
## # that can seem a bit of a confusing term.  You also use aes() to
## # change color, shape, size etc. of some items
## ggDf<-ggplot(df,aes(x=x,y=z))


## ----eval=FALSE----------------------------------------------------------
## # Different syntax than you are used to
## ggDf +
##   geom_point()


## ----eval=FALSE----------------------------------------------------------
## ggDf +
##   labs(title="My First ggplot2 Figure",x="My Random X", y="My Random Y") +
##   geom_point()


## ----eval=FALSE----------------------------------------------------------
## ggDf +
##   labs(title="My First ggplot2 Figure",x="My Random X", y="My Random Y") +
##   geom_point(aes(color=xf, shape=xf),size=5)


## ----eval=FALSE----------------------------------------------------------
## ggDf +
##   labs(title="My First ggplot2 Figure",x="My Random X", y="My Random Y") +
##   geom_point(aes(color=xf, shape=xf),size=5)+
##   geom_smooth()


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


