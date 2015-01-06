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
A `for` loop allows you to repeat code.  You specify a variable and a range of values and the `for` loop runs the code for each value in your range.  

###return

##Exercise 1

##Markdown

##Reproducible Documents and Presentations

##Exercise 2

