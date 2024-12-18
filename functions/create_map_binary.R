library(rnaturalearth)
library(dplyr)
library(ggplot2)
library(ggthemes)

create_map_binary <- function(var_name, title, subtitle, legend_title, theme, direction) {

  ne_countries(scale = "medium", returnclass = "sf") |> 
    left_join(
      filtered_data, # Merge spatial data with filtered data
      join_by(iso_a3 == country_code)
    ) |> 
    filter(name != "Antarctica") |>  
    ggplot() + 
    geom_sf(aes(fill = .data[[var_name]])) + # Dynamically fill based on variable
    labs(
      title = title, # Map title
      #subtitle = subtitle, # Subtitle
      fill = legend_title, # Legend title
      caption = "Source: Identification for Development Dataset (World Bank)"
    ) +
    theme_map() +
    theme(
      plot.title = element_text(face = "bold")
    ) +
    scale_fill_viridis_d(
      option = theme, # Use the selected viridis theme
      direction = direction # Control color scale direction
    )
}