library(rnaturalearth)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(wbstats)

create_map <- function(var_name, title, subtitle, legend_title, theme, direction){
  
  ne_countries(scale = "medium", returnclass = "sf") |> 
    left_join(
      filtered_data, # change variable id
      join_by(iso_a3 == country_code)
    ) |> 
    filter(name != "Antarctica") |>  
    ggplot() + 
    geom_sf(aes(fill = .data[[var_name]])) + # unquote var_id
    labs(
      title =  title, # change title
      fill = legend_title, # change legend title
      caption = "Source: Identification for Development Dataset (World Bank)"
    ) +
    theme_map() +
    theme(
      plot.title = element_text(face = "bold"),
    ) +
    scale_fill_viridis_c( 
      option = theme, #  chg theme
      direction = direction # change direction of scale
    )
}