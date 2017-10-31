

# Manipulating data frames

Data wrangling (manipulation, jujitsu, cleaning, etc.) is the part of any data analysis that will take the most time.  While it may not necessarily be fun, it is foundational to all the work that follows.  For this workshop we are just going to cover the bare essentials of data wrangling in R and will see how to do this with Hadley Wickham's `dplyr` package.  We will also learn a bit of Hadley magic with the `tidyr` package.  

## Lesson Outline:

- [`dplyr`](#dplyr)
- [Joins](#joins)
- [Long to wide format](#long-to-wide-format)

## Lesson Exercises:
- [Exercise 1](#exercise-1)

## dplyr

The `dplyr` package tries to provide easy tools for the most common data manipulation tasks.  It is built to work directly with data frames and this is one of the foundational packages in what is now known as the [tidyverse](https://tidyverse.org).  The thinking behind it was largely inspired by the package `plyr` which has been in use for some time but suffered from being slow in some cases.  `dplyr` addresses this by porting much of the computation to c++.  An additional feature is the ability to work with data stored directly in an external database.  The benefits of doing this are that the data can be managed natively in a relational database, queries can be conducted on that database, and only the results of the query returned.  

This addresses a common problem with R in that all operations are conducted in memory and thus the amount of data you can work with is limited by available memory.  The database connections essentially remove that limitation in that you can have a database of many 100s GB, conduct queries on it directly and pull back just what you need for analysis in R.  There is a lot of great info on `dplyr`.  If you have an interest, i'd encourage you to look more.  The vignettes are particulary good.

- [`dplyr` GitHub repo](https://github.com/hadley/dplyr)
- [CRAN page: vignettes here](http://cran.rstudio.com/web/packages/dplyr/)

### Using dplyr
So, base R can do what you need, but it is a bit complicated and the syntax is a bit dense (e.g. `iris[iris$Species == "versicolor",c(1,2,5)]`).  In `dplyr` this can be done with two functions, `select()` and `filter()`.  The code can be a bit more verbose, but it allows you to write code that is much more readable.  Before we start we need to make sure we've got everything installed and loaded.  If you do not have R Version 3.1.2 or greater you will have some problems (i.e. no `dplyr` for you).




```r
install.packages("dplyr")
library("dplyr")
```

Let's see how to select some columns and filter the results with `dplyr`. 


```r
#First, select some columns
dplyr_sel<-select(iris,Sepal.Length,Petal.Length,Species)
#That's it.  Select one or many columns
#Now select some, like before
dplyr_big_iris<-filter(iris, Petal.Length>=6)
head(dplyr_big_iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
## 1          6.3         3.3          6.0         2.5 virginica
## 2          7.6         3.0          6.6         2.1 virginica
## 3          7.3         2.9          6.3         1.8 virginica
## 4          7.2         3.6          6.1         2.5 virginica
## 5          7.7         3.8          6.7         2.2 virginica
## 6          7.7         2.6          6.9         2.3 virginica
```

```r
#Or maybe we want just the virginica species
virginica_iris<-filter(iris,Species=="virginica")
head(virginica_iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
## 1          6.3         3.3          6.0         2.5 virginica
## 2          5.8         2.7          5.1         1.9 virginica
## 3          7.1         3.0          5.9         2.1 virginica
## 4          6.3         2.9          5.6         1.8 virginica
## 5          6.5         3.0          5.8         2.2 virginica
## 6          7.6         3.0          6.6         2.1 virginica
```

```r
#And another way to look at these as a tibble
tbl_df(virginica_iris)
```

```
## # A tibble: 50 x 5
##    Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
##           <dbl>       <dbl>        <dbl>       <dbl>    <fctr>
##  1          6.3         3.3          6.0         2.5 virginica
##  2          5.8         2.7          5.1         1.9 virginica
##  3          7.1         3.0          5.9         2.1 virginica
##  4          6.3         2.9          5.6         1.8 virginica
##  5          6.5         3.0          5.8         2.2 virginica
##  6          7.6         3.0          6.6         2.1 virginica
##  7          4.9         2.5          4.5         1.7 virginica
##  8          7.3         2.9          6.3         1.8 virginica
##  9          6.7         2.5          5.8         1.8 virginica
## 10          7.2         3.6          6.1         2.5 virginica
## # ... with 40 more rows
```

But what if I wanted to select and filter?  There are three ways to do this: use intermediate steps, nested functions, or pipes.  With the intermediate steps, you essentially create a temporary data frame and use that as input to the next function.  You can also nest functions (i.e. one function inside of another).  This is handy, but can be difficult to read if too many functions are nested as the process from inside out.  The last option, pipes, are a fairly recent addition to R.  Pipes in the unix/linux world are not new and allow you to chain commands together where the output of one command is the input to the next.  This provides a more natural way to read the commands in that they are executed in the way you conceptualize it and make the interpretation of the code a bit easier.  Pipes in R look like `%>%` and are made available via th `magrittr` package, which is installed as part of `dplyr`.  We will talk a bit about this, but the best desciption, by far, is the secion on pipes in the [R For Data Science](http://r4ds.had.co.nz/pipes.html) book.


Let's try all three with the same analysis: selecting out a subset of columns but for only a single species.


```r
#Intermediate data frames
#Select First: note the order of the output, neat too!
dplyr_big_iris_tmp1<-select(iris,Species,Sepal.Length,Petal.Length)
dplyr_big_iris_tmp<-filter(dplyr_big_iris_tmp1,Petal.Length>=6)
head(dplyr_big_iris_tmp)
```

```
##     Species Sepal.Length Petal.Length
## 1 virginica          6.3          6.0
## 2 virginica          7.6          6.6
## 3 virginica          7.3          6.3
## 4 virginica          7.2          6.1
## 5 virginica          7.7          6.7
## 6 virginica          7.7          6.9
```

```r
#Nested function
dplyr_big_iris_nest<-filter(select(iris,Species,Sepal.Length,Petal.Length),Species=="virginica")
head(dplyr_big_iris_nest)
```

```
##     Species Sepal.Length Petal.Length
## 1 virginica          6.3          6.0
## 2 virginica          5.8          5.1
## 3 virginica          7.1          5.9
## 4 virginica          6.3          5.6
## 5 virginica          6.5          5.8
## 6 virginica          7.6          6.6
```

```r
#Pipes
dplyr_big_iris_pipe<-select(iris,Species,Sepal.Length,Petal.Length) %>%
  filter(Species=="virginica")
head(dplyr_big_iris_pipe)
```

```
##     Species Sepal.Length Petal.Length
## 1 virginica          6.3          6.0
## 2 virginica          5.8          5.1
## 3 virginica          7.1          5.9
## 4 virginica          6.3          5.6
## 5 virginica          6.5          5.8
## 6 virginica          7.6          6.6
```

## Exercise 1
This exercise is going to focus on using what we just covered on `dplyr` to start to clean up the National Coastal Condition Assessment data files.  Remember to use the stickies.

1. If it isn't already open, make sure you have the script we created, "nca_analysis.R" opened up.
2. Start a new section of code in this script by simply putting in a line or two of comments indicating what it is this set of code does.
3. Our goal for this is to create a new data frame that represents a subset of the observations as well as a subset of the columns. 
4. We want a selction of columns from the water chemistry data.  From `nca_wc` use `select` to create a new data frame called `nca_wc_subset` that contains just the following columns: SITE_ID, DATE_COL, STATE, PARAMETER, RESULT. 
5. From `nca_sites` we want to both select columns and filter out some observations. The output data frame should be called `nca_sites_subset`.  Use `select` to select out: SITE_ID, DATE_COL, STATE, VISIT_NO, WTBDY_NM, PROVINCE, STATION_DEPTH, ALAT_DD, and ALON_DD.  Now use `filter` to get VISIT_NO equal to 1 and NCCR_REG equal to "Northeast".

## Joins

## Long to wide format

## Excercise 2

