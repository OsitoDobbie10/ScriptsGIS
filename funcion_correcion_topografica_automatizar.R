rm(list = ls())
library(dplyr)
library(raster)
library(RStoolbox)
library(sf)
#RUTEAS LA UBICACIÓN DE LOS DATOS LANDSAT
setwd('D:/DataBase/Theme_n1/01-DataSet/01-raster/01-landsat/')
ltpp <- function(file,ae,dem){
  #---------- DESCOMPRESIÓN DE DATOS ----------#
  untar(file, exdir = file %>% strsplit('.tar') %>% sapply('[',1))
  #---------- LECTURA DE METADATOS ----------#
  rut    = file %>% strsplit('.tar') %>% sapply('[',1)
  #LECTURA DE METADATOS LANDSAT
  mtlFile = file.path(rut,list.files(rut,pattern = '_MTL.txt'))
  MTL     = readMeta(mtlFile)
  az      = (MTL$SOLAR_PARAMETERS)[1]
  elev    = (MTL$SOLAR_PARAMETERS)[2]
  sensor  = MTL$SENSOR
  if(sensor == 'TM'){ bands = c(1:7)}
  if(sensor == 'OLI_TIRS'){ bands = c(1:11)}
  ##LECTURA DE DATOS VECTORIALES
  shp     = ae
  SisRef  = '+proj=utm +zone=17 +datum=WGS84 +units=m +no_defs'
  #LECTURA DE LA IMAGEN MULTIESPECTRAL LANDSAT
  lsat    = stackMeta(mtlFile) %>% crop(shp %>% st_transform(SisRef))
  #CÁLCULO DE REFLECTIVIDAD APARENTE
  lsat_Apref   = radCor(lsat, MTL, 'apref')
  #CORRECCIÓN ATMOSFÉRICA DARK-OBJECT SUBTRACTION
  lsat_Absref  = radCor(lsat, MTL, 'dos',atmosphere = 'clear',clamp = T)[[bands]]
  lsat_Absref  = lsat_Absref %>% projectRaster(crs = crs(shp))
  #CORRECCIÓN TOPOGRÁFICA, MÉTODO DE CIVCO
  modelELEV    = dem
  slope        = terrain(modelELEV,'slope')
  aspect       = terrain(modelELEV,'aspect')
  cosi         = hillShade(slope,aspect,elev,az)
  cosi[cosi<0] = 0
  cosi_rspl    = cosi %>% resample(lsat_Absref)
  cosi_mean    = getValues(cosi_rspl) %>% mean(na.rm=T)
  lsat_TopCor  = lsat_Absref + (lsat_Absref*((cosi_mean-cosi_rspl)/cosi_mean))
  lsat_TopCor[lsat_TopCor<0] = 0
  names(lsat_TopCor)         = paste('B',bands,sep = '')
  #ALAMCENANDO DATOS LANDSAT CORREGIDOS
  writeRaster(lsat_Apref, file.path(rut, paste(rut %>% substr(3,18),'_RefAp.tif',sep = '')),overwrite=T)
  writeRaster(lsat_TopCor, file.path(rut, paste(rut %>% substr(3,18),'_RefAbs.tif',sep = '')),overwrite=T)
}
#------------#
datos <- list.files(pattern = '.gz',full.names = T)
shp <- read_sf('Area_Estudio.shp')
dem <- raster('dem.tif')