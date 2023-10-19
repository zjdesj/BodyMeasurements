library(openxlsx)
library(readxl)
filePath =  '/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/reference'
setwd(filePath)

# Read Excel files into data frames
file1 <- "bars.xlsx"
file2 <- "robs-best.xlsx"
#file1 <- "reference-merge.xlsx"
#file2 <- "robs-ab.xlsx"

df1 <- read.xlsx(file1)
df2 <- read.xlsx(file2)

# Extract the 'stem' column from both data frames
stem_column <- df1$plan

# Merge the two data frames using cbind() based on the 'stem' column
merged_df <- cbind(df1, df2[match(stem_column, df2$plan), ])

write_xlsx(merged_df, 'reference-merge.xlsx')



library(openxlsx)
library(readxl)
f2 =  '/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/reference/reference.xlsx'
f1 =  '/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/results-campaigns.xlsx'
df1 <- read.xlsx(f1)
df2 <- read.xlsx(f2)

# Extract the 'stem' column from both data frames
stem_column <- df1$campaign

# Merge the two data frames using cbind() based on the 'stem' column
merged_df <- cbind(df1, df2[match(stem_column, df2$plan), ])

write_xlsx(merged_df, '/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/reference/reference-env.xlsx')
