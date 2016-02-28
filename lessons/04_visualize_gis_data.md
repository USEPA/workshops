
```

```
## OGR data source with driver: ESRI Shapefile 
## Source: "data", layer: "Metro_Lines"
## with 8 features
## It has 4 fields
```

```
## OGR data source with driver: GeoJSON 
## Source: "data/metrostations.geojson", layer: "OGRGeoJSON"
## with 40 features
## It has 6 fields
```

# Visualizing Spatial Data in R
Visualizing spatial data in interactive and static forms is one of the defining characteristics of GIS.  With interactive visualization and analysis, R, admittedly, is not quite up to the standards of a stand-alone GIS like QGIS or ArcGIS.  That being said, it has come quite a long way in the last several years.  Static visualization (e.g. maps) in R are, in my opinion, on par with anything you can create with a dedicated GIS.  A few (now somewhat dated) examples of maps built with R show this:

- [London Bike Hires](http://spatialanalysis.co.uk/wp-content/uploads/2012/02/bike_ggplot.png)
- [Facebook Users](http://paulbutler.org/archives/visualizing-facebook-friends/facebook_map.png)

Now we won't get to this level in just an hour or so, but we will see how to build static maps, get access to simple interactivity, and then see some of the javascript based mapping packages.

## Lesson Outline
- [Visualizing spatial data with `sp` and `raster`](#visualizing-spatial-data-with-sp-and-raster)
- [Using `ggplot2` and `ggmap`](#using-ggplot2-and-ggmap)
- [Simple interactivity with `quickmapr`](#simple-interactivity-with-quickmapr)
- [Javascript packages: `leaflet` and `mapview`](#javascript-packages-leaflet-and-mapview)

## Lesson Exercises
- [Exercise 4.1](#exercise-41)

## Visualizing spatial data with `sp` and `raster`

## Simple interactivity with `quickmapr`

## Exercise 3.1
We will create a map of the data we've been working with, the NLCD and boundary.

1. Map your clipped landcover and the DC boundary using the default tools from `sp` and `raster`.
2. Create the same map, but use `quickmapr`.  Try out some of the interactivity tools: zoom, pan, identify.

## Javascript packages: `leaflet` and `mapview`

## Exercise 3.2



## Using `ggplot2` and `ggmap`
