library(tidyverse)
library(data.table)
library(gridExtra)

df.unfolded <- read.csv('../data/alpha-empirical-unfolded.csv', header=T)

df <- df.unfolded[,c("Sample","FWW")]

df.u.melt <- melt(as.data.table(df), id='Sample')

ggu <- ggplot(df, aes(x=Sample, y=FWW)) +
    #geom_jitter(aes(color=Parameter, stroke=1.5),
    #            width=0.1, height=0.1) +
    geom_point(aes(color=Sample, shape=Sample),
               size=9, alpha=0.9) +
    theme_bw() +
    theme(axis.text.x = element_text(face='bold', angle = 45, hjust=1, size=14)) +
    coord_cartesian(ylim=c(-0.2,0.5)) +
    #theme(axis.text.x = element_text(face='bold', angle = 45, hjust=1)) +
    #ylab('Difference from True Alpha') + xlab(NULL) +
    scale_y_continuous(breaks=seq(-0.8, 0.4, 0.1)) +
    #theme(axis.ticks.x = element_blank(),
    #      axis.text.x = element_blank()) +
    xlab("Species") + ylab('Alpha value')

ggu

ggsave("empirical-FWW.png", path="../plots/")
