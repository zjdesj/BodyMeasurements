# for body measurments data summary (table)

library(readxl)
library(dplyr)
library(ggplot2)
library(corrplot)
library(randomForest)
library(writexl)

setwd("/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/")

#data <- read_excel('results-BM.xlsx')[236:275,]
#data <- read_excel('results-BM.xlsx')[1:235,]
data <- read_excel('results-BM.xlsx')

data$MBL <- as.numeric(data$MBL)
data$height = as.numeric(data$nheight)
data$speed = as.numeric(data$speed)

# 补全windSpeed
#mean_windSpeed <- mean(data$windSpeed, na.rm = TRUE)
#data$windSpeed[is.na(data$windSpeed)] <- mean_windSpeed

summary(data)

cor(data[, c('maxLightStrength', 'minLightStrength')])

# Calculate correlation matrix
correlation_matrix <- cor(data[, c( "AW", 'HH', 'WH', 'WiH', 'BH', 'MBL', 
                                    "maxLightStrength", "minLightStrength", "temperature",
                                    "humidity", "windSpeed", "size", "height", "speed")])

# Visualize correlation matrix
corrplot(correlation_matrix, method = "color")


# Perform linear regression
regression_model <- lm(cbind(AW, HH, WH, WiH, BH, MBL) ~ height + I(height^2) + speed + I(speed^2) + height:speed + maxLightStrength 
                       + minLightStrength + temperature + humidity + windSpeed + size, data = data)
summary(regression_model)

tTest = list()
i=0
for (item in summary(regression_model)) {
  i = i + 1
  tTest = cbind(tTest, item$coefficients[, "Pr(>|t|)"])
}
tTest

# Create the data frame
p_values_df <- data.frame(
  Predictor = rownames(p_values_df),
  model1 = c(5.369331e-09, 0.01649506, 0.1629181, 0.1133112, 0.2216672, 0.3454916, 0.1999987, 0.1725888, 0.1269941, 0.1177414, 0.5759461, 0.4671924),
  model2 = c(1.117222e-25, 0.3452439, 0.790168, 0.2835421, 0.3548962, 0.2021867, 0.3262356, 0.7207494, 0.7963299, 0.0610961, 0.984751, 0.8900728),
  model3 = c(3.474364e-25, 0.4504242, 0.7019816, 0.9286303, 0.929365, 0.1399462, 0.144838, 0.993254, 0.6034266, 0.05417023, 0.7839673, 0.9472979),
  model4 = c(3.026843e-16, 0.2941108, 0.07562915, 0.4126179, 0.4021361, 0.1711812, 0.1628881, 0.7588319, 0.4139602, 0.4180415, 0.3761496, 0.8065396),
  model5 = c(4.618792e-11, 0.8796805, 0.3419173, 0.7862754, 0.3357082, 0.5362766, 0.7706146, 0.2772832, 0.9176636, 0.08117909, 0.07652618, 0.1109913),
  model6 = c(0.0658102, 0.6864948, 0.6111282, 0.400731, 0.6782892, 0.3832519, 0.2566187, 0.4808295, 0.6560879, 0.3268265, 0.3826322, 0.5639676)
)

# Set row names to the predictor variable names
rownames(p_values_df) <- c("(Intercept)", "height", "I(height^2)", "speed", "I(speed^2)", "maxLightStrength", "minLightStrength", "temperature", "humidity", "windSpeed", "size", "height:speed")

# Save the data frame to an Excel file
write_xlsx(p_values_df, '/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/result-coefficients-1.xlsx')



# Perform linear regression
regression_model <- lm(cbind(AW, HH, WH, WiH, BH, MBL) ~ height + speed + maxLightStrength 
                       + minLightStrength + temperature + humidity + windSpeed + size, data = data)
summary(regression_model)

tTest = list()
i=0
for (item in summary(regression_model)) {
  i = i + 1
  tTest = cbind(tTest, item$coefficients[, "Pr(>|t|)"])
}
tTest

# Create the matrix
p_values_df <- data.frame(
  model1 = c(0.04702739, 0.6831169, 0.6011595, 0.5927728, 0.8540475),
  model2 = c(5.057429e-06, 0.5868181, 0.3844623, 0.7141492, 0.5720589),
  model3 = c(1.018141e-06, 0.5235409, 0.5760727, 0.6632831, 0.1921964),
  model4 = c(4.824695e-06, 0.6849995, 0.5027363, 0.7403495, 0.9916739),
  model5 = c(1.958324e-06, 0.978821, 0.8454449, 0.9492372, 0.9505475),
  model6 = c(0.5696466, 0.5284646, 0.2939594, 0.676825, 0.02405919)
)

# Create a data frame with column names
rownames(p_values_df) <- c("(Intercept)", "height",  "speed", "maxLightStrength", "minLightStrength", "temperature", "humidity", "windSpeed", "size")



# Save the data frame to an Excel file
write_xlsx(p_values_df, '/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/result-coefficients-4.xlsx')




pDay = data %>%
  filter(height %in% c(8, 10, 15), speed %in% c(3, 5))


regression_model <- lm(cbind(AW, HH, WH, WiH, BH, MBL) ~ height + speed + maxLightStrength 
                       + minLightStrength + temperature + humidity + windSpeed + size, data = pDay)
summary(regression_model)


tTest = list()
i=0
for (item in summary(regression_model)) {
  i = i + 1
  tTest = cbind(tTest, item$coefficients[, "Pr(>|t|)"])
}
tTest

# Create the matrix
p_values_df <- data.frame(
  model1 = c(0.02922232, 0.0378261, 0.2626139, 0.06827454, 0.02476573, 0.01573462, 0.03219295),
  model2 = c(0.6671024, 0.8569418, 0.9704641, 0.9328016, 0.8596048, 0.8076201, 0.1354534),
  model3 = c(0.4917561, 0.3425348, 0.2517057, 0.8827342, 0.3578612, 0.3725563, 0.07897069),
  model4 = c(0.518441, 0.662975, 0.5976906, 0.6064113, 0.6277598, 0.6102932, 0.008935043),
  model5 = c(0.2922935, 0.3827922, 0.8800099, 0.3533593, 0.3475249, 0.3458768, 0.0001656918),
  model6 = c(0.0627336, 0.05573958, 0.09290678, 0.2561844, 0.05458247, 0.05667151, 0.7776912)
)

# Create a data frame with column names
rownames(p_values_df) <- c("(Intercept)", "height",  "speed", "maxLightStrength", "minLightStrength", "temperature", "humidity", "windSpeed", "size")
write_xlsx(p_values_df, '/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/result-coefficients-5.xlsx')




