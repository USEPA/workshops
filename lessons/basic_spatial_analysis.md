

# Basic GIS Analysis with R
We now have the required packages installed and know how to read data into R. Our next step is to start doing some GIS analysis with R. Throughout the course of this lesson will show how to do some basic manipulation of the `raster` and `sp` objects and then show a few examples of relatively straightforward analyses.  We will only be scratching the surface here, but hopefully this will provide a starting point for more work doing spatial analysis in R.  ***Note:*** *Much of this lesson assumes some familiarity with R and working with data frames.*

## Lesson Outline
- [Explore and manipulate](#explore-and-manipulate)
- [Projections](#projections)
- [Brief introduction to rgeos](#brief-introduction-to-rgeos)
- [Working with rasters](#working-with-rasters)
- [Other geospatial packages](#other-geospatial-packages)

## Lesson Exercises
- [Exercise 3.1](#exercise-31)
- [Exercise 3.2](#exercise-32)
- [Exercise 3.3](#exercise-33)

## Explore and manipulate
One of the nice things about `SpatialXDataFrame` objects is that many of the tricks you know for working with data frames will also work.  This allows us to subset our spatial data, summarize data, etc. in a very R like way.

Let's start working through some examples using the two Metro datasets.


```
## Error in ogrInfo(dsn = dsn, layer = layer, encoding = encoding, use_iconv = use_iconv, : Cannot open data source
```

```
## Error in ogrInfo(dsn = dsn, layer = layer, encoding = encoding, use_iconv = use_iconv, : Cannot open data source
```

```
## Error in .rasterObjectFromFile(x, band = band, objecttype = "RasterLayer", : Cannot create a RasterLayer object from this file. (file does not exist)
```

We've already seen how to use the default print statements to look at the basics


```r
dc_metro
```

```
## Error in eval(expr, envir, enclos): object 'dc_metro' not found
```

```r
dc_metro_sttn
```

```
## Error in eval(expr, envir, enclos): object 'dc_metro_sttn' not found
```

We can get more info on the data with:


```r
head(dc_metro_sttn)
```

```
## Error in head(dc_metro_sttn): object 'dc_metro_sttn' not found
```

```r
summary(dc_metro_sttn)
```

```
## Error in summary(dc_metro_sttn): object 'dc_metro_sttn' not found
```

```r
names(dc_metro_sttn)
```

```
## Error in eval(expr, envir, enclos): object 'dc_metro_sttn' not found
```

```r
# Look at individual columns
dc_metro_sttn$NAME
```

```
## Error in eval(expr, envir, enclos): object 'dc_metro_sttn' not found
```

And to get into the guts of the `sp` objects:


```r
str(dc_metro)
```

```
## Error in str(dc_metro): object 'dc_metro' not found
```

Yikes!

Now for the fun part.  We can use indexing/subsetting tools we already know to pull out individual features based on the data stored in the `sp` objects data frame.  For instance:


```r
# select with base indexing
est_mrkt <- dc_metro_sttn[dc_metro_sttn$NAME == "Eastern Market", ]
```

```
## Error in eval(expr, envir, enclos): object 'dc_metro_sttn' not found
```

```r
est_mrkt
```

```
## Error in eval(expr, envir, enclos): object 'est_mrkt' not found
```

```r
# select with subset (plus a Lil Rhody Shout Out!)
ri <- subset(dc_metro_sttn, NAME == "Rhode Island Ave")
```

```
## Error in subset(dc_metro_sttn, NAME == "Rhode Island Ave"): object 'dc_metro_sttn' not found
```

```r
ri
```

```
## Error in eval(expr, envir, enclos): object 'ri' not found
```

```r
# select multiple items
red_line_sttn <- subset(dc_metro_sttn, grepl("red", LINE))
```

```
## Error in subset(dc_metro_sttn, grepl("red", LINE)): object 'dc_metro_sttn' not found
```

```r
red_line_sttn
```

```
## Error in eval(expr, envir, enclos): object 'red_line_sttn' not found
```

Adding data is just the same as for adding data to data frames.  I found some ridership data for the different stations and summarized that, by station, into "station_rides.csv".  Let's pull that in, and add it to `dc_metro_sttn`.  


```r
station_rides <- read.csv("data/station_rides.csv")
```

```
## Warning in file(file, "rt"): cannot open file 'data/station_rides.csv': No
## such file or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```r
dc_metro_sttn <- merge(dc_metro_sttn, station_rides, by.x = "NAME", by.y = "Ent.Station", 
    all.x = TRUE)
```

```
## Error in merge(dc_metro_sttn, station_rides, by.x = "NAME", by.y = "Ent.Station", : object 'dc_metro_sttn' not found
```

```r
head(dc_metro_sttn)
```

```
## Error in head(dc_metro_sttn): object 'dc_metro_sttn' not found
```

So, now we can use these values to select.


```r
busy_sttn <- subset(dc_metro_sttn, avg_wkday >= 10000)
```

```
## Error in subset(dc_metro_sttn, avg_wkday >= 10000): object 'dc_metro_sttn' not found
```

```r
busy_sttn
```

```
## Error in eval(expr, envir, enclos): object 'busy_sttn' not found
```


## Projections
Although many GIS provide project-on-the-fly (jwh editorial: WORST THING EVER), R does not.  To get our maps to work and analysis to be correct, we need to know how to modify the projections of our data so that they match up.  A description of projections is way beyond the scope of this workshop, but these links provide some good background info and details:

- [USGS](http://egsc.usgs.gov/isb//pubs/MapProjections/projections.html)
- [NCEAS](https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/OverviewCoordinateReferenceSystems.pdf)

And for more on projecting there's some good info in the [rOpenSci draft spatial data viz Task View](https://github.com/ropensci/maptools#projecting-data)

For our purposes we will be using `spTransform` to reproject data.  We need to supply two arguments, "x", the object we are transforming, and "CRSobj" which is the details of the new projection.  We will assume that we have good data read into R and that the original projection is already defined.  This is the case with all of the example data.

There are many ways to specify the "CRSobj".  We will be using [Proj.4](https://trac.osgeo.org/proj/) strings and the `CRS` function for this.  We can get the Proj.4 strings from other datasets, or specify them from scratch.  To get them from scratch, the easiest thing to do is search at [spatialreference.org](http://spatialreference.org/).  You can either search there, or just use Google.  For instance, if we want the [ESRI Albers Equal Area projection as Proj.4](www.google.com/search?q=ESRI Albers Equal Area projection as Proj.4) gets it as the first result.  Just select the [Proj4](http://spatialreference.org/ref/esri/usa-contiguous-albers-equal-area-conic/proj4/) link from the list.

So, if we want to reproject our data using this projection:


```r
esri_alb_p4 <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
dc_metro_alb <- spTransform(dc_metro, CRS(esri_alb_p4))
```

```
## Error in spTransform(dc_metro, CRS(esri_alb_p4)): object 'dc_metro' not found
```

Luckily, it is pretty common to have several datasets with one of which in the projections you want to use.  We can then just pull the Proj4 string from that.


```r
dc_metro_sttn_prj <- spTransform(dc_metro_sttn, CRS(proj4string(dc_metro_alb)))
```

```
## Error in spTransform(dc_metro_sttn, CRS(proj4string(dc_metro_alb))): object 'dc_metro_sttn' not found
```

Projecting rasters is a bit different.  We will use `raster::projectRaster` to accomplish this. Be aware that this is looking for a Proj4 string for the "crs", and not a CRSobj.  


```r
dc_elev_prj <- projectRaster(dc_elev, crs = proj4string(dc_metro_sttn_prj))
```

```
## Error in methods::extends(class(x), "BasicRaster"): object 'dc_elev' not found
```

## Exercise 3.1
In this first exercise we will work on manipulating the Tiger Lines file of the states that we pulled in as part of lesson 2 and assigned to `us_states`.

1. Assign just the DC boundary to an object named `dc_bnd`.
2. Re-project `dc_bnd` to match the projection of `dc_nlcd`.  Assign this to an object named `dc_bnd_prj`.

## Brief introduction to rgeos
In this section we are going to start working with many of the "typical" GIS type analyses, specifically buffers and a few overlays. We will use mostly `rgeos` but will also look a bit at `sp::over`.

Let's start with a buffer. We will use the albers projected stations for these examples


```r
sttn_buff_500 <- gBuffer(dc_metro_sttn_prj, width = 500)
```

```
## Error in is.projected(spgeom): object 'dc_metro_sttn_prj' not found
```

```r
plot(sttn_buff_500)
```

```
## Error in plot(sttn_buff_500): object 'sttn_buff_500' not found
```

We can see that overlapping buffers merged in this case.  If we wanted a buffer for each station we can use the "byid" argument.


```r
sttn_buff_500_id <- gBuffer(dc_metro_sttn_prj, width = 500, byid = TRUE)
```

```
## Error in is.projected(spgeom): object 'dc_metro_sttn_prj' not found
```

```r
plot(sttn_buff_500_id)
```

```
## Error in plot(sttn_buff_500_id): object 'sttn_buff_500_id' not found
```

Now we get a 500 meter circle around each of the stations.  Let's move on to one of the overlay commands in `rgeos`,the difference.


```r
# Create something to take difference of
sttn_buff_100 <- gBuffer(dc_metro_sttn_prj, width = 100)
```

```
## Error in is.projected(spgeom): object 'dc_metro_sttn_prj' not found
```

```r
sttn_diff <- gDifference(sttn_buff_500, sttn_buff_100)
```

```
## Error in identical(spgeom1@proj4string, spgeom2@proj4string): object 'sttn_buff_500' not found
```

```r
sttn_diff
```

```
## Error in eval(expr, envir, enclos): object 'sttn_diff' not found
```

```r
# pulls into individual polygons, instead of a single multi-polygon.
sttn_diff <- disaggregate(sttn_diff)
```

```
## Error in disaggregate(sttn_diff): object 'sttn_diff' not found
```

```r
sttn_diff
```

```
## Error in eval(expr, envir, enclos): object 'sttn_diff' not found
```

```r
plot(sttn_diff)
```

```
## Error in plot(sttn_diff): object 'sttn_diff' not found
```

Lastly, let's pull out some of the basic geographic info on our datasets using `rgeos`.  That is provided by `gArea` and `gLength`. Let's get the area and perimeter of the all the land 500 meters from a metro station


```r
gLength(sttn_diff)
```

```
## Error in is.projected(spgeom): object 'sttn_diff' not found
```

```r
gArea(sttn_diff)
```

```
## Error in is.projected(spgeom): object 'sttn_diff' not found
```

```r
# likely want area of each poly
gArea(sttn_diff, byid = TRUE)
```

```
## Error in is.projected(spgeom): object 'sttn_diff' not found
```

We have left most of `rgeos` untouched, but hopefully shown enough to get you started.  

## Exercise 3.2
We will work with the re-projected `dc_bnd_prj` lets set this up for some further analysis.

1. Buffer the DC boundary by 1000 meters. Save it to dc_bnd_1000
2. Assign an object that represents only the area 1000 meters outside of DC (hint: gDifference).
3. Determine the area of both the DC boundary as well as just the surrounding 1000 meters.

## Working with rasters
Let's move on to rasters.  We will be doing mostly work with base R to summarize information stored in rasters and use our vector datasets to interact with those rasters and then we will show a few functions from `raster`.

We've already seen how to get some of the basic info of a raster.  To re-hash:


```r
dc_elev
```

```
## Error in eval(expr, envir, enclos): object 'dc_elev' not found
```

This gives us the basics.  There are many options for looking at the values stored in the raster.  I usually default to `values` which returns the values as a vector which we can then use in R functions.

For instance, mean elevation in `dc_elev` could be calculated with 


```r
mean(values(dc_elev), na.omit = T)
```

```
## Error in values(dc_elev): object 'dc_elev' not found
```

If our raster contains categorical data (e.g. LULC), we can work with that too.  We don't have a ready example so lets use another `raster` function to reclassify our elevation data and then look at some summary stats of that.


```r
# reclass elevation into H, M, L
elev_summ <- summary(values(dc_elev))
```

```
## Error in values(dc_elev): object 'dc_elev' not found
```

```r
# this is the format for the look up table expected by reclassify
rcl <- matrix(c(-Inf, elev_summ[2], 1, elev_summ[2], elev_summ[5], 2, elev_summ[5], 
    Inf, 3), nrow = 3, byrow = T)
```

```
## Error in matrix(c(-Inf, elev_summ[2], 1, elev_summ[2], elev_summ[5], 2, : object 'elev_summ' not found
```

```r
dc_elev_class <- reclassify(dc_elev, rcl)
```

```
## Error in reclassify(dc_elev, rcl): object 'dc_elev' not found
```

```r
dc_elev_class
```

```
## Error in eval(expr, envir, enclos): object 'dc_elev_class' not found
```

So now we have categorical data, we can do cross-tabs on the values and calculate percent in each category.


```r
elev_class_perc <- table(values(dc_elev_class))/length(values(dc_elev_class))
```

```
## Error in values(dc_elev_class): object 'dc_elev_class' not found
```

```r
elev_class_perc
```

```
## Error in eval(expr, envir, enclos): object 'elev_class_perc' not found
```

The last task we will show is using vector to data to clip out our raster data.  We can do this with crop and mask.  We do the crop first as it will subset our raster based on the extent.  In most cases this is a significantly smaller area than the full raster dataset and speeds up the subsequent mask. We will do this with the projected versions.


```r
dc_elev_crop <- crop(dc_elev_prj, sttn_buff_500)
```

```
## Error in crop(dc_elev_prj, sttn_buff_500): object 'dc_elev_prj' not found
```

```r
plot(dc_elev_crop)
```

```
## Error in plot(dc_elev_crop): object 'dc_elev_crop' not found
```

```r
plot(sttn_buff_500, add = T)
```

```
## Error in plot(sttn_buff_500, add = T): object 'sttn_buff_500' not found
```

So, with this limited to just the extent of our dataset we can now clip out the values for each of the circles with.


```r
dc_elev_sttns <- mask(dc_elev_crop, sttn_buff_500)
```

```
## Error in mask(dc_elev_crop, sttn_buff_500): object 'dc_elev_crop' not found
```

```r
plot(dc_elev_sttns)
```

```
## Error in plot(dc_elev_sttns): object 'dc_elev_sttns' not found
```

```r
plot(sttn_buff_500, add = T, border = "red", lwd = 2)
```

```
## Error in plot(sttn_buff_500, add = T, border = "red", lwd = 2): object 'sttn_buff_500' not found
```

That gives us just the elevation within 500 meters of the Metro stations.  Probably not really interesting information, but we have it!  It might be more interesting to get the average elevation of each metro station.  Our workflow would be different as we would need to look at this on a per-station basis.  Might require a loop or a different approach all together.  Certainly possible, but beyond what we have time for today.

## Exercise 3.3
Let's combine all of this together and calculate some landcover summary statistics

1. Clip out the NLCD from within the DC boundaries.
2. Clip out the NLCD from the surrounding 1000 meters.
3. Summarize the land use/land cover statistics and report percent of each landcover type both within the DC boundary and within the surrounding 1000 meters.

## Other Geospatial packages
In this section, I'll introduce a few other packages that I have used or know about that provide some common analyses that may not be readily available via the base packages.  For a complete annotated listing though, the [CRAN Spatial Analysis Task View](https://cran.r-project.org/web/views/Spatial.html) should be your first stop.  The task view provides a full list of packages for working with spatial data, geostatistics, spatial regression, etc.  

Some of the other packages I have used for various tasks have been:
- [gdistance](https://cran.r-project.org/web/packages/gdistance/index.html): Provides tools for calculating distances across a grid.  Computes things like cost distance, accumulate costs, shortest path, etc. The [vignette for gdistance](https://cran.r-project.org/web/packages/gdistance/vignettes/gdistance1.pdf) is a good place to start for an overview of the package.
- [geosphere](https://cran.r-project.org/web/packages/geosphere/index.html): `geosphere` provides tools for spherical trigonometry and allows working directly with latitude, longitude, and bearing.  For more, look at the [vignette](https://cran.r-project.org/web/packages/geosphere/vignettes/geosphere.pdf).
- [SDMTools](https://cran.r-project.org/web/packages/SDMTools/index.html): This package provides functions to work with species distribution models.  In addition though, it also has implementations of most of the metrics available in the venerable landscape ecology tool, [FRAGSTATS](http://www.umass.edu/landeco/research/fragstats/fragstats.html).

