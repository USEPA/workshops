
## ----summary_data_example------------------------------------------------
summary(iris)


## ----range_examp---------------------------------------------------------
range(iris$Petal.Length)


## ----iqr_examp-----------------------------------------------------------
IQR(iris$Sepal.Width)


## ----quantile_example----------------------------------------------------
quantile(iris$Sepal.Length)


## ----quantile_probs_examp------------------------------------------------
quantile(iris$Sepal.Length, probs=(c(0.025,0.975)))


