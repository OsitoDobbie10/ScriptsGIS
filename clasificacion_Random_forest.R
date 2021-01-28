rm(list = ls())
library(rgdal)
library(raster)
library(caret)#permite correr RandomForest y otros modelos de clasificación
library(snow)#procesamiento en paralelo
library(randomForest)#modelo de clasificación
library(dplyr)
library(sf)
library(lattice)
setwd('D:/DataBase/Theme_n1/01-DataSet/')
#  LEER Y RENOMBRAR EL ARCHIVO RASTER APILADO
img <- brick('01-raster/03-covariables/2016/CovStack.tif')
names(img) <- c('dem',paste('B',c(1:7),sep = ''),'ndvi','slope','brightness','greenness','wetness')
# LECTURA DE DATOS VECTORIALES PARA EL ENTRENAMIENDO DEL MODELO
trainData <- read_sf("02-shp/02-Training_Data/Training_Data_2016.shp")
#------------------------------------------------------------------------------------------------------field <- "class"
# CREACIÓN DE UN DATAFRAME VACÍO
# QUE ALMACENARÁ A LOS VALORES DE LAS VARIABLES PREDICTORA
# EXTRAÍDAS A PARTIR DEL LAS ÁREAS DE ENTRENAMIENTO
df <- matrix(vector(), 0, nlayers(img)+1) %>% data.frame()
# TIPOS DE COBERTURAS
n <- trainData %>% group_by(dscrp,class) %>% summarise(num=length(class))
# EXTRACCIÓ DE VALORES DE LA IMAGEN A PARTIR DEL DATO VECTORIAL
for (i in n$class){
  categorymap = trainData %>% filter(class==i)
  dataSet     = extract(img, categorymap)
  elmnts_null = dataSet %>% lapply(is.null) %>% unlist()
  dataSet     = dataSet[!elmnts_null] %>% do.call(what = 'rbind') %>% as.data.frame() %>%  mutate(class = i)
  df          = rbind(df, dataSet)
}

# SELECCIONANDO UN NÚMERO MENOR DE MUESTRAS
nsamples  <- 1000
df_sample <- df[sample(1:nrow(df), nsamples), ]

# ENTRENANDO EL MODELO
df_fit <- train(as.factor(class) ~ B1 + B2 + B3 + B4 + B5 + B6 + B7 + ndvi +
                  brightness + greenness + wetness + dem + slope, method = "rf", data = df, na.action=na.exclude)

# PREDICCIÓN LANDCOVER CON PROCESAMIENTO EN PARALELO
beginCluster()
landcover_pred <- clusterR(img, raster::predict, args = list(model = df_fit))
endCluster()

# FILTRO MAJORITY
landcover_majority <- focal(landcover_pred, w=matrix(1,3,3), fun=modal)

# ESCRITURA DE LA CLASIFICACIÓN LANDCOVER
writeRaster(landcover_pred, '01-raster/04-landcover/LandCover_2016.tif')