---
title: "Lesson 1: Geospatial Vector Data in R"
description: February 9th, 2022
---

## Lesson objectives

- Gain familiarity with RStudio workspace.
- Begin executing basic computational operations within the R console.
- Understand the difference between **vector** and **raster** datasets.
- Import vector data into R using the `sf` package.
- Plot the vector data into R using the `ggplot2` package.

## Lesson 1 dataset and shared notes

Before we begin this tutorial, please download the lesson 1 data, open the shared lesson notes onto a browser, and download the lesson 1 R script for reference.

- Download lesson 1 data [here](https://bit.ly/3gr1Szk)
- Access the shared lesson 1 notes [here](https://bit.ly/3sp08fC)
- The complete lesson 1 R script can be accessed [here](/scripts/lesson1_script.r)

## Preliminaries

#### Navigating the RStudio workspace

#### Installing and loading R packages

Please make sure to have `ggplot2`, `sf`, and `ggmap` installed. You can do this by typing the following into the R console.

```
install.packages(c("ggplot2", "sf", "ggmap"))
```

After installation completes, load the packages into your R workspace:

```
library(ggplot2)
library(sf)
library(ggmap)
```

## Vector and raster data structures

#### Vector data overview

There are two primary types of geospatial data: vector and raster. Vector data represent specific physical features on the earth's surface. A vector feature's shape is represented by its **geometry**. Geometries can be composed of one or more vertices in geographic space.

When a feature's geometry is represented by a single vertex, it is a **point** feature.

When a feature's geometry is represented by a series of interconnected vertices, where the first and last vertex _are not the same_, it is a **polyline** feature.

When a feature's geometry is represented by a series of interconnected vertices, where the first and last vertex _are the same_, it is a **polygon** feature.

#### Vector data formats

Vector data can be stored in a variety of formats, including ESRI shapefiles (`.shp`), GeoJson (`.geojson`), Scalable Vector Graphics (`.svg`), etc. Regardless of format, you can think of a shapefile as a table, where rows represent specific features, and columns store information about the feature's attributes. The only requirement for this table is the inclusion of a **geometry** column, which describes the shape and position of a feature in geographic space. 

#### Rasters

In contrast to vector data, rasters are composed of a matrix of cells or pixels that represent a unit of geographic space. Each of these units contain values that represent conditions for the specified area. Rasters will be a dedicated tutorial in a future lesson.

## Introducing the data

In this lesson, we will be working with shapefiles that represent census tract boundaries within Lane County, Oregon.

## Understanding projections and CRS

## Import a vector into R

## Plotting vector data

## Additional reading and resources
