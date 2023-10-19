# for body measurments data summary (table)

library(readxl)
library(dplyr)
library(ggplot2)
library(patchwork)
library(writexl)


setwd("/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/")

data <- read_excel('results-BM-adjusted.xlsx')
data$height = factor(data$height, levels=c('8', '10', '15', 'n8', 'n10', 'n15'))
data$speed = factor(data$speed, levels = c('1', '2', '3', '5'), 
                    labels = c('1 m/s', '2 m/s', '3 m/s', '5 m/s'))
data$MBL <- as.numeric(data$MBL)
summary(data)


summary_data_factors <- data %>%
  group_by(height, speed) %>%
  summarise(
    mean_AW1 = mean(AW1, na.rm = TRUE),
    sd_AW1 = sd(AW1, na.rm = TRUE),
    mean_AW = mean(AW, na.rm = TRUE),
    sd_AW = sd(AW, na.rm = TRUE),
    mean_AW2 = mean(AW2, na.rm = TRUE),
    sd_AW2 = sd(AW2, na.rm = TRUE),
    mean_HH1 = mean(HH1, na.rm = TRUE),
    sd_HH1 = sd(HH1, na.rm = TRUE),
    mean_HH = mean(HH, na.rm = TRUE),
    sd_HH = sd(HH, na.rm = TRUE),
    mean_WH = mean(WH, na.rm = TRUE),
    sd_WH = sd(WH, na.rm = TRUE),
    mean_WiH1 = mean(WiH1, na.rm = TRUE),
    sd_WiH1 = sd(WiH1, na.rm = TRUE),
    mean_WiH = mean(WiH, na.rm = TRUE),
    sd_WiH = sd(WiH, na.rm = TRUE),
    mean_BH = mean(BH, na.rm = TRUE),
    sd_BH = sd(BH, na.rm = TRUE),
    mean_MBL = mean(MBL, na.rm = TRUE),
    sd_MBL = sd(MBL, na.rm = TRUE)
  )
summary_data_factors
write_xlsx(summary_data_factors, '/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/results-BM-adjusted-summary-factor.xlsx')


summary_data_overall <- data %>%
  summarise(
    mean_AW1 = mean(AW1, na.rm = TRUE),
    sd_AW1 = sd(AW1, na.rm = TRUE),
    mean_AW = mean(AW, na.rm = TRUE),
    sd_AW = sd(AW, na.rm = TRUE),
    mean_AW2 = mean(AW2, na.rm = TRUE),
    sd_AW2 = sd(AW2, na.rm = TRUE),
    mean_HH1 = mean(HH1, na.rm = TRUE),
    sd_HH1 = sd(HH1, na.rm = TRUE),
    mean_HH = mean(HH, na.rm = TRUE),
    sd_HH = sd(HH, na.rm = TRUE),
    mean_WH = mean(WH, na.rm = TRUE),
    sd_WH = sd(WH, na.rm = TRUE),
    mean_WiH1 = mean(WiH1, na.rm = TRUE),
    sd_WiH1 = sd(WiH1, na.rm = TRUE),
    mean_WiH = mean(WiH, na.rm = TRUE),
    sd_WiH = sd(WiH, na.rm = TRUE),
    mean_BH = mean(BH, na.rm = TRUE),
    sd_BH = sd(BH, na.rm = TRUE),
    mean_MBL = mean(MBL, na.rm = TRUE),
    sd_MBL = sd(MBL, na.rm = TRUE)
  )
summary_data_overall


summary_data_day <- data %>%
  filter(height %in% c('8', '10', '15'), speed %in% c('3 m/s', '5 m/s')) %>%
  summarise(
    mean_AW1 = mean(AW1, na.rm = TRUE),
    sd_AW1 = sd(AW1, na.rm = TRUE),
    mean_AW = mean(AW, na.rm = TRUE),
    sd_AW = sd(AW, na.rm = TRUE),
    mean_AW2 = mean(AW2, na.rm = TRUE),
    sd_AW2 = sd(AW2, na.rm = TRUE),
    mean_HH1 = mean(HH1, na.rm = TRUE),
    sd_HH1 = sd(HH1, na.rm = TRUE),
    mean_HH = mean(HH, na.rm = TRUE),
    sd_HH = sd(HH, na.rm = TRUE),
    mean_WH = mean(WH, na.rm = TRUE),
    sd_WH = sd(WH, na.rm = TRUE),
    mean_WiH1 = mean(WiH1, na.rm = TRUE),
    sd_WiH1 = sd(WiH1, na.rm = TRUE),
    mean_WiH = mean(WiH, na.rm = TRUE),
    sd_WiH = sd(WiH, na.rm = TRUE),
    mean_BH = mean(BH, na.rm = TRUE),
    sd_BH = sd(BH, na.rm = TRUE),
    mean_MBL = mean(MBL, na.rm = TRUE),
    sd_MBL = sd(MBL, na.rm = TRUE)
  )
summary_data_day

summary_data_night <- data %>%
  filter(height %in% c('n8', 'n10', 'n15'), speed %in% c('3 m/s', '5 m/s')) %>%
  summarise(
    mean_AW1 = mean(AW1, na.rm = TRUE),
    sd_AW1 = sd(AW1, na.rm = TRUE),
    mean_AW = mean(AW, na.rm = TRUE),
    sd_AW = sd(AW, na.rm = TRUE),
    mean_AW2 = mean(AW2, na.rm = TRUE),
    sd_AW2 = sd(AW2, na.rm = TRUE),
    mean_HH1 = mean(HH1, na.rm = TRUE),
    sd_HH1 = sd(HH1, na.rm = TRUE),
    mean_HH = mean(HH, na.rm = TRUE),
    sd_HH = sd(HH, na.rm = TRUE),
    mean_WH = mean(WH, na.rm = TRUE),
    sd_WH = sd(WH, na.rm = TRUE),
    mean_WiH1 = mean(WiH1, na.rm = TRUE),
    sd_WiH1 = sd(WiH1, na.rm = TRUE),
    mean_WiH = mean(WiH, na.rm = TRUE),
    sd_WiH = sd(WiH, na.rm = TRUE),
    mean_BH = mean(BH, na.rm = TRUE),
    sd_BH = sd(BH, na.rm = TRUE),
    mean_MBL = mean(MBL, na.rm = TRUE),
    sd_MBL = sd(MBL, na.rm = TRUE)
  )
summary_data_night

summary_data_overall <- data %>%
  group_by(height, speed) %>%
  summarise(
    mean_AW1 = mean(AW1, na.rm = TRUE),
    sd_AW1 = sd(AW1, na.rm = TRUE),
    mean_AW = mean(AW, na.rm = TRUE),
    sd_AW = sd(AW, na.rm = TRUE),
    mean_AW2 = mean(AW2, na.rm = TRUE),
    sd_AW2 = sd(AW2, na.rm = TRUE),
    mean_HH1 = mean(HH1, na.rm = TRUE),
    sd_HH1 = sd(HH1, na.rm = TRUE),
    mean_HH = mean(HH, na.rm = TRUE),
    sd_HH = sd(HH, na.rm = TRUE),
    mean_WH = mean(WH, na.rm = TRUE),
    sd_WH = sd(WH, na.rm = TRUE),
    mean_WiH1 = mean(WiH1, na.rm = TRUE),
    sd_WiH1 = sd(WiH1, na.rm = TRUE),
    mean_WiH = mean(WiH, na.rm = TRUE),
    sd_WiH = sd(WiH, na.rm = TRUE),
    mean_BH = mean(BH, na.rm = TRUE),
    sd_BH = sd(BH, na.rm = TRUE),
    mean_MBL = mean(MBL, na.rm = TRUE),
    sd_MBL = sd(MBL, na.rm = TRUE)
  )
summary_data_factors



d1 = bind_rows(summary_data_overall,summary_data_day, summary_data_night)

d1
write_xlsx(d1, '/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/results-BM-adjusted-summary-over.xlsx')






#data_day = data[1:235,2:ncol(data)]
#data_day$height = factor(data_day$height, levels=c('8', '10', '15', '30', '50'))
#data_day$speed = factor(data_day$speed, levels = c('1', '2', '3', '5', '7', '9'))
#summary(data_day)
#
#data_night = data[236:275,2:ncol(data)]
#data_night$height = factor(data_night$height, levels = c('n8', 'n10', 'n15'))
#data_night$speed = factor(data_night$speed, levels = c('3', '5'))
#summary(data_night)
#
#campaign = group_by(data_day, height, speed)
#summarise(campaign, 
#    width_mean = mean(width),
#    width_sd = sd(width)      
#)
#
