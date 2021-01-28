#Coreccion topografica a la imagen 
rm(list = ls())
library(dplyr)
library(raster)
library(RStoolbox)
library(sf) 
#RUTEAS LA UBICACIÓN DE LOS DATOS LANDSAT
setwd('D:/DataBase/Theme_n1/01-DataSet/01-raster/01-landsat/')
#LECTURA DE METADATOS LANDSAT
mtlFile <- 'LT50090651987222XXX01/LT50090651987222XXX01_MTL.txt'
MTL     <- readMeta(mtlFile)
az      <- (MTL$SOLAR_PARAMETERS)[1]
elev    <- (MTL$SOLAR_PARAMETERS)[2]
#CALIBRACIÓN RADIOMÉTRICA
SisRef  <- '+proj=utm +zone=16 +datum=WGS84 +units=m +no_defs'
shp     <- read_sf('D:/DataBase/Theme_n1/01-DataSet/02-shp/Area_Estudio.shp')
#LECTURA DE LA IMAGEN MULTIESPECTRAL LANDSAT
lsat    <- stackMeta(mtlFile) %>% crop(shp %>% st_transform(SisRef))
#CÁLCULO DE REFLECTIVIDAD APARENTE
lsat_Apref <- radCor(lsat, MTL, 'apref')
#CORRECCIÓN ATMOSFÉRICA DARK-OBJECT SUBTRACTION
lsat_Absref <- radCor(lsat, MTL, 'dos',atmosphere = 'clear',clamp = T)[[c(1:5,7)]]
lsat_Absref <- lsat_Absref %>% projectRaster(crs = crs(shp))
#CORRECCIÓN TOPOGRÁFICA, MÉTODO DE CIVCO
dem          <- raster('D:/DataBase/Theme_n1/01-DataSet/01-raster/02-dem/dem.tif')
slope        <- terrain(dem,'slope')
aspect       <- terrain(dem,'aspect')
cosi         <- hillShade(slope,aspect,elev,az)
cosi[cosi<0] <- 0
cosi_rspl    <- cosi %>% resample(lsat_Absref)
cosi_mean    <- getValues(cosi_rspl) %>% mean(na.rm=T)
lsat_TopCor  <- lsat_Absref + (lsat_Absref*((cosi_mean-cosi_rspl)/cosi_mean))
lsat_TopCor[lsat_TopCor<0] <- 0
plotRGB(lsat_TopCor,4,5,3,stretch='hist')  
writeRaster(lsat_TopCor ,filename = "imagen",format="GTiff")