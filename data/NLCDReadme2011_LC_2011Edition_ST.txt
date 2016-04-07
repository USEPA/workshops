National Land Cover Database (NLCD) Tiled Data Distribution SYstem (TDDS) Zipfile Content Readme

Table of Contents


INTRODUCTION
Process Description
Part 1: Data Specification
PART 2: TILED DATA DISTRIBUTION SYSTEM (TDDS) - ORTHOIMAGERY INFORMATION
Part 3: FILE NAMING CONVENTION
PART 4: CONTENTS OF ZIPFILE
PART 5: DISTRIBUTION INFORMATION
Part 6: Resource Information

Introduction
The National Land Cover Database 2001 Percent Developed Imperviousness was produced through a cooperative project conducted by the Multi-Resolution Land Characteristics (MRLC) Consortium.  The MRLC Consortium is a partnership of federal agencies (www.mrlc.gov), consisting of the U.S. Geological Survey (USGS), the National Oceanic and Atmospheric Administration (NOAA), the U.S. Environmental Protection Agency (EPA), the U.S. Department of Agriculture (USDA), the U.S. Forest Service (USFS), the National Park Service (NPS), the U.S. Fish and Wildlife Service (FWS), the Bureau of Land Management (BLM) and the USDA Natural Resources Conservation Service (NRCS).  One of the primary goals of the project is to generate a current, consistent, seamless, and accurate National Land Cover Database (NLCD) circa 2001 for the United States at medium spatial resolution.  For a detailed definition and discussion on MRLC and the NLCD 2001 products, refer to Homer et al. (2003) and http://www.mrlc.gov/mrlc2k.asp.



The NLCD 2001 was created by partitioning the U.S. into mapping zones.  A total of 66 mapping zones were delineated within the conterminous U.S. based on ecoregion and geographical characteristics, edge-matching features and the size requirement of Landsat mosaics.  This update represents a seamless assembly of updated NLCD 2001 Percent Developed Imperviousness for all 66 MRLC mapping zones.  Questions about the NLCD 2001 Percent Developed Imperviousness 2011 Edition can be directed to the NLCD 2001 land cover mapping team at the National Center, EROS, Sioux Falls, SD (605) 594-6151 or mrlc@usgs.gov.

Process Description
To develop adequate training data for impervious estimation, approximately 20 DOQQ's across each mapping zone with a nominal spatial resolution of 1-m were classified into either pervious or non-pervious surfaces, and then summed within each 30 meter Landsat pixel cell to obtain percentage of imperviousness. Training data were selected based on the degree of variance each training data set possesses with regards to Landsat ETM+ imagery used for mapping.  Each added training data set decreased the amount of variance present within the Landsat data as a whole.  The selection process was repeated until the amount of variance explained reached a pre-defined threshold.

          By combining the training data with Landsat spectral data and other ancillary data, percent imperviousness prediction models were developed using a regression tree algorithm (named "Cubist").   All data layers used as input for running the Cubist, in order to establish the prediction model for imperviousness are listed in the "Supplemental Information" section.  Three ancillary data sets were used for urban/suburban delineation masking, which is essential to confine the imperviousness mapping within the developed areas.

          After the best combination of possible input data layers had been determined and the final percent impervious layer produced, the urban mask created was used to eliminate those pixels from the final percent impervious file that fall outside identified impervious surface areas.  Thus, the impervious pixels identified within the mask were retained, while all non-impervious surface pixels were removed from the final product.  This corrected for any small areas of pixels that may have been included as part of the impervious surface layer because their spectral signature was not covered in the Cubist modeling process.  Finally, visual inspection of imperviousness layer was made with limited manual editing to eliminate non-urban areas based on area of interest delineated by the mapping team.

          For Landsat Scene Acquisition dates and identification numbers for imagery used in the NLCD 2001 land, please see:  appendix2_nlcd2001_scene_list_by_zone.txt

NLCD 2001 Impervious (2011 Edition) Processing
          To improve NLCD imperviousness the 2011 project included a process to reduce omission and commission error in NLCD 2001, 2006, and 2011 products.  This activity was completed for urban areas in most of the eastern ½ of the conterminous United States.  High resolution (one-meter ground sample distance) National Aerial Imagery Program (NAIP – http://fsa.usda.gov/FSA/) imagery was used to verify imperviousness.  Using hand-edits imperviousness was removed from areas incorrectly identified as developed and added to areas where developed land cover was missed.  A modeling process was implemented to parse imperviousness changes to the correct era.  These improvements were incorporated with the derived developed classes in all areas of imperviousness and land cover versions released with NLCD 2011 editions.

PART 1: Data Specifications and Products


	Resolution:      	one Arc Second (~30 meter)
  	Data type:      	GeoTIFF
  	Projection:  		Albers Conical Equal Area
  	Datum:       		NAD83
  	

	NLCD 2011 - Landcover  - 2011 Edition includes data for Conterminous U.S..  
	

PART 2: TILED DATA DISTRIBUTION SYSTEM (TDDS) - NLCD INFORMATION

Tiled Data Distribution System (TDDS) is a means to access pre-packaged data.  The zip bundles contain the product image and associated files, an overall coverage shapefile, metadata, color table file, appendix of scene listings, and readme.  The data is available for download thru The National Map viewer and MRLC viewer.  (http://viewer.nationalmap.gov/viewer/ and http://gisdata.usgs.gov/website/mrlc/viewer.htm)

Part 3: FILE NAMING CONVENTION

Each tile is cut to the state boundary.  The naming convention for each tile is the NLCD product and state name.


The file naming convention is:
	
        NLCDFFFF_NNN_aaaaaa

		NLCD      =  National Land Cover Database
		FFFF      =  Project Year (2011)
                NNN       =  Product type (LC = Landcover, IMP = Imperviousness, Canopy = CAN)
		aaaaaa    =  State Name		


  	Example: NLCD2001_LC_Alabama.zip 

			NLCD     =  National Land Cover Database
	 		2011     =  Project year 2011
		      	LC       =  Landcover product
                        Alabama  =  State
                        			           

PART 4: CONTENTS OF ZIPFILE

	
	.tif  	 =  Geotiff image
	.tfw	 =  World file for full resolution Geotiff image
	.aux.xm l=  diplay info
	.prj	 =  Projection File
	.jpg	 =  Lossy compressed image
	.jpw     =  World file for lossy compressed image
	.xml     =  FGDC Metadata file 
	.htm     =  HTML format FGDC metadata file suitable for reading and printing
	.vat.dbf =  Color table information
	Shapefile
	 (.dbf, .prj, .sbn, .sbx, .shp, .shx)
		=  The shapefile (consisting of 6 files) represents the state boundaries
	NLCDReadme2011_LC_2011Edition_ST.txt 
		=  The readme text file
	Appendix
		=  List of Landsat scenes and scene dates by path/row used in this project


PART 5: DISTRIBUTION INFORMATION

	Access points (i.e. map interface) can be found at:
		
		http://viewer.nationalmap.gov/viewer/ and http://gisdata.usgs.gov/website/mrlc/viewer.htm
	
	To acquire entire datasets via Bulk Data Distribution, they can be found at:
	
		http://www.mrlc.gov/


Part 6: Resource Information

Information concerning the Multi-Resolution Land Characteristics Consortium  (MRLC), data info, and refernces can be found at:
	
		http://www.mrlc.gov/



Disclaimer:  Any use of trade, product, or firm names is for descriptive 
purposes only and does not imply endorsement by the U. S. Government.    


Readme Publication Date:  May 2014


