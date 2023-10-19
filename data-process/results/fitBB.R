library(readxl)
library(ggplot2)
library(patchwork)
library(writexl)

filePath = "/Users/wyw/Documents/Chaper2/github-code/data/cattle-individual/bb"
setwd(filePath)


# Specify the pattern to match
pattern <- "^(\\d|n\\d).*"

# List files in the directory that match the pattern
matching_files <- list.files(filePath, pattern = pattern)

matching_files

func = function(name) {
  data = read_excel(name)
  
  dxy = data.frame(x = data$x, y = data$y)
  
  model = lm(y ~ x + I(x^2), data = dxy)
  
  #summary(model)
  
  predicted_y = predict(model)
  
  #summary(predicted_y)
  
  #ggplot(data, aes(x = x, y = y)) +
  #  geom_point(color = "blue") +         # Original data points
  #  geom_line(aes(y = predicted_y), color = "red") +  # Predicted values line
  #  labs(x = "x", y = "y") +
  #  theme_minimal()
  
  dxz = data.frame(x = data$x, z = data$z)
  
  model2 = lm(z ~ x + I(x^2), data = dxz)
  
  #summary(model2)
  
  predicted_z = predict(model2)
  
  #summary(predicted_z)
  
  #ggplot(data, aes(x = x, y = z)) +
  #  geom_point(color = "blue") +         # Original data points
  #  geom_line(aes(y = predicted_z), color = "red") +  # Predicted values line
  #  labs(x = "x", y = "z") +
  #  theme_minimal()
  
  ret = data.frame(x = data$x, y = data$y,  y_hat = predicted_y, z = data$z, z_hat = predicted_z)
  
  return(ret)
}


getDistance = function(ret) {
  n <- nrow(ret)
  distance <- 0
  distanceX <- 0
  for (i in 2:n) {
    dx <- ret$x[i] - ret$x[i - 1]
    dy <- ret$y_hat[i] - ret$y_hat[i - 1]
    dz <- ret$z_hat[i] - ret$z_hat[i - 1]
    distance <- distance + sqrt(dx^2 + dy^2 + dz^2)
    distanceX = distanceX + sqrt(dx^2 + dy^2)
  }
  # Print the calculated distance
  #print(distance)
  diss = c(distanceX, distance)
  return(diss)
}


new_data <- data.frame(item = character(0), MBL = numeric(0), MBL_x = numeric(0))
for (fileName in matching_files) {
  ret = func(fileName)
  name = paste(filePath, "/hat_", fileName, sep = "")
  #write_xlsx(ret, path = name) 
  
  diss = getDistance(ret)
  #print(diss)
  stem = gsub("\\.xlsx$", "", fileName)
  item = c(item=stem, MBL=diss[2], MBL_x = diss[1])
  new_data = rbind(new_data, item)
}

new_data

write_xlsx(new_data, '/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/results-MLB.xlsx')
