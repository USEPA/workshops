---
title: 'Spatial Data Analysis in R: Lightning Demo!'
author: "Jeff W. Hollister"
date: "11/3/2015"
output: html_document
---

[Just the Code](README.R)

Free and open source software solutions for GIS have come a long way in the last several years as the tools to handle file I/O, vector analysis, and raster processing have matured.  Built on top of many of these libraries are some farily well known options and include [QGIS](http://www.qgis.org/en/site/), [GRASS](https://grass.osgeo.org/), and [PostGIS](http://postgis.net/).  During this same time, we have seen the rise of the [R Language for Statistical Computing](https://www.r-project.org/) and not to be left behind many of the same libraries are now supported in R.  So given all of these options, plus the tools many use provided by [esri](https://www.esri.com) there is a rich ecosystem of options for GIS analysts.  

The purpose of this lightning demo is to provide a small taste of GIS capabilities that are available in R.  I will run through the set-up required to get going, show examples of reading in and exploring both raster and vector, show some visualization options, and do some simple analysis.  As this is a demo, and supposed to be done in 5 minutes, I will likely fail miserably at this.  Becuase of that, I have created this page that has all of what I wanted to show in one place so when things go off the ralis, you can follow along later.

*Note: This demo assumes a minimum level of familiarity with R*

##Get R set up to do GIS
First task is to make sure we have everything in place to do spatial analysis.  The core packages that will provide nearly all of the GIS functionality you need on a daily basis are:

- `sp`: provides the base data structure for vector (and other) data.  This is the foundation that most GIS in R is built on.
- `raster`: provides the base data strcuture for raster data as well as a bit of visualization and analysis tools.  I prefer this over using `sp` for raster data becuase `raster` leaves data on disk and does not pull it all in to memory.
- `rgdal`: R client for Geospatial Data Abstraction Library (GDAL) and handles file I/O plus projections.  Does require access to GDAL and PROJ.4.  These are part of the package on Windows (e.g. trivial to install), but external libraries need to be loaded on Linux and Mac.
- `rgeos`: R client for the Geometry Engine, Open Source (GEOS).  This provides vector analysis capabilities.  Similar to `rgdal` external libraries are needed, but are part of Windows binaries and needed for Linux and Mac.

To get this set up all we need to do is:


```r
#if not already installed
install.packages(c("sp","raster","rgdal","rgeos"))
```


```r
library("sp")
library("raster")
library("rgdal")
```

```
## rgdal: version: 1.1-8, (SVN revision 616)
##  Geospatial Data Abstraction Library extensions to R successfully loaded
##  Loaded GDAL runtime: GDAL 1.7.3, released 2010/11/10
##  Path to GDAL shared files: /usr/share/gdal
##  GDAL does not use iconv for recoding strings.
##  Loaded PROJ.4 runtime: Rel. 4.7.1, 23 September 2009, [PJ_VERSION: 470]
##  Path to PROJ.4 shared files: (autodetected)
##  Linking to sp version: 1.2-1
```

```r
library("rgeos")
```

```
## rgeos version: 0.3-19, (SVN revision 524)
##  GEOS runtime version: 3.5.0-CAPI-1.9.0 r4084 
##  Linking to sp version: 1.2-2 
##  Polygon checking: TRUE
```

##Read in data
First, let's go find some data... Since we are in Burlington, VT we can keep it local and get some data from the [Vermont Center for Geographic Information](http://vcgi.vermont.gov/).  No need to leave our beloved R command line for this either.  


```r
#Get the Town Boundaries
towns_url <- "http://maps.vcgi.org/gisdata/vcgi/packaged_zips/BoundaryTown_TWNBNDS.zip"
download.file(towns_url,"vt_towns.zip")
unzip("vt_towns.zip")

#Get Landcover
lc_url <-"http://maps.vcgi.org/gisdata/vcgi/packaged_zips/LandLandcov_LCLU.zip"
download.file(lc_url,"vt_lulc.zip")
unzip("vt_lulc.zip")
```

We now have some vector data (the towns) and raster data (the land cover) locally.  How do we pull that into R?  Frist the town boundaries, which are in shapefiles.


```r
#Read in the vector town boundary
vt_towns <- readOGR(".","Boundary_TWNBNDS_poly")
```

```
## OGR data source with driver: ESRI Shapefile 
## Source: ".", layer: "Boundary_TWNBNDS_poly"
## with 255 features
## It has 5 fields
```

That wasn't too bad.  Essentially (for shapefiles, anyway) the first argument is the folder where the shapefiles reside and the second argument is the name of the shapefile (without the `.shp` extension).

Rasters are pretty easy too.  In this case we are reading in an Arc Grid file.  Becuase of the unzipping it is buried a bit in the path.


```r
#Read in the raster landcover
#on linux you can point to the folder
#windows wants the hdr.adf file
vt_lulc <- raster("lclu/lclu/hdr.adf")
```



##Explore that data
So, not much really happened there.  Let's look around at these just to make sure we got something.


```r
#List the objects in memory
ls()
```

```
## [1] "lc_url"    "towns_url" "vt_lulc"   "vt_towns"
```

```r
#Let's look at the towns
#Default view (from the raster package, actually)
vt_towns
```

```
## class       : SpatialPolygonsDataFrame 
## features    : 255 
## extent      : 424788.8, 581562, 25211.84, 279799  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=tmerc +lat_0=42.5 +lon_0=-72.5 +k=0.9999642857142857 +x_0=500000 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs +towgs84=0,0,0 
## variables   : 5
## names       : FIPS6,  TOWNNAME, CNTY, SHAPE_area, SHAPE_len 
## min values  :  1005,   ADDISON,    1,    3811960,  9386.921 
## max values  : 27120, WORCESTER,   27,  191543033, 81013.336
```

```r
#Summary
summary(vt_towns)
```

```
## Object of class SpatialPolygonsDataFrame
## Coordinates:
##         min    max
## x 424788.84 581562
## y  25211.84 279799
## Is projected: TRUE 
## proj4string :
## [+proj=tmerc +lat_0=42.5 +lon_0=-72.5 +k=0.9999642857142857
## +x_0=500000 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs
## +towgs84=0,0,0]
## Data attributes:
##      FIPS6            TOWNNAME        CNTY         SHAPE_area       
##  Min.   : 1005   ADDISON  :  1   Min.   : 1.00   Min.   :  3811960  
##  1st Qu.: 7038   ALBANY   :  1   1st Qu.: 7.00   1st Qu.: 83030613  
##  Median :17020   ALBURGH  :  1   Median :17.00   Median :102573587  
##  Mean   :14785   ANDOVER  :  1   Mean   :14.73   Mean   : 97648783  
##  3rd Qu.:23018   ARLINGTON:  1   3rd Qu.:23.00   3rd Qu.:116550822  
##  Max.   :27120   ATHENS   :  1   Max.   :27.00   Max.   :191543033  
##                  (Other)  :249                                      
##    SHAPE_len    
##  Min.   : 9387  
##  1st Qu.:39861  
##  Median :42591  
##  Mean   :42831  
##  3rd Qu.:46916  
##  Max.   :81013  
## 
```

```r
#Look at the attributes on the towns
head(vt_towns)
```

```
##   FIPS6  TOWNNAME CNTY SHAPE_area SHAPE_len
## 0  9030    CANAAN    9   85677488  61301.88
## 1 11040  FRANKLIN   11  105864062  42591.26
## 2 11015 BERKSHIRE   11  108509286  41941.76
## 3 11050  HIGHGATE   11  155573562  57367.84
## 4 11060  RICHFORD   11  111897346  42398.62
## 5 13005   ALBURGH   13  123041223  55791.54
```

```r
#Or the whole thing
vt_towns@data
```

```
##     FIPS6           TOWNNAME CNTY SHAPE_area SHAPE_len
## 0    9030             CANAAN    9   85677488 61301.881
## 1   11040           FRANKLIN   11  105864062 42591.263
## 2   11015          BERKSHIRE   11  108509286 41941.757
## 3   11050           HIGHGATE   11  155573562 57367.841
## 4   11060           RICHFORD   11  111897346 42398.624
## 5   13005            ALBURGH   13  123041223 55791.542
## 6    9080             NORTON    9  100482148 43902.679
## 7    9005            AVERILL    9   99375244 39817.046
## 8   19050            HOLLAND   19  100189636 40818.363
## 9   19060                JAY   19   87962933 37738.295
## 10  19085               TROY   19   94383638 47965.466
## 11   9060          LEMINGTON    9   91510951 43331.850
## 12  13015      ISLE LA MOTTE   13   47763644 37271.888
## 13   9010        AVERYS GORE    9   47292690 30643.471
## 14   9095        WARREN GORE    9   26689895 22700.035
## 15   9090      WARNERS GRANT    9    8288808 14083.930
## 16  11075            SHELDON   11  101859875 45704.059
## 17  19070             MORGAN   19   88380778 45378.297
## 18   9065              LEWIS    9  101060098 40392.560
## 19  11080            SWANTON   11  159762216 68129.695
## 20  13020         NORTH HERO   13  119147807 55473.749
## 21  11020           ENOSBURG   11  124617361 46401.246
## 22  19090          WESTFIELD   19  103631847 40797.073
## 23  19020         CHARLESTON   19   99805183 42716.501
## 24  11070    ST. ALBANS TOWN   11  157564225 78232.826
## 25  19015        BROWNINGTON   19   73447022 35879.959
## 26  11030          FAIRFIELD   11  177142867 64524.290
## 27   9015         BLOOMFIELD    9  104291960 42262.620
## 28   9020           BRIGHTON    9  140748545 48133.163
## 29  19055           IRASBURG   19  105602850 41563.857
## 30  19065             LOWELL   19  146022290 52294.911
## 31  11010        BAKERSFIELD   11  109203744 50169.372
## 32  11065    ST. ALBANS CITY   11    5080961 12358.664
## 33  19095           WESTMORE   19   97320460 39492.856
## 34   9045          FERDINAND    9  137488290 55273.121
## 35   9025          BRUNSWICK    9   65172509 45467.258
## 36  15005          BELVIDERE   15   92349429 38042.749
## 37  11045            GEORGIA   11  117352157 47293.420
## 38  19005             ALBANY   19  100957172 40183.423
## 39  13010         GRAND ISLE   13   90668009 42391.990
## 40  15045         WATERVILLE   15   40734143 30691.062
## 41  11025            FAIRFAX   11  104627305 46169.391
## 42   5040             NEWARK    5   96449476 39280.804
## 43  11035           FLETCHER   11   99605218 51333.062
## 44  19010             BARTON   19  114883657 47446.339
## 45   5070             SUTTON    5   99686312 45892.705
## 46  19040             GLOVER   19   99792938 39905.803
## 47   7050             MILTON    7  157909639 54906.101
## 48   9040         EAST HAVEN    9   96599833 39249.109
## 49  19030         CRAFTSBURY   19  102452194 40426.323
## 50  15010          CAMBRIDGE   15  164353908 56100.885
## 51   5060          SHEFFIELD    5   84994418 36359.687
## 52  13025         SOUTH HERO   13  120234067 45962.992
## 53   9050             GRANBY    9  100535555 40079.186
## 54  19045         GREENSBORO   19  102430049 40376.553
## 55   5010              BURKE    5   87302153 40549.542
## 56   7080           WESTFORD    7  101351389 41106.414
## 57  15030            JOHNSON   15  118351878 47120.286
## 58  15050            WOLCOTT   15  101790638 40355.084
## 59   7075          UNDERHILL    7  132821810 50063.389
## 60   5085           WHEELOCK    5  103650697 47738.664
## 61   9055          GUILDHALL    9   85414995 46251.024
## 62   9085            VICTORY    9  111578210 43206.593
## 63  15025          HYDE PARK   15  101004201 43210.388
## 64  15035         MORRISTOWN   15  132906472 59518.246
## 65   5025           HARDWICK    5  100122404 40120.650
## 66   5065           STANNARD    5   32895888 26870.072
## 67   5030              KIRBY    5   64068487 35996.915
## 68  15040              STOWE   15  188090869 62697.954
## 69  15020             ELMORE   15  102301503 40653.754
## 70   5035             LYNDON    5  102812108 40506.041
## 71   5075             WALDEN    5  101016952 40181.841
## 72   9070          LUNENBURG    9  117860228 50304.181
## 73   7045            JERICHO    7   91967431 40934.693
## 74   5055      ST. JOHNSBURY    5   95443874 40328.331
## 75   9035            CONCORD    9  138439252 53284.486
## 76  23095           WOODBURY   23  101733756 40229.867
## 77  23100          WORCESTER   23  100298215 40374.843
## 78   7005             BOLTON    7  109193887 48743.768
## 79   5080          WATERFORD    5  103047386 43015.999
## 80  23025             CALAIS   23   99841775 40239.335
## 81   7060         ST. GEORGE    7    9519772 13461.506
## 82   5005             BARNET    5  112665439 50885.601
## 83  23050          MIDDLESEX   23  103054812 46704.820
## 84   5045            PEACHAM    5  123586188 48117.956
## 85  23030            DUXBURY   23  111413424 43527.739
## 86   7020          CHARLOTTE    7  130472781 45660.621
## 87   7040         HUNTINGTON    7   99255523 46947.996
## 88  23090          WATERBURY   23  128420961 52612.985
## 89  23045         MARSHFIELD   23  113239389 44445.599
## 90  23035    EAST MONTPELIER   23   82857518 40005.364
## 91  23060           MORETOWN   23  104170757 43631.720
## 92  23055         MONTPELIER   23   26574156 27746.897
## 93   1095         STARKSBORO    1  117985555 51495.492
## 94   5020             GROTON    5  142560238 48741.074
## 95  23070         PLAINFIELD   23   54611423 30915.114
## 96   1060            MONKTON    1   93934902 40092.555
## 97  23040            FAYSTON   23   94571698 41780.654
## 98  23015             BERLIN   23   95078831 43010.828
## 99   1025        FERRISBURGH    1  158603750 59759.290
## 100 23010         BARRE TOWN   23   79596348 52800.427
## 101  7010         BUELS GORE    7   12956149 18648.542
## 102 17040             ORANGE   17  100903459 40571.669
## 103 23005         BARRE CITY   23   10430110 17298.477
## 104  1015            BRISTOL    1  106722088 51862.878
## 105 17060            TOPSHAM   17  126946316 45763.950
## 106  1100          VERGENNES    1    6560941 10203.963
## 107  1065          NEW HAVEN    1  107484465 52068.204
## 108  1075             PANTON    1   57071357 35471.780
## 109  1105            WALTHAM    1   23917473 25500.316
## 110  1050            LINCOLN    1  118620948 47935.511
## 111 17075         WASHINGTON   17  101091529 40334.126
## 112  1005            ADDISON    1  126776512 48458.610
## 113 17025            CORINTH   17  125220680 45062.736
## 114  1110          WEYBRIDGE    1   45500501 30602.223
## 115 17020            CHELSEA   17  103821734 43889.978
## 116  1055         MIDDLEBURY    1  102803224 41226.325
## 117  1080             RIPTON    1  127878470 51332.665
## 118  1010           BRIDPORT    1  119957420 44416.938
## 119  1020           CORNWALL    1   74424823 36536.659
## 120 17070           VERSHIRE   17   93626405 38990.324
## 121 17080       WEST FAIRLEE   17   59149461 32673.479
## 122 17030            FAIRLEE   17   54499733 34227.128
## 123  1040            HANCOCK    1   99942616 47182.635
## 124 17065          TUNBRIDGE   17  116004828 43070.775
## 125  1085          SALISBURY    1   77952186 38473.985
## 126 27075          ROCHESTER   27  148013539 81013.336
## 127  1090           SHOREHAM    1  119466396 45534.173
## 128 17050          STRAFFORD   17  114637747 43607.819
## 129 27020             BETHEL   27  118502490 43779.901
## 130 17055           THETFORD   17  114859401 44877.980
## 131 27080           ROYALTON   27  105631686 41508.267
## 132  1070             ORWELL    1  128785302 47182.934
## 133 21075         PITTSFIELD   21   53205993 38572.117
## 134 27085             SHARON   27  104395323 41995.775
## 135 27095        STOCKBRIDGE   27  119263837 48331.618
## 136 27055            NORWICH   27  115847321 46161.607
## 137 27015            BARNARD   27  125426997 44928.740
## 138 21005             BENSON   21  117483498 45082.106
## 139 27040           HARTFORD   27  119080761 45121.142
## 140 21047         KILLINGTON   21  123274391 50594.658
## 141 27025        BRIDGEWATER   27  128500178 45900.366
## 142 21135         WEST HAVEN   21   74478281 46397.865
## 143 21035         FAIR HAVEN   21   47183547 37027.806
## 144 27045           HARTLAND   27  117311187 46800.806
## 145 27060           PLYMOUTH   27  127409918 46144.286
## 146 21110         SHREWSBURY   21  129086797 48461.827
## 147 27070            READING   27  106860075 41636.197
## 148 27115            WINDSOR   27   51190903 30375.851
## 149 21125        WALLINGFORD   21  111503268 45313.239
## 150 21060        MOUNT HOLLY   21  125860727 47258.245
## 151 21070             PAWLET   21  111447199 42319.846
## 152 27050             LUDLOW   27   93946560 42579.210
## 153 21030              DANBY   21  107936081 41329.539
## 154 21065        MOUNT TABOR   21  114599431 46642.415
## 155 27105             WESTON   27   92106507 45568.006
## 156 27005            ANDOVER   27   74862897 37742.984
## 157 27090        SPRINGFIELD   27  128476210 46364.834
## 158  3045             RUPERT    3  115977183 42831.177
## 159  3015             DORSET    3  123025408 45443.723
## 160  3030               PERU    3   97088203 39582.521
## 161  3020          LANDGROVE    3   23036309 28795.902
## 162 25050        LONDONDERRY   25   93149632 41975.779
## 163 25030            GRAFTON   25   98970259 42734.775
## 164 25110            WINDHAM   25   67788208 35392.758
## 165  3050           SANDGATE    3  109610494 41870.105
## 166  3075            WINHALL    3  115314816 43660.166
## 167  3025         MANCHESTER    3  108980206 41786.673
## 168 25045            JAMAICA   25  128162202 45903.558
## 169 25080          TOWNSHEND   25  110672390 45695.666
## 170 25095        WESTMINSTER   25  117096816 45771.975
## 171  3005          ARLINGTON    3  109369693 41889.160
## 172  3070         SUNDERLAND    3  117975390 43674.698
## 173 25075           STRATTON   25  121362592 48000.491
## 174 25015          BROOKLINE   25   33566339 34118.828
## 175 25090          WARDSBORO   25   75787729 35961.973
## 176  3060         SHAFTSBURY    3  111541317 42249.206
## 177  3018        GLASTENBURY    3  115029773 43129.614
## 178 25073           SOMERSET   25   71236277 34464.932
## 179 25065             PUTNEY   25   69141008 36802.751
## 180 25060            NEWFANE   25  103661069 43004.554
## 181 25020              DOVER   25   92863621 40205.814
## 182 25025         DUMMERSTON   25   80114164 39998.509
## 183  3010         BENNINGTON    3  109467845 42283.601
## 184  3080           WOODFORD    3  123074057 44231.223
## 185  3055          SEARSBURG    3   55450993 29679.768
## 186 25105         WILMINGTON   25  109968938 41967.247
## 187 25055           MARLBORO   25  105473647 41070.469
## 188 25010        BRATTLEBORO   25   84517855 39980.096
## 189  3040          READSBORO    3   93968849 40554.802
## 190  3035             POWNAL    3  121803046 44102.285
## 191  3065           STAMFORD    3  102573587 40489.282
## 192 25100         WHITINGHAM   25  101357536 40364.474
## 193 25040            HALIFAX   25  103066246 40700.055
## 194 25035           GUILFORD   25  102738784 40554.186
## 195 25085             VERNON   25   51886046 36933.408
## 196 11055         MONTGOMERY   11  146119827 51578.456
## 197 15015               EDEN   15  165499437 53912.691
## 198  9075          MAIDSTONE    9   83203708 56927.735
## 199  7025         COLCHESTER    7  156466204 68239.781
## 200  5015           DANVILLE    5  158031897 55724.531
## 201  7090           WINOOSKI    7    3811960  9386.921
## 202 23020              CABOT   23   99482369 41985.883
## 203  7065          SHELBURNE    7  113382460 45753.986
## 204  7055           RICHMOND    7   85239010 39362.260
## 205  7035          HINESBURG    7  102784373 41481.057
## 206 27065            POMFRET   27  102443452 41299.923
## 207 27120          WOODSTOCK   27  114829573 43860.140
## 208 21095       RUTLAND CITY   21   19863925 21544.426
## 209  7015         BURLINGTON    7   39752390 37828.075
## 210 17010          BRAINTREE   17   99837217 41523.101
## 211 17045           RANDOLPH   17  124627917 44983.146
## 212  7030              ESSEX    7  102100944 49310.054
## 213  5050            RYEGATE    5   95506665 44146.963
## 214 17035            NEWBURY   17  167112676 60351.068
## 215  7070   SOUTH BURLINGTON    7   79736942 68384.544
## 216  7085          WILLISTON    7   80514067 47599.981
## 217 17085       WILLIAMSTOWN   17  104530696 41500.797
## 218 17015         BROOKFIELD   17  106819873 43324.482
## 219 17005           BRADFORD   17   77473042 44628.423
## 220 21085           POULTNEY   21  112963230 46883.640
## 221 21120           TINMOUTH   21   74478882 37117.699
## 222 21130              WELLS   21   60104286 31559.934
## 223 21055 MIDDLETOWN SPRINGS   21   58813219 31619.748
## 224 27110       WEST WINDSOR   27   64311242 32935.198
## 225 27035            CHESTER   27  144767778 48680.459
## 226 27030          CAVENDISH   27  102568168 40674.994
## 227 27011          BALTIMORE   27   12336838 15861.100
## 228 27100      WEATHERSFIELD   27  113973687 45784.695
## 229 19080       NEWPORT TOWN   19  112732270 52777.699
## 230 19035              DERBY   19  148585654 64490.856
## 231 19025           COVENTRY   19   71964890 34354.964
## 232 19075       NEWPORT CITY   19   19751687 25766.354
## 233 23065         NORTHFIELD   23  115909986 47045.494
## 234 23080         WAITSFIELD   23   67142073 35347.752
## 235 25070         ROCKINGHAM   25  109234729 45756.370
## 236 25005             ATHENS   25   36386666 29260.080
## 237  1035          GRANVILLE    1  132031156 46977.650
## 238 23075            ROXBURY   23  108124978 41910.225
## 239 23085             WARREN   23  103944760 41859.952
## 240  1030             GOSHEN    1   53723179 37046.954
## 241  1115            WHITING    1   35491952 27680.554
## 242  1045          LEICESTER    1   56177055 32666.716
## 243 21020         CHITTENDEN   21  191543033 57806.307
## 244 21115            SUDBURY   21   57344315 34731.128
## 245 21040         HUBBARDTON   21   74037625 34836.662
## 246 21015          CASTLETON   21  109780844 42287.454
## 247 21045                IRA   21   57676859 39941.289
## 248 21010            BRANDON   21  103714543 42913.050
## 249 21080          PITTSFORD   21  112847899 53488.622
## 250 21140       WEST RUTLAND   21   46815021 34693.459
## 251 21090            PROCTOR   21   19623360 33733.080
## 252 21100            RUTLAND   21   49745234 62913.208
## 253 21050             MENDON   21   98267211 53373.394
## 254 21025          CLARENDON   21   81639419 38371.942
```

```r
#Now for the raster
vt_lulc
```

```
## class       : RasterLayer 
## dimensions  : 12143, 9782, 118782826  (nrow, ncol, ncell)
## resolution  : 25, 25  (x, y)
## extent      : 338237.5, 582787.5, 23149.49, 326724.5  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=tmerc +lat_0=42.5 +lon_0=-72.5 +k=0.9999642857142857 +x_0=500000 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs +towgs84=0,0,0 
## data source : /data/projects/gis_r_demo/lclu/lclu/hdr.adf 
## names       : hdr 
## values      : 3, 212  (min, max)
## attributes  :
##         ID   COUNT
##  from:   3  100266
##  to  : 212 3595406
```

```r
#Value attribute table
print(vt_lulc)
```

```
## factor levels (value attributes)
##    ID    COUNT
## 1   3   100266
## 2   5  4527083
## 3   7    37481
## 4  11   817946
## 5  12    71489
## 6  13    35663
## 7  14  1996579
## 8  17    53087
## 9  22    55548
## 10 24   339358
## 11 41 19895208
## 12 42  8872216
## 13 43  9415618
## 14 61  1474753
## 15 62   357897
```

##Visualize it

We have our data in, we've looked at some of information, but this is all about GIS in R and what would a GIS demo be without some maps.  There are lots of ways to create maps in R and this area is receiveing a lot of development attention.  I'll show three ways to do this: using base tools, using a wrapper around the base tools called `quickmapr` (WARNING: SHAMELESS SELF-PROMOTION), and finally using `leaflet` to map the data.  

I won't spend time on cartography per se, but thought I'd show some examples of maps created in R to show what is possible:

- [London Bike Map](http://spatialanalysis.co.uk/wp-content/uploads/2012/02/bike_ggplot.png)
- [Facebook Connections](http://paulbutler.org/archives/visualizing-facebook-friends/facebook_map.png)

So, let's first look at our data with base functions.  It is pretty straightforward.





```r
#Plot landcover first
plot(vt_lulc)
#Now add the towns
plot(vt_towns, add = TRUE)
```

![map1](map1.png)

Hey, a map!  Simple and easy.  There are many controls for how this draws, but beyond scope for a 5 minute demo.

But what if I want to interact with this map?  Well, that is what `quickmapr` does.


```r
#Get the package
install.packages("quickmapr")
library("quickmapr")
```


With that loaded up we can create the `quickmapr` object and map and then interact with it.




```r
map <- qmap(vt_lulc,vt_towns)
```

![map2](map2.png)

Then a few options for interactions:

- Zooming with `zi()`,`zo()`, and `ze()`
- Pan with `p()`
- Identify with `i()`
- Label with `l()` (work in progress!)
- Back to full extent with `f()`

Last example I'll show is using our data in R, with the `leaflet` package (and javascript library) to build interactive web maps.

Like above, we need the package.


```r
#Get the package
install.packages("leaflet")
library("leaflet")
```

```
## Warning in install.packages :
##   installation of package 'png' had non-zero exit status
## Warning in install.packages :
##   installation of package 'leaflet' had non-zero exit status
## 
## The downloaded source packages are in
## 	'/tmp/RtmpUCr2BI/downloaded_packages'
```

```
## Error in library("leaflet"): there is no package called 'leaflet'
```

Plus, since this is `leaflet`, projected data is going to be a challenge and we need to get the data into geographic coordinates. 


```r
proj4 <- CRS("+proj=longlat +datum=NAD83 +no_defs +ellps=GRS80 +towgs84=0,0,0")
vt_towns_geo <- spTransform(vt_towns,proj4)
```

Now let's create the `leaflet` map.


```r
map <- leaflet()
```

```
## Error in eval(expr, envir, enclos): could not find function "leaflet"
```

```r
map <- addTiles(map)
```

```
## Error in eval(expr, envir, enclos): could not find function "addTiles"
```

```r
map <- addPolygons(map,data=vt_towns_geo)
```

```
## Error in eval(expr, envir, enclos): could not find function "addPolygons"
```

```r
#Not Run: Takes a while.  Does projection behind the scenes.
#map <- addRasterImage(map, data = vt_lulc)
map
```

```
## vt_lulc

## vt_towns
```

##Analyze it
Last thing we would expect to be able to do with any GIS is some geospatial analysis.  For this demo we will keep it simple and pull out some land use and landcover summaries for Burlington.

First, let's extract just Burlington from the towns.


```r
#Use base R indexing to grab this
burlington_bnd <- vt_towns[vt_towns[["TOWNNAME"]] == "BURLINGTON",]
burlington_bnd
```

```
## class       : SpatialPolygonsDataFrame 
## features    : 1 
## extent      : 438211.5, 446215.9, 216431, 226915.8  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=tmerc +lat_0=42.5 +lon_0=-72.5 +k=0.9999642857142857 +x_0=500000 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs +towgs84=0,0,0 
## variables   : 5
## names       : FIPS6,   TOWNNAME, CNTY, SHAPE_area, SHAPE_len 
## min values  :  7015, BURLINGTON,    7,   39752390,  37828.07 
## max values  :  7015, BURLINGTON,    7,   39752390,  37828.07
```

```r
#And plot it, with a basemap in quickmapr
burl <- qmap(vt_towns, burlington_bnd, basemap = "1m_aerial", 
             resolution = 600)
```

![plot of chunk unnamed-chunk-18](figure/unnamed-chunk-18-1.png) 

```r
#Or base
plot(vt_towns)
plot(burlington_bnd, border="red", lwd = 3, add=T)
```

![plot of chunk unnamed-chunk-18](figure/unnamed-chunk-18-2.png) 

Now we can use the boundary to clip out the land use/land cover.



```r
#First we crop the data: which uses the extent.  This speeds up the mask
burlington_lulc <- crop(vt_lulc,burlington_bnd)
#Next we mask which removes lulc outside of town boundary
burlington_lulc <- mask(burlington_lulc,burlington_bnd)
#And look at the result 
plot(burlington_lulc)
plot(burlington_bnd, add = T, lwd = 3)
```

![map3](map3.png)

Last thing to do is summarize our stats:


```r
values <- getValues(burlington_lulc)
values <- data.frame(table(values))
values$Perc <- round(100 * (values$Freq/sum(values$Freq)),1)
```

Well, I am not too familiar with Vermont's codes, so lets add that in.


```r
#Get Codes from VCGI
download.file("http://maps.vcgi.org/gisdata/vcgi/products/products_vcgi/lucodes.zip","vt_lucodes.zip")
unzip("vt_lucodes.zip")
#It's a dbf so we can deal with that in foreign package
library(foreign)
codes <- read.dbf("lucodes/lucodes.dbf")
values <- merge(values,codes,by.x="values",by.y="CODE")
knitr::kable(values[,3:4])
```



| Perc|CATEGORY                                                              |
|----:|:---------------------------------------------------------------------|
| 22.2|RESIDENTIAL                                                           |
|  7.9|COMMERCIAL, SERVICES AND INSTITUTIONAL                                |
|  7.9|COMMERCIAL, SERVICES AND INSTITUTIONAL (continued)                    |
|  0.4|INDUSTRIAL                                                            |
| 14.6|TRANSPORTATION, COMMUNICATION AND UTILITIES                           |
|  5.0|OUTDOOR AND OTHER URBAN AND BUILT-UP LAND                             |
|  4.8|Row crops (not including orchards and berries, code 22)               |
|  1.0|Hay/rotation/permanent pasture                                        |
|  0.5|OTHER AGRICULTURAL LAND                                               |
|  0.1|BRUSH OR TRANSITIONAL BETWEEN OPEN AND FORESTED                       |
|  2.6|BROADLEAF FOREST (generally deciduous)                                |
|  2.5|CONIFEROUS FOREST (generally evergreen)                               |
|  1.6|MIXED CONIFEROUS-BROADLEAF FOREST                                     |
| 35.3|WATER (see 143 for transportation uses and 233 for agricultural uses) |
|  0.4|FORESTED WETLAND                                                      |
|  0.9|NON-FORESTED WETLAND                                                  |

Whew!  Did I finish in 5 minutes.  Most likely not even close.


