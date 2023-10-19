library(readxl)
library(ggplot2)
library(patchwork)

setwd("/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result")

data <- read_excel('results-campaigns.xlsx')
data$date <- factor(data$date, labels = c('8 Jan.', 'morning on 9 Jan.', '31 Dec.', 'afternoon on 9 Jan.'))
data$height <- factor(data$height, levels=c('8', '10', '15', '30', '50', 'n8','n10', 'n15')
                      , labels = c('8m', '10m', '15m', '30m', '50m', '8m at night', '10m at night', '15m at night'))
data$temperature <- as.numeric(data$temperature)

data$points = data$points / 1000000

head(data, n=5)

campaign_size = ggplot(data, aes(x = duration, y = points, group=height)) + 
  geom_line(aes(col = height)) +
  geom_point(aes(col = height)) +
  #theme_minimal() +
  #theme(legend.position = c(0.1, 0.6) ) +
  labs(x = "Duration of acqusition in campaign (unit: second)", 
       y = "Point cloud size (unit: million)",
       col = "Height Category"
  ) 


campaign_time = ggplot(data, aes(x = time, y = `standing cattle`, group = date, color = date)) +
  geom_line(aes(linetype = "Standing cattle")) +
  geom_point() +
  geom_line(aes(y = `avaliable cattle`, linetype = "Seleted standing cattle")) +
  geom_point(aes(y = `avaliable cattle`)) + 
  scale_color_manual(values = c("blue", "red", "black", "purple"), guide = guide_legend(title = "Time slots")) +
  scale_linetype_manual(values = c( "dashed", "solid")) +
  #theme_minimal() +
  #theme(legend.position = c(0.8, 0.65) ) +
  labs(x = "Time of implementing campaign", y = "Cattle count") +
  guides(linetype = guide_legend(title = "Cattle"))
campaign_time


compaign_light = ggplot(data, aes(x = time, y = `max-illumiantion`, group = date, color = date)) +
  geom_line(aes(linetype = "Maximum light strength")) +
  #geom_point() +
  geom_line(aes(y = `min-illumiantion`, linetype = "Minimum light strength")) +
  #geom_point(aes(y = `min-illumiantion`)) + 
  geom_line(aes(y = temperature, linetype = "Temperature")) +  # Temperature line
  scale_color_manual(values = c("blue", "red", "black", "purple"), guide = guide_legend(title = "Time slots")) +
  scale_linetype_manual(values = c("solid", "dashed", "dotted")) + 
  #theme_minimal() +
  theme(legend.position = c(0.85, 0.6) ) +
  labs(x = "Time of implementing campaign", y = "Light strength (x1000 lux)") +
  guides(linetype = guide_legend(title = "Enviornmental category")) +
  scale_y_continuous(
    name = "Temperature (°C)", 
    sec.axis = sec_axis(trans = ~ .,  name = "Light strength (x1000 lux)"),
    limits = c(-5, 60)
  )



compaign_wind = ggplot(data, aes(x = time, y = `max-wind-speed`, group = date, color = date)) +
  #geom_point() +
  geom_line(aes(linetype = "Max wind speed")) +
  geom_line(aes(y = moisture / 10, linetype = "Humidity")) +
  #geom_point(aes(y = moisture / 10)) + 
  scale_color_manual(values = c("blue", "red", "black", "purple"), guide = guide_legend(title = "Time slots")) +
  scale_linetype_manual(values = c("solid", "dashed")) + 
  #theme_minimal() +
  theme(legend.position = c(0.85, 0.6) ) +
  labs(x = "Time of implementing campaign", y = "Max wind speed (m/s)") +
  guides(linetype = guide_legend(title = "Enviornmental category")) +
  scale_y_continuous(
    name = "Humidity (%)", 
    sec.axis = sec_axis(trans = ~ (.) * 0.1,  name = "Maximum wind speed (m/s)"),
  )

 
(campaign_time / compaign_wind | compaign_light / campaign_size) +
  plot_layout(guides = "collect")
  #plot_annotation(tag_levels = list(c("(a) Cattle count in each campaign",  "(b) Light strength and temperature during campaigns ", "(c) Wind speed and moisture during campaigns",  "(d) Point cloud size of each campaign" ))) &
  #theme(plot.tag = element_text(hjust = 0.5, size = 18),
  #      plot.tag.position = "bottom",
  #) 

 (compaign_light / compaign_wind ) +  
  plot_layout(guides = "collect") +
  plot_annotation(tag_levels = list(c("(a) Light strength and temperature during campaigns ", "(b) Wind speed and moisture during campaigns" )))  &
  theme(plot.tag = element_text(hjust = 0.8, size = 14),
        plot.tag.position = "bottom",
  ) 

(campaign_time  | campaign_size) +
  plot_annotation(tag_levels = list(c("(a) Cattle count in each campaign",  "(b) Point cloud size of each campaign" ))) &
  theme(plot.tag = element_text(hjust = 0.8, size = 14),
        plot.tag.position = "bottom",
  ) 

ggsave('/Users/wyw/Downloads/chapter2-figures/results/data-campaign.png')




  
