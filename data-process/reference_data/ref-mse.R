library(readxl)
library(dplyr)
library(ggplot2)
library(corrplot)
library(writexl)
library(patchwork)
library(plotly)

setwd("/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/reference")

#data_all <- read_excel('reference-env.xlsx')
data_all <- read_excel('reference-env-adjusted.xlsx')
data = data_all[, c('width', 'h1', 'h2', 'gwidth', 'gh1', 'gh2')]


# Calculate MAE for gwidth
mae_gwidth <- mean(abs(data$width - data$gwidth))
# Calculate MSE for gwidth
mse_gwidth <- mean((data$width - data$gwidth)^2)
# Calculate RMSE for gwidth
rmse_gwidth <- sqrt(mse_gwidth)

# Calculate the mean of width
mean_width <- mean(data$width)
# Calculate the standard deviation (SD) of width
sd_width <- sd(data$width)

mean_width  
sd_width 
mae_gwidth
rmse_gwidth


# Calculate MAE for gh2
mae_gh2 <- mean(abs(data$h2 - data$gh2))
# Calculate MSE for gh2
mse_gh2 <- mean((data$h2 - data$gh2)^2)
# Calculate RMSE for gh2
rmse_gh2 <- sqrt(mse_gh2)

# Calculate the mean of width
mean_h2 <- mean(data$h2)
# Calculate the standard deviation (SD) of width
sd_h2 <- sd(data$h2)

mean_h2 
sd_h2
mae_gh2
rmse_gh2


# Calculate MAE for gh1
mae_gh1 <- mean(abs(data$h1 - data$gh1))
# Calculate MSE for gh1
mse_gh1 <- mean((data$h1 - data$gh1)^2)
# Calculate RMSE for gh1
rmse_gh1 <- sqrt(mse_gh1)

# Calculate the mean of width
mean_h1 <- mean(data$h1)
# Calculate the standard deviation (SD) of width
sd_h1 <- sd(data$h1)

mean_h1 
sd_h1
mae_gh1
rmse_gh1
