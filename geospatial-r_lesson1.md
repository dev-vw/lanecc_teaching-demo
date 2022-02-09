---
title: "Lesson 1: Geospatial Vector Data in R"
description: February 9th, 2022
---

# Lesson objectives

#### Objective 1: Begin getting comfortable with R and the RStudio IDE 
- Gain familiarity with RStudio workspace.
- Begin executing basic computational operations within the R console.

#### Objective 2: Start working with vector geospatial data
- Understand the difference between **vector** and **raster** datasets.
- Import vector data into R using the `sf` package.
- Plot the vector data into R using the `ggplot2` package.

# What learn R?

- R is **reproducible**
- R is **powerful**
- R is **egalitarian**
- R is **free**

# Lesson 1 dataset and shared notes

Before we begin this tutorial, please be sure to complete the following preparatory tasks:

#### **Step 1:** Download lesson 1 data

You can download the lesson 1 data [here](/data/lanecounty_censustracts2020.zip). The this is a zipped folder (`lanecounty_censustracts2020.zip`) containing four vector files. Unzip this file and take note of the location where its saved.

I highly recommended that you create dedicated folder for this course. Here's a suggested organizational structure for your course folder:

```shell
rtools_course
├── data
│   └── lesson1_dat
│       ├── _archive
│       │   └── lanecounty_censustracts2020.zip
│       └── lanecounty_censustracts2020
│           ├── lanecounty_censustracts2020.dbf
│           ├── lanecounty_censustracts2020.prj
│           ├── lanecounty_censustracts2020.shp
│           └── lanecounty_censustracts2020.shx
└── lessons
    └── lesson1
        └── lesson1_script.r
```

#### **Step 2:** Access the shared lesson 1 notes

You can access the shared notes [here](https://bit.ly/3sp08fC). Please open a separate browser window, and have this page open on a separate tab. We will be accessing and interacting with this document throughout class.

#### **Step 3:** Download the lesson 1 R script

For every lesson, I will write-up the complete R script (or written list of R commands) used in our tutorial. Eventually, you will gain fluency in writing your own scripts for your own analytical and data manipulation purposes. For lesson 1, you can access the R script [here](/scripts/lesson1_script.r).

# An introduction to working with R

#### Navigating the RStudio workspace

For this course, we will be using RStudio as our integrated development environment (IDE). Like R itself, RStudio is also free and open-source. RStudio is also available with premium features through a commercial license, but these are largely unnecessary for the majority of users. Throughout this course, the RStudio IDE will be the portal through which we will interact with R: we will be able to write R scripts and code, generate graphics, organize project files, and much more.

The following shows an overview of the RStudio workspace:

![rstudio overview](/images/rstudio_overview.png)

RStudio is organized into four smaller panes. Most of our work will occur within the **source** and **console** panes.

- **Environment/History/Connections/Git**: This pane is located by default at the top-right. The **environment** tab will show any objects or variables that are declared during the current R session while **history** shows all commands that have been declared during this session. We will not using the **connections** or **git** tab during this course, but these show any connections to remote servers and/or Git repositories (a popular distributed version control system), respectively.

- **Files/Plots/Packages/Help/Viewer**: This pane is located by default at the lower right portion of the RStudio workspace. The **files** tab will show the files contained within the current working directory. The **plots** tab will show any plots that have been generated during this R session. The **packages** tab will show a list of packages that have been loaded into the current R environment. Finally, the **helper** tab shows help documentation (when queried) and the **viewer** tab shows any output designed for web development.

- **Source**: This pane is located at the upper left portion of your workspace. It shows any current documents used to save or document R commands and code. In this course, we will mainly use R scripts, but other documentation could include R markdown, regular text files, and scripts from other programming languages like Python and C.

- **Console/Jobs**: This is pane located on the bottom-left. The console allows direct interaction with the R interpreter. The **jobs** tab will display any operations occuring in the background.

#### Setting your working directory

Earlier, I had mentioned creating a dedicated folder containing all course materials on your personal computer. Not only is it great to have an organized file system, we can also tell RStudio to set default working directory. This makes finding files easier, and will pay dividends in maximizing working efficiency. You won't believe the amount of errors that result fromt simply not knowing which directory you're working in!

A file **path** is a string of characters that uniquely identifies the placement of files within a file system. The format of the path to your individual `rtools_course` directory will depend on your operating system. For MacOS, a typical path may look like the following: `/Users/<YOUR-USERNAME>/Documents/.../rtools_course`

For Windows, the path delimiters use back slashes rather than forward slashes. An example Windows path may look like this: `C:\Documents\...\rtools_course`

Within my computer (I'm running a distribution of the Linux operating system called Ubuntu), `rtools_course` is located at `/home/vaniawang/.../rtools_course/`.

Once you know the path to your working directory, simply run the `setwd()` command in the R console:

```r
setwd("/home/vaniawang/.../rtools_course/")
```

#### Interacting with the R console

When you first open R, you are likely to be greeted with something like the following in your console:

```r
R version 4.1.2 (2021-11-01) -- "Bird Hippie"
Copyright (C) 2021 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

>
```

You can begin typing code after the `>` prompt. Let's start with some basic arithmetic. Type the following into the console and press `ENTER`:

```r
1 + 10
```

The resulting output should be expected:

```r
[1] 11
```

> :exclamation: **Digression Alert** :exclamation: You may be thinking what `[1]` means. Many objects in R are expressed as the vectors: a sequence of elements of the same type (integer, strings, or logicals). Vectors have lengths, which indicate the number of elements it contains.  The `[1]` simply shows the numbered element of the vector that's returned. The addition operator used here `+` returns the value `2` in vector form.

#### Assigning variables

Now that we have an understanding of executing basic functions within the R console, we can start storing values in variables using the `<-` operator:

```r
x <- 6
```

The value assigned to x can be accessed by directly typing the variable name into the console:

```r
> x
[1] 6
```

When naming variables, remember to give a descriptive name to reflect the object stored within that variable. There naming conventions you should be aware of.

- Variable names should not *start with* numbers or special characters (e.g. `_`, `$`).
- Variable names should not *contain* special characters (e.g. `-`).
- Variable names that start with a period `.` will be hidden from the environment. Try to avoid this when starting out.
- Variable names should be lowercase, and use underscores `_` to separate words within a name.

```r
# Invalid, will throw an error
_first_day
first-day
1_day
$day

# Not invalid, but avoid
.first_day

# Good
first_day
day_2

# Not invalid, but poorly named
this_is_the_variable_x
firstday
secondday
xyz3
```

#### Documenting your code

Now that we've become familiar with interacting with R through the console, let's begin learning about one of the more powerful capabilities of R: saving reporducible commands in scripts. Open a new R script by selecting `File > New File > R Script`. Immediately save the script as `lesson1_script` into your working directory, as to not lose your work. Be sure to consistently save your work by going to `File > Save` or using the keyboard shortcut `Ctrl-s`.

Type the following into the first two lines of your script. Here, we wrote down the command for setting our working directory that we ran before. Above that, however, is something new: any lines of code preceded by a `#` is a **comment**. All comments are ignored with this script is ultimately executed. Comments are very useful because it increases the readability of your code, and helps any collaborators (including future you) understand how your script works. In this example, I state explicitly what `setwd(...)` does. **It is important that you get into including as detailed and informative comments as you can!**

```r
# Set working directory at the local rtools_course folder
setwd("/home/vaniawang/Documents/teaching/lanecc_teaching-demo/rtools_course/")
```

#### Installing and loading R packages

Please make sure to have `ggplot2` and `sf` installed. You can do this by typing the following into the R console.

```r
install.packages(c("ggplot2", "sf"))
```

After installation completes, load the packages into your R workspace. Include the following into your `lesson1_script.R`.

```r
library(ggplot2)
library(sf)
```

# Vector and raster data structures

#### Vector data overview

There are two primary types of geospatial data: vector and raster. Vector data represent specific physical features on the earth's surface. A vector feature's shape is represented by its **geometry**. Geometries can be composed of one or more vertices in geographic space.
2
When a feature's geometry is represented by a single vertex, it is a **point** feature.

![points example](/images/points.png)

When a feature's geometry is represented by a series of interconnected vertices, where the first and last vertex _are not the same_, it is a **polyline** feature.

![line example](/images/line.png)

When a feature's geometry is represented by a series of interconnected vertices, where the first and last vertex _are the same_, it is a **polygon** feature.

![polygon example](/images/poly.png)

#### Vector data formats

Vector data can be stored in a variety of formats, including ESRI shapefiles (`.shp`), GeoJson (`.geojson`), Scalable Vector Graphics (`.svg`), etc. Regardless of format, you can think of a shapefile as a table, where rows represent specific features, and columns store information about the feature's attributes. The only requirement for this table is the inclusion of a **geometry** column, which describes the shape and position of a feature in geographic space. 

#### Rasters data overview

In contrast to vector data, rasters are composed of a matrix of cells or pixels that represent a unit of geographic space. Each of these units contain values that represent conditions for the specified area. An example of raster data are precipitation maps, where each pixel or grid on the map is assigned a value indicating the amount of precipitation received for that location. **We will cover raster data in detail in a future lesson.**

# About the data used in this lesson

In this lesson, we will be working with shapefiles that contain polygon features representing census tract boundaries within Lane County, Oregon. Prior to this lesson, I had downloaded the 2020 census tract shapefile data from the [Oregon Spatial Data Library](https://spatialdata.oregonexplorer.info/geoportal/). The documentation for this data [is described in detail here](https://bit.ly/3GAcIxy).

# Understanding coordinate reference systems

An additional attribute associated with all geospatial data sources, both vector and raster data, is a coordinate reference system (CRS). In the case of vector data, its CRS tells your mapping software (in our case, R) how to position the data's features in geographic space. In other words, it helps answer the question: _How do you represent the earth, a 3D sphere, onto maps, a 2D plane?_

#### Two main components to a CRS

A CRS is defined by two key components:

- **Datum:** A model for the shape of the earth. Datums can be contextual, designed to fit particular areas on the earth better than areas.

- **Projection:** This is a mathematical function that transforms the X and Y coordinates of one spatial reference framework, to the X and Y coordinates of another spatial reference framework.

Given that both of these components can result in significant distortions to geographic data, it is vital that we verify that a data source has a CRS, and if not, specify it. Not doing this will result in funky looking features and maps.

####  Datum (in terms of fruit)

I think we can all agree that the earth is round-ish in shape. A datum is simply a formalized round-ish model of the earth. Let's think of the earth in terms of round fruit. Which do we think best models the spherical/ellipsoid/round-ish shape earth? A lime? A watermelon? The answer is contextual. Some datums may best reflect the ground truth of certain areas of the earth, but not others. For the purposes of our course, we'll start with WGS84, which is commonly used in global positioning systems (GPS).

#### Projection (in terms of fruit)

Given that the earth is curved and maps are flat, there needs to be a process for defining how a position on a curved surface translates to a flat one. Projections are these mathematical processes. If we were to choose a watermelon as our datum, the way we peel the watermelon and flatten the peels is analogous to map projections. There are many ways to peel and flatten the watermelon, which may result distorted regions of the globe.

# Import a vector datafile into R

Importing shapefiles into R is simple using the [`sf` package](https://r-spatial.github.io/sf/). After importing this library into R using `library(sf)`, you should have access to all of the package's functions. We will use the `st_read(...)` function to read the shapefile into our R workspace. Please type the following into your `lesson1_script.R`:

```r
# Use the st_read(...) function to read the shapefile containing lane county census tracts
lc_ct <- st_read("data/lesson1_dat/lanecounty_censustracts2020/lanecounty_censustracts2020.shp")

```

Here, the `st_read(...)` function takes a character string containing the path to the `lanecounty_censustracts2020.shp` file and saves the resulting data in a variable called `lc_ct`. Note that although the `st_read(...)` function does not query for the other three files in that directory (ending in `.dbf`, `prj`, `shx`), they are still necessary for the shapefile to be imported. Do not delete these other files!

# Plotting vector data

Now that we've imported the Lane County Census Tract features into the variable named `lc_ct`, we can plot this data to graphically see what these census tracts look like! Please add the following to your `lesson1_script.R`:

```r
# Plot the loaded lc_ct 
ggplot() + geom_sf(data = lc_ct)
```

The ggplot() initializes a graphical object. Running this function alone will produce a blank graphic. 

![blank ggplot](/images/blank-ggplot.png)

Using the `geom_sf(...)` function, we will layer on the `lc_ct` data saved in the prior step to visualize the census tracts. To do this, we add `lc_ct` to the `data` parameter for the function: `geom_sf(data = lc_ct)`

![lane county census tracts](/images/lanecounty_censustracts.png)

# Additional reading and resources

#### More beginner R tutorials

- [Software Carpentries: *R for Reproducible Scientific Analysis*](https://swcarpentry.github.io/r-novice-gapminder/). A Spanish version of this tutorial is available [here](https://swcarpentry.github.io/r-novice-gapminder-es/).

- [Software Carpentries: *Programming with R*](https://swcarpentry.github.io/r-novice-inflammation/)

#### Advanced resources

- [*Geocomputation with R, 2019, Lovelace et al*](https://geocompr.robinlovelace.net/)
