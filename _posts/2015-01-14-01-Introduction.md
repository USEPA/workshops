---
title: "01 - Introduction to R: The basics"
author: Jeffrey W. Hollister
layout: post_page
---



Over the course of the next two days we are going to walk through a typical data analysis workflow in R.  But, with this first lesson we are going to focus on making sure everything is working and get some basic orientation in R.  The real fun will start in the lessons to come.  

##Quick Links to Exercises and R code
My goal is to have this workshop be as hands-on as possible.  As such, there are exercises through out.  For each lesson, I will provide a list of links near the top of the post so that you can skip all the prose and jump straight to the lessons.  So, here are the links for Lesson 1.

- [Lesson 1 R Code](/introR/rmd_posts/2015-01-14-01-Introduction.R): All the code from this post in an R Script.
- [Exercise 1](#exercise-1): RStudio Introduction.
- [Exercise 2](#exercise-2): Functions, packages, and help

##Lesson Goals
- Understand what R is and what it can be used for
- Why would you choose R over another tool
- Troubleshoot software installs (keep your fingers crossed)
- Gain familiarity with using R from within the RStudio IDE
- Get to know the basic syntax of R functions
- Be able to install and load a package into your R library
- Know how to get help

##What is R and why use it
R is an open source language and environment for data analysis, statistics, and visualization.  This is the typical definition.  I would argue that R has evolved a bit and is now, more and more, also a general purpose computing language.  It is very widely used in academia and industry for statistics, visualization, data science, and general purpose computation.  In short, the answer to the question to, "Can you do that in R" is almost always yes.  R may not be the best answer, but it is an accurate one.  

The primary reason R is widely used is that it is free, has a large and vibrant community, it is easily extensible, and back to that question, yes you can do that in R!  More to the point, in the environmental sciences R is able to handle any data management, analysis or visualization task that you would need to accomplish and it has capabilities to provide a fully reproducible analysis. 

Lastly, R has almost become the standard for any data analysis or visualization task.  A great site [r4stats.com](http://r4stats.com) has an [article](http://r4stats.com/articles/popularity/) on data analysis software popularity that is kept update on the relative popularity of different languages.  One striking figure is the comparison of links to the main pages of the different languages:

[![r4stats.com web site link graph](http://r4stats.files.wordpress.com/2012/04/fig_8_websitelinks.png?w=640&h=689)](http://r4stats.com/articles/popularity/)

<caption align="bottom">source: r4stats.com - The Popularity of Data Analysis Software </caption>

If read this article you certainly get the sense that R is one of the top languages and trends all favor its continued growth while other popular software (SAS, SPSS, etc.) are seeing decline.

##Getting R and RStudio going
Over the last several years, RStudio has become a very popular IDE (integrated development environment) for R.  In addition to interacting with the R Console, RStudio has many extras built in including version control integration, package building, reproducible research, de-bugging, and built-in text editor with smart highlighting and code completion.  This is the environment we will be using for the two days and should set you up for continued learning with R.

##Exercise 1
This exercise will make sure R and RStudio are working and that you can get around the basics in RStudio.  Use the green stickies when you have completed, and red stickies if you are running into problems.

1. Start RStudio: To start both R and RStudio requires only firing up RStudio.  RStudio should be available from All Programs at the Start Menu.  Fire up RStudio. You should have done this already (see [post 00](/introR/2015/01/14/00-Before-The-Workshop/)).

2. Take a few minutes to look around RStudio.  Find the Console Pane. Find Global and Project Options (hint: look in Tools).  Look at the Environment, History Pane.  Look at the Files, Plots, Packages ... pane.

3. Create a new project.  Name is "gedr_workshop".  We will use this for the rest of the workshop.

4. Create a new "R Script"" in the Source Pane, save that file into your newly created project and name it "lesson1.R". 

5. Download [Lesson 1 R Code](/introR/rmd_posts/2015-01-14-01-Introduction.R) and save it to your project.

##Using functions
R is built off of functions and most of everything you do will use a function.

The basic syntax of function follows the form: `function_name(param1, param2, ...)`.  With the base install, you will gain access to many.  For instance:


{% highlight r %}
#Print
print("hello world!")
{% endhighlight %}



{% highlight text %}
## [1] "hello world!"
{% endhighlight %}



{% highlight r %}
#A sequence
seq(1,10)
{% endhighlight %}



{% highlight text %}
##  [1]  1  2  3  4  5  6  7  8  9 10
{% endhighlight %}



{% highlight r %}
#Random normal numbers
rnorm(100,mean=10,sd=2)
{% endhighlight %}



{% highlight text %}
##   [1]  9.428537 12.192949  3.941532  9.256546  8.696833 11.077342 13.930553
##   [8]  9.787077 11.222469 12.922915  9.928866 13.594624  9.610475 11.991406
##  [15]  6.464563  8.311447 10.173608  8.716995  8.708291  9.427993 13.049252
##  [22] 10.679197  8.120219  5.591127  8.021306 11.680883 12.053075  8.451959
##  [29]  6.445835 10.672541  9.835059  4.613852 10.481308  6.366834 12.027403
##  [36] 11.031621 11.488733  9.102950  7.169140  9.506038 11.829922  9.952907
##  [43] 10.643566 11.171273  9.835628 11.353844  8.896099 13.125384  8.282723
##  [50]  7.141227 11.337495  9.467282  8.784670  9.245472  9.019832  8.865711
##  [57] 10.999561  8.664285 11.577300 10.162121  7.017972 10.249797 10.683567
##  [64]  9.003053 10.585503  8.415749  9.918933 11.361721 10.954545  8.939700
##  [71]  6.270322 11.504973 12.699026 12.277663 12.673781  8.107007  9.215161
##  [78]  8.700720  7.567847 11.720286 11.351083  8.039061  6.986090 11.690100
##  [85] 11.080663  7.507857  9.326296  5.381702  8.840844 10.540916  9.438831
##  [92]  9.745547  9.495756 11.787255  8.366543  9.184629 10.297360  9.343943
##  [99] 11.388941 12.517871
{% endhighlight %}



{% highlight r %}
#Mean
mean(rnorm(100))
{% endhighlight %}



{% highlight text %}
## [1] 0.05279571
{% endhighlight %}

As an aside, the `#` indicates a comment.  You can put whatever else you'd like on the line after this.  R will not evaluate it.  When commenting your code, err on the side of too much!

##Using packages
The base install of R is quite powerful, but you will soon have a need or desire to go beyond this.  Packages provide this ability.  They are a standardized method for extending R with new methods, techniques, and programming functionality.  There is a lot to say about packages regarding finding them, using them, etc., but for now let's focus just on the basics.  

###CRAN
One of the reasons for R's popularity is CRAN, [The Comprehensive R Archive Network](http://cran.r-project.org/).  This is where you download R and also where most will gain access to packages (there are other places, but that is for later).  Not much else to say about this now other than to be aware or it.

###Installing packages
When a packages gets installed, that means the source (or packaged binary for Windows) is downloaded and put into your library.  A default library location is set for you so no need to worry about that.  In fact on Windows most of this is pretty automatic.  Let's give it a shot.



{% highlight r %}
#Install dplyr and ggplot2
install.packages("ggplot2")
{% endhighlight %}



{% highlight text %}
## Installing package into '/data/jhollist/R/x86_64-redhat-linux-gnu-library/3.1'
## (as 'lib' is unspecified)
{% endhighlight %}



{% highlight text %}
## 
## The downloaded source packages are in
## 	'/tmp/RtmpFFMvXl/downloaded_packages'
{% endhighlight %}



{% highlight r %}
install.packages("dplyr")
{% endhighlight %}



{% highlight text %}
## Installing package into '/data/jhollist/R/x86_64-redhat-linux-gnu-library/3.1'
## (as 'lib' is unspecified)
{% endhighlight %}



{% highlight text %}
## 
## The downloaded source packages are in
## 	'/tmp/RtmpFFMvXl/downloaded_packages'
{% endhighlight %}



{% highlight r %}
#You can also put more than one in like
install.packages(c("randomForest","formatR"))
{% endhighlight %}



{% highlight text %}
## Installing packages into '/data/jhollist/R/x86_64-redhat-linux-gnu-library/3.1'
## (as 'lib' is unspecified)
{% endhighlight %}



{% highlight text %}
## 
## The downloaded source packages are in
## 	'/tmp/RtmpFFMvXl/downloaded_packages'
{% endhighlight %}

###Loading packages
One source of confusion that many have is when they cannot access a package that they just installed. This is because getting to this point requires an extra step, loading (or attaching) the package.   


{% highlight r %}
#Add libraries to your R Session
library("ggplot2")
{% endhighlight %}



{% highlight text %}
## Loading required package: methods
{% endhighlight %}



{% highlight r %}
library("dplyr")
{% endhighlight %}



{% highlight text %}
## 
## Attaching package: 'dplyr'
## 
## The following object is masked from 'package:stats':
## 
##     filter
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
{% endhighlight %}



{% highlight r %}
#You can also access functions in a library by using package::function
randomForest::randomForest
{% endhighlight %}



{% highlight text %}
## function (x, ...) 
## UseMethod("randomForest")
## <environment: namespace:randomForest>
{% endhighlight %}

You will often see people use `require` to load a package. It is better form to not do this. For a more detailed explanation of why `library()` and not `require()` see [Yihui Xie's post on the subject](http://yihui.name/en/2014/07/library-vs-require/.)

###Some other useful commands
There are a lot of other commands that help you navigate packages


{% highlight r %}
#See what is installed
installed.packages()

#What packages are available?
available.packages()

#Update
update.packages()
{% endhighlight %}

##Help!
Being able to find help and interpret that help is probably one of the most important skills for learning a new language.  R is no different. Help on functions and packages can be accessed directly from R, can be found on CRAN and other official R resources, searched on Google, found on StackOverflow, or from any number of fantastic online resources. I will cover a few of these here. 

###Help from the console
Getting help from the console is straightforward and can be done numerous ways.


{% highlight r %}
#Using the help command/shortcut
help("print") #Help on the print command
?print #Help on the print command using the `?` shortcut
help(package="dplyr") #Help on the package `dplyr`

#Don't know the exact name or just part of it
apropos("print") #Returns all available functions with "print" in the name
??print #Shortcut, but also searches demos and vignettes in a formatted page
{% endhighlight %}

###Official R Resources
In addition to help from with R itself, CRAN and the R-Project have many resources available for support.  Two of the most notable are the mailing lists and the [task views](http://cran.r-project.org/web/views/).

- [R Help Mailing List](https://stat.ethz.ch/mailman/listinfo/r-help): The main mailing list for R help.  Can be a bit daunting and some senior folks can be, um, curmudgeonly...
- [R-sig-ecology](https://stat.ethz.ch/mailman/listinfo/r-sig-ecology): A special interest group for use of R in ecology.  Less daunting the the main help with participation form some big names in ecological modelling (Ben Bolker and Gavin Simpson).  One of the moderators is great, the other is a bit of a jerk (it's me).
- [Environmetrics Task View](http://cran.r-project.org/web/views/Environmetrics.html): Task views are great in that the provided an annotated list of packages relevant to a particular field.  This one is maintained by Gavin Simpson and has great info on packages relevant to much of the work at EPA.
- [Spatial Analysis Task View](http://cran.r-project.org/web/views/Spatial.html): One I use a lot that lists all the relevant packages for spatial analysis, GIS, and Remote Sensing in R. 

###Google and StackOverflow
While the resources already mentioned are useful, often the quickest way is to just turn to Google.  However, a search for "R" is a bit challenging.  A few ways around this.  Google works great if you search of a given package.  You can search for mailing lists directly (i.e. "R-sig-geo").  An R specific search tool, [RSeek.org](http://www.rseek.org/), has been created to facilitate this.  

One specific resource that I use quite a bit is [StackOverflow with the 'r' tag](http://stackoverflow.com/questions/tagged/r).  StackOverflow is a discussion forum for all things related to programming.  You can then use this tag and the search functions in StackOverflow and find answers to almost anything you can think of.

###Other Resources
As I mention earlier, there are TOO many resources to mention and everyone has their favorites.  Below are just a few that I like.

- [R For Cats](http://rforcats.net/): Basic introduction site, meant to be a gentle and light-hearted introduction
- [Advanced R](http://adv-r.had.co.nz/): Web home of Hadley Wickham's new book.  Gets into more advanced topics, but also covers the basics in a great way.
- [Why R is Hard To Learn](http://r4stats.com/articles/why-r-is-hard-to-learn/): Long and detailed blog post discussing some of the challenges people often face when learning R.
- [Other Resources](http://scicomp2014.edc.uri.edu/resources.html): A list I helped compile for a URI Class.


##Exercise 2
For this second exercise we are going to get used to using some basic functions, working with scripts and not just the console, and look through some task views and get used to basic navigation around packages.  Use the green stickies when you have completed, and red stickies if you are running into problems.

1. If it is not already open, open the "lesson1.R" file you created in Exercise 1. Enter your commands into this script, save it, and run it.
2. Use the `print` function to print something to the screen.
3. Combine `mean` and `rnorm` to return the mean value of a set of random numbers.
4. Open up a [task view](http://cran.r-project.org/web/views/) of your choosing.  Select a package and install it. 
5. Load the library.
6. Open the help for the package.
7. Remember all of these functions should be saved inside your "lesson1.R" script.




