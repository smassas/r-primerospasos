library(tidyverse)

# Carguemos la base de datos países, proveniente de la librería datos.
paises <- datos::paises

# Filtremos Chile para comenzar a graficar.
g1 <- paises %>% dplyr::filter(pais == "Chile")

# 1. Diagrama de puntos y líneas ------------------------------------------------------

# 1.1.  Gráfico por defecto -----------------------------------------------

plot(g1$esperanza_de_vida ~ g1$anio, xlab = "Año", ylab = "GDP per capita",
     main = "Evolución del GDP per capita en Chile", col = "tomato", 
     cex.lab = 1, # Tamaño ejes.
     pch = 16) # Forma de los puntos.

# 1.2.  Gráfico con ggplot2 -----------------------------------------------

ggplot2::ggplot(data = g1, aes(x = anio, y = esperanza_de_vida)) +
  ggplot2::geom_point(color = "black") +
  ggplot2::geom_line(color = "darkblue", size = 1) +
  ggplot2::labs(title = "Chile",
                subtitle = "Esperanza de vida 1952 a 2007",
                caption = "",
                x = "Año",
                y = "Esperanza de vida") +
  hrbrthemes::theme_ipsum() +
  ggplot2::geom_hline(yintercept = mean(g1$esperanza_de_vida), 
                      color = "black", 
                      linetype = "dashed", 
                      alpha = 0.7)


# 1.2.1.  Graficar 1.2 pero por continente --------------------------------

g2 <- paises %>% 
  dplyr::filter(pais %in% c("Chile", "Argentina", "Perú",
                            "Colombia", "Brasil", "Bolivia",
                            "Ecuador", "Venezuela"))

ggplot2::ggplot(data = g2, aes(x = anio, y = esperanza_de_vida, color = pais)) +
  geom_line(size = 1.5) +
  labs(title = "Países latinoamericanos",
       subtitle = "Esperanza de vida 1952 a 2007",
       x = "Año",
       y = "Esperanza de vida") +
  hrbrthemes::theme_ipsum() 

# Un ejemplo adicional ----------------------------------------------------

# Diagrama de puntos con etiquetas.
g3 <- paises %>% filter(anio == 2007)

# ggplot 
ggplot2::ggplot(g3, aes(y = pib_per_capita, x = esperanza_de_vida), fill = pais) +
  ggplot2::geom_point(size = 1) +
  ggrepel::geom_label_repel(aes(
    label = ifelse(pib_per_capita > 30000, as.character(pais),"")),
    size = 3,
    box.padding = 0.35,
    point.padding = 0.5,
    segment.color = 'grey50')

# Facetas -----------------------------------------------------------------

g4 <- paises %>% select(everything())

# ggplot

ggplot2::ggplot(g4, aes(x = pib_per_capita, y = esperanza_de_vida)) +
  ggplot2::geom_point(pch = 20, color = "darkblue") +
  ggplot2::facet_wrap(~continente) +
  ggplot2::theme(plot.title = element_text(colour = "cornflowerblue"),
                 strip.text.x = element_text(size = 8, colour = "white"), 
                 strip.background = element_rect(colour = "white", fill = "cornflowerblue"),
                 axis.text.x = element_text(colour = "cornflowerblue"),
                 axis.text.y = element_text(colour = "cornflowerblue"),
                 axis.text = element_text(colour = "cornflowerblue"),
                 legend.title = element_text(colour = "cornflowerblue"))

g4 %>% dplyr::filter(anio %in% c(1962, 2007)) %>% 
  ggplot(aes(esperanza_de_vida, pib_per_capita, col = continente)) +
  geom_point() +
  facet_grid(. ~ anio) +
  scale_colour_brewer(palette = "Set1")

# Gráfico de barras -------------------------------------------------------

# Contemos el número de países según continente

g5 <- paises %>% 
  dplyr::filter(anio == 2007) %>% 
  dplyr::group_by(continente) %>% 
  dplyr::count()

ggplot2::ggplot(g5, aes(x= reorder(continente, n), y = n, fill= continente)) + 
  ggplot2::geom_bar(stat = "identity") +
  ggplot2::labs(y="Número de países", x = "Continente") +
  ggplot2::theme(axis.text.x = element_text(angle = 0, hjust = 0.5),
               legend.position = "none") +
  ggplot2::geom_text(aes(label = n),
                     position = position_stack(vjust = 0.5),
                     color = "white",
                     size = 3) +
  ggplot2::coord_flip()

# legend.key.height = unit(0.4, 'cm'),
# legend.key.width = unit(0.4, 'cm'),
# axis.text = element_text(size = 10)

# ¿Si queremos visualizar la población según continente?

g5 <- paises %>% 
  dplyr::select(pais, continente, poblacion) %>% 
  dplyr::group_by(continente) %>% 
  dplyr::summarise(Poblacion = sum(poblacion)) 

# ggplot
ggplot2::ggplot(data = g5, aes(x = reorder(continente, -Poblacion), y = Poblacion)) +
  ggplot2::geom_bar(stat = "identity", fill = "darkblue") +
  ggplot2::labs(title = "Población según continente",
                x = "Continente",
                y = "Población") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) #Si es que desea modificar el eje X.

# Boxplot -----------------------------------------------------------------

g6 <- paises %>% dplyr::filter(continente == "Américas")

ggplot2::ggplot(g6, aes(x = pais, y = esperanza_de_vida)) +
  ggplot2::geom_boxplot(fill = "steelblue", outlier.colour = "red", 
                        outlier.shape = 16) + 
  ggplot2::labs(x = "País", y = "Años",
                title = "Esperanza de vida en América",
                subtitle = "Entre los años 1952 a 2007",
                caption = "Fuente Datos: gapminder") +
  ggplot2::coord_flip() 
  # ggthemes::theme_hc()

# Histograma y densidad --------------------------------------------------------------

ggplot2::ggplot(paises, aes(x = pib_per_capita)) +
  ggplot2::geom_histogram(position = "identity", bins = 30, alpha = 0.6) 

# En función de continente
ggplot2::ggplot(paises, aes(x = esperanza_de_vida)) +
  ggplot2::geom_histogram(aes(color = continente, fill = continente), 
                          position = "identity", bins = 30, alpha = 0.6) 

# Gráfico de sectores -----------------------------------------------------

g7 <- paises %>% 
  dplyr::select(pais, poblacion, anio, continente) %>% 
  dplyr::group_by(anio) %>% 
  dplyr::mutate(porcentaje = poblacion/sum(poblacion)*100) %>% 
  dplyr::ungroup() %>% 
  dplyr::filter(anio == max(anio, na.rm = TRUE) &
                pais %in% c("Alemania", "España", "Italia", "Polonia"))

ggplot2::ggplot(g7, aes(x = "", y = porcentaje, fill = pais)) +
  ggplot2::geom_bar(stat = "identity", color = "white", alpha = 0.8, width = 2) +
  ggplot2::coord_polar(theta = "y", start = 0) +
  ggplot2::theme_void() + 
  ggplot2::geom_text(aes(label = round(porcentaje, 2)),
                     position = position_stack(vjust = 0.5),
                     color = "white",
                     size = 3) +
  guides(fill = guide_legend(reverse = TRUE)) +
  ggplot2::scale_fill_brewer(palette="Paired") 

# Actividad 1 -------------------------------------------------------------

nacimientos <- guaguas::guaguas

# Efecto biblia

biblia <- nacimientos %>% 
  dplyr::filter(nombre %in% c("Osmán", "Noé", "Lázaro", "Jesús", "Isaías", "Abraham"),
                sexo == "M") %>% 
  ggplot2::ggplot(aes(anio, n, color = nombre)) +
  ggplot2::geom_line(size = 1) +
  ggplot2::labs(x = "año", y = "total inscripciones", color = "nombre", 
                title = "Inscripciones de nombres bíblicos entre 1925 - 2000") +
  hrbrthemes::theme_ipsum()

# Contexto político de los años 60/70

periodo_up <- nacimientos  %>% 
  dplyr::filter(nombre %in% c("Salvador", "Augusto"), 
                anio >= 1960 & anio <= 1980) %>% 
  ggplot2::ggplot(aes(anio, n, color = forcats::fct_reorder2(nombre, n, anio))) + 
  ggplot2::geom_line(size = 1) +
  ggplot2::labs(x = "año", y = "total inscripciones", color = "nombre", 
                title = "Inscripciones de 'Salvador' y 'Augusto' entre 1960 - 1980") +
  hrbrthemes::theme_ipsum()

# Efecto romané año 2000

romane <- nacimientos %>% 
  dplyr::filter(nombre %in% c("Milenka", "Branco", "Salomé"), 
                anio > 1980) %>% 
  ggplot2::ggplot(aes(anio, n, color = nombre)) + 
  ggplot2::geom_line(size = 1) +
  ggplot2::labs(x = "año", y = "total inscripciones",
                title = "Inscripciones de nombres de personajes de 'Romané'") +
  hrbrthemes::theme_ipsum()

gridExtra::grid.arrange(periodo_up, romane, biblia, ncol = 2)

# Guardar gráficos

if(!dir.exists("graficos")) dir.create("graficos")

pdf("graficos/e.pdf")
e <- ggplot(data_vis, aes(x = Comuna, y = Solicitud_tarjeta, fill = Comuna)) +
  geom_boxplot() 
print(e)
dev.off()

ggsave("graficos/e.pdf")
ggsave("graficos/e.png")
