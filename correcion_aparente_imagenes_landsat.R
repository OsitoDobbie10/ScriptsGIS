rm(list = ls())
#lectura de datos landsat vamos a generar correcion aparente imagenes landsat 
library(dplyr)
library(raster)
library(RStoolbox)
library(sf)
#RUTEAS LA UBICACIÓN DE LOS DATOS LANDSAT
setwd('D:/DataBase/Theme_n1/01-DataSet/01-raster/01-landsat/')
#LECTURA DE METADATOS LANDSAT
mtlFile <- 'LT50090651987222XXX01/LT50090651987222XXX01_MTL.txt'
MTL     <- readMeta(mtlFile)
#CALIBRACIÓN RADIOMÉTRICA
SisRef  <- '+proj=utm +zone=16 +datum=WGS84 +units=m +no_defs'
shp     <- read_sf('D:/DataBase/Theme_n1/01-DataSet/02-shp/Area_Estudio.shp') %>% st_transform(SisRef)
#LECTURA DE LA IMAGEN MULTIESPECTRAL LANDSAT
lsat    <- stackMeta(mtlFile) %>% crop(shp)
#CÁLCULO DE REFLECTIVIDAD APARENTE
lsat_Apref <- radCor(lsat, MTL, 'apref')