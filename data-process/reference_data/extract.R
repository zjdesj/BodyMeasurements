library(readxl)
filePath =  '/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/reference'
setwd(filePath)

# Read Excel files into data frames
file <- 'reference-merge.xlsx'

data = read.xlsx(file)

summary(data)

data$h1 = data$lt_mean - data$lb_mean
data$h1

data$h2 = data$rt_mean - data$rb_mean
data$h2

data$lsize = data$lb_size + data$lt_size

data$rsize = data$rb_size + data$rt_size

write_xlsx(data, 'reference.xlsx')