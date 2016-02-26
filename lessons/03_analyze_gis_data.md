
```
## Error in eval(expr, envir, enclos): object 'opt_chunks' not found
```

# Basic GIS Analysis with R
We now have the required packages installed and know how to read data into R. Our next step is to start doing some GIS analysis with R. Throughout the course of this lesson will show how to do some basic manipulation of the `raster` and `sp` objects and then show a few examples of some relatively straightforward analyses.  We will only be scratching the surface here, but hoepfully this will provide a starting point for more work doing spatial analysis in R.  ***Note:*** *Much of this lesson assumes some familiarity with R and working with data frames.*

## Lesson Outline
- [Explore and manipulate](#explore-and-manipulate)
- [Projections](#projections)
- [Intro to rgeos:Overlay and Buffer](#intro-to-rgeos-overlay-and-buffer)
- [Working with rasters](#working-with-rasters)
- [Other geospatial packages](#other-geospatial-packages)

## Lesson Exercises
- [Exercise 3.1](#exercise-31)
- [Exercise 3.2](#exercise-32)
- [Exercise 3.3](#exercise-33)

## Explore and manipulate
One of the nice things about `SpatialXDataFrame` objects is that many of the tricks you know for working with data frames will also work.  This allows us subset our spatial data, summarize data, etc. in an R way.

Let's start working through some examples using the two Metro datasets.


```
## OGR data source with driver: ESRI Shapefile 
## Source: "data", layer: "Metro_Lines"
## with 8 features
## It has 4 fields
```

```
## Error in ogrInfo(dsn = dsn, layer = layer, encoding = encoding, use_iconv = use_iconv, : Cannot open data source
```

We've already seen how to use the default print statements to look at the basics


```r
dc_metro
```

```
## class       : SpatialLinesDataFrame 
## features    : 8 
## extent      : -77.08576, -76.91327, 38.83827, 38.97984  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0 
## variables   : 4
## names       :    GIS_ID,            NAME,                            WEB_URL, OBJECTID 
## min values  : Metro_001,            blue, http://wmata.com/rail/maps/map.cfm,        1 
## max values  : Metro_006, yellow - rush +, http://wmata.com/rail/maps/map.cfm,        8
```

```r
dc_metro_sttn
```

```
## class       : SpatialPointsDataFrame 
## features    : 40 
## extent      : -77.085, -76.93526, 38.84567, 38.97609  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0 
## variables   : 7
## names       :                          NAME, OBJECTID,   GIS_ID,                                                WEB_URL,                 LINE,                    ADDRESS, avg_wkday 
## min values  :                     Anacostia,        1, mstn_001,  http://wmata.com/rail/station_detail.cfm?station_id=1, blue, orange, silver, 1001 CONNECTICUT AVENUE NW,    1761.2 
## max values  : Woodley Park-Zoo Adams Morgan,       40, mstn_040, http://wmata.com/rail/station_detail.cfm?station_id=90,   red, green, yellow, 919 RHODE ISLAND AVENUE NE,   32611.1
```

We can get more info on the data with:


```r
head(dc_metro_sttn)
```

```
##                    NAME OBJECTID   GIS_ID
## 7      Columbia Heights        1 mstn_007
## 20 Georgia Ave Petworth        2 mstn_020
## 34               Takoma        3 mstn_034
## 4         Brookland-CUA        4 mstn_004
## 17          Fort Totten        5 mstn_017
## 3          Benning Road        6 mstn_003
##                                                   WEB_URL
## 7  http://wmata.com/rail/station_detail.cfm?station_id=75
## 20 http://wmata.com/rail/station_detail.cfm?station_id=76
## 34 http://wmata.com/rail/station_detail.cfm?station_id=29
## 4  http://wmata.com/rail/station_detail.cfm?station_id=27
## 17 http://wmata.com/rail/station_detail.cfm?station_id=28
## 3  http://wmata.com/rail/station_detail.cfm?station_id=90
##                    LINE                ADDRESS avg_wkday
## 7         green, yellow    3030 14TH STREET NW   12608.3
## 20        green, yellow 3700 GEORGIA AVENUE NW        NA
## 34                  red    327 CEDAR STREET NW    6023.5
## 4                   red 801 MICHIGAN AVENUE NE        NA
## 17   red, green, yellow 550 GALLOWAY STREET NE    7442.0
## 3  blue, orange, silver   4500 BENNING ROAD NE    3067.2
```

```r
summary(dc_metro_sttn)
```

```
## Object of class SpatialPointsDataFrame
## Coordinates:
##                 min       max
## coords.x1 -77.08500 -76.93526
## coords.x2  38.84567  38.97609
## Is projected: FALSE 
## proj4string :
## [+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0]
## Number of points: 40
## Data attributes:
##                  NAME       OBJECTID          GIS_ID  
##  Anacostia         : 1   Min.   : 1.00   mstn_001: 1  
##  Archives-Navy Meml: 1   1st Qu.:10.75   mstn_002: 1  
##  Benning Road      : 1   Median :20.50   mstn_003: 1  
##  Brookland-CUA     : 1   Mean   :20.50   mstn_004: 1  
##  Capitol South     : 1   3rd Qu.:30.25   mstn_005: 1  
##  Cleveland Park    : 1   Max.   :40.00   mstn_006: 1  
##  (Other)           :34                   (Other) :34  
##                                                     WEB_URL  
##  http://wmata.com/rail/station_detail.cfm?station_id=1  : 1  
##  http://wmata.com/rail/station_detail.cfm?station_id=10 : 1  
##  http://wmata.com/rail/station_detail.cfm?station_id=108: 1  
##  http://wmata.com/rail/station_detail.cfm?station_id=11 : 1  
##  http://wmata.com/rail/station_detail.cfm?station_id=21 : 1  
##  http://wmata.com/rail/station_detail.cfm?station_id=23 : 1  
##  (Other)                                                :34  
##                    LINE                           ADDRESS  
##  red                 :13   1001 CONNECTICUT AVENUE NW : 1  
##  blue, orange, silver:10   1101 HOWARD ROAD SE        : 1  
##  green, yellow       : 6   1200 INDEPENDENCE AVENUE SW: 1  
##  green               : 4   1290 ALABAMA AVENUE SE     : 1  
##  orange              : 2   1300 U STREET NW           : 1  
##  red, green, yellow  : 2   1400 I STREET NW           : 1  
##  (Other)             : 3   (Other)                    :34  
##    avg_wkday    
##  Min.   : 1761  
##  1st Qu.: 6027  
##  Median : 7399  
##  Mean   :11062  
##  3rd Qu.:12374  
##  Max.   :32611  
##  NA's   :18
```

```r
names(dc_metro_sttn)
```

```
## [1] "NAME"      "OBJECTID"  "GIS_ID"    "WEB_URL"   "LINE"      "ADDRESS"  
## [7] "avg_wkday"
```

And to get into the guts of the `sp` objects:


```r
str(dc_metro)
```

```
## Formal class 'SpatialLinesDataFrame' [package "sp"] with 4 slots
##   ..@ data       :'data.frame':	8 obs. of  4 variables:
##   .. ..$ GIS_ID  : Factor w/ 6 levels "Metro_001","Metro_002",..: 4 5 3 2 2 1 1 6
##   .. ..$ NAME    : Factor w/ 8 levels "blue","green",..: 5 7 3 2 8 1 4 6
##   .. ..$ WEB_URL : Factor w/ 1 level "http://wmata.com/rail/maps/map.cfm": 1 1 1 1 1 1 1 1
##   .. ..$ OBJECTID: int [1:8] 1 2 3 4 5 6 7 8
##   ..@ lines      :List of 8
##   .. ..$ :Formal class 'Lines' [package "sp"] with 2 slots
##   .. .. .. ..@ Lines:List of 1
##   .. .. .. .. ..$ :Formal class 'Line' [package "sp"] with 1 slot
##   .. .. .. .. .. .. ..@ coords: num [1:1028, 1:2] -77 -77 -77 -77 -77 ...
##   .. .. .. ..@ ID   : chr "0"
##   .. ..$ :Formal class 'Lines' [package "sp"] with 2 slots
##   .. .. .. ..@ Lines:List of 1
##   .. .. .. .. ..$ :Formal class 'Line' [package "sp"] with 1 slot
##   .. .. .. .. .. .. ..@ coords: num [1:284, 1:2] -77 -77 -77 -77 -77 ...
##   .. .. .. ..@ ID   : chr "1"
##   .. ..$ :Formal class 'Lines' [package "sp"] with 2 slots
##   .. .. .. ..@ Lines:List of 1
##   .. .. .. .. ..$ :Formal class 'Line' [package "sp"] with 1 slot
##   .. .. .. .. .. .. ..@ coords: num [1:1066, 1:2] -77.1 -77.1 -77.1 -77.1 -77.1 ...
##   .. .. .. ..@ ID   : chr "2"
##   .. ..$ :Formal class 'Lines' [package "sp"] with 2 slots
##   .. .. .. ..@ Lines:List of 1
##   .. .. .. .. ..$ :Formal class 'Line' [package "sp"] with 1 slot
##   .. .. .. .. .. .. ..@ coords: num [1:837, 1:2] -77 -77 -77 -77 -77 ...
##   .. .. .. ..@ ID   : chr "3"
##   .. ..$ :Formal class 'Lines' [package "sp"] with 2 slots
##   .. .. .. ..@ Lines:List of 1
##   .. .. .. .. ..$ :Formal class 'Line' [package "sp"] with 1 slot
##   .. .. .. .. .. .. ..@ coords: num [1:78, 1:2] -77 -77 -77 -77 -77 ...
##   .. .. .. ..@ ID   : chr "4"
##   .. ..$ :Formal class 'Lines' [package "sp"] with 2 slots
##   .. .. .. ..@ Lines:List of 1
##   .. .. .. .. ..$ :Formal class 'Line' [package "sp"] with 1 slot
##   .. .. .. .. .. .. ..@ coords: num [1:1035, 1:2] -77.1 -77.1 -77.1 -77.1 -77.1 ...
##   .. .. .. ..@ ID   : chr "5"
##   .. ..$ :Formal class 'Lines' [package "sp"] with 2 slots
##   .. .. .. ..@ Lines:List of 1
##   .. .. .. .. ..$ :Formal class 'Line' [package "sp"] with 1 slot
##   .. .. .. .. .. .. ..@ coords: num [1:108, 1:2] -77 -77 -77 -77 -76.9 ...
##   .. .. .. ..@ ID   : chr "6"
##   .. ..$ :Formal class 'Lines' [package "sp"] with 2 slots
##   .. .. .. ..@ Lines:List of 5
##   .. .. .. .. ..$ :Formal class 'Line' [package "sp"] with 1 slot
##   .. .. .. .. .. .. ..@ coords: num [1:109, 1:2] -77 -77 -77 -77 -77 ...
##   .. .. .. .. ..$ :Formal class 'Line' [package "sp"] with 1 slot
##   .. .. .. .. .. .. ..@ coords: num [1:50, 1:2] -77.1 -77.1 -77.1 -77.1 -77.1 ...
##   .. .. .. .. ..$ :Formal class 'Line' [package "sp"] with 1 slot
##   .. .. .. .. .. .. ..@ coords: num [1:272, 1:2] -77 -77 -77 -77 -77 ...
##   .. .. .. .. ..$ :Formal class 'Line' [package "sp"] with 1 slot
##   .. .. .. .. .. .. ..@ coords: num [1:239, 1:2] -77 -77 -77 -77 -77 ...
##   .. .. .. .. ..$ :Formal class 'Line' [package "sp"] with 1 slot
##   .. .. .. .. .. .. ..@ coords: num [1:373, 1:2] -77 -77 -77 -77 -77 ...
##   .. .. .. ..@ ID   : chr "7"
##   ..@ bbox       : num [1:2, 1:2] -77.1 38.8 -76.9 39
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:2] "x" "y"
##   .. .. ..$ : chr [1:2] "min" "max"
##   ..@ proj4string:Formal class 'CRS' [package "sp"] with 1 slot
##   .. .. ..@ projargs: chr "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
```

Now for the fun part.  We can use indexing/subsetting tools we already know to pull out individual features based on the data stored in the `sp` objects data frame.  For instance:


```r
#select with base indexing
est_mrkt <- dc_metro_sttn[dc_metro_sttn$NAME == "Eastern Market",]
est_mrkt
```

```
## class       : SpatialPointsDataFrame 
## features    : 1 
## extent      : -76.996, -76.996, 38.88463, 38.88463  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0 
## variables   : 7
## names       :           NAME, OBJECTID,   GIS_ID,                                                WEB_URL,                 LINE,                    ADDRESS, avg_wkday 
## min values  : Eastern Market,       34, mstn_011, http://wmata.com/rail/station_detail.cfm?station_id=60, blue, orange, silver, 701 PENNSYLVANIA AVENUE SE,    6038.7 
## max values  : Eastern Market,       34, mstn_011, http://wmata.com/rail/station_detail.cfm?station_id=60, blue, orange, silver, 701 PENNSYLVANIA AVENUE SE,    6038.7
```

```r
#select with subset (plus a Lil Rhody Shout Out!)
ri <- subset(dc_metro_sttn,NAME == "Rhode Island Ave")
ri
```

```
## class       : SpatialPointsDataFrame 
## features    : 1 
## extent      : -76.99594, -76.99594, 38.92107, 38.92107  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0 
## variables   : 7
## names       :             NAME, OBJECTID,   GIS_ID,                                                WEB_URL, LINE,                    ADDRESS, avg_wkday 
## min values  : Rhode Island Ave,       37, mstn_030, http://wmata.com/rail/station_detail.cfm?station_id=26,  red, 919 RHODE ISLAND AVENUE NE,        NA 
## max values  : Rhode Island Ave,       37, mstn_030, http://wmata.com/rail/station_detail.cfm?station_id=26,  red, 919 RHODE ISLAND AVENUE NE,        NA
```

```r
#select multiple items
red_line_sttn <- subset(dc_metro_sttn,grepl("red",LINE))
red_line_sttn
```

```
## class       : SpatialPointsDataFrame 
## features    : 16 
## extent      : -77.085, -76.99454, 38.8961, 38.97609  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0 
## variables   : 7
## names       :                          NAME, OBJECTID,   GIS_ID,                                               WEB_URL,               LINE,                    ADDRESS, avg_wkday 
## min values  :                 Brookland-CUA,        3, mstn_004, http://wmata.com/rail/station_detail.cfm?station_id=1,                red, 1001 CONNECTICUT AVENUE NW,    4637.5 
## max values  : Woodley Park-Zoo Adams Morgan,       40, mstn_040, http://wmata.com/rail/station_detail.cfm?station_id=9, red, green, yellow, 919 RHODE ISLAND AVENUE NE,   32611.1
```

Adding data is just the same as for adding data to data frames.  I found some ridership data for the different stations and summarized that, by station, into "station_rides.csv".  Let's pull that in, and add it to `dc_metro_sttn`.  


```r
read.csv("data/station_rides.csv")
```

```
## Warning in file(file, "rt"): cannot open file 'data/station_rides.csv': No
## such file or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```r
dc_metro_sttn<-merge(dc_metro_sttn,station_rides,
                     by.x="NAME",by.y="Ent.Station",all.x=TRUE)
head(dc_metro_sttn)
```

```
##                    NAME OBJECTID   GIS_ID
## 7      Columbia Heights        1 mstn_007
## 20 Georgia Ave Petworth        2 mstn_020
## 34               Takoma        3 mstn_034
## 4         Brookland-CUA        4 mstn_004
## 17          Fort Totten        5 mstn_017
## 3          Benning Road        6 mstn_003
##                                                   WEB_URL
## 7  http://wmata.com/rail/station_detail.cfm?station_id=75
## 20 http://wmata.com/rail/station_detail.cfm?station_id=76
## 34 http://wmata.com/rail/station_detail.cfm?station_id=29
## 4  http://wmata.com/rail/station_detail.cfm?station_id=27
## 17 http://wmata.com/rail/station_detail.cfm?station_id=28
## 3  http://wmata.com/rail/station_detail.cfm?station_id=90
##                    LINE                ADDRESS avg_wkday.x avg_wkday.y
## 7         green, yellow    3030 14TH STREET NW     12608.3     12608.3
## 20        green, yellow 3700 GEORGIA AVENUE NW          NA          NA
## 34                  red    327 CEDAR STREET NW      6023.5      6023.5
## 4                   red 801 MICHIGAN AVENUE NE          NA          NA
## 17   red, green, yellow 550 GALLOWAY STREET NE      7442.0      7442.0
## 3  blue, orange, silver   4500 BENNING ROAD NE      3067.2      3067.2
```

So, now we can use these values to select.


```r
busy_sttn <- subset(dc_metro_sttn,avg_wkday >= 10000)
```

```
## Error in eval(expr, envir, enclos): object 'avg_wkday' not found
```

```r
busy_sttn
```

```
## class       : SpatialPointsDataFrame 
## features    : 7 
## extent      : -77.04342, -77.00742, 38.88803, 38.92785  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0 
## variables   : 7
## names       :             NAME, OBJECTID,   GIS_ID,                                                WEB_URL,                      LINE,                    ADDRESS, avg_wkday 
## min values  : Columbia Heights,        1, mstn_007,  http://wmata.com/rail/station_detail.cfm?station_id=1,      blue, orange, silver, 1001 CONNECTICUT AVENUE NW,   11671.6 
## max values  :    Union Station,       31, mstn_037, http://wmata.com/rail/station_detail.cfm?station_id=75, red, blue, orange, silver,         900 18TH STREET NW,   32611.1
```

## Projections
Although many GIS provide project-on-the-fly (editorial: WORST THING EVER), R does not.  To get our maps to work and analysis to be correct, we need to know how to modify the projectins of our data so that they match up.  A descition of projections is way beyond the scope of this workshop, but these links provide some good background info and details:

- [USGS](http://egsc.usgs.gov/isb//pubs/MapProjections/projections.html)
- [NCEAS](https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/OverviewCoordinateReferenceSystems.pdf)

And for more on projecting there's some good info in the [rOpenSci draft spatial data viz Task View](https://github.com/ropensci/maptools#projecting-data)

For our purposes we will be using `spTransform` to reproject data.  We need to supply two arguments, "x" the object we are transforming and "CRSobj" which is the details of the new projection.  We will assume that we have good data read into R and that the original projection is already defined.  This is the case with all of the example data.

There are many ways to specify the "CRSobj".  We will be using [Proj.4](https://trac.osgeo.org/proj/) strings and the `CRS` function for this.  We can get the Proj.4 strings from other datasets, or specify them from scratch.  
To get them from scratch, the easiest thing to do is search at [spatialreference.org](http://spatialreference.org/).  You can either search there, or just use Google.  For instance, if we want the [ESRI Albers Equal Area projection as Proj.4](www.google.com/search?q=ESRI Albers Equal Area projection as Proj.4) gets it as the first result.  Just select the [Proj4](http://spatialreference.org/ref/esri/usa-contiguous-albers-equal-area-conic/proj4/) from the list.

So, if we want to reproject our data using this projection:


```r
dc_metro_alb <- spTransform(dc_metro,
                CRS("+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"))
```

Luckily, it is pretty common to have several datasets and one of which is in the projections you want to use.  We can then just pull the Proj4 string from that.


```r
dc_metro_sttn_prj <- spTransform(dc_metro_sttn,
                                 CRS(proj4string(dc_metro_alb))) 
```

## Exercise 3.1
In this first exercise we will work on manipulating the Tiger Lines file of the states that we pulled in as part of lesson 2 and assinged to `us_states`.

1. Assign just the DC boundary to an object named `dc_bnd`.
2. Re-project `dc_bnd` to match the projection of `dc_nlcd`.  Assign this to an object named `dc_bnd_prj`.

## Intro to rgeos: Overlay and Buffer
In this section we are going to start working with many of the "typical" GIS type analyses.

## Exercise 3.2
We will work with the re-projected `dc_bnd_prj` lets set this up for some further analyis.

1. Buffer the DC boundary by 1000 meters.
2. Using the overlay functions, get an object that represents only the area 1000 meters outside of DC.
3. Determine the area of both the DC boundary as well as the surrounding 1000 meters.

## Working with rasters

## Exercise 3.3
Let's combine all of this together and calculate some landcover summary statistics

1. Clip out the NLCD from within the DC boundaries.
2. Clip out the NLCD from the surrounding 1000 meters.
3. Summarize the land use/land cover statistics and report percent of each landcover type both within the DC boundary and within the surrounding 1000 meters.

## Other Geospatial packages
In this section, I'll introduce a few other packages that I have used or know about that provide some common analyses that may not be readily available via the base packages.  For a complete annotated listing though, the [CRAN Spatial Analysis Task View](https://cran.r-project.org/web/views/Spatial.html) should be your first stop.  The task view provides a full list of packages for working with spatial data, geostatistics, spatial regression, etc.  

Some of the other packages I have used for various tasks have been:
- gdistance: 
- geosphere:
- SDMTools:

