# Funciones en R ----------------------------------------------------------

# Diferencia entre log(100, 10) y log(10, 100)
log(100,10)
log(10,100)

# En el primero calculamos el logaritmo de 100 en base 10, en el segundo 
# calculamos el logaritmo de 10 en base 100

# Lo que ya vimos la clase pasada:

# Objetos en R ----------------------------------------------------------
# Colección de información indexada.

# Creamos un objeto con operador de asignación
# objeto <- valor

numero <- 256
resultado <- sqrt(numero)
resultado

# También vimos que podíamos sobreescribir un objeto:
a <- 5
b <- a
a <- 3

# ¿Valor de A?
a
# ¿Valor de B?
b

# Algunos comando útiles

ls() # Mostrar objetos creados
rm(a) # Remueve objeto a
rm(list = ls()) # Remueve toda la memoria

# R es sensible a mayúsculas y minúsculas ---------------------------------

polera <- c(254,203,182,50)
mean(Polera)
sum(poleras)

# Estructuras de datos en R -----------------------------------------------

# 1. Vector ---------------------------------------------------------------
# Se definen con el comando c() y cada elemento se separa con una coma.
# Son un conjunto de escalares. Un escalar es un valor que posee un 
# valor fijo como constante. En términos matemáticos, es una matriz con una 
# dimensión. En términos estadísticos, lo entenderemos como variable.

vector <- c(60,20,32,45,50)
class(vector) 

# Funciones para generar vectores
rep(1:6, times = 2) # Repetir secuencia 2 veces.
rep(1:5, each = 2) # Repetir cada número de la secuencia 2 veces.
rep(1:4, times = c(2,2,2,2)) # Lo mismo que lo anterior
seq(from = 1, to = 20, by = 2)

# Funcionalidades adicionales
length(vector) # Largo de un vector
is.vector(vector) # Comprueba si la clase se condice con nuestro objeto.
as.vector(vector) # Transformar un objeto a vector.
which(seq(from = 1, to = 17, by = 1) > 12)

# Seleccionar elemento de un vector
vector[1] # Extraer el elemento 1 del vector llamado vector

# Solución tarea vectores -------------------------------------------------

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

# 2. Matrices -------------------------------------------------------------

matrix <- matrix(data = c(20,5,10,15), nrow = 2, ncol = 2)
colnames(matrix) <- c("Vote", "No vote")
row.names(matrix) <- c("ABC1", "C2")
matrix

# Concatenar vectores

v_1 <- 1:5
v_2 <- LETTERS[1:5]
cbind(v_1, v_2)
rbind(v_1, v_2)

# Solución tarea matrices -------------------------------------------------

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


# 3. Dataframe ------------------------------------------------------------
# Arreglo de datos en una estructura bi-dimensional. A diferencia de una matriz, 
# un data frame puede tener columnas de distintos tipos de datos. 

# Crear un dataframe

# Forma 1
mes <- c("Ene", "Feb", "Mar", "Abr", "May")
anio <- rep(2018, times = length(mes))
data <- data.frame(anio, mes)

# Forma 2
data <- data.frame(mes = c("Ene", "Feb", "Mar", "Abr", "May"),
                   anio = rep(2018, times = length(mes)))

# Actividad práctica

nombre <- c("Andrea", "Bastian", "Camilo", "Daniela")
grupo_s <- c("AB", "0", "A", "B")
altura_cm <- c(165, 180, 158, 170)

data <- data.frame(nombre, grupo_s, altura_cm)
data <- data.frame(nombre = c("Andrea", "Bastian", "Camilo", "Daniela"),
           grupo_s = c("AB", "0", "A", "B"),
           altura_cm = c(165, 180, 158, 170))

# Selección de observaciones de un data frame

data[1,] # Fila 1
data[2, 1] # Fila 2, columna 1.
data[3, c("altura_cm")] # Fila 3 y columna altura_cm
data$grupo_s # Rescate con signo peso.
data[, c("nombre", "altura_cm")]

# Ahora realizarán la siguiente actividad que está en el Drive:
# Actividad Subsetting -------------------------------------------------

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

# Operadores lógicos  -----------------------------------------------------

paises <- datos::paises

paises$anio >= 2000 #retornamos TRUE y FALSE
paises[paises$anio >= 2007,] 
paises[paises$anio >= 2007, c(1,3)]  #retornemos solo los países, año y el filtro.
paises[paises$esperanza_de_vida >= 80, c("pais", "continente")]
paises[paises$pib_per_capita >= 1000 & paises$continente == "Europa",]
paises[!(paises$pib_per_capita >= 1000 & paises$continente == "Europa"),]
subset(x = paises, subset = pais == "Chile", select = c(1:5))
paises[paises$pais %in% c("Chile", "Brasil", "Argentina"),]



