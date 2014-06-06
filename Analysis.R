################################################################
# Statistical Analysis and Graphic Code for Pool-Queue Project #
################################################################

# Import Packages
library(vioplot)

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

## Figures 2 & 3 - Trajectories for predators and prey
PoolPreyTrajectory <- read.csv(("PoolPrey.csv"),header=F)
PPreyT <- as.matrix(PoolPreyTrajectory)
PoolPredTrajectory <- read.csv(("PoolPredator.csv"),header=F)
PPredT <- as.matrix(PoolPredTrajectory)
QueuePreyTrajectory <- read.csv(("QueuePrey.csv"),header=F)
QPreyT <- as.matrix(QueuePreyTrajectory)
QueuePredTrajectory <- read.csv(("QueuePredator.csv"),header=F)
QPredT <- as.matrix(QueuePredTrajectory)
Deterministic <- read.csv(("LVDeterministic.csv"),header=T)

sim_length <- 99 # Number of observations in timeseries - 1
realizations <- 250 # How many realizations of the model were run

par(mfrow=c(1,1))
# Plot Trajectories for Prey
plot(0:sim_length, rep(NA,sim_length+1),main="",xlab="Time", ylab="Prey", ylim=c(0,11.5))
for (i in 1:realizations) {
  lines(0:sim_length, PPreyT [ ,i],lwd=2,col=rgb(0,100,0,20,maxColorValue=255))
}
for (k in 1:realizations) {
  lines(0:sim_length, QPreyT [ ,k],lwd=2,col=rgb(0,0,255,20,maxColorValue=255))
}
lines(Deterministic$Time,Deterministic$prey,lwd=4,col="Black",lty=2)
legend("top",c("Pool","Queue","Deterministic"),lwd=c(2,2,3),col=c("Dark Green","Blue","Black"),lty=c(1,1,2),bty='n', horiz=T)

# Plot Trajectories for Predators
plot(0:sim_length, rep(NA,sim_length+1),main="",xlab="Time", ylab="Predators", ylim=c(0,17))
for (i in 1:realizations) {
  lines(0:sim_length, PPredT [ ,i],lwd=2,col=rgb(0,100,0,20,maxColorValue=255))
}
for (k in 1:realizations) {
  lines(0:sim_length, QPredT [ ,k],lwd=2,col=rgb(0,0,255,20,maxColorValue=255))
}
lines(Deterministic$Time,Deterministic$predator,lwd=4,col="Black",lty=2)
legend("top",c("Pool","Queue","Deterministic"),lwd=c(2,2,3),col=c("Dark Green","Blue","Black"),lty=c(1,1,2),bty='n', horiz=T)

## Figure 4 - Cumultive incident and recurrent cases
par(mfrow=c(1,2))
vioplot(HAIPoolOutcomes$Recur,HAIQueueOutcomes$Recur,names=c("Pool","Queue"),col="Grey",drawRect=FALSE)
title("Recurrent C. difficile", ylab="Cases")
vioplot(HAIPoolOutcomes$Incident,HAIQueueOutcomes$Incident,names=c("Pool","Queue"), col="Grey",drawRect=FALSE)
title("Incident C. difficile", ylab="Cases")

## Figure 5 - Computational runtimes
LVCompP <- subset(LVComp, Method=="Pool")$Time
LVCompQ <- subset(LVComp, Method=="Queue")$Time
CDICompP <- subset(CDIComp, Method=="Pool")$Time
CDICompQ <- subset(CDIComp, Method=="Queue")$Time

par(mfrow=c(1,2))
vioplot(LVCompP,LVCompQ,names=c("Pool","Queue"),col="Grey",drawRect=FALSE)
title("Predator-Prey Model",ylab="Runtime (Seconds)")
vioplot(CDICompP,CDICompQ, names=c("Pool","Queue"),col="Grey",drawRect=FALSE,ylim=c(0,8))
title("Hospital Infection Model",ylab="Runtime (Seconds)")
