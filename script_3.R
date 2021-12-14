# Sección 1.1: Creación de un dataframe (Forma 1) ---------------------------

# La norma primaria de calidad del aire para material particulado fino es veinte 
# microgramos por metro cúbico (20 µg/m3), como concentración anual, 
# y cincuenta microgramos por metro cúbico (50 µg/m3), como concentración de 24 horas.


ciudad <- c("Santiago","Los Ángeles","Concepción",
            "Temuco","Puerto Montt","Antofagasta")
region <- c("RM","Bío Bío", "Bío Bío", "La Araucanía",
            "Los Lagos", "Antofagasta")
cantidad <- sample(x = 10:50, size = 6, replace = TRUE)
DF1 <- data.frame(ciudad,region,cantidad)

head(DF1)

# Recordatorio: ¿Es "=" igual a "<-"?

DF1.2 <- data.frame(ciudad <- c("Santiago","Los Ángeles","Concepción",
                                "Temuco","Puerto Montt","Antofagasta"),
                    region <- c("RM","Bío Bío", "Bío Bío", "La Araucanía",
                                "Los Lagos", "Antofagasta"),
                    sample(x = 10:50, size = 6, replace = TRUE))
head(DF1.2)

# Sección 1.2: Creaci?n de un dataframe (Forma 2) ---------------------------

ciudad <- c("Santiago","Los Ángeles","Concepción",
            "Temuco","Puerto Montt","Antofagasta")
region <- c("RM","Bío Bío", "Bío Bío", "La Araucanía","Los Lagos", "Antofagasta")
cantidad <- sample(x = 10:50, size = 6, replace = TRUE)
Matriz <- cbind(ciudad,region,cantidad)
class(Matriz) # ?Es una matriz!

DF2 <- as.data.frame(Matriz)
class(DF2) # Ahora si es un dataframe

# Sección 2: Manipulaci?n de un dataframe -----------------------------------

# head(data, k)
# tail(data, k)
# dim(data)
# length(data)
# names(data)
# attach(data) (no recomendado)
# Operador "$"

# Sección 3: Taller práctico ------------------------------------------------

# install.packages("datos")
library(datos)
datos <- datos::paises

head(datos, 3) # Se visualizan las primeras tres tuplas del dataframe

tail(datos, 3) # Se visualizan las ?ltimas tres tuplas del dataframe

dim(datos) # ?Cu?ntas observaciones y variables tiene el dataframe?

length(datos) # ?Cu?ntas variables tiene el dataframe?

names(datos) # ?Cu?les son los nombres de las variables del dataframe?

head(datos$anio, 15) # ?C?mo rescatamos una variable en particular?

# Sección 4.1: Creación de un tibble ----------------------------------------

library(tibble)
tibble_DF1 <- tibble(ID = 1:100,
                     Numero = rnorm(100),
                     Sexo = rbinom(100, 1, 0.4))
tibble_DF1

# Sección 4.2: tibble vs dataframe ------------------------------------------

dataframe_DF1 <- as.data.frame(tibble_DF1)

head(dataframe_DF1, 3)
head(tibble_DF1, 3)

head(dataframe_DF1$Num, 3)
head(tibble_DF1$Num, 3) # Sensible a los nombres exactos de variables

# Sección 5: Importaci?n y exportaci?n de datos -----------------------------

# IMACEC: Indicador de corto plazo (principal) que permite analizar tendencias al 
# alza o a la baja  del mercado y el comportamiento productivo de Chile. 
# Su evolución representa una aproximación de la evolución del PIB

# Estimación que resume la actividad de los distintos sectores de la economía 
# en un determinado mes, a precios del año anterior

# El cálculo del Imacec se basa en múltiples indicadores de oferta que 
# son ponderados por la participación de las actividades económicas 
# dentro del PIB en el año anterior.

# 1. Producción de Bienes
# a. Minería
# b. Industria manufacturera
# c. Resto de bienes
# 2. Comercio
# 3. Servicios

# if (!require("readxl")) {
#   install.packages("readxl")
#   library(readxl)
# }

IMACEC <- readxl::read_excel(path = "data/Data_IMACEC.xlsx", sheet = 1)

# Sección 6.1: An?lisis exploratorio (glimpse vs str) -----------------------

dplyr::glimpse(IMACEC)
str(IMACEC)

# Sección 6.2: An?lisis exploratorio (summary) ------------------------------

summary(IMACEC)

# Sección 6.3: An?lisis exploratorio (skimr) --------------------------------

#install.packages('skimr')
library(skimr)
skimr::skim(IMACEC)

# Extra: 
Hmisc::describe(IMACEC)

# Sección 7: Problemas de importación de datos básicos ----------------------


# Sección 8.1: Observaciones agrupadas: Columnas combinadas -----------------

# Existen distintos packages para cuando las tablas no vienen en 
# formato tidy,  sino con varios headers e incluso headers al lado 
# izquierdo. Para ello, podemos  utilizar los paquetes tidyxl, 
# unpivotr o también openxlsx.

#install.packages('openxlsx')
library(openxlsx)

# Cargar data base combinada
df <- openxlsx::read.xlsx(file.choose(), fillMergedCells = T)

head(df)

# Sección 8.2: Observaciones agrupadas: Columna NO combinada ----------------

# Carga base data no combinada
df <- openxlsx::read.xlsx(file.choose()) 

library(dplyr)

df %>% tidyr::fill(Mes, .direction = "down") # Mayor éxito


# Guardar bases de datos --------------------------------------------------

# ¿PERO CÓMO GUARDAR BASES DE DATOS?
  
data_1 <- data.frame(datos = sample(x = 200, size = 30, replace = TRUE),
                       cliente = paste("Cliente", rep(1:30)))

data_2 <- data.frame(datos = sample(x = 200, size = 30, replace = TRUE),
                     cliente = paste("Cliente", rep(1:30)))

data_3 <- data.frame(datos = sample(x = 200, size = 30, replace = TRUE),
                     cliente = paste("Cliente", rep(1:30)))

library(readxl)

writexl::write_xlsx(list("sheet1" = data_1, 
                         "sheet2 "= data_2, 
                         "sheet3" = data_3), 
                    path = "data/data.xlsx")


# ¿Y SI QUIERO EN PDF?
  
library(gridExtra). #cuadrícula extra.
pdf("test.pdf", height=11, width=10)
grid.table(data_1)
dev.off()






