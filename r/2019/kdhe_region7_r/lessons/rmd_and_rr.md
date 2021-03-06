

# Reproducible Research Documents

Reproducibility and the ["reproducibility crisis"](https://www.nature.com/news/1-500-scientists-lift-the-lid-on-reproducibility-1.19970) in science have received quite a bit of attention over the last several years. As such, interest in making our work more reproducible has also increased.  The focus of this workshop is on a small, but very important part, of reproducibility, computational reproducibility.  In particular, we will focus on what Victoria Stodden has described as "Open or Reproducible Research" in which code, data, and descriptions are all freely available (for more on this see <http://stodden.net/icerm_report.pdf>).  An exhaustive review of all things reproducible is beyond the scope of this workshop, so I will point you to the best general resource I know of on this, the [rOpenSci Reproducibility Guide](http://ropensci.github.io/reproducibility-guide) and in particular the [Introduction](http://ropensci.github.io/reproducibility-guide/sections/introduction/).

After this lesson, you will:

- Understand the value of reproducible documents
- Gain familiarity with Markdown, `rmarkdown` and `knitr`
- Work with and render an R Markdown document with RStudio

## Lesson Outline
- [Introduction to Reproducible Documents](#reproducible-documents)
- [Create a document](#create-a-document)
- [YAML](#yaml)
- [Markdown](#markdown)
- [Code chunks](#code-chunks)
- [Rendering](#rendering)

## Exercises
- [Exercise 3.1](#exercise-31)



## Reproducible Documents

Reproducible documents, are documents that mix text and code and allow others (or you!) to re-run your analysis.  They are inspired by Donald Knuth's ideas on [literate programming](http://www-cs-faculty.stanford.edu/~knuth/lp.html).  Specific to the R world we build reproducible documents with Markdown, `rmarkdown`, `knitr`, and an external tool called [pandoc](https://pandoc.org/). In short, these tools allow us to write up documents, embed code via "code chunks", run that code and render the final document with nicely formatted text, results, figures etc into a final format of our choosing.  We can create `.html`, `.docx`, `.pdf`, ...  The benefit of doing this is that all of our data and code are a part of the document.  We can share our source document, then anyone can reproduce all of our calculations.  For instance, we can make a manuscript that looks like this:

[![Rendered Manuscript](figures/rendered.jpg)](https://github.com/USEPA/LakeTrophicModelling/raw/master/vignettes/manuscript.pdf)

from a source markdown document that looks like:

[![Raw RMarkdown](figures/source.jpg)](https://github.com/USEPA/LakeTrophicModelling/raw/master/vignettes/manuscript.Rmd)

While we can't get to this level of detail with just the stock RStudio tools (i.e. in requires a bit of LaTeX shenanigans), we can still do some pretty cool stuff. For instance, we can see how this could be used to write the text describing an analysis, embed the analysis and figure creation directly in the document, and render a final document.  You share the source and rendered document and anyone has access to your full record of that analysis!  Additionally, maybe you have a standard set of analyses to run on a dataset that is evolving or updated on a regular basis.  We can build an R Markdown document that reads in a dataset, runs analysis and updates the output.  

With all of this in mind, let's jump into working with an R Markdown document and learn about the basic building blocks: YAML, Markdown, and Code Chunks.

## Create a Document
We will be mostly working with the R Markdown document we already have, `kdhe_markdown.Rmd`, but before we do that, we will create a new one to learn about the basics.  First, go to File: New File : R Markdown.  You should get a window that looks something like:

![New RMarkdown](figures/newrmarkdown.jpg)

Add title and author, select "HTML" as the output and click "OK".  RStudio will open a new tab in the editor and in it will be your new document, with some very useful examples.

In our document we can see a couple of things.  In particular we see `YAML`, `Markdown`, text and code chunks.

## YAML

    ---
    title: "My First Reproducible Document"
    author: "Jeff W. Hollister"
    date: "12/6/2019"
    output: pdf_document
    ---

This is the YAML (YAML Ain't Markup Language) header (a.k.a front-matter).  It is metadata about the document that can be very useful.  There is a lot more we can do with the YAML.  There are additional fields available for us to you, or we can even create our own.  For our purposes these basic ones are good, but there are also additional ones.  We will use some during the exercise, but you can read more in the [`rmarkdown` cheatsheet](http://www.rstudio.com/wp-content/uploads/2016/03/rmarkdown-cheatsheet-2.0.pdf) as well as in the various chapters of [R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/#).  A lot of the optional ones I use are part of the [output format](http://rmarkdown.rstudio.com/lesson-9.html). 

## Markdown
Markdown isn't R, but it has become an important tool in the R ecosystem as it can be used to create package vignettes, can be used on [GitHub](http://github.com), and forms the basis for several reproducible research tools in RStudio.  Markdown is a tool that allows you to write simply formatted text that is converted to HTML.  The primary goal of markdown is readibility of the raw file.  Over the last couple of years, Markdown has emerged as a key way to write up reproducible documents, create websites, write documentation (all of these lessons are written in Markdown), and make presentations.  For the basics of markdown and general information look at [Daring Fireball](http://daringfireball.net/projects/markdown/basics).

To get you started, here is some of that same information on the most common markdown you will use: text, headers, lists, links, images, and tables.

### Text

So, for basic text... Just type it!

### Headers

In markdown, there are two ways to do headers but for most of what you need, you can use the following for headers:


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
[Kansas Department of Health and EnvironmentL Bureau of Water](http://www.kdheks.gov/water/)
```

Which looks like: [Kansas Department of Health and Environment](http://www.kdheks.gov/).

The text you want linked goes in the `[]` and the link itself goes in the `()`.  That's it! Now to show an image, you do this:

```
![Kansas HAB Meeting Save The Date](http://www.kdheks.gov/algae-illness/images/HAB-Save-the-Date-2020.jpg)
```

And renders like: 

![Kansas HAB Meeting Save The Date](http://www.kdheks.gov/algae-illness/images/HAB-Save-the-Date-2020.jpg)

The only difference is the use of the `!` at the beginning.  When parsed, the image itself will be included, and not linked text.  As these will be on the web, the images need to also be available via the web.  You can link to local files, but will need to use a path relative to the root of the document you are working on.  Let's not worry about that as it is a bit beyond the scope of this tutorial.

And with this, we can have some real fun.  

![matt foley](https://media.giphy.com/media/n7Nwr10hWzROE/giphy.gif)

### Tables

Markdown has the ability to structure tables as well.  So to get a table like this:

|First Name|Last Name|Favorite Color|
|----------|---------|--------------|
|Cookie    |Monster  |Blue          |
|Big       |Bird     |Yellow        |
|Elmo      |Monster  |Red           |

We use Markdown that looks like this:

<pre>
|First Name|Last Name|Favorite Color|
|----------|---------|--------------|
|Cookie    |Monster  |Blue          |
|Big       |Bird     |Yellow        |
|Elmo      |Monster  |Red           |
</pre>

Coding these tables up by hand only makes sense for the simplest cases, but luckily we have many options for generating tables with R functions.  For static non interactive tables there is the `kable()` function from the `knitr` package and there's the [`kableExtra` package](https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_html.html) which provides tools for enhanced tables.  There are others as well and a good overview can be seen in [this rOpenSci discussion](https://github.com/ropensci/unconf17/issues/69).  If you prefer interactive tables and your output type is going to be HTML, the `DT` package, which uses the [DataTables `javascript` library](https://datatables.net/) is a nice option.

With these functions, we can now use any data frames we have in R and create an output table.  For instance:


```r
knitr::kable(rbind(head(iris),tail(iris)),row.names = FALSE)
```



| Sepal.Length| Sepal.Width| Petal.Length| Petal.Width|Species   |
|------------:|-----------:|------------:|-----------:|:---------|
|          5.1|         3.5|          1.4|         0.2|setosa    |
|          4.9|         3.0|          1.4|         0.2|setosa    |
|          4.7|         3.2|          1.3|         0.2|setosa    |
|          4.6|         3.1|          1.5|         0.2|setosa    |
|          5.0|         3.6|          1.4|         0.2|setosa    |
|          5.4|         3.9|          1.7|         0.4|setosa    |
|          6.7|         3.3|          5.7|         2.5|virginica |
|          6.7|         3.0|          5.2|         2.3|virginica |
|          6.3|         2.5|          5.0|         1.9|virginica |
|          6.5|         3.0|          5.2|         2.0|virginica |
|          6.2|         3.4|          5.4|         2.3|virginica |
|          5.9|         3.0|          5.1|         1.8|virginica |

## Code Chunks

So, now that we know YAML controls the document build process, and we can structure our text with Markdown, we need to add the last step: incorportaing code.  To include R Code in your `.Rmd` you would do something like:

<pre>```{r}
x<-rnorm(100)
x<br>```</pre>

This identifies what is known as a code chunk.  When written like it is above, it will echo the code to your final document, evalute the code with R and echo the results to the final document.  There are some cases where you might not want all of this to happen.  You may want just the code returned and not have it evalutated by R.  This is accomplished with code chunk options.  For instance:

<pre>```{r eval=FALSE}
x<-rnorm(100)<br>```</pre>

Alternatively, you might just want the output returned, as would be the case when using R Markdown to produce a figure in a presentation or paper:

<pre>```{r echo=FALSE}
x<-rnorm(100)
y<-jitter(x,1000)
plot(x,y)<br>```</pre>
    
Lastly, each of your code chunks can have a label.  That would be accomplished with something like:
 
    
<pre>```{r myFigure, echo=FALSE}
x<-rnorm(100)
y<-jitter(x,1000)
plot(x,y)<br>```</pre>

Code chunks are incredibly powerful and with the current iteration of RStudio and the packages that support R Markdown you can do a lot.  For instance, you can include code chunks in languages other than R including: Python, shell scripts, SQL, JavaScript, ...  For details see the [Other langauge engines Chapter](https://bookdown.org/yihui/rmarkdown/language-engines.html) in the "R Markdown: The Definitive Guide book.  Furthermore, there are MANY code chunk options and those can be quite useful, but beyond the scope of what we are covering today.  For more, read the [R code chunks and inline R Code Chapter](https://bookdown.org/yihui/rmarkdown/r-code.html). 

## Rendering

Now that we have seen all the pieces of an R Markdown document, we can explore our output options.  If you look near the top of the editor window you will see:

![knit it](figures/knit.jpg)

Alternatively, we can use the console to do this.


```r
rmarkdown::render("my_rmd.Rmd")
```

This rendering process takes all of the inputs (YAML, markdown, text, and code) and weaves them together into a output document that has run the code and returned any results.  There are many options for output types, but the ones you most likely will use are HTML, docx, or pdf.  The pdf output is widely used, but that requires a local installation of LaTeX, which most computers will not already have.  For todays workshop our focus will be on output to docx files as those tend to be the most widely accepted within our respective agencies and Microsoft Word is rather ubiquitous.  

So, how do we control the output type for our files?  There are several ways to do this.

1. If no output type is specified, it will default to HTML.
2. If you use the the top of the editor and use the "Knit" dropdown menu, it provides the option to choose from: Knit to HTML, Knit to PDF, or Knit to Word.  Depending on which one use choose, it will add an `output:` entry to your YAML.
3. With the `render()` function, you can specify your output with the`output_format` argument.

We have now covered all the basics of R Markdown, but there is one more to cover before we get our hands dirty with the `kdhe_markdown.Rmd` and that is parameters.

## Parameters

To add parameters to our R Markdown file, we need to first specify those parameters in the YAML and then tell the code in our code chunks how to use that parameter.

For our example markdown document that we've been working through we can add these to the YAML with this:

    ---
    title: "My First Reproducible Document"
    author: "Jeff W. Hollister"
    date: "12/6/2019"
    output: pdf_document
    params:
      data: iris
    ---

And then we can change our code chunk to use the paramaters

<pre>```{r cars}
summary(get(params$data))<br>```</pre>

And now when we render it will either use the default value we provide, `iris`, or if we select "Knit with parameter" from the "Knit" menu it will pop up a window asking for our input for this parameter.  
Like all of the topic we've covered, there are many additional options. For more, read the [Parameterized Reports Chapter](https://bookdown.org/yihui/rmarkdown/parameterized-reports.html).

## Exercise 3.1 

We now have some tools at our disposal that we can use to start to work with and add information to an R Markdown document.  There is a LOT here, but I wanted to include this all here so those that want to can work through many of the different topics.

1. Create a new RStudio project and name it `rmarkdown_workshop`.
2. Download the R Markdown file and save in this new project at the root of the project (Bonus: Who can describe what "root of the project" means?):
  - [`kdhe_markdown.Rmd`](https://raw.githubusercontent.com/USEPA/kdhe_region7_r/master/lessons/kdhe_markdown.Rmd)
3. Create a folder at the root of your project named `data`.
4. Download the following two data files into this new `data` folder: (Note: Chrome does a very awful thing with these files.  Even though they are `.csv`, if you try to `Save link as...` it wants to save them as `.txt` files.  Make sure you replace `.txt` with `.csv` in the file dialog)
  - [`nla_2007.csv`](https://raw.githubusercontent.com/USEPA/kdhe_region7_r/master/data/nla_2007.csv)
  - [`nla_2012.csv`](https://raw.githubusercontent.com/USEPA/kdhe_region7_r/master/data/nla_2012.csv)
5. Open up the `kdhe_markdown.Rmd` file.
6. With the person(s) next to you take a look at the file and answer the following questions:
  - What is the name of the second code chunk, and  what does it do?
  - Look at the YAML header.  What type of output will this R Markdown file produce?
  - How many output tables do you expect to see in the final ouput document?
  - What year of NLA data did this summarize?  How can you tell that from the information in the R Markdown document?
7. Now that you've looked around the file a bit, let's create the output by clicking on the `Knit` button at the top of the window.
9. Change the title of the document to include the year.
10. Render this again with the `Knit` button.
12. Now, lets just play around with Markdown in general.  Try some of the following and then re-render your document to see the results:
  - Add a new first level header with "Playing around with Markdown" as the text
  - Add three second level headers underneath with the following text: "A bulleted list", "A link", "An animated GIF"
  - Underneath "A bulleted list", add a bulleted list with three items that have your three favorite foods/
  - Underneath "A link" add in a link to the website of your choosing. 
  - Underneath "An animated GIF" add an image using the URL of an animated GIF of your choosing.  You can search for "Animated GIF" at <https://images.google.com>.
11. Now render this document a third time, but use the `Knit:Knit with parameters` option from the `Knit` drop down menu and choose the 2012 NLA data for this one. 

