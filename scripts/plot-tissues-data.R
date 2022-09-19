library(tidyverse)
library(data.table)
library(gridExtra)

df.unfolded <- read.csv('../data/alpha-tissue-unfolded.csv', header=T)
df.folded <- read.csv('../data/alpha-tissue-folded.csv', header=T)

df.u.melt <- melt(as.data.table(df.unfolded), id='Tissue')
df.f.melt <- melt(as.data.table(df.folded), id='Tissue')

ggu <- ggplot(df.u.melt, aes(x=value, y=variable, fill=variable)) +
    geom_col(position = 'dodge') +
    #geom_point() +
    facet_wrap(~Tissue, ncol = 2) +
    scale_y_discrete(limits=rev) +
    #geom_point(aes(color=Tissue, shape=Tissue),
    #           size=4, alpha=0.9) +
    theme_bw() +
    theme(axis.text.y = element_blank()) +
    #ggtitle("Unfolded - all methods") +
    theme(axis.ticks.y = element_blank(),
          axis.text.y = element_blank()) +
    xlab(NULL) + 
    ylab(NULL)
    #theme(axis.text.x = element_text(face='bold', angle = 45, hjust=1)) +
    #theme(axis.text.x = element_text(face='bold', angle = 45, hjust=1)) +
    #ylab('Difference from True Alpha') + xlab(NULL) +
    #scale_y_continuous(breaks=seq(-0.8, 0.8, 0.2)) +
    #theme(axis.ticks.x = element_blank(),
    #      axis.text.x = element_blank()) +
    #xlab("Model") + ylab('Alpha value')

ggu

ggsave("tissues-unfolded.png", path="../plots/")

##

ggf <- ggplot(df.f.melt, aes(x=value, y=variable, fill=variable)) +
    geom_col(position = 'dodge') +
    geom_point() +
    facet_wrap(~Tissue, ncol = 3) +
    theme_bw() +
    theme(axis.text.y = element_blank()) +
    #ggtitle("Unfolded - all methods") +
    theme(axis.ticks.y = element_blank(),
          axis.text.y = element_blank()) +
    xlab(NULL) +
    ylab(NULL)
ggf

ggsave("tissues-folded.png", path="../plots/")

#p <- grid.arrange(ggu, ggf)
#ggsave("popgen-data.png", p)

