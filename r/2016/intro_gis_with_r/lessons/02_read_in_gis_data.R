## ----download_zip--------------------------------------------
library(httr)
url <- "https://github.com/USEPA/intro_gis_with_r/blob/master/data.zip?raw=true"
GET(url,write_disk("data.zip",overwrite = TRUE))

## ----unzip_it------------------------------------------------
unzip("data.zip",overwrite = TRUE)

## ----read_shp------------------------------------------------------------
dc_metro <- readOGR("data","Metro_Lines")

## ----metro_chk-----------------------------------------------------------
summary(dc_metro)
plot(dc_metro)

## ----maptools------------------------------------------------------------
dc_metro_mt<-maptools::readShapeLines("data/Metro_Lines")
summary(dc_metro_mt)

## ----clean_it,echo=FALS------------------------------------------------
x<-file.remove(list.files("data","dc_metro",full.names = TRUE))

## ----noshap------------------------------------------------------------
list.files("data","dc_metro")

## ----write_shp-----------------------------------------------------------
writeOGR(dc_metro,"data","dc_metro",driver="ESRI Shapefile")

#Is it there?
list.files("data","dc_metro")

## ----read_fgdb-----------------------------------------------------------
#List feature classes
ogrListLayers("data/spx.gdb")
examp_fgdb <- readOGR(dsn = "data/spx.gdb", layer="polygons5")

## ----check_gdb-----------------------------------------------------------
summary(examp_fgdb)
plot(examp_fgdb)

## ----read_geojson--------------------------------------------------------
dc_metro_sttn <- readOGR("data/metrostations.geojson", "OGRGeoJSON")

## ----check_geojson-------------------------------------------------------
#Let's use the defualt print method 
dc_metro_sttn

## ----plot_geojson,eval=TRU---------------------------------------------
#And add a few more things to our plot
plot(dc_metro)
plot(dc_metro_sttn, col = "red", add=TRUE)

## ----write_geojson,eval=F------------------------------------------------
writeOGR(dc_metro_sttn,dsn="stations.gejson",layer="dc_metro_sttn",driver="GeoJSON")

## ----readGDAL------------------------------------------------------------
dc_elev_gdal <- readGDAL("data/dc_ned.tif")
raster::print(dc_elev_gdal) #using the raster print method

## ----raster--------------------------------------------------------------
dc_elev <- raster("data/dc_ned.tif")
dc_elev

## ----time--------------------------------------------------------------
system.time(readGDAL("data/dc_ned.tif"))
system.time(raster("data/dc_ned.tif"))

## ----ascii_examp---------------------------------------------------------
dc_elev_ascii <- raster("data/dc_ned.asc")
dc_elev_ascii

## ----write_rast----------------------------------------------------------
writeRaster(dc_elev,"dc_elev_example.tif", overwrite = T)

