library(tidyverse)
library(openintro)
oscars <- openintro::oscars

# Sintaxis dplyr ----------------------------------------------------------

# El dplyr es un paquete que está dentro del ecosistema tidyverse. Su función es
# prestar herramientas para manipular, tratar y operar las bases de datos.

# Exploración de los nombres de la base -----------------------------------

names(oscars)

# Select ------------------------------------------------------------------
# Extrae o selecciona variables.

# Seleccionar solo una variable.
oscars %>% dplyr::select(oscar_yr)

# Seleccionar 4 variables en específico.
oscars %>% dplyr::select(award, movie, name, age) 

# Seleccionar 3 variables en específico, pero con los comandos por defecto.
oscars[, c("award", "movie", "age")]

# Seleccionar de acuerdo a la posición (ubicación) de la variable.
oscars %>% dplyr::select(1, 2, 3)

# Seleccionar todas las variables, con excepción de las que figuran en la c().
oscars %>% dplyr::select(-c(birth_date))

# Seleccionar de acuerdo a un orden en específico. Everything se refiere a "todas las demás".
oscars %>% dplyr::select(name, everything())

# Seleccionar todas las variables que comiencen con la letra M.
oscars %>% dplyr::select(name, starts_with(match = "birth"))

# Seleccionar todas las variables que finalicen con la letra E.
oscars %>% dplyr::select(ends_with(match = "e"))

# Seleccionar con una condición lógica. Es decir, cuando las variables sean de tipo numérico.
oscars %>% dplyr::select_if(is.numeric)

# Otro mecanismo para una selección lógica.
oscars %>% dplyr::select(where(is.numeric))

# Actividad 1 -------------------------------------------------------------

oscars %>% dplyr::select(name, movie)
oscars %>% dplyr::select(c(3:5))
oscars %>% dplyr::select(-award)
oscars %>% dplyr::select(!starts_with(match = "birth"), -oscar_no) 

# Filter ------------------------------------------------------------------
# Filtra las variables de acuerdo a condiciones lógicas.

# Veamos los valores que poseen las variables de tipo cualitativo.

# Tabla de frecuencia para contabilizar los valores.
table(oscars$award)

# Visualizar los valores únicos que posee la variable.
unique(oscars$name)

# Filtrar cuando el año sea mayor o igual a 2015.
oscars %>% dplyr::filter(award >= 2015)

# Lo mismo que lo anterior, pero con los comandos por defecto (escuela antigua).
oscars[oscars$award >= 2015,]

# Filtrar cuando el premdio sea de tipo mejor actriz.
oscars %>% dplyr::filter(award == "Best actress")

# Lo mismo que lo anterior, pero con los comandos por defecto (escuela antigua).
oscars[oscars$award == "Best actress",]

# Filtrar cuando la vedad sea mayor o igual a 50 y año del premio mayor a 2000
oscars %>% dplyr::filter(age >= 50 & oscar_yr  >= 2000)

# Filtrar cuando la variable edad esté entre el año 2009 y 2017.
oscars %>% dplyr::filter(between(age, 20, 30) & award == "Best actress")

# Filtrar cuando el año del oscar sea el más reciente. Aquí utilizamos la función max.
oscars %>% dplyr::filter(oscar_yr == max(oscar_yr, na.rm = TRUE))

# Actividad 2: Filter ------------------------------------------------------------------

# ¿Quiénes ganaron oscars en el año más reciente?
oscars %>% dplyr::filter(oscar_yr == max(oscar_yr, na.rm = T))

# Actrices, menores de 25 años, que hayan ganado oscar
oscars %>% dplyr::filter(award == "Best actress" & age <= 25) 

# ¿Cuántos oscars ganó Meryl Streep?
oscars %>% dplyr::filter(name == "Meryl Streep") 

# En qué películas ganó oscar De Niro y Al Pacino
oscars %>% dplyr::filter(name %in% c("Robert De Niro",
                                     "Al Pacino"))
# Otra opción para lo anterior 
oscars %>% filter(stringr::str_detect(name, pattern = "De Niro"))

# Actores que hayan ganado oscar entre los 30 y 40 años.
oscars %>% dplyr::filter(award == "Best actor", between(age, 30, 40))
oscars %>% dplyr::filter(award == "Best actor", age > 30 & age <= 40)

# Actor o actriz que ha recibido el premio con mayor edad.

oscars %>% dplyr::filter(age == max(age))
oscars[which.max(oscars$age),][4]

# Mutate ------------------------------------------------------------------

# Cuánto tiempo pasó desde que nació hasta que obtuvo el oscar
oscars %>% 
  dplyr::mutate(tiempo_oscar =  oscar_yr - birth_y) 

# Crear nueva variable con ifelse
oscars %>% 
  dplyr::mutate(award = ifelse(award == "Best actress", 
                               "Mejor actriz", "Mejor Actor"))

# Crear nueva variable con case_when
oscars %>% 
  dplyr::mutate(award = dplyr::case_when(award == "Best actress" ~ 
                                        "Mejor actriz",
                                         TRUE ~ "Mejor actor"))

# Dejar todas las observaciones en mayúsculas
oscars %>% dplyr::mutate_all(stringr::str_to_upper)

# Convertir todas las variables a caracter
oscars %>% dplyr::mutate_all(as.character)

# Convertir variables de una naturaleza a otra
oscars %>% dplyr::mutate_if(is.character, as.factor) 

# Paréntesis: aprendamos otra técnica de data wranling con unite.

names(oscars)
unite <- tidyr::unite(data = oscars, col = "Cumpleaños", c(birth_d, birth_mo, birth_y), sep = "-")
tidyr::separate(data = unite, col = Cumpleaños, into = c("birth_d", "birth_mo", "birth_y"))


# Actividad 3:  ------------------------------------------------------------------
# Calcular edad actual de ganadores de oscars

oscars %>% 
  dplyr::mutate(diferencia_dias = Sys.Date() - birth_date,
                edad_actual = as.numeric(round(diferencia_dias/365), digits = 0)) %>% 
  dplyr::select(diferencia_dias, edad_actual) 

oscars %>% 
  dplyr::mutate(diferencia_dias = as.numeric(difftime(Sys.Date(), birth_date)),
                edad_actual = round(diferencia_dias/365))  %>% 
  dplyr::select(edad_actual, diferencia_dias) 

# Group_by ----------------------------------------------------------------
# Agrupa variables de tipo categórico.

# Contabilizar los premios a mejor actor y actriz
oscars %>% dplyr::group_by(award) %>% dplyr::count()

# Contabilizar premios según actor
oscars %>% 
  dplyr::filter(award == "Best actor") %>% 
  dplyr::group_by(name) %>% 
  dplyr::count()

# Actividad 4: Group_by ----------------------------------------------------------------

# De la base oscar, agrupar por nombre y contabilizar el numero de 
# óscars.

oscars %>% 
  dplyr::filter(award == "Best actor") %>% 
  dplyr::group_by(name) %>% 
  dplyr::count() %>% 
  dplyr::arrange(desc(n)) %>% 
  dplyr::filter(n >= 2)


# Summarize ---------------------------------------------------------------
# Realiza resumen de los datos.

oscars %>% 
  dplyr::filter(name %in% c("Robert De Niro", "Leonardo Di Caprio", "Meryl Streep",
                     "Jennifer Lawrence", "Nicole Kidman")) %>%
  dplyr::group_by(name) %>% 
  dplyr::summarize(n = n())


# Actividad 5 -------------------------------------------------------------

resumen <- oscars %>% 
  dplyr::select(!starts_with(match = "b")) %>% 
  dplyr::group_by(award) %>% 
  dplyr::summarise(oscars = n(),
                   promedio_edad = mean(age, na.rm = TRUE),
                   mediana_edad = median(age, na.rm = TRUE),
                   Q1 = quantile(age, probs = 0.25),
                   Q3 = quantile(age, probs = 0.75),
                   sd = sd(age, na.rm = TRUE),
                   min = min(age, na.rm = TRUE),
                   max = max(age, na.rm = TRUE)) %>% 
  dplyr::rename(premio = award) %>% 
  dplyr::mutate(premio = ifelse(premio == "Best actor", "Mejor actor",
                                "Mejor actriz"))

resumen
# Almacenar en una planilla Excel

if(!dir.exists("datos")) dir.create("datos")
  
writexl::write_xlsx(x = resumen, path = "datos/resumen.xlsx")

