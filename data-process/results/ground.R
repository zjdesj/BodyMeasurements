# for ground data summary (table)
library(readxl)
library(dplyr)
library(ggplot2)
library(patchwork)
library(writexl)


setwd("/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/")

data <- read_excel('data-measurement.xlsx')
data$height = factor(data$height, levels=c('8', '10', '15', '30', '50', 'n8', 'n10', 'n15'))
data$speed = factor(data$speed, levels = c('1', '2', '3', '5', '7', '9'), 
                    labels = c('1 m/s', '2 m/s', '3 m/s', '5 m/s', '7 m/s', '9 m/s'))

data$ground <- as.numeric(data$ground)
summary(data)


summary_data_factors <- data %>%
  group_by(height, speed) %>%
  summarise(
    mean_ground = mean(ground, na.rm = TRUE),
    sd_ground = sd(ground, na.rm = TRUE),
  )
summary_data_factors



write_xlsx(summary_data_factors, '/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/results-ground.xlsx')


