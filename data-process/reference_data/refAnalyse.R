
library(readxl)
library(dplyr)
library(ggplot2)
library(corrplot)
library(writexl)
library(patchwork)
library(plotly)

setwd("/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/reference")

data_all <- read_excel('reference-env.xlsx')
data = data_all[, c("height", "speed",  "maxLightStrength", "minLightStrength", "temperature",
                    "humidity", "windSpeed", 'width', 'h1', 'h2')]
data$height = as.numeric(data$height)

data$time = 'day_time'
data[31:36, 'time'] = 'night_time'
summary(data)

cor(data[, c('maxLightStrength', 'minLightStrength')])
cor(data[, c('h1', 'h2')])
# Calculate correlation matrix
correlation_matrix <- cor(data[, c( 'width', 'h1', 'h2', 
                                    "maxLightStrength", "minLightStrength", "temperature",
                                    "humidity", "windSpeed", "height", "speed")])
corrplot(correlation_matrix, method = "color")



#the relationship of responses and ground truth/ use data befor standardization
plotRef = function() {
  custom_height <- c(8, 10, 15, 30, 50)
  custom_speed <- c(1, 2, 3, 5, 7, 9)
  
  color_palette <- c("Subset 1" = "blue", "Subset 2" = "red")
  
  p1 = ggplot(data = data, aes(x = height, y = width, color=time)) +
    geom_point() +
    labs(x = "height (m)", y = "width (m)") +
    scale_x_continuous(breaks = custom_height, labels = custom_height)+
    #geom_text(aes(x = 40, y = 1.3, label = "ground truth: width=1.327"))+
    geom_hline(yintercept = 1.327,  color = "blue") 
  p2 = ggplot(data = data, aes(x = speed, y = width, color=time)) +
    geom_point() +
    labs(x = "speed (m/s)", y = "width (m)") +
    scale_x_continuous(breaks = custom_speed, labels = custom_speed) +
    #geom_text(aes(x = 5, y = 1.3, label = "ground truth: width=1.327"))+
    geom_hline(yintercept = 1.327,  color = "blue")
  
  p3 = ggplot(data = data, aes(x = height, y = h1, color=time)) +
    geom_point() +
    labs(x = "height (m)", y = "h1 (m)") +
    scale_x_continuous(breaks = custom_height, labels = custom_height) +
    geom_hline(yintercept = 0.467,  color = "blue") 
  p4 = ggplot(data = data, aes(x = speed, y = h1, color=time)) +
    geom_point() +
    labs(x = "speed (m/s)", y = "h1 (m)") +
    scale_x_continuous(breaks = custom_speed, labels = custom_speed)+
    geom_hline(yintercept = 0.467,  color = "blue")
  
  p5 = ggplot(data = data, aes(x = height, y = h2, color=time)) +
    geom_point() +
    labs(x = "height (m)", y = "h2 (m)") +
    scale_x_continuous(breaks = custom_height, labels = custom_height)+
    geom_hline(yintercept = 0.467, color = "blue")
  p6 = ggplot(data = data, aes(x = speed, y = h2, color=time)) +
    geom_point() +
    labs(x = "speed (m/s)", y = "h2 (m)") +
    scale_x_continuous(breaks = custom_speed, labels = custom_speed)+
    geom_hline(yintercept = 0.467,  color = "blue")
  
  design <- "AACCEE
             BBDDFF"
  wrap_plots(
    A=p1,B=p2,
    C=p3,D=p4,
    E=p5,F=p6,
    design = design, 
    guides = "collect")
}
plotRef()


plotCorrelation = function () {
  BMdata <- read_excel('/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/results-BM.xlsx')
  BMdata$MBL <- as.numeric(BMdata$MBL)
  BMdata$height = as.numeric(BMdata$nheight)
  BMdata$speed = as.numeric(BMdata$speed)
  summary(BMdata) 
  
  # Calculate correlation matrix
  correlation_matrix <- cor(BMdata[, c( "AW", 'HH', 'WH', 'WiH', 'BH', 'MBL', 
                                      "maxLightStrength", "minLightStrength", "temperature",
                                      "humidity", "windSpeed", "size", "height", "speed")])
  
  # Visualize correlation matrix
  corrplot(correlation_matrix, method = "color")
  
  
  
  data_all <- read_excel('/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/reference/reference-env.xlsx')
  data = data_all[, c("height", "speed",  "maxLightStrength", "minLightStrength", "temperature",
                      "humidity", "windSpeed", 'width', 'h1', 'h2')]
  data$height = as.numeric(data$height)
  
  # Calculate correlation matrix
  correlation_matrix2 <- cor(data[, c( 'width', 'h1', 'h2', 
                                      "maxLightStrength", "minLightStrength", "temperature",
                                      "humidity", "windSpeed", "height", "speed")])
  corrplot(correlation_matrix2, method = "color")
  
}
plotCorrelation()
  
  
plot3d = function () {
  custom_colors <- c("day_time" = "#333333", "night_time" = "#e763fa")

  scatterplot_3d <- plot_ly(data = data, x = ~height, y = ~speed, z = ~width, 
                          type = "scatter3d", mode = "markers", 
                          color = ~time, colors = custom_colors,
                          marker = list(size = 5, opacity = 0.7)) 

  # Add a flat surface at z = 1.327 without bars
  scatterplot_3d <- scatterplot_3d %>%
    add_surface()

  # Customize the plot labels and title
  scatterplot_3d <- scatterplot_3d %>% 
    layout(scene = list(xaxis = list(title = "Height"),
                      yaxis = list(title = "Speed"),
                      zaxis = list(title = "Width")),
         title = "3D Scatterplot of Height, Speed, and Width by Time Category")

  # Display the 3D scatterplot
  scatterplot_3d
}


# MANOVA
reFmanova = function() {
 # standardization
  predictor_vars <- c("height", "speed", "maxLightStrength", "minLightStrength", "temperature", "humidity", "windSpeed")
  data[, predictor_vars] <- scale(data[, predictor_vars])
  
  manova_result <- manova(cbind(width, h1, h2) ~ height + speed 
                          + maxLightStrength + minLightStrength + temperature + humidity + windSpeed, data = data)
  summary(manova_result) 
  saveManove(manova_result)
}
reFmanova()
BMmanova = function() {
  BMdata <- read_excel('/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/results-BM.xlsx')
  BMdata = BMdata[1:235,]
  #BMdata = BMdata[236:275,]
  BMdata$MBL <- as.numeric(BMdata$MBL)
  BMdata$height = as.numeric(BMdata$nheight)
  BMdata$speed = as.numeric(BMdata$speed)
  summary(BMdata) 
 # standardization
  predictor_vars <- c("height", "speed", "maxLightStrength", "minLightStrength", "temperature", "humidity", "windSpeed", "size")
  # for night
  #predictor_vars <- c("height", "speed",  "temperature", "size")
  BMdata[, predictor_vars] <- scale(BMdata[, predictor_vars])
  
  manova_result <- manova(cbind(AW, HH, WH, WiH, BH, MBL) ~ height + speed 
                          + maxLightStrength + minLightStrength + temperature + humidity + windSpeed + size, data = BMdata)
  summary(manova_result) 
  
  return(manova_result)
}

saveManove = function (ret) {
  rowName = c("height", "speed", "maxLightStrength", "minLightStrength", "temperature", "humidity","windSpeed", "size", '')
  summary <- data.frame(
    Data = rowName,
    Df = summary(ret)$stats[, "Df"],
    Pillai = summary(ret)$stats[, "Pillai"],
    Approx_F = summary(ret)$stats[, "approx F"],
    Num_Df = summary(ret)$stats[, "num Df"],
    Den_Df = summary(ret)$stats[, "den Df"],
    Pr_gt_F = summary(ret)$stats[, "Pr(>F)"]
  )
  
  write_xlsx(summary, '/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/effects/RefAll.xlsx')
}

ret = BMmanova()
summary(ret) 

saveManove(ret)




qlm <- lm(cbind(width, h1, h2) ~ height + I(height^2) + speed + I(speed^2) + height:speed + maxLightStrength 
                       + minLightStrength + temperature + humidity + windSpeed, data = data)
summary(qlm)


# Make predictions on the testing set
predictions <- predict(model, newdata = testing_data)

# Calculate RMSE
rmse <- sqrt(mean((predictions - testing_data$width)^2))


lm <- lm(cbind(width, h1, h2) ~ height + speed + maxLightStrength 
                       + minLightStrength + temperature + humidity + windSpeed, data = data)
summary(lm)



