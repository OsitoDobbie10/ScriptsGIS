rm(list = ls())
library(dplyr)
library(raster)
library(sf)
library(reshape)
library(velox)
library(ggplot2)
setwd('D:/DataBase/Theme_n1/')
source('02-Scripts/Color_Ramp.R')

basin         <- read_sf("DC.shp")
rut           <- '01-DataSet/01-raster/04-landcover/'
LandUse_velox <- stack(list.files(rut,pattern = ".tif",full.names = T)) %>% velox()
years         <- c(1994,2017)
Name_TypeUse  <- c('01-Rios y lagos','02-Areas quemadas', '03-Vegetacion','04-Suelo','05-Urbano')
n             <- length(Name_TypeUse)
Name_TypeUse_label <- Name_TypeUse %>% strsplit('-') %>% sapply('[',2)


#------ Extrayendo valores --------#
extract    <- do.call('rbind', LandUse_velox$extract(basin)) %>% as.data.frame()
area_basin <- nrow(extract)*900/10000
#------ Creando un DATAFRAME ------#
tabla      <- data.frame(Name_TypeUse)

#------ Creando Tabla de resumen de Area por tipo de ------#
#------ Cobertura/Uso de tierra para cada ano ------#
for (i in 1:2) {
  area  = extract[i] %>% table() %>% as.data.frame() %>% 
    dplyr::select(Freq) %>% mutate(Freq = Freq*900/10000)
  tabla = cbind(tabla,area)
  names(tabla)[i+1] =  years[i]
}
#----------------------------------------------------------#


#------ Editando la Tabla resumen ------#
Tabla_melt        <- melt(tabla, id.vars = c("Name_TypeUse"))
names(Tabla_melt) <- c("Name_TypeUse","Year","Area")
Tabla_melt        <- Tabla_melt %>% mutate(Year=Year %>% as.vector() %>% as.numeric(),
                                           Frec_Rel = (Area*100/area_basin) %>% round(1))

for (i in 1:length(Name_TypeUse)) {# N° DE COBERTURAS
  for (j in 1:length(years)) {# N° DE AÑOS
    if(i==1){ Tabla_melt[i + n*(j-1), 5] = Tabla_melt[i + n*(j-1), 4]
    } else  { Tabla_melt[i + n*(j-1), 5] = Tabla_melt[i + n*(j-1), 4] + Tabla_melt[(i-1) + n*(j-1),5] }
  }
}

names(Tabla_melt)[5] <- 'Frec_Acum'
Tabla_melt           <- Tabla_melt %>% mutate(Ubic_text = 100 - Frec_Acum + Frec_Rel/2)

#---------------------------------------#


#------ Plot de Grafica de Barras ------#
X <-  ggplot(Tabla_melt, aes(x=Year, y=Frec_Rel, fill=Name_TypeUse)) + 
  labs(x="\nYear", y="Study Area\n (% Total)\n", fill="Land cover") + 
  geom_bar(stat="identity", colour=F) + 
  theme_bw() +
  scale_x_continuous(breaks = years,expand = c(0,0)) + 
  scale_y_continuous(breaks = seq(0, 100, 10),expand = c(0,0)) + 
  scale_fill_manual(values = cb_palette, labels = Name_TypeUse_label) +
  theme(axis.title=element_text(size=25),
        panel.border = element_rect(colour = "black", fill=NA, size=1.2),
        axis.text.x  = element_text(size = 15),
        axis.text.y  = element_text(size = 15),
        legend.title = element_text(color = "black", size = 15),
        legend.text  = element_text(color = "black", size = 14)) +
  geom_text(aes(y=Ubic_text, label=Frec_Rel), vjust=0.25, colour="black",size=4)

ggsave(X, filename = "04-Graphics/BarGraph_LUCC.png", width = 25, height = 20, units = "cm")
#----------------------------------------