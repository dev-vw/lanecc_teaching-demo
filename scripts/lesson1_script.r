# Load the required libraries
library(sf)
library(ggplot2)

# Use the st_read(...) function to read the shapefile containing
# 
or_ct <- st_read("data/CensusTracts2020/CensusTracts2020.shp")
or_ct_3857 <- st_transform(or_ct, 3857)

lane_ct_3857 <- or_ct_3857[which(or_ct_3857$COUNTY == "Lane County"), ]

st_write(lane_ct_3857, 
         "data/lanecounty_censustracts2020/lanecounty_censustracts2020.shp")

lane_ct_read <- st_read("data/lanecounty_censustracts2020/lanecounty_censustracts2020.shp")

ggplot() + geom_sf(data=lane_ct_read, aes(fill = HISP18))

bmap <- ggmap::get_stamenmap(bbox=c(left=-124.3944, 
                                    bottom=43.5305, 
                                    right=-121.7092, 
                                    top=44.3250), 
                             zoom  = 8)

ggmap::ggmap(bmap) +
  coord_sf(crs = st_crs(3857)) +
  geom_sf(data=lane_ct,
#          aes(fill = HISP18),
          inherit.aes = FALSE) +
  ggtitle("Oregon Census Tracts")

ggmap(bmap)
