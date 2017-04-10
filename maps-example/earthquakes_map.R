#-------------------------- BANNER R-LAB#2


# https://earthquake.usgs.gov/earthquakes/search/
# http://www.exegetic.biz/blog/2014/04/earthquake-magnitude-depth-chart/


# Install pkg
install.packages("maps")
install.packages("colourpicker")
install.packages("showtext")

# Load
require(ggplot2)
require(maps)
require(grid)


# Data loading
catalog <- read.csv("earthquakes_2013_2017.csv", stringsAsFactors = FALSE)

# Data cleaning
catalog <- within(catalog, {
       time <- sub("T", " ", time)
       time <- sub("Z", "", time)
       time <- strptime(time, format = "%Y-%m-%d %H:%M:%S")
       date <- as.Date(time)
       year <- as.integer(strftime(time, format = "%Y"))
     })
catalog <- catalog[, c(12, 16, 17, 1, 2:5, 14)]


world.map <- map_data("world")


# Vintage
ggplot() +
  geom_polygon(data = world.map, aes(x = long, y = lat, group = group),
               fill = "#FFF5EE") +
  geom_point(data = catalog, alpha = 0.25,
             aes(x = longitude, y = latitude, size = mag, colour = depth)) +
  labs(x = NULL, y = NULL) +
  scale_colour_gradient("Depth [m]", low = "#B4CDCD", high = "#E0EEEE") +
  scale_size("Magnitude", range = c(1,2)) +
  coord_fixed(ylim = c(-82.5, 87.5), xlim = c(-185, 185)) +
  theme_classic() +
  theme(axis.line = element_blank(), axis.text = element_blank(),
        axis.ticks = element_blank(),
        plot.margin=unit(c(3, 0, 0, 0),"mm"),
        legend.text = element_text(size = 6),
        legend.title = element_text(size = 8, face = "plain"),
        panel.background = element_rect(fill="#EEE9E9"))


