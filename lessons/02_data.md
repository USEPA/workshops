

# Working With Data in R

In this lesson we are going to focus on data and how it is dealt with by R.  This will include a discussion of the basic data types and data structures.  Lastly we will cover how to get data that lives in other files into R.  We will work through examples using base R. I will demo other ways of getting data into R with some additional packages

## Lesson Outline:

- [Data types and data structures in R](#data-types-and-data-structures-in-r)
- [Reading external data](#reading-external-data)
- [Other ways to read data](#other-ways-to-read-data)
- [Data wrangling/manipulating/jujitsu/munging](#data-manipulation)

## Lesson Exercises:

- [Exercise 2.1](#exercise-21)
- [Exercise 2.2](#exercise-22)

##Data types and data structures in R
*Borrowed liberally from Jenny Bryan's [course materials on r](http://www.stat.ubc.ca/~jenny/STAT545A/quick-index.html) and Karthik Ram's [material from the Canberra Software Carpentry R Bootcamp](https://github.com/swcarpentry/2013-10-09-canberra).  Anything good is because of Jenny and Karthik.  Mistakes are all mine.*

Remember that everything in R is an object.  With regards to data, those objects have some specific characteristics that help R (and us) know what kind of data we are dealing with and what kind of operations can be done on that data.  This stuff may be a bit dry, but a basic understanding will help as so much of what we do with analysis has to do with the organization and type of data we have. First, lets discuss the atomic data types.

###Data types

There are 6 basic atomic classes: character, numeric (real or decimal), integer, logical, complex, and raw.

| Example 				 | Type 		 |
| :--------------- | --------: |
| "a", "swc" 			 | character |
| 2, 15.5 				 | numeric 	 | 
| 2L 							 | integer 	 |
| `TRUE`, `FALSE`  | logical 	 |
| 1+4i 						 | complex 	 |
| 62 6f 62         | raw			 |

In this workshop we will deal almost exclusively with three (and these are, in my experience, by far the most common): character, numeric, and logical.  

### NA, Inf, and NaN
There are values that you will run across on ocassion that aren't really data types but are important to know about.  

`NA` is R's value for missing data.  You will see this often and need to figure out how to deal with them in your analysis.  A few built in functions are useful for dealing with `NA`.  


```r
na.omit()#na.omit - removes them
na.exclude()#similar to omit, but has different behavior with some functions.
is.na()#Will tell you if a value is NA
```

`Inf` is infinity. You can have positive or negative infinity and `NaN` means "not a number."  It's an undefined value.

###Data structures
The next set of information relates to the many data structures in R.  

The data structures in base R include:

- vector
- list
- matrix
- data frame
- factors
- tables

Our efforts will focus on vectors, and data frames.  We will discuss just  We will leave it to your curiousity to explore the basics of lists, factors, matrix, and table data structures.

### Vectors
A vector is the most common and basic data structure in `R` and is pretty much the workhorse of R. 

A vector can be a vector of characters, logical, integers or numeric and all values in the vector must be of the same data type.  Specifically, these are known as atomic vectors.

There are many ways to create vectors, but we will focus on one, `c()`, which is a very common way to create a vector from a set of values.  `c()` combines a set of arguments into a single vector.  For instance,


```r
char_vector <- c("Joe","Bob","Sue")
num_vector <- c(1,6,99,-2)
logical_vector <- c(TRUE,FALSE,FALSE,TRUE,T,F)
```

Now that we have these we can use some functions to examine the vectors. 


```r
#Print the vector
print(char_vector)
```

```
## [1] "Joe" "Bob" "Sue"
```

```r
char_vector
```

```
## [1] "Joe" "Bob" "Sue"
```

```r
#Examine the vector
typeof(char_vector)
```

```
## [1] "character"
```

```r
length(logical_vector)
```

```
## [1] 6
```

```r
class(num_vector)
```

```
## [1] "numeric"
```

```r
str(char_vector)
```

```
##  chr [1:3] "Joe" "Bob" "Sue"
```

We can also add to existing vectors using `c()`.


```r
char_vector <- c(char_vector, "Jeff")
char_vector
```

```
## [1] "Joe"  "Bob"  "Sue"  "Jeff"
```

There are some ways to speed up entry of values.


```r
#Create a series
series <- 1:10
seq(10)
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

```r
seq(1, 10, by = 0.1)
```

```
##  [1]  1.0  1.1  1.2  1.3  1.4  1.5  1.6  1.7  1.8  1.9  2.0  2.1  2.2  2.3
## [15]  2.4  2.5  2.6  2.7  2.8  2.9  3.0  3.1  3.2  3.3  3.4  3.5  3.6  3.7
## [29]  3.8  3.9  4.0  4.1  4.2  4.3  4.4  4.5  4.6  4.7  4.8  4.9  5.0  5.1
## [43]  5.2  5.3  5.4  5.5  5.6  5.7  5.8  5.9  6.0  6.1  6.2  6.3  6.4  6.5
## [57]  6.6  6.7  6.8  6.9  7.0  7.1  7.2  7.3  7.4  7.5  7.6  7.7  7.8  7.9
## [71]  8.0  8.1  8.2  8.3  8.4  8.5  8.6  8.7  8.8  8.9  9.0  9.1  9.2  9.3
## [85]  9.4  9.5  9.6  9.7  9.8  9.9 10.0
```

```r
#Repeat values
fives<-rep(5,10)
fives
```

```
##  [1] 5 5 5 5 5 5 5 5 5 5
```

```r
laugh<-rep("Ha", 100)
laugh
```

```
##   [1] "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha"
##  [15] "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha"
##  [29] "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha"
##  [43] "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha"
##  [57] "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha"
##  [71] "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha"
##  [85] "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha" "Ha"
##  [99] "Ha" "Ha"
```

Lastly, R can operate directly on vectors.  This means we can use use our arithmetic functions on vectors and also many functions can deal with vectors directly.  The result of this is another vector, equal to the length of the longest one.  You will hear this referred to as "vectorized" operations.


```r
#A numeric example
x<-1:10
y<-10:1
z<-x+y
z
```

```
##  [1] 11 11 11 11 11 11 11 11 11 11
```

```r
#another one, with different lengths
a<-1
b<-1:10
c<-a+b
c
```

```
##  [1]  2  3  4  5  6  7  8  9 10 11
```

```r
#A character example with paste()
first<-c("Buggs","Elmer","Pepe", "Foghorn")
last<-c("Bunny", "Fudd","Le Pew", "Leghorn")
first_last<-paste(first, last)
first_last
```

```
## [1] "Buggs Bunny"     "Elmer Fudd"      "Pepe Le Pew"     "Foghorn Leghorn"
```

### Data frames

Data frames are the data structure you will most often use when doing data analysis.  They are the most spreadsheet like data structure in R, but unlike spreadsheets there are some rules that must be followed. This is a good thing!

Data frames are made up of rows and columns.  Each column is a vector and those vectors must be of the same length.  Essentially, anything that can be saved in a `.csv` file can be read in as a data frame.  Data frames have several attributes.  The ones you will interact with the most are column names, row names, dimension.  

So one way to create a data frame is from some vectors and the `data.frame()` command:


```r
numbers <- c(1:26,NA)
letts <- c(NA,letters) #letters is a special object available from base R
logical <- c(rep(TRUE,13),NA,rep(FALSE,13))
examp_df <- data.frame(letts,numbers,logical)
```

Now that we have this data frame we probably want to do something with it.  We can examine it in many ways.


```r
#See the first 6 rows
head(examp_df)
```

```
##   letts numbers logical
## 1  <NA>       1    TRUE
## 2     a       2    TRUE
## 3     b       3    TRUE
## 4     c       4    TRUE
## 5     d       5    TRUE
## 6     e       6    TRUE
```

```r
#See the last 6 rows
tail(examp_df)
```

```
##    letts numbers logical
## 22     u      22   FALSE
## 23     v      23   FALSE
## 24     w      24   FALSE
## 25     x      25   FALSE
## 26     y      26   FALSE
## 27     z      NA   FALSE
```

```r
#See column names
names(examp_df)
```

```
## [1] "letts"   "numbers" "logical"
```

```r
#see row names
rownames(examp_df)
```

```
##  [1] "1"  "2"  "3"  "4"  "5"  "6"  "7"  "8"  "9"  "10" "11" "12" "13" "14"
## [15] "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27"
```

```r
#Show structure of full data frame
str(examp_df)
```

```
## 'data.frame':	27 obs. of  3 variables:
##  $ letts  : Factor w/ 26 levels "a","b","c","d",..: NA 1 2 3 4 5 6 7 8 9 ...
##  $ numbers: int  1 2 3 4 5 6 7 8 9 10 ...
##  $ logical: logi  TRUE TRUE TRUE TRUE TRUE TRUE ...
```

```r
#Show number of rows and colums
dim(examp_df)
```

```
## [1] 27  3
```

```r
nrow(examp_df)
```

```
## [1] 27
```

```r
ncol(examp_df)
```

```
## [1] 3
```

```r
#Get summary info
summary(examp_df)
```

```
##      letts       numbers       logical       
##  a      : 1   Min.   : 1.00   Mode :logical  
##  b      : 1   1st Qu.: 7.25   FALSE:13       
##  c      : 1   Median :13.50   TRUE :13       
##  d      : 1   Mean   :13.50   NA's :1        
##  e      : 1   3rd Qu.:19.75                  
##  (Other):21   Max.   :26.00                  
##  NA's   : 1   NA's   :1
```

```r
#remove NA
na.omit(examp_df)
```

```
##    letts numbers logical
## 2      a       2    TRUE
## 3      b       3    TRUE
## 4      c       4    TRUE
## 5      d       5    TRUE
## 6      e       6    TRUE
## 7      f       7    TRUE
## 8      g       8    TRUE
## 9      h       9    TRUE
## 10     i      10    TRUE
## 11     j      11    TRUE
## 12     k      12    TRUE
## 13     l      13    TRUE
## 15     n      15   FALSE
## 16     o      16   FALSE
## 17     p      17   FALSE
## 18     q      18   FALSE
## 19     r      19   FALSE
## 20     s      20   FALSE
## 21     t      21   FALSE
## 22     u      22   FALSE
## 23     v      23   FALSE
## 24     w      24   FALSE
## 25     x      25   FALSE
## 26     y      26   FALSE
```

If you want to learn more about any of these data structure, [Hadley Wickham's Advanced R section on data structures](http://adv-r.had.co.nz/Data-structures.html) is really good.


##Exercise 2.1

For the first exercise of lesson 2, we are going to build a data frame from scratch.  

1.) If you are using a script to keep all of your code, make sure it is open and enter you code in there.

2.) Create three vectors.  One with numeric data, one with character, and a third with boolean data.  Each vector must contain 10 values.

3.) Combine these three vectors into a data frame (hint: `data.frame()`) that is stored in an object called `my_df`.

4.) Now from the console, explore `my_df` with some of the functions we talked about earlier (e.g., summary, str, head, etc.).

##Reading external data
Completely creating a data frame from scratch is useful (especially when you start writing your own functions), but more often than not data is stored in an external file that you need to read into R.  These may be delimited text files, spreadsheets, relational databases, SAS files ...  You get the idea.  Instead of treating this subject exhaustively, we will focus just on a single file type, `.csv` that is very commonly encountered and (usually) easy to create from other file types.  For this, we will use `read.csv()`(although there are many, compelling options from packages like `rio` and `readr`). 

`read.csv()` is a specialized version of `read.table()` that focuses on, big surprise here, .csv files. This command assumes a header row with column names and that the delimiter is a comma. The expected no data value is NA and by default, strings are converted to factors by default (this can trip people up).

Source files for `read.csv()` can either be on a local hard drive or, and this is pretty cool, on the web. We will be using the later for our examples and exercises. If you had a local file it would be accessed like `mydf <- read.csv("C:/path/to/local/file.csv")`. As an aside, paths and use of forward vs back slash is important. R is looking for forward slashes ("/"), or unix-like paths. You can use these in place of the back slash and be fine. You can use a back slash but it needs to be a double back slash ("\"). This is becuase the single backslash in an escape character that is used to indicate things like newlines or tabs. 
For today's workshop we will focus on grabbing data from a local file.  Follow [this link](https://raw.githubusercontent.com/USEPA/region1_r/master/data/nla_dat.csv?token=AFL8S5sdVQxShPQXn1fAivwXw8dCLi0Pks5XKkIwwA%3D%3D) to download the data to your machine. 

Let's give it a try.


```r
#Grab data from a local file
nla_wq <- read.csv("../data/nla_dat.csv",stringsAsFactors = FALSE)
head(nla_wq)
```

```
##         SITE_ID RT_NLA  EPA_REG WSA_ECO9 LAKE_ORIGIN PTL NTL  CHLA SECMEAN
## 1 NLA06608-0001    REF Region_8      WMT     NATURAL   6 151  0.24    6.40
## 2 NLA06608-0002  SO-SO Region_4      CPL    MAN-MADE  36 695  3.84    0.55
## 3 NLA06608-0003  TRASH Region_6      CPL     NATURAL  43 738 16.96    0.71
## 4 NLA06608-0004  SO-SO Region_8      WMT    MAN-MADE  18 344  4.60    1.80
## 5 NLA06608-0006    REF Region_1      NAP    MAN-MADE   7 184  4.08    3.21
## 6 NLA06608-0007    REF Region_5      UMW     NATURAL   8 493  2.43    3.15
```

```r
str(nla_wq)
```

```
## 'data.frame':	1086 obs. of  9 variables:
##  $ SITE_ID    : chr  "NLA06608-0001" "NLA06608-0002" "NLA06608-0003" "NLA06608-0004" ...
##  $ RT_NLA     : chr  "REF" "SO-SO" "TRASH" "SO-SO" ...
##  $ EPA_REG    : chr  "Region_8" "Region_4" "Region_6" "Region_8" ...
##  $ WSA_ECO9   : chr  "WMT" "CPL" "CPL" "WMT" ...
##  $ LAKE_ORIGIN: chr  "NATURAL" "MAN-MADE" "NATURAL" "MAN-MADE" ...
##  $ PTL        : int  6 36 43 18 7 8 66 10 159 28 ...
##  $ NTL        : int  151 695 738 344 184 493 801 473 1026 384 ...
##  $ CHLA       : num  0.24 3.84 16.96 4.6 4.08 ...
##  $ SECMEAN    : num  6.4 0.55 0.71 1.8 3.21 3.15 0.79 4.48 0.31 0.65 ...
```

```r
dim(nla_wq)
```

```
## [1] 1086    9
```

```r
summary(nla_wq)
```

```
##    SITE_ID             RT_NLA            EPA_REG         
##  Length:1086        Length:1086        Length:1086       
##  Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character  
##                                                          
##                                                          
##                                                          
##    WSA_ECO9         LAKE_ORIGIN             PTL               NTL         
##  Length:1086        Length:1086        Min.   :   1.00   Min.   :    5.0  
##  Class :character   Class :character   1st Qu.:  10.00   1st Qu.:  309.5  
##  Mode  :character   Mode  :character   Median :  25.50   Median :  575.0  
##                                        Mean   : 109.22   Mean   : 1175.8  
##                                        3rd Qu.:  89.75   3rd Qu.: 1172.0  
##                                        Max.   :4679.00   Max.   :26100.0  
##       CHLA           SECMEAN      
##  Min.   :  0.07   Min.   : 0.040  
##  1st Qu.:  2.98   1st Qu.: 0.650  
##  Median :  8.02   Median : 1.380  
##  Mean   : 29.38   Mean   : 2.195  
##  3rd Qu.: 26.08   3rd Qu.: 2.850  
##  Max.   :936.00   Max.   :36.710
```

##Other ways to read data
Although, `read.csv()` and `read.table()` are very flexible, they are not the only options for reading in data.  This could be a full day in and of itself, but packages like `readr`, `readxl`, and `rio` provide flexible methods for reading in data.  Also, databases can also be accessed directly in R and much of this functionality is in the `DBI` and `RODBC` packages.  Making the connections is not entirely trivial, but an easier way to take advantage of this is via the `dplyr` package.  See the [vignette on databases](https://cran.r-project.org/web/packages/dplyr/vignettes/databases.html) fo a lot of good examples of working with common open source databases.

##Data Manipulation
Lastly, a quick word on manipulating and cleaning datasets with R.  This is the step you will likely spend the most time on and thus, is a big topic.  For this workshop, unfortunately, we have very little time to spend on this.  The only bit of working with data frames that will be helpful is how to access the individual columns (which are vectors!).  There are a couple of ways to do this.  We will only use one.


```r
#What columuns do we have?
names(nla_wq)
```

```
## [1] "SITE_ID"     "RT_NLA"      "EPA_REG"     "WSA_ECO9"    "LAKE_ORIGIN"
## [6] "PTL"         "NTL"         "CHLA"        "SECMEAN"
```

```r
#The site id column
nla_wq$SITE_ID
```

```
##   [1] "NLA06608-0001" "NLA06608-0002" "NLA06608-0003" "NLA06608-0004"
##   [5] "NLA06608-0006" "NLA06608-0007" "NLA06608-0008" "NLA06608-0010"
##   [9] "NLA06608-0012" "NLA06608-0013" "NLA06608-0014" "NLA06608-0015"
##  [13] "NLA06608-0016" "NLA06608-0019" "NLA06608-0020" "NLA06608-0021"
##  [17] "NLA06608-0023" "NLA06608-0024" "NLA06608-0025" "NLA06608-0029"
##  [21] "NLA06608-0031" "NLA06608-0033" "NLA06608-0036" "NLA06608-0037"
##  [25] "NLA06608-0038" "NLA06608-0041" "NLA06608-0042" "NLA06608-0043"
##  [29] "NLA06608-0044" "NLA06608-0045" "NLA06608-0048" "NLA06608-0049"
##  [33] "NLA06608-0050" "NLA06608-0053" "NLA06608-0057" "NLA06608-0061"
##  [37] "NLA06608-0062" "NLA06608-0064" "NLA06608-0065" "NLA06608-0066"
##  [41] "NLA06608-0068" "NLA06608-0069" "NLA06608-0071" "NLA06608-0072"
##  [45] "NLA06608-0073" "NLA06608-0076" "NLA06608-0078" "NLA06608-0079"
##  [49] "NLA06608-0080" "NLA06608-0081" "NLA06608-0085" "NLA06608-0086"
##  [53] "NLA06608-0089" "NLA06608-0090" "NLA06608-0091" "NLA06608-0099"
##  [57] "NLA06608-0101" "NLA06608-0102" "NLA06608-0104" "NLA06608-0105"
##  [61] "NLA06608-0110" "NLA06608-0111" "NLA06608-0112" "NLA06608-0113"
##  [65] "NLA06608-0115" "NLA06608-0116" "NLA06608-0120" "NLA06608-0124"
##  [69] "NLA06608-0126" "NLA06608-0127" "NLA06608-0128" "NLA06608-0129"
##  [73] "NLA06608-0130" "NLA06608-0132" "NLA06608-0134" "NLA06608-0137"
##  [77] "NLA06608-0139" "NLA06608-0140" "NLA06608-0141" "NLA06608-0142"
##  [81] "NLA06608-0144" "NLA06608-0148" "NLA06608-0149" "NLA06608-0150"
##  [85] "NLA06608-0152" "NLA06608-0153" "NLA06608-0155" "NLA06608-0158"
##  [89] "NLA06608-0161" "NLA06608-0162" "NLA06608-0167" "NLA06608-0168"
##  [93] "NLA06608-0169" "NLA06608-0173" "NLA06608-0174" "NLA06608-0175"
##  [97] "NLA06608-0176" "NLA06608-0177" "NLA06608-0179" "NLA06608-0180"
##  [ reached getOption("max.print") -- omitted 986 entries ]
```

```r
#The chlorophyll a column
nla_wq$CHLA
```

```
##   [1]   0.24   3.84  16.96   4.60   4.08   2.43  30.24   4.38   4.90  16.03
##  [11]   8.75  20.00  13.00   4.03  20.24   2.29   2.78  44.15   1.30 123.12
##  [21]   5.26   8.92   5.07   8.02   4.33   0.88   2.21   5.41 135.61  20.16
##  [31]  54.00   1.14   3.95   6.26 125.40   3.50   2.18  19.04   0.57   1.75
##  [41]   0.95   7.41 198.72  10.13   0.49  10.88  10.02   2.35  58.46   6.66
##  [51]   4.04  18.24  11.36   4.36 118.80   4.60   0.70   1.20  38.20   5.98
##  [61]   1.77   3.26  84.76   4.69   1.35   2.82   2.54  31.59 228.24   5.92
##  [71]   0.46   0.43  12.91   8.11   1.58   1.33  12.80  52.56 110.16   1.36
##  [81]  22.25   1.87   4.18   8.22   5.20  10.40  79.80   3.14  39.00   2.56
##  [91] 936.00  21.76   2.59  70.40   6.75  19.68  25.76   3.58  18.40  30.62
##  [ reached getOption("max.print") -- omitted 986 entries ]
```

##Exercise 2.2
From here on out I hope to have these exercises begin to build on each other. We may not do that 100%, but there should at least be a modicum of continuity. For this exercise we are going to grab some data, look at that data, and be able to describe some basic information about that dataset.  The data we are using is the 2007 National Lakes Assessment.

1. Let's focus on using a script for the rest of our exercises.  Create a new script in RStudio.  Name it "nla_analysis.R"
2. As you write the script, comment as you go. Remember comments are lines that begin with `#`.
3. Add a function to your script that creates a data frame named `nla_wq`.
4. Add commands to your script that will provides details on the structure (hint: `str`) of the newly created data frame
5. Get the mean value for the `CHLA` column. 
5. Run the script and make sure it doesn't throw any errors and you do in fact get a data frame.
6. Explore the data frame using some of the functions we covered (e.g. `head()`,`summary()`, or `str()`).  This part does not need to be included in the script. 
