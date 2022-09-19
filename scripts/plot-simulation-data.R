library(tidyverse)
library(data.table)
library(gridExtra)

unfolded <- read.csv('../data/alpha-simulation-unfolded.csv', header=T)

# Create a dataframe with difference from true values
df.u <- data.frame('parameters' = unfolded$Parameter)
df.u$MK = round((unfolded$MK - unfolded$TrueAlpha), 4)
df.u$FWW = round((unfolded$FWW - unfolded$TrueAlpha), 4)
df.u$AsymptoticMK = round((unfolded$AsymptoticMK - unfolded$TrueAlpha), 4)
df.u$GammaGamma = round((unfolded$GammaGamma - unfolded$TrueAlpha), 4)
df.u$GammaExpo = round((unfolded$GammaExpo - unfolded$TrueAlpha), 4)
df.u$ScaledBeta = round((unfolded$ScaledBeta - unfolded$TrueAlpha), 4)
df.u$DisplGamma = round((unfolded$DisplGamma - unfolded$TrueAlpha), 4)
df.u$FGMBesselK = round((unfolded$FGMBesselK - unfolded$TrueAlpha), 4)

# save the the dataframe
#write.csv(df.u, 'diff-values_unfolded.csv')

# Convert dataframe to long format
df.u.melt <- melt(as.data.table(df.u), id="parameters")
# Create a data table with mean values
df.u.mean <- df.u.melt[ ,list(avg=round(mean(value),3)), by=variable]


# Jitter plot of alpha values
ggu <- ggplot(df.u.melt, aes(x=variable, y=value)) +
    geom_jitter(aes(color=parameters, fill=parameters), shape=21,
                alpha=0.8, size=4,
                stroke=.1, position=position_dodge(width=0.2)) +
    geom_hline(yintercept=0, linetype="longdash", color = "red") +
    theme_bw() +
    theme(axis.text.x = element_text(face='bold', angle = 45, hjust=1)) +
    theme(axis.text.x = element_text(face='bold', angle = 45, hjust=1)) +
    ylab('Difference from True Alpha') + xlab(NULL) +
    scale_y_continuous(breaks=seq(-1.6, 0.6, 0.2))

# Add the mean values as points w/ labels
ggu + geom_point(df.u.mean, mapping=aes(x=variable, y=avg), size=2,
                 shape=4, stroke=1.2) 
    #geom_text(data=df.u.mean, aes(x=variable, y=avg, label=avg, fontface="bold"), nudge_x = 0.30)

ggu

ggsave("simulation-unfolded.png", path="../plots/")

#######

# Processing the folded SFS data
folded <- read.csv('../data/alpha-simulation-folded.csv', header=T)

df.f <- data.frame('parameters' = folded$Parameter)
df.f$GammaZero = round((folded$GammaZero - folded$TrueAlpha), 4)
df.f$GammaExpo = round((folded$GammaExpo - folded$TrueAlpha), 4)
df.f$ScaledBeta = round((folded$ScaledBeta - folded$TrueAlpha), 4)
df.f$DisplGamma = round((folded$DisplGamma - folded$TrueAlpha), 4)
df.f$FGMBesselK = round((folded$FGMBesselK - folded$TrueAlpha), 4)

#write.csv(df.f, 'diff-values_folded.csv')

df.f.melt <- melt(as.data.table(df.f), id='parameters')
df.f.mean <- df.f.melt[ ,list(avg=round(mean(value),3)), by=variable]

# Jitter plot of alpha values
ggf <- ggplot(df.f.melt, aes(x=variable, y=value)) +
    geom_jitter(aes(color=parameters, fill=parameters), shape=21,
                alpha=0.8, size=4,
                stroke=.1, position=position_dodge(width=0.2)) +
    geom_hline(yintercept=0, linetype="longdash", color = "red") +
    theme_bw() +
    theme(axis.text.x = element_text(face='bold', angle = 45, hjust=1)) +
    theme(axis.text.x = element_text(face='bold', angle = 45, hjust=1)) +
    ylab('Difference from True Alpha') + xlab(NULL) +
    scale_y_continuous(breaks=seq(-1.6, 0.6, 0.2))

# Add the mean values as points w/ labels
ggf + geom_point(df.f.mean, mapping=aes(x=variable, y=avg), size=2,
                 shape=4, stroke=1.2) 
    #geom_text(data=df.f.mean, aes(x=variable, y=avg, label=avg, fontface="bold"), nudge_x = 0.20)

ggf

ggsave("simulation-folded.png", path="../plots/")

###########

# Make a grid for both figures
#p <- grid.arrange(ggu, ggf)
#p

#ggsave("simulation-data.png", p)


