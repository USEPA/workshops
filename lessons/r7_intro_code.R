################################################################################
# lessons/data_analysis_basics.R
################################################################################
## ----get_nla_data, message=FALSE, warning=FALSE--------------------------
# URL for 2007 NLA water quality data
nla_wq_url <- "https://www.epa.gov/sites/production/files/2014-10/nla2007_chemical_conditionestimates_20091123.csv"

nla_secchi_url <- "https://www.epa.gov/sites/production/files/2014-10/nla2007_secchi_20091008.csv"

# Read into an R data.frame with read.csv
nla_wq <- read.csv(nla_wq_url, stringsAsFactors = FALSE)
nla_secchi <- read.csv(nla_secchi_url, stringsAsFactor = FALSE)

## ----clean_nla_data, message=FALSE, warning=FALSE------------------------
#Load dplyr into current session
library(dplyr)

#Clean up NLA Water quality
nla_wq_cln <- nla_wq %>%
  filter(VISIT_NO == 1,
         SITE_TYPE == "PROB_Lake") %>%
  select(SITE_ID,ST,EPA_REG,RT_NLA,LAKE_ORIGIN,PTL,NTL,TURB,CHLA)

#Clean up NLA Secchi
nla_secchi_cln <- nla_secchi %>%
  filter(VISIT_NO == 1) %>%
  select(SITE_ID, SECMEAN)

#Join the two together based on SITE_ID and the finally filter out NA's
nla <- left_join(x = nla_wq_cln, y = nla_secchi_cln, by = "SITE_ID") %>%
  filter(complete.cases(NTL,PTL,TURB,CHLA,SECMEAN))
tbl_df(nla)

## ----summary, message=FALSE, warning=FALSE-------------------------------
#Get a summary of the data frame
summary(nla)

## ----individual_stats, message=FALSE, warning=FALSE----------------------
#Stats for Total Nitrogen
mean(nla$NTL)
median(nla$NTL)
min(nla$NTL)
max(nla$NTL)
sd(nla$NTL)
IQR(nla$NTL)
range(nla$NTL)

## ----na_rm, message=FALSE, warning=FALSE---------------------------------
#An example with NA's
x <- c(37,22,NA,41,19)
mean(x) #Returns NA
mean(x, na.rm = TRUE) #Returns mean of 37, 22, 41, and 19

## ----table, message=FALSE, warning=FALSE---------------------------------
#The table() funciton is usefule for returning counts
table(nla$LAKE_ORIGIN)

## ----table2, message=FALSE, warning=FALSE--------------------------------
x <- c(1,1,0,0,1,1,0,0,1,0,1,1)
y <- c(1,1,0,0,1,0,1,0,1,0,0,0)
xy_tab <- table(x,y)
xy_tab
prop.table(xy_tab)

## ----grouping, message=FALSE, warning=FALSE------------------------------
orig_stats_ntl <- nla %>%
  group_by(LAKE_ORIGIN) %>%
  summarize(mean_ntl = mean(NTL),
            median_ntl = median(NTL),
            sd_ntl = sd(NTL))
orig_stats_ntl

## ----tableit, results="asis"---------------------------------------------
knitr::kable(orig_stats_ntl)

## ----histogram_density, message=FALSE, warning=FALSE---------------------
#A single histogram using base
hist(nla$NTL)
#Log transform it
hist(log1p(nla$NTL)) #log1p adds one to deal with zeros
#Density plot
plot(density(log1p(nla$NTL)))

## ----boxplots, message=FALSE, warning=FALSE------------------------------
#Simple boxplots
boxplot(nla$CHLA)
boxplot(log1p(nla$CHLA))

#Boxplots per group
boxplot(log1p(nla$CHLA)~nla$EPA_REG)

## ----scatterplots, message=FALSE, warning=FALSE--------------------------
#A single scatterplot
plot(log1p(nla$PTL),log1p(nla$CHLA))
#A matrix of scatterplot
plot(log1p(nla[,6:10]))

## ----fancy_density, message=FALSE, warning=FALSE-------------------------
#Getting super fancy with tidyr, plotly, and ggplot2 to visualize all variables
library(tidyr)
library(ggplot2)
library(plotly)
nla_gather <- gather(nla,parameter,value,6:10)
dens_gg <-ggplot(nla_gather,aes(x=log1p(value))) +
  geom_density() +
  facet_wrap("parameter") +
  labs(x="log1p of measured value")
#ggplotly(dens_gg)
dens_gg

## ----fancy_matrix, message=FALSE, warning=FALSE--------------------------
ggplot(nla, aes(x=log1p(PTL),y=log1p(NTL))) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap("EPA_REG")

## ----t-test, message=FALSE, warning=FALSE--------------------------------
#Long Format - original format for LAKE_ORIGIN and SECMEAN
t.test(nla$SECMEAN ~ nla$LAKE_ORIGIN)

#Wide Format - need to do some work to get there - tidyr is handy!
wide_nla <- spread(nla,LAKE_ORIGIN,SECMEAN)
names(wide_nla)[9:10]<-c("man_made", "natural")
t.test(wide_nla$man_made, wide_nla$natural)

## ----simple_anova, message=FALSE, warning=FALSE--------------------------
# A quick visual of this:
boxplot(log1p(nla$CHLA)~nla$RT_NLA)

# One way analysis of variance
nla_anova <- aov(log1p(CHLA)~RT_NLA, data=nla)
nla_anova #Terms
summary(nla_anova) #The table
anova(nla_anova) #The table with a bit more

## ----cor, message=FALSE, warning=FALSE-----------------------------------
#For a pair
cor(log1p(nla$PTL),log1p(nla$NTL))
#For a correlation matrix
cor(log1p(nla[,6:10]))
#Spearman Rank Correlations
cor(log1p(nla[,6:10]),method = "spearman")

## ----cor_test, message=FALSE,warning=FALSE-------------------------------
cor.test(log1p(nla$PTL),log1p(nla$NTL))

## ------------------------------------------------------------------------
# The simplest case
chla_tp <- lm(log1p(CHLA) ~ log1p(PTL), data=nla) #Creates the model
summary(chla_tp) #Basic Summary
names(chla_tp) #The bits
chla_tp$coefficients #My preference
coef(chla_tp) #Same thing, but from a function
head(resid(chla_tp)) # The resdiuals

## ----multiple, warning=FALSE, message=FALSE------------------------------
chla_tp_tn_turb <- lm(log1p(CHLA) ~ log1p(PTL) + log1p(NTL) + log1p(TURB), data = nla)
summary(chla_tp_tn_turb)

################################################################################
# lessons/data_in_r.R
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
#Grab data from a web file
nla_url <- "https://usepa.github.io/region1_r/nla_dat.csv"
nla_wq <- read.csv(nla_url,stringsAsFactors = FALSE)
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
# lessons/data_manipulation.R
################################################################################
## ----indexing_examp------------------------------------------------------
#Create a vector
x<-c(10:19)
x
#Positive indexing returns just the value in the ith place
x[7]
#Negative indexing returns all values except the value in the ith place
x[-3]
#Ranges work too
x[8:10]
#A vector can be used to index
#Can be numeric
x[c(2,6,10)]
#Can be boolean - will repeat the pattern 
x[c(TRUE,FALSE)]
#Can even get fancy
x[x%%2==0]

## ----list_index----------------------------------------------------------
x_list <- list(1:10,letters[1:10])
x_list
#Get the first item of the list
x_list[[1]]
#Or the second item
x_list[[2]]
#And now the letter "g"
x_list[[2]][7]

## ----data_frame_index----------------------------------------------------
#Let's use one of the stock data frames in R, iris
head(iris)
#And grab a specific value
iris[1,1]
#A whole column
petal_len<-iris[,3]
petal_len
#A row
obs15<-iris[15,]
obs15
#Many rows
obs3to7<-iris[3:7,]
obs3to7

## ----more_data_frame_index-----------------------------------------------
#First, there are a couple of ways to use the column names
iris$Petal.Length
head(iris["Petal.Length"])
#Multiple colums
head(iris[c("Petal.Length","Species")])
#Now we can combine what we have seen to do some more complex queries
#Lets get all the data for Species with a petal length greater than 6
big_iris<-iris[iris$Petal.Length>=6,]
head(big_iris)
#Or maybe we want just the sepal widths of the virginica species
virginica_iris<-iris$Sepal.Width[iris$Species=="virginica"]
head(virginica_iris)

## ----setup_dplyr,eval=FALSE----------------------------------------------
install.packages("dplyr")
library("dplyr")

## ----more_data_frame_dplyr-----------------------------------------------
#First, select some columns
dplyr_sel<-select(iris,Sepal.Length,Petal.Length,Species)
#That's it.  Select one or many columns
#Now select some, like before
dplyr_big_iris<-filter(iris, Petal.Length>=6)
head(dplyr_big_iris)
#Or maybe we want just the virginica species
virginica_iris<-filter(iris,Species=="virginica")
head(virginica_iris)

## ----combine_commands----------------------------------------------------
#Intermediate data frames
#Select First: note the order of the output, neat too!
dplyr_big_iris_tmp1<-select(iris,Species,Sepal.Length,Petal.Length)
dplyr_big_iris_tmp<-filter(dplyr_big_iris_tmp1,Petal.Length>=6)
head(dplyr_big_iris_tmp)

#Nested function
dplyr_big_iris_nest<-filter(select(iris,Species,Sepal.Length,Petal.Length),Species=="virginica")
head(dplyr_big_iris_nest)

#Pipes
dplyr_big_iris_pipe<-select(iris,Species,Sepal.Length,Petal.Length) %>%
  filter(Species=="virginica")
head(dplyr_big_iris_pipe)

## ----aggregate_examp-----------------------------------------------------
#Chained with Pipes
group_by(iris,Species)%>%
  summarize(mean(Sepal.Length),
            mean(Sepal.Width),
            mean(Petal.Length),
            mean(Petal.Width))

## ----arrange_example-----------------------------------------------------
#dplyr provides its own object type, tbl that has lots of nice properties
mtcars_tbl <- as.tbl(mtcars)
#ascending order is default
arrange(mtcars_tbl,mpg)
#descending
arrange(mtcars_tbl,desc(mpg))
#multiple columns: most cyl with best mpg at top
arrange(mtcars_tbl,desc(cyl),desc(mpg))

## ----slice_example-------------------------------------------------------
#grab rows 3 through 10
slice(mtcars_tbl,3:10)

## ----mutate_example------------------------------------------------------
mutate(mtcars_tbl,kml=mpg*0.425)

## ----rowwise_examp-------------------------------------------------------
#First a dataset of temperatures, recorded weekly at 100 sites.
temp_df<-data.frame(id=1:100,week1=runif(100,20,25), week2=runif(100,19,24), 
                    week3=runif(100,18,26), week4=runif(100,17,23))
head(temp_df)
#To add row means to the dataset, without the ID
temp_df2<-temp_df %>% 
  rowwise() %>% 
  mutate(site_mean = mean(c(week1,week2,week3,week4)))
head(temp_df2)

################################################################################
# lessons/data_viz.R
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

################################################################################
# lessons/r_basics.R
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
install.packages(c("quickmapr","formatR"))

## ----load_package--------------------------------------------------------
#Loading packages into your library
#Add libraries to your R Session
library("ggplot2")
library("dplyr")

#You can also access functions without loading by using package::function
dplyr::mutate


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


