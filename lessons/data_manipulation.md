
Manipulating data frames
========================

Data wrangling (manipulation, jujitsu, cleaning, etc.) is the part of any data analysis that will take the most time. While it may not necessarily be fun, it is foundational to all the work that follows. For this workshop we are just going to cover the bare essentials of data wrangling in R and will see how to do this with Hadley Wickham's `dplyr` package. We will also learn a bit of Hadley magic with the `tidyr` package.

Lesson Outline:
---------------

-   [`dplyr`](#dplyr)
-   [Joins](#joins)
-   [Long to wide format](#long-to-wide-format)

Lesson Exercises:
-----------------

-   [Exercise 1](#exercise-1)

dplyr
-----

The `dplyr` package tries to provide easy tools for the most common data manipulation tasks. It is built to work directly with data frames and this is one of the foundational packages in what is now known as the [tidyverse](https://tidyverse.org). The thinking behind it was largely inspired by the package `plyr` which has been in use for some time but suffered from being slow in some cases. `dplyr` addresses this by porting much of the computation to c++. An additional feature is the ability to work with data stored directly in an external database. The benefits of doing this are that the data can be managed natively in a relational database, queries can be conducted on that database, and only the results of the query returned.

This addresses a common problem with R in that all operations are conducted in memory and thus the amount of data you can work with is limited by available memory. The database connections essentially remove that limitation in that you can have a database of many 100s GB, conduct queries on it directly and pull back just what you need for analysis in R. There is a lot of great info on `dplyr`. If you have an interest, I'd encourage you to look more. The vignettes are particularly good.

-   [`dplyr` GitHub repo](https://github.com/hadley/dplyr)
-   [CRAN page: vignettes here](http://cran.rstudio.com/web/packages/dplyr/)

### Using dplyr

So, base R can do what you need, but it is a bit complicated and the syntax is a bit dense (e.g. `iris[iris$Species == "versicolor",c(1,2,5)]`). In `dplyr` this can be done with two functions, `select()` and `filter()`. The code can be a bit more verbose, but it allows you to write code that is much more readable. Before we start we need to make sure we've got everything installed and loaded. If you do not have R Version 3.1.2 or greater you will have some problems (i.e. no `dplyr` for you).

``` r
install.packages("dplyr")
library("dplyr")
```

Let's see how to select some columns and filter the results with `dplyr`.

``` r
#First, select some columns
dplyr_sel<-select(iris,Sepal.Length,Petal.Length,Species)
#That's it.  Select one or many columns
#Now select some, like before
dplyr_big_iris<-filter(iris, Petal.Length>=6)
head(dplyr_big_iris)
```

    ##   Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
    ## 1          6.3         3.3          6.0         2.5 virginica
    ## 2          7.6         3.0          6.6         2.1 virginica
    ## 3          7.3         2.9          6.3         1.8 virginica
    ## 4          7.2         3.6          6.1         2.5 virginica
    ## 5          7.7         3.8          6.7         2.2 virginica
    ## 6          7.7         2.6          6.9         2.3 virginica

``` r
#Or maybe we want just the virginica species
virginica_iris<-filter(iris,Species=="virginica")
head(virginica_iris)
```

    ##   Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
    ## 1          6.3         3.3          6.0         2.5 virginica
    ## 2          5.8         2.7          5.1         1.9 virginica
    ## 3          7.1         3.0          5.9         2.1 virginica
    ## 4          6.3         2.9          5.6         1.8 virginica
    ## 5          6.5         3.0          5.8         2.2 virginica
    ## 6          7.6         3.0          6.6         2.1 virginica

``` r
#And another way to look at these as a tibble
tbl_df(virginica_iris)
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

But what if I wanted to select and filter? There are three ways to do this: use intermediate steps, nested functions, or pipes. With the intermediate steps, you essentially create a temporary data frame and use that as input to the next function. You can also nest functions (i.e. one function inside of another). This is handy, but can be difficult to read if too many functions are nested as the process from inside out. The last option, pipes, are a fairly recent addition to R. Pipes in the UNIX/Linux world are not new and allow you to chain commands together where the output of one command is the input to the next. This provides a more natural way to read the commands in that they are executed in the way you conceptualize it and make the interpretation of the code a bit easier. Pipes in R look like `%>%` and are made available via the `magrittr` package, which is installed as part of `dplyr`. We will talk a bit about this, but the best description, by far, is the section on pipes in the [R For Data Science](http://r4ds.had.co.nz/pipes.html) book.

Let's try all three with the same analysis: selecting out a subset of columns but for only a single species.

``` r
#Intermediate data frames
#Select First: note the order of the output, neat too!
dplyr_big_iris_tmp1<-select(iris,Species,Sepal.Length,Petal.Length)
dplyr_big_iris_tmp<-filter(dplyr_big_iris_tmp1,Petal.Length>=6)
head(dplyr_big_iris_tmp)
```

    ##     Species Sepal.Length Petal.Length
    ## 1 virginica          6.3          6.0
    ## 2 virginica          7.6          6.6
    ## 3 virginica          7.3          6.3
    ## 4 virginica          7.2          6.1
    ## 5 virginica          7.7          6.7
    ## 6 virginica          7.7          6.9

``` r
#Nested function
dplyr_big_iris_nest<-filter(select(iris,Species,Sepal.Length,Petal.Length),Species=="virginica")
head(dplyr_big_iris_nest)
```

    ##     Species Sepal.Length Petal.Length
    ## 1 virginica          6.3          6.0
    ## 2 virginica          5.8          5.1
    ## 3 virginica          7.1          5.9
    ## 4 virginica          6.3          5.6
    ## 5 virginica          6.5          5.8
    ## 6 virginica          7.6          6.6

``` r
#Pipes
dplyr_big_iris_pipe<-select(iris,Species,Sepal.Length,Petal.Length) %>%
  filter(Species=="virginica")
head(dplyr_big_iris_pipe)
```

    ##     Species Sepal.Length Petal.Length
    ## 1 virginica          6.3          6.0
    ## 2 virginica          5.8          5.1
    ## 3 virginica          7.1          5.9
    ## 4 virginica          6.3          5.6
    ## 5 virginica          6.5          5.8
    ## 6 virginica          7.6          6.6

Exercise 1
----------

This exercise is going to focus on using what we just covered on `dplyr` to start to clean up the National Coastal Condition Assessment data files. Remember to use the stickies.

1.  If it isn't already open, make sure you have the script we created, "nca\_analysis.R" opened up.
2.  Start a new section of code in this script by simply putting in a line or two of comments indicating what it is this set of code does.
3.  Our goal for this is to create a new data frame that represents a subset of the observations as well as a subset of the columns.
4.  We want a selection of columns from the water chemistry data. From `nca_wc` use `select` to create a new data frame called `nca_wc_subset` that contains just the following columns: SITE\_ID,PARAMETER, RESULT.
5.  From `nca_sites` we want to both select columns and filter out some observations. First, use `filter` to get VISIT\_NO equal to 1 and NCCR\_REG equal to "Northeast". Now, use `select` to select out: SITE\_ID, DATE\_COL, STATE, WTBDY\_NM, PROVINCE, STATION\_DEPTH, ALAT\_DD, and ALON\_DD. The final output data frame should be called `nca_sites_subset`.

Joins
-----

Now that we have two data frames pulled in and have cleaned them up a bit, we might want to look at ways to combine the information that is in both. We can do this by "joining" the two together. The general concept of joins stems from relational databases where you have multiple database tables that share a common field or fields.

Let's create some examples to look at.

``` r
table1 <- data.frame(id = c(1,2,3,4,5), height = seq(0,400,by=100), 
                     weight = runif(5,30,50), 
                     x = c(-73,-73,-74,-75,-72), y = c(46,47,47,48,44))
table2 <- data.frame(id = c(1,3,4), category = c("low","medium","medium-high"))
table1
```

    ##   id height   weight   x  y
    ## 1  1      0 47.30269 -73 46
    ## 2  2    100 47.71512 -73 47
    ## 3  3    200 37.73277 -74 47
    ## 4  4    300 48.23718 -75 48
    ## 5  5    400 32.97160 -72 44

``` r
table2
```

    ##   id    category
    ## 1  1         low
    ## 2  3      medium
    ## 3  4 medium-high

We can use the field that is common between the two, `id` in this case, to merge (i.e. "join") the two tables together. Databases, and by extension `dplyr`, have many ways to do these joins. We are only going to talk about one, the left join. A left join allows you to join two tables and the result is a table that has all of the records from the first table (i.e. the "left" one) and only the matching records from the second (i.e. the "right" one). Let's look at how we can use the `dplyr` function, `left_join` to do this in R.

``` r
table_1_2 <- left_join(table1, table2)
```

    ## Joining, by = "id"

``` r
table_2_1 <- left_join(table2, table1)
```

    ## Joining, by = "id"

``` r
table_1_2
```

    ##   id height   weight   x  y    category
    ## 1  1      0 47.30269 -73 46         low
    ## 2  2    100 47.71512 -73 47        <NA>
    ## 3  3    200 37.73277 -74 47      medium
    ## 4  4    300 48.23718 -75 48 medium-high
    ## 5  5    400 32.97160 -72 44        <NA>

``` r
table_2_1
```

    ##   id    category height   weight   x  y
    ## 1  1         low      0 47.30269 -73 46
    ## 2  3      medium    200 37.73277 -74 47
    ## 3  4 medium-high    300 48.23718 -75 48

Long to wide format
-------------------

Lastly, we are going to show how to do some pretty amazing data manipulation using thy `tidyr` package. One of the primary goals of `tidyr` is to facilitate converting data from a long format (a.k.a. "narrow", database style) to a wide or spreadsheet kind of format. If you are well versed in spreadsheets this is similar to restructuring a worksheet using pivot tables.

Let's look back at our example from above, specifically `table_1_2`. This would be an example of a wide formatted data set. We can use this to show the two workhorse functions in `tidyr`, `gather` and `spread`.

If we want to take this dataset and convert into a long format we use `gather` (as in we gather up selected columns and place them into two output columns as a key:value pair).

``` r
library(tidyr)
table_1_2_long <- gather(table_1_2, variable, value, 2:6)
```

    ## Warning: attributes are not identical across measure variables; they will
    ## be dropped

``` r
table_1_2_long
```

    ##    id variable            value
    ## 1   1   height                0
    ## 2   2   height              100
    ## 3   3   height              200
    ## 4   4   height              300
    ## 5   5   height              400
    ## 6   1   weight 47.3026876477525
    ## 7   2   weight 47.7151177823544
    ## 8   3   weight  37.732766373083
    ## 9   4   weight 48.2371838670224
    ## 10  5   weight 32.9715951299295
    ## 11  1        x              -73
    ## 12  2        x              -73
    ## 13  3        x              -74
    ## 14  4        x              -75
    ## 15  5        x              -72
    ## 16  1        y               46
    ## 17  2        y               47
    ## 18  3        y               47
    ## 19  4        y               48
    ## 20  5        y               44
    ## 21  1 category              low
    ## 22  2 category             <NA>
    ## 23  3 category           medium
    ## 24  4 category      medium-high
    ## 25  5 category             <NA>

Now to go the other direction, we use `spread` (as in spread out the key:value pairs in two columns into a bunch of new columns named by the key).

``` r
table_1_2_wide <- spread(table_1_2_long, variable, value)
table_1_2_wide
```

    ##   id    category height           weight   x  y
    ## 1  1         low      0 47.3026876477525 -73 46
    ## 2  2        <NA>    100 47.7151177823544 -73 47
    ## 3  3      medium    200  37.732766373083 -74 47
    ## 4  4 medium-high    300 48.2371838670224 -75 48
    ## 5  5        <NA>    400 32.9715951299295 -72 44

Exercise 2
----------

For the last exercise of the data manipulation lesson we will join our two NCCA tables together and convert them using `tidyr`.

1.  The `nca_wc_subset` data frame is in a long format (hint: look at PARAMETER and RESULT). Convert this data frame into `nca_wc_wide` using `gather`.

2.  Create a new data frame, named `ncca`, that is a combination of the the sites and water chemistry data that has only the rows we filtered our for the Northeast (hint: `left_join` and proper order).
