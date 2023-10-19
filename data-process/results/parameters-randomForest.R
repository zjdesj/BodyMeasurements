# for body measurments data summary (table)

library(readxl)
library(dplyr)
library(ggplot2)
library(corrplot)
library(randomForest)
library(writexl)
library(tidyr)

setwd("/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/")

data <- read_excel('results-BM.xlsx')
data$MBL <- as.numeric(data$MBL)
data$height = as.numeric(data$nheight)
data$speed = as.numeric(data$speed)

summary(data)

target <- data[, c("AW", "HH", "WH", "WiH", "BH", "MBL")]
features <- data[, c("height", "speed", "maxLightStrength", "minLightStrength", "temperature", "humidity", "windSpeed", "size")]
# "AW", 'HH', 'WH', 'WiH', 'BH', 'MBL'

# Prepare the targets
target_AW <- data$AW
target_HH <- data$HH
target_WH <- data$WH
target_WiH <- data$WiH
target_BH <- data$BH
target_MBL <- data$MBL

# Create separate random forest models for each target
rf_model_AW <- randomForest(features, target_AW, ntree = 500)
rf_model_HH <- randomForest(features, target_HH, ntree = 500)
rf_model_WH <- randomForest(features, target_WH, ntree = 500)
rf_model_WiH <- randomForest(features, target_WiH, ntree = 500)
rf_model_BH <- randomForest(features, target_BH, ntree = 500)
rf_model_MBL <- randomForest(features, target_MBL, ntree = 500)

print(rf_model_AW)
print(rf_model_HH)
print(rf_model_WH)
print(rf_model_WiH)
print(rf_model_BH)
print(rf_model_MBL)

varImpPlot(rf_model_AW)
varImpPlot(rf_model_HH)
varImpPlot(rf_model_WH)
varImpPlot(rf_model_WiH)
varImpPlot(rf_model_BH)
varImpPlot(rf_model_MBL)


summary(rf_model_AW)

importance_scores <- importance(rf_model_AW)
ret = importance_scores
importance_scores <- importance(rf_model_HH)
ret = cbind(ret, importance_scores)
importance_scores <- importance(rf_model_WH)
ret = cbind(ret, importance_scores)
importance_scores <- importance(rf_model_WiH)
ret = cbind(ret, importance_scores)
importance_scores <- importance(rf_model_BH)
ret = cbind(ret, importance_scores)
importance_scores <- importance(rf_model_MBL)
ret = cbind(ret, importance_scores)


colnames( ret) =  c("AW", "HH", "WH", "WiH", "BH", "MBL")

ret


fret = data.frame(ret)
fret

importance_data <- data.frame(
  Feature = rownames(fret),
  AW = fret$AW,
  HH = fret$HH,
  WH = fret$WH,
  WiH = fret$WiH,
  BH = fret$BH,
  MBL = fret$MBL
)

#importance_data = rbind(importance_data, c('R2', 0.4169,-0.0559,	-0.0524,	-0.1182,	0.3101,	-0.0502))

# Convert the data from wide to long format using tidyr
importance_data_long <- importance_data %>%
  pivot_longer(cols = -Feature, names_to = "Target", values_to = "Importance")

# Create the ggplot bar plot
ggplot(importance_data_long, aes(x = Feature, y = Importance, fill = Target)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Feature Importance Scores",
       x = "Feature",
       y = "Importance Score") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_brewer(palette = "Set1")


importance_data
write_xlsx(importance_data, '/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/result-importanceScore-randomForest.xlsx')
