
<insertHTML:[columns.html]

Data Visualization
========================================================
date: November 5, 2017
author: Marcus W Beck
autosize: true
css: frm.css
transition: none

<img src="data_viz-figure/unnamed-chunk-1-1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="800px" style="display: block; margin: auto;" />

Lesson outline
========================================================
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
* The scatterplot can be created with one line... `plot(y ~ x, data)`

```r
data(iris)
plot(Sepal.Length ~ Sepal.Width, data = iris)
```

![plot of chunk unnamed-chunk-2](data_viz-figure/unnamed-chunk-2-1.png)

Simple plots with base R
========================================================
* The scatterplot can be created with one line... `plot(data$x, data$y)`

```r
plot(iris$Sepal.Width, iris$Sepal.Length)
```

![plot of chunk unnamed-chunk-3](data_viz-figure/unnamed-chunk-3-1.png)

`ggplot2`: overview
========================================================
ex

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
