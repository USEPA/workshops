## -------------------------------------------------------------
dc_metro <- readOGR("data","Metro_Lines")
dc_metro_sttn <- readOGR("data/metrostations.geojson", "OGRGeoJSON")
dc_elev <- raster("data/dc_ned.tif")

## ------------------------------------------------------------------------
dc_metro
dc_metro_sttn

## ------------------------------------------------------------------------
head(dc_metro_sttn)
summary(dc_metro_sttn)
names(dc_metro_sttn)
#Look at individual columns
dc_metro_sttn$NAME

## ------------------------------------------------------------------------
str(dc_metro)

## ------------------------------------------------------------------------
#select with base indexing
est_mrkt <- dc_metro_sttn[dc_metro_sttn$NAME == "Eastern Market",]
est_mrkt
#select with subset (plus a Lil Rhody Shout Out!)
ri <- subset(dc_metro_sttn,NAME == "Rhode Island Ave")
ri
#select multiple items
red_line_sttn <- subset(dc_metro_sttn,grepl("red",LINE))
red_line_sttn

## ------------------------------------------------------------------------
station_rides <- read.csv("data/station_rides.csv")
dc_metro_sttn<-merge(dc_metro_sttn,station_rides,
                     by.x="NAME",by.y="Ent.Station",all.x=TRUE)
head(dc_metro_sttn)

## ------------------------------------------------------------------------
busy_sttn <- subset(dc_metro_sttn,avg_wkday >= 10000)
busy_sttn

## ------------------------------------------------------------------------
esri_alb_p4 <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
dc_metro_alb <- spTransform(dc_metro,
                CRS(esri_alb_p4))

## ------------------------------------------------------------------------
dc_metro_sttn_prj <- spTransform(dc_metro_sttn,
                                 CRS(proj4string(dc_metro_alb))) 

## ---------------------------------------------------------------
dc_elev_prj <- projectRaster(dc_elev,crs=proj4string(dc_metro_sttn_prj))

## ------------------------------------------------------------------------
sttn_buff_500 <- gBuffer(dc_metro_sttn_prj,width=500)
plot(sttn_buff_500)

## ------------------------------------------------------------------------
sttn_buff_500_id <- gBuffer(dc_metro_sttn_prj,width=500,byid = TRUE)
plot(sttn_buff_500_id)

## ----diff----------------------------------------------------------------
#Create something to take difference of
sttn_buff_100 <- gBuffer(dc_metro_sttn_prj,width = 100)
sttn_diff <- gDifference(sttn_buff_500,sttn_buff_100)
sttn_diff
#pulls into individual polygons, instead of a single multi-polygon.
sttn_diff <- disaggregate(sttn_diff)
sttn_diff
plot(sttn_diff)

## ------------------------------------------------------------------------
gLength(sttn_diff)
gArea(sttn_diff)
#likely want area of each poly
gArea(sttn_diff,byid=TRUE)

## ------------------------------------------------------------------------
dc_elev

## ------------------------------------------------------------------------
mean(values(dc_elev),na.omit=T)

## ------------------------------------------------------------------------
#reclass elevation into H, M, L
elev_summ <- summary(values(dc_elev))
#this is the format for the look up table expected by reclassify
rcl <- matrix(c(-Inf,elev_summ[2],1,
                elev_summ[2],elev_summ[5],2,
                elev_summ[5],Inf,3),
              nrow=3,byrow=T)
dc_elev_class <- reclassify(dc_elev,rcl)
dc_elev_class

## ------------------------------------------------------------------------
elev_class_perc <- table(values(dc_elev_class))/
  length(values(dc_elev_class))
elev_class_perc

## ------------------------------------------------------------------------
dc_elev_crop <- crop(dc_elev_prj,sttn_buff_500)
plot(dc_elev_crop)
plot(sttn_buff_500,add=T)

## ------------------------------------------------------------------------
dc_elev_sttns <- mask(dc_elev_crop,sttn_buff_500)
plot(dc_elev_sttns)
plot(sttn_buff_500,add=T,border="red",lwd=2)

