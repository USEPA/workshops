

# Reading and Writing Raster and Vector Data
So, now that we have the base packages installed and loaded we can work on getting our data into and out of R.  While it is possible to store spatial data as R objects (e.g. via .Rda/Rdata files) that is probably not the best approach.  It is better to store spatial data in widley used files (e.g. shapefiles,.tiff, or geojson) or in spatial databases (e.g. file geodatabse or PostGIS) and then read that data into R for analysis then writing the results back out to your file format of choice.  In this lesson we will explore several ways to read in multiple vector and raster data types.

## Lesson Outline
- [Vector data: shapefiles](#vector-data-shapefiles)
- [Vector data: file geodatabase](#vector-data-file-geodatabase])
- [Vector data: geojson](#vector-data-geojson)
- [Raster data: esri grids](#raster-data-esri-grids)
- [Raster data: ASCII](#raster-data-ascii)
- [Raster data: common image formats](#raster-data-common-image-formats)
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
For many, shapefiles are going to be the most common way to interact with spatial data.  In R, there are many ways to read in shapefiles.  We are going to focus using `rgdal` becuase it is flexible and provides a common interface to multiple file types.  But to be fair, I'll also quickly show a few other options from `maptools` and `shapefiles`.

### Reading in Shapfiles
To read in a shapefile using `rgdal`, we want to use the `readOGR` function.  This function is the primary way to interact with vector data using `rgdal`.  There are many arguments to this function, but the two you need are the "dsn" and "layer".  For a shapefile the "dsn" is the path (in our case probably "data") and the "layer" is the name of the shapefile without any extensions.  The function call to read the DC Metro shapefile from out example data looks like: 


```r
dc_metro <- readOGR("data","Metro_Lines")
```

```
## Error in ogrInfo(dsn = dsn, layer = layer, encoding = encoding, use_iconv = use_iconv, : Cannot open data source
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
```

```
## Error in getinfo.shape(filen): Error opening SHP file
```

```r
summary(dc_metro_mt)
```

```
## Error in summary(dc_metro_mt): error in evaluating the argument 'object' in selecting a method for function 'summary': Error: object 'dc_metro_mt' not found
```


```r
dc_metro_sf<-shapefiles::read.shapefile("data/Metro_Lines")
```

```
## Warning in file(shp.name, "rb"): cannot open file 'data/Metro_Lines.shp':
## No such file or directory
```

```
## Error in file(shp.name, "rb"): cannot open the connection
```

```r
summary(dc_metro_sf)
```

```
## Error in summary(dc_metro_sf): error in evaluating the argument 'object' in selecting a method for function 'summary': Error: object 'dc_metro_sf' not found
```

Couple of notes on these.  First the `maptools` ones require that you know your geomtery type, whereas, `readOGR` will get that from the data.  I did test to see if the the `maptools::readShapeLines` was any quicker than `rgdal::readOGR` and in my huge sample of one, it was. Second, `shapefiles::read.shapefile` pulls the shapefile in as a list and thus the defualt plotting, printing, summary etc. methods you get with an `sp` object are not available to you.  Further work would need to be done to get these into the appropriate `sp` object.  Lastly, each of these are one-trick ponies.  They read in shapefiles and that is it.  As we will see, readOGR works across a range of vector data types and thus, is what I would recomend for most spatial data I/O tasks.

### Writing shapefiles

Writing shapefiles is just as easy as reading them, assuming you have an `sp` object to work with.  We will just show this using `readOGR`.

Before we do this, we can prove that the shapefile doesn't exist.


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
A recent addition to the GDAL world is the ability to read ESRI File Geodatabases.  This is easy to access on windows as the latest version of GDAL is wrapped up as part of the `rgdal` install and thus you get access to the appropriate drivers.  This is a bit more challenging on Linux (even more so on the antiquated RHEL 6 that is EPAs approved OS) as you need to have GDAL 1.11.x +.  In any event, if you use file geodatabases, you can read those directly into R with readOGR.



## Vector data: geojson

## Exercise 2.1

## Raster data: esri grids

## Raster data: ASCII

## Raster data: common image formats

## Exercise 2.2

## Geospatial data packages
- maps
- USCensus

