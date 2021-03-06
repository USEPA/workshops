
 
# Setting up R to do GIS
Out of the box, R is not ready to do GIS analysis.  As such, we need to add a few packages that will provide most of the functionality you'd expect out of a GIS.  In this lesson we will introduce the bare minimum packages for doing GIS.

## Lesson Outline
- [Required packages](#required-packages)
- [Interacting with an external GIS](#interacting-with-an-external-gis)

## Lesson Exercises
- [Exercise 1.1](#exercise-11)

## Required packages
Within in the last several years there has been a lot of effort spent on adding spatial data handling and analysis capability to R.  Thanks to the very significant effort of the package authors we now have the foundation for doing GIS entirely within R. ***Aside:*** *R may not always be the best choice for a given GIS task, but at least now it is a possible choice.  This is a discussion though, for another time*

The four packages that provide this foundation are:

- [sp](https://cran.r-project.org/web/packages/sp/index.html)
- [rgdal](https://cran.r-project.org/web/packages/rgdal/index.html)
- [raster](https://cran.r-project.org/web/packages/raster/index.html)
- [rgeos](https://cran.r-project.org/web/packages/rgeos/index.html)

Let's dig in a bit deeper on each of these.

### sp
The `sp` package provides the primary spatial data structures for use in R.  Many other packages assume your data is stored as one of the `sp` data structures.  Getting into the details of these is beyond the scope of this workshop, but look at the [introduction to sp vignette for more details](https://cran.r-project.org/web/packages/sp/vignettes/intro_sp.pdf).  That being said, we will be working mostly with `SpatialPointsDataFrame` and `SpatialPolygonsDataFrame`.  More on that later.

Getting `sp` added is no different than adding any other package that is on CRAN.


```r
install.packages("sp")
library("sp")
```

### rgdal
The `rgdal` package provides tools for reading and writing multiple spatial data formats.  It is based on the [Geospatial Data Abstraction Library (GDAL)](http://www.gdal.org/) which is a project of the Open Source Geospatial Foundation (OSGeo).  The primary use of `rgdal` is to read various spatial data formats into R and store them as `sp` objects.  In this workshop, we will be only using `rgdal` to read in shape files, but it has utility far beyond that.  

As before, nothing special to get set up with `rgdal` on windows.  Simply:


```r
install.packages("rgdal")
library("rgdal")
```

Getting set up on Linux or Mac requires more effort (i.e. need to have GDAL installed).  As this is for a USEPA audience the windows installs will work for most.  Thus, discussion of this is mostly beyond the scope of this workshop.  

### raster
Although `sp` and `rgdal` provide raster data capabilities, they do require that the full raster dataset be read into memory.  This can have some performance implications as well as limits the size of datasets you can readily work with.  The `raster` package works around this by working with raster data on the disk.  That too has some performance implications, but for the most part, in my opinion anyway, `raster` makes it easier to work with raster data.  It also provides several additional functions for analyzing raster data.  

To install, just do: 


```r
install.packages("raster")
library("raster")
```

### rgeos
The last of the core packages for doing GIS in R is `rgeos`.  Like `rgdal`, `rgeos` is a project of OSgeo.  It is a wrapper around the [Geometry Engine Open Source](https://trac.osgeo.org/geos/) c++ library and provides a suite of tools for conducting vector GIS analyses.  

To install on windows


```r
install.packages("rgeos")
library("rgeos")
```

For Linux and Mac the GEOS library will also need to be available.  As with `rgdal` this is a bit beyond the scope of this workshop.  One item to note for US EPA Linux users.  The official Linux OS is Red Hat 6.  There have been reports of problems with the version of GEOS available for Red Hat 6.  If this applies to you, contact [me](mailto::hollister.jeff@epa.gov) for details on how to solve this (assuming I can remember how I did it).

## Exercise 1.1
The first exercise won't be too thrilling, but we need to make sure everyone has the four packages installed. 

1.) Install `sp` and load `sp` into your library.
2.) Repeat, with `rgdal`, `raster`, and `rgeos`.


## Interacting with an external GIS
Although we won't be working with external GIS in this workshop, there are several packages that provide ways to move back and forth from another GIS and R.  

- [spgrass6](https://cran.r-project.org/web/packages/spgrass6/index.html): Provides an interface between R and [GRASS 6+](https://grass.osgeo.org/download/software/#g64x).  Allows for running R from within GRASS as well as running GRASS from within R.  
- [rgrass7](https://cran.r-project.org/web/packages/rgrass7/index.html): Same as `spgrass6`, but for the latest version of GRASS, [GRASS 7](https://grass.osgeo.org/download/software/#g70x).
- [RPyGeo](https://cran.r-project.org/web/packages/RPyGeo/index.html): A wrapper for accessing ArcGIS from R.  Utilizes intermediate python scripts to fire up ArcGIS.  Hasn't been updated in some time.
- [RSAGA](https://cran.r-project.org/web/packages/RSAGA/index.html): R interface to the command line version of [SAGA GIS](http://www.saga-gis.org/en/index.html).







