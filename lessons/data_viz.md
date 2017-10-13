
<insertHTML:[columns.html]

Data Visualization
========================================================
date: November 5, 2017
author: Marcus W Beck
autosize: false
css: frm.css
transition: none
width: 960
height: 700

<img src="data_viz-figure/unnamed-chunk-1-1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="800px" style="display: block; margin: auto;" />

Lesson outline
========================================================
A whirlwind tour of data viz...
* Simple plots with base R
* `ggplot2`: introduction
* `ggplot2`: scatterplots
* `ggplot2`: barchart
* `ggplot2`: customizing 
* Other cool stuff

Motivation
========================================================
* You can make some really cool graphs in R

<div align='center'>
<img src="data_viz-figure/cool1.png" alt="Drawing" style="width: 600px;"/>
</div>

Motivation
========================================================
* You can make some really cool graphs in R

<div align='center'>
<img src="data_viz-figure/cool2.jpg" alt="Drawing" style="width: 900px;"/>
</div>

Motivation
========================================================
* You can make some really cool graphs in R

<div align='center'>
<img src="data_viz-figure/cool3.jpg" alt="Drawing" style="width: 700px;"/>
</div>

Motivation
========================================================
* You can make some really cool graphs in R

3d and interactive: 
https://blog.plot.ly/post/101360048217/7-plotly-graphs-in-3d-stocks-cats-and-lakes

A CERF example:
https://fawda123.github.io/ADOSR/depth_ex

Simple plots with base R
========================================================
* Base graphics in R (i.e, those that come with the software) can do most anything for you
* But they're kind of ugly in the default format (bad for pubs)
* Customization is tedious...
* Easy to use for quick, exploratory plots

Simple plots with base R
========================================================
* The scatterplot can be created with `plot`
* Let's load the `iris` dataset from the [datasets](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html) package
* Measurements on 150 flowers from three species

```r
data(iris)
str(iris)
```

```
'data.frame':	150 obs. of  5 variables:
 $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
 $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
 $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
 $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
 $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
```

Simple plots with base R
========================================================
* The scatterplot can be created with `plot`
* Let's load the `iris` dataset from the [datasets](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html) package
* Measurements on 150 flowers from three species

```r
data(iris)
head(iris)
```

```
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species
1          5.1         3.5          1.4         0.2  setosa
2          4.9         3.0          1.4         0.2  setosa
3          4.7         3.2          1.3         0.2  setosa
4          4.6         3.1          1.5         0.2  setosa
5          5.0         3.6          1.4         0.2  setosa
6          5.4         3.9          1.7         0.4  setosa
```

Simple plots with base R
========================================================
* The scatterplot can be created with one line... `plot(y ~ x, data)`
* This literally says... from the data object, plot the variables y (on the y-axis) against x (on the x-axis)

```r
plot(Sepal.Length ~ Sepal.Width, data = iris)
```

Simple plots with base R
========================================================

```r
plot(Sepal.Length ~ Sepal.Width, data = iris)
```

<img src="data_viz-figure/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" width="700px" style="display: block; margin: auto;" />

Simple plots with base R
========================================================
* We can also use alternative notation without using the data argument

```r
plot(iris$Sepal.Width, iris$Sepal.Length)
```
* As compared to...

```r
plot(Sepal.Length ~ Sepal.Width, data = iris)
```
* Note the arrangement of y/x variables in each

Simple plots with base R
========================================================
* We can also use alternative notation without using the data argument

```r
plot(iris$Sepal.Width, iris$Sepal.Length)
```

<img src="data_viz-figure/unnamed-chunk-8-1.png" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" width="600px" style="display: block; margin: auto;" />

Simple plots with base R
========================================================
* But check out the axis labels...

```r
plot(iris$Sepal.Width, iris$Sepal.Length)
```

<img src="data_viz-figure/unnamed-chunk-9-1.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" width="600px" style="display: block; margin: auto;" />

Simple plots with base R
========================================================
* `plot` has lots of optional arguments, called within `plot` or separately using `par`
<div align='center'>
<img src="data_viz-figure/plotopt.png" alt="Drawing" style="width: 900px;"/>
</div> 

Simple plots with base R
========================================================
* Change axis labels, give it a title...

```r
plot(iris$Sepal.Width, iris$Sepal.Length, xlab = 'Width (cm)', ylab = 'Length (cm)', main = 'Sepal dimensions')
```

<img src="data_viz-figure/unnamed-chunk-10-1.png" title="plot of chunk unnamed-chunk-10" alt="plot of chunk unnamed-chunk-10" width="600px" style="display: block; margin: auto;" />

Simple plots with base R
========================================================
* The plot margins are too big, let's change that

```r
par(mar = c(4.5, 4.5, 1, 1))
plot(iris$Sepal.Width, iris$Sepal.Length, xlab = 'Width (cm)', ylab = 'Length (cm)', main = 'Sepal dimensions')
```

<img src="data_viz-figure/unnamed-chunk-11-1.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" width="600px" style="display: block; margin: auto;" />

Simple plots with base R
========================================================
* Other base plot functions - bar plots

```r
barplot(table(iris$Species))
```

<img src="data_viz-figure/unnamed-chunk-12-1.png" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" width="700px" style="display: block; margin: auto;" />

Simple plots with base R
========================================================
* Other base plot functions - histogram

```r
hist(iris$Sepal.Length)
```

<img src="data_viz-figure/unnamed-chunk-13-1.png" title="plot of chunk unnamed-chunk-13" alt="plot of chunk unnamed-chunk-13" width="700px" style="display: block; margin: auto;" />

Simple plots with base R
========================================================
* Other base plot functions - paired scatter plots

```r
pairs(iris)
```

<img src="data_viz-figure/unnamed-chunk-14-1.png" title="plot of chunk unnamed-chunk-14" alt="plot of chunk unnamed-chunk-14" width="700px" style="display: block; margin: auto;" />

<code>ggplot2</code>: overview
========================================================
* Base graphics are okay for exploratory stuff
* ggplot2 is meant to improve on base by linking the graph components following a **grammar of graphics** 
* Makes thinking, reasoning, and communicatings graphics easier
* Start with a foundational component to add additional pieces

<div align='center'>
<img src="data_viz-figure/ggplot2_hex.png" alt="Drawing" style="width: 100px;"/>
</div>


`ggplot2`: scatterplots
========================================================
ex

`ggplot2`: barchart
========================================================
ex

`ggplot2`: customizing
========================================================
ex

Other cool stuff
========================================================
ex

Sources of help
========================================================
ex
