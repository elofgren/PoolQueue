################################################################
# Statistical Analysis and Graphic Code for Pool-Queue Project #
################################################################

# Import Packages
library(ggplot2)
library(gridExtra)
library(plyr)

### Analysis of Ecology Results ###
## C- and N- Extinction Probability
PoolExtinction <- as.data.frame(read.csv("~/Documents/Code/PoolQueue/LVpoolExtinction.csv"))
QueueExtinction <- as.data.frame(read.csv("~/Documents/Code/PoolQueue/LVqueueExtinction.csv"))

# Prey
pool_trials <- nrow(PoolExtinction)
queue_trials <- nrow(QueueExtinction)

extinctprey_pool <- sum(PoolExtinction$Prey)
extinctprey_queue <- sum(QueueExtinction$Prey)

PreyExtinctTest <- prop.test(x = c(extinctprey_pool, extinctprey_queue), n = c(pool_trials,queue_trials))
PreyExtinctDiff <- (extinctprey_pool/pool_trials) - (extinctprey_queue/queue_trials)
PreyExtinctCI <- PreyExtinctTest$conf.int
PreyExtinctP <- PreyExtinctTest$p.value

# Predators
extinctpred_pool <- sum(PoolExtinction$Predator)
extinctpred_queue <- sum(QueueExtinction$Predator)

PredExtinctTest <- prop.test(x = c(extinctpred_pool, extinctpred_queue), n = c(pool_trials,queue_trials))
PredExtinctDiff <- (extinctpred_pool/pool_trials) - (extinctpred_queue/queue_trials)
PredExtinctCI <- PredExtinctTest$conf.int
PredExtinctP <- PredExtinctTest$p.value

# N-extinction
extinctN_pool <- sum(PoolExtinction$N)
extinctN_queue <- sum(QueueExtinction$N)

NExtinctTest <- prop.test(x = c(extinctN_pool, extinctN_queue), n = c(pool_trials,queue_trials))
NExtinctDiff <- (extinctN_pool/pool_trials) - (extinctN_queue/queue_trials)
NExtinctCI <- NExtinctTest$conf.int
NExtinctP <- NExtinctTest$p.value

## Mean and Median Species Populations




