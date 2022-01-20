
Basics of R
===========

Lesson Outline
--------------

-   [RStudio](#rstudio)
-   [R language fundamentals](#r-language-fundamentals)
-   [The data frame](#the-data-frame)

Lesson Exercises
----------------

-   [Exercise 1](#exercise-1)
-   [Exercise 2](#exercise-2)

RStudio
-------

### Working with R and RStudio

Over the last several years, RStudio has become a very popular IDE (integrated development environment) for R. In addition to interacting with the R Console, RStudio has many extras built in including version control integration, package building, reproducible research, de-bugging, and built-in text editor with smart highlighting and code completion. This is the environment we will be using for the workshop and should set you up for continued learning with R.

Before we get to the first exercise, let's spend a bit of time working with RStudio. Just watch as I demo this. The first exercise will have you doing these steps.

### Fire up R and RStudio

Find the RStudio shortcut or menu (OS specific of course) and fire it up. Once done, it should look something like:

![rstudio](figure/rstudio.jpg)

Let's take some time to look around. I'll show each of the different sections, or "panes" as they are known.

### Projects

Projects are a way to organize your work in RStudio. Essentially they are folders, but with a few added files so that you can manage some options on a per project basis. To create a new project use <File:New> Project, or use the drop-down on the top right of the RStudio window. It will look like this after you select "New Project..."

![rstudio proj](figure/rstudio_proj.jpg)

### Scripts

Scripts are text files that hold the code you write. We will work both with scripts and the console during this workshop. To create a new script you use "<File:New> <File:R> Script".

![rstudio script](figure/rstudio_script.jpg)

### Interacting with R inside of RStudio

Once you have functions in your script, they still need to be sent to the R console. There are several ways to do this. There is the old stand-by of copying and pasting, but this is a bit cumbersome. Instead you can use the `Run` button in the upper right corner of the source pane, or even better (I think so, anyway) you can use `ctrl-enter`. Both the `Run` buttons and `ctrl-enter` will send the line that your cursor is on and move to the next line or it will send just the selected text.

![rstudio-script](figure/rstudio_run.jpg)

Exercise 1
----------

This exercise will make sure R and RStudio are working and that you can get around the basics in RStudio. Use the green stickies when you have completed, and red stickies if you are running into problems.

1.  Start RStudio: To start both R and RStudio requires only firing up RStudio. RStudio should be available from All Programs at the Start Menu. Fire up RStudio.
2.  Take a few minutes to look around RStudio. Find the Console Pane. Find Global and Project Options (hint: look in Tools). Look at the Environment, History Pane. Look at the Files, Plots, Packages, etc. pane.

3.  Create a new project. Name it "cerf\_r\_workshop". We will use this for the rest of the workshop.

4.  Create a new "R Script" in the Source Pane, save that file into your newly created project and name it "cerf\_workshop.R". It'll just be a blank text file at this point.

5.  Add in a comment line to separate this section. It should look something like: `# Exercise 1: Just Getting used to RStudio and Scripts`.

6.  Add a single line to this script with the following text: `ls()`. This is an R function that lists objects in your current environment. Use the various ways we showed to send this command to the R Console. Also, try typing this directly into the R Console and hit `Enter` to run it.

7.  Lastly, we need to get this project set up with some example data for our upcoming exercises. You should have downloaded this already, but if not, the data are available from <https://usepa.github.io/cerf_r/data.zip>. Copy this zip file into your project and unzip into a folder named `data`.

R language fundamentals
-----------------------

### Functions and basic syntax

R is a functional programming language and as such, most everything you do uses a function.

The basic syntax of function follows the form: `function_name(arg1, arg2, ...)`. With the base install, you will gain access to many (3866 functions, to be exact). Some examples:

``` r
#Print
print("hello world!")
```

    ## [1] "hello world!"

``` r
#A sequence
seq(1,10)
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
#Random normal numbers
rnorm(100,mean=10,sd=2)
```

    ##   [1] 11.107458  9.826251  8.284993  7.470559 11.574341  9.106477  8.737679
    ##   [8]  6.059051 10.453519 10.953001 10.467034 10.865577 12.408636  9.697859
    ##  [15] 10.704760  9.456156 10.225607  8.080390  9.141435  7.990206 11.249459
    ##  [22]  7.669894 12.698951  9.007324 10.330663 10.285502  6.313021  4.797985
    ##  [29]  8.193402  9.558743 12.594119 10.224060  5.760441  7.006890  9.793743
    ##  [36]  7.084714  9.191355 10.369976  8.784472 14.310849 13.010280 10.217266
    ##  [43] 10.343144 13.818994  9.238629 11.337827 10.995251  7.188340 11.330322
    ##  [50] 12.131302  7.356080  6.804971  7.143444  9.294138 11.298623  9.556650
    ##  [57] 11.238352  8.403956 12.971388 11.049064  9.559426  8.687384 11.610741
    ##  [64]  8.496808  7.343738 13.171276  9.372551  9.128817 13.741026 14.469998
    ##  [71]  9.587523 10.667313  9.492136 10.051293 10.875054 10.144283  7.247322
    ##  [78]  7.521518  9.244399  7.933775  9.230506 11.369789  8.334552  9.462259
    ##  [85] 14.847286  9.598365 10.225291  8.654251  9.264931 11.120839 10.971163
    ##  [92] 10.311238  9.917104  9.824983 10.185210 11.793643 10.276061 11.428962
    ##  [99]  9.478244  9.492684

``` r
#Mean
mean(rnorm(100))
```

    ## [1] 0.01934887

``` r
#Sum
sum(rnorm(100))
```

    ## [1] -23.75453

Very often you will see functions used like this:

``` r
my_random_sum <- sum(rnorm(100))
```

In this case the first part of the line is the name of an object. You make this up. Ideally it should have some meaning, but the only rules are that it can't start with a number and must not have any spaces. The second bit, `<-`, is the assignment operator. This tells R to take the result of `sum(rnorm(100))` and store it an object named, `my_random_sum`.

With this, you have the very basics of how we write R code and save objects that can be used later.

### A few side notes

There are several other characters that commonly show up in R code. These are:

``` r
# NOTES:
#Comments
#()
#[]
#{}
```

The `#` indicates a comment. You can put whatever else you'd like after this, but on the same line as the `#`. R will not evaluate it. Multiple `#####`, are still just seen as a comment. When commenting your code, err on the side of too much! Also, you will see `()`, `[]`, and `{}` used in R code. The `()` indicates a function (almost always), the `[]` indicates indexing (grabbing values by the location), and the `{}` groups code that is meant to be run together and is usually used when programming functions in R.

### Packages

The base install of R is quite powerful, but you will soon have a need or desire to go beyond this. Packages provide this ability. They are a standardized method for extending R with new methods, techniques, and programming functionality. There is a lot to say about packages regarding finding them, using them, etc., but for now let's focus just on the basics.

### CRAN

One of the reasons for R's popularity is CRAN, [The Comprehensive R Archive Network](http://cran.r-project.org/). This is where you download R and also where most will gain access to packages (there are other places, but that is for later). Not much else to say about this now other than to be aware of it. As of 2017-11-03, there are 11647 on CRAN!

### Installing packages

When a package gets installed, that means the source is downloaded and put into your library. A default library location is set for you so no need to worry about that. In fact on Windows most of this is pretty automatic. Let's give it a shot.

``` r
#Installing Packages from CRAN
#Install dplyr and ggplot2
install.packages("ggplot2")
install.packages("dplyr")

#You can also put more than one in like
install.packages(c("quickmapr","formatR"))
```

### Using packages

One source of confusion that many have is when they cannot access a package that they just installed. This is because getting to this point requires an extra step, loading (or attaching) the package.

``` r
#Loading packages into your library
#Add libraries to your R Session
library("ggplot2")
library("dplyr")

#You can also access functions without loading by using package::function
dplyr::mutate
```

    ## function (.data, ...) 
    ## {
    ##     UseMethod("mutate")
    ## }
    ## <environment: namespace:dplyr>

You will often see people use `require()` to load a package. It is better form to not do this. For a more detailed explanation of why `library()` and not `require()` see [Yihui Xie's post on the subject](http://yihui.name/en/2014/07/library-vs-require/.)

And now for a little pedantry. You will often hear people use the terms "library" and "package" interchangeably. This is not correct. A package is what is submitted to CRAN, it is what contains a group of functions that address a common problem, and it is what has allowed R to expand. A library is, more or less, where you packages are stored. You have a path to that library and this is where R puts new packages that you install (e.g. via `install.packages()`). These two terms are related, but most certainly different. Apologies up front if I slip and use one when I actually mean the other...

### Getting Help

Being able to find help and interpret that help is probably one of the most important skills for learning a new language. R is no different. Help on functions and packages can be accessed directly from R, can be found on CRAN and other official R resources, searched on Google, found on StackOverflow, or from any number of fantastic online resources. I will cover a few of these here.

### Help from the console

Getting help from the console is straightforward and can be done numerous ways.

``` r
#Using the help command/shortcut
#When you know the name of a function
help("print") #Help on the print command
?print #Help on the print command using the `?` shortcut

#When you know the name of the package
help(package="dplyr") #Help on the package `dplyr`

#Don't know the exact name or just part of it
apropos("print") #Returns all available functions with "print" in the name
??print #Shortcut, but also searches demos and vignettes in a formatted page
```

### Official R Resources

In addition to help from within R itself, CRAN and the R-Project have many resources available for support. Two of the most notable are the mailing lists and the [task views](http://cran.r-project.org/web/views/).

-   [R Help Mailing List](https://stat.ethz.ch/mailman/listinfo/r-help): The main mailing list for R help. Can be a bit daunting and some (although not most) senior folks can be, um, curmudgeonly...
-   [R-sig-ecology](https://stat.ethz.ch/mailman/listinfo/r-sig-ecology): A special interest group for use of R in ecology. Less daunting the the main help with participation from some big names in ecological modelling and statistics (e.g., Ben Bolker, Gavin Simpson, and Phil Dixon). One of the moderators is great, the other is a bit of a jerk (it's me).
-   [Environmetrics Task View](http://cran.r-project.org/web/views/Environmetrics.html): Task views are great in that they provide an annotated list of packages relevant to a particular field. This one is maintained by Gavin Simpson and has great info on packages relevant to much of the work at EPA.
-   [Spatial Analysis Task View](http://cran.r-project.org/web/views/Spatial.html): One I use a lot that lists all the relevant packages for spatial analysis, GIS, and Remote Sensing in R.

### Google and StackOverflow

While the resources already mentioned are useful, often the quickest way is to just turn to Google. However, a search for "R" is a bit challenging. A few ways around this. Google works great if you search for a given package or function name. You can search for mailing lists directly (i.e. "R-sig-geo"). An R specific search tool, [RSeek.org](http://www.rseek.org/), has been created to facilitate this.

One specific resource that I use quite a bit is [StackOverflow with the 'r' tag](http://stackoverflow.com/questions/tagged/r). StackOverflow is a discussion forum for all things related to programming. You can then use this tag and the search functions in StackOverflow and find answers to almost anything you can think of.

### Other Resources

As I mention earlier, there are TOO many resources to mention and everyone has their favorites. Below are just a few that I like.

-   [R For Cats](http://rforcats.net/): Basic introduction site, meant to be a gentle and light-hearted introduction
-   [Advanced R](http://adv-r.had.co.nz/): Web home of Hadley Wickham's new book. Gets into more advanced topics, but also covers the basics in a great way.
-   [Other Resources](http://scicomp2014.edc.uri.edu/resources.html): A list I helped compile for a URI Class.
-   [CRAN Cheatsheets](http://cran.r-project.org/doc/contrib/Short-refcard.pdf): A good cheat sheet from the official source
-   [RStudio Cheatsheets](http://www.rstudio.com/resources/cheatsheets/): Additional cheat sheets from RStudio. I am especially fond of the data wrangling one.

The data frame
--------------

Simply put, a data structure is a way for programming languages to handle storing information. Like most languages, R has several structures (vectors, matrix, lists, etc.) but since R is built for data analysis the data frame, a spreadsheet like structure with rows and columns, is the most widely used and useful to learn first. In addition, the data frame (or is it data.frame) is the basis for many modern R pacakges (e.g. the tidyverse) and getting used to it will allow you to quickly build your R skills.

*Note:* It is useful to know more about the different data structures such as vectors, lists, and factors (a weird one that is for catergorical data). But that is beyond what we have time for. You can look at some of our [old materials](data_in_r.md) or even better look at what I think is the best source on this information, Hadley Wickham's [Data Structures Chapter in Advanced R](http://adv-r.had.co.nz/Data-structures.html).

### Build a data frame

Let's now take a quick look at building a simple data frame from scratch with the `data.frame()` function. This is mostly a teaching excercise as we will use the function very little in the excercises to come.

``` r
# Our first data frame

my_df <- data.frame(names = c("joe","jenny","bob","sue"), 
                    age = c(45, 27, 38,51), 
                    knows_r = c(FALSE, TRUE, TRUE,FALSE))
my_df
```

    ##   names age knows_r
    ## 1   joe  45   FALSE
    ## 2 jenny  27    TRUE
    ## 3   bob  38    TRUE
    ## 4   sue  51   FALSE

That created a data frame with 3 columns (names, age, knows\_r) and four rows. For each row we have some information on the name of an individual (stored as a character/string), their age (stored as a numeric value), and a column indicating if they know R or not (stored as a boolean/logical).

If you've worked with data before in a spreadsheet or from a table in a database, this rectangular structure should look somewhat familiar. One way (there are many!) we can access the different parts of the data frame is like:

``` r
# Use the dollar sign to get a column
my_df$age
```

    ## [1] 45 27 38 51

``` r
# Grab a row with indexing
my_df[2,]
```

    ##   names age knows_r
    ## 2 jenny  27    TRUE

At this point, we have:

-   built a data frame from scratch
-   seen rows and columns
-   heard about "rectangular" structure
-   seen how to get a row and a column

The purpose of all this was to introduce the concept of the data frame. Moving forward we will use other tools to read in data, but the end result will be the same: a data frame with rows (i.e. observations) and columns (i.e. variables).

### Reading external data

Completely creating a data frame from scratch is useful (especially when you start writing your own functions), but more often than not data is stored in an external file that you need to read into R. These may be delimited text files, spreadsheets, relational databases, SAS files ... You get the idea. Instead of treating this subject exhaustively, we will focus just on a single file type, `.csv` that is very commonly encountered and (usually) easy to create from other file types. For this, we will use `read.csv()`(although there are many, compelling options from packages like `rio` and `readr`).

`read.csv()` is a specialized version of `read.table()` that focuses on, big surprise here, .csv files. This command assumes a header row with column names and that the delimiter is a comma. The expected no data value is NA and by default, strings are converted to factors by default (this can trip people up). If you remember, we discussed earlier that we should explicitly define our factors. We will use `read.csv()`, with this defualt behaviour turned off.

Source files for `read.csv()` can either be on a local hard drive or, and this is pretty cool, on the web. We will be using the later for our examples and exercises. If you had a local file it would be accessed like `mydf <- read.csv("C:/path/to/local/file.csv")`. As an aside, paths and use of forward vs back slash is important. R is looking for forward slashes ("/"), or unix-like paths. You can use these in place of the back slash and be fine. You can use a back slash but it needs to be a double back slash (""). This is becuase the single backslash in an escape character that is used to indicate things like newlines or tabs.

Let's give it a try.

``` r
#Grab data from a web file
nla_url <- "https://www.epa.gov/sites/production/files/2014-10/nla2007_chemical_conditionestimates_20091123.csv"
nla_wq <- read.csv(nla_url,stringsAsFactors = FALSE)
head(nla_wq)
```

    ##         SITE_ID VISIT_NO SITE_TYPE      LAKE_SAMP    TNT   LAT_DD
    ## 1 NLA06608-0001        1 PROB_Lake Target_Sampled Target 48.97903
    ## 2 NLA06608-0002        1 PROB_Lake Target_Sampled Target 33.03606
    ## 3 NLA06608-0002        2 PROB_Lake Target_Sampled Target 33.03606
    ## 4 NLA06608-0003        1 PROB_Lake Target_Sampled Target 28.04774
    ## 5 NLA06608-0003        2 PROB_Lake Target_Sampled Target 28.04774
    ## 6 NLA06608-0004        1 PROB_Lake Target_Sampled Target 37.41662
    ##       LON_DD ST  EPA_REG AREA_CAT7 NESLAKE STRATUM   PANEL        DSGN_CAT
    ## 1 -114.02184 MT Region_8  (50,100]         NLALake Panel_1 WMT_MT_(50,100]
    ## 2  -79.98379 SC Region_4   (10,20]         NLALake Panel_1  CPL_SC_(10,20]
    ## 3  -79.98379 SC Region_4   (10,20]         NLALake Panel_1  CPL_SC_(10,20]
    ## 4  -97.85987 TX Region_6    (4,10]         NLALake Panel_1          (4,10]
    ## 5  -97.85987 TX Region_6    (4,10]         NLALake Panel_1          (4,10]
    ## 6 -108.40458 CO Region_8  (50,100]         NLALake Panel_1 WMT_CO_(50,100]
    ##       MDCATY       WGT    WGT_NLA ADJWGT_CAT URBAN WSA_ECO3 WSA_ECO9
    ## 1 0.02820818  35.10944   7.594532         MT    NO    WMTNS      WMT
    ## 2 0.00817201 121.19093  60.654227         SC   YES   PLNLOW      CPL
    ## 3 0.00817201 121.19093  60.654227         SC   YES   PLNLOW      CPL
    ## 4 0.00131289 754.34539 210.504940         TX   YES   PLNLOW      CPL
    ## 5 0.00131289 754.34539 210.504940         TX   YES   PLNLOW      CPL
    ## 6 0.04653754  21.28117   9.171940         CO   YES    WMTNS      WMT
    ##   ECO_LEV_3 NUT_REG
    ## 1        41      II
    ## 2        63     XIV
    ## 3        63     XIV
    ## 4        34       X
    ## 5        34       X
    ## 6        21      II
    ##                                               NUTREG_NAME ECO_NUTA
    ## 1                              Western Forested Mountains       II
    ## 2                                   Eastern Coastal Plain      CPL
    ## 3                                   Eastern Coastal Plain      CPL
    ## 4 Texas-Louisiana Coastal and Mississippi Alluvial Plains      CPL
    ## 5 Texas-Louisiana Coastal and Mississippi Alluvial Plains      CPL
    ## 6                              Western Forested Mountains       II
    ##   LAKE_ORIGIN   ECO3_X_ORIGIN REF_CLUSTER RT_NLA HUC_2    HUC_8 FLAG_INFO
    ## 1     NATURAL   WMTNS NATURAL           F    REF    10 10010001          
    ## 2    MAN-MADE PLNLOW MAN-MADE           D  SO-SO     3  3050201          
    ## 3    MAN-MADE PLNLOW MAN-MADE           D  SO-SO     3  3050201          
    ## 4     NATURAL  PLNLOW NATURAL           D  TRASH    12 12110111          
    ## 5     NATURAL  PLNLOW NATURAL           D  TRASH    12 12110111          
    ## 6    MAN-MADE  WMTNS MAN-MADE           G  SO-SO    14 14080202          
    ##   COMMENT_INFO SAMPLED SAMPLED_CHEM INDXSAMP_CHEM PTL NTL  TURB    ANC
    ## 1                  YES          YES           YES   6 151 0.474  924.3
    ## 2                  YES          YES           YES  36 695 3.550  104.5
    ## 3                  YES          YES            NO  22 469 3.870  103.1
    ## 4                  YES          YES           YES  43 738 7.670 4746.0
    ## 5                  YES          YES            NO  50 843 9.530 4784.4
    ## 6                  YES          YES           YES  18 344 3.810 1656.4
    ##     DOC COND SAMPLED_CHLA INDXSAMP_CHLA  CHLA                   PTL_COND
    ## 1  0.63   96          YES           YES  0.24          1:LEAST DISTURBED
    ## 2 14.02   45          YES           YES  3.84 2:INTERMEDIATE DISTURBANCE
    ## 3 13.69   43          YES            NO 20.88          1:LEAST DISTURBED
    ## 4  6.00 1089          YES           YES 16.96 2:INTERMEDIATE DISTURBANCE
    ## 5  5.87 1120          YES            NO 12.86 2:INTERMEDIATE DISTURBANCE
    ## 6  8.00  303          YES           YES  4.60 2:INTERMEDIATE DISTURBANCE
    ##                     NTL_COND         CHLA_COND                  TURB_COND
    ## 1          1:LEAST DISTURBED 1:LEAST DISTURBED          1:LEAST DISTURBED
    ## 2 2:INTERMEDIATE DISTURBANCE 1:LEAST DISTURBED          1:LEAST DISTURBED
    ## 3          1:LEAST DISTURBED 1:LEAST DISTURBED          1:LEAST DISTURBED
    ## 4 2:INTERMEDIATE DISTURBANCE 1:LEAST DISTURBED 2:INTERMEDIATE DISTURBANCE
    ## 5 2:INTERMEDIATE DISTURBANCE 1:LEAST DISTURBED 2:INTERMEDIATE DISTURBANCE
    ## 6 2:INTERMEDIATE DISTURBANCE  3:MOST DISTURBED 2:INTERMEDIATE DISTURBANCE
    ##            ANC_COND     SALINITY_COND
    ## 1 1:LEAST DISTURBED 1:LEAST DISTURBED
    ## 2 1:LEAST DISTURBED 1:LEAST DISTURBED
    ## 3 1:LEAST DISTURBED 1:LEAST DISTURBED
    ## 4 1:LEAST DISTURBED  3:MOST DISTURBED
    ## 5 1:LEAST DISTURBED  3:MOST DISTURBED
    ## 6 1:LEAST DISTURBED 1:LEAST DISTURBED

``` r
str(nla_wq)
```

    ## 'data.frame':    1252 obs. of  51 variables:
    ##  $ SITE_ID      : chr  "NLA06608-0001" "NLA06608-0002" "NLA06608-0002" "NLA06608-0003" ...
    ##  $ VISIT_NO     : int  1 1 2 1 2 1 2 1 2 1 ...
    ##  $ SITE_TYPE    : chr  "PROB_Lake" "PROB_Lake" "PROB_Lake" "PROB_Lake" ...
    ##  $ LAKE_SAMP    : chr  "Target_Sampled" "Target_Sampled" "Target_Sampled" "Target_Sampled" ...
    ##  $ TNT          : chr  "Target" "Target" "Target" "Target" ...
    ##  $ LAT_DD       : num  49 33 33 28 28 ...
    ##  $ LON_DD       : num  -114 -80 -80 -97.9 -97.9 ...
    ##  $ ST           : chr  "MT" "SC" "SC" "TX" ...
    ##  $ EPA_REG      : chr  "Region_8" "Region_4" "Region_4" "Region_6" ...
    ##  $ AREA_CAT7    : chr  "(50,100]" "(10,20]" "(10,20]" "(4,10]" ...
    ##  $ NESLAKE      : chr  "" "" "" "" ...
    ##  $ STRATUM      : chr  "NLALake" "NLALake" "NLALake" "NLALake" ...
    ##  $ PANEL        : chr  "Panel_1" "Panel_1" "Panel_1" "Panel_1" ...
    ##  $ DSGN_CAT     : chr  "WMT_MT_(50,100]" "CPL_SC_(10,20]" "CPL_SC_(10,20]" "(4,10]" ...
    ##  $ MDCATY       : num  0.02821 0.00817 0.00817 0.00131 0.00131 ...
    ##  $ WGT          : num  35.1 121.2 121.2 754.3 754.3 ...
    ##  $ WGT_NLA      : num  7.59 60.65 60.65 210.5 210.5 ...
    ##  $ ADJWGT_CAT   : chr  "MT" "SC" "SC" "TX" ...
    ##  $ URBAN        : chr  "NO" "YES" "YES" "YES" ...
    ##  $ WSA_ECO3     : chr  "WMTNS" "PLNLOW" "PLNLOW" "PLNLOW" ...
    ##  $ WSA_ECO9     : chr  "WMT" "CPL" "CPL" "CPL" ...
    ##  $ ECO_LEV_3    : int  41 63 63 34 34 21 21 16 16 59 ...
    ##  $ NUT_REG      : chr  "II" "XIV" "XIV" "X" ...
    ##  $ NUTREG_NAME  : chr  "Western Forested Mountains" "Eastern Coastal Plain" "Eastern Coastal Plain" "Texas-Louisiana Coastal and Mississippi Alluvial Plains" ...
    ##  $ ECO_NUTA     : chr  "II" "CPL" "CPL" "CPL" ...
    ##  $ LAKE_ORIGIN  : chr  "NATURAL" "MAN-MADE" "MAN-MADE" "NATURAL" ...
    ##  $ ECO3_X_ORIGIN: chr  "WMTNS NATURAL" "PLNLOW MAN-MADE" "PLNLOW MAN-MADE" "PLNLOW NATURAL" ...
    ##  $ REF_CLUSTER  : chr  "F" "D" "D" "D" ...
    ##  $ RT_NLA       : chr  "REF" "SO-SO" "SO-SO" "TRASH" ...
    ##  $ HUC_2        : int  10 3 3 12 12 14 14 17 17 1 ...
    ##  $ HUC_8        : int  10010001 3050201 3050201 12110111 12110111 14080202 14080202 17060201 17060201 1100005 ...
    ##  $ FLAG_INFO    : chr  "" "" "" "" ...
    ##  $ COMMENT_INFO : chr  "" "" "" "" ...
    ##  $ SAMPLED      : chr  "YES" "YES" "YES" "YES" ...
    ##  $ SAMPLED_CHEM : chr  "YES" "YES" "YES" "YES" ...
    ##  $ INDXSAMP_CHEM: chr  "YES" "YES" "NO" "YES" ...
    ##  $ PTL          : int  6 36 22 43 50 18 46 4 3 7 ...
    ##  $ NTL          : int  151 695 469 738 843 344 596 85 68 184 ...
    ##  $ TURB         : num  0.474 3.55 3.87 7.67 9.53 3.81 7.33 0.475 0.609 0.901 ...
    ##  $ ANC          : num  924 104 103 4746 4784 ...
    ##  $ DOC          : num  0.63 14.02 13.69 6 5.87 ...
    ##  $ COND         : int  96 45 43 1089 1120 303 327 53 55 75 ...
    ##  $ SAMPLED_CHLA : chr  "YES" "YES" "YES" "YES" ...
    ##  $ INDXSAMP_CHLA: chr  "YES" "YES" "NO" "YES" ...
    ##  $ CHLA         : num  0.24 3.84 20.88 16.96 12.86 ...
    ##  $ PTL_COND     : chr  "1:LEAST DISTURBED" "2:INTERMEDIATE DISTURBANCE" "1:LEAST DISTURBED" "2:INTERMEDIATE DISTURBANCE" ...
    ##  $ NTL_COND     : chr  "1:LEAST DISTURBED" "2:INTERMEDIATE DISTURBANCE" "1:LEAST DISTURBED" "2:INTERMEDIATE DISTURBANCE" ...
    ##  $ CHLA_COND    : chr  "1:LEAST DISTURBED" "1:LEAST DISTURBED" "1:LEAST DISTURBED" "1:LEAST DISTURBED" ...
    ##  $ TURB_COND    : chr  "1:LEAST DISTURBED" "1:LEAST DISTURBED" "1:LEAST DISTURBED" "2:INTERMEDIATE DISTURBANCE" ...
    ##  $ ANC_COND     : chr  "1:LEAST DISTURBED" "1:LEAST DISTURBED" "1:LEAST DISTURBED" "1:LEAST DISTURBED" ...
    ##  $ SALINITY_COND: chr  "1:LEAST DISTURBED" "1:LEAST DISTURBED" "1:LEAST DISTURBED" "3:MOST DISTURBED" ...

``` r
dim(nla_wq)
```

    ## [1] 1252   51

``` r
summary(nla_wq)
```

    ##    SITE_ID             VISIT_NO      SITE_TYPE          LAKE_SAMP        
    ##  Length:1252        Min.   :1.000   Length:1252        Length:1252       
    ##  Class :character   1st Qu.:1.000   Class :character   Class :character  
    ##  Mode  :character   Median :1.000   Mode  :character   Mode  :character  
    ##                     Mean   :1.076                                        
    ##                     3rd Qu.:1.000                                        
    ##                     Max.   :2.000                                        
    ##                                                                          
    ##      TNT                LAT_DD          LON_DD             ST           
    ##  Length:1252        Min.   :26.94   Min.   :-124.63   Length:1252       
    ##  Class :character   1st Qu.:37.17   1st Qu.:-104.72   Class :character  
    ##  Mode  :character   Median :41.36   Median : -94.65   Mode  :character  
    ##                     Mean   :40.61   Mean   : -94.67                     
    ##                     3rd Qu.:44.71   3rd Qu.: -84.59                     
    ##                     Max.   :48.98   Max.   : -67.70                     
    ##                                                                         
    ##    EPA_REG           AREA_CAT7           NESLAKE         
    ##  Length:1252        Length:1252        Length:1252       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##                                                          
    ##                                                          
    ##                                                          
    ##                                                          
    ##    STRATUM             PANEL             DSGN_CAT        
    ##  Length:1252        Length:1252        Length:1252       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##                                                          
    ##                                                          
    ##                                                          
    ##                                                          
    ##      MDCATY              WGT             WGT_NLA         ADJWGT_CAT       
    ##  Min.   :0.000000   Min.   :  0.000   Min.   :  0.000   Length:1252       
    ##  1st Qu.:0.008009   1st Qu.:  7.834   1st Qu.:  3.186   Class :character  
    ##  Median :0.029694   Median : 19.709   Median :  8.555   Mode  :character  
    ##  Mean   :0.055412   Mean   : 86.753   Mean   : 43.452                     
    ##  3rd Qu.:0.096820   3rd Qu.: 63.500   3rd Qu.: 33.170                     
    ##  Max.   :0.759758   Max.   :770.316   Max.   :724.887                     
    ##                                                                           
    ##     URBAN             WSA_ECO3           WSA_ECO9           ECO_LEV_3    
    ##  Length:1252        Length:1252        Length:1252        Min.   : 1.00  
    ##  Class :character   Class :character   Class :character   1st Qu.:27.00  
    ##  Mode  :character   Mode  :character   Mode  :character   Median :46.00  
    ##                                                           Mean   :44.15  
    ##                                                           3rd Qu.:58.00  
    ##                                                           Max.   :84.00  
    ##                                                                          
    ##    NUT_REG          NUTREG_NAME          ECO_NUTA        
    ##  Length:1252        Length:1252        Length:1252       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##                                                          
    ##                                                          
    ##                                                          
    ##                                                          
    ##  LAKE_ORIGIN        ECO3_X_ORIGIN      REF_CLUSTER       
    ##  Length:1252        Length:1252        Length:1252       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##                                                          
    ##                                                          
    ##                                                          
    ##                                                          
    ##     RT_NLA              HUC_2            HUC_8           FLAG_INFO        
    ##  Length:1252        Min.   : 1.000   Min.   : 1010002   Length:1252       
    ##  Class :character   1st Qu.: 4.000   1st Qu.: 4050002   Class :character  
    ##  Mode  :character   Median : 9.000   Median : 9020103   Mode  :character  
    ##                     Mean   : 8.458   Mean   : 8529963                     
    ##                     3rd Qu.:11.000   3rd Qu.:11130303                     
    ##                     Max.   :18.000   Max.   :18100200                     
    ##                                                                           
    ##  COMMENT_INFO         SAMPLED          SAMPLED_CHEM      
    ##  Length:1252        Length:1252        Length:1252       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##                                                          
    ##                                                          
    ##                                                          
    ##                                                          
    ##  INDXSAMP_CHEM           PTL               NTL             TURB        
    ##  Length:1252        Min.   :   1.00   Min.   :    5   Min.   :  0.147  
    ##  Class :character   1st Qu.:   9.00   1st Qu.:  309   1st Qu.:  1.390  
    ##  Mode  :character   Median :  25.00   Median :  574   Median :  3.655  
    ##                     Mean   : 112.09   Mean   : 1177   Mean   : 12.993  
    ##                     3rd Qu.:  89.25   3rd Qu.: 1174   3rd Qu.: 10.800  
    ##                     Max.   :4865.00   Max.   :26100   Max.   :574.000  
    ##                                                                        
    ##       ANC               DOC               COND         SAMPLED_CHLA      
    ##  Min.   :  -63.0   Min.   :  0.340   Min.   :    4.0   Length:1252       
    ##  1st Qu.:  506.8   1st Qu.:  3.337   1st Qu.:   87.0   Class :character  
    ##  Median : 1722.2   Median :  5.450   Median :  241.5   Mode  :character  
    ##  Mean   : 2680.4   Mean   :  8.881   Mean   :  688.5                     
    ##  3rd Qu.: 2998.4   3rd Qu.:  8.525   3rd Qu.:  465.2                     
    ##  Max.   :91632.9   Max.   :290.570   Max.   :50590.0                     
    ##                                                                          
    ##  INDXSAMP_CHLA           CHLA          PTL_COND           NTL_COND        
    ##  Length:1252        Min.   :  0.07   Length:1252        Length:1252       
    ##  Class :character   1st Qu.:  2.87   Class :character   Class :character  
    ##  Mode  :character   Median :  7.60   Mode  :character   Mode  :character  
    ##                     Mean   : 29.25                                        
    ##                     3rd Qu.: 25.45                                        
    ##                     Max.   :936.00                                        
    ##                     NA's   :5                                             
    ##   CHLA_COND          TURB_COND           ANC_COND        
    ##  Length:1252        Length:1252        Length:1252       
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##                                                          
    ##                                                          
    ##                                                          
    ##                                                          
    ##  SALINITY_COND     
    ##  Length:1252       
    ##  Class :character  
    ##  Mode  :character  
    ##                    
    ##                    
    ##                    
    ## 

Take note of the argument we used on `read.csv()`. The `stringsAsFactors = FALSE` is what we want to use to make sure factors are not getting automatically created.

### Other ways to read data

Although, `read.csv()` and `read.table()` are very flexible, they are not the only options for reading in data. This could be a full day in and of itself, but packages like `readr`, `readxl`, and `rio` provide flexible methods for reading in data. Also, databases can also be accessed directly in R and much of this functionality is in the `DBI` and `RODBC` packages. Making the connections is not entirely trivial, but an easier way to take advantage of this is via the `dplyr` package. See the [vignette on databases](https://cran.r-project.org/web/packages/dplyr/vignettes/databases.html) fo a lot of good examples of working with common open source databases.

Exercise 2
----------

From here on out I hope to have the exercises will build on each other. For this exercise we are going to grab some data, look at that data, and be able to describe some basic information about that dataset. The data we are using is the 2010 National Coastal Conidition Assessment from EPA's Office of Water. URL's for those files are included below.

1.  We will be using a new script for the rest of our exercises. Create this script in RStudio and name it "nca\_analysis.R"
2.  As you write the script, comment as you go. Some good examples are what we used in the first script where we provided some details on each of the exercises. Remember comments are lines that begin with `#` and you can put whatever you like after that.
3.  Add some lines to your script that creates two data frames. One named `nca_sites` and the other names `nca_wc`. These are in the `data` folder you downloaded and we moved earlier. The `read.csv` function is your friend here and the paths to the two files are `"data/nca_2010_siteinfo.csv"` and `"data/nca_2010_waterchem.csv"`.
4.  Now run your script and make sure it doesn't throw any errors and you do in fact get a data frame.
5.  Explore the data frame using some of the functions we covered above (e.g. `head()`,`summary()`, or `str()`). This part does not need to be included in the script and can be done directly inthe console. It is just a quick QA step to be sure the data read in as expected.
