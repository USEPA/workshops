---
title: "09 - Repeat and Reproduce"
author: Jeffrey W. Hollister
layout: post_page
---


In theory, you now have a basic understanding of how to conduct a typical data analysis workflow in R.  All that is left is to be able to write it up in such a way that others can not only understand what we did, but repeat it exactly on their own machines. To do this effectively we need to understand how to create reusable R code and create reproducible reports.  This will be a very high level introduction to both concepts, but should hopefully give you a jumping off place for more learning.

##Quick Links to Exercises and R code
- [Lesson 9 R Code](/gedr/rmd_posts/2015-01-14-09-Repeat-Reproduce.R): All the code from this post in an R Script.
- [Exercise 1](#exercise-1): Create your own function
- [Exercise 2](#exercise-2): Use Rstudio and markdown for reproducible documents

##Lesson Goals
- Understand how to create your own functions
- Be able to use basic programming control structures
- Gain familiarity with Markdown and `knitr`
- Create a simple, reproducible document and presentation

##Functions and Programming with R
At this point we should be pretty well versed at using functions.  They have a name, some arguments, and they do something.  Some return a value, some don't.  In short they form the basic structure of R.  One of the cool thing about R (and programming in general), is that we are not stuck with the functions provided to us.  We can (and should!) develop our own as we often want to do things repeatedly, and in slightly different contexts.  Creating a function to deal with this fact helps us a great deal becuase we do not have to repeat ourselves, we can just use what we have already written.  Creating a function is really easy.  We use the `function()` function.  It has the basic structure of 

```
function_name<-function(arguments){
  code goes here
  use arguments as needed
}
```
So a real example, without arguments might look like:


{% highlight r %}
hw<-function(){
  print("Hello, World")
}

hw()
{% endhighlight %}



{% highlight text %}
## [1] "Hello, World"
{% endhighlight %}

Well that's nice...  Not really useful, but shows the main components, `function()`, and the `{}` which are really the only new things.

It would be a bit better if it were more flexible.  We can do that becuase we can specify our own arguments to use within the body of the function.  For example,


{% highlight r %}
p<-function(my_text){
  print(my_text)
}

p("Hello, world")
{% endhighlight %}



{% highlight text %}
## [1] "Hello, world"
{% endhighlight %}



{% highlight r %}
p("Hola, mundo")
{% endhighlight %}



{% highlight text %}
## [1] "Hola, mundo"
{% endhighlight %}



{% highlight r %}
p("Howdy, Texas")
{% endhighlight %}



{% highlight text %}
## [1] "Howdy, Texas"
{% endhighlight %}

So, this is of course a silly example.  Functions are useful when we want to combine many other functions together that do something useful that we might want to repeat.  Since we have been working most recently with creating plots, I could imagine us wanting to create a plot with a similar layout, but with different source data and then save that plot to a file, all with a single function call.  That might look like:


{% highlight r %}
myplot<-function(x,y,grp,file){
  my_p<-ggplot(data.frame(x,y,grp),aes(x=x,y=y)) +
            geom_point(aes(color=grp, shape=grp),size=5) +
            geom_smooth(method="lm",aes(colour=grp))+
            labs(x=substitute(x),y=substitute(y))
  ggsave(my_p,file=file)
  return(my_p)
}

myplot(iris$Petal.Length,iris$Petal.Width,iris$Species,"petal_petal.jpg")
{% endhighlight %}



{% highlight text %}
## Saving 7 x 7 in image
{% endhighlight %}

![plot of chunk plot_function_examp]({{ site.url }}/figure/plot_function_examp-1.png) 

{% highlight r %}
myplot(iris$Sepal.Length,iris$Sepal.Width,iris$Species,"sepal_l_petal_w.jpg")
{% endhighlight %}



{% highlight text %}
## Saving 7 x 7 in image
{% endhighlight %}

![plot of chunk plot_function_examp]({{ site.url }}/figure/plot_function_examp-2.png) 

Cool, a function, that does something useful.  It still is just a collection of functions at this point though.  What if we wanted to repeat something or have the function make some decisions and do one thing given a set of criteria and something else for a different set?  Well we need to look more at some of the classic programming structures in R.  For this introduction, I am going to look just at `if-else` statements, `for` loops (some in the R world think this to be bad since R is optimized for working on vectors, but I think the concept useful and I M writing this, so there!),  and `return()`.  

###if-else
If you have done any programing in any language, then `if-else` statements are not new to you.  All they do is allow us to tell the function how to make some decisions.  

I will show the examples in the context of a function as that is how they are most commonly used. So, we can implement them in R like:


{% highlight r %}
odd_even<-function(num){
  if(num %% 2 == 0){
    print("EVEN")
  } else {
    print("ODD")
  }
}

odd_even(27)
{% endhighlight %}



{% highlight text %}
## [1] "ODD"
{% endhighlight %}



{% highlight r %}
odd_even(34)
{% endhighlight %}



{% highlight text %}
## [1] "EVEN"
{% endhighlight %}

And you can you use multiple `if` statements


{% highlight r %}
plus_minus<-function(num){
  if(num>0){
    print("plus")
  } else if (num < 0) {
    print("minus")
  } else {
    print("zero")
  }
}
 
plus_minus(198)
{% endhighlight %}



{% highlight text %}
## [1] "plus"
{% endhighlight %}



{% highlight r %}
plus_minus(-44)
{% endhighlight %}



{% highlight text %}
## [1] "minus"
{% endhighlight %}



{% highlight r %}
plus_minus(37*0)
{% endhighlight %}



{% highlight text %}
## [1] "zero"
{% endhighlight %}

###for
A `for` loop allows you to repeat code.  You specify a variable and a range of values and the `for` loop runs the code for each value in your range.  The basic structure looks like:

```
for(a_name in a_range){
 code you want to run
 may or may not use a_name
}
```

And and example in a function.


{% highlight r %}
sum_vec<-function(vec){
  j<-0
  for(i in vec){
    j<-i+j
    print(j)
  }
}

sum_vec(1:2)
{% endhighlight %}



{% highlight text %}
## [1] 1
## [1] 3
{% endhighlight %}



{% highlight r %}
sum_vec(1:10)
{% endhighlight %}



{% highlight text %}
## [1] 1
## [1] 3
## [1] 6
## [1] 10
## [1] 15
## [1] 21
## [1] 28
## [1] 36
## [1] 45
## [1] 55
{% endhighlight %}

Again a bit of a silly example since all it is doing is looping through a list of values and summing it.  In reality you would just use `sum()`.  This also highlights the fact that loops in R are slow compared to vector operations and/or base operations.  We can see what the problem is if we look at a large vector and the time it takes to get the sum.  First let's ammend the function so that it only prints the answer.  Printing on each iteration of the loop was just to show it looping...


{% highlight r %}
sum_vec<-function(vec){
  j<-0
  for(i in vec){
    j<-i+j
  }
  print(j)
}

sum_vec(1:10)
{% endhighlight %}



{% highlight text %}
## [1] 55
{% endhighlight %}

Now that we have two functions that work the same, lets check the timing.


{% highlight r %}
large_vec<-as.numeric(1:5000000)
#Same Answer...
sum(large_vec)
{% endhighlight %}



{% highlight text %}
## [1] 1.25e+13
{% endhighlight %}



{% highlight r %}
sum_vec(large_vec)
{% endhighlight %}



{% highlight text %}
## [1] 1.25e+13
{% endhighlight %}



{% highlight r %}
#Different speed
system.time(sum(large_vec))
{% endhighlight %}



{% highlight text %}
##    user  system elapsed 
##   0.006   0.000   0.006
{% endhighlight %}



{% highlight r %}
system.time(sum_vec(large_vec))
{% endhighlight %}



{% highlight text %}
## [1] 1.25e+13
{% endhighlight %}



{% highlight text %}
##    user  system elapsed 
##   1.599   0.000   1.601
{% endhighlight %}

Here we can see the difference.  In this case the `sum()` is several hundred times faster! 

In short, if there is an obvious vectorized/base solution (in this case the sum()), use that.  If you need to use a loop, use that.  There are plenty of examples where a vectorized solution exists for a loop, but it may be difficult to code and understand.  I believe it is possible to go too far down the vectorized path.  Do it when it makes sense, otherwise take advantage of the for loop!

###return
The last control structure we are going to talk about is `return()`.  All `return()` does is provides a result from a function and terminates the function.  You may be asking yourself, didn't we get terminate and get a value from the functions we just created?  We did and `return()` is not mandatory for R functions as they will return the last calculation.  However, I do think that including a `return()` is good practice and allows us to be clear and more specific about what you get out of your functions.  Let's take a look at the `sum_vec()` function (even though, I just explained why this is not the best function), the `odd_even()` function  and make simple changes to take advantage of `return()`.

First, `odd_even()`


{% highlight r %}
odd_even<-function(num){
  if(num %% 2 == 0){
    return("EVEN")
  } 
  return("ODD")
}
{% endhighlight %}

Now, `sum_vec()`


{% highlight r %}
sum_vec<-function(vec){
  j<-0
  for(i in vec){
    j<-i+j
  }
  return(j)
}
{% endhighlight %}

Pretty straightforward!

##Exercise 1
For this exercise we are going to practice with functions and some of the control structures.

1.) Our first task is to create a simple function.  This one is a bit contrived, but wanted let you try it first before we work on our NLA data.  Create a function that allows you to calculate the mean or standard deviation (hint: sd()) of an input vector.
2.) Our second task is going to be to take your last `ggplot2` plot, and turn that into a function.  The function should take an x and y as input, and have an optional argument for a file name to save it as an image.  Depending on how complex your plot was you may need to add in some additional arguments.  To help things along, I have provided some starter code:


{% highlight r %}
plot_nla<-function(x,y,out=NULL){
  #ggplot2 code
  #Note: ggplot requires a data frame as input.  How would you deal with that?
  
  #ggsave here
  #look into the is.null() function
  if(put condition here){
    ggsave()
  }
  
  #Need to return something ...
  return()
}
{% endhighlight %}


##Markdown
Markdown is a tool that allows you to write simply formated text that is converted to HTML/XHTML.  Primary goal of markdown is readibility of the raw file.  Over the last couple of years, Markdown has emerged as a key way to write up reproducible documents, create websites (this whole website was written in Mardown), and make presentations.  For the basics of markdown and general information look at [Daring Fireball](http://daringfireball.net/projects/markdown/basics).

*note: this text borrowed liberally from another class [SciComp2014](http://scicomp2014.edc.uri.edu)*

To get you started, here is some of that same information on the most common markdown you will use in your posts: Text, Headers, Lists, Links, and Images.

### Text

So, for basic text... Just type it!

### Headers

In pure markdown, there are two ways to do headers but for most of what you need, you can use the following for headers:

```
# Header 1
## Header 2
...
###### Header 6
```

### List

Lists can be done many ways in markdown. An unordered list is simply done with a `-`, `+`, or `*`.  For example

- this list
- is produced with
- the following 
- markdown.

```
- this list
- is produced with
- the following 
- markdown
```
Notice the space after the `-`.  With most markdown interpertters, you can nest lists.  

So to produce this:
- level one
- level one
 - level two
 - level two
- level one
 - level two
  - level three
  
You do:
 
 ```
 - level one
- level one
 - level two
 - level two
- level one
 - level two
  - level three
```

These are not currently getting parsed correctly on the course website.  Not sure why...

To create an ordered list, simple use numbers.  So to produce:

1. this list
2. is produced with
3. the following
4. markdown.

```
1. this list
2. is produced with
3. the following
4. markdown.
```

Note that the actual numbers you use to create the ordered list do not matter.  When you start a list with a number of a letter, the HTML that gets created sees it as an ordered lists and will order and label to item appropriately.

### Links and Images

Last type of formatting that you will likely want to accomplish with R markdown is including links and images.  While these two might seem dissimilar, I am including them together as their syntax is nearly identical.

So, to create a link you would use the following:

```
[Course Website](http://scicomp2014.edc.uri.edu)
```

The text you want linked goes in the `[]` and the link itself goes in the `()`.  That's it! Now to show an image, you simply do this:

```
![CI Logo](http://www.edc.uri.edu/nrs/classes/nrs592/CI.jpg?s=150)
```

The only difference is the use of the `!` at the beginning.  When parsed, the image itself will be included, and not just linked text.  As these will be on the web, the images need to also be available via the web.  You can link to local files, but will need to use a relative path and you will need to make sure the image gets moved to the class Github repoitory.  If you want to do that, talk to [Jeff](mailto:hollister.jeff@epa.gov).  It's easy, but beyond the scope of this tutorial.




##Reproducible Documents and Presentations

##Exercise 2

