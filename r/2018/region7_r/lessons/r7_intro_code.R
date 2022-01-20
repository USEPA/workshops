################################################################################
# ./data_aggregation.R
################################################################################
## ----tidyr_data----------------------------------------------------------
library(tidyr)
smiths

## ----gather--------------------------------------------------------------
smiths_long <- smiths %>%
  gather("variable","value",2:5) %>%
  arrange(subject)
smiths_long

## ----spread--------------------------------------------------------------
smiths_wide <- smiths_long %>%
  spread(variable,value)
smiths_wide

## ----aggregate_examp-----------------------------------------------------
#Chained with Pipes
iris %>%
  group_by(Species)%>%
  summarize(mean_sepal_length = mean(Sepal.Length),
            mean_sepal_width = mean(Sepal.Width),
            mean_petal_length = mean(Petal.Length),
            mean_petal_width = mean(Petal.Width))

## ----more_summarize------------------------------------------------------
mtcars %>%
  group_by(cyl) %>%
  summarize(mean_mpg = mean(mpg),
            sd_mpg = sd(mpg),
            samp_size = n())

################################################################################
# ./data_analysis_basics.R
################################################################################
## ----summary, message=FALSE, warning=FALSE-------------------------------
#Get a summary of the data frame
summary(nla_wq_subset)

## ----individual_stats, message=FALSE, warning=FALSE----------------------
#Stats for Total Nitrogen
mean(nla_wq_subset$NTL)
median(nla_wq_subset$NTL)
min(nla_wq_subset$NTL)
max(nla_wq_subset$NTL)
sd(nla_wq_subset$NTL)
IQR(nla_wq_subset$NTL)
range(nla_wq_subset$NTL)

## ----na_rm, message=FALSE, warning=FALSE---------------------------------
#An example with NA's
x <- c(37,22,NA,41,19)
mean(x) #Returns NA
mean(x, na.rm = TRUE) #Returns mean of 37, 22, 41, and 19

## ----table, message=FALSE, warning=FALSE---------------------------------
#The table() funciton is usefule for returning counts
table(nla_wq_subset$LAKE_ORIGIN)

## ----table2, message=FALSE, warning=FALSE--------------------------------
x <- c(1,1,0,0,1,1,0,0,1,0,1,1)
y <- c(1,1,0,0,1,0,1,0,1,0,0,0)
xy_tab <- table(x,y)
xy_tab
prop.table(xy_tab)

## ----grouping, message=FALSE, warning=FALSE------------------------------
orig_stats_ntl <- nla_wq_subset %>%
  group_by(LAKE_ORIGIN) %>%
  summarize(mean_ntl = mean(NTL),
            median_ntl = median(NTL),
            sd_ntl = sd(NTL))
orig_stats_ntl

## ----tableit, eval=FALSE-------------------------------------------------
knitr::kable(orig_stats_ntl)

## ----tableit3, results="asis", echo=FALSE--------------------------------
knitr::kable(orig_stats_ntl)

## ----histogram_density, message=FALSE, warning=FALSE---------------------
#A single histogram using base
hist(nla_wq_subset$NTL)
#Log transform it
hist(log1p(nla_wq_subset$NTL)) #log1p adds one to deal with zeros
#Density plot
plot(density(log1p(nla_wq_subset$NTL)))

## ----boxplots, message=FALSE, warning=FALSE------------------------------
#Simple boxplots
boxplot(nla_wq_subset$CHLA)
boxplot(log1p(nla_wq_subset$CHLA))

#Boxplots per group
boxplot(log1p(nla_wq_subset$CHLA)~nla_wq_subset$EPA_REG)

## ----scatterplots, message=FALSE, warning=FALSE--------------------------
#A single scatterplot
plot(log1p(nla_wq_subset$PTL),log1p(nla_wq_subset$CHLA))
#A matrix of scatterplot
plot(log1p(nla_wq_subset[,6:9]))

## ----fancy_density, message=FALSE, warning=FALSE-------------------------
#Getting super fancy with tidyr, plotly (commented out for md), and ggplot2 to visualize all variables
library(tidyr)
library(ggplot2)
library(plotly)
nla_gather <- gather(nla_wq_subset,parameter,value,6:9)
dens_gg <-ggplot(nla_gather,aes(x=log1p(value))) +
  geom_density() +
  facet_wrap("parameter") +
  labs(x="log1p of measured value")
ggplotly(dens_gg)
#dens_gg

## ----fancy_matrix, message=FALSE, warning=FALSE--------------------------
ggplot(nla_wq_subset, aes(x=log1p(PTL),y=log1p(NTL))) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap("EPA_REG")

## ----t-test, message=FALSE, warning=FALSE--------------------------------
#Long Format - original format for LAKE_ORIGIN and SECMEAN
t.test(nla_wq_subset$SECMEAN ~ nla_wq_subset$LAKE_ORIGIN)

#Wide Format - need to do some work to get there - tidyr is handy!
wide_nla <- spread(nla_wq_subset,LAKE_ORIGIN,SECMEAN)
names(wide_nla)[8:9]<-c("man_made", "natural")
t.test(wide_nla$man_made, wide_nla$natural)

## ----simple_anova, message=FALSE, warning=FALSE--------------------------
# A quick visual of this:
boxplot(log1p(nla_wq_subset$CHLA)~nla_wq_subset$RT_NLA)

# One way analysis of variance
nla_anova <- aov(log1p(CHLA)~RT_NLA, data=nla_wq_subset)
nla_anova #Terms
summary(nla_anova) #The table
anova(nla_anova) #The table with a bit more

## ----bonferonni----------------------------------------------------------
tukey_test <- TukeyHSD(nla_anova, ordered = TRUE, conf.level = 0.95)
tukey_test
summary(tukey_test)

## ----cor, message=FALSE, warning=FALSE-----------------------------------
#For a pair
cor(log1p(nla_wq_subset$PTL),log1p(nla_wq_subset$NTL))
#For a correlation matrix
cor(log1p(nla_wq_subset[,6:9]))
#Spearman Rank Correlations
cor(log1p(nla_wq_subset[,6:9]),method = "spearman")

## ----cor_test, message=FALSE,warning=FALSE-------------------------------
cor.test(log1p(nla_wq_subset$PTL),log1p(nla_wq_subset$NTL))

## ------------------------------------------------------------------------
# The simplest case
chla_tp <- lm(log1p(CHLA) ~ log1p(PTL), data=nla_wq_subset) #Creates the model
summary(chla_tp) #Basic Summary
names(chla_tp) #The bits
chla_tp$coefficients #My preference
coef(chla_tp) #Same thing, but from a function
head(resid(chla_tp)) # The resdiuals

## ----multiple, warning=FALSE, message=FALSE------------------------------
chla_tp_tn_turb <- lm(log1p(CHLA) ~ log1p(PTL) + log1p(NTL), data = nla_wq_subset)
summary(chla_tp_tn_turb)

## ----rf_install, eval=FALSE----------------------------------------------
install.packages("randomForest")
library("randomForest")
help(package="randomForest")

## ----rf_example----------------------------------------------------------
rf_x<-select(iris,Petal.Width, Petal.Length, Sepal.Width, Sepal.Length)
rf_y<-iris$Species
iris_rf<-randomForest(x=rf_x,y=rf_y)
iris_rf

## ----rf_form_examp-------------------------------------------------------
iris_rf2<-randomForest(Species~.,data=iris)
iris_rf2

## ----rf_plots------------------------------------------------------------
#Error vs num of trees
plot(iris_rf2)
#Variable Importance
varImpPlot(iris_rf2)

################################################################################
# ./data_in_r.R
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
nla_url <- "https://raw.githubusercontent.com/USEPA/region7_r/master/nla_dat.csv"
nla_wq <- read.csv(nla_url,stringsAsFactors = FALSE)
head(nla_wq)
str(nla_wq)
dim(nla_wq)
summary(nla_wq)

################################################################################
# ./data_manipulation.R
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

################################################################################
# ./data_viz.R
################################################################################
## ----plot_examp----------------------------------------------------------
plot(nla_wq_subset$CHLA,nla_wq_subset$NTL)

## ----plot_examp_2--------------------------------------------------------
plot(nla_wq_subset$CHLA,nla_wq_subset$NTL,main="NLA Nutrient and Chlorophyll",
     xlab="Chlorophyll a",ylab="Total Nitrogen")

## ----boxplot_examp-------------------------------------------------------
boxplot(nla_wq_subset$CHLA)

## ----boxplot_grps_examp--------------------------------------------------
boxplot(nla_wq_subset$CHLA ~ nla_wq_subset$EPA_REG)
#Given the spread, maybe  a log transform makes sense
boxplot(log10(nla_wq_subset$CHLA) ~ nla_wq_subset$EPA_REG)

## ----base_hist_examp-----------------------------------------------------
hist(nla_wq_subset$PTL)
#And log again specifying number of breaks (e.g. bins)
hist(log10(nla_wq_subset$PTL), breaks=10)

## ----ggplot_install, eval=FALSE------------------------------------------
install.packages("ggplot2")
library("ggplot2")

## ----ggplot_examp--------------------------------------------------------
# aes() are the "aesthetics" info.  When you simply add the x and y
# that can seem a bit of a confusing term.  You also use aes() to 
# change color, shape, size etc. of some items 
nla_gg <- ggplot(nla_wq_subset,aes(x=CHLA,y=NTL))

## ----points_examp--------------------------------------------------------
#Different syntax than you are used to
nla_gg + 
  geom_point()

#This too can be saved to an object
nla_scatter <- nla_gg +
                geom_point()

#Call it to show the plot
nla_scatter

## ----iris_labels---------------------------------------------------------
#Getting fancy to show italics and greek symbols
x_lab <- expression(paste("Chlorophyll ",italic(a), " (", mu, "g/L)"))
y_lab <- expression(paste("Total Nitrogen ", "(", mu, "g/L)"))
nla_scatter <- nla_scatter +
                labs(title="Nitrogen and Chlorophyll in US Lakes",
                     x=x_lab, y=y_lab)
nla_scatter

## ----iris_colors---------------------------------------------------------
nla_scatter <-  nla_scatter +
                geom_point(aes(color=RT_NLA, shape=RT_NLA),size=2)
nla_scatter

## ----iris_loess----------------------------------------------------------
nla_scatter_loess <- nla_scatter +
                geom_smooth(method = "loess")
nla_scatter_loess

## ----iris_lm-------------------------------------------------------------
nla_scatter_lm <- nla_scatter +
                  geom_smooth(method="lm")
nla_scatter_lm

## ----iris_lm_groups------------------------------------------------------
nla_scatter_lm_group <- nla_scatter +
                        geom_smooth(method="lm", 
                                    aes(group=RT_NLA))
nla_scatter_lm_group

## ----iris_lm_color-------------------------------------------------------
nla_scatter_lm_color <- nla_scatter +
                        geom_smooth(method="lm", 
                                    aes(color=RT_NLA))
nla_scatter_lm_color

## ----packages------------------------------------------------------------
library(dplyr) # For some basic data massaging
library(tidyr) # Also for some basic data massaging
library(ggplot2) # For the plots

## ----data----------------------------------------------------------------
tbl_df(nla_wq_subset)  

## ----barchart_data-------------------------------------------------------
nla_bar_mean <- nla_wq_subset %>%
  group_by(WSA_ECO9) %>%
  summarize(nitrogen = mean(log1p(NTL)),
            phosphorus = mean(log1p(PTL))) %>%
  gather("variable", "mean", 2:3)

nla_bar_se <- nla_wq_subset %>%
  group_by(WSA_ECO9) %>%
  summarize(nitrogen = sd(log1p(NTL))/sqrt(length(NTL)),
            phosphorus = sd(log1p(PTL))/sqrt(length(PTL))) %>%
  gather("variable", "std_error", 2:3)

## ----join----------------------------------------------------------------
nla_bar_data <- full_join(nla_bar_mean, nla_bar_se)
nla_bar_data

## ----barchart------------------------------------------------------------
nla_bar <- ggplot(nla_bar_data,aes(x = WSA_ECO9, y = mean, fill = variable)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  geom_errorbar(aes(ymin=mean-std_error, ymax=mean+std_error),
                  width=.2,                    # Width of the error bars
                  position=position_dodge(.9))

nla_bar

## ----reorder-------------------------------------------------------------
library(forcats)
# First create a character vector of levels in the proper order
eco9_ord <- nla_bar_data %>%
  filter(variable == "phosphorus") %>%
  arrange(desc(mean)) %>%
  .$WSA_ECO9

nla_bar_data <- nla_bar_data %>%
  mutate(desc_ecoregion = fct_relevel(factor(WSA_ECO9,eco9_ord)))

## ----barchart_order------------------------------------------------------
nla_bar <- ggplot(nla_bar_data,aes(x = desc_ecoregion, y = mean, fill = variable)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  geom_errorbar(aes(ymin=mean-std_error, ymax=mean+std_error),
                  width=.2,                    # Width of the error bars
                  position=position_dodge(.9))

nla_bar

## ----viridis-------------------------------------------------------------
library(viridis)
nla_bar <- nla_bar +
  scale_fill_viridis(discrete=TRUE)

nla_bar

## ----legend--------------------------------------------------------------
nla_bar <- nla_bar +
  guides(fill = guide_legend(title = "Nutrients"))

nla_bar

## ----themes1-------------------------------------------------------------
nla_bar <- nla_bar +
   labs(x = "Mean Concentration", y = "Ecoregions")+
   theme(text = element_text(family="serif"),
         panel.background = element_blank(), panel.grid = element_blank(), 
         panel.border = element_rect(fill = NA), 
         plot.title  = element_text(family="sans",size=12,face="bold",vjust=1.1),
         legend.position = c(0.85,0.85), legend.key = element_rect(fill = 'white'),
         legend.text = element_text(family="sans",size=15), 
         legend.title = element_text(family="sans",size=11),
         axis.title.x = element_text(family="sans",vjust = -0.5, size = 12),
         axis.title.y = element_text(family="sans",vjust = 1.5, size = 12),
         axis.text.x = element_text(family="sans",size = 11),
         axis.text.y = element_text(family="sans",size = 11))
nla_bar

## ----canned--------------------------------------------------------------
nla_bar + 
  theme_bw()

nla_bar +
  theme_classic()

nla_bar +
  theme_minimal()

## ----ggthemes------------------------------------------------------------
library(ggthemes)
nla_bar +
  theme_economist()

nla_bar + 
  theme_excel()

nla_bar + 
  theme_tufte()

nla_bar +
  theme_fivethirtyeight()

## ----ggsave, eval = TRUE-------------------------------------------------
ggsave(filename = "nla_bar_chart.jpg",
       plot = nla_bar,
       width = 8,
       height = 4,
       units = "in", 
       dpi = 300)

## ----autocrop, eval = TRUE-----------------------------------------------
library(magick)
nla_fig <- image_read("nla_bar_chart.jpg")
nla_fig <- image_trim(nla_fig)
image_write(nla_fig, "nla_bar_chart_trim.jpg" )

## ----barchart_data_ex, eval = FALSE--------------------------------------
## #Packages needed
library(dplyr)
library(tidyr)
library(ggplot2)
nla_chla_secc_mean <- nla_wq_subset %>%
  group_by(EPA_REG) %>%
  summarize(chla = mean(CHLA),
            secchi = mean(SECMEAN)) %>%
  gather("variable","mean",2:3)

nla_chla_secc_se <- nla_wq_subset %>%
  group_by(EPA_REG) %>%
  summarize(chla = sd(log1p(CHLA))/sqrt(length(CHLA)),
            secchi = sd(log1p(SECMEAN))/sqrt(length(SECMEAN))) %>%
  gather("variable","se",2:3)

nla_chla_secc_data <- full_join(nla_chla_secc_mean, nla_chla_secc_se)

## ----facet_grid_nla, warning=FALSE, message=FALSE------------------------
tp_chla <- ggplot(nla_wq_subset,aes(x=log10(PTL),y=log10(CHLA))) + geom_point()

tp_chla + facet_grid(RT_NLA ~ .)

tp_chla +
  stat_smooth() +
  facet_grid(RT_NLA ~ LAKE_ORIGIN)

## ----devtools_install, eval=FALSE----------------------------------------
library(devtools)
install_github("dgrtwo/gganimate")

################################################################################
# ./peoples_choice.R
################################################################################

################################################################################
# ./r_basics.R
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

## ----common--------------------------------------------------------------
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
## #When you know the name of a function
help("print") #Help on the print command
?print #Help on the print command using the `?` shortcut

## #When you know the name of the package
help(package="dplyr") #Help on the package `dplyr`

## #Don't know the exact name or just part of it
apropos("print") #Returns all available functions with "print" in the name
??print #Shortcut, but also searches demos and vignettes in a formatted page

