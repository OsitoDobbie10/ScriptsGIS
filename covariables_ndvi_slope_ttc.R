rm(list = ls())
#Covariable de los siguuientes elementos 
library(RStoolbox)
library(raster)
library(dplyr)
#RUTEAS LA UBICACIÓN DE LOS DATOS LANDSAT
setwd('D:/DataBase/Theme_n1/01-DataSet/01-raster/')
#----------------------#
lts        <- brick('01-landsat/LC80090652016206LGN00/LC80090652016206_RefAbs.tif')
names(lts) <- paste('B',c(1:7),sep = '')
ttc        <- tasseledCap(lts[[c(2:7)]],sat = 'Landsat8OLI')
ndvi       <- (lts[[5]]-lts[[4]])/(lts[[5]]+lts[[4]])
dem        <- raster('02-dem/dem.tif') %>% resample(lts)
slope      <- terrain(dem,unit = 'degrees')
writeRaster(lts,'lts',format="GTiff")
writeRaster(ttc, 'ttc' ,format="GTiff")
writeRaster(ndvi,'ndvi',format="GTiff")
writeRaster(dem,'dem' , format="GTiff")
writeRaster(slope, 'slope',format="GTiff")