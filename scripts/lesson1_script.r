# Load the needed packages
library(sf)
library(ggplot2)

# To make your life easier, set your working directory to have all
# needed files easily accessible!
setwd("/home/vaniawang/Documents/teaching/lanecc_teaching-demo/rtools_course/")

# Use the st_read(...) function to read the shapefile containing
lc_ct <- st_read("data/lesson1_dat/lanecounty_censustracts2020/lanecounty_censustracts2020.shp")

# Use the st_crs() command to verify the CRS of the vector data we
# just imported
st_crs(lc_ct)

# Plot the loaded lc_ct
ggplot() + geom_sf(data = lc_ct)

# ---- EXTRA INFORMATION, WE WILL COVER THIS LATER --- #
library(ggmap)

lanecounty_basemap <- ggmap::get_stamenmap(bbox = c(left = -124.3944, 
                                                    bottom = 43.5305, 
                                                    right = -121.7092, 
                                                    top = 44.3250), 
                                           zoom = 9)

ggmap::ggmap(lanecounty_basemap) +
  geom_sf(data = lc_ct,
          fill = NA,
          color = "#00abff",
          inherit.aes = FALSE) +
  ggtitle("Lane County Census Tracts") +
  coord_sf(crs = st_crs(4326))
