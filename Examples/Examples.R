

library(ggmap)

get_map("Louisiana", zoom = 6, maptype = "toner-background") %>%
  ggmap(extent = "device") +
  geom_hurricane(data = hurricane_data,
                 aes(x = longitude, y = latitude, 
                     r_ne = ne, r_se = se, r_nw = nw, r_sw = sw,
                     fill = wind_speed, color = wind_speed),
                 alpha = 0.5) + 
  scale_color_manual(name = "Wind speed (kts)", 
                     values = c("red", "orange", "yellow")) + 
  scale_fill_manual(name = "Wind speed (kts)", 
                    values = c("red", "orange", "yellow"))


library(gganimate)
library(gifski)
library(magick)

hurricane_path <- 
  get_map("Jacksonville", zoom = 5, maptype = "hybrid") %>%
  ggmap(extent = "device") +
  geom_hurricane(data = hurricane_data,
                 aes(x = longitude, y = latitude, 
                     r_ne = ne, r_se = se, r_nw = nw, r_sw = sw,
                     fill = wind_speed, color = wind_speed),
                 alpha = 0.5) + 
  scale_color_manual(name = "Wind speed (kts)", 
                     values = c("red", "orange", "yellow")) + 
  scale_fill_manual(name = "Wind speed (kts)", 
                    values = c("red", "orange", "yellow")) +
  transition_time(date) +
  ease_aes('linear')

animate(hurricane_path, renderer = magick_renderer())

















