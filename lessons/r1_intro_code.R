################################################################################
# ./01_basics.R
################################################################################
## ----function_examples---------------------------------------------------
#Print
print("hello world!")
#A sequence
seq(1,10)
#Random normal numbers
rnorm(100,mean=10,sd=2)
#Mean
mean(rnorm(100))
#Sum
sum(rnorm(100))

# NOTES:
#Comments
#()
#[]
#{}

## ----install_package, eval=FALSE-----------------------------------------
## #Installing Packages from CRAN
## #Install dplyr and ggplot2
install.packages("ggplot2")
install.packages("dplyr")

## #You can also put more than one in like
install.packages(c("randomForest","formatR"))

## ----load_package--------------------------------------------------------
#Loading packages into your library
#Add libraries to your R Session
library("ggplot2")
library("dplyr")

#You can also access functions without loading by using package::function
randomForest::randomForest


## ----other_packages, eval=FALSE------------------------------------------
## #See what is installed
installed.packages()

## #What packages are available?
available.packages()

## #Update, may take a while if you have many packages installed
update.packages()

## ----operators_consoloe--------------------------------------------------
#A really powerful calculator!
1+1 #Add
10-4 #Subtract
3*2 #Multiply
3^3 #Exponents
100/10 #Divide
5%%2 #Modulus
5>2 #Greater than
4<5 #Less than
5<=5 #Less than or equal
8>=2 #Greater than or equal
2==2 #Equality: notice that it is TWO equal signs!
5!=7 #Not Equals

## ----assignment_operator-------------------------------------------------
#Numeric assignment
x<-5
x
y<-x+1
y
z<-x+y
z
#Character
a<-"Bob"
a
b<-"Sue"
b
a2<-"Larry"
a2

## ----useful_functions_workspace, eval=FALSE------------------------------
## #List all objects in current workspace
ls()
ls(pattern="a")

## #Remove an object
rm(x)

## #Save your workspace
## #Saves the whole thing to a file called lesson2.RData
save.image("lesson2.RData")
## #Saves just the a and y objects to a file called lesson2_ay.RData
save(a,y,file="lesson2_ay.RData")

## ----help_from_console, eval=FALSE---------------------------------------
## #Using the help command/shortcut
help("print") #Help on the print command
?print #Help on the print command using the `?` shortcut
help(package="dplyr") #Help on the package `dplyr`

## #Don't know the exact name or just part of it
apropos("print") #Returns all available functions with "print" in the name
??print #Shortcut, but also searches demos and vignettes in a formatted page


################################################################################
# ./02_data.R
################################################################################
## ----na_examples, eval=FALSE---------------------------------------------
na.omit()#na.omit - removes them
na.exclude()#similar to omit, but has different behavior with some functions.
is.na()#Will tell you if a value is NA

## ----use_c---------------------------------------------------------------
char_vector <- c("Joe","Bob","Sue")
num_vector <- c(1,6,99,-2)
logical_vector <- c(TRUE,FALSE,FALSE,TRUE,T,F)

## ----examine_vector------------------------------------------------------
#Print the vector
print(char_vector)
char_vector

#Examine the vector
typeof(char_vector)
length(logical_vector)
class(num_vector)
str(char_vector)

## ----add_to_vec----------------------------------------------------------
char_vector <- c(char_vector, "Jeff")
char_vector

## ----vector_shortcuts----------------------------------------------------
#Create a series
series <- 1:10
seq(10)
seq(1, 10, by = 0.1)

#Repeat values
fives<-rep(5,10)
fives
laugh<-rep("Ha", 100)
laugh

## ----vectorized_examp----------------------------------------------------
#A numeric example
x<-1:10
y<-10:1
z<-x+y
z

#another one, with different lengths
a<-1
b<-1:10
c<-a+b
c


#A character example with paste()
first<-c("Buggs","Elmer","Pepe", "Foghorn")
last<-c("Bunny", "Fudd","Le Pew", "Leghorn")
first_last<-paste(first, last)
first_last

## ----create_data_frame---------------------------------------------------
numbers <- c(1:26,NA)
letts <- c(NA,letters) #letters is a special object available from base R
logical <- c(rep(TRUE,13),NA,rep(FALSE,13))
examp_df <- data.frame(letts,numbers,logical)

## ----examine_data_frame--------------------------------------------------
#See the first 6 rows
head(examp_df)
#See the last 6 rows
tail(examp_df)
#See column names
names(examp_df)
#see row names
rownames(examp_df)
#Show structure of full data frame
str(examp_df)
#Show number of rows and colums
dim(examp_df)
nrow(examp_df)
ncol(examp_df)
#Get summary info
summary(examp_df)
#remove NA
na.omit(examp_df)

## ----readcsv-------------------------------------------------------------
#Grab data from a local file
nla_wq <- read.csv("../data/nla_dat.csv",stringsAsFactors = FALSE)
head(nla_wq)
str(nla_wq)
dim(nla_wq)
summary(nla_wq)

## ----access_colums-------------------------------------------------------
#What columuns do we have?
names(nla_wq)
#The site id column
nla_wq$SITE_ID
#The chlorophyll a column
nla_wq$CHLA

################################################################################
# ./03_viz.R
################################################################################
## ----plot_examp----------------------------------------------------------
plot(nla_wq$CHLA,nla_wq$NTL)

## ----plot_examp_2--------------------------------------------------------
plot(nla_wq$CHLA,nla_wq$NTL,main="NLA Nutrient and Chlorophyll",
     xlab="Chlorophyll a",ylab="Total Nitrogen")

## ----boxplot_examp-------------------------------------------------------
boxplot(nla_wq$CHLA)

## ----boxplot_grps_examp--------------------------------------------------
boxplot(nla_wq$CHLA ~ nla_wq$EPA_REG)
#Given the spread, maybe  a log transform makes sense
boxplot(log10(nla_wq$CHLA) ~ nla_wq$EPA_REG)

## ----base_hist_examp-----------------------------------------------------
hist(nla_wq$PTL)
#And log again specifying number of breaks (e.g. bins)
hist(log10(nla_wq$PTL), breaks=10)

## ----ggplot_install, eval=FALSE------------------------------------------
install.packages("ggplot2")
library("ggplot2")

## ----ggplot_examp--------------------------------------------------------
# aes() are the "aesthetics" info.  When you simply add the x and y
# that can seem a bit of a confusing term.  You also use aes() to 
# change color, shape, size etc. of some items 
nla_gg<-ggplot(nla_wq,aes(x=CHLA,y=NTL))

## ----points_examp--------------------------------------------------------
#Different syntax than you are used to
nla_gg + 
  geom_point()

#This too can be saved to an object
nla_scatter<-nla_gg +
                geom_point()

#Call it to create the plot
nla_scatter

## ----iris_labels---------------------------------------------------------
#Getting fancy to show italics and greek symbols
x_lab <- expression(paste("Chlorophyll ",italic(a), " (", mu, "g/L)"))
y_lab <- expression(paste("Total Nitrogen ", "(", mu, "g/L)"))
nla_scatter<-nla_scatter +
                labs(title="Nitrogen and Chlorophyll in US Lakes",
                     x=x_lab, y=y_lab)
nla_scatter

## ----iris_colors---------------------------------------------------------
nla_scatter<- nla_scatter +
                geom_point(aes(color=RT_NLA, shape=RT_NLA),size=2)
nla_scatter

## ----iris_loess----------------------------------------------------------
nla_scatter_loess<-nla_scatter +
                geom_smooth()
nla_scatter_loess

## ----iris_lm-------------------------------------------------------------
nla_scatter_lm<-nla_scatter +
                  geom_smooth(method="lm")
nla_scatter_lm

## ----iris_lm_groups------------------------------------------------------
nla_scatter_lm_group<-nla_scatter +
                        geom_smooth(method="lm", 
                                    aes(group=RT_NLA))
nla_scatter_lm_group

## ----iris_lm_color-------------------------------------------------------
nla_scatter_lm_color<-nla_scatter +
                        geom_smooth(method="lm", 
                                    aes(color=RT_NLA))
nla_scatter_lm_color

## ----gg_box_examp--------------------------------------------------------
ggplot(nla_wq,aes(x=EPA_REG,y=log10(CHLA))) +
  geom_boxplot()

## ----gg_hist_examp-------------------------------------------------------
ggplot(nla_wq,aes(x=log10(CHLA)))+
  geom_histogram(binwidth=0.25)

## ----themes_examp--------------------------------------------------------
scatter_p<-ggplot(nla_wq,aes(x=log10(PTL),y=log10(CHLA))) +
              geom_point(aes(colour=LAKE_ORIGIN, shape=LAKE_ORIGIN))
scatter_p

## ----themes_examp_custom-------------------------------------------------
scatter_p_base<-scatter_p + 
  theme(panel.background = element_blank(), 
        panel.grid = element_blank(),
        panel.border = element_rect(fill = NA),
        text=element_text(family="Times",colour="red",size=24))
scatter_p_base

## ----themes_examp_stock--------------------------------------------------
scatter_p + theme_bw()
scatter_p + theme_classic()

## ----themes_examp_polished-----------------------------------------------
#Now Let's start over, with some new colors and regression lines
x_lab <- expression(paste("Chlorophyll ",italic(a), " (", mu, "g/L)"))
y_lab <- expression(paste("Total Nitrogen ", "(", mu, "g/L)"))
scatter_polished <- ggplot(nla_wq,aes(x=log10(PTL),y=log10(CHLA))) +
              geom_point(aes(colour=RT_NLA, shape=RT_NLA)) +
              stat_smooth(method="lm", aes(colour=RT_NLA)) +
              scale_colour_manual(breaks = nla_wq$RT_NLA,
                                  values= c("steelblue1",
                                            "sienna",
                                            "springgreen3")) + 
              theme_classic(18,"Times") +
              theme(text=element_text(colour="slategray")) +
              labs(title="National \n Lake P and Chl a \n Relationship",
                     x=x_lab, y=y_lab)
              

scatter_polished 

## ----ggsave_examp, eval=FALSE--------------------------------------------
## #Save as jpg, with 600dpi, and set width and height
## #Many other options in the help
ggsave(plot=scatter_polished,
       file="Fig1.jpg",dpi=600,width=8, heigh=5)
## #Save as PDF
ggsave(plot=scatter_polished,
       file="Fig1.pdf")

## ----facet_grid_nla, warning=FALSE, message=FALSE------------------------
tp_chla <- ggplot(nla_wq,aes(x=log10(PTL),y=log10(CHLA))) + geom_point()

tp_chla + facet_grid(RT_NLA ~ .)

tp_chla +
  stat_smooth() +
  facet_grid(RT_NLA ~ LAKE_ORIGIN)

