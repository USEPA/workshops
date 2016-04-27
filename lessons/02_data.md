

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
##    [1] "NLA06608-0001"         "NLA06608-0002"        
##    [3] "NLA06608-0003"         "NLA06608-0004"        
##    [5] "NLA06608-0006"         "NLA06608-0007"        
##    [7] "NLA06608-0008"         "NLA06608-0010"        
##    [9] "NLA06608-0012"         "NLA06608-0013"        
##   [11] "NLA06608-0014"         "NLA06608-0015"        
##   [13] "NLA06608-0016"         "NLA06608-0019"        
##   [15] "NLA06608-0020"         "NLA06608-0021"        
##   [17] "NLA06608-0023"         "NLA06608-0024"        
##   [19] "NLA06608-0025"         "NLA06608-0029"        
##   [21] "NLA06608-0031"         "NLA06608-0033"        
##   [23] "NLA06608-0036"         "NLA06608-0037"        
##   [25] "NLA06608-0038"         "NLA06608-0041"        
##   [27] "NLA06608-0042"         "NLA06608-0043"        
##   [29] "NLA06608-0044"         "NLA06608-0045"        
##   [31] "NLA06608-0048"         "NLA06608-0049"        
##   [33] "NLA06608-0050"         "NLA06608-0053"        
##   [35] "NLA06608-0057"         "NLA06608-0061"        
##   [37] "NLA06608-0062"         "NLA06608-0064"        
##   [39] "NLA06608-0065"         "NLA06608-0066"        
##   [41] "NLA06608-0068"         "NLA06608-0069"        
##   [43] "NLA06608-0071"         "NLA06608-0072"        
##   [45] "NLA06608-0073"         "NLA06608-0076"        
##   [47] "NLA06608-0078"         "NLA06608-0079"        
##   [49] "NLA06608-0080"         "NLA06608-0081"        
##   [51] "NLA06608-0085"         "NLA06608-0086"        
##   [53] "NLA06608-0089"         "NLA06608-0090"        
##   [55] "NLA06608-0091"         "NLA06608-0099"        
##   [57] "NLA06608-0101"         "NLA06608-0102"        
##   [59] "NLA06608-0104"         "NLA06608-0105"        
##   [61] "NLA06608-0110"         "NLA06608-0111"        
##   [63] "NLA06608-0112"         "NLA06608-0113"        
##   [65] "NLA06608-0115"         "NLA06608-0116"        
##   [67] "NLA06608-0120"         "NLA06608-0124"        
##   [69] "NLA06608-0126"         "NLA06608-0127"        
##   [71] "NLA06608-0128"         "NLA06608-0129"        
##   [73] "NLA06608-0130"         "NLA06608-0132"        
##   [75] "NLA06608-0134"         "NLA06608-0137"        
##   [77] "NLA06608-0139"         "NLA06608-0140"        
##   [79] "NLA06608-0141"         "NLA06608-0142"        
##   [81] "NLA06608-0144"         "NLA06608-0148"        
##   [83] "NLA06608-0149"         "NLA06608-0150"        
##   [85] "NLA06608-0152"         "NLA06608-0153"        
##   [87] "NLA06608-0155"         "NLA06608-0158"        
##   [89] "NLA06608-0161"         "NLA06608-0162"        
##   [91] "NLA06608-0167"         "NLA06608-0168"        
##   [93] "NLA06608-0169"         "NLA06608-0173"        
##   [95] "NLA06608-0174"         "NLA06608-0175"        
##   [97] "NLA06608-0176"         "NLA06608-0177"        
##   [99] "NLA06608-0179"         "NLA06608-0180"        
##  [101] "NLA06608-0181"         "NLA06608-0183"        
##  [103] "NLA06608-0184"         "NLA06608-0189"        
##  [105] "NLA06608-0190"         "NLA06608-0191"        
##  [107] "NLA06608-0195"         "NLA06608-0196"        
##  [109] "NLA06608-0198"         "NLA06608-0201"        
##  [111] "NLA06608-0203"         "NLA06608-0204"        
##  [113] "NLA06608-0207"         "NLA06608-0208"        
##  [115] "NLA06608-0209"         "NLA06608-0212"        
##  [117] "NLA06608-0215"         "NLA06608-0216"        
##  [119] "NLA06608-0217"         "NLA06608-0219"        
##  [121] "NLA06608-0220"         "NLA06608-0221"        
##  [123] "NLA06608-0222"         "NLA06608-0223"        
##  [125] "NLA06608-0224"         "NLA06608-0225"        
##  [127] "NLA06608-0226"         "NLA06608-0228"        
##  [129] "NLA06608-0229"         "NLA06608-0234"        
##  [131] "NLA06608-0235"         "NLA06608-0238"        
##  [133] "NLA06608-0239"         "NLA06608-0240"        
##  [135] "NLA06608-0241"         "NLA06608-0242"        
##  [137] "NLA06608-0243"         "NLA06608-0244"        
##  [139] "NLA06608-0245"         "NLA06608-0247"        
##  [141] "NLA06608-0253"         "NLA06608-0254"        
##  [143] "NLA06608-0255"         "NLA06608-0257"        
##  [145] "NLA06608-0259"         "NLA06608-0260"        
##  [147] "NLA06608-0268"         "NLA06608-0271"        
##  [149] "NLA06608-0275"         "NLA06608-0276"        
##  [151] "NLA06608-0277"         "NLA06608-0279"        
##  [153] "NLA06608-0280"         "NLA06608-0281"        
##  [155] "NLA06608-0283"         "NLA06608-0284"        
##  [157] "NLA06608-0285"         "NLA06608-0286"        
##  [159] "NLA06608-0290"         "NLA06608-0291"        
##  [161] "NLA06608-0293"         "NLA06608-0294"        
##  [163] "NLA06608-0295"         "NLA06608-0297"        
##  [165] "NLA06608-0299"         "NLA06608-0302"        
##  [167] "NLA06608-0303"         "NLA06608-0306"        
##  [169] "NLA06608-0312"         "NLA06608-0313"        
##  [171] "NLA06608-0318"         "NLA06608-0319"        
##  [173] "NLA06608-0324"         "NLA06608-0325"        
##  [175] "NLA06608-0326"         "NLA06608-0327"        
##  [177] "NLA06608-0328"         "NLA06608-0330"        
##  [179] "NLA06608-0332"         "NLA06608-0333"        
##  [181] "NLA06608-0334"         "NLA06608-0337"        
##  [183] "NLA06608-0339"         "NLA06608-0340"        
##  [185] "NLA06608-0341"         "NLA06608-0343"        
##  [187] "NLA06608-0344"         "NLA06608-0345"        
##  [189] "NLA06608-0350"         "NLA06608-0356"        
##  [191] "NLA06608-0357"         "NLA06608-0358"        
##  [193] "NLA06608-0359"         "NLA06608-0361"        
##  [195] "NLA06608-0363"         "NLA06608-0366"        
##  [197] "NLA06608-0367"         "NLA06608-0369"        
##  [199] "NLA06608-0372"         "NLA06608-0373"        
##  [201] "NLA06608-0376"         "NLA06608-0377"        
##  [203] "NLA06608-0378"         "NLA06608-0386"        
##  [205] "NLA06608-0388"         "NLA06608-0393"        
##  [207] "NLA06608-0395"         "NLA06608-0399"        
##  [209] "NLA06608-0401"         "NLA06608-0402"        
##  [211] "NLA06608-0403"         "NLA06608-0405"        
##  [213] "NLA06608-0407"         "NLA06608-0408"        
##  [215] "NLA06608-0413"         "NLA06608-0414"        
##  [217] "NLA06608-0421"         "NLA06608-0425"        
##  [219] "NLA06608-0426"         "NLA06608-0432"        
##  [221] "NLA06608-0433"         "NLA06608-0435"        
##  [223] "NLA06608-0436"         "NLA06608-0439"        
##  [225] "NLA06608-0440"         "NLA06608-0442"        
##  [227] "NLA06608-0445"         "NLA06608-0447"        
##  [229] "NLA06608-0449"         "NLA06608-0452"        
##  [231] "NLA06608-0453"         "NLA06608-0456"        
##  [233] "NLA06608-0458"         "NLA06608-0459"        
##  [235] "NLA06608-0463"         "NLA06608-0467"        
##  [237] "NLA06608-0468"         "NLA06608-0469"        
##  [239] "NLA06608-0470"         "NLA06608-0471"        
##  [241] "NLA06608-0472"         "NLA06608-0473"        
##  [243] "NLA06608-0479"         "NLA06608-0480"        
##  [245] "NLA06608-0483"         "NLA06608-0484"        
##  [247] "NLA06608-0488"         "NLA06608-0489"        
##  [249] "NLA06608-0493"         "NLA06608-0494"        
##  [251] "NLA06608-0495"         "NLA06608-0497"        
##  [253] "NLA06608-0498"         "NLA06608-0500"        
##  [255] "NLA06608-0501"         "NLA06608-0502"        
##  [257] "NLA06608-0503"         "NLA06608-0508"        
##  [259] "NLA06608-0509"         "NLA06608-0510"        
##  [261] "NLA06608-0511"         "NLA06608-0512"        
##  [263] "NLA06608-0514"         "NLA06608-0515"        
##  [265] "NLA06608-0523"         "NLA06608-0526"        
##  [267] "NLA06608-0528"         "NLA06608-0529"        
##  [269] "NLA06608-0530"         "NLA06608-0531"        
##  [271] "NLA06608-0533"         "NLA06608-0537"        
##  [273] "NLA06608-0540"         "NLA06608-0541"        
##  [275] "NLA06608-0546"         "NLA06608-0547"        
##  [277] "NLA06608-0550"         "NLA06608-0551"        
##  [279] "NLA06608-0555"         "NLA06608-0558"        
##  [281] "NLA06608-0560"         "NLA06608-0561"        
##  [283] "NLA06608-0562"         "NLA06608-0564"        
##  [285] "NLA06608-0565"         "NLA06608-0569"        
##  [287] "NLA06608-0570"         "NLA06608-0579"        
##  [289] "NLA06608-0580"         "NLA06608-0581"        
##  [291] "NLA06608-0582"         "NLA06608-0583"        
##  [293] "NLA06608-0585"         "NLA06608-0587"        
##  [295] "NLA06608-0588"         "NLA06608-0591"        
##  [297] "NLA06608-0593"         "NLA06608-0594"        
##  [299] "NLA06608-0595"         "NLA06608-0596"        
##  [301] "NLA06608-0597"         "NLA06608-0599"        
##  [303] "NLA06608-0606"         "NLA06608-0608"        
##  [305] "NLA06608-0609"         "NLA06608-0610"        
##  [307] "NLA06608-0611"         "NLA06608-0614"        
##  [309] "NLA06608-0617"         "NLA06608-0618"        
##  [311] "NLA06608-0619"         "NLA06608-0622"        
##  [313] "NLA06608-0623"         "NLA06608-0624"        
##  [315] "NLA06608-0625"         "NLA06608-0627"        
##  [317] "NLA06608-0628"         "NLA06608-0630"        
##  [319] "NLA06608-0632"         "NLA06608-0634"        
##  [321] "NLA06608-0635"         "NLA06608-0637"        
##  [323] "NLA06608-0641"         "NLA06608-0648"        
##  [325] "NLA06608-0649"         "NLA06608-0650"        
##  [327] "NLA06608-0651"         "NLA06608-0654"        
##  [329] "NLA06608-0657"         "NLA06608-0658"        
##  [331] "NLA06608-0659"         "NLA06608-0660"        
##  [333] "NLA06608-0661"         "NLA06608-0662"        
##  [335] "NLA06608-0663"         "NLA06608-0665"        
##  [337] "NLA06608-0672"         "NLA06608-0677"        
##  [339] "NLA06608-0679"         "NLA06608-0681"        
##  [341] "NLA06608-0687"         "NLA06608-0690"        
##  [343] "NLA06608-0692"         "NLA06608-0696"        
##  [345] "NLA06608-0707"         "NLA06608-0709"        
##  [347] "NLA06608-0710"         "NLA06608-0711"        
##  [349] "NLA06608-0712"         "NLA06608-0713"        
##  [351] "NLA06608-0715"         "NLA06608-0717"        
##  [353] "NLA06608-0718"         "NLA06608-0720"        
##  [355] "NLA06608-0721"         "NLA06608-0723"        
##  [357] "NLA06608-0724"         "NLA06608-0726"        
##  [359] "NLA06608-0727"         "NLA06608-0731"        
##  [361] "NLA06608-0733"         "NLA06608-0734"        
##  [363] "NLA06608-0738"         "NLA06608-0743"        
##  [365] "NLA06608-0744"         "NLA06608-0749"        
##  [367] "NLA06608-0751"         "NLA06608-0753"        
##  [369] "NLA06608-0754"         "NLA06608-0755"        
##  [371] "NLA06608-0756"         "NLA06608-0759"        
##  [373] "NLA06608-0761"         "NLA06608-0762"        
##  [375] "NLA06608-0764"         "NLA06608-0765"        
##  [377] "NLA06608-0766"         "NLA06608-0769"        
##  [379] "NLA06608-0770"         "NLA06608-0771"        
##  [381] "NLA06608-0775"         "NLA06608-0779"        
##  [383] "NLA06608-0781"         "NLA06608-0782"        
##  [385] "NLA06608-0783"         "NLA06608-0785"        
##  [387] "NLA06608-0792"         "NLA06608-0793"        
##  [389] "NLA06608-0794"         "NLA06608-0797"        
##  [391] "NLA06608-0802"         "NLA06608-0804"        
##  [393] "NLA06608-0805"         "NLA06608-0806"        
##  [395] "NLA06608-0807"         "NLA06608-0808"        
##  [397] "NLA06608-0809"         "NLA06608-0811"        
##  [399] "NLA06608-0812"         "NLA06608-0815"        
##  [401] "NLA06608-0820"         "NLA06608-0823"        
##  [403] "NLA06608-0824"         "NLA06608-0825"        
##  [405] "NLA06608-0827"         "NLA06608-0828"        
##  [407] "NLA06608-0830"         "NLA06608-0831"        
##  [409] "NLA06608-0834"         "NLA06608-0836"        
##  [411] "NLA06608-0837"         "NLA06608-0842"        
##  [413] "NLA06608-0843"         "NLA06608-0846"        
##  [415] "NLA06608-0847"         "NLA06608-0849"        
##  [417] "NLA06608-0850"         "NLA06608-0851"        
##  [419] "NLA06608-0856"         "NLA06608-0857"        
##  [421] "NLA06608-0859"         "NLA06608-0860"        
##  [423] "NLA06608-0862"         "NLA06608-0863"        
##  [425] "NLA06608-0864"         "NLA06608-0865"        
##  [427] "NLA06608-0868"         "NLA06608-0869"        
##  [429] "NLA06608-0870"         "NLA06608-0871"        
##  [431] "NLA06608-0872"         "NLA06608-0873"        
##  [433] "NLA06608-0874"         "NLA06608-0875"        
##  [435] "NLA06608-0877"         "NLA06608-0878"        
##  [437] "NLA06608-0880"         "NLA06608-0881"        
##  [439] "NLA06608-0885"         "NLA06608-0889"        
##  [441] "NLA06608-0890"         "NLA06608-0891"        
##  [443] "NLA06608-0893"         "NLA06608-0895"        
##  [445] "NLA06608-0899"         "NLA06608-0900"        
##  [447] "NLA06608-0904"         "NLA06608-0905"        
##  [449] "NLA06608-0906"         "NLA06608-0913"        
##  [451] "NLA06608-0914"         "NLA06608-0915"        
##  [453] "NLA06608-0916"         "NLA06608-0918"        
##  [455] "NLA06608-0921"         "NLA06608-0922"        
##  [457] "NLA06608-0924"         "NLA06608-0925"        
##  [459] "NLA06608-0926"         "NLA06608-0927"        
##  [461] "NLA06608-0929"         "NLA06608-0930"        
##  [463] "NLA06608-0933"         "NLA06608-0934"        
##  [465] "NLA06608-0935"         "NLA06608-0938"        
##  [467] "NLA06608-0940"         "NLA06608-0942"        
##  [469] "NLA06608-0943"         "NLA06608-0944"        
##  [471] "NLA06608-0946"         "NLA06608-0950"        
##  [473] "NLA06608-0955"         "NLA06608-0957"        
##  [475] "NLA06608-0958"         "NLA06608-0961"        
##  [477] "NLA06608-0962"         "NLA06608-0967"        
##  [479] "NLA06608-0968"         "NLA06608-0970"        
##  [481] "NLA06608-0971"         "NLA06608-0972"        
##  [483] "NLA06608-0974"         "NLA06608-0979"        
##  [485] "NLA06608-0980"         "NLA06608-0982"        
##  [487] "NLA06608-0984"         "NLA06608-0986"        
##  [489] "NLA06608-0987"         "NLA06608-0989"        
##  [491] "NLA06608-0990"         "NLA06608-0993"        
##  [493] "NLA06608-0994"         "NLA06608-0997"        
##  [495] "NLA06608-1001"         "NLA06608-1003"        
##  [497] "NLA06608-1005"         "NLA06608-1006"        
##  [499] "NLA06608-1007"         "NLA06608-1008"        
##  [501] "NLA06608-1010"         "NLA06608-1012"        
##  [503] "NLA06608-1014"         "NLA06608-1015"        
##  [505] "NLA06608-1016"         "NLA06608-1018"        
##  [507] "NLA06608-1022"         "NLA06608-1024"        
##  [509] "NLA06608-1034"         "NLA06608-1035"        
##  [511] "NLA06608-1036"         "NLA06608-1037"        
##  [513] "NLA06608-1038"         "NLA06608-1039"        
##  [515] "NLA06608-1041"         "NLA06608-1044"        
##  [517] "NLA06608-1045"         "NLA06608-1047"        
##  [519] "NLA06608-1052"         "NLA06608-1055"        
##  [521] "NLA06608-1056"         "NLA06608-1057"        
##  [523] "NLA06608-1058"         "NLA06608-1059"        
##  [525] "NLA06608-1060"         "NLA06608-1070"        
##  [527] "NLA06608-1073"         "NLA06608-1083"        
##  [529] "NLA06608-1086"         "NLA06608-1087"        
##  [531] "NLA06608-1089"         "NLA06608-1091"        
##  [533] "NLA06608-1096"         "NLA06608-1100"        
##  [535] "NLA06608-1102"         "NLA06608-1103"        
##  [537] "NLA06608-1107"         "NLA06608-1108"        
##  [539] "NLA06608-1111"         "NLA06608-1113"        
##  [541] "NLA06608-1114"         "NLA06608-1115"        
##  [543] "NLA06608-1119"         "NLA06608-1120"        
##  [545] "NLA06608-1122"         "NLA06608-1125"        
##  [547] "NLA06608-1129"         "NLA06608-1130"        
##  [549] "NLA06608-1131"         "NLA06608-1134"        
##  [551] "NLA06608-1141"         "NLA06608-1145"        
##  [553] "NLA06608-1147"         "NLA06608-1148"        
##  [555] "NLA06608-1150"         "NLA06608-1151"        
##  [557] "NLA06608-1153"         "NLA06608-1155"        
##  [559] "NLA06608-1162"         "NLA06608-1163"        
##  [561] "NLA06608-1164"         "NLA06608-1166"        
##  [563] "NLA06608-1167"         "NLA06608-1170"        
##  [565] "NLA06608-1172"         "NLA06608-1174"        
##  [567] "NLA06608-1175"         "NLA06608-1177"        
##  [569] "NLA06608-1179"         "NLA06608-1181"        
##  [571] "NLA06608-1183"         "NLA06608-1185"        
##  [573] "NLA06608-1189"         "NLA06608-1190"        
##  [575] "NLA06608-1191"         "NLA06608-1195"        
##  [577] "NLA06608-1198"         "NLA06608-1199"        
##  [579] "NLA06608-1204"         "NLA06608-1206"        
##  [581] "NLA06608-1207"         "NLA06608-1208"        
##  [583] "NLA06608-1209"         "NLA06608-1217"        
##  [585] "NLA06608-1219"         "NLA06608-1220"        
##  [587] "NLA06608-1222"         "NLA06608-1223"        
##  [589] "NLA06608-1227"         "NLA06608-1232"        
##  [591] "NLA06608-1236"         "NLA06608-1238"        
##  [593] "NLA06608-1239"         "NLA06608-1240"        
##  [595] "NLA06608-1241"         "NLA06608-1242"        
##  [597] "NLA06608-1243"         "NLA06608-1244"        
##  [599] "NLA06608-1245"         "NLA06608-1255"        
##  [601] "NLA06608-1256"         "NLA06608-1258"        
##  [603] "NLA06608-1259"         "NLA06608-1262"        
##  [605] "NLA06608-1263"         "NLA06608-1266"        
##  [607] "NLA06608-1268"         "NLA06608-1269"        
##  [609] "NLA06608-1270"         "NLA06608-1271"        
##  [611] "NLA06608-1273"         "NLA06608-1274"        
##  [613] "NLA06608-1278"         "NLA06608-1279"        
##  [615] "NLA06608-1281"         "NLA06608-1283"        
##  [617] "NLA06608-1284"         "NLA06608-1288"        
##  [619] "NLA06608-1292"         "NLA06608-1295"        
##  [621] "NLA06608-1297"         "NLA06608-1300"        
##  [623] "NLA06608-1303"         "NLA06608-1312"        
##  [625] "NLA06608-1316"         "NLA06608-1319"        
##  [627] "NLA06608-1321"         "NLA06608-1323"        
##  [629] "NLA06608-1332"         "NLA06608-1333"        
##  [631] "NLA06608-1334"         "NLA06608-1336"        
##  [633] "NLA06608-1339"         "NLA06608-1342"        
##  [635] "NLA06608-1344"         "NLA06608-1346"        
##  [637] "NLA06608-1347"         "NLA06608-1348"        
##  [639] "NLA06608-1349"         "NLA06608-1354"        
##  [641] "NLA06608-1355"         "NLA06608-1358"        
##  [643] "NLA06608-1359"         "NLA06608-1360"        
##  [645] "NLA06608-1364"         "NLA06608-1365"        
##  [647] "NLA06608-1367"         "NLA06608-1368"        
##  [649] "NLA06608-1369"         "NLA06608-1370"        
##  [651] "NLA06608-1372"         "NLA06608-1375"        
##  [653] "NLA06608-1376"         "NLA06608-1377"        
##  [655] "NLA06608-1380"         "NLA06608-1383"        
##  [657] "NLA06608-1387"         "NLA06608-1389"        
##  [659] "NLA06608-1390"         "NLA06608-1391"        
##  [661] "NLA06608-1396"         "NLA06608-1397"        
##  [663] "NLA06608-1398"         "NLA06608-1401"        
##  [665] "NLA06608-1403"         "NLA06608-1413"        
##  [667] "NLA06608-1414"         "NLA06608-1417"        
##  [669] "NLA06608-1420"         "NLA06608-1421"        
##  [671] "NLA06608-1425"         "NLA06608-1426"        
##  [673] "NLA06608-1432"         "NLA06608-1434"        
##  [675] "NLA06608-1435"         "NLA06608-1436"        
##  [677] "NLA06608-1439"         "NLA06608-1445"        
##  [679] "NLA06608-1447"         "NLA06608-1450"        
##  [681] "NLA06608-1454"         "NLA06608-1455"        
##  [683] "NLA06608-1460"         "NLA06608-1461"        
##  [685] "NLA06608-1462"         "NLA06608-1465"        
##  [687] "NLA06608-1469"         "NLA06608-1473"        
##  [689] "NLA06608-1476"         "NLA06608-1481"        
##  [691] "NLA06608-1482"         "NLA06608-1483"        
##  [693] "NLA06608-1484"         "NLA06608-1487"        
##  [695] "NLA06608-1488"         "NLA06608-1489"        
##  [697] "NLA06608-1492"         "NLA06608-1496"        
##  [699] "NLA06608-1499"         "NLA06608-1504"        
##  [701] "NLA06608-1508"         "NLA06608-1510"        
##  [703] "NLA06608-1511"         "NLA06608-1515"        
##  [705] "NLA06608-1517"         "NLA06608-1521"        
##  [707] "NLA06608-1524"         "NLA06608-1527"        
##  [709] "NLA06608-1529"         "NLA06608-1532"        
##  [711] "NLA06608-1537"         "NLA06608-1538"        
##  [713] "NLA06608-1544"         "NLA06608-1556"        
##  [715] "NLA06608-1560"         "NLA06608-1561"        
##  [717] "NLA06608-1562"         "NLA06608-1564"        
##  [719] "NLA06608-1568"         "NLA06608-1569"        
##  [721] "NLA06608-1572"         "NLA06608-1575"        
##  [723] "NLA06608-1576"         "NLA06608-1577"        
##  [725] "NLA06608-1578"         "NLA06608-1579"        
##  [727] "NLA06608-1593"         "NLA06608-1595"        
##  [729] "NLA06608-1596"         "NLA06608-1600"        
##  [731] "NLA06608-1602"         "NLA06608-1608"        
##  [733] "NLA06608-1617"         "NLA06608-1623"        
##  [735] "NLA06608-1626"         "NLA06608-1630"        
##  [737] "NLA06608-1631"         "NLA06608-1633"        
##  [739] "NLA06608-1637"         "NLA06608-1638"        
##  [741] "NLA06608-1640"         "NLA06608-1641"        
##  [743] "NLA06608-1643"         "NLA06608-1652"        
##  [745] "NLA06608-1654"         "NLA06608-1655"        
##  [747] "NLA06608-1668"         "NLA06608-1672"        
##  [749] "NLA06608-1674"         "NLA06608-1675"        
##  [751] "NLA06608-1679"         "NLA06608-1684"        
##  [753] "NLA06608-1687"         "NLA06608-1690"        
##  [755] "NLA06608-1695"         "NLA06608-1703"        
##  [757] "NLA06608-1704"         "NLA06608-1707"        
##  [759] "NLA06608-1711"         "NLA06608-1715"        
##  [761] "NLA06608-1717"         "NLA06608-1719"        
##  [763] "NLA06608-1723"         "NLA06608-1724"        
##  [765] "NLA06608-1733"         "NLA06608-1735"        
##  [767] "NLA06608-1736"         "NLA06608-1739"        
##  [769] "NLA06608-1740"         "NLA06608-1741"        
##  [771] "NLA06608-1742"         "NLA06608-1748"        
##  [773] "NLA06608-1755"         "NLA06608-1771"        
##  [775] "NLA06608-1775"         "NLA06608-1781"        
##  [777] "NLA06608-1782"         "NLA06608-1789"        
##  [779] "NLA06608-1791"         "NLA06608-1793"        
##  [781] "NLA06608-1800"         "NLA06608-1802"        
##  [783] "NLA06608-1804"         "NLA06608-1808"        
##  [785] "NLA06608-1810"         "NLA06608-1811"        
##  [787] "NLA06608-1812"         "NLA06608-1818"        
##  [789] "NLA06608-1821"         "NLA06608-1824"        
##  [791] "NLA06608-1825"         "NLA06608-1835"        
##  [793] "NLA06608-1836"         "NLA06608-1839"        
##  [795] "NLA06608-1840"         "NLA06608-1851"        
##  [797] "NLA06608-1856"         "NLA06608-1857"        
##  [799] "NLA06608-1861"         "NLA06608-1862"        
##  [801] "NLA06608-1863"         "NLA06608-1867"        
##  [803] "NLA06608-1868"         "NLA06608-1871"        
##  [805] "NLA06608-1873"         "NLA06608-1874"        
##  [807] "NLA06608-1879"         "NLA06608-1884"        
##  [809] "NLA06608-1893"         "NLA06608-1906"        
##  [811] "NLA06608-1908"         "NLA06608-1910"        
##  [813] "NLA06608-1930"         "NLA06608-1936"        
##  [815] "NLA06608-1948"         "NLA06608-1953"        
##  [817] "NLA06608-1958"         "NLA06608-1959"        
##  [819] "NLA06608-1960"         "NLA06608-1968"        
##  [821] "NLA06608-1975"         "NLA06608-1985"        
##  [823] "NLA06608-1989"         "NLA06608-1992"        
##  [825] "NLA06608-1998"         "NLA06608-2005"        
##  [827] "NLA06608-2007"         "NLA06608-2010"        
##  [829] "NLA06608-2027"         "NLA06608-2036"        
##  [831] "NLA06608-2037"         "NLA06608-2039"        
##  [833] "NLA06608-2049"         "NLA06608-2056"        
##  [835] "NLA06608-2072"         "NLA06608-2074"        
##  [837] "NLA06608-2076"         "NLA06608-2078"        
##  [839] "NLA06608-2082"         "NLA06608-2086"        
##  [841] "NLA06608-2087"         "NLA06608-2091"        
##  [843] "NLA06608-2092"         "NLA06608-2094"        
##  [845] "NLA06608-2095"         "NLA06608-2103"        
##  [847] "NLA06608-2114"         "NLA06608-2117"        
##  [849] "NLA06608-2120"         "NLA06608-2123"        
##  [851] "NLA06608-2131"         "NLA06608-2134"        
##  [853] "NLA06608-2135"         "NLA06608-2152"        
##  [855] "NLA06608-2154"         "NLA06608-2155"        
##  [857] "NLA06608-2162"         "NLA06608-2177"        
##  [859] "NLA06608-2185"         "NLA06608-2187"        
##  [861] "NLA06608-2196"         "NLA06608-2217"        
##  [863] "NLA06608-2219"         "NLA06608-2241"        
##  [865] "NLA06608-2250"         "NLA06608-2253"        
##  [867] "NLA06608-2257"         "NLA06608-2266"        
##  [869] "NLA06608-2267"         "NLA06608-2283"        
##  [871] "NLA06608-2305"         "NLA06608-2322"        
##  [873] "NLA06608-2332"         "NLA06608-2333"        
##  [875] "NLA06608-2345"         "NLA06608-2354"        
##  [877] "NLA06608-2372"         "NLA06608-2379"        
##  [879] "NLA06608-2418"         "NLA06608-2426"        
##  [881] "NLA06608-2429"         "NLA06608-2438"        
##  [883] "NLA06608-2450"         "NLA06608-2453"        
##  [885] "NLA06608-2457"         "NLA06608-2463"        
##  [887] "NLA06608-2477"         "NLA06608-2481"        
##  [889] "NLA06608-2492"         "NLA06608-2497"        
##  [891] "NLA06608-2507"         "NLA06608-2513"        
##  [893] "NLA06608-2523"         "NLA06608-2524"        
##  [895] "NLA06608-2565"         "NLA06608-2593"        
##  [897] "NLA06608-2629"         "NLA06608-2640"        
##  [899] "NLA06608-2644"         "NLA06608-2655"        
##  [901] "NLA06608-2673"         "NLA06608-2685"        
##  [903] "NLA06608-2696"         "NLA06608-2704"        
##  [905] "NLA06608-2708"         "NLA06608-2714"        
##  [907] "NLA06608-2715"         "NLA06608-2726"        
##  [909] "NLA06608-2740"         "NLA06608-2753"        
##  [911] "NLA06608-2776"         "NLA06608-2779"        
##  [913] "NLA06608-2797"         "NLA06608-2800"        
##  [915] "NLA06608-2801"         "NLA06608-2823"        
##  [917] "NLA06608-2824"         "NLA06608-2831"        
##  [919] "NLA06608-2833"         "NLA06608-2874"        
##  [921] "NLA06608-2881"         "NLA06608-2889"        
##  [923] "NLA06608-2891"         "NLA06608-2916"        
##  [925] "NLA06608-2924"         "NLA06608-2954"        
##  [927] "NLA06608-2955"         "NLA06608-2972"        
##  [929] "NLA06608-2987"         "NLA06608-2996"        
##  [931] "NLA06608-3032"         "NLA06608-3035"        
##  [933] "NLA06608-3083"         "NLA06608-3096"        
##  [935] "NLA06608-3121"         "NLA06608-3147"        
##  [937] "NLA06608-3153"         "NLA06608-3157"        
##  [939] "NLA06608-3160"         "NLA06608-3169"        
##  [941] "NLA06608-3228"         "NLA06608-3265"        
##  [943] "NLA06608-3303"         "NLA06608-3313"        
##  [945] "NLA06608-3320"         "NLA06608-3329"        
##  [947] "NLA06608-3480"         "NLA06608-3484"        
##  [949] "NLA06608-3608"         "NLA06608-3616"        
##  [951] "NLA06608-3644"         "NLA06608-3656"        
##  [953] "NLA06608-3660"         "NLA06608-3698"        
##  [955] "NLA06608-3846"         "NLA06608-3890"        
##  [957] "NLA06608-3911"         "NLA06608-4056"        
##  [959] "NLA06608-4064"         "NLA06608-4206"        
##  [961] "NLA06608-4252"         "NLA06608-4320"        
##  [963] "NLA06608-4382"         "NLA06608-4413"        
##  [965] "NLA06608-4414"         "NLA06608-4440"        
##  [967] "NLA06608-4472"         "NLA06608-4504"        
##  [969] "NLA06608-4610"         "NLA06608-4643"        
##  [971] "NLA06608-4650"         "NLA06608-4659"        
##  [973] "NLA06608-4686"         "NLA06608-4698"        
##  [975] "NLA06608-4828"         "NLA06608-4929"        
##  [977] "NLA06608-9999"         "NLA06608-ALPS-1218"   
##  [979] "NLA06608-ALSC:020149"  "NLA06608-ELS:1C2-032" 
##  [981] "NLA06608-ELS:1C3-003"  "NLA06608-ELS:1D1-035" 
##  [983] "NLA06608-ELS:1D2-087"  "NLA06608-ELS:1E1-052" 
##  [985] "NLA06608-ELS:1E1-096"  "NLA06608-ELS:1E1-128" 
##  [987] "NLA06608-ELS:1E3-012"  "NLA06608-ELS:2B2-008" 
##  [989] "NLA06608-ELS:2C2-048"  "NLA06608-ELS:2C3-018" 
##  [991] "NLA06608-ELS:2D3-008"  "NLA06608-EMAP:ME011L" 
##  [993] "NLA06608-EMAP:ME012L"  "NLA06608-EMAP:ME254L" 
##  [995] "NLA06608-EMAP:ME263L"  "NLA06608-EMAP:ME518L" 
##  [997] "NLA06608-FL:107895579" "NLA06608-FL:16674741" 
##  [999] "NLA06608-FL:18261987"  "NLA06608-FL:99324403" 
## [1001] "NLA06608-IN:646"       "NLA06608-MI:7007"     
## [1003] "NLA06608-MN:03-0029"   "NLA06608-MN:06-0002"  
## [1005] "NLA06608-MN:11-0102"   "NLA06608-MN:15-0010"  
## [1007] "NLA06608-MN:22-0074"   "NLA06608-MN:49-0140"  
## [1009] "NLA06608-MN:51-0063"   "NLA06608-MN:56-0306"  
## [1011] "NLA06608-MN:61-0037"   "NLA06608-MN:74-0023"  
## [1013] "NLA06608-MN:75-0200"   "NLA06608-MN:77-0019"  
## [1015] "NLA06608-MN:87-0030"   "NLA06608-NELP-0253"   
## [1017] "NLA06608-NELP-0955"    "NLA06608-NELP-1330"   
## [1019] "NLA06608-NELP-2155"    "NLA06608-NELP-3586"   
## [1021] "NLA06608-NH250L"       "NLA06608-NH4912"      
## [1023] "NLA06608-NV:2"         "NLA06608-NV:4"        
## [1025] "NLA06608-OH:19"        "NLA06608-OH:22"       
## [1027] "NLA06608-R10BULLTR"    "NLA06608-R10CHARLT"   
## [1029] "NLA06608-R10COUNCI"    "NLA06608-R10FISHLA"   
## [1031] "NLA06608-R10FOURMI"    "NLA06608-R10RAINYL"   
## [1033] "NLA06608-R10SQUAWL"    "NLA06608-R10ULAKE"    
## [1035] "NLA06608-R10YELLOW"    "NLA06608-R31"         
## [1037] "NLA06608-R314"         "NLA06608-R315"        
## [1039] "NLA06608-R318"         "NLA06608-R319"        
## [1041] "NLA06608-R32"          "NLA06608-R322"        
## [1043] "NLA06608-R323"         "NLA06608-R324"        
## [1045] "NLA06608-R326"         "NLA06608-R328"        
## [1047] "NLA06608-R333"         "NLA06608-R334"        
## [1049] "NLA06608-R336"         "NLA06608-R34"         
## [1051] "NLA06608-R5:KATHRYN"   "NLA06608-R5:OTTAWA"   
## [1053] "NLA06608-R7101"        "NLA06608-R7103"       
## [1055] "NLA06608-R7106"        "NLA06608-R715"        
## [1057] "NLA06608-R716"         "NLA06608-R723"        
## [1059] "NLA06608-R728"         "NLA06608-R730"        
## [1061] "NLA06608-R733"         "NLA06608-R736"        
## [1063] "NLA06608-R746"         "NLA06608-R750"        
## [1065] "NLA06608-R759"         "NLA06608-R764"        
## [1067] "NLA06608-R767"         "NLA06608-R769"        
## [1069] "NLA06608-R770"         "NLA06608-R772"        
## [1071] "NLA06608-R775"         "NLA06608-R784"        
## [1073] "NLA06608-R791"         "NLA06608-R792"        
## [1075] "NLA06608-R796"         "NLA06608-TX:10"       
## [1077] "NLA06608-TX:14"        "NLA06608-TX:15"       
## [1079] "NLA06608-TX:19"        "NLA06608-TX:22"       
## [1081] "NLA06608-TX:27"        "NLA06608-TX:29"       
## [1083] "NLA06608-TX:30"        "NLA06608-TX:5"        
## [1085] "NLA06608-WI:LOWES"     "NLA06608-WI:SY"
```

```r
#The chlorophyll a column
nla_wq$CHLA
```

```
##    [1]   0.24   3.84  16.96   4.60   4.08   2.43  30.24   4.38   4.90
##   [10]  16.03   8.75  20.00  13.00   4.03  20.24   2.29   2.78  44.15
##   [19]   1.30 123.12   5.26   8.92   5.07   8.02   4.33   0.88   2.21
##   [28]   5.41 135.61  20.16  54.00   1.14   3.95   6.26 125.40   3.50
##   [37]   2.18  19.04   0.57   1.75   0.95   7.41 198.72  10.13   0.49
##   [46]  10.88  10.02   2.35  58.46   6.66   4.04  18.24  11.36   4.36
##   [55] 118.80   4.60   0.70   1.20  38.20   5.98   1.77   3.26  84.76
##   [64]   4.69   1.35   2.82   2.54  31.59 228.24   5.92   0.46   0.43
##   [73]  12.91   8.11   1.58   1.33  12.80  52.56 110.16   1.36  22.25
##   [82]   1.87   4.18   8.22   5.20  10.40  79.80   3.14  39.00   2.56
##   [91] 936.00  21.76   2.59  70.40   6.75  19.68  25.76   3.58  18.40
##  [100]  30.62   1.38  30.10  40.75  32.26   5.17   1.13  15.55  31.40
##  [109]  10.67   0.80   0.77  68.85   6.52  65.60   2.41   4.36  58.46
##  [118]  19.20  17.60  55.58 871.20  31.68  38.74  21.92   1.88   0.88
##  [127]   5.89   1.43   3.60   4.78   7.80   2.98   2.66   2.10   9.74
##  [136]   2.87   1.82   6.00   2.66  55.80  32.54  49.60   2.44   1.15
##  [145]  48.24   1.27   7.70  30.04   6.72   1.98  12.93 126.27  20.95
##  [154]  25.10   9.86  20.80  35.28   2.22   4.30   3.62  21.89   2.34
##  [163]   5.73  14.13   3.78 203.76  84.24  38.73  19.20  15.08  13.89
##  [172]   4.48   4.82  46.00   1.26  56.74 117.50   1.10   6.44   5.04
##  [181]   5.88   7.84   7.44   9.90   5.28  45.36  24.80   6.05  17.44
##  [190] 110.70   5.62   3.69  42.66  11.86  11.68   7.57  59.40   1.74
##  [199]   3.16   0.68   4.25  44.93   0.55   0.83   0.33   1.24  30.40
##  [208]   3.35  16.16  73.73   5.36   8.56   1.81   5.67 108.58   6.69
##  [217]   2.18  16.16   3.12  24.80   1.68  23.20  18.22 377.28   5.46
##  [226]   4.50   6.85   1.21   4.39   7.25   4.31  25.10  15.06   3.98
##  [235]  30.72  12.72   0.64   3.35   1.51   5.52  19.20  36.82   5.30
##  [244]   1.52   3.84 126.40  49.68  24.32   9.47  24.64   1.77   0.86
##  [253]  26.42  13.12   0.63   2.28 244.80  28.00   1.23  71.20   2.35
##  [262]  11.84   3.86   5.92  48.60  11.01  11.79  26.08  17.76   3.81
##  [271]   3.18   2.34  95.04   6.02  14.94   2.11   1.31  16.80   5.65
##  [280]   7.22  12.96   0.14   2.08   6.65  40.90  54.00   3.49   7.14
##  [289]   1.82   1.93  15.70 326.88   2.53  15.28   7.47   5.81  10.69
##  [298]  20.64 106.56   0.99   7.80  50.26   5.82 102.60 187.92   5.81
##  [307]  20.64   1.22   2.44  10.17   2.95   4.40  23.20  35.20   0.62
##  [316]   3.19   2.30   2.62  34.00 139.68   5.15   7.41  25.44  78.29
##  [325]   3.64   6.90  12.96   9.15  12.48   1.12  24.14   2.90  25.92
##  [334]   2.97 273.60   2.50  63.36  25.72  12.11   3.44   2.28   4.61
##  [343]  13.76  32.62   5.60  98.46   7.44  16.32   3.06   1.65   3.55
##  [352] 216.00   2.64  19.20   7.10   5.65   2.97   1.50 130.40   2.88
##  [361]   2.85   3.15   1.70   6.03  97.49  13.74   3.62   8.80   1.15
##  [370] 114.60  10.96 185.40  54.00 133.20  24.26  11.39  33.94  15.36
##  [379]   6.82   6.40   1.82  98.50  17.92   3.28  50.93   6.57  30.24
##  [388]   3.07   1.06   4.24   5.23   5.01   2.27   8.32  27.50  76.80
##  [397]   3.01  50.04   6.45  27.20 120.80   2.08   6.23  39.70  11.60
##  [406]  68.40 272.00   1.30   8.05   2.70  55.58   1.56   2.57  31.84
##  [415] 189.36   4.70   2.30   7.80   9.47  12.72  11.47  11.17   3.57
##  [424]  14.38   9.22  83.52  29.48  11.66   0.49 256.32  14.32   9.98
##  [433]  14.16   6.14  11.80   6.11  41.60  15.89  23.04  11.93   3.38
##  [442]  30.68   6.96  13.86  69.19  15.65  77.20   1.29   0.83   3.44
##  [451]   1.29  37.87   1.73   2.38  19.50   1.24  98.00   1.02   1.47
##  [460]   2.72   1.56   1.30   8.16   0.07  18.72  11.89  22.56   2.38
##  [469]   2.29  25.23  14.96   1.72   2.78   2.16   8.56   3.64   1.40
##  [478]  15.50  47.60   0.86  28.58  13.36   1.68   3.75  84.00   2.08
##  [487]  32.64   5.22  38.30  65.20  20.32   0.53   3.74   1.50   5.28
##  [496]   3.82  22.88  34.20   9.26   0.52  22.72   7.19   9.81  66.24
##  [505]  21.44   7.56 138.24   6.66   1.98 255.60  39.89  10.56   4.00
##  [514] 125.28   3.31  18.40   1.26   9.60  28.66  89.71   8.75   0.15
##  [523]   0.80  39.80 155.52  23.11   0.34 318.24  13.86   3.58   1.04
##  [532]  12.67  36.17   2.90   2.10  10.98  49.03  53.64  46.22   7.57
##  [541]  12.50   4.42   2.21   8.02   5.92   4.18   4.32  23.68   6.19
##  [550]   9.43  10.16  17.83  42.24  48.00   3.79  13.72   0.25  28.68
##  [559]   3.08   4.01   8.08   1.15   2.62   1.22   3.00   2.76  32.11
##  [568]  16.64 349.20  82.22   1.81 104.53   1.87   6.18  48.96  16.57
##  [577]   2.64  49.58   5.04   2.98   2.50 138.82   6.55  21.60  38.87
##  [586]  22.40  10.40  81.60   5.08   5.65   4.75   1.83  83.38  28.87
##  [595]  14.08   2.90  35.28 103.90  17.44 516.00   2.58   4.35   3.01
##  [604]  20.80  14.00   0.93  37.84 113.14   1.60  98.88 195.84   1.90
##  [613]  29.09  10.67   1.19  46.37   1.19  45.22   7.08  26.08   6.06
##  [622]   1.59   7.65   1.60  62.40 169.63   1.57  15.38  19.64   1.34
##  [631]   3.00  49.86 147.60   3.78   6.30   2.16   5.07   1.31  27.20
##  [640]   3.63   3.84   7.64  34.85  49.92 103.20   5.36 184.00  32.20
##  [649]  30.08  16.16  62.64  63.94   9.12   0.87   2.77  21.28   9.97
##  [658]  52.85   5.59  67.97   5.12 210.60   7.87  37.30   1.93  49.20
##  [667]  10.48   1.99  13.38  75.60   9.71  12.37   5.16   2.31   9.40
##  [676]   4.72   3.33  16.67   5.09   2.94   2.82   8.80   4.46  18.22
##  [685]  26.80   5.97  65.52   2.01  62.00   0.49  23.52   4.81   3.80
##  [694]  14.59 114.62  17.94  40.61  12.98   2.91 155.08  11.74  28.48
##  [703]   5.24  11.60   6.38  82.51   7.72 381.60   6.04  42.66   2.18
##  [712]   2.62  26.64   5.39  27.47   3.24   2.94  12.80  11.49  19.47
##  [721]   4.45  88.20  68.40   4.32  23.36   2.26   6.34   5.00 684.00
##  [730]  13.01   4.25  31.52   7.25  24.16  14.78  21.44  27.58   1.52
##  [739]  19.87   0.23  23.20   5.66   3.17  57.20   4.48 542.40  18.72
##  [748] 100.51   2.32   3.01   3.12  22.63   7.52   4.63   2.29  32.04
##  [757]  32.54   3.29   4.32   8.80   0.88 314.61   2.82  55.28 167.04
##  [766]  62.00  38.20   2.23  27.13 116.40   3.37   1.04  12.60   4.03
##  [775]  23.00  14.56  17.44   1.35   1.63   5.45  43.63   5.30  25.47
##  [784]  24.80  14.80   7.57  13.68   0.68 197.00  25.14  16.20   2.02
##  [793] 115.56  12.53  72.00   6.05   5.18   1.25  55.32   7.60  61.44
##  [802]  52.70   9.00   3.10   0.46   3.56 109.66  25.44   6.94   2.10
##  [811]   0.94  22.24   1.48  31.40  20.88   9.17   0.67  17.49  14.85
##  [820]  94.93   4.98   0.66  17.12 104.40   3.32 194.40   6.72  14.30
##  [829]   3.95   4.41  19.20 338.40   1.42  92.16 105.84  61.09   3.59
##  [838]   8.64   3.57   1.59  64.51  20.43  84.96  20.64   2.89   8.13
##  [847]   3.41 149.60  13.47 166.63  13.44   6.15  15.22  23.83  46.40
##  [856]   1.46   3.74   1.39   4.20  14.96   3.38   2.79  20.52   1.13
##  [865]   0.70  30.08   1.91   1.62   8.50   3.43   6.54   3.57  14.29
##  [874]  68.88   3.04   7.78   4.84   1.42  24.32  69.60   2.45   4.64
##  [883]   0.90   4.59   3.69   1.58   1.83   0.95  19.36  20.91  38.02
##  [892]   3.54  13.50  41.90   7.10  38.20  27.16  25.12   4.43  29.46
##  [901]   1.33   2.43  41.76  25.88   5.16   9.07   4.75   1.18  11.37
##  [910]   3.39  13.86   6.00   2.02   2.41   6.82  24.32  25.28  37.60
##  [919]   3.06   3.94   0.89   1.77   7.20   1.98  12.64 136.66  32.98
##  [928] 145.00  15.18  16.64  44.93   3.25  20.64   9.87  14.64  37.66
##  [937]   1.50   2.21 271.44  54.43   8.70   1.77  35.42   7.73  19.07
##  [946]   3.70  38.88  83.50  52.85   1.69  19.20 428.00   5.25   4.59
##  [955]   0.90   2.77  29.12   8.08  10.19  66.96   1.47   2.50  12.08
##  [964]   2.56  12.10  34.20  29.40  18.51   5.38  13.83  26.08  76.32
##  [973]  16.80 104.40   4.62  38.30   1.02   1.09   3.27  14.18   2.72
##  [982]  31.36  16.80   1.67   2.91   3.15   1.17   3.97   5.64   5.45
##  [991]   1.11   4.35   0.69   1.75   1.84   2.06  10.53   1.54   5.28
## [1000]  18.72   1.01   2.75   2.67  42.26   2.47   2.87  47.95   1.21
## [1009]  25.12   5.39   7.00  13.54  15.43  12.78  40.03   1.04   0.82
## [1018]   0.82   0.73   1.08   3.99   0.78   1.29  28.00   5.89   1.00
## [1027]   0.70   0.20   0.68   7.79   2.74   0.53   0.66   6.04   0.38
## [1036]   2.87   3.97   2.48   5.34  12.11   1.68   2.03  15.96   4.67
## [1045]  27.52   2.24   8.48   8.48  12.00   2.51   4.10   1.05 118.40
## [1054]  77.20  30.67  70.27  15.01  13.87  21.28  16.32  14.26  11.04
## [1063]  17.28  35.86   4.78   7.98   0.79   1.49   2.70   7.60   5.36
## [1072]   6.75 101.25 143.60  99.52  33.55   8.16   3.63   8.43 109.83
## [1081]  12.58   3.89  80.10  15.12 149.04  32.90
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
