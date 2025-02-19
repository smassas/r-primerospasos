library(tidyverse)
library(readxl) 
library(readxl)
library(moments)
library(htmlTable)
library(gridExtra)

if(!dir.exists("datos")) dir.create("datos")

# Instalar librerías para importar datos --------------------------------------

# Formato XLSX
data <- readxl::read_xlsx(path = "datos/base_bancos.xlsx", sheet = 1) 

# Mecanismo alternativo
# library(rio)
# data <- import(file.choose())

# Análisis exploratorio de datos ------------------------------------------

head(data) # Muestra las primeras filas de un objeto (base de datos)
tail(data) # Muestra las últimas filas de un objeto (base de datos)
names(data) # Muestra los nombres de las variables de un objeto (base de datos)
View(data) # Muestra el 100% de la base de datos u objeto
summary(data) # Da un resumen rápido de un objeto (base de datos)

# install.packages(skimr)
# library(skimr)
# skimr::skim(data)

# install.packages(Hmisc)
# Hmisc::describe(data)

# Tablas de frecuencias  ------------------------------------------------------------------

# 1. ¿Cuántos clientes son profesionales, según comuna?
table(data$Comuna) # genera una tabla de frecuencia
tabla <- table(data$Comuna, data$Profesion) # Genera una tabla de doble entrada
tabla

addmargins(tabla) # Agrega las sumas totales
addmargins(tabla, margin = 1) # Agrega las sumas totales por columnas
addmargins(tabla, margin = 2) # Agrega las sumas totales por filas

# Lo anterior nos permite calcular probabilidades de enfoque empírico 
# (sustentadas en frecuencias relativas) a partir de tablas de contingencia.

# Probabilidad: es una medida numérica que varía entre cero y uno, 
# que describe la posibilidad de ocurrencia de un evento o suceso.

# Las probabilidades empíricas no son equiprobables.
# los resultados de un espacio muestral no tienen la misma probabilidad 
# de suceder. Ejemplo: Se aprueba o no aprueba el curso.

# P(A) = Frecuencia de A / total de casos
# P(Las Cisterna) = 94/598
# P(NO profesional) = 258/598

# P(La Cisterna & NO) = 77/598
# P(A & B) = P(A|B) * P(B)

# P(San Ramón | NO) = 70/258
# P(A | B) = P(A & B) / P(B). 

#¿Por qué? 
# (Resultados favorables a A & B / totales) / 
# (Resultados favorables a B / totales)

# P(San Ramón & No) / P(No)
# (70/598) / (258/598)

tabla_prop <- prop.table(tabla)# Entrega las proporciones globales
addmargins(tabla_prop) # Entrega las proporciones por filas y columnas
round(addmargins(tabla_prop), digits = 4)*100 # Redondear o pasar a porcentaje

# El porcentaje de 100% fue repartido, dividido, distribuido al anterior de las 
# celdas. Por lo tanto, me muestran la distribución porcentual.

# ¿Cómo interpretamos?
# Un 12% de todos los clientes, que no tienen profesión y que son de La Cisterna.
# Un 14% de todos los clientes, que no tienen profesión y que son de Lo Prado

# Si tomamos cada una de las columnas, como un subconjunto, 
# cada una de ellas tendrá un 100%. 

prop.table(tabla_prop, margin = 2) # Entrega las proporciones por columnas
round(prop.table(tabla_prop, margin = 2), digits = 4)*100

# Si tomamos cada una de las filas, como un subconjunto, 
# cada una de ellas tendrá un 100%.

# ¿Cómo interpretamos?
# De todo el conjunto de los clientes que no tienen profesión, el 27% proviene
# de la comuna de San Ramón.

prop.table(tabla_prop, margin = 1) # Entrega las proporciones por filas
round(prop.table(tabla_prop, margin = 1), digits = 4)*100

# ¿Cómo interpretamos?
# De todos los clientes de la comuna de Las Condes, el 94% declara ser 
# profesional.

# 2. Agrupar clientes bancarios a partir de rangos etareos y ver quiénes solicitan crédito.
# Si la/as variables son continuas, pueden categorizarse mediante intervalos.
table(data$Edad)

# Recodifiquemos a tres tramos.
# Todos los que están entre 18 y 30 año, categoría 1 (joven).
# Todos los que están entre 31 y 45 años, categoría 2 (adulto joven)
# Todos los que están entre 46 y 60 años, categoría 3 (adulto)
# Todos los demás, 4 (adulto mayor).

tramos <- data %>% mutate(Tramo_edad = car::recode(Edad, "18:30 = 1; 31:45 = 2; 
                                      46:60 = 3; else = 4")) 

# tramos <- data %>% mutate(Tramo_edad = 
#                             case_when(Edad <= 30 ~ "Joven",
#                                       Edad >= 30 & Edad <= 45 ~ "Adulto joven",
#                                       Edad >= 45 & Edad <= 60 ~ "Adulto",
#                                       TRUE ~ "Adulto mayor")) 

table(tramos$Solicitud, tramos$Tramo_edad)

# Regla de Sturges
# K = 1 + 3.332 * log10(N)

# Hallar el rango
R <- max(data$Edad) - min(data$Edad)
# Hallar el n (número de datos)
n <- nrow(data)

# Hallar número de intervalos: fórmula para determinar 
K <- 1 + 3.332 * log(n, base = 10) #n es el número de datos.
K
# Obtener amplitud o ancho de clase (cociente del rango y número de intervalos)
W <- R / K
W

# Se aproxima al número impar más cercano. 
trunc(W)
round(W)

grDevices::nclass.Sturges(data$Edad)

# 3. ¿Cuántos hijos tienen los clientes que solicitan crédito en edad escolar?

table(data$Hijos)

data %>% 
  filter(Credito == 1) %>% 
  select(Credito, Hijos) %>% 
  group_by(Hijos) %>% 
  summarize(n = n()) %>% 
  mutate(Freq_abs_acum = cumsum(n),
         Freq_rel = round(n/sum(n), digits = 4),
         Freq_rel_acum = cumsum(Freq_rel))

# El 37% de los clientes que solicita crédito no tiene hijos.
# El 69% de los clientes tiene por lo menos 1 hijo en edad escolar.

# Medidas de tendencia central --------------------------------------------

# 4. ¿Cuál es el ingreso promedio mensual por comuna?
mean(data$Ingreso_mensual[data$Comuna == "Las Condes"])
mean(data$Ingreso_mensual[data$Comuna == "Vitacura"])
aggregate(data$Ingreso_mensual ~ data$Comuna, FUN = mean)

# Formato número con puntos y símbolo $.
# paste0("$", format(as.numeric(data$Ingreso_mensual), big.mark= "."))

# 5. ¿Cuál es la edad promedio de hombres (1) y mujeres (0) que solicitan crédito?
data$Sexo_reco = ifelse(data$Sexo==1,"Hombre","Mujer")
mean(data$Edad[data$Sexo == "1" & data$Credito == "1"], na.rm  = TRUE)
mean(data$Edad[data$Sexo == "0" & data$Credito == "1"], na.rm  = TRUE)

# Opción 2
data %>% 
  mutate(Sexo_reco = ifelse(Sexo == "1", "Hombre", "Mujer")) %>% 
  filter(Credito == "1") %>% 
  group_by(Sexo_reco) %>% 
  summarize(Edad_promedio = mean(Edad, na.rm = TRUE)) 

# Opción 3
Prom_hombre <- subset(x = data, subset = Sexo == "1")
Prom_hombre <- mean(Prom_hombre$Ingreso_mensual, na.rm = TRUE)
Prom_hombre

# 6. ¿Cuál es la mediana de ingreso mensual en Lo Prado?

median(data$Ingreso_mensual[data$Comuna == "Lo Prado"])

library(modeest); mfv(data$Edad)

# Medidas de posición -----------------------------------------------------

# Cuartiles: Agrupan 25% cada uno (son 3).
# Quintiles: Agrupan 20% cada uno (son 4).
# Deciles: Agrupan 10% cada uno (son 9).
# Percentiles: Agrupan 1% cada uno (son 99)

# 7. ¿Cómo se agrupan los ingresos de todos los clientes?
quantile(x = data$Ingreso_mensual) # Entrega los cuartiles
quantile(x =data$Ingreso_mensual, probs = 0.25) # Entrega el/los percentiles deseados

# Medidas de dispersión ---------------------------------------------------

# 8. ¿Entre qué rangos se encuentra el ingreso mensual de San Ramón?
range(data$Ingreso_mensual[data$Comuna == "San Ramón"]) 

# Es lo mismo si es que calculemos el mínimo y el máximo.
min(data$Ingreso_mensual[data$Comuna == "San Ramón"])
max(data$Ingreso_mensual[data$Comuna == "San Ramón"])

data %>% 
  filter(Comuna == "San Ramón") %>% 
  group_by(Comuna) %>% 
  summarize(min = min(Ingreso_mensual, na.rm = TRUE),
            max = max(Ingreso_mensual, na.rm = TRUE))

# 9. ¿Cuál es el rango intercuartil de la edad de clientes en la comuna de Providencia?
IQR(data$Edad) 
IQR(data$Edad[data$Comuna == "Providencia"])

# Entrega el rango intercuartil. Diferencia o distancia entre el 3er y el 1er cuartil. 
# Conforme aumente el IQR, indicará que la dispersión será mayor.
# Si hay mucha asimetría, se sugiere medir tendencia central con mediana y IQR.

# Calcula la desviacion estándar
sd(data$Ingreso_mensual[data$Profesion == "SI"]) 

# Calcula la varianza
var(data$Ingreso_mensual[data$Profesion == "NO"]) 

# 10. ¿Hay ingresos mensuales atípicos en la comuna de La Cisterna?

# Los valores atípicos pueden tener un efecto desproporcionado en los resultados 
# estadísticos, como la media, lo que puede conducir a interpretaciones engañosas

# Los datos que son más de 1.5 veces el valor del rango intercuartílico o, mejor dicho, 
# que se encuentran a esa distancia del primer y tercer cuartil, se denominan 
# valores atípicos.

Q1 <- quantile(data$Ingreso_mensual[data$Comuna == "La Cisterna"], probs = c(0.25))
Q3 <- quantile(data$Ingreso_mensual[data$Comuna == "La Cisterna"], probs = c(0.75))

LI <- Q1 - 1.5 * (Q3 - Q1)
LS <- Q3 + 1.5 * (Q3 - Q1)

# Si X (variable) es <= LI: outlier
# Si X (variable) es >= LS: outlier 

data$Ingreso_mensual[data$Comuna == "La Cisterna"] <= LI
data$Ingreso_mensual[data$Comuna == "La Cisterna"] >= LS

which(data$Ingreso_mensual[data$Comuna == "La Cisterna"] >= LS) 
data$Ingreso_mensual[data$Comuna == "La Cisterna"][1]
data$Ingreso_mensual[data$Comuna == "La Cisterna"][25]

which(data$Ingreso_mensual[data$Comuna == "La Cisterna"] <= LI) 
data$Ingreso_mensual[data$Comuna == "La Cisterna"][3]

data %>% dplyr::filter(Comuna == "La Cisterna" & 
                         Ingreso_mensual >= LS |
                         Ingreso_mensual <= LI) 

# Calcula el error estándar
sd(data$Ingreso_mensual)/sqrt(length(data$Ingreso_mensual)) 

# Calcula el coeficiente de variación
sd(data$Edad)/mean(data$Edad) 

# Interpretación relativa del grado de variabilidad, 
# independiente de la escala de la variable.

# Si el C.V es menor o igual al 30%, significa que la media aritmética es 
# representativa del conjunto de datos, por ende el conjunto de datos es "Homogéneo".

# La variable edad presenta una dispersión del 34,06% 
# según el valor obtenido en el coeficiente de variación

# Estadísticos de forma  -------------------------------------------------

library(moments) # Paquete que permite calcular la curtosis y coeficiente de asimetría

# 11. ¿Cuál es la forma de distribución del ingreso? 

moments::skewness(data$Ingreso_mensual) 

# Asimetría 
# Si asimetría es < 0: con cola a la izquierda (moda > mediana > media )
# Si asimetría es > 0: con cola a la derecha (sesgo positivo) (Moda < Mediana < Media)
# Si asimetría es = 0: no hay asimetría, la distribución es simétrica (converge moda, mediana y media)

moments::kurtosis(data$Ingreso_mensual) 
# Curtosis
# Si curtosis es > 0: leptocúrtica (datos concentrados alrededor de la media)
# Si curtosis es < 0: platicúrtica (muy poca concentración de datos alrededor de promedio).
# Si curtosis es = 0: mesocúrtica (distribuye normal)

# 12. ¿Cuál es el ingreso mensual de cada cliente?

ingreso_comuna <- data %>% 
  dplyr::select(Comuna, Ingreso_mensual) %>% 
  dplyr::group_by(Comuna) %>% 
  dplyr::summarise(Promedio_ingreso = mean(Ingreso_mensual, na.rm = TRUE),
                   Mediana_ingreso = median(Ingreso_mensual, na.rm = TRUE),
                   SD = sd(Ingreso_mensual, na.rm = TRUE),
                   Q1 = quantile(Ingreso_mensual, probs = c(0.25), na.rm = TRUE),
                   Q3 = quantile(Ingreso_mensual, probs = c(0.75), na.rm = TRUE),
                   Curtosis = moments::kurtosis(data$Ingreso_mensual, na.rm = TRUE),
                   Asimetria = moments::skewness(data$Ingreso_mensual, na.rm = TRUE))

data %>% 
  dplyr::group_by(Comuna) %>% 
  dplyr::summarise_at(vars(Ingreso_mensual), list(~n(),
                                                  ~mean(.x, na.rm = TRUE),
                                                  ~median(.x, na.rm = TRUE),
                                                  ~quantile(.x, probs = c(0.25)),
                                                  ~quantile(.x, probs = c(0.75)),
                                                  ~sd(.x, na.rm = TRUE))) %>% 
  mutate(mean = paste0("$", format(as.numeric(mean), big.mark= ".")))


# Guardar ejercicio anterior en Excel ------------------------------------------------

writexl::write_xlsx(x = ingreso_comuna, path = "datos/ingreso_comuna.xlsx",
                    col_names = TRUE)

#Ya, pero ahora queremos guardar algunas comunas en distintas hojas.

# Opción split

data_comunas <- data %>% dplyr::group_split(Comuna) 

# data_nest <- data %>% group_by(Comuna) %>% nest()

writexl::write_xlsx(list("La Cisterna" = data_comunas[[1]], 
                         "Las Condes"= data_comunas[[2]], 
                         "Lo Prado" = data_comunas[[3]], 
                         "Ñuñoa" = data_comunas[[4]],
                         "Providencia" = data_comunas[[5]],
                         "San Ramón" = data_comunas[[6]],
                         "Vitacura" = data_comunas[[7]]),
                    path = "datos/data_comunas.xlsx")

# Otra opción por defecto.
split(data, f = data$Comuna) # Separemos la data de acuerdo a factores

#Rescatemos elementos de las listas

split(data_set, f = data_set$tienda)[[1]][[1]]
split(data_set, f = data_set$tienda)[[2]][[1]]
split(data_set, f = data_set$tienda)[[3]][[1]]

# Guardar en PDF ----------------------------------------------------------

pdf("ingreso_comunas.pdf", height=11, width=10)
gridExtra::grid.table(ingreso_comuna)
dev.off()

# Guardar en HTML

htmlTable(ingreso_comuna)

# Guardar en R Data

save(ingreso_comuna, file= "ingreso_comuna.Rdata")
load("ingreso_comuna.Rdata")

# Correlación lineal ------------------------------------------------------

# Ambas categóricas: coef. de Chi-cuadrado Pearson, coef. de Phi de Pearson, entre otros.
# Ambas continuas: coef. de correlación lineal, coef.de Spearman, entre otros.
# Una categórica y una contínua: coef. f de Cohen, coef. biserial, test de independencia, 
# test de medias.

Mailings <- c(96, 40, 104, 128, 164, 76, 72, 80, 84, 180, 44, 36)
Conversiones <- c(41, 41, 51, 53, 60, 61, 50, 28, 48, 70, 33, 30)

x <- data.frame(Mailings, Conversiones)

sum_producto <- x %>% 
  mutate(x_barra = Mailings - mean(Mailings),
         y_barra = Conversiones - mean(Conversiones),
         producto = round(x_barra * y_barra, digits = 1)) %>% 
  summarise(sum_prod = sum(producto)) 

sum_producto/((nrow(x)-1)*sqrt(var(Mailings))*sqrt(var(Conversiones)))

cor(Mailings, Conversiones)

