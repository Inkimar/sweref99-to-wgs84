library(magrittr)
library(sp)
library(readr)
library(dplyr)

coords <- 
  read_csv("/home/ingimar/repos/inkimar-github/sweref99-to-wgs84/lat_long-sweref99.csv") %>% 
  select(contains("SWEREF99")) %>%
  select(lon = E_SWEREF99, lat = N_SWEREF99)

SWEREF99TM <- CRS("+init=epsg:3006")
WGS84 <- CRS("+init=epsg:4326")  # http://epsg.io/4326 "real" WGS84

p1 <- SpatialPointsDataFrame(coords, data = coords, proj4string = SWEREF99TM)
p2 <- spTransform(p1, WGS84)

df <- tibble(
  lat = p2$lat,
  lon = p2$lon)

write_excel_csv(df, "/home/ingimar/repos/inkimar-github/sweref99-to-wgs84/wgs84.csv")
