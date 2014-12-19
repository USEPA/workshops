
## ----setup, echo=FALSE, warning=FALSE------------------------------------
options(repos="http://cran.rstudio.com/")


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


## ----useful_functions_workspace------------------------------------------
#List all objects in current workspace
ls() 
ls(pattern="a")

#Remove an object
rm(x)

#Save your workspace
#Saves the whole thing to a file called lesson2.RData
save.image("lesson2.RData") 
#Saves just the a and y objects to a file called lesson2_ay.RData
save(a,y,file="lesson2_ay.RData")


## ----useful_functions_directory------------------------------------------
#See the current directory
getwd()

#Create a directory
dir.create("temp")

#Change the directory
setwd("temp")

#List files and directories
list.files()
list.files("..")
list.dirs("..")


## ----data_type_functions, eval=FALSE-------------------------------------
## typeof()  # what is it?
## length()  # how long is it? What about two dimensional objects?
## attributes()  # does it have any metadata?


## ------------------------------------------------------------------------
1/0
# [1] Inf
1/Inf
# [1] 0


## ------------------------------------------------------------------------
0/0
NaN.


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


## ----create_data_frame---------------------------------------------------
numbers <- 1:26
letters <- letters #this is a special object available from base R
logical <- c(rep(TRUE,13),rep(FALSE,13))
examp_df <- data.frame(numbers,letters,logical)


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


## ----factor_examples-----------------------------------------------------
#An unorderd factor
yn <- factor(c("yes", "no", "no", "yes", "yes"))
yn

#An ordered factor
lmh <- factor (c("high","high","low","medium","low","medium","high"),levels=c("low","medium","high"),ordered=TRUE )


## ----list_examples-------------------------------------------------------
examp_list<-list(letters=c("x","y","z"),animals=c("cat","dog","bird","fish"),numbers=1:100,df=examp_df)
examp_list


## ----read_csv_examp------------------------------------------------------
#Grab data from the web
web_df <- read.csv("http://jwhollister.com/public/files/example.csv")
head(web_df)
str(web_df)
dim(web_df)
summary(web_df)


## ----gdata_examp---------------------------------------------------------
#Make sure gdata is installed
install.packages("gdata")
#Load up gdata
library("gdata")
#Get an example Excel file read into R
download.file("http://jwhollister.com/public/files/example.xlsx", "example.xlsx")
first_sheet<-read.xls("example.xlsx",sheet=1)
second_sheet<-read.xls("example.xlsx",sheet=2)
#Did it work?
first_sheet
second_sheet


