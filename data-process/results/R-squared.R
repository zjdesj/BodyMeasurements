library(ggplot2)
library(tidyr)


# Create a data frame from the provided data
data <- data.frame(
  method = c(
    "all_data_randomForest_R2", "all_data_quadratic_R2", "all_data_R2", 
    "all_data_AR2", "day_data_R2", "day_data_AR2", 
    "day_data(8/10/15,3/5)_R2", "day_data(8/10/15,3/5)_AR2",
    "night_data_R2", "night_data_AR2"
  ),
  AW = c(0.4169, 0.4212, 0.4142, 0.3966, 0.3356, 0.3121, 0.332, 0.2485, 0.04648, -0.0625),
  HH = c(-0.0559, 0.1379, 0.135, 0.109, 0.1542, 0.1242, 0.1557, 0.05019, 0.06781, -0.03873),
  WH = c(-0.0524, 0.1113, 0.1108, 0.08402, 0.131, 0.1003, 0.1743, 0.07107, 0.08325, -0.02152),
  WiH = c(-0.1182, 0.1108, 0.09427, 0.06703, 0.1274, 0.09654, 0.16, 0.05497, 0.02451, -0.08698),
  BH = c(0.3101, 0.362, 0.3527, 0.3332, 0.3554, 0.3326, 0.326, 0.2418, 0.003223, -0.1107),
  MBL = c(-0.0502, 0.09716, 0.09495, 0.06773, 0.1002, 0.06833, 0.1166, 0.006204, 0.1652, 0.06985)
)

# Print the data frame
print(data)


# Reshape the data into a longer format
data_long <- gather(data, Metric, Value, -method)

# Convert the 'method' column to a factor with the desired order
data_long$method <- factor(data_long$method, levels = unique(data_long$method))

# Create a bar plot using ggplot2
ggplot(data_long, aes(x = method, y = Value, fill = Metric)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "R-squared from various methods and data",
       y = "variation explanation") +
  theme_minimal() +
  labs(fill = "BM") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
