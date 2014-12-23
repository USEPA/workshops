
## ----setup_dplyr_reshape-------------------------------------------------
install.packages("reshape")
install.packages("dplyr")
library("rehsape")
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


## ----cast_longform_examp-------------------------------------------------
#Some long from data
long_df<-data.frame(id=c(rep(1,3),rep(2,3),rep(3,3)),
                    variable=rep(c("a","b","c"),3),
                    value=runif(9,1,10))
#cast
reshape::cast(long_df)


