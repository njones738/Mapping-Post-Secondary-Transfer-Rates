# Opens up plot view
rerun_hgd <- function(x) {
    httpgd::hgd()
    httpgd::hgd_browse()
}
rerun_hgd()

# read in data
df <- read.csv("N:/Classes/2023_1SPRING/Analytics_Day/Data/csc.csv") %>%
            filter(REGION != 0) %>%
            filter(REGION != 9) %>%
            mutate(REGION = as.character(REGION))









# Load required libraries
library(tidyverse)
library(sf)
library(dplyr)
library(ggplot2)
library(tigris)
library(units)
library(igraph)

# Function to create a MultiPolygon for each state
create_multipolygon <- function(lat_list, long_list) {
  polygons <- lapply(1:length(lat_list), function(i) {
    coords <- cbind(long_list[[i]], lat_list[[i]])
    polygon <- st_polygon(list(coords))
    polygon
  })
  
  multipolygon <- st_multipolygon(list(polygons))
  return(multipolygon)
}

region_df <- st_as_sf(df,
                         coords = c("LONGITUDE", "LATITUDE"),
                         crs = 4326) %>%
                group_by(REGION) %>%
                summarize(geometry = st_union(geometry))
region_df



# Load the US map with state boundaries
us_map <- tigris::states(cb = TRUE, class = "sf") %>% 
    st_transform(crs = 4326) %>%
    filter(STUSPS %in% unique(df$STABBR)) %>% 
    st_join(.,
            region_df)

# Define the color palette for regions
region_palette <- c("purple", "green", "yellow", "brown", "pink", "#257747", "#411d1d", "#866167")

# Function to calculate the distance between two coordinates
dist_haversine <- function(lat1, lon1, lat2, lon2) {
  R <- 6371 # Earth's mean radius in km
  dlat <- as.numeric(set_units(abs(lat1 - lat2), "degrees")) * pi / 180
  dlon <- as.numeric(set_units(abs(lon1 - lon2), "degrees")) * pi / 180
  a <- sin(dlat / 2) * sin(dlat / 2) +
    cos(lat1 * pi / 180) * cos(lat2 * pi / 180) *
    sin(dlon / 2) * sin(dlon / 2)
  c <- 2 * atan2(sqrt(a), sqrt(1 - a))
  d <- R * c
  return(d)
}

# Create edges between schools within 100 miles of each other
create_edges <- function(df) {
  df_combinations <- expand.grid(1:nrow(df), 1:nrow(df))
  df_combinations <- df_combinations[df_combinations$Var1 < df_combinations$Var2, ] # nolint
  df_edges <- df_combinations %>%
                    mutate(dist = dist_haversine(df$LATITUDE[Var1],
                                                df$LONGITUDE[Var1],
                                                df$LATITUDE[Var2],
                                                df$LONGITUDE[Var2]),
                           
                        ) %>%
    filter(dist <= 100 * 1.60934) # Convert miles to kilometers
  return(df_edges)
}

# Plot the map
plot_map <- function(df, us_map, edges) {
  ggplot() +
    geom_sf(data = us_map, aes(fill = REGION), color = "white", size = 0.1) +
    scale_fill_manual(values = region_palette) +
    geom_segment(data = edges,
                 aes(x = df$LONGITUDE[Var1],
                     y = df$LATITUDE[Var1],
                     xend = df$LONGITUDE[Var2],
                     yend = df$LATITUDE[Var2]
                    ),
                     color = "red"

                ) +
    geom_point(data = df,
               aes(x = LONGITUDE,
                   y = LATITUDE,
                   size = UGDS),
               color = "gray",
               alpha = 0.75
              ) +
    scale_size_continuous(range = c(1, 10), 
                          breaks = scales::pretty_breaks(n = 5)) +
    theme_bw() +
    theme(legend.position = "bottom") +
    labs(fill = "Region", size = "Number of Students")
}


# Create edges between schools within 100 miles of each other
edges <- create_edges(df)

# Plot the map
map_plot <- plot_map(df, us_map, edges)
print(map_plot)










