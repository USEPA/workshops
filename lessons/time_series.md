
<insertHTML:[columns.html]

Analysis of Time Series Data Using R
========================================================
date: November 5, 2017
author: Marcus W Beck
autosize: true
css: frm.css
transition: none
width: 960
height: 700

<img src="time_series-figure/unnamed-chunk-1-1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="800px" style="display: block; margin: auto;" />

========================================================
<div align='center'>
<img src="time_series-figure/harry.jpg" alt="Drawing" style="width: 800px;"/>
</div>

========================================================
<div align='center'>
<img src="time_series-figure/onedoesnot.jpg" alt="Drawing" style="width: 600px;"/>
</div>

========================================================
<div align='center'>
<img src="time_series-figure/aliens.jpg" alt="Drawing" style="width: 600px;"/>
</div>

Lesson outline
========================================================
* Properties of time series
* Types of WQ/estuarine time series
* Exploratory analysis
* Quick QAQC 
* Formal trend tests

<img src="time_series-figure/aliens.jpg" alt="Drawing" style="width: 250px;"/>

What is a time series
========================================================
* As Hagrid says, anything with a time stamp
* Otherwise, it's a steady state dataset
* In theory, all data sets are time series
* Time series analysis considers observation **order** as a defining factor

What is a time series
========================================================
**Observations indexed and ordered by a time stamp**, they come in many shapes and sizes

<img src="time_series-figure/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" width="900px" style="display: block; margin: auto;" />

What is a time series
========================================================
**Observations indexed and ordered by a time stamp**, they can be composed of parts (real or artificial)
<img src="time_series-figure/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" width="900px" style="display: block; margin: auto;" />

What is a time series
========================================================
**Observations indexed and ordered by a time stamp**, they can be multivariate
<img src="time_series-figure/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" width="900px" style="display: block; margin: auto;" />

What is a time series
========================================================
**Observations indexed and ordered by a time stamp**, they can be multivariate
<img src="time_series-figure/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" width="900px" style="display: block; margin: auto;" />

Properties of time series
========================================================
incremental: true

Assumptions for basic parametric models:
* Residuals are individually normally distributed
* Constant variance or homogeneity (i.e., even spread of residuals)
* Explanatory variables are deterministic
* Independence of observations or no pattern in residuals

Properties of time series
========================================================
Assumptions for basic parametric models:

```r
x <- rnorm(100)
y <- x + rnorm(100)
par(mfrow = c(1, 3))
plot(x); plot(y)
plot(y ~ x)
abline(reg = lm(y ~ x))
```

<img src="time_series-figure/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" width="900px" style="display: block; margin: auto;" />

Properties of time series
========================================================
Assumptions for basic parametric models:

```r
par(mfrow = c(2, 2))
mod1 <- lm(y ~ x)
plot(mod1)
```

<img src="time_series-figure/unnamed-chunk-7-1.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" width="900px" style="display: block; margin: auto;" />

Properties of time series
========================================================
Assumptions for basic parametric models:

```r
x <- cumsum(x)
y <- cumsum(y)
par(mfrow = c(1, 3))
plot(x); plot(y)
plot(y ~ x)
abline(reg = lm(y ~ x))
```

<img src="time_series-figure/unnamed-chunk-8-1.png" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" width="900px" style="display: block; margin: auto;" />

Properties of time series
========================================================
Assumptions for basic parametric models:

```r
mod2 <- lm(y ~ x)
par(mfrow = c(2, 2))
plot(mod2)
```

<img src="time_series-figure/unnamed-chunk-9-1.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" width="900px" style="display: block; margin: auto;" />

Properties of time series
========================================================
Assumptions for basic parametric models:

```r
par(mfrow = c(1, 2))
acf(resid(mod1))
acf(resid(mod2))
```

<img src="time_series-figure/unnamed-chunk-10-1.png" title="plot of chunk unnamed-chunk-10" alt="plot of chunk unnamed-chunk-10" width="900px" style="display: block; margin: auto;" />

Properties of time series
========================================================
incremental: true

* Time series violate the common assumption that observations are independent
* Time is a 'nuisance' variable that must be accounted for
* Time has interesting properties that can be leveraged for analysis
* The structure of time series also represents analysis overhead

Exercise 1: A gentle introduction
========================================================
incremental: true

1) Load the datasets `sapdc` and `apacp`

2) What are the variables?

3) What is the time range?

4) What is the time step?

5) Bonus: plot a time series

Exercise 1: A gentle introduction
========================================================
1) Load the datasets `sapdc` and `apacp`

https://USEPA.github.io/cerf_r/lessons/data/sapdc.RData

https://USEPA.github.io/cerf_r/lessons/data/apacp.RData

```r
load('data/sapdc.RData')
load('data/apacp.RData')
```
2) what are the variables?

3) What is the time range?

4) What is the time step?

5) Bonus: plot a time series

Exercise 1: A gentle introduction
========================================================

```r
head(sapdc)
```

```
        DateTimeStamp Temp  Sal DO_obs ATemp   BP WSpd      Tide
1 2012-01-01 00:00:00 14.9 33.3    5.0  11.9 1022  0.5 0.8914295
2 2012-01-01 00:30:00 14.9 33.4    5.5  11.3 1022  0.6 1.0011830
3 2012-01-01 01:00:00 14.9 33.4    5.9   9.9 1021  0.6 1.0728098
4 2012-01-01 01:30:00 14.8 33.3    6.4  10.0 1022  2.4 1.1110885
5 2012-01-01 02:00:00 14.7 33.2    6.6  11.4 1022  1.3 1.1251628
6 2012-01-01 02:30:00 14.7 33.3    6.1  10.7 1021  0.0 1.1223799
```

```r
head(apacp)
```

```
        date    po4   nh4   no2   no3   no23 chla
1 2002-04-02 0.0040 0.028 0.002 0.047 0.0490 1.80
2 2002-04-30 0.0140 0.138 0.005 0.115 0.1200 1.20
3 2002-06-04 0.0060 0.049 0.002 0.024 0.0260 3.40
4 2002-07-02 0.0155 0.088 0.002    NA 0.0395 3.35
5 2002-08-06 0.0110 0.040 0.003 0.036 0.0390 7.80
6 2002-09-10 0.0260 0.039 0.003 0.013 0.0160 0.80
```

Exercise 1: A gentle introduction
========================================================

https://beckmw.shinyapps.io/swmp_comp/

<div align='center'>
<img src="time_series-figure/swmp_comp.png" alt="Drawing" style="width: 800px;"/>
</div>

Types of WQ/estuarine time series
========================================================
* discrete monitoring data (e.g., nutrient data)
  * Many large systems have these data
  * Good for trend analysis
  * Typically a monthly time step
  * Detection limits can be an issue
  
  ***
<div align='center'>
<img src="time_series-figure/tb_map.png" alt="Drawing" style="width: 600px;"/>
</div>

Types of WQ/estuarine time series
========================================================
* continuous sonde data (e.g., dissolved oxygen, tidal height)
  * More common for site-level analysis
  * Time steps can be 'continuous'
  * Good for signal processing
  * Observations are more correlated
  
<img src="time_series-figure/unnamed-chunk-13-1.png" title="plot of chunk unnamed-chunk-13" alt="plot of chunk unnamed-chunk-13" width="600px" style="display: block; margin: auto;" />

Exercise 2: A less gentle introduction
========================================================
Now we will import the raw data for apacp, sapdc and format for time series analysis

1) Load the datasets in R

https://usepa.github.io/cerf_r/lessons/data/apacp.txt
https://usepa.github.io/cerf_r/lessons/data/sapdc.txt

2) Format the time series column

Exercise 2: A less gentle introduction
========================================================

1) Load the datasets in R





































































```
Error in file(file, "rt") : cannot open the connection
```
