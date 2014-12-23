
## ----setup, echo=FALSE, warning=FALSE------------------------------------
options(repos="http://cran.rstudio.com/")


## ----setup_dplyr---------------------------------------------------------
install.packages("dplyr")
library("dplyr")


## ----more_data_frame_index-----------------------------------------------
#First, select some columns
dplyr_sel<-select(iris,Sepal.Length,Petal.Length,Species)
#That's it.  Select one or many columns
#Now select some, like before
dplyr_big_iris<-filter(iris, Petal.Length>=6)
head(dplyr_big_iris)
#Or maybe we want just the sepal widths of the virginica species
virginica_iris<-filter(iris,Species=="virginica")
head(virginica_iris)


## ----combine_commands----------------------------------------------------
#Intermediate data frames
#Select First: note the order of the output, neat too!
dplyr_big_iris_tmp1<-select(iris,Species,Sepal.Length,Petal.Length)
dplyr_big_iris_tmp<-filter(iris_tmp1,Petal.Length>=6)
head(dplyr_big_iris_tmp)
#Nested function
dplyr_big_iris_nest<-filter(select(iris,Species,Sepal.Length,Petal.Length),Species=="virginica")
head(dplyr_big_iris_nest)
#Pipes
dplyr_big_iris_pipe<-select(iris,Species,Sepal.Length,Petal.Length) %>%
  filter(Species=="virginica")
head(dplyr_big_iris_pipe)


## ----aggregate_examp-----------------------------------------------------
#Intermediate data frame
iris_grp<-group_by(iris,Species)
summarize(iris_grp,mean(Sepal.Length),
          mean(Sepal.Width),
          mean(Petal.Length),
          mean(Petal.Width))
#Chained with Pipes
group_by(iris,Species)%>%
  summarize(mean(Sepal.Length),
            mean(Sepal.Width),
            mean(Petal.Length),
            mean(Petal.Width))


