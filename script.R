# Módulo 1
# Correo profesor: sebastian.massa@mat.uc.cl
# Correo ayudante: bahidalgo@uc.cl
# URL código en vivo: 
# URL consultas: https://cutt.ly/7Ttmteu

# Atajos ------------------------------------------------------------------

# Comentarios en R

# Cmd + Shift + C (Mac) 
# Ctrl + Shift + C (Windows).

# Seccionar líneas de código

# Cmd + Shift + R (Mac) 
# Ctrl + Shift + R (Windows).

# Instalar y leer librería

# install.packages("nombre del paquete")
# library("nombre de librería")

# Ejecutar una línea de código

# Opción 1: Click en botón Run 
# Opción 2: Ctrl + Enter (Windows)
# Opción 3: Cmd + Enter (Mac)

# Introducción a R --------------------------------------------------------

# R como calculadora 

5+5
25/5
2*2
27-2

# Operatoria con más cálculos

sqrt(2^4 + exp(3)/55 - log(5*8-2))
12*(7+2)+(45-32)+8
30-(-2)*(-10)+(-5)*(-2)
520 + 202 * log(25)
2 + 4 * exp(3)
22^2 - 2^2
5 + (5 * 10 + 2 * 3)
log(5) + pi/sqrt(5)
52 + 203 + 1002 + 204

# R como calculadora lógica

20 == 5 # igualdad
30 >= 14 # mayor o igual que
22 <= 2 # menor o igual que
25 != 10 # no es igual a
p = 10; y = 5; p <= y # operatoria en objetos

# Actividad 1: Cálculo aritmético -------------------------------------------------------------

520 + 202 * log(25)
2 + 4 * exp(3)
2^2* sqrt(2)
5 + (5 * 10 + 2 * 3)^2
log(5) + pi/sqrt(5)
5**2 + 20**3 + 100**2 + 20**4

# Actividad 2: Lógica orientada a objetos -------------------------------------------------------------

# ¿Cuál es el valor de a y b? Si a <- 5; b <- a; a <- 4

a <- 5
b <- a
a <- 4
print(a)

# Sea x = 30, w = 5 y z = a^2, ¿qué resultado obtenemos de x * y + z?

x <- 30
w <- 5
z <- a^2
z*y+z

# Almacenar en un objeto el resultado anterior llamado variable_1.

variable_1 <- z*y+z

# ¿Qué resultado obtenemos al dividir variable_1 y z?

variable_1/z

# Asignar el valor 20000 a la variable presupuesto_2020

presupuesto_2020 <- 20000

# Ejecutar variable presupuesto_2020

presupuesto_2020

# Asignar el valor 30000 a la variable presupuesto_2021

presupuesto_2021 <- 30000

# Ejecutar la variable presupuesto_2021

presupuesto_2021

# Crear nueva variable que sea la sumatoria de presupuesto_2020 y presupuesto_2021

presupuesto_global <- presupuesto_2020 + presupuesto_2021

# Actividad 3: secuencias y repeticiones ----------------------------------

# Construya las siguientes repeticiones usando la función rep, no lo haga ingresando número por número.

# 1 2 3 4 1 2 3 4
rep(1:4, times = 2)
rep(seq(from = 1, to = 4, by = 1), 2)
secuencia <- c(1:4, 1:4)

# 1 1 2 2 3 3 4 4
rep(1:4, each = 2)
rep(1:4, times = c(2,2,2,2))

# 1 1 2 3 3 4
rep(1:4, times = c(2, 1, 2, 1))

# 1 1 2 2 3 3
rep(1:3, each = 2)

# Una secuencia de dos en dos comenzando en 1 y finalizando en 200.
seq(from = 1, to = 200, by = 2)
1:200

# Crear un vector con los números de 1 a 17 y extraer los números que son mayores o iguales a 12.
1:17 > 12 # Nos entrega el valor lógico.
which(seq(from = 1, to = 17, by = 1) > 12) # Para entregar la observación y no la posición.
which(1:17 > 12) 

# Actividad 4: Contagios covid --------------------------------------------

# Número de casos Covid-19 diarios según Comuna.

Las_Condes <- c(80, 90, 50, 40, 35)
La_Florida <- c(75, 68, 50, 90, 98)

# Crear vector que contenga los días de la semana.
Dias_contagios <- c("Lunes", "Martes", "Miércoles", "Jueves", "Viernes")

# Asignar los días de la semana al vector Las_Condes y vector La_Florida.
names(Las_Condes) <- Dias_contagios
names(La_Florida) <-  Dias_contagios

# Calcule el total de contagios semanales por comuna.
Total_Las_Condes <- sum(Las_Condes)
Total_La_Florida <- sum(La_Florida)

# Determinar si los contagios en Las Condes son mayores a La Florida

Total_Las_Condes > Total_La_Florida

# Determinar qué día de la semana se encuentra la mayor cantidad de contagios, 
# según comuna.

Las_Condes[which.max(Las_Condes)]
La_Florida[which.max(La_Florida)]

# Elementos adicionales. 

# ¿Qué días fueron mayores a 75 casos diarios por cada comuna?

Las_Condes[which(Las_Condes > 75)]
La_Florida[which(La_Florida > 75)]

names(Las_Condes)[Las_Condes > 75]
names(La_Florida)[La_Florida > 75]

# ¿Qué días fueron menores a 40 casos en la comuna de Las Condes?
Las_Condes[which(Las_Condes < 40)]

# ¿Qué días fueron menores a 68 casos en la comuna de La Florida?
Las_Condes[which(Las_Condes > 68)]

# Actividad 5: Subsetting -------------------------------------------------

Conteo <- data.frame(Candidato = c("Kast", "Boric"),
                     Votos = c("64000", "78000"),
                     Mesas = c("Mesa1", "Mesa1"))

# 1. Seleccionar solo la columna votos
Conteo[, "Votos"]
Conteo[, 2]

# 2. Seleccionar la fila 1 y columna 1 y 2.
Conteo[1, c(1:2)]
Conteo[1, c(1,2)]
Conteo[1, c("Candidato", "Votos")]

# 3. Seleccionar columna 2 mediante operador $.
Conteo$Votos

# 4. Selccionar la fila 1 y columna 1 y 3.
Conteo[1, c(1,3)]
Conteo[1, c("Candidato", "Mesas")]

# 5. Seleccionar fila 2, además de la columna 3.
Conteo[2, 3]

# Síntesis subsetting -----------------------------------------------------

paises <- datos::paises

paises$anio >= 2000 #retornamos TRUE y FALSE
paises[paises$anio >= 2007,] 
paises[paises$anio >= 2007, c(1,3)]  #retornemos solo los países y el filtro.
paises[paises$esperanza_de_vida >= 80, c("pais", "continente")]
paises[paises$pib_per_capita >= 1000 & paises$continente == "Europa",]
paises[!(paises$pib_per_capita >= 1000 & paises$continente == "Europa"),]
subset(x = paises, subset = pais == "Chile", select = c(1:5))

# Actividad 6: Vectores ----------------------------------------------------------------

# 1. Usar "seq()" para crear un vector de 10 números con espacio desde 0 a 12.
vec_num <- seq(from = 0, to = 12, length.out = 10)
trunc(vec_num, 2)

# 2. Usar ":" para crear un vector de valores enteros entre el 31 y 40
vec_int <- c(31:40)

# 3. Usar "LETTERS" ,"[ ]" y "c()" para crear un vector con 9 letras comenzando desde la "C" y que además contenga la "Z"
vec_cha <- c(LETTERS[3:11], "Z")
length(vec_cha)
#4. Usar "letters" y "[ ]" para crear un vector de tipo factor con las primeras 10 letras minusculas.
vec_fac <- factor(letters[1:10])
length(vec_fac)
# 5. Combinar los vectores obtenidos en (3) y (4) usando "c()". No convertir a factor.
vec_let <- c(vec_cha, vec_fac)

# 6. combinar usando "c()" y "[ ]" los primero 4 elemento de "vec_num" 
# con los ultimos 4 elementos de "vec_int"
round(c(vec_num[1:4], vec_int[1:4]), 2)

# extra: sort()
sort(round(c(vec_num[1:4], vec_int[1:4]), 2), decreasing = TRUE)

# Actividad 7: Matrices ----------------------------------------------------------------

# 1. Crear una matriz con 10 filas  y 4 columnas llenas de NA usando "matrix()"
mat.0 <- matrix(nrow = 10, ncol = 4, data = NA)

# 2. Asignar "vec_num" a la primera columna de "mat_1"
mat_1 <- mat.0 # no editar
mat_1[,1] <- vec_num
mat_1 
# 3. Asignar "vec_int" a la ultima columna de mat_2
mat_2 <- mat_1 # no editar
dim(mat_1)
mat_2[,2] <- vec_int
mat_2
# 4. Asignar "vec_cha" y "vec_fac" a las restantes columnas de "mat_2" para obtener "mat_3".
mat_3 <- mat_2 # no editar.
mat_3[,3:4] <- c(vec_cha, vec_fac)
mat_3

# 5. Selecionar la sexta fila de la matriz y guardar en "fila_6" como vector.
fila_6 <- mat_3[6,]

# 6. extraer el elemento asignado en la fila 5 y columna 3 como valor numerico.
valor_5.3 <-  mat_3[5,3] # solo nos indica la letra "g"

# buscamos la posicion de la letra "e"    # Hint: which()
valor_5.3 <- which(mat_3 == "G", arr.ind = TRUE)

# 7. Usando "cbind()" combinar "vec_num", "vec_int", "vec_cha", y "vec_fac" en "mat_4".
mat_4 <- cbind(vec_num, vec_int, vec_cha, vec_fac)

# 8. Reordenar las columnas de "mat_4" para que sea igual a "mat_3"
mat_ord <- cbind(mat_4, mat_3)
mat_ord[4]

# 9. Trasponer la matriz mat_4 y extraer solo las primeras 4 columnas. 
# Almacenar en vector mat_ord.

mat_ord <- t(mat_4)[, 1:4]
mat_t <- t(mat_4)[, 6:10]

# 10. Usar rbind() y añadir mat_4 y mat_3
mat_final <- rbind(mat_4, mat_3)
mat_final

# 11. Asignar filas y columnas con comando paste() y rep()

row.names(mat_final) <- paste("fila", rep(1:20))
colnames(mat_final) <- paste("columna", rep(1:4))
mat_final

