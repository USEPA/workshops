---
title: "08 - Repeat and Reproduce"
author: Jeffrey W. Hollister
layout: post_page
---


In theory, you now have a basic understanding of how to conduct a typical data analysis workflow in R.  All that is left is to be able to write it up in such a way that others can not only understand what we did, but repeat it exactly on their own machines. To do this effectively we need to understand how to create reusable R code and create reproducible reports.  This will be a very high level introduction to both concepts, but should hopefully give you a jumping off place for more learning.

## Quick Links to Exercises and R code
- [Lesson 8 R Code](/introR/rmd_posts/2015-01-15-08-Repeat-Reproduce.R): All the code from this post in an R Script.
- [Exercise 1](#exercise-1): Create your own function


## Lesson Goals
- Understand how to create your own functions
- Be able to use basic programming control structures
- Gain familiarity with Markdown and `knitr`
- Create a simple, reproducible document and presentation

## Functions and Programming with R
At this point we should be pretty well versed at using functions.  They have a name, some arguments, and they do something.  Some return a value, some don't.  In short they form the basic structure of R.  One of the cool things about R (and programming in general), is that we are not stuck with the functions provided to us.  We can (and should!) develop our own as we often want to do things repeatedly, and in slightly different contexts.  Creating a function to deal with this fact helps us a great deal because we do not have to repeat ourselves, we can just use what we have already written.  Creating a function is really easy.  We use the `function()` function.  It has the basic structure of: 


```
function_name<-function(arguments){
  code goes here
  use arguments as needed
}
```

And each function comes with some basic information attached to it and have functions associated with them.  These are the `formals()`, the `body()`, and the `environment()`.  We aren't going to get into the details of these, but I did want you to at least be aware of them.

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

### if-else
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

## for
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

Again a bit of a silly example since all it is doing is looping through a list of values and summing it.  In reality you would just use `sum()`.  This also highlights the fact that loops in R can be slow compared to vector operations and/or primitive operations (see Hadley's section on [Primitive functions](http://adv-r.had.co.nz/Functions.html#function-components)).  

Let's dig a bit more into this issue with another example (using the `sum()` example is a bit unfair since `sum()` is actually implemented in C).  This time, let's look at adding two vectors together.  We haven't touched on this yet, but R is really good at dealing with this kind of operation.  It is what people mean when they talk about "vectorized" operations.  For instance:



{% highlight r %}
# A simple vectorize operation
x<-1:100
y<-100:1
z<-x+y
z
{% endhighlight %}



{% highlight text %}
##   [1] 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101
##  [18] 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101
##  [35] 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101
##  [52] 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101
##  [69] 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101
##  [86] 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101
{% endhighlight %}

Pretty cool.  This kind of thing doesn't come easily with many languages.  You would need to program it yourself using a loop.  For the sake of argument, let's try that with R.


{% highlight r %}
#We will assume vectors of the same length...
add_vecs<-function(vec1,vec2){
  out<-NULL
  for(i in 1:length(vec1)){
    out[i]<-vec1[i]+vec2[i]
  }
  out
}
add_vecs(x,y)
{% endhighlight %}



{% highlight text %}
##   [1] 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101
##  [18] 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101
##  [35] 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101
##  [52] 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101
##  [69] 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101
##  [86] 101 101 101 101 101 101 101 101 101 101 101 101 101 101 101
{% endhighlight %}

So, these do the same thing, big deal.  It is big though when you look at the timing of the two.  Let's create two large vectors and see what happens.


{% highlight r %}
large_vec1<-as.numeric(1:100000)
large_vec2<-as.numeric(100000:1)
#Different speed
vec_time<-system.time(large_vec1+large_vec2)
loop_time<-system.time(add_vecs(large_vec1,large_vec2))
vec_time
{% endhighlight %}



{% highlight text %}
##    user  system elapsed 
##       0       0       0
{% endhighlight %}



{% highlight r %}
loop_time
{% endhighlight %}



{% highlight text %}
##    user  system elapsed 
##  10.237   0.000  10.243
{% endhighlight %}

Wow, quite a difference in time! It is examples like this that lead to all the talk around why R is slow at looping.  In general I agree that if there is an obvious vectorized/base solution (in this case simply adding the two vectors) use that.  That being said, it isn't always obvious what the vectorized solution would be. In that case there are some easy things to do to speed this up.  With loops that write to an object and that object is getting re-sized, we may also know the final size of that object so we can do one simple thing to dramatically improve perfomance: pre-allocate your memory, like this:



{% highlight r %}
#We will assume vectors of the same length...
add_vecs2<-function(vec1,vec2){
  out<-vector("numeric",length(vec1))
  for(i in 1:length(vec1)){
    out[i]<-vec1[i]+vec2[i]
  }
  out
}

system.time(add_vecs2(large_vec1,large_vec2))
{% endhighlight %}



{% highlight text %}
##    user  system elapsed 
##   0.088   0.000   0.088
{% endhighlight %}

Now thats better.  In short, if an obvious vector or primitive solution exists, use that.  If those aren't clear and you need to use a loop, don't be afraid to use one.  There are plenty of examples where a vectorized solution exists for a loop, but it may be difficult to code and understand.  Personally, I think it is possible to go too far down the vectorized path.  Do it when it makes sense, otherwise take advantage of the for loop! You can always try and speed things up after you have got your code working the first time.

## return
The last control structure we are going to talk about is `return()`.  All `return()` does is provide a result from a function and terminates the function.  You may be asking yourself, didn't we terminate and get a value from the functions we just created?  We did and `return()` is not mandatory for R functions as they will return the last calculation.  However, I do think that including a `return()` is good practice and allows us to be clear and more specific about what you get out of your functions.  Let's take a look at the `sum_vec()` function (even though, I just explained why this is not the best function), the `odd_even()` function  and make simple changes to take advantage of `return()`.

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



## Exercise 1
For this exercise we are going to practice with functions and some of the control structures.

1. Our first task is to create a simple function.  This one is a bit contrived, but wanted let you try it first before we work on our NLA data.  Create a function that allows you to calculate the mean or standard deviation (hint: sd()) of an input vector.
2. Our second task is going to be to take your last `ggplot2` plot, and turn that into a function.  The function should take an x and y as input, and have an optional argument for a file name to save it as an image.  Depending on how complex your plot was you may need to add in some additional arguments.  To help things along, I have provided some starter code:


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


## Markdown
Markdown isn't R, but it has become an important tool in the R ecosystem as it can be used to create package vignettes, can be used on [GitHub](http://github.com), and forms the basis for several reproducible research tools in RStudio.  Markdown is a tool that allows you to write simply formatted text that is converted to HTML/XHTML.  The primary goal of markdown is readibility of the raw file.  Over the last couple of years, Markdown has emerged as a key way to write up reproducible documents, create websites (this whole website was written in Markdown), and make presentations.  For the basics of markdown and general information look at [Daring Fireball](http://daringfireball.net/projects/markdown/basics).

*note: this text borrowed liberally from another class [SciComp2014](http://scicomp2014.edc.uri.edu)*

To get you started, here is some of that same information on the most common markdown you will use in your posts: Text, Headers, Lists, Links, and Images.

### Text

So, for basic text... Just type it!

### Headers

In pure markdown, there are two ways to do headers but for most of what you need, you can use the following for headers:


    # Header 1
    ## Header 2
    ...
    ###### Header 6
  

### List

Lists can be done many ways in markdown. An unordered list is simply done with a `-`, `+`, or `*`.  For example

- this list
- is produced with
- the following 
- markdown.
    - nested

<pre>    
- this list
- is produced with
- the following 
- markdown
    - nested
</pre> 
    
Notice the space after the `-`.  

To create an ordered list, simply use numbers.  So to produce:

1. this list
2. is produced with
3. the following
4. markdown.
    - nested

<pre>
1. this list
2. is produced with
3. the following
4. markdown.
    - nested
</pre>

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

The only difference is the use of the `!` at the beginning.  When parsed, the image itself will be included, and not just linked text.  As these will be on the web, the images need to also be available via the web.  You can link to local files, but will need to use a path relative to the root of the document you are working on.  Let's not worry about that. It's easy, but beyond the scope of this tutorial.

## Reproducible Documents and Presentations
By itself Markdown is pretty cool, but doesn't really provide any value added to the way most of us already work.  However, when you add in a few other things, it, in my opinion, changes things dramatically.  Two tools in particular that, along with Markdown, have moved reproducible research forward (especially as it relates to R) are, the `knitr` package and a tool called pandoc.  We are not going to cover the details of these, but we will use them via RStudio.  

In short, these three tools allow us to write up documents, embed code via "code chunks", run that code and render the final document with nicely formatted text, results, figures etc into a final format of our choosing.  We can create `.html`, `.docx`, `.pdf`, ...  The benefit of doing this is that all of our data and code are a part of the document.  I share my source document, then anyone can reproduce all of our calculations.  For instance, I can make a manuscript that looks like this:

![Rendered Manuscript](/introR/figure/rendered.jpg)

from a source markdown document that looks like:

![Raw RMarkdown](/introR/figure/source.jpg)

While we can't get to this level of detail with just the stock RStudio tools, we can still do some pretty cool stuff.  We are not going to do an exercise on this one, but we will walk through an example to create a simple reproducible research document and a presentation using the RStudio interface.  This may seem a departure for me, but anything to increase the adoption of reproducible research is a win!

First, lets talk a bit about "code chunks."  

## Code Chunks
Since we are talking about markdown and R, our documents will all be R Markdown documents (i.e. .Rmd).  To include R Code in your .Rmd you would do something like:

    ```{r}
    x<-rnorm(100)
    x
    ```
    
This identifies what is known as a code chunk.  When written like it is above, it will echo the code to your final document, evalute the code with R and echo the results to the final document.  There are some cases where you might not want all of this to happen.  You may want just the code returned and not have it evalutated by R.  This is accomplished with:

    ```{r eval=FALSE}
    x<-rnorm(100)
    ```

Alternatively, you might just want the output returned, as would be the case when using R Markdown to produce a figure in a presentation or paper:


    ```{r echo=FALSE}
    x<-rnorm(100)
    y<-jitter(x,1000)
    plot(x,y)
    ```
    
Lastly, each of your code chunks can have a label.  That would be accomplished with something like:
 
    ```{r myFigure, echo=FALSE}
    x<-rnorm(100)
    y<-jitter(x,1000)
    plot(x,y)
    ```
    
Now, lets get started and actually create a reproducible document

## Create a Document
To create your document, go to File: New File : R Markdown.  You should get a window that looks something like:

![New RMarkdown](/introR/figure/newrmarkdown.jpg)

Add title and author, select "HTML" as the output and click "OK".  RStudio will open a new tab in the editor and in it will be your new document, with some very useful examples.

In this document we can see a couple of things.  First at the top we see:

    ---
    title: "My First Reproducible Document"
    author: "Jeff W. Hollister"
    date: "1/6/2015"
    output: pdf_document
    ---

This is the YAML(YAML Ain't Markup Language) header or front-matter.  It is metadata about the document that can be very useful.  For our purposes we don't need to know anything more about this.  Below that you see text, code chunks, and if it were included some markdown.  At its core this is all we need for a reproducible document.  We can now take this document, pass it through `knitr::knit()` (remember this syntax from the first lesson?) and pandoc and get our output.  We can do this from the console and/or shell, or we can use RStudio.  

If you look near the top of the editor window you will see:

![knit it](/introR/figure/knit.jpg)

Click this and behold the magic!

Spend some time playing around with this document.  Add in some other markdown, text and a code chunk then `knit()` it to see the outcome.  It should be easy to see how this could be used to write the text describing an analysis, embed the analysis and figure creation directly in the document, and render a final document.  You share the source and rendered document and anyone has access to your full record of that research!

## Create a Presentation
Creating a presentation is not much different.  We just need a way to specify different slides.

Repeat the steps from above, but this time instead of selecting "Document", select "Presentation".  Only thing we need to know is that a second level header (i.e. `##`) is what specifies the title of the next slide.  Any thing you put after that goes on that slide.  Similar to before, play around with this, add a slide with some new text, new code and knit it.  There you have it, a reproducible presentation.  

I know you will probably wonder can you change the look and feel of this presentation, and the answer is yes.  I have done that, but using a different method for creating slides by using the `slidify` package.  An example of that presentation is in a talk I gave on [Social Media and Blogging](http://jwhollister.com/epablogpresent).  It does take a bit more work to set this up.  I am also not familar with where RStudio is getting the styling for the presentation. In short, yes but requires a bit of work.

