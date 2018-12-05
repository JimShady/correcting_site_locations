library(openair)
library(tidyverse)
library(sf)

sites_from_david  <- read_csv('SiteLocationsNewSince2009.csv')

meta              <- importMeta(source = 'kcl')

sites             <- left_join(sites_from_david, meta, by = c("SiteCode" = "code")) 

sites             <- select(sites, 'SiteCode', 'latitude', 'longitude')

names(sites)      <- c('code', 'y', 'x')

rm(meta, sites_from_david)

sites <- st_as_sf(sites, coords = c('x','y')) %>% st_set_crs(4326)

st_write(sites, 'sites.kml')
