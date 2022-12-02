##########################
# Mapping challenge!
# R Cafe TUD
# 2 December 2022
# Clementine Cottineau
##########################


## Install packages as needed

#install.packages("osmdata")
library(osmdata)
#install.packages("sf")
library(sf)
#install.packages("ggplot2")
library(ggplot2)
#install.packages("leaflet")
library(leaflet)


## Extract data from the OSM API

# Define the bounding box of a given place using the NominatimAPI 
bb <- getbb("Zierikzee")
bb

# Use this trick in case of error with `opq()`. It forces the system to recognise that you have access to internet.
assign("has_internet_via_proxy", TRUE, environment(curl::has_internet))

# download OSM features within the bb bounding box, using the hierarchy of OSM categories,
zierikzee_osm <- opq(bbox=bb) %>%
  add_osm_feature(key = "amenity", value = "bench") %>%
  osmdata_sf()  # and transform it into an sf object

# getting info about the object by viewing its first few lines
head(zierikzee_osm)

#selecting the points only
benches <- zierikzee_osm$osm_points

#extract latitude and longitudes info and store them as columns
benches$lat <- st_coordinates(benches)[,"Y"]
benches$long <- st_coordinates(benches)[,"X"]


# static visualisation
p <- ggplot(data = benches) +
  geom_sf(aes(col=backrest))
p


## Dynamic visualisation

# transform info about backrest into colour code
# - blue if there is a backrest, 
# - red if not, 
# - purple if we don't know

benches$colour <- ifelse(!is.na(benches$backrest),
                         ifelse(benches$backrest == "yes", 
                                "blue", "red"),
                         "purple")

# use leaflet to map benches on a CartoDB base layer
leaflet() %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addCircleMarkers(benches, lng = benches$long, lat = benches$lat, 
                   radius = 5, color = benches$colour)

# look into this page for more basemaps: https://rstudio.github.io/leaflet/basemaps.html