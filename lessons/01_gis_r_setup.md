

# Setting up R to do GIS
Out of the box, R is not ready to do GIS analysis.  As such, we need to add a few packages that will provide most of the functionality you'd expect out of a GIS.  In this lesson we will introduce both the bare minimum packages for doing GIS as well as discuss additional packages that provide more advanced GIS analysis and visualization.

## Lesson Outline
- [Required packages](#required-packages)
- [Advanced GIS analysis packages](#advanced-gis-analysis-packages)
- [Visualization packages](#visualization-packages)

## Required packages
Within in the last several years there has been a lot of effort spent on adding spatial data handling and analysis capability to R.  Thanks to the very significant effort of the package authors we now have the foundation for doing GIS entirely within R. ***Aside:*** *R may not always be the best choice for a given GIS task, but at least now it is a possible choice.  This is a discussion though, for another time*

The four packages that provide this foundation are:

- [sp](https://cran.r-project.org/web/packages/sp/index.html)
- [rgdal](https://cran.r-project.org/web/packages/rgdal/index.html)
- [raster](https://cran.r-project.org/web/packages/raster/index.html)
- [rgeos](https://cran.r-project.org/web/packages/rgeos/index.html)

Let's dig in a bit deeper on each of these.

### sp
The `sp` package was originally developed by Edzer Pebesma and Roger Bivand.  Many others have contributed.  It provides the primary spatial data strucutres for use in R.  Many other packages assume your data is stored as one of the `sp` data structures.  Getting into the details of these is beyond the scope of this workshop, but look at the [introduction to sp vignette for more](https://cran.r-project.org/web/packages/sp/vignettes/intro_sp.pdf) details.  That being said, we will be working specifically with `SpatialPoints`, `SpatialPointsDataFrame`, `SpatialPolygons`, and `SpatialPolygonsDataFrame`.  More on that later.

Getting `sp` added is no different than adding any other package that is on CRAN.


```r
install.packages("sp")
library("sp")
```

### rgdal

### raster

### rgeos

## Advanced GIS analysis packages

## Visualization packages

## Lesson Exercises
- [Exercise 1.1](#exercise-11)

## Exercise 1.1
