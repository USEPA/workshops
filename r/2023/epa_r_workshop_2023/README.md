## 2023 USEPA R User Group Workshop Agenda

#### On-line participation details:

This year's workshop will be fully virtual, held on the afternoons (1-5pm eastern) of Oct 17th, 18th, and 19th, 2023.
Details on remote participation option for the presentations and workshops will be sent to participants closer to the workshop dates.
The agenda below is preliminary and may change before the workshop.

Sign-up to participate via [EventBrite](https://www.eventbrite.com/e/r-user-group-workshop-2023-october-17th-19th-registration-611092212257).

## Tue, October 17

|Time (EDT)     |Title                    |Speaker                  |
|---------------|-------------------------|-------------------------|
|1:00pm - 1:15pm|Welcome and Introduction |John Sykes, Deputy Director of OSIM|
|1:15pm - 2:15pm|Keynote: Supporting Kinder Science for Future Us          |[Julia Stewart-Lowndes](https://jules32.github.io/) and [Ileana Fenwick](https://aces.kenaninstitute.unc.edu/people/ileana-fenwick/)|
|2:15pm - 3:00pm|Lightning Talks          |Kelsey Hensley, Yana Genchanok, Thomas Barnum, William Wheeler, and Cristina Mullin|
|3:00pm - 3:15pm|**Break**                |                         |
|               |Invited Talks *(See below for details)*|           |
|3:15pm - 3:40pm|Environmental Justice Analysis Multisite tool|Mark Corrales|
|3:40pm - 4:05pm|Implementation of CompTox and GenRA APIs for rapid chemical risk characterization|Sean Thimons|
|4:05pm - 4:30pm|Building Qlik dashboards with R|Carrie Cummings    |
|4:30pm - 4:55pm|Shrimp and Grits: Enhancing Grants Results and Tracking System (GRTS) Data Analytics Using R and Friends|Eric Beck|
|5:00pm - 6:00pm|Virtual Happy Hour       |All!                     |

## Wed, October 18

Day 2 will be split into 3 parallel sessions, all taking place from 1pm-5pm:

|Track  |Title                   |Topics                  |Lead                    |
|-------|------------------------|------------------------|------------------------|
|1|[Intro to R (Part 1)](https://github.com/nicholekulikowski/intro-to-R-2023)|R fundamentals, overview of RStudio IDE, importing and visualizing data|Nichole Kulikowski|
|2|EPA Infrastructure/DMAP|GitHub Enterprise, Cloud.gov, R Connect|Dave Smith|
|3|[Spatial Data and Analysis in R](https://mhweber.github.io/R-User-Group-Spatial-Workshop-2021/)|Reading and writing spatial data, spatial data operations, spatial mapping|[Marc Weber](https://mhweber.github.io/) and [Michael Dumelle](https://michaeldumelle.github.io/)|

## Thu, October 19

Day 3 will be split into 3 parallel sessions, all taking place from 1pm-5pm:

|Track  |Title                   |Topics                  |Lead                    |
|-------|------------------------|------------------------|------------------------|
|1|[Intro to R (Part 2)](https://github.com/nicholekulikowski/intro-to-R-2023)|R fundamentals, overview of RStudio IDE, importing and visualizing data|Nichole Kulikowski|
|2|Quarto|Hands on building manuscripts, reports, presentations, websites, and more in Quarto|Jeremy Allen (Posit)|
|3|Shiny|A hands-on course of building Shiny projects and the use of Shiny|Andrew R. Murray|



#### Invited Talks (Tues, October 17):

- **Plenary Keynote: Julia Stewart-Lowndes and Ileana Fenwick.** Julia founded [Openscapes](https://openscapes.org/) and will tell her story of using R to promote open science, see [her website](https://jules32.github.io/) for more. Ileana is a [PhD student at UNC](https://aces.kenaninstitute.unc.edu/people/ileana-fenwick/) and has done a lot of work on open science, particularly for Black Women in Ecology, Evolution, and Marine Sciences. She leads up the [OpenScapes Pathways to Open Science Program](https://openscapes.org/initiatives.html#pathways-to-open-science-program).
- **Lightning Talks:** This session will consist of quick (9-minute) presentations on applications of R and related tools in EPA research and applications:
  - Kelsey Hensley (2:15-2:24): *Topic TBA*
  - Yana Genchanok (2:24-2:33): *Topic TBA*
  - Thomas Barnum (2:33-2:42): *Topic TBA*
  - William Wheeler (2:42-2:51): *Topic TBA*
  - Cristina Mullin (2:51-3:00): *Topic TBA*
- **Mark Corrales:** *EJAM (Environmental Justice Analysis Multisite tool)* is in development as a Shiny webapp in R
- **Sean Thimons:** *Implementation of CompTox and GenRA APIs for rapid chemical risk characterization*
- **Carrie Cummings:** *Building Qlik dashboards with R* - There are many options for building a dashboard. This presentation will walk through why a R developer may want to consider using Qlik as the front end for their application. We’ll show a real-life project example, walk through how to connect Qlik and R, and discuss some pros/cons of using Qlik vs R-Shiny.
- **Eric Beck:** *Shrimp and Grits: Enhancing Grants Results and Tracking System (GRTS) Data Analytics Using R and Friends* - CWA Section 319, Nonpoint Source Program, has a BMP and funding tracking system that our grantees are required to use and populate with data. The system goes back to the 1990’s, and houses data on funding, best management practices for stormwater control (BMP), pollutant load reductions, spatial data including watersheds, etc. The system has grown dendritically over the years. It has some data analysis capacity built-in using Oracle Business Intelligence (OBI), but is very limited and clunky. The GRTS Connector, AKA Shrimp and Grits, is intended to bolster that data analysis capability to help answer basic and complex questions about BMP effectiveness, deployment locations, lag time between grant award and BMP installation, etc. It is envisioned that this analytical capacity will be exceptionally valuable in case of an OIG or GAO audit.



#### Workshop Descriptions:

- **Introduction to R (2 days):** Participants in this workshop will be introduced to R through the lense of the "Tidyverse" as well as learn basics of the R Language for statistical computing.  In particular we will: 1) learn the fundamentals of R including syntax, functions, and packages; 2) spend quality time with the core R data structure, the data frame; 3) learn how to manipulate our data with the `dplyr` and `tidyr` packages; and 4) gain expereince creating data visualizations with `ggplot2`.  Our goal is to set learners up with a foundation for future exploration of R.
- **EPA Infrastructure/DMAP (1 day):** Participants in this workshop will be introduced to EPA-managed infrastructure for developing R projects, including the Data Management and Analytics Platform (DMAP), Cloud.gov, R Connect, and GitHub Enterprise.
- **Spatial Data and Analysis in R (1 day):** This workshop will provide an introduction to the current GIS ecosystem in R.  We’ll demonstrate use of packages such as sf, raster, terra, stars, tmap, mapview and others.  The workshop will provide an overview of both vector and raster I/O in R, vector geocomputation operations such as spatial subsetting, spatial joins, spatial aggregation, and distance operations as well as raster operations such as map algebra  We’ll cover coordinate reference systems and projections in R as well as mapping in R.  We’ll also look at examples of exploratory spatial data analysis (ESDA) in R, data transformation and processing, data visualization, and spatial analysis in R in the context of reproducible research.
- **Quarto (1 day):** Staff from Posit (formerly RStudio) will be giving an introduction to Quarto, which is a new alternative to R Markdown for creating interactive notebooks and reports. This workship will cover hands on building manuscripts, reports, presentations, websites, and more in Quarto.
- **Shiny (1 day):** A hands-on course of building Shiny projects and the use of Shiny.

