# Características sociodemográficas
# Libraries

require(plyr)
library(tidyverse)


# Database extraction
# Function to make extraction readable by table
enut_path <- function(tabla){
  p <- paste0("datos/raw/conjunto_de_datos_enut_2019_csv/conjunto_de_datos_enut_tradicional_2019/conjunto_de_datos_",tabla,"_enut_tradicional_2019/conjunto_de_datos/conjunto_de_datos_",tabla,"_enut_tradicional_2019.csv")
  return(p)
}

# We extract four tables. Vivienda shows the characteristics of the building
# Hogar describes the household
# sdem is about the sociodemographic characteristics of the household
# modulo shows the results of the use of time of the members of the household

enut <- read.csv(enut_path("tmodulo"))
enut_sdem <- read.csv(enut_path("tsdem"))
enut_hogar <- read.csv(enut_path("thogar"))
enut_vivienda <- read.csv(enut_path("tvivienda"))

rm(enut_path)
