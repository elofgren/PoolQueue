################################################################
# Statistical Analysis and Graphic Code for Pool-Queue Project #
################################################################

# Import Packages
library(ggplot2)
library(gridExtra)
library(plyr)

### Analysis of Ecology Results ###
## C- and N- Extinction Probability
PoolExtinction <- as.data.frame(read.csv("LVpoolExtinction.csv"))
QueueExtinction <- as.data.frame(read.csv("LVqueueExtinction.csv"))

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
PoolMeans <- as.data.frame(read.csv("LVpoolMean.csv"))
QueueMeans <- as.data.frame(read.csv("LVqueueMean.csv"))
PoolMeans$Method <- factor("Pool")
QueueMeans$Method <- factor("Queue")
Means <- rbind(PoolMeans,QueueMeans)
PreyMeansTest <- kruskal.test(Means$Prey,Means$Method)
PredMeansTest <- kruskal.test(Means$Predator,Means$Method)
NMeansTest <- kruskal.test(Means$N,Means$Method)

PoolMedians <- as.data.frame(read.csv("LVpoolMedian.csv"))
QueueMedians <- as.data.frame(read.csv("LVqueueMedian.csv"))
PoolMedians$Method <- factor("Pool")
QueueMedians$Method <- factor("Queue")
Medians <- rbind(PoolMedians,QueueMedians)
PreyMedianTest <- kruskal.test(Medians$Prey,Medians$Method)
PredMedianTest <- kruskal.test(Medians$Predator,Medians$Method)
NMedianTest <- kruskal.test(Medians$N,Medians$Method)

### Analysis of HAI Results ###
HAIPoolExtinction <- as.data.frame(read.csv("CDIPoolExtinction.csv"))
HAIQueueExtinction <- as.data.frame(read.csv("CDIQueueExtinction.csv"))

# N-extinction
haipool_trials <- nrow(HAIPoolExtinction)
haiqueue_trials <- nrow(HAIQueueExtinction)

haiextinct_pool <- sum(HAIPoolExtinction$Extinction)
haiextinct_queue <- sum(HAIQueueExtinction$Extinction)

HAIExtinctTest <- prop.test(x = c(haiextinct_pool, haiextinct_queue), n = c(haipool_trials,haiqueue_trials))
HAIExtinctDiff <- (haiextinct_pool/haipool_trials) - (haiextinct_queue/haiqueue_trials)
HAIExtinctCI <- HAIExtinctTest$conf.int
HAIExtinctP <- HAIExtinctTest$p.value

# Outcomes
HAIPoolOutcomes <- as.data.frame(read.csv("CDIPoolOutcomes.csv"))
HAIQueueOutcomes <- as.data.frame(read.csv("CDIQueueOutcomes.csv"))
HAIPoolOutcomes$Method <- factor("Pool")
HAIQueueOutcomes$Method <- factor("Queue")
HAIOutcomes <- rbind(HAIPoolOutcomes,HAIQueueOutcomes)
IncidentTest <- kruskal.test(HAIOutcomes$Incident,HAIOutcomes$Method)
RecurTest <- kruskal.test(HAIOutcomes$Recur,HAIOutcomes$Method)

### Analysis of Computation Time ###
CompTime <- as.data.frame(read.csv("RunTimes.csv"))
LVComp <- CompTime[which(CompTime$Model=="LV"),]
CDIComp <- CompTime[which(CompTime$Model=="CDI"),]
LVCompTest <- kruskal.test(LVComp$Time ~ LVComp$Method)
CDICompTest <- kruskal.test(CDIComp$Time ~ CDIComp$Method)

### Plot Code ###
# Figure 1 - 

# Figure 2 - 

# Figure 3 - 

# Figure 4 - 

# Figure 5 - Computational Runtime Densities

LVCompPoolDen <- density(LVComp[which(LVComp$Method=="Pool"),])



ICUcohort <- subset(cohort, ICU == 1)
NICUcohort <- subset(cohort, ICU == 0)
ICUden <- density(ICUcohort$Age)
NICUden <- density(NICUcohort$Age)
par(mar=c(5.1,5.1,4.1,2.1))
plot(ICUden, col="black", lwd = 3,xlab="Age (Years)",ylab = "Density", main="", cex.lab=1.5,axes=FALSE)
axis(2, cex.axis=1.3, at=c(0.005,0.015,0.025),lwd=1)
axis(1, cex.axis=1.3)
box()
lines(NICUden, col="grey75", lwd = 3)
legend("topright", c("ICU","Non-ICU"), lwd=3, col=c("black","grey75"),
       lty=c(1,1), pch=c(NA,NA), bty='n',inset=0.02, cex=1.3)

