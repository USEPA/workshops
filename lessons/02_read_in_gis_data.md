

# Reading and Writing Raster and Vector Data
So, now that we have the base packages installed and loaded we can work on getting our data into and out of R.  While it is possible to store spatial data as R objects (e.g. via .Rda/Rdata files) that is probably not the best approach.  It is better to store spatial data in widley used files (e.g. shapefiles,.tiff, or geojson) or in spatial databases (e.g. file geodatabse or PostGIS) and then read that data into R for analysis then writing the results back out to your file format of choice.  In this lesson we will explore several ways to read in multiple vector and raster data types.

## Lesson Outline
- [Vector data: shapefiles](#vector-data-shapefiles)
- [Vector data: file geodatabase](#vector-data-file-geodatabase])
- [Vector data: geojson](#vector-data-geojson)
- [Raster data: GeoTIFF](#raster-data-geotiff)
- [Raster data: ASCII](#raster-data-arcinfo-ascii)
- [Geospatial data packages](#geospatial data packages)

## Lesson Exercises
- [Exercise 2.1](#exercise-21)
- [Exercise 2.2](#exercise-22)

## Get the example data
For this workshop, I have collected several example datasets to use and have included them in this repository.  So, let's first grab the dataset.  It is stored as a zip file.  You can download it [directly from this link](https://github.com/USEPA/intro_gis_with_r/blob/master/data.zip?raw=true), or we could use R.  I prefer to use the `httr` package becuase base `download.file` can act funny on different platforms.


```r
library(httr)
url <- "https://github.com/USEPA/intro_gis_with_r/blob/master/data.zip?raw=true"
GET(url,write_disk("data.zip",overwrite = TRUE))
```

Oh and while we are being a bit #rstats crazy...  Let unzip it with R too!


```r
unzip("data.zip",overwrite = TRUE)
```



## Vector data: shapefiles
For many, shapefiles are going to be the most common way to interact with spatial data.  In R, there are many ways to read in shapefiles.  We are going to focus using `rgdal` becuase it is flexible and provides a common interface to multiple file types.  But to be fair, I'll also quickly show a another option from `maptools`.

### Reading in Shapfiles
To read in a shapefile using `rgdal`, we want to use the `readOGR` function.  This function is the primary way to interact with vector data using `rgdal`.  There are many arguments to this function, but the two you need are the "dsn" and "layer".  For a shapefile the "dsn" is the path (in our case probably "data") and the "layer" is the name of the shapefile without any extensions.  The function call to read the DC Metro shapefile from out example data looks like: 


```r
dc_metro <- readOGR("data","Metro_Lines")
```

```
## OGR data source with driver: ESRI Shapefile 
## Source: "data", layer: "Metro_Lines"
## with 8 features
## It has 4 fields
```

We will get more into working with `sp` object and visualizing spatail data later, but just to prove that this did something:


```r
summary(dc_metro)
```

```
## Object of class SpatialLinesDataFrame
## Coordinates:
##         min       max
## x -77.08576 -76.91327
## y  38.83827  38.97984
## Is projected: FALSE 
## proj4string :
## [+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0]
## Data attributes:
##        GIS_ID               NAME                                 WEB_URL 
##  Metro_001:2   blue           :1   http://wmata.com/rail/maps/map.cfm:8  
##  Metro_002:2   green          :1                                         
##  Metro_003:1   orange         :1                                         
##  Metro_004:1   orange - rush +:1                                         
##  Metro_005:1   red            :1                                         
##  Metro_006:1   silver         :1                                         
##                (Other)        :2                                         
##     OBJECTID   
##  Min.   :1.00  
##  1st Qu.:2.75  
##  Median :4.50  
##  Mean   :4.50  
##  3rd Qu.:6.25  
##  Max.   :8.00  
## 
```

```r
plot(dc_metro)
```

![plot of chunk metro_chk](figure/metro_chk-1.png)

As I mentioned earlier, there are other ways to read in shapefiles.  Two common ways are with the `maptools` and `shapefiles` packages


```r
dc_metro_mt<-maptools::readShapeLines("data/Metro_Lines")
summary(dc_metro_mt)
```

```
## Object of class SpatialLinesDataFrame
## Coordinates:
##         min       max
## x -77.08576 -76.91327
## y  38.83827  38.97984
## Is projected: NA 
## proj4string : [NA]
## Data attributes:
##        GIS_ID               NAME                                 WEB_URL 
##  Metro_001:2   blue           :1   http://wmata.com/rail/maps/map.cfm:8  
##  Metro_002:2   green          :1                                         
##  Metro_003:1   orange         :1                                         
##  Metro_004:1   orange - rush +:1                                         
##  Metro_005:1   red            :1                                         
##  Metro_006:1   silver         :1                                         
##                (Other)        :2                                         
##     OBJECTID   
##  Min.   :1.00  
##  1st Qu.:2.75  
##  Median :4.50  
##  Mean   :4.50  
##  3rd Qu.:6.25  
##  Max.   :8.00  
## 
```
 
Couple of notes on this  First the `maptools` functions require that you know your geomtery type, whereas, `readOGR` will get that from the data.  I did test to see if the the `maptools::readShapeLines` was any quicker than `rgdal::readOGR` and in my huge sample of one, it was. Lastly, `readShapeLines` is a one-trick pony.  It reads in shapefiles and that is it.  As we will see, `readOGR` works across a range of vector data types and thus, is what I would recomend for most vector data I/O tasks.

### Writing shapefiles

Writing shapefiles is just as easy as reading them, assuming you have an `sp` object to work with.  We will just show this using `readOGR`.

Before we do this, we can prove that the shapefile doesn't exist.


```
## [1] TRUE TRUE TRUE TRUE TRUE
```

```r
list.files("data","dc_metro")
```

```
## character(0)
```

Now to write the shapefile:


```r
writeOGR(dc_metro,"data","dc_metro",driver="ESRI Shapefile")

#Is it there?
list.files("data","dc_metro")
```

```
## [1] "dc_metro.dbf" "dc_metro.prj" "dc_metro.shp" "dc_metro.shx"
```

So same "dsn" and "layer" arguments as before.  Only differnce is that the first argument is the `sp` object you want to write out to a shapefile.  

## Vector data: file geodatabase
A recent addition to the GDAL world is the ability to read ESRI File Geodatabases.  This is easy to access on windows as the latest version of GDAL is wrapped up as part of the `rgdal` install and thus you get access to the appropriate drivers.  This is a bit more challenging on Linux (even more so on the antiquated RHEL 6 that is EPAs approved OS) as you need to have GDAL 1.11.x +.  In any event, if you use file geodatabases, you can read those directly into R with readOGR. Difference here is the "dsn" is the name of the file geodatabase (with path info if needed), and the "layer" is the feature class.


```r
#List feature classes
ogrListLayers("data/spx.gdb")
```

```
## [1] "points"    "points2"   "points3"   "polygons"  "polygons2" "polygons3"
## [7] "polygons4" "polygons5"
## attr(,"driver")
## [1] "OpenFileGDB"
## attr(,"nlayers")
## [1] 8
```

```r
examp_fgdb <- readOGR(dsn = "data/spx.gdb", layer="polygons5")
```

```
## OGR data source with driver: OpenFileGDB 
## Source: "data/spx.gdb", layer: "polygons5"
## with 600 features
## It has 0 fields
```

And to be sure it worked:


```r
summary(examp_fgdb)
```

```
## Object of class SpatialPolygonsDataFrame
## Coordinates:
##      min   max
## x -1e+06 1e+06
## y -1e+06 1e+06
## Is projected: NA 
## proj4string : [NA]
## Data attributes:
##       FID       
##  Min.   :  1.0  
##  1st Qu.:150.8  
##  Median :300.5  
##  Mean   :300.5  
##  3rd Qu.:450.2  
##  Max.   :600.0
```

```r
plot(examp_fgdb)
```

![plot of chunk check_gdb](figure/check_gdb-1.png)

Writing to a file geodatabase from R is not yet possible.

## Vector data: geojson

Last vector example we will show is geojson.  For most desktop GIS users this will not be encountered too often, but as more and more GIS moves to the web, geojson will become increasingly common.  We will still rely on `readOGR` for the geojson.

### Reading in geojson

To read in with `rgdal` we use "dsn" and "layer" a bit differently.  The "dsn" is the name (and path) of the file, and "layer" is going to be set as "OGRGeoJSON". 


```r
dc_metro_sttn <- readOGR("data/dc_metrostations.geojson", "OGRGeoJSON")
```

```
## Error in ogrInfo(dsn = dsn, layer = layer, encoding = encoding, use_iconv = use_iconv, : 
## 	GDAL Error 3: Cannot open file 'data/dc_metrostations.geojson'
```

And to see that something is there...


```r
#Let's use the defualt print 
dc_metro_sttn
```

```
## class       : SpatialPointsDataFrame 
## features    : 40 
## extent      : -77.085, -76.93526, 38.84567, 38.97609  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0 
## variables   : 6
## names       : OBJECTID,   GIS_ID,                          NAME,                                                WEB_URL,                 LINE,                    ADDRESS 
## min values  :        1, mstn_001,                     Anacostia,  http://wmata.com/rail/station_detail.cfm?station_id=1, blue, orange, silver, 1001 CONNECTICUT AVENUE NW 
## max values  :        9, mstn_040, Woodley Park-Zoo Adams Morgan, http://wmata.com/rail/station_detail.cfm?station_id=90,   red, green, yellow, 919 RHODE ISLAND AVENUE NE
```

```r
#And add a few more things to our plot
plot(dc_metro)
```

![plot of chunk check_geojson](figure/check_geojson-1.png)

```r
plot(dc_metro_sttn, col = "red")
```

![plot of chunk check_geojson](figure/check_geojson-2.png)

### Writing geojson

Just as with shapefiles, writing to a geojson file can be accomplished with `writeOGR`.


```r
writeOGR(dc_metro_sttn,"data/stations.geojson", "OGRGeoJSON", 
         driver="GeoJSON")
```

```
## Error in writeOGR(dc_metro_sttn, "data/stations.geojson", "OGRGeoJSON", : 
## 	GDAL Error 3: Cannot open file 'data/stations.geojson'
```

Lastly, if you commonly work with geojson files, there is the `geojsonio` package from [rOpenSci](https://ropensci.org/) that provides a number of tools for reading, writing, and converting geojson files.  It is certainly worth exploring as it provides additiona functionality beyond the `rgdal` toolset.

## Exercise 2.1
For this first exercise we will just focus on getting a shapefile read into R.  We will be using the sticky notes I handed out to let me know who needs help and who has finished the exercise.  Once everyone is done, we will move on.

1.) Using `rgdal::readOGR` to read in the US Census Tiger Line Files of the state boundaries.  Assign it to an object called `us_states`.
2.) Once it is read in use `summary` to look at some of the basics and the plot the data.


## Raster data: GeoTIFF
We will just show a couple of examples as reading in rasters is a bit more straightforward than vector.  Our first example will be GeoTIFFs.


## Raster data: ArcInfo ASCII

## Exercise 2.2

## Geospatial data packages
- maps
- USCensus

