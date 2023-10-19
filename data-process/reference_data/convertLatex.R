#install.packages("xtable")
library(readxl)
library(xtable)

#data = read_excel('/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/effects/Effects.xlsx')
data = read_excel('/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/BM/results-BM-adjusted-summary.xlsx')
data



data2 =  data.frame(
  Parameters = c("height", "speed", "maxLightStrength", "minLightStrength", "temperature", "humidity", "windSpeed", "size"),
  `BM_alldata(n = 275)` = c(0.2874, 0.4428, 0.1597, 0.0540, 0.0894, 0.0333, 0.0383, 0.0169),
  `Pillai (BM_alldata)` = c("4.69E-17 ***", "1.25E-30 ***", "3.32E-08 ***", "0.0237 *", "0.0004 ***", "0.1797", "0.1136", "0.6120"),
  `Pr_gt_F (BM_alldata)` = c("***", "***", "***", "*", "***", "", "", ""),
  `BM_daydata(n = 235)` = c(0.2542, 0.4408, 0.0727, 0.0696, 0.0612, 0.0403, 0.0443, 0.0242),
  `Pillai (BM_daydata)` = c("3.58E-12 ***", "1.60E-25 ***", "0.0099 **", "0.0133 *", "0.0287 *", "0.1647", "0.1199", "0.4870"),
  `Pr_gt_F (BM_daydata)` = c("***", "***", "**", "*", "*", "", "", ""),
  `BM_nightdata(n = 40)` = c(0.2584, "", "", "", "0.0330", "", "", "0.2406"),
  `Pillai (BM_nightdata)` = c("0.1455", "", "", "", "0.9827", "", "", "0.1862"),
  `Pr_gt_F (BM_nightdata)` = c("***", "", "", "", "*", "", "", ""),
  `BM_alldata(n = 36)` = c(0.8449, 0.3628, 0.0092, 0.0236, 0.2455, 0.2040, 0.0966, NA),
  `Pillai (BM_alldata2)` = c("1.16E-10 ***", "0.0076 **", "0.9700", "0.8889", "0.0586 .", "0.1095", "0.4417", NA),
  `Pr_gt_F (BM_alldata2)` = c("***", "**", "", "*", ".", "", "", "")
)
data[2:9,] = data2[1:8,]
data = rbind(data[1:2,], data2)

data[, -1] <- lapply(data[, -1], function(x) format(x, digits = c(1,3)))
latex_table <- xtable(data, caption = "Your Table Caption", label = "tab: effect")
print(latex_table)

writeLines(as.character(latex_table), "/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/effects/effects.tex")
