#leer metados de las imagenes landsat 5 y 8 
rm(list = ls())
#cargar librerias para el scripts 
#usar version de R 3.6.3 
library(dplyr)
library(raster)
library(RStoolbox)
#RUTEAS LA UBICACIÓN DE LOS DATOS LANDSAT
setwd('D:/DataBase/Theme_n1/01-DataSet/01-raster/01-landsat/')
#LECTURA DE METADATOS LANDSAT
mtlFile   <- 'LT50090651987222XXX01/LT50090651987222XXX01_MTL.txt'
MTL  <- readMeta(mtlFile)