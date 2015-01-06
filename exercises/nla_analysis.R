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
											subset=SITE_TYPE=="PROB_Lake")

###############################################################################
#Lesson 3: Exercise 2
#Merging data
###############################################################################
nla_data<-merge(nla_wq_subset,nla_sites_subset,by="SITE_ID",all.x=TRUE)

###############################################################################
#Lesson 3: Exercise 3
#Reshape and Modify data
###############################################################################
origin_mean_wq<-aggregate(nla_data[,4:8],list(nla_data$LAKE_ORIGIN),function(x)
  mean(x,na.rm=TRUE))
ecoregion_mean_wq<-aggregate(nla_data[,4:8],list(nla_data$WSA_ECO9),function(x)
  mean(x,na.rm=TRUE))
nla_mean_wq<-apply(nla_data[,4:8],2,function(x)
  mean(x,na.rm=TRUE))

###############################################################################
#Lesson 4: Exercise 1
#Subset with dplyr
###############################################################################
library(dplyr)
nla_sites_subset_dplyr <- select(nla_sites, SITE_ID, LON_DD, LAT_DD, STATE_NAME, 
                                 WSA_ECO9, NUT_REG, NUTREG_NAME, LAKE_ORIGIN, 
                                 RT_NLA)

nla_wq_subset_dplyr <- select(nla_wq, SITE_ID, VISIT_NO, SITE_TYPE, TURB, NTL, 
                              PTL, CHLA, SECMEAN) %>%
                        filter(VISIT_NO==1 & SITE_TYPE == "PROB_Lake")


###############################################################################
#Lesson 4: Exercise 2
#Summarize data with dplyr
###############################################################################

origin_mean_wq_dplyr <- group_by(nla_data, LAKE_ORIGIN) %>%
                          summarize(mean(TURB), mean(NTL), mean(PTL), mean(CHLA), 
                                    mean(SECMEAN, na.rm=TRUE))

ecoregion_mean_wq_dplyr <- group_by(nla_data, WSA_ECO9) %>%
                          summarize(mean(TURB), mean(NTL), mean(PTL), mean(CHLA), 
                                    mean(SECMEAN, na.rm=TRUE))

nla_mean_wq_dplyr <- summarize(nla_data, mean(TURB), mean(NTL), mean(PTL), mean(CHLA), 
                               mean(SECMEAN, na.rm=TRUE))

###############################################################################
#Lesson 5: Exercise 1
#Summary stats
#Not elegant, but perhaps more clear.  Lots of repeat. 
###############################################################################
turb_summ<-c(quantile(nla_data$TURB,na.rm=T),mean=mean(nla_data$TURB,na.rm=T),
             iqr=IQR(nla_data$TURB,na.rm=T))
ntl_summ<-c(quantile(nla_data$NTL,na.rm=T),mean=mean(nla_data$NTL,na.rm=T),
            iqr=IQR(nla_data$NTL,na.rm=T))
ptl_summ<-c(quantile(nla_data$PTL,na.rm=T),mean=mean(nla_data$PTL,na.rm=T),
            iqr=IQR(nla_data$PTL,na.rm=T))
chla_summ<-c(quantile(nla_data$CHLA,na.rm=T),mean=mean(nla_data$CHLA,na.rm=T),
             iqr=IQR(nla_data$CHLA,na.rm=T))
secmean_summ<-c(quantile(nla_data$SECMEAN,na.rm=T),mean=mean(nla_data$SECMEAN,na.rm=T),
                iqr=IQR(nla_data$SECMEAN,na.rm=T))
nla_wq_summary_base<-data.frame(TURB=turb_summ,NTL=ntl_summ,PTL=ptl_summ,
                                CHLA=chla_summ,SECMEAN=secmean_summ)


###############################################################################
#Lesson 5: Exercise 2
#Basic Exploratory Visualization
###############################################################################
#Pipes are not just for dplyr anymore!
select(nla_data,TURB,NTL,PTL,CHLA,SECMEAN)%>%
  plot()
#More fanciness
with(nla_data,boxplot(CHLA~RT_NLA))
with(nla_data,boxplot(log10(CHLA)~RT_NLA))

###############################################################################
#Lesson 6: Exercise 1
#Basic Stats
###############################################################################
#T-tests - mean difference of man-made vs natural lakes
turb_ttest <- with(nla_data,t.test(TURB~LAKE_ORIGIN))
ntl_ttest <- with(nla_data,t.test(NTL~LAKE_ORIGIN))
ptl_ttest <- with(nla_data,t.test(PTL~LAKE_ORIGIN))
chla_ttest <- with(nla_data,t.test(CHLA~LAKE_ORIGIN))
secmean_ttest <- with(nla_data,t.test(SECMEAN~LAKE_ORIGIN))
turb_ttest
ntl_ttest
ptl_ttest
chla_ttest
secmean_ttest
#Predict Chlorophyll a with lm - based on classic models
chla_lm<-lm(log10(CHLA)~log10(NTL)+log10(PTL),data=nla_data)
summary(chla_lm)

###############################################################################
#Lesson 7: Exercise 1
#Random Forest
###############################################################################
#clean up dataframe
nla_data_rf<-select(nla_data,RT_NLA,TURB,NTL,PTL,CHLA,SECMEAN)
nla_ref_rf<-randomForest(RT_NLA~.,data=nla_data_rf,na.action=na.omit)
nla_ref_rf
plot(nla_ref_rf)
varImpPlot(nla_ref_rf)

###############################################################################
#Lesson 8: Exercise 1
#ggplot2
###############################################################################
#scatterplot
ggplot(nla_data,aes(x=log10(PTL),y=log10(NTL)))+geom_point()
#boxplot
ggplot(nla_data,aes(x=RT_NLA,y=log10(CHLA)))+geom_boxplot()
#histogram
ggplot(nla_data,aes(x=log10(NTL)))+geom_histogram()
#barplot
mn_chla_data<-group_by(nla_data,WSA_ECO9)%>%
  summarize(mn_chla=mean(CHLA,na.rm=TRUE))
ggplot(mn_chla_data,aes(x=WSA_ECO9,y=mn_chla))+geom_bar(stat="identity")
#tp-chla scatter
ggplot(nla_data,aes(x=log10(PTL),y=log10(CHLA))) + 
  geom_point(aes(colour=LAKE_ORIGIN)) + 
  stat_smooth(method="lm",aes(colour=LAKE_ORIGIN))


###############################################################################
#Lesson 8: Exercise 2
#ggplot2 Themes
###############################################################################
#install.packages("wesanderson")
library("wesanderson")

nla_ptl_chla<-ggplot(nla_data,aes(x=log10(PTL),y=log10(CHLA))) + 
  geom_point(aes(colour=LAKE_ORIGIN), size=5) + 
  stat_smooth(method="lm",aes(colour=LAKE_ORIGIN)) + 
  theme_bw(20,"Arial") +
  labs(title="Total Phosphorus and Chlorophyll a",
      x="Log Total Phosphorus",
      y=expression(paste('Log Chlorophyll ', italic("a")))) +
  theme(text=element_text(colour="slategray")) +
  scale_colour_manual(breaks = nla_data$LAKE_ORIGIN,
                      values= wes.palette(2,"Moonrise1"))
nla_ptl_chla
ggsave(plot = nla_ptl_chla,
       file = "Fig_tp_chla.jpg", dpi=300, width=8, height=5)

###############################################################################
#Lesson 9: Exercise 1
#Functions and control structures
###############################################################################
#1
mean_sd<-function(vec,type=c("mean","sd"),...){
  type<-match.arg(type)
  if(type=="mean"){
    return(mean(vec, ...))
  } 
  if(type=="sd"){
    return(sd(vec,...))
  }
}

mean_sd(1:10)
mean_sd(rnorm(10),"sd")
mean_sd(c(5,6,7,5,6,7,5,6,7),"mean")
mean_sd(1,"bob")

#2
plot_nla<-function(x,y,grp,out=NULL){
  my_p<-ggplot(data.frame(x,y,grp),aes(x=x,y=y)) +
    geom_point(aes(color=grp, shape=grp),size=5) +
    geom_smooth(method="lm",aes(colour=grp))+
    labs(x=substitute(x),y=substitute(y))
  if(!is.null(out){
    ggsave(my_p,file=file)
  }
  return(my_p)
}
