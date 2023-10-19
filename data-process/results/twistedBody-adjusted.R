library(readxl)
library(dplyr)
library(ggplot2)
library(patchwork)
library(tidyr)

setwd("/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/")

data <- read_excel('results-dimensions-adjusted.xlsx')
data$height = factor(data$height, levels=c('8', '10', '15', 'n8', 'n10', 'n15'))
data$speed = factor(data$speed, levels = c('1', '2', '3', '5'), 
                    labels = c('1 m/s', '2 m/s', '3 m/s', '5 m/s'))
data$MBL <- as.numeric(data$MBL)
data$MBL_x <- as.numeric(data$MBL_x)

data$DHz = -data$HDz
summary(data)

deltaAB = data$MBL - data$BAx

deltaAB
summary(deltaAB)
data$deltaAB = deltaAB
summary(data)

#mean(data$HAx)
#sd(data$HAx) *2
#mean(data$BHx)
#sd(data$BHx) * 2
#mean(data$T2Hz)
#mean(data$AHz)
#mean(data$DHz)
#mean(data$BHz)

# Create a histogram using ggplot2
deltaAB = ggplot(data, aes(x = deltaAB* 100)) +
  geom_histogram(fill = "lightblue", color = "black") +
  theme_minimal() +
  labs(x = "Subtraction of MBL_x and AB_x (Unit: cm)", y = "Frequency")

ggsave(paste('/Users/wyw/Downloads/chapter2-figures/results/posture-twist', '.png', sep = ''))


AH = ggplot(data, aes(x = HAx* 100)) +
  geom_histogram(fill = "lightblue", color = "black") +
  ggplot(aes(x = BHx* 100))
  geom_histogram(fill = "blue", color = "black") +
  theme_minimal() +
  labs(x = "Subtraction of MBL_x and AB_x (Unit: cm)", y = "Frequency")


#HAx	BHx	DHx	BAx	M2T2x	HT2x	M2Hx 	MBL_x	
#AHz	BHz	HDz	ABz	M2T2z	T2Hz	M2Hz	ADz	BDz	T2Az	T2Bz	
#MBL
  
dfx = data[, c('HT2x', 'HT1x', 'HAx', 'DHx', 'BHx', 'M1Hx', 'M2Hx', 'BAx', 'MBL', 'M2T2x')]
summary(dfx)
# Reshape data using tidyr::gather
data_longx <- tidyr::gather(dfx, key = "Column", value = "Value")

# Create the combined boxplot using ggplot2
#plot_combinedX <- ggplot(data_longx, aes(x = Column, y = Value *100)) +
plot_combinedX <- ggplot(data_longx, aes(x = factor(Column, levels = unique(Column)), y = Value * 100)) +
  geom_boxplot(fill = "lightblue") +
  labs(x = "landmark distances along x-axis", y = "horizontal distance (cm)")

# Print the combined boxplot plot
#plot_combinedX

dfz = data[, c('T2Hz', 'T1Hz', 'AHz', 'DHz', 'BHz', 'M1Hz','M2Hz', 'ABz', 'ADz', 'BDz', 'T2Az', 'T2Bz')]   #'M2T2z',
summary(dfz)

data_longz <- tidyr::gather(dfz, key = "Column", value = "Value")

# Create the combined boxplot using ggplot2
#plot_combinedz <- ggplot(data_longz, aes(x = Column, y = Value *100)) +
plot_combinedZ <- ggplot(data_longz, aes(x = factor(Column, levels = unique(Column)), y = Value * 100)) +
  geom_boxplot(fill = "lightblue") +
  labs(x = "landmark distances along z-axis", y = " height difference (cm)") 

# Print the combined boxplot plot
#plot_combinedX | plot_combinedZ
#ggsave(paste('/Users/wyw/Downloads/chapter2-figures/results/distances', '.png', sep = ''))


hdata = read_excel('results-BM-adjusted.xlsx')
hdata$height = factor(hdata$height, levels=c('8', '10', '15', 'n8', 'n10', 'n15'))
hdata$speed = factor(hdata$speed, levels = c('1', '2', '3', '5'), 
                    labels = c('1 m/s', '2 m/s', '3 m/s', '5 m/s'))
hdata$MBL <- as.numeric(hdata$MBL)
summary(hdata)
dfh = hdata[, c('AW', 'WH', 'HH', 'BH', 'WiH', 'MBL')]
summary(dfh)
data_longh <- tidyr::gather(dfh, key = "Column", value = "Value")

# Create the combined boxplot using ggplot2
plot_combinedh <- ggplot(data_longh, aes(x = factor(Column, levels = unique(Column)), y = Value * 100)) +
#plot_combinedh <- ggplot(data_longh, aes(x = Column, y = Value *100)) +
  geom_boxplot(fill = "lightblue") +
  labs(x = "body measurements", y = "value (cm)") 

#plot_combinedh
#ggsave(paste('/Users/wyw/Downloads/chapter2-figures/results/heights', '.png', sep = ''))


plot_combinedX / plot_combinedZ /plot_combinedh 




#summary(data)
#edata = read_excel('results-campaigns.xlsx')
#edata$temperature <- as.numeric(edata$temperature)
#edata$height = factor(edata$height, levels=c('8', '10', '15', '30', '50', 'n8', 'n10', 'n15'))
#edata$date = factor(edata$date, levels=c('9', '8', '92', '31'), labels=c('9_a', '8', '9_p', '31'))
##edata$speed = factor(edata$speed, levels = c('1', '2', '3', '5', '7', '9'), 
##                     labels = c('1 m/s', '2 m/s', '3 m/s', '5 m/s', '7 m/s', '9 m/s'))
#
#summary(edata)
#
