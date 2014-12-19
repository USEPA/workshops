###############################################################################
#Script used during intro R workshop
#12/18/14
#written by: jwh
#Walks through a typical data analysis workflow in R with some of the NLA
#data
###############################################################################

###############################################################################
#Lesson 2: Exercise 2
#Get the data
###############################################################################
wq_url<-"http://water.epa.gov/type/lakes/assessmonitor/lakessurvey/upload/NLA2007_WaterQuality_20091123.csv"
site_url<-"http://water.epa.gov/type/lakes/assessmonitor/lakessurvey/upload/NLA2007_SampledLakeInformation_20091113.csv"
nla_wq<-read.csv(wq_url)
nla_sites<-read.csv(site_url)
str(nla_wq)
str(nla_sites)

###############################################################################
#Lesson 3: Exercise 1
#Subset the data
###############################################################################
nla_sites_subset<-subset(nla_sites,select=c(SITE_ID, LON_DD, LAT_DD, STATE_NAME, 
																						WSA_ECO9, NUT_REG, NUTREG_NAME, 
																						LAKE_ORIGIN, RT_NLA))
nla_wq_subset<-subset(nla_wq,select=c(SITE_ID, VISIT_NO, SITE_TYPE, TURB, NTL, 
																			PTL, CHLA, SECMEAN))
nla_wq_subset<-subset(subset(nla_wq_subset,subset=VISIT_NO==1),
											subset=SITE_TYPE=="REF_Lake")

###############################################################################
#Lesson 3: Exercise 2
#Merging data
###############################################################################
nla_data<-merge(nla_wq_subset,nla_sites_subset,by="SITE_ID",all.x=TRUE)

###############################################################################
#Lesson 3: Exercise 3
#Reshape and Modify data
###############################################################################
