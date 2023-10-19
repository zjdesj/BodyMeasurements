# for body measurements data summary (firgure)

library(readxl)
library(dplyr)
library(ggplot2)
library(patchwork)

setwd("/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/")

data <- read_excel('results-BM.xlsx')
data$height = factor(data$height, levels=c('8', '10', '15', '30', '50', 'n8', 'n10', 'n15'))
data$speed = factor(data$speed, levels = c('1', '2', '3', '5', '7', '9'), 
                    labels = c('1 m/s', '2 m/s', '3 m/s', '5 m/s', '7 m/s', '9 m/s'))
data$MBL <- as.numeric(data$MBL)
summary(data)

bmList = c('AW', 'HH', 'WH', 'WiH', 'BH', 'MBL')
for (bm in bmList) {
  fig1 <- paste("p1_", bm, sep = "")
  item1 = ggplot(data, aes_string(x="height",y=bm,fill="height")) +
    geom_boxplot() + 
    geom_jitter(width = 0.1,alpha = 0.2) +
    facet_wrap(~speed)+ 
    theme(axis.text.x = element_text(angle = 45,hjust = 1)) +
    labs(y='') +
    ggtitle(bm) #+
    #theme(plot.margin = margin(t = 0, r= 0, b =0, l = 0, unit='pt'))+
    #theme(plot.title=element_text(margin=margin(t=40,b=-30)))
  assign(fig1, item1)
  
  fig2 <- paste("p2_", bm, sep = "")
  item2 = ggplot(data, aes_string(x="height",y=bm,fill="height")) +
    geom_boxplot() + 
    geom_jitter(width = 0.1,alpha = 0.2) +
    theme(axis.text.x = element_text(angle = 45,hjust = 1)) +
    labs(y='') +
    ggtitle(bm) #+
    #theme(plot.margin = margin(t = 0, r= 0, b =0, l = 0, unit='pt'))+
    #theme(plot.title=element_text(margin=margin(t=40,b=-30)))
  assign(fig2, item2)
  
  fig3 <- paste("p3_", bm, sep = "")
  item3 = ggplot(data, aes_string(x="speed",y=bm,fill="speed")) +
    geom_boxplot() + 
    geom_jitter(width = 0.1,alpha = 0.2) +
    theme(axis.text.x = element_text(angle = 45,hjust = 1)) +
    labs(y='')+
    ggtitle(bm) #+
    #theme(plot.margin = margin(t = 0, r= 0, b =0, l = 0, unit='pt'))+
    #theme(plot.title=element_text(margin=margin(t=40,b=-30)))
  assign(fig3, item3)
}

#p2_AW / p3_AW | p1_AW + plot_layout(guides = "collect") 

design <- "ACCDFF
           BCCEFF
           GIIJLL
           HIIKLL
           MOOPRR
           NOOQRR"

 wrap_plots(
            A=p2_AW,B=p3_AW,C=p1_AW,
            D=p2_HH,E=p3_HH,F=p1_HH,
            G=p2_BH,H=p3_BH,I=p1_BH,
            J=p2_WH,K=p3_WH,L=p1_WH,
            M=p2_WiH,N=p3_WiH,O=p1_WiH,
            P=p2_MBL,Q=p3_MBL,R=p1_MBL,
            design = design, 
            guides = "collect")

ggsave(paste('/Users/wyw/Downloads/chapter2-figures/results/BM/data-BM.png', sep = ''))


#fig_AW + fig_HH + fig_BH + fig_WiH + fig_WH + fig_MBL + plot_layout(ncol = 2, nrow=3, guides = "collect")
#
#fig_HH
#fig_AW + fig_HH + plot_layout(ncol = 2, guides = "collect")
