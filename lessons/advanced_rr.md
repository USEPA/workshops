


# Advanced Reproducibility Topics and Tools

After we finish this lesson, you will:

- be able to customize MS Word output
- know how to incorporate citations into a reproducible workflow
- learn about ways to capture need information on the computational environment
- be introduced to related issues such as version control, continuous intergration, and licensing

## Lesson Outline
- [Word templates](#word-templates)
- [Managing references](#managing-references)
- [Computational environment](#computation-environment)
- [Related issues](#related-issues)

## Exercises
- [Exercise 1](#exercise-1)

## Word templates

Combining code and text in a single document and rendering to a final product is cool.  However, without control of the final formatting and without being able to use widespread file formats its utility is limited.  Luckily, we can output to multiple formats, including .pdf, .html., .docx, .odt, ... and with the use of file format specific templates we can impose our will on the look and feel of the final product.  In this section we will focus on working with word templates.  Instead of repeating detail of this here, I point you to the [Happy collaboration with Rmd to docx](http://rmarkdown.rstudio.com/articles_docx.html) article from RStudio.

The best way to learn these is to work with them.  The steps we will use are roughly as follows:

1. Create an .Rmd with the different sections you want in your output and render that to a .docx
2. Open your .docx in Word and, using "styles", set the formatting you want
3. Create a new .Rmd that will be the source for your final document, and in the YAML under `word_document:` add in a `reference_docx:` that points to your new .docx with the saved styles. 
4. Add content to your .Rmd and render to your now nicely styled Word document.
5. Share, edit, rinse, repeat.

## Managing references

Like before, the best source of information on this is in [Happy collaboration with Rmd to docx](http://rmarkdown.rstudio.com/articles_docx.html#bibliographies).  We will follow along from there for most of these examples.  The steps that we need to follow are:

1. Build up your `.bib` file.
2. In the YAML front matter of your document point to the `.bib` using the `bibliography:` keyword.
3. Add citations to your text in the format of `[@hollister2017]`.  
4. Render.
5. If you have a particular citation style that you would like to use, find an approriate `.csl` file from <http://citationstyles.org/>.  That can be added in with the `csl:` keyword.

We will show how this works using a generic draft manuscript template that I have created at <https://github.com/jhollist/rmd_word_manuscript>.  

### A manuscript example: .Rmd to word

From the repository listed above, we will need to download a couple of files

1. The most important file is the .docx template.  Download it from <https://github.com/jhollist/rmd_word_manuscript/blob/master/manuscript_template.docx?raw=true> and save it in a folder named `manuscript`.

2. The other files are examples that we can use to show how this works.  Get the following:

- [Example .Rmd](https://github.com/jhollist/rmd_word_manuscript/blob/master/manuscript.Rmd?raw=true)
- [Example .bib](https://github.com/jhollist/rmd_word_manuscript/blob/master/manuscript.bib?raw=true)
- [plos.csl](https://github.com/jhollist/rmd_word_manuscript/blob/master/plos.csl?raw=true)

Save all of these in the same `manuscript` folder.

3. Open the manuscript.Rmd file in RStudio and we will work through rendering this together.

## Exercise 1

In this exercise, we will take the result from our reproducible research document exercise and convert this to a manuscript following the manuscript example we just saw.

1. Add some authors
2. Add an abstract (don't worry about the text)
3. Add Intro, Methods, and Results sections
4. Add some references to a .bib
5. Add some in text citations
6. Use `knitr::kable(iris[1:10,])` to add a simple table to your document.
7. Render!

## Computational environment

We talked early on that we are focusing on computational reproducibility.  Up to this point our focus has been on creating a document that combines code, data and text.  This provides the steps and ingredients needed to reproduce a given work; however, that work was run at a specific point in time, with specific versions of software, on a specific operating system, and on specific hardware.  Any one of these things can change and potentially impact reproducibility.  There are several ways to begin to address this aspect of reproducibility that range from simple reporting of the environment, to providing full reproducible computational environments.  We will work with one today, and provide links for more reading on the others. 

### Session information

The easiest thing we can do to provide some insurance that our work can be reproduced is provide a detailed report of the software and operating systems used for our analysis.  

We can do that using `sessionInfo()`

So, for the last time the document was rendered, this is what I had:


```r
sessionInfo()
```

```
## R version 3.4.1 (2017-06-30)
## Platform: x86_64-redhat-linux-gnu (64-bit)
## Running under: Red Hat Enterprise Linux Server release 6.9 (Santiago)
## 
## Matrix products: default
## BLAS: /usr/lib64/R/lib/libRblas.so
## LAPACK: /usr/lib64/R/lib/libRlapack.so
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] bindrcpp_0.2       dplyr_0.7.3        purrr_0.2.3       
## [4] readr_1.1.0        tidyr_0.6.2        tibble_1.3.4      
## [7] tidyverse_1.1.1    magrittr_1.5       ggplot2_2.2.1.9000
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.12      cellranger_1.1.0  compiler_3.4.1   
##  [4] plyr_1.8.4        bindr_0.1         forcats_0.2.0    
##  [7] tools_3.4.1       lubridate_1.6.0   jsonlite_1.5     
## [10] evaluate_0.10     gtable_0.2.0      nlme_3.1-131     
## [13] lattice_0.20-35   pkgconfig_2.0.1   rlang_0.1.2      
## [16] psych_1.7.5       curl_2.8.1        yaml_2.1.13      
## [19] parallel_3.4.1    haven_1.0.0       xml2_1.1.1       
## [22] stringr_1.2.0     httr_1.3.1        knitr_1.16       
## [25] hms_0.3           grid_3.4.1        glue_1.1.1       
## [28] R6_2.2.2          readxl_1.0.0      foreign_0.8-69   
## [31] modelr_0.1.0      reshape2_1.4.2    scales_0.4.1.9002
## [34] rvest_0.3.2       assertthat_0.2.0  mnormt_1.5-5     
## [37] colorspace_1.3-2  stringi_1.1.5     lazyeval_0.2.0   
## [40] munsell_0.4.3     broom_0.4.2
```

This can be included at the bottom of a `.Rmd` or you can include a code chunk at the end of your document that includes this:

<pre>```{r session_info, echo=FALSE}
#Send session info to a file: 
capture.output(sessionInfo(),file="sessioninfo.txt")<br>```</pre>

If you are managing your project with `git` and you make that repository available via GitHub, this "sessioninfo.txt" file will live with the document and be a record of what was used the last time the file was rendered.  
  
### Package managment

While knowing the details of what was used is very important, it does not necessarily ensure that you will be able to get access to that software at that specific version.  In the R world there are ways to help facilitate this for the packages that we use.  Several options are currently available are:

- [packrat](https://github.com/rstudio/packrat)
- [drat](https://github.com/eddelbuettel/drat)
- [miniCRAN](https://github.com/RevolutionAnalytics/miniCRAN)
- [checkpoint](https://github.com/RevolutionAnalytics/checkpoint)

Each of these have there own use cases, but the provide a way to store and access specific packages with specific versions that is free from relying just on CRAN.

### Virtual Machines and Docker

In this last section we are going to talk more about fully replicating a given computational environemnt.  There are several ways to do this, but two of the most common are to provide access to a virtual machine or, a ligtherweight and more recent option, access to a container.  Both of these solves issues around operating systems and dependencies.  It is a much more generalizable solution in that the focus is not just R.


- Virutal machines:  A virtual machine is managed by software on a given piece of hardware such that multiple machines can be supported on a single server.  Resources are divided up among the multiple virtual machines and each machine can have its own operating system and its own set of available software.  They are useful in that it is an all in one solution that someone can replicate provided they have access to the virtual machine software.  The files are relatively large and can be cumbersome to share.  A related concept (and what that you see more and more) is use of cloud resources.  An Amazon Web Services instance is analagous to a virtual machine (this is my definition!) where the hardware itself is the cloud.

- Containers:  Containers are similar to a virtual machine but the do not divide up resources (i.e. All cpus and all memory are available to all containers).  Like a virtual machine it provides a complete computational environment although, as far as I know, is limited (a feature, not a but) to linux systems.  The most common containerization tool is [Docker](https://www.docker.com/) and handily for R users, there is a [Rocker](https://hub.docker.com/u/rocker/) which provides a whole slew of pre-made R based docker files.

At this point our ability to easily utilize these within the confines of EPA's information technology infrastrcture is uncertain...

## Related issues

In this last section we are going to very briefly introduce some tangential concepts to reproducibility and provide a list and links to some relevant tools.

 - Version control

This is a broad 

 - Sharing and collaboration

 - Automation, testing, and continuous integration
 - Licensing (and an Open Source rant): Licensing our work is important as it (somewhat) unambiguously defines the bounds of acceptable use for our work.  As we work for the federal govenment and sepcifically for the USEPA there are further constraints on what type of licenses we can use.  Currently the only acceptable license (and it really isn't a license but more a public domain dedication) for us to use as EPA employees is the [Creative Commons Zero](https://creativecommons.org/publicdomain/zero/1.0/).  Other Creative Commons licenses would probably also be ok (e.g. [CC BY](https://creativecommons.org/licenses/by/2.0/)) would probably be OK to use, but 1) EPA has not explicitly approved these (that I know of) and 2) reproducible research documents are a mix of text, ideas, and code.  Of the Creative Commons license, only the CC0 has been deemed acceptable for code.  Other acceptable open source licenses (e.g. from the [OSI](https://opensource.org/)) have not been approved by EPA for our use. In short it is kind a muddy and the easiest thing we can do as EPA employees is to use CC0 for all of the above.
 <rant> A related issue is the software used to conduct our research.  If reproducibility is a goal (and I think it should be) then any impediment to that reproducibility should be avoided.  In this, I include the use of paid, closed-source, and/or proprietary software.  Thus, if you use SAS, your resultant work is not (by my definition) reproducible.  If you use ArcGIS, that research is (again by my definition) not reproducible.  I say this becuase financial constraints to getting access to that software are real and in many cases are insurmmountable.  Thus, if the goal is reproducibility, Free and Open Source Software is a must as it allows anyone to re-run those analyses.</rant>  

