# Clase 4
# Manipulación y otras estructuras de datos

# Recordatorio ------------------------------------------------------------

library(guaguas)

guaguas <- guaguas::guaguas

# Análisis exploratorio 

names(guaguas)
unique(guaguas$nombre)
length(guaguas)
class(guaguas)
sapply(guaguas, FUN = class)
dplyr::glimpse(guaguas)
str(guaguas)
skimr::skim(guaguas)
View(guaguas)

# Operadores lógicos y subsetting

guaguas$anio 
guaguas[, c("anio", "nombre", "sexo")]
guaguas[1:50, c("nombre", "anio")]
guaguas[guaguas$anio > 2000,]
guaguas[guaguas$anio > 2000 & guaguas$nombre %in% c("Sebastián", "Javiera"),]
guaguas[guaguas$nombre == "Claudio" & guaguas$n >= 100,]
guaguas[!(guaguas$anio == 2000 | guaguas$anio == 1920),]
guaguas[guaguas$nombre == "Jesús" & guaguas$sexo == "F",]
subset(x = guaguas, subset = guaguas$nombre == "María", select = c(1,3))
guaguas[which(guaguas$nombre %in% c("María", "Claudio", "Sebastián")),][1:5,]
guaguas$nombre[guaguas$sexo == "F"]

# Coerción explícita

Titanic
class(Titanic)
as.data.frame(Titanic)
tibble::as_tibble(Titanic)

# Paquete janitor ---------------------------------------------------------
# Creemos una base de datos desde cero, con el objeto de poner en práctica 
# lo que hemos visto en las sesiones anteriores.

# Supongamos que deseamos crear una base de datos de clasificación de tipos de cerveza.
# ¡Por si no lo sabían, les comento un poco sobre las etapas de la cerveza! 

# 1. Molienda
# 2. Maceración (grano se disuelve en agua. Luego, se hierve el producto durante 90 min a 50, 60, 78 grados, a fin de extraer color, azúcar y proteínas)
# 3. Líquido Mosto (bondades del grano)
# 4. Mezcla Mosto con lúpulo a cocción (100º grados para disolver amargor del lúpulo).
# 5. Enfriar mosto a temperatura óptima para determinado tipo de levadura (azucar en alcohol y gas carbónico)
# 6. Maduración (baja temperatura a 0 grados, para dejar que la cerveza repose)

base <- data.frame(Categoría = c("IPA","Lager","Porter", "Lambic","Weissbier"), 
                   `Cantidad Lupulo` = c("Alto","Bajo","Medio", "Bajo", "Bajo"),
                   Caracter = c("Amarga", "Amarga", "Ácido", "Ácido", "Ácido"),
                   Acentuación = c("Lúpulo-frutal", 
                                     "Terroso-frutal", 
                                     "Chocolate-tostado", 
                                     "Ácido-Frutal",
                                     "Cítrico-trigo"),
                     IBU = c(93.2, 38.5, 55.2, 63.5, 68.7),
                     Criterio_evaluar = rep(NA, 5))

janitor::clean_names(base)
janitor::remove_empty(base, which = c("cols"))
janitor::get_dupes(base, Categoría)
janitor::adorn_percentages(base, denominator = "col")
janitor::adorn_pct_formatting(base, digits = 0)

# Paquete string ----------------------------------------------------------

# Expresiones regulares
# Una manera de describir patrones específicos de caracteres en un texto.
# Son códigos que sintetizan los caracteres.

# \d cualquier dígito
# \w cualquier caracter de palabra
# \s espacio en blanco
# \b límite de palabra
# \D cualquier no dígito
# \W cualquier cosa que no sea caracter de palabra
# \S cualquier cosa que no sean espacios en blanco.
# . cualquier caracter, excepto un salto de línea.

# Posición del patrón dentro de la cadena

# ^: Principio de la cadena,
# $: Final de la cadena.

# Cuantificadores:

# *: El carácter puede aparecer al menos 0 veces.
# +: El carácter puede aparecer al menos 1 vez.
# ?: El carácter puede aparecer hasta 1 vez.

# Otra notación

# [:digit:] o \d. Dígitos del 0 al 9, equivalente a [0-9].
# \D: Inverso de \d, es decir, equivalente a [^0-9].
# [:lower:]: Minúsculas, equivalente a [a-z].
# [:upper:]: Mayúsculas, equivalente a [A-Z]
# [:alpha:]: Mayúsculas y minúsculas.
# [:alnum:]: Caracteres alfanuméricos. Dígitos, mayúsculas y minúsculas. Equivalente a \w.
# \W: Inverso de w.
# [:blank:]: Espacio y tabulación.
# [:space:]: Espacio: tabulación, nueva línea, retorno de línea y espacio.
# [:punct:]: Puntuación.

# Ejemplos strings --------------------------------------------------------

install.packages(stringr)
library(stringr)

# Últimos dos números que estén al final de una cadena de texto
criterio <- c("ABC12")
patron <- "\\d{2}"
stringr::str_view(criterio, patron)

# Rescatar 1 o 3 dígitos de una cadena

criterio <- c("123A", "a4", "b")
patron <- "^\\d{1,3}"
stringr::str_view(criterio, patron)

# Rescatar los que dicen Univ y U, para reemplazar por otro patrón.
universidades <- c("U. Chile", 
                   "Univ Católica",
                   "Univ. de Concepción",
                   "Universidad Adolfo Ibañez", 
                   "U del Bío Bío")

patron <- "^Univ\\.?\\s|^U\\.?\\s"
stringr::str_view(universidades, patron)

numeros <- c("5,9", "5,11", "6,a", "6,3")
patron <- "^[4-7],\\d*$" 
stringr::str_detect(numeros, patron)
stringr::str_view(numeros, patron)

x <- c("Sebastián", "Sebastian", "Sebasti@n")
y <- "Hoy aprenderemos expresiones regulares en el curso"

# Rescatar una expresión
substring(x, first = 4, last = 9) 
# Longitud de caracteres
nchar(x) 
# Concatenar con separador
paste(x, y, sep = " ")
# Concatenar sin separador
paste0(x, y)
# Concatenar
cat(x, y, sep = ". ")
# Sustituir caracteres en una cadena de texto.
chartr("e", "a", x) 
# Minúscula
tolower(x) 
# Mayúscula
toupper(x) 
# Reemplazar expresión regular
stringr::str_replace(string = x, pattern = "Sebasti[a|@]n", replacement = "Sebastián") 
# Detecta patrón lógico en cadena de texto.
stringr::str_detect(string = x, pattern = "@") 
# Posición en la cadena de texto.
stringr::str_which(string = x, pattern = "@") 
grep(pattern = "@", x = x) 
# Encuentra patrones lógicos de la expresión regular en la cadena
stringr::str_detect(string = x, pattern = "Sebasti[a|á|@]n")
grepl(pattern = "Sebasti[a|á|@]n", x = x) 
# Extraer patrón de una cadena de texto.
stringr::str_extract(string = x, pattern = "Sebasti[a|á]n")

# Tratamiento de fechas -------------------------------------------------------

# Para ver nuestra configuración regional usamos la siguiente función
Sys.getlocale("LC_TIME")
# Sys.setenv("LANGUAGE" = "Spanish")
# Sys.setlocale("LC_TIME", "es_ES")

Sys.Date()
as.Date("2021-11-17")
class(as.Date("2021/11/17"))
as.Date("Nov-17-2021", format = "%b-%d-%y")

dia1 <- as.Date("25/12/2012",format="%d/%m/%Y")
dia2 <- as.Date("20/1/2013",format="%d/%m/%Y")
dia2-dia1

# Utilizar secuencia de fechas
inicio <- as.Date("2021-01-01")
fin <- as.Date("2021-12-31")
seq(from = inicio, to = fin, by = 1)

# install.packages("lubridate")
library(lubridate)

lubridate::today()
lubridate::now()
lubridate::hour(lubridate::now())
lubridate::minute(lubridate::now())
lubridate::second(lubridate::now())
lubridate::make_date(year = 2021, month = 11, day = 17)
lubridate::dmy('17112021')
lubridate::mdy("July 4th, 2000")
lubridate::ymd(20170131)
lubridate::ymd("1970 May 17")
lubridate::ymd(20170713) + lubridate::years(5)


# Paquete skimr -----------------------------------------------------------

skimr::skim(base)
skimr::to_long(base) # Examen exhaustivo de las variables
base %>% skimr::skim() %>% skimr::is_skim_df() # Testea si es de tipo skim
base %>% skimr::skim() %>% skimr::focus(n_missing) # Selecciona variables

# Paquete naniar ----------------------------------------------------------

library(naniar)

is.na(base)
sum(is.na(base))
any(is.na(base))  # al menos un NA
which(is.na(base))

for (i in 1:length(base)) {
  print(sum(is.na(base[i])))
}

purrr::map_dbl(base, .f = function(x){sum(is.na(x))})

naniar::n_miss(base)
naniar::n_complete(base)
naniar::prop_miss(base)
naniar::miss_var_summary(base)
naniar::miss_case_table(base)
naniar::vis_miss(base)
naniar::gg_miss_fct(base, Caracter)

# Factores ----------------------------------------------------------------

NSE <- c("ABC1", "C2", "C3", "D", "E")
NSE <- sample(NSE, size = 500, replace = TRUE)
Candidatos <- c("Kast", "Boric")
Candidatos <- sample(Candidatos, size = 500, replace = TRUE)

resultados <- data.frame(NSE = as.factor(NSE), 
                         Candidatos = as.factor(Candidatos))

tabla <- table(resultados$NSE, resultados$Candidatos)
prop.table(tabla)
addmargins(tabla, 2) # Fila
addmargins(tabla, 1) # Columna

# Definir niveles factor
resultados$NSE <- factor(resultados$NSE, levels = c("C2", "C3", "D", "E", "ABC1"))
resultados$NSE

