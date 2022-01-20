---
title: "National Harmful Algal Bloom Report"
author: "Jeffrey W. Hollister"
date: '2019-12-06'
params:
  data:
    label: "Input dataset:"
    value: data/nla_2007.csv
    input: file
output: word_document
---



# Purpose

The purpose of this document is to serve as motivating example for learning R Markdown and some of the most used features, but I also hope that it will be a useful reference for new R Markdown projects.  This example will build on the work we've already done as we'll use the suite of [Tidyverse](https://tidyverse.org) tools for cleaning and visualizing data.  

# The Example

Several years ago, our research group at EPA had a question about "what is a harmful algal bloom?"  There are of course many ways to define a bloom, but we had the pre-requisite that we be able to apply this definition to existing datasets.  Given this requirement, we focused in on using chlorophyll as a potential proxy for a more direct measurment of HAB's.  To do this we used an conditional probability approach and used the 2007 NLA data to identify chlorophyll concentrations that were associated with exceedences of several microcystin advisory levels.  Details on this are in the [paper at F1000Research](https://f1000research.com/articles/5-151).  For this example, we are going to use the chlorophyll concentrations listed in that papers Table 2.  That table is reproduced below:

|Cond. Probability|USEPA Child (0.3 µg/L)|WHO Drink (1 µg/L)|USEPA Adult (1.6 µg/L)|WHO Recreational (2 µg/L)|
|-----------------|----------------------|------------------|----------------------|--------------------------|
|0.1|	0.07|	0.07|	0.07|	1|
|0.2|	0.07|	4|	12|	17|
|0.3|	3|	17|	32|	45|
|0.4|	11|	37|	68|	77|
|0.5|	23|	68|	84|	104|
|0.6|	39|	97|	115|	185|
|0.7|	66|	126|	871|	871|
|0.8|	116|	271|	871|	871|
|0.9|	170|	516|	871|	871|

We will use the chlorophyl concentration that has at least even odds of exceeding one of the values.  Our summary will look at multiple values.

## Get Data 

In this example we are also highlighting the use of paramaterized reports.  And when we run this with parameters it will ask us to choose the file.  The default is to use 2007 NLA data. 

Let's get that data read in


```r
nla <- read_csv(params$data)
```

```
## Error in is.connection(x): object 'params' not found
```

## Manipulate Data

Now that we have the data read in, let's figure out how many of our chlorophyll based HABs occurred in 2007.  This might be useful to also summarize at the state level.


```r
nla %>%
  group_by(st) %>% 
  summarize(childepa_habs = sum(chla >= 23),
            adultwho_habs = sum(chla >= 68),
            adultepa_habs = sum(chla >= 84),
            whorec_habs = sum(chla >= 104)) %>%
  ungroup() %>%
  kable()
```

```
## Error in eval(lhs, parent, parent): object 'nla' not found
```

And maybe we want to see how these numbers might relate to average state nutrient levels, so lets build that dataset for some visualization.


```r
nla_hab_counts <- nla %>%
  group_by(st) %>% 
  summarize(childepa_habs = sum(chla >= 23),
            adultwho_habs = sum(chla >= 68),
            adultepa_habs = sum(chla >= 84),
            whorec_habs = sum(chla >= 104),
            avg_tn = mean(ntl),
            avg_tp = mean(ptl)) %>%
  ungroup() 
```

```
## Error in eval(lhs, parent, parent): object 'nla' not found
```

## Visualize Data

Next step is to visualize the data.  Let's look at the association between state nutrient averages and total number of HABs.


```r
nutrient_habs_gg <- nla_hab_counts %>%
  ggplot(aes(x = log10(avg_tn), y = log10(avg_tp))) +
  geom_point(aes(color = childepa_habs, size = childepa_habs)) +
  geom_smooth(method = "lm") +
  theme_classic() +
  labs(x = "Log 10 State Average Total Nitrogen",
       y = "Log 10 State Average Total Phosphorus")
```

```
## Error in eval(lhs, parent, parent): object 'nla_hab_counts' not found
```

```r
nutrient_habs_gg
```

```
## Error in eval(expr, envir, enclos): object 'nutrient_habs_gg' not found
```


