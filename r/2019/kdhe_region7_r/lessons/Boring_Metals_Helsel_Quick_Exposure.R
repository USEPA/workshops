#Let's take a swan dive at the handling of non-detects we mostly glanced over the theory of earlier.
#The original request was for me to get into Helsel's approaches and running non-parametric analysis.
#We're going to do a blow-through to get a quick exposure of what's available to us and see how easy it is to use for these methods.
#By NO MEANS, whatshoever, should this be considered in-depth, complete, and how it should be done. I'm not much of one for statistics, but I can code:
library(readxl)
metals <- read_excel("R:/TMDL/Dane Backup/R_Class_Dec2019/MetalsHelselQuick.xlsx", col_types = c("text", "date", "numeric", "text", "numeric", "text", "text"))

summary(metals)
str(metals)

#Format should look familiar, but simpler perhaps? I've included a T/F qualifier for easier conversion in R in addition to limiting which sites we're comparing to one on the Kansas River and one on the Ark:

metals$CADMIUMR<- as.logical(metals$CADMIUMR)
metals$COPPERR<- as.logical(metals$COPPERR)
metals$River<- as.factor(metals$River) #It'll be necessary for Helsel's material
colnames(metals)<- c("Site","Date","Cd","CdR","Cu","CuR","River")


#I'll split them into two datasets now, one for each metal. I do this, to simplify working with NAs

cddat<- metals[,c(1:4,7)]
cddat<- cddat[complete.cases(cddat), ] #remove NAs
str(cddat)

cudat<- metals[,c(1:2,5:7)]
cudat<- cudat[complete.cases(cudat), ] #remove NAs
str(cudat)

#We're going to start with Cu and end with Cd
#Let's make some poor assumptions:

hist(cudat$Cu)
qqnorm(cudat$Cu)

#Looks normal enough* (*this is false, but just showing options here)
#Is there a difference between the two rivers?

boxplot(Cu~River, data=cudat)
t.test( cudat$Cu[cudat$River=="Kansas"], cudat$Cu[cudat$River=="Arkansas"])

#boxplot shows not so much but the t.test seems convinced. However, we didn't meet the required assumptions underlying the t.test, particularly normally distributed data. Also, we just took the detection limit values at face value, which could definitely skew these values high.
#What if I zeroed the detection limit values?

cuexamp<- cudat
cuexamp$Cu[cuexamp$CuR==T] <- 0
boxplot(Cu~River, data=cuexamp)
boxplot(Cu~River, data=cudat)

#So there's some wiggle room. Handling detection limits concerns with the non-normality means we now move on to:
#Non-parametric analysis:

wilcox.test(cudat$Cu[cudat$River=="Kansas"], cudat$Cu[cudat$River=="Arkansas"])
wilcox.test(Cu~River, data=cudat) #Same thing, but skipped having to write a bunch of code

kruskal.test(Cu~River, data=cudat)

#This is just to show what's out there. Notice all of the arguments available for these basic ones, and know there's probably a package out there that can run a specific kind of test for you if you want more in-depth.


#That touches on the first approach for handling censored data by Helsel. The other approach is Maximum Likelihood Estimate (MLE)
#Luckily, Helse wrote a package on that:

library(NADA)
#For the extra curious https://cran.r-project.org/web/packages/NADA/NADA.pdf

#A couple of useful functions right off the bat:

censtats(cudat$Cu, cudat$CuR)
cenreg(cudat$Cu, cudat$CuR, cudat$River)

#What about looking at the censtats for each river?
#You'll have to use your coding knowledge
censtats(cudat$Cu[cudat$River=="Kansas"], cudat$CuR[cudat$River=="Kansas"])
censtats(cudat$Cu[cudat$River=="Arkansas"], cudat$CuR[cudat$River=="Arkansas"])
#Or try censummary() for a little bit of overlap
censummary(cudat$Cu, cudat$CuR, cudat$River)



#Let's try some more visual options and get our eyes off the code:

cenboxplot(cudat$Cu, cudat$CuR, cudat$River)
#Highest censoring threshold is the horizontal line automatically added for us

cenxyplot(metals$Cu, metals$CuR, metals$Cd, metals$CdR)
#draws a scatter plot with censored values represented by dashed lines spanning from the censored threshold to zero

#What if you want to see the code used to develop this function?
getAnywhere(cenxyplot)

ros(cudat$Cu, cudat$CuR)
plot(ros(cudat$Cu, cudat$CuR))
plot(ros(cudat$Cu, cudat$CuR), plot.censored=T)



#Regression for MLE left-censored Data?
cenmle(cudat$Cu, cudat$CuR, cudat$River)
plot(cenmle(cudat$Cu, cudat$CuR, cudat$River))


#Did I include the cadmium data just for a comparison in one plot to the copper data?
#Nope! There's guidance on when to use censoring of data for comparisons in Helsel's literature, but I wanted an actual example of what to expect from a dataset with a lot of them:
length(cudat$CuR)
length(cudat$CuR[cudat$CuR==T])
length(cddat$CdR)
length(cddat$CdR[cddat$CdR==T])

#So approximately 1/40 of the copper data is below detection limit whereas the cadmium has 39/42 of it as such
#Normal (and parametric) stats fail us:
t.test(Cd~River, data=cddat)
wilcox.test(Cd~River, data=cddat)
kruskal.test(Cd~River, data=cddat)

#What about the NADA Helsel package?

cendiff(cddat$Cd, cddat$CdR, cddat$River)
#We still don't see a difference, but at least this method takes into account the non-detects in a non-arbitrary manner backed by statistics

cenboxplot(cddat$Cd, cddat$CdR, cddat$River) #For the visual comparison
ros(cddat$Cd, cddat$CdR) #Good warning message built-in to the function
plot(ros(cddat$Cd, cddat$CdR)) #Warning again
plot(ros(cddat$Cd, cddat$CdR), plot.censored=T) #Warning again
censummary(cddat$Cd, cddat$CdR, cddat$River) #Worth a peruse



#That's as far as I got into studying Helsel before this course. Hopefully, this got some exposure to a better method than just halving your non-detects or other arbitrary methodology.