## ---- eval=FALSE---------------------------------------------------------
#if not already installed
install.packages(c("sp","raster","rgdal","rgeos","leaflet"))

## ------------------------------------------------------------------------
library("sp")
library("raster")
library("rgdal")
library("rgeos")

## ------------------------------------------------------------------------
#Get the Town Boundaries
towns_url <- "http://rigis.org/geodata/bnd/muni97b.zip"
download.file(towns_url,"data/ri_towns.zip")
unzip("data/ri_towns.zip",exdir = "data")

#Get Landcover
#Using NLCD becuase I wanted a raster example!
#Download takes time!  DON'T DEMO
lc_url <-"http://gisdata.usgs.gov/tdds/downloadfile.php?TYPE=nlcd2011_lc_state&FNAME=NLCD2011_LC_Rhode_Island.zip"
download.file(lc_url,"data/ri_lulc.zip")
unzip("data/ri_lulc.zip",exdir ="data")

## ------------------------------------------------------------------------
#Read in the vector town boundary
ri_towns <- readOGR("data","muni97b")

## ------------------------------------------------------------------------
#Read in the raster landcover
ri_lulc <- raster("data/NLCD2011_LC_Rhode_Island.tif")

## ------------------------------------------------------------------------
#List the objects in memory
ls()

#Let's look at the towns
#Default view (from the raster package, actually)
ri_towns

#Look at the attributes for my town
#ri_towns[ri_towns$NAME=="SOUTH KINGSTOWN",]
#A few rogue poly's that need to be dealt with (RIGIS is on it!)
ri_towns[ri_towns$NAME=="SOUTH KINGSTOWN" & !is.na(ri_towns$NAME),]

#Now for the raster
ri_lulc

## ------------------------------------------------------------------------
ri_towns <- spTransform(ri_towns,CRS(proj4string(ri_lulc)))

## ------------------------------------------------------------------------
#Plot landcover first
plot(ri_lulc)
#Now add the towns
plot(ri_towns, add = TRUE)

## ------------------------------------------------------------------------
#Get the package if you need it
install.packages("leaflet")


## ------------------------------------------------------------------------
# Reproject because web mapping...
proj4 <- CRS("+ellps=WGS84 +proj=longlat +datum=WGS84 +no_defs")
ri_towns_geo <- spTransform(ri_towns,proj4)

## ------------------------------------------------------------------------
map <- leaflet()
map <- addTiles(map)
map <- addPolygons(map,data=ri_towns_geo,popup = ri_towns$NAME)
#Not Run: Takes a while.  Does projection behind the scenes.
#map <- addRasterImage(map, data = ri_lulc)
map

## ------------------------------------------------------------------------
#Use base R indexing to grab this
idx <- ri_towns[["NAME"]] == "SOUTH KINGSTOWN" & !is.na(ri_towns[["NAME"]])
sk_bnd <- ri_towns[idx,]
sk_bnd

## ------------------------------------------------------------------------
#And plot it with base
plot(ri_towns)
plot(sk_bnd, border="red", lwd = 3, add=T)

## ------------------------------------------------------------------------
sk_lulc <- crop(ri_lulc,sk_bnd)
sk_lulc <- mask(sk_lulc,sk_bnd)
#Color map get's lost, so ...
sk_lulc@legend@colortable <- ri_lulc@legend@colortable

## ------------------------------------------------------------------------
#Plot landcover first
plot(sk_lulc)
#Now add the towns
plot(sk_bnd, border="red",add = T, lwd = 3)

## ------------------------------------------------------------------------
values <- getValues(sk_lulc)
values <- data.frame(table(values))
values$Perc <- round(100 * (values$Freq/sum(values$Freq)),1)

## ------------------------------------------------------------------------
codes <- read.csv("data/nlcd_2011_codes.csv")
values <- merge(values,codes,by.x="values",by.y="code")
knitr::kable(values[,3:4])

