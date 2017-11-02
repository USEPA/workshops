
Spatial/GIS Analysis with R
===========================

Given the size of this topic and limited time we have to spend on it this introduction of Spatial and GIS analyses with R is going to focus on one type of spatial data, vector, and one class of spatial data structures in r, simple features.

Lesson Outline
--------------

-   [Required packages](#required-spatial-packages)
-   [Read in spatial data](#read-in-spatial-data)
-   [Spatial data manipulation](#spatial-data-manipulation)
-   [Projections](#projections)
-   [Spatial data visualization](#spatial-data-visualization)
-   [Example spatial workflow](#example-spatial-workflow)

Lesson Exercises
----------------

-   [Exercise 1](#exercise-1)
-   [Exercise 2](#exercise-2)
-   [Exercise 3](#exercise-3)

Required packages
-----------------

Since the late 2000's there has been a rapid increase in the spatial data handling and analysis capability of R. The `rgdal`, `rgeos`, `raster`, and `sp` packages (through the very significant effort of the package authors) provided the foundation for doing GIS entirely within R. More recently a new route for handling vector data has emerged in the [`sf` package](https://cran.r-project.org/package=sf). Most current development for vector processing is focusing on `sf`. As such, this workshop will as well. Raster data is still dealt with via [`raster`](https://cran.r-project.org/package=raster). As mentioned, in this workshop we will only be focusing on a single class of data: vector data as represented by simple features. Thus, we only need a single package.

### sf

The [`sf` package](http://r-spatial.github.io/sf/) provides vector data handling via the Simple Features standard, an Open Geospatial Consortium and International Standards Organization standard for spatial data. In addition, `sf` provides a tidy spatial data format that allows for manipulation with the popular `dplyr` package.

Getting `sf` added is no different than adding any other package that is on CRAN.

``` r
install.packages("sf")
library("sf")
```

Read in spatial data
--------------------

Exercise 1
----------

Spatial data manipulation
-------------------------

Projections
-----------

Exercise 2
----------

Spatial data visualization
--------------------------

Exercise 3
----------

Example spatial workflow
------------------------
