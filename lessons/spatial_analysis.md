

# Spatial/GIS Analysis with R

Given the size of this topic and limited time we have to spend on it this introduction of Spatial and GIS analyses with R is going to focus on one type of spatial data, vector, and one class of spatial data structures in r, simple features.

## Lesson Outline
- [Required packages](#required-spatial-packages)
- [Read in spatial data](#read-in-spatial-data)
- [Spatial data manipulation](#spatial-data-manipulation)
- [Projections](#projections)
- [Spatial data visualization](#spatial-data-visualization)

## Lesson Exercises
- [Exercise 1](#exercise-1)
- [Exercise 2](#exercise-2)
- [Exercise 3](#exercise-3)

## Required packages

 Since the late 2000's there has been a rapid increase in the spatial data handling and analysis capability of R.  The `rgdal`, `rgeos`, `raster`, and `sp` packages (through the very significant effort of the package authors) provided the foundation for doing GIS entirely within R. More recently a new route for handling vector data has emerged in the [`sf` package](https://cran.r-project.org/package=sf).  Most current development for vector processing is focusing on `sf`.  As such, this workshop will as well.  Raster data is still dealt with via [`raster`](https://cran.r-project.org/package=raster). As mentioned, in this workshop we will only be focusing on a single class of data: vector data as represented by simple features.  Thus, we only need a single package. 

### sf
The [`sf` package](http://r-spatial.github.io/sf/) provides vector data handling via the Simple Features standard, an Open Geospatial Consortium and International Standards Organization standard for spatial data. In addition, `sf` provides a tidy spatial data format that allows for manipulation with the popular `dplyr` package.

Getting `sf` added is no different than adding any other package that is on CRAN.


```r
install.packages("sf")
library("sf")
```

## Read in spatial data 

For this workshop, I have collected a couple of example datasets to use and have included them in this repository.  So, let's first grab the dataset.  It is stored as a zip file.  You can download it [directly from this link](https://usepa.github.io/cerf_r/data.zip), but most of you should have done this prior to the workshop.  Let's find this file and unzip it into our project.  We can do this via our trusty point and click methods or we can use R. The code below assumes the data is in my Downloads folder and that I am in the correct working directory in R.


```r
unzip("C:/Users/JHollist/Downloads/data.zip", overwrite = TRUE)
```

For many, shapefiles are going to be the most common way to interact with spatial data.  Thus, our efforts today will look just at working with a shapefile.  With `sf`, reading in in shapefiles is straightforward via the `st_read()` function.


```r
ri_towns <- st_read("data/muni97d.shp")
```

```
## Reading layer `muni97d' from data source `C:\data\cerf_r\lessons\data\muni97d.shp' using driver `ESRI Shapefile'
## Simple feature collection with 396 features and 12 fields
## geometry type:  POLYGON
## dimension:      XY
## bbox:           xmin: 220310.4 ymin: 23048.49 xmax: 432040.9 ymax: 340916.6
## epsg (SRID):    NA
## proj4string:    +proj=tmerc +lat_0=41.08333333333334 +lon_0=-71.5 +k=0.99999375 +x_0=99999.99999999999 +y_0=0 +datum=NAD83 +units=us-ft +no_defs
```

We will get more into working with `sf` object and visualizing spatial data later, but just to prove that this did something:


```r
plot(st_geometry(ri_towns))
```

![plot of chunk towns_chk](figure/towns_chk-1.png)

The spatial data types that `sf` recognizes follow the general concept of points, lines and polygons.  You can see for this that the Rhode Island  are read in as a POLYGON.  Details on these are beyond what we can cover in this short workshop, but the `sf` documentation does a good job, in particular the [Simple Features in R vignette](https://r-spatial.github.io/sf/articles/sf1.html).

## Exercise 1

1. Make sure you have `sf` installed and added to your session via `library`
2. Make sure the data folder is available in your project
3. Read in the `SAV16.shp` into an `sf` data frame called `sav`.

## Spatial data manipulation

The greatest thing about the `sf` objects is that the tricks you know for working with data frames will also work. This is becuase `sf` objects are data frames that hold the geographic information in a special list-column.  In addition to being data frames, `sf` was designed to work with the [`tidyverse`](https://tidyverse.org) and are organized as [tidy data.](http://vita.had.co.nz/papers/tidy-data.html)  This allows us to subset our spatial data, summarize data, etc. using the tools in the `tidyverse`, most notabley `dplyr`.  If you haven't worked with spatial data in R the "old way", then you can't fully appreciate how much this should:

![](https://media.giphy.com/media/3o7TKSjRrfIPjeiVyM/giphy.gif)

Suffice it to say, it is really cool!

Again since we are limited with our time we are just going to show some simple ways that we can work with these datasets and manipulate them.

We've already seen how to use the default print statements to look at the basics


```r
ri_towns
```

We can get more info on the data with the usual data frame tools:


```r
head(ri_towns)
```

```
## Simple feature collection with 6 features and 12 fields
## geometry type:  POLYGON
## dimension:      XY
## bbox:           xmin: 246748.8 ymin: 282524.2 xmax: 360358 ymax: 340916.6
## epsg (SRID):    NA
## proj4string:    +proj=tmerc +lat_0=41.08333333333334 +lon_0=-71.5 +k=0.99999375 +x_0=99999.99999999999 +y_0=0 +datum=NAD83 +units=us-ft +no_defs
##         AREA PERIMETER RITOWN5K_ RITOWN5K_I             NAME MCD CFIPS
## 1  788769737 134174.19         2        380       CUMBERLAND  20     7
## 2  219887686  61203.98         3          1       WOONSOCKET  80     7
## 3  693661121 122732.51         4          2 NORTH SMITHFIELD  55     7
## 4 1588026224 166984.85         5          3     BURRILLVILLE   5     7
## 5  527562041 117805.34         6        381          LINCOLN  45     7
## 6  769680403 111353.48         7          4       SMITHFIELD  75     7
##       COUNTY OSP CFIPS_MCD TWNCODE LAND                       geometry
## 1 PROVIDENCE   8      7020      CU    Y POLYGON ((339469.65625 3405...
## 2 PROVIDENCE  39      7080      WO    Y POLYGON ((320285.09375 3394...
## 3 PROVIDENCE  25      7055      NS    Y POLYGON ((299086.65625 3388...
## 4 PROVIDENCE   3      7005      BU    Y POLYGON ((303493.28125 3100...
## 5 PROVIDENCE  17      7045      LI    Y POLYGON ((331461.675 320529...
## 6 PROVIDENCE  31      7075      SM    Y POLYGON ((303493.28125 3100...
```

```r
summary(ri_towns)
```

```
##       AREA             PERIMETER          RITOWN5K_       RITOWN5K_I   
##  Min.   :1.500e+01   Min.   :    22.8   Min.   :  0.0   Min.   :  0.0  
##  1st Qu.:2.270e+03   1st Qu.:   209.0   1st Qu.:110.5   1st Qu.:108.8  
##  Median :8.864e+03   Median :   427.9   Median :211.5   Median :207.5  
##  Mean   :7.561e+07   Mean   : 18306.5   Mean   :211.5   Mean   :208.1  
##  3rd Qu.:9.226e+04   3rd Qu.:  1620.2   3rd Qu.:310.2   3rd Qu.:308.2  
##  Max.   :1.741e+09   Max.   :388647.1   Max.   :422.0   Max.   :420.0  
##                                                                        
##               NAME          MCD            CFIPS               COUNTY   
##  LITTLE COMPTON : 75   Min.   : 5.00   Min.   : 1.000   BRISTOL   : 16  
##  NEWPORT        : 66   1st Qu.:10.00   1st Qu.: 5.000   KENT      : 14  
##  CHARLESTOWN    : 40   Median :20.00   Median : 5.000   NEWPORT   :200  
##  NARRAGANSETT   : 38   Mean   :19.76   Mean   : 6.321   PROVIDENCE: 29  
##  SOUTH KINGSTOWN: 31   3rd Qu.:25.00   3rd Qu.: 9.000   WASHINGTON:137  
##  PORTSMOUTH     : 23   Max.   :80.00   Max.   :10.000                   
##  (Other)        :123                                                    
##       OSP          CFIPS_MCD       TWNCODE    LAND             geometry  
##  Min.   : 1.00   Min.   :1005   LC     : 75   Y:396   POLYGON      :396  
##  1st Qu.:18.00   1st Qu.:5010   NE     : 66           epsg:NA      :  0  
##  Median :20.00   Median :5030   CH     : 40           +proj=tmer...:  0  
##  Mean   :20.12   Mean   :6318   NA     : 38                              
##  3rd Qu.:27.00   3rd Qu.:9005   SK     : 31                              
##  Max.   :39.00   Max.   :9040   PO     : 23                              
##                                 (Other):123
```

```r
names(ri_towns)
```

```
##  [1] "AREA"       "PERIMETER"  "RITOWN5K_"  "RITOWN5K_I" "NAME"      
##  [6] "MCD"        "CFIPS"      "COUNTY"     "OSP"        "CFIPS_MCD" 
## [11] "TWNCODE"    "LAND"       "geometry"
```

```r
# Look at individual columns
ri_towns$NAME
```

```
##   [1] CUMBERLAND       WOONSOCKET       NORTH SMITHFIELD BURRILLVILLE    
##   [5] LINCOLN          SMITHFIELD       GLOCESTER        CENTRAL FALLS   
##   [9] PAWTUCKET        NORTH PROVIDENCE JOHNSTON         PROVIDENCE      
##  [13] EAST PROVIDENCE  SCITUATE         FOSTER           PROVIDENCE      
##  [17] PROVIDENCE       PROVIDENCE       CRANSTON         EAST PROVIDENCE 
##  [21] EAST PROVIDENCE  EAST PROVIDENCE  EAST PROVIDENCE  EAST PROVIDENCE 
##  [25] EAST PROVIDENCE  EAST PROVIDENCE  BARRINGTON       BARRINGTON      
##  [29] BARRINGTON       WARWICK          BARRINGTON       BARRINGTON      
##  [33] BARRINGTON       WARREN           BARRINGTON       WARWICK         
##  [37] BARRINGTON       WARWICK          WARWICK          WARWICK         
##  [41] BARRINGTON       BARRINGTON       WARREN           WEST WARWICK    
##  [45] COVENTRY         BRISTOL          WARREN           WARWICK         
##  [49] WARWICK          BRISTOL          WARWICK          WARWICK         
##  [53] BRISTOL          TIVERTON         WARWICK          PORTSMOUTH      
##  [57] EAST GREENWICH   WEST GREENWICH   PORTSMOUTH       PORTSMOUTH      
##  [61] NORTH KINGSTOWN  PORTSMOUTH       PORTSMOUTH       PORTSMOUTH      
##  [65] PORTSMOUTH       PORTSMOUTH       PORTSMOUTH       PORTSMOUTH      
##  [69] PORTSMOUTH       PORTSMOUTH       PORTSMOUTH       PORTSMOUTH      
##  [73] PORTSMOUTH       PORTSMOUTH       PORTSMOUTH       PORTSMOUTH      
##  [77] PORTSMOUTH       PORTSMOUTH       PORTSMOUTH       PORTSMOUTH      
##  [81] EXETER           NORTH KINGSTOWN  PORTSMOUTH       TIVERTON        
##  [85] NORTH KINGSTOWN  NORTH KINGSTOWN  TIVERTON         TIVERTON        
##  [89] JAMESTOWN        NORTH KINGSTOWN  RICHMOND         LITTLE COMPTON  
##  [93] MIDDLETOWN       NORTH KINGSTOWN  HOPKINTON        NORTH KINGSTOWN 
##  [97] NORTH KINGSTOWN  LITTLE COMPTON   TIVERTON         TIVERTON        
## [101] TIVERTON         LITTLE COMPTON   TIVERTON         LITTLE COMPTON  
## [105] LITTLE COMPTON   LITTLE COMPTON   TIVERTON         LITTLE COMPTON  
## [109] TIVERTON         LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON  
## [113] JAMESTOWN        SOUTH KINGSTOWN  NEWPORT          NEWPORT         
## [117] JAMESTOWN        JAMESTOWN        NARRAGANSETT     NEWPORT         
## [121] NEWPORT          NEWPORT          JAMESTOWN        JAMESTOWN       
## [125] JAMESTOWN        JAMESTOWN        MIDDLETOWN       JAMESTOWN       
## [129] JAMESTOWN        JAMESTOWN        JAMESTOWN        JAMESTOWN       
## [133] JAMESTOWN        JAMESTOWN        MIDDLETOWN       JAMESTOWN       
## [137] MIDDLETOWN       MIDDLETOWN       JAMESTOWN        MIDDLETOWN      
## [141] MIDDLETOWN       JAMESTOWN        NEWPORT          JAMESTOWN       
## [145] LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON  
## [149] LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON   NARRAGANSETT    
## [153] LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON  
## [157] NARRAGANSETT     LITTLE COMPTON   NEWPORT          NARRAGANSETT    
## [161] NARRAGANSETT     LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON  
## [165] LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON   CHARLESTOWN     
## [169] LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON  
## [173] LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON   NEWPORT         
## [177] LITTLE COMPTON   LITTLE COMPTON   NEWPORT          NEWPORT         
## [181] NEWPORT          LITTLE COMPTON   LITTLE COMPTON   NEWPORT         
## [185] NEWPORT          LITTLE COMPTON   NEWPORT          LITTLE COMPTON  
## [189] LITTLE COMPTON   NEWPORT          LITTLE COMPTON   NEWPORT         
## [193] NEWPORT          NARRAGANSETT     NEWPORT          NARRAGANSETT    
## [197] NEWPORT          LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON  
## [201] NEWPORT          NEWPORT          NEWPORT          NARRAGANSETT    
## [205] NEWPORT          NEWPORT          NEWPORT          LITTLE COMPTON  
## [209] LITTLE COMPTON   LITTLE COMPTON   NEWPORT          NEWPORT         
## [213] NEWPORT          NEWPORT          NEWPORT          NEWPORT         
## [217] NEWPORT          NEWPORT          NEWPORT          NEWPORT         
## [221] NEWPORT          LITTLE COMPTON   NEWPORT          NEWPORT         
## [225] NEWPORT          LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON  
## [229] LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON  
## [233] LITTLE COMPTON   NARRAGANSETT     NARRAGANSETT     NEWPORT         
## [237] NARRAGANSETT     LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON  
## [241] LITTLE COMPTON   LITTLE COMPTON   NEWPORT          NEWPORT         
## [245] NEWPORT          NEWPORT          NEWPORT          NEWPORT         
## [249] NEWPORT          NEWPORT          NEWPORT          LITTLE COMPTON  
## [253] NEWPORT          NEWPORT          NEWPORT          NEWPORT         
## [257] NEWPORT          NEWPORT          NEWPORT          LITTLE COMPTON  
## [261] NEWPORT          LITTLE COMPTON   NEWPORT          NEWPORT         
## [265] NEWPORT          LITTLE COMPTON   NEWPORT          NEWPORT         
## [269] NEWPORT          LITTLE COMPTON   NEWPORT          NEWPORT         
## [273] LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON   LITTLE COMPTON  
## [277] LITTLE COMPTON   LITTLE COMPTON   NARRAGANSETT     NEWPORT         
## [281] LITTLE COMPTON   NARRAGANSETT     NARRAGANSETT     NARRAGANSETT    
## [285] NARRAGANSETT     NARRAGANSETT     NARRAGANSETT     NARRAGANSETT    
## [289] NARRAGANSETT     NARRAGANSETT     NARRAGANSETT     NARRAGANSETT    
## [293] NARRAGANSETT     NARRAGANSETT     NARRAGANSETT     SOUTH KINGSTOWN 
## [297] SOUTH KINGSTOWN  WESTERLY         SOUTH KINGSTOWN  SOUTH KINGSTOWN 
## [301] NARRAGANSETT     SOUTH KINGSTOWN  NARRAGANSETT     WESTERLY        
## [305] WESTERLY         SOUTH KINGSTOWN  WESTERLY         NARRAGANSETT    
## [309] NARRAGANSETT     NARRAGANSETT     NARRAGANSETT     NARRAGANSETT    
## [313] NARRAGANSETT     SOUTH KINGSTOWN  SOUTH KINGSTOWN  NARRAGANSETT    
## [317] SOUTH KINGSTOWN  NARRAGANSETT     SOUTH KINGSTOWN  SOUTH KINGSTOWN 
## [321] NARRAGANSETT     SOUTH KINGSTOWN  SOUTH KINGSTOWN  SOUTH KINGSTOWN 
## [325] SOUTH KINGSTOWN  CHARLESTOWN      SOUTH KINGSTOWN  SOUTH KINGSTOWN 
## [329] CHARLESTOWN      SOUTH KINGSTOWN  SOUTH KINGSTOWN  SOUTH KINGSTOWN 
## [333] CHARLESTOWN      CHARLESTOWN      CHARLESTOWN      CHARLESTOWN     
## [337] SOUTH KINGSTOWN  SOUTH KINGSTOWN  SOUTH KINGSTOWN  SOUTH KINGSTOWN 
## [341] SOUTH KINGSTOWN  SOUTH KINGSTOWN  SOUTH KINGSTOWN  CHARLESTOWN     
## [345] CHARLESTOWN      SOUTH KINGSTOWN  CHARLESTOWN      SOUTH KINGSTOWN 
## [349] CHARLESTOWN      SOUTH KINGSTOWN  CHARLESTOWN      CHARLESTOWN     
## [353] CHARLESTOWN      CHARLESTOWN      CHARLESTOWN      CHARLESTOWN     
## [357] CHARLESTOWN      CHARLESTOWN      CHARLESTOWN      CHARLESTOWN     
## [361] NARRAGANSETT     CHARLESTOWN      CHARLESTOWN      CHARLESTOWN     
## [365] CHARLESTOWN      CHARLESTOWN      CHARLESTOWN      CHARLESTOWN     
## [369] CHARLESTOWN      CHARLESTOWN      CHARLESTOWN      CHARLESTOWN     
## [373] CHARLESTOWN      CHARLESTOWN      CHARLESTOWN      CHARLESTOWN     
## [377] CHARLESTOWN      CHARLESTOWN      CHARLESTOWN      WESTERLY        
## [381] CHARLESTOWN      WESTERLY         WESTERLY         WESTERLY        
## [385] WESTERLY         WESTERLY         WESTERLY         WESTERLY        
## [389] WESTERLY         WESTERLY         WESTERLY         NEW SHOREHAM    
## [393] NEW SHOREHAM     PROVIDENCE       PROVIDENCE       PROVIDENCE      
## 39 Levels: BARRINGTON BRISTOL BURRILLVILLE CENTRAL FALLS ... WOONSOCKET
```

Now for the fun part.  Let's pair these `sf` objects with some `dplyr` tools to pull out individual features based on the data stored in the `sf` objects.  For instance:
 

```r
# Need to add dplyr
library(dplyr)

# Let's get just South Kingstown and clean up the attributes a bit.
sk_town <- ri_towns %>% filter(NAME == "SOUTH KINGSTOWN") %>% select(NAME, COUNTY, 
    AREA)
plot(st_geometry(sk_town))
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png)

Now that we have the polygons (there are 31) for the town pulled out we can work with these poly's.  One thing you might want to do is have this represented a single MULTIPOLYGON.  We can use dplyr to do this.  


```r
sk_town <- sk_town %>% group_by(NAME) %>% summarize(total_area_sqmi = sum(AREA)/27878400)
sk_town
```

```
## Simple feature collection with 1 feature and 2 fields
## geometry type:  MULTIPOLYGON
## dimension:      XY
## bbox:           xmin: 293569.4 ymin: 101120.6 xmax: 342630.9 ymax: 160990.8
## epsg (SRID):    NA
## proj4string:    +proj=tmerc +lat_0=41.08333333333334 +lon_0=-71.5 +k=0.99999375 +x_0=99999.99999999999 +y_0=0 +datum=NAD83 +units=us-ft +no_defs
## # A tibble: 1 x 3
##              NAME total_area_sqmi          geometry
##            <fctr>           <dbl>  <simple_feature>
## 1 SOUTH KINGSTOWN        60.20766 <MULTIPOLYGON...>
```

## Projections

Although many GIS provide project-on-the-fly, R does not.  To get our maps to work and analysis to be correct, we need to know how to modify the projections of our data so that they match up.  A description of projections is way beyond the scope of this workshop, but these links provide some good background info and details:

- [USGS](http://egsc.usgs.gov/isb//pubs/MapProjections/projections.html)
- [NCEAS](https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/OverviewCoordinateReferenceSystems.pdf)

And for more on projecting there's some good info in the [rOpenSci draft spatial data viz Task View](https://github.com/ropensci/maptools#projecting-data)

For our purposes we will be using `st_transform()` to reproject data.  We need to supply two arguments, "x", the object we are transforming, and either an [EPSG code](http://www.epsg-registry.org/) or a character with a [Proj.4](https://trac.osgeo.org/proj/) string.  We will assume that we have good data read into R and that the original projection is already defined.  This is the case with all of the example data.  Be careful using data that do not have a coordinate reference system defined!

For our examples, we will be using [Proj.4](https://trac.osgeo.org/proj/) strings.  We can get the Proj.4 strings from other datasets, or specify them from scratch.  To get them from scratch, the easiest thing to do is search at [spatialreference.org](http://spatialreference.org/).  You can either search there, or just use Google.  For instance, if we want the [ESRI Albers Equal Area projection as Proj.4](www.google.com/search?q=ESRI Albers Equal Area projection as Proj.4) gets it as the first result.  Just select the [Proj4](http://spatialreference.org/ref/esri/usa-contiguous-albers-equal-area-conic/proj4/) link from the list.

We can pull them from existing `sf` objects like:


```r
st_crs(ri_towns)$proj4string
```

```
## [1] "+proj=tmerc +lat_0=41.08333333333334 +lon_0=-71.5 +k=0.99999375 +x_0=99999.99999999999 +y_0=0 +datum=NAD83 +units=us-ft +no_defs"
```

So, let's reproject our data into an Albers projection stored in the `dc_nlcd` raster.  It is a `raster` object and not `sf` so it needs to be accessed with `proj4string()`


```r
esri_alb_p4 <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
sk_town_alb <- st_transform(sk_town, esri_alb_p4)
plot(st_geometry(sk_town_alb))
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7-1.png)

## Exercise 2

1. Using `select` remove Shape_Leng and Shape_Area (hint: -column_name). Also, lets filter out the patches of SAV that are larger that 10 ha.  Assign the results of both steps to a single sf object named `large_sav`.  
2. And just for the practice, re-project `large_sav` into `large_sav_alb` and use the proj.4 string for the ESRI Albers Equal Area Projection (<http://spatialreference.org/ref/esri/usa-contiguous-albers-equal-area-conic/proj4/>).

## Spatial data visualization

We have already seen out we can plot using the base plotting function (i.e. `plot()`), but those are pretty limited.  If we want to move beyond those to make more polished maps or interact with the data we need to use additional packages.

First, lets look at how we would make a very simple map using `ggplot2`. For example, this figure was created solely with `ggplot2`.

![](figure/gis_probability_map-1.jpeg)

Currently, the mapping of `sf` objects with `ggplot2` is only available from the latest version on GitHub.  It should be moving to CRAN in the near future, but for now we can use `devtools` (you will need to intall this with `install.packages("devtools")`).

With devtools we can install the GitHub version of `ggplot2` like this:


```r
devtools::install_github("tidyverse/ggplot2")
```

With the bleeding edge version of `ggplot2` we can plot `sf` objects directly.


```r
library(ggplot2)
ri_towns_gg <- ggplot(ri_towns) + geom_sf() + geom_sf(data = sk_town, fill = "darkolivegreen2")
ri_towns_gg
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9-1.png)

With `ggplot2` we have the ability create any kind of map we can conceive of, but we can't interact with our data. To do that, requires an additional pacakge, `mapview`.

Many of the visualization tasks (e.g. zoom, pan, identify) are implemented (and implemented well) in various javascript libraries.  As such, much of the development in R has been towards packages to access javascript libraries and allow the display of R objects. Our efforts are going to focus on the [`mpaview` package](https://cran.r-project.org/package=mapview) which provides a relatively streamlined way to access the [leaflet javascript library](http://leafletjs.com/) in R.  It uses the `leaflet` package, which  is written and maintained through RStudio.  For more on how to use `leaflet` directly, check out [RStudio's tutorial](https://rstudio.github.io/leaflet/).  For additional tutorials on mapview, see articles on [the r-spatial page.](https://r-spatial.github.io/mapview/index.html) 

Before we build some maps, let's get everything we need installed and loaded.


```r
install.packages("leaflet")
install.packages("mapview")
library(mapview)
```

Although the maps we can create with `mapview` are really nice, there is one downside.  It is expected that the data are all in unprojected latitude and longitude, so if you have projected data, that will need to be converted back in to geographic coordinates. This happens behind the scenes by `mapview` so it is easy to do, just be aware that your maps will display in the ubiquitous web mercator projection. For most applications this won't be a problem, but if your viz requires accurate shape and size and you are in high lattitudes, you will need to think carefully about the impacts of this.

So lets get started with the bare minimum of `mapview()` 


```r
map <- mapview(ri_towns)
map
```

The default options from `mapview()` are pretty nice and we won't be going beyond these.  But since this is built off of `leaflet`, in theory most things that leaflet can do, we can use in our mapview maps.  Let's explore the map a bit before we move on.

Now, lets add other layers in and also change their styling.


```r
map + sk_town
```

## Exercise 3

For this exercise, we will create a `mapview` map and if there is time, a `ggplot2` map.

1. Create a `mapview` map with the South Kingstown border and the `large_sav`.  Play around with the map to get a feel for the zooming, layer switching, identifying, etc.
2. Now let's create a `ggplot` map of all the Rhode Island towns and the full `sav`.  Make sure the `sav` is mapped with an appropriate color (i.e. not pink!).  Look at `colors()` for some options. 
