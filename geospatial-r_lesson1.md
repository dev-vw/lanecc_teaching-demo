---
title: "Lesson 1: Geospatial Vector Data in R"
description: February 9th, 2022
---

# Lesson objectives

- Gain familiarity with RStudio workspace.
- Begin executing basic computational operations within the R console.
- Understand the difference between **vector** and **raster** datasets.
- Import vector data into R using the `sf` package.
- Plot the vector data into R using the `ggplot2` package.

# Lesson 1 dataset and shared notes

Before we begin this tutorial, please be sure to complete the following preparatory tasks:

#### **Step 1:** Download lesson 1 data

You can download the lesson 1 data [here](/data/lanecounty_censustracts2020.zip). I highly recommended that you create dedicated folder for this course. Here's a suggested organizational structure for your course folder:

```
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

# What learn R?

- R is **reproducible**
- R is **powerful**
- R is **egalitarian**
- R is **free**

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

In my case, all my course materials are contained within a folder titled `rtools_course`. Within my computer (I'm running a distribution of the Linux operating system called Ubuntu), it is located at the following file **path**, or a character string that uniquely identifies the placement of files within a file system. 

```
setwd("/home/vaniawang/.../rtools_course/")
```

The path for your own computer will depend on your operating system. For MacOS, a typical path may look like the following:

`/Users/<YOUR-USERNAME>/Documents/rtools_course`

For Windows, the path delimiters use back slashes rather than forward slashes than MacOS and Linux, which are both Unix-based operating systems. An example path may look like this:

`C:\Documents\rtools_course`

#### Executing mathematical operations in the console

#### Installing and loading R packages

Please make sure to have `ggplot2` and `sf` installed. You can do this by typing the following into the R console.

```
install.packages(c("ggplot2", "sf"))
```

After installation completes, load the packages into your R workspace:

```
library(ggplot2)
library(sf)
```

# Vector and raster data structures

#### Vector data overview

There are two primary types of geospatial data: vector and raster. Vector data represent specific physical features on the earth's surface. A vector feature's shape is represented by its **geometry**. Geometries can be composed of one or more vertices in geographic space.

When a feature's geometry is represented by a single vertex, it is a **point** feature.

![points example](/images/points.png)

When a feature's geometry is represented by a series of interconnected vertices, where the first and last vertex _are not the same_, it is a **polyline** feature.

![line example](/images/line.png)

When a feature's geometry is represented by a series of interconnected vertices, where the first and last vertex _are the same_, it is a **polygon** feature.

![polygon example](/images/poly.png)

#### Vector data formats

Vector data can be stored in a variety of formats, including ESRI shapefiles (`.shp`), GeoJson (`.geojson`), Scalable Vector Graphics (`.svg`), etc. Regardless of format, you can think of a shapefile as a table, where rows represent specific features, and columns store information about the feature's attributes. The only requirement for this table is the inclusion of a **geometry** column, which describes the shape and position of a feature in geographic space. 

#### Rasters

In contrast to vector data, rasters are composed of a matrix of cells or pixels that represent a unit of geographic space. Each of these units contain values that represent conditions for the specified area. _We will cover raster data in detail in a future lesson._

# Introducing the data

In this lesson, we will be working with shapefiles that represent census tract boundaries within Lane County, Oregon.

# Understanding coordinate reference systems

An additional attribute associated with all geospatial data sources, both vector and raster data, is a coordinate reference system (CRS). In the case of vector data, its CRS tells your mapping software (in our case, R) how to position the data's features in geographic space. In other words, it helps answer the question: _How do you represent the earth, a 3D sphere, onto maps, a 2D plane?_

#### There are two components to a CRS

A CRS is defined by two key components:

- **Datum:** A model of the shape of the earth. Datums can be contextual, designed to fit particular areas on the earth better than areas. In this course, we will use the WGS84 datum.

- **Projection:** This is the computational process that flattens features on the spherical surface of the earth onto a 2D plane.

# Import a vector datafile into R

# Plotting vector data

# Additional reading and resources
