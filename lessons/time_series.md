
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
<img src="time_series-figure/harry.jpg" alt="Drawing" style="width: 600px;"/>
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
* What is a time series 
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




Properties of time series
========================================================
Craziness - date are ordered by time stamp

Properties of time series
========================================================
Time series structures in R

Properties of time series
========================================================
R packages for time series analysis

Types of WQ/estuarine time series
========================================================
discrete
continuous
regular/irregular, censored

Exploratory analysis
========================================================
Basic plots (use lubridate for conditional plots), decomposition plots, acf

QAQC screening
========================================================
complete cases? 
censored data?
bogus data?
missing observations (omit? impute?)

Formal trend analysis methods
========================================================
Kendall tests

Exercises
========================================================
exercise
