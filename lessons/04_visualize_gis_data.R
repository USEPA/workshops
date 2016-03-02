## ----data_setup
dc_metro <- readOGR("data","Metro_Lines",verbose=FALSE)
dc_metro_sttn <- readOGR("data/metrostations.geojson", "OGRGeoJSON",verbose = FALSE)
dc_elev <- raster("data/dc_ned.tif")
dc_metro_prj <- spTransform(dc_metro,
                CRS("+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"))
dc_metro_sttn_prj <- spTransform(dc_metro_sttn,
                                 CRS(proj4string(dc_metro_prj)))
dc_elev_prj <- projectRaster(dc_elev,crs=proj4string(dc_metro_sttn_prj)) 
sttn_buff_500 <- gBuffer(dc_metro_sttn_prj,width=500)

## ------------------------------------------------------------------------
plot(dc_metro)
#Play with symbology
plot(dc_metro, col="red", lwd = 3)
#Use data to color
plot(dc_metro, col=dc_metro$NAME, lwd=dc_metro$GIS_ID)

## ------------------------------------------------------------------------
plot(dc_metro)
#Add stations, change color,size, and symbol
plot(dc_metro_sttn, add=T, col="red", pch=15, cex=1.2)

## ------------------------------------------------------------------------
plot(dc_elev)
plot(dc_metro, add=T)
plot(dc_metro_sttn, add=T, col="red", pch=15,cex=1.2)

## ------------------------------------------------------------
install.packages("quickmapr")
library(quickmapr)

## ------------------------------------------------------------------------
my_map <- qmap(dc_elev_prj,dc_metro_prj,dc_metro_sttn_prj)

## --------------------------------------------------------------
zi(my_map)
p(my_map)
zo(my_map)
i(my_map,3)
f(my_map)

## ------------------------------------------------------------------------
my_map<-qmap(dc_metro_prj, dc_metro_sttn_prj, colors=c("yellow","green"), 
             basemap="topo",resolution = 800)
my_map<-qmap(dc_metro_prj, dc_metro_sttn_prj, colors=c("yellow","green"), 
             basemap="1m_aerial",resolution = 800)

## --------------------------------------------------------------
install.packages("leaflet")
library(leaflet)

## ------------------------------------------------------------
map <- leaflet()
map <- addTiles(map)
map <- addPolylines(map,data=dc_metro)
map

## -------------------------------------------------------------
map <- leaflet()
map <- addPolylines(map,data=dc_metro)
map <- addProviderTiles(map,"Esri.NatGeoWorldMap")
map
#or
map <- leaflet()
map <- addPolylines(map,data=dc_metro)
map <- addProviderTiles(map,"MapQuestOpen.Aerial")
map

## -------------------------------------------------------------
map <- leaflet()
map <- addTiles(map)
map <- addPolylines(map,data=dc_metro)
map <- addCircles(map, data=dc_metro_sttn,
                   color="red", weight = 7,
                   popup = dc_metro_sttn$NAME)
map

## -------------------------------------------------------------
map <- leaflet()
map <- addTiles(map)
map <- addPolylines(map,data=dc_metro)
#Note: Takes a while.  Does projection behind the scenes.
map <- addRasterImage(map, dc_elev)
map

