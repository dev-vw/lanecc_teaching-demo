library(sf)
library(ggplot2)
library(ggmap)

or_ct <- st_read("data/CensusTracts2020/CensusTracts2020.shp")
lane_ct <- or_ct[which(or_ct$COUNTY == "Lane County"), ]


ggmap(get_stamenmap(bbox=c(left=-124.725, 
                           bottom=41.849, 
                           right=-116.079, 
                           top=46.563), 
                    zoom = 8)) +
  geom_sf(data=lane_ct, 
          size=0.1, 
          color="#31a354",
          fill="green",
          inherit.aes=FALSE) + 
  ggtitle("Oregon Census Tracts")

ggmap(get_stamenmap(bbox=c(left=-124.725, 
                           bottom=41.849, 
                           right=-116.079, 
                           top=46.563), 
                    zoom = 8))
