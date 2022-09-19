library(tidyverse)
library(data.table)
library(gridExtra)

df.unfolded <- read.csv('../data/alpha-empirical-unfolded.csv', header=T)
df.folded <- read.csv('../data/alpha-empirical-folded.csv', header=T)

df.u.melt <- melt(as.data.table(df.unfolded), id='Sample')
df.f.melt <- melt(as.data.table(df.folded), id='Sample')

ggu <- ggplot(df.f.melt, aes(x=variable, y=value)) +
    #geom_jitter(aes(color=Parameter, stroke=1.5),
    #            width=0.1, height=0.1) +
    geom_point(aes(color=Sample, shape=Sample),
               size=4, alpha=0.9) +
    geom_hline(yintercept=0, linetype="longdash", color = "red") +
    theme_bw() +
    theme(axis.text.x = element_text(face='bold', angle = 45, hjust=1, size=8)) +
    #theme(axis.text.x = element_text(face='bold', angle = 45, hjust=1)) +
    ylab('Difference from True Alpha') + xlab(NULL) +
    scale_y_continuous(breaks=seq(-0.8, 0.8, 0.2)) +
    #theme(axis.ticks.x = element_blank(),
    #      axis.text.x = element_blank()) +
    xlab("Model") + ylab('Alpha value')

ggu

ggsave("empirical-folded.png", path="../plots/")

##

ggf <- ggplot(df.f.melt, aes(x=variable, y=value)) +
    geom_point(aes(color=Sample, shape=Sample),
               size=4, alpha=0.9) +
    theme_bw() +
    theme(axis.text.x = element_text(face='bold', angle = 45, hjust=1)) +
    theme(axis.text.x = element_text(face='bold', angle = 45, hjust=1)) +
    ylab('Difference from True Alpha') + xlab(NULL) +
    scale_y_continuous(breaks=seq(-0.8, 0.8, 0.2)) +
    xlab("Model") + ylab('Alpha value')

ggf

ggsave("empirical-folded.png", path="../plots/")

#p <- grid.arrange(ggu, ggf)
#ggsave("popgen-data.png", p)

