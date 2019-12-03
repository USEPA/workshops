#Do you want to build an RScript?
#We're going to write this thing together as a class. Don't worry though, I have an answer sheet for when I forget things!
#When working through this, 1 line space is to make reading easier. 3 empty lines are where you insert your code/answers

#First thing first, find the "OracleExport_BasicChem.xlsx" document and load it into R as object "basechem"



#What is that dataset? It's the format our data at KDHE comes in from an Oracle query and these include samples from the Stream Probabilistic (SP) monitoring program, Stream Chemistry (SC) monitoring program, and Lake Monitoring (LM) program
#Take a look at what you've got using View(), summary(), str(), and head()



#It's got some eccentricities to it, but note the repeated parameter name columns with an 'R' appended to the end. These are qualifiers and how you know if the sample was a non-detect or above detection limit. It'll come into play in a little bit
#Let's do a quick bit of clean-up to make our lives easier.
#HUC8 is missing for most of the observations, Basin is missing for everything, COL_DATEX is redundant, and COL_TIME won't be needed for our purposes today.



#Another option was not downloading those columns from the query to make the dataset, but this is good practice and hindsight is 20/20. Also, time of day plays a role in dissolved oxygen and pH so needing it for those isn't beyond the pale.
#Pick a parameter, any parameter!
#Try hist(), qqnorm(), boxplot(), and stem() for some quick exploratory data analysis (EDA) and easy visualizations.



#hist() is a quick distribution comparison
#qqnorm() is pretty good for looking at the tails of a distribution as well and for several of the parameters the tails deviate strongly suggesting extreme values in the dataset
#boxplot() shows the outliers really quickly. Check ?boxplot() to get an idea of all the extra bells and whistles we skipped though
#stem() is a good way of noting not every visual pops up in the Plots window and there's always another way of doing the same thing in R and coding in general

#We should have a decent feel for the dataset now. Let's manipulate it to our needs:
#Remember the qualifier fields ending in the 'R'? They've come home to roost.
#We'll take it easy and just assume there are only below detection level values and take the '>' for what they are.
#The below detection limit values are a problem and confound environmental data everywhere you go and there is no perfect answer to them. Basically, we came to an unknown, tried to measure it, and despite eliminating some of the unknown potential still have an unknown.
#For now, we'll handle the basic default answers everybody applies to below detection limit values. However, we'll touch on some tools/answers more grounded in statistical backing at the end when we're more comfortable with the dataset and coding with it.

#Option 1: remove the below detection limit values
#Try subsetting to filter out those values using:
rmchem<- basechem[basechem$ALKALINTYR!="<", ]
#Now look at the Environment window to the top right. It just shaved off a thousand observations!
#You can use View() to explore that the "<" really did get removed from the dataset, but why is this a bad thing the way it was done? Check mean(basechem$DISOXY, na.rm=T) against mean(rmchem$DISOXY, na.rm=T)



#Just because it was below detection for the Alkalinity doesn't mean all of the other parameters were too. We just lost 1,000+ observations for a whole slew of parameters!!!
#Better solution starts with a reset (assign the object basechem to rmchem):
  
  
  
#We correctly referenced the rows that were '<' but removed them instead of nulling the values.
#The hint then is to reference those values on the left side of the arrow and assign their new value on the right side of the arrow.
#Start by referencing which values you want to replace with an NA that are currently listed as the reporting limits. Then reference a corresponding value (qualifier) it matches with to make the condition of when to change things. Finish with the assignment arrow and the value to assign to these referenced values:
  
  
  
#Hint part 2: We're doing a comparison of if the ALKALINTYR=="<" then do something, but what happens   when we compare to an NA?
#Try 'NA>5' to see:
  
  
  
#Use the & operator for multiple comparisons here and !is.na() to check for your NA's:
  
  
  
#How to check it worked: Look at the Environment of the objects in RStudio. Did the number of observations change?
#Try View(), summary(), str(), and head() again and look for where things differ and if it did what you wanted it to.

#That was messy to figure out, but here's where coding is really friendly to changes: you don't have to do that again and you can use that code every time you get new data and it will work every time. You don't have to figure out that formatting each time the dataset gets new data, in other words.

#Option 2: Halve the values
#This is a really common approach to be taken. Helsel has many things to say about this, but we'll start with the basics/foundation and work our way up from there.
#Reset rmchem to be equal to basechem again:



#Halve the Alk values where AlkR is '<': (hint, it'll look identical to above for the left side of the '<-')



#Use the same tools as before (View(), summary(), etc.) to check it worked:



#Let's say we're done with adjusting the Alk values, remove the AlkR column:



#Here's where coding comes into play/usefulness again. We just manipulated the alkalinity values as we wanted. How about the chloride, dissolved oxygen, pH, sodium, specific conductivity, temperature (celsius), and total suspended solids?
#It's as easy as copy, paste, replace. Ctrl+c the code for Alkalinity, ctrl+v it 7 times below that line, select the lines you want to edit (hold down cursor and drag), press ctrl+f and replace the 'ALKALINTYR' with 'CHLORIDER' (and so on) for each parameter's qualifier.



#You're done, that's it*.
#*However, pH is pretty much always going to be within measurement, or certainly going to need to account for the '>' as well, and temperature should always be within bounds too. Go ahead and remove the lines of code changing those values.



#Run it all and check the results:



#Remove the qualifer ('R') columns:



#One last housekeeping item: Column Names
#How to reference them: colnames(rmchem)
#Change them to Program, SiteName, SiteID, County, Location, Date, Alk, Cl, DO, pH, Na, SpecCond, Celsius, TSS, and Turb:



#We now have a finished dataset to work with*
#How about some exploratory data analysis?
#summary() and str() are classic go-tos. Run those and then the next one I have below (it'll take a minute and can read the summary() and str() results while waiting:
  
  
  
#Try pairs(rmchem[7:15]). Don't worry about it taking a minute, it has 29,953 observations times 9 parameters to plot.



#There are a lot of potential avenues to explore with this dataset. Let's start with the classics: standard violation?
#Kansas' chloride surface water quality standard for drinking water use is 250 mg/L...but which ones have drinking water uses protected?
#Xenia Lake, Yates Center Reservoir, Warren Park Lake, Jetmore Lake, and Tuttle Creek Lake...also identified as LM074401, LM069201, LM062001, LM073901, and LM021001 are my example locations I dug up quickly
#Subset these site names to a dwstest object:



#Any violations?



#How about a plot to see if any of the sites are funny by comparison?
#Use ggplot and set color=SiteName and just a basic scatterplot of Cl against time:



#So now what? We only got a look at 5 lakes with the use protected.
#New dataset time! We need to assign uses to these site names or else we'll never be able to compare to criteria in a reasonable amount of time per location.
#Import the "RegisterGISforR.xlsx" spreadsheet and name it the 'lakereg' object:



#Check the str(). We're going to merge this object with the rmchem object, and for this to work we're going to need a column from one to match a column from the other (at least 1, can have more):



#Assign the columns the names SiteName, WBName, BA, Basin, HUC8, Type, Category, AL, CR, DS, FP, GR, IW, IR, LW:



#Try the merge() function and assign them to object 'testmerg'



#Try unique(testmerg$Program):



#It dropped the other samples that didn't have a lake name assigned to them. What if we wanted to keep those? Check the ?merge() help document and look at the all.x argument:
  
  
  
#Try it again with all.x=T:
  
  
  
#Did it work? Try a comparison using summary(obj1)==summary(obj2):
  
  
  

#It should work as intended now. However, it's a good reminder that not everything about coding is intuitive or as you first interpret it. Make sure you double check your assumptions, all of them, before committing to a path forward.

#Remove the testmerg and dwstest objects, and then name the merge of the rmchem and lakereg the 'chemreg' object:



#Subset that to a new object with just the DS=="X" values, named 'dwschem':



#Check for violations again using the max() function:



#That's a YUP
#How bad are we talking? use summary() and hist() for an idea:



#Which lakes have 1+ violation?



#How many is that?



#Is there a seasonal impact? Use the lubridate package with the month() function with hist() to see the spread:
  
  
  
#Not what you'd have expected? Me neither
  
  
  
#Hint: check the spread of all LM program Cl samples for frequency with hist():
  
  
  
#So we're looking at summer monitoring specifically here. Life makes sense again. However, this raises the question of what about the SC and SP programs too? Check those spreads of chloride measurements too:
  
  
  
#Bonus: If we don't have uses readily tied to SC and SP sites, check against the chronic aquatic life standard for chloride, 860 mg/L, by assuming all of the sites have aquatic life uses applied:
  
  
  
#Let's shift gears. How about some good old scatterplot linear regression comparisons?
#I'd expect the Cl and Na concentrations to be largely linear and shoot up in the winter. Let's test those assumptions.
#First, use ggplot2 to check linearity:



#That's an odd fishtail effect. Was that in the pairs chart too? (Check with the back arrow on the Plots window)

#Back to chemistry 101:
#1 mol of NaCl = 1 mol Na = 1 mol Cl
#Na is 22.990 g/mol and Cl is 35.45 g/mol
#22.990 g Na : 35.45 g Cl is our ratio
#Slope of line for a one to one of these with mg/L concentrations has us at:
#22.99/35.45 = 0.64852

#Let's separate the data into two different lines there where objects are nahigh and clsteady:
#One where Cl is less than 225 mg/L and Na is greater than 300 mg/L; the other where Cl is >225 mg/L
#*I visually estimated these values using geom_hline() and geom_vline()



#Check them out now with ggplot(clsteady, aes(Cl, Na)) + geom_point():



#How do we plot the line of best fit and find the slope?
#Two functions: ?geom_smooth() with method and se arguments; ?lm()



#We've got two things going on here. The clsteady data seems to be matching up to our mass ratio of 0.64852 with an estimated slope of 0.6353; however, the nahigh data is rocketing upwards at 2.237 instead. Explanations?
  
  
  
#My guess is geology, and we can start stabbing at that with a geography check:
#We now have the nahigh data and a column with county abbreviations (some NA's, but we'll work with what we've got)
#Try table(nahigh$County):



#If you Google those counties, you can see a geographic proclivity towards west-central Kansas. 
#We're still missing county data for most of the points we used for the linear model, but that's a dataset refinement for another day.

#I'm going to change gears on us one final time. The last big tool I'd like you all to see is looping plot production.
#A loop is what the name implies; going around in a circle.
#Imagine I want a plot for each and every single lake's data that has had a violation of the Cl criteria.
#This could take a looooong time to make.
#However, coding can do this for us.
#There are several things we'll need to set up, and these we'll do together:
#First, let's get a list of Site Names to work with

violakes<- chemreg[chemreg$DS=="X" & !is.na(chemreg$DS) & chemreg$Cl>250,]
violakes<- unique(violakes$SiteName, na.rm=T)
violakes<- violakes[!is.na(violakes)]
violakes

#Next, we're going to build a for() loop:
#For that, we need to define how many times it will run and where to initialize

howlong<-7
i<-1

#Next, we'll build the loop together:

howlong<-7
i<-1
for(i in 1:howlong){
  loopname<- violakes[i]
  loopname
  
  loopdata<- chemreg[chemreg$SiteName==loopname,]
  head(loopdata)
  
  print(     ggplot(loopdata, aes(x=Date, y=Cl)) + geom_point() +geom_hline(yintercept=250) + ggtitle(loopname) + scale_y_continuous(limits=c(0,NA))     )
}

#For now, pat yourselves on the back; we've made it to the end of this lecture!
