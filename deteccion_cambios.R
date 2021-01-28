rm(list = ls())
library(velox)
library(sp)
library(raster)
library(sf)
library(dplyr)
setwd('D:/DataBase/Theme_n1/01-DataSet/')
#-------- Lectura y Creación de imputs  --------#
shp            <- read_sf('DC.shp')
LandCover_type <- c("Agua","Quemado","Vegetacion","Suelo","Urbano")
LandUse_start  <- velox('LandCover_1994.tif')
LandUse_end    <- velox('LandCover_2017.tif')

#-------- Creación y edición de tabla de detección de cambio --------#
a <- LandUse_start$extract(shp) %>% do.call(what = 'rbind')
b <- LandUse_end$extract(shp) %>% do.call(what = 'rbind')

df <- data.frame(start=a, end=b)

for (i in 1:5) { df = df %>% mutate(start = ifelse(start==i, LandCover_type[i], start),
                                    end = ifelse(end==i,   LandCover_type[i], end))}

#-------- Detección de Cambio  --------#
change <- table(df)
write.csv(change, "05-Tables/change_matrix_2016-1987.csv")
