library(readxl)
library(dplyr)
library(ggplot2)
library(patchwork)
library(tidyr)
library(caret)


setwd("/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/estimation")

data <- read_excel('WH_HH.xlsx')

data = data[, c('WH', 'HH')]
#day data
#data = data[1:96, c('WH', 'HH')]

summary(data)


response_variable <- "HH"

# Define the formula for the model
formula <- as.formula(paste(response_variable, "~ ."))

# Fit a linear regression model using 10-fold cross-validation
cv_results <- train(
  formula,
  data = data,
  method = "lm",
  trControl = trainControl(method = "cv", number = 10)
)
cv_results
lm = cv_results$finalModel

#Coefficients:
#  (Intercept)           WH  
#0.01672      0.96105 


# Test on data 7&9, 30&50
test <- read_excel('WH_HH_7&9.xlsx')
#test

test$predicted_HH <- predict(lm, newdata = test)
test

mae_HH <- mean(abs(test$HH - test$predicted_HH))
rmse_HH = sqrt(mean((test$HH - test$predicted_HH)^2))
r_squared_HH <- 1 - sum((test$HH - test$predicted_HH)^2) / sum((test$HH - mean(test$HH))^2)

mae_HH
rmse_HH
r_squared_HH


