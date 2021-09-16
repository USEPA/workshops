
## 2021 USEPA R User Group Workshop Agenda

#### On-line participation details:

This year's workshop will be fully virtual, held on the afternoons (1-5pm eastern) of Sept 21st, 22nd, and 23rd, 2021.  Details on remote participation option for the presentations and workshops will be sent to participants closer to the workshop dates.  The agenda below is preliminary and may change before the workshop.

#### Twitter (not officially sanctioned)

We've been using #eparstats for EPA related R events.  Feel free to live tweet, unless otherwise directed!

## Tue, September 21

|Time (EDT)     |Title                    |Speaker                  |
|---------------|-------------------------|-------------------------|
||**Introduction and Welcome**||
|1:00pm - 1:10pm||Jeff Hollister, USEPA/ORD/CEMM and Anne Vega, USEPA/ORD/OSIM|
|1:10pm - 1:20pm||Vince Allen, USEPA Chief IT Architect, USEPA/OMS/ODSTA|
||**Keynote**||
|1:20pm - 2:20pm|Object of type 'closure' is not subsettable|Jenny Bryan, RStudio|
|2:20pm - 2:30pm|**Break**||
||**Invited Talks**||
|2:30pm - 2:50pm|Rivers & gages & forecasts, oh my! Visualizing water data in R with the USGS Vizlab|Colleen Nell, USGS|
|2:50pm - 3:10pm|Introducing the River Basin Export Reduction Optimization Support Tool (RBEROST)|Catherine Chamberlain, ORISE/USEPA/CEMM|
|3:10pm - 3:30pm|Automating Spatial Data Extraction|Thomas Barnum, USEPA/ORD/CPHEA|
|3:30pm - 3:50pm|Statistical Measures of Inequality in Disadvantaged Communities to Underground Storage Tanks + Decision Applications with Shiny|Andrew Murray, ORISE/USEPA/CESER|
|3:50pm - 4:00pm|**Break**||
|4:00pm - 4:20pm|Creating Automated, Custom Fact Sheets in R Markdown|Marschall Furman, ORISE/USEPA/CPHEA and Nichole Kulikowski, USEPA/CPHEA|
|4:20pm - 4:40pm|Deployment Options for EPA Shiny Apps|Steven Pfeiffer, USEPA/ORD/OSIM|
|4:40pm - 5:00pm|Overview of the Puget Sound Air Sensor Dashboard|Graeme Carvlin, Puget Sound Clean Air Agency|
||**Evening Activities**||
|5:00pm - 6:00pm|Virtual Happy Hour|All!|

## Wed, September 22

Session 2 will be split into 3 parallel sessions, all taking place from 1pm-5pm:

|Track  |Title                         |Lead                       |
|-------|------------------------------|---------------------------|
|1|Intro to R (Part 1)|Nichole Kulikowski|
|2|Intro to tidy models|R Studio|
|3|Using R Packages for Reproducible Workflows|Michael Dumelle|

## Thu, September 23

Session 3 will be split into 3 parallel sessions, all taking place from 1pm-5pm:

|Track  |Title                         |Lead                       |
|-------|------------------------------|---------------------------|
|1|Intro to R (Part 2)|Nichole Kulikowski|
|2|Big Data with R|R Studio|
|3|Spatial Data and Analysis in R|Marc Weber|



#### Workshop Descriptions:

- **Introduction to R (2 days):** Participants in this workshop will be introduced to R through the lense of the "Tidyverse" as well as learn basics of the R Language for statistical computing.  In particular we will: 1) learn the fundamentals of R including syntax, functions, and packages; 2) spend quality time with the core R data structure, the data frame; 3) learn how to manipulate our data with the `dplyr` and `tidyr` packages; and 4) gain expereince creating data visualizations with `ggplot2`.  Our goal is to set learners up with a foundation for future exploration of R.
- **Intro to tidy models (1 day):** RStudio will be giving an introduction to Tidymodels. Tidymodels is a collection of packages for modeling and machine learning using tidyverse principles. In this session we'll introduce functions from rsample, recipes, parsnip, and yardstick. You'll learn how to split data, fit a model, predict, and compare outcomes with a workflow that easily allows you to change and compare model types.  A training environment with R and RStudio will be provided for all participants. [Example content here](https://github.com/rstudio-education/tidymodels-virtually)
- **Using R Packages for Reproducible Workflows (1 day):** In this workshop. we show how R packages can be used to complement your workflow. We discuss how the structure of an R package lets you easily combine your R functions with your data, code, and manuscript to create a reproducible product that is easy to share with your colleagues. We cover writing R functions, how to build an R package, how to build fully reproducible, dynamic documents/reports that combine code and text, how to use a Git/GitHub repository alongside your R package, and some extra tips and tricks.
- **Big Data with R (1 day):** This workshop covers how to analyze large amounts of data in R. We will focus on scaling up our analyses using the same dplyr verbs that we use in our everyday work. We will use dplyr with data.table, databases, and Spark . We will also cover best practices on visualizing, modeling, and sharing against these data sources. Where applicable, we will review recommended connection settings, security best practices, and deployment options.  [Example content here](https://github.com/rstudio-conf-2020/big-data)
- **Spatial Data and Analysis in R (1 day):** This workshop will provide an introduction to the current GIS ecosystem in R.  We’ll demonstrate use of packages such as sf, raster, terra, stars, tmap, mapview and others.  The workshop will provide an overview of both vector and raster I/O in R, vector geocomputation operations such as spatial subsetting, spatial joins, spatial aggregation, and distance operations as well as raster operations such as map algebra  We’ll cover coordinate reference systems and projections in R as well as mapping in R.  We’ll also look at examples of exploratory spatial data analysis (ESDA) in R, data transformation and processing, data visualization, and spatial analysis in R in the context of reproducible research.
