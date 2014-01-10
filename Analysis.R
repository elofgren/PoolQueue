################################################################
# Statistical Analysis and Graphic Code for Pool-Queue Project #
################################################################

# Import Packages
library(ggplot2)
library(gridExtra)
library(plyr)

### Analysis of Ecology Results ###

## Pool-based Predation ##
PoolFoxes <- read.csv("PoolFoxes.csv",header=FALSE,skip=1)