## ----eval = FALSE--------------------------------------------------------
## #if not already installed
## install.packages(c("sp","raster","rgdal","rgeos"))

## ------------------------------------------------------------------------
library("sp")
library("raster")
library("rgdal")
library("rgeos")

## ---- eval=FALSE---------------------------------------------------------
## #Get the Town Boundaries
## towns_url <- "http://rigis.org/geodata/bnd/muni97b.zip"
## download.file(towns_url,"data/ri_towns.zip")
## unzip("data/ri_towns.zip",exdir = "data")
## 
## #Get Landcover
## #Using NLCD becuase I wanted a raster example!
## lc_url <-"http://gisdata.usgs.gov/tdds/downloadfile.php?TYPE=nlcd2011_lc_state&FNAME=NLCD2011_LC_Rhode_Island.zip"
## download.file(lc_url,"data/ri_lulc.zip")
## unzip("data/ri_lulc.zip",exdir ="data")

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

## ---- eval=FALSE---------------------------------------------------------
## #Plot landcover first
## plot(ri_lulc)
## #Now add the towns
## plot(ri_towns, add = TRUE)

## ---- echo=FALSE,message=FALSE-------------------------------------------
#Doing this to hack the empty space issue with 2 plots
x<-png("figure/base.png")
#Plot landcover first
plot(ri_lulc)
#Now add the towns
plot(ri_towns, add = TRUE)
x<-dev.off()

## ---- eval=FALSE---------------------------------------------------------
## #Get the package
## install.packages("leaflet")
## library("leaflet")

## ---- echo=FALSE,message=FALSE-------------------------------------------
#Get the package
if(!require(leaflet)){
  install.packages("leaflet", repo = "https://cran.rstudio.com")
}
library("leaflet")

## ------------------------------------------------------------------------
proj4 <- CRS("+ellps=WGS84 +proj=longlat +datum=WGS84 +no_defs")
ri_towns_geo <- spTransform(ri_towns,proj4)

## ---- eval=FALSE---------------------------------------------------------
## map <- leaflet()
## map <- addTiles(map)
## map <- addPolygons(map,data=ri_towns_geo)
## #Not Run: Takes a while.  Does projection behind the scenes.
## #map <- addRasterImage(map, data = ri_lulc)
## map

## ---- echo=FALSE---------------------------------------------------------
library(htmlwidgets)
map <- leaflet()
map <- addTiles(map)
map <- addPolygons(map,data=ri_towns_geo)
#Not Run: Takes a while.  Does projection behind the scenes.
#map <- addRasterImage(map, data = ri_lulc)
saveWidget(map, file="map.html")

## ------------------------------------------------------------------------
#Use base R indexing to grab this
idx <- ri_towns[["NAME"]] == "SOUTH KINGSTOWN" & !is.na(ri_towns[["NAME"]])
sk_bnd <- ri_towns[idx,]
sk_bnd

## ----eval=FALSE----------------------------------------------------------
## #And plot it with base
## plot(ri_towns)
## plot(sk_bnd, border="red", lwd = 3, add=T)

## ----echo=FALSE,message=FALSE--------------------------------------------
x<-png("figure/towns.png")
#And plot it with base
plot(ri_towns)
plot(sk_bnd, border="red", lwd = 3, add=T)
x<-dev.off()

## ---- echo = FALSE, messages = FALSE-------------------------------------
sk_lulc <- crop(ri_lulc,sk_bnd)
sk_lulc <- mask(sk_lulc,sk_bnd)
#Color map get's lost, so ...
sk_lulc@legend@colortable <- ri_lulc@legend@colortable

## ---- eval=FALSE---------------------------------------------------------
## #Plot landcover first
## plot(sk_lulc)
## #Now add the towns
## plot(sk_bnd, border="red",add = T, lwd = 3)

## ---- echo=FALSE,message=FALSE-------------------------------------------
x<-png("figure/sk.png")
#Plot landcover first
plot(sk_lulc)
#Now add the towns
plot(sk_bnd, border="red",add = T, lwd = 3)
x<-dev.off()

## ------------------------------------------------------------------------
values <- getValues(sk_lulc)
values <- data.frame(table(values))
values$Perc <- round(100 * (values$Freq/sum(values$Freq)),1)

## ------------------------------------------------------------------------
codes <- read.csv("data/nlcd_2011_codes.csv")
values <- merge(values,codes,by.x="values",by.y="code")
knitr::kable(values[,3:4])

