# Mario Alberto Garcia Meza
# mario.agm@ujed.mx

# Libraries

library(dplyr)
require(plyr)
library(ggplot2)


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

head(enut_hogar)

# Ingresos adicionales al trabajo. El siguiente bloque suma los ingresos
# del hogar diferentes al trabajo.

gsub(1,0,c(1,1,1,2,2,3,2,1,0))

apply(enut_hogar, seq(6,22,2), function(x) gsub(999999,0,x))


max(enut_hogar$P2_4A_1, na.rm = TRUE)
enut_hogar$ing_ntrab <- rowSums(enut_hogar[,c("P2_4A_1", "P2_4A_2",
                                              "P2_4A_3","P2_4A_4",
                                              "P2_4A_5", "P2_4A_6",
                                              "P2_4A_7", "P2_4A_8", 
                                              "P2_4A_9")], na.rm = TRUE)

            

###############################################################

# Trabajadores en el hogar
# De entrada por salida
enut_hogar$P2_6_1 %>% table() %>% prop.table()
enut_hogar[enut_hogar$P2_6_1 == 1,]$P2_7_1 %>% table()
enut_hogar[enut_hogar$P2_6_1 == 1,]$P2_8_1 %>% mean(na.rm = TRUE) # horas totales que trabajaron la semana pasada en promedio
enut_hogar[enut_hogar$P2_6_1 == 1,]$P2_8_1 %>% sd(na.rm = TRUE) # horas totales que trabajaron la semana pasada en promedio

ggplot(enut_hogar[enut_hogar$P2_6_1 == 1,], aes(x = P2_8_1))+
  geom_bar()+
  scale_x_continuous(limits = c(0,50))

# sólo el 6.79% de los hogares contratan trabajadorxs domésticxs de entrada por salida
# que vivan ahí
enut_hogar$P2_6_2 %>% table() %>% prop.table()
enut_hogar[enut_hogar$P2_6_2 == 1,]$P2_7_2 %>% table()

ggplot(enut_hogar[enut_hogar$P2_6_2 == 1,], aes(x = P2_8_2))+
  geom_bar()+
  scale_x_continuous(limits = c(0,50))

# Enfermeras o cuidadoras
enut_hogar$P2_6_3 %>% table() %>% prop.table()
enut_hogar[enut_hogar$P2_6_3 == 1,]$P2_7_3 %>% table()

ggplot(enut_hogar[enut_hogar$P2_6_3 == 1,], aes(x = P2_8_3))+
  geom_bar()+
  scale_x_continuous(limits = c(0,80))



