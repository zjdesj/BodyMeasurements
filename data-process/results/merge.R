library(openxlsx)
library(readxl)
filePath =  '/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/'
setwd(filePath)

# Read Excel files into data frames
file1 <- "results-landmarks.xlsx"
file2 <- "results-MLB.xlsx"

df1 <- read.xlsx(file1)
df2 <- read.xlsx(file2)

# Extract the 'stem' column from both data frames
stem_column <- df1$stem

# Merge the two data frames using cbind() based on the 'stem' column
merged_df <- cbind(df1, df2[match(stem_column, df2$stem), ])

write_xlsx(merged_df, 'results-merge.xlsx')

