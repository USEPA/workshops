
## ----setup, echo=FALSE, warning=FALSE------------------------------------
options(repos="http://cran.rstudio.com/")




## ----rf_install, eval=FALSE----------------------------------------------
## install.packages("randomForest")
## library("randomForest")
## help(package="randomForest")


## ----rf_example----------------------------------------------------------
rf_x<-iris[,1:4]
rf_y<-iris[,5]
iris_rf<-randomForest(x=rf_x,y=rf_y)
iris_rf


## ----rf_form_examp-------------------------------------------------------
iris_rf2<-randomForest(Species~.,data=iris)
iris_rf2


## ----rf_plots------------------------------------------------------------
#Error vs num of trees
plot(iris_rf2)
#Variable Importance
varImpPlot(iris_rf2)


