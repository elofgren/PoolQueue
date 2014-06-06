####################################
# Lotka-Volterra Competition Model #
# Pool versus Queue Migration      #
####################################

# Module Imports
import os
import stochpy
import pylab as pl
import numpy as numpy

workingdir = os.getcwd()

# General simulation parameters
start_time = 0.0
end_time = 100
n_runs = 2500

######################################
# Pool-based Birth/Death of Predator #
######################################

LVpool = stochpy.SSA()
LVpool.Model(File='LVpool.psc', dir = workingdir)
PoolPrey = numpy.empty([end_time,n_runs])
PoolPredator = numpy.empty([end_time,n_runs])
PoolTotal = numpy.empty([end_time,n_runs])
PoolExtinction = numpy.empty([n_runs,3])
PoolMedian = numpy.empty([n_runs,3])
PoolMean = numpy.empty([n_runs,3])

def LVPoolRun(model,iteration):
    model.Endtime(end_time)
    model.DoStochSim()
    model.GetRegularGrid(npoints=end_time*10)
    population = model.data_stochsim_grid.species
    for t in range(0,end_time):
        PoolPrey[t,iteration] = population[0][0][t]
        PoolPredator[t,iteration] = population[1][0][t]
        PoolTotal[t,iteration] = PoolPrey[t,iteration]+PoolPredator[t,iteration]
    if PoolPrey[-1,iteration] == 0:
    	PoolExtinction[iteration,0] = 1
    else:
    	PoolExtinction[iteration,0] = 0
    if PoolPredator[-1,iteration] == 0:
    	PoolExtinction[iteration,1] = 1
    else:
    	PoolExtinction[iteration,1] = 0
    if PoolTotal[-1,iteration] == 0:
    	PoolExtinction[iteration,2] = 1
    else:
    	PoolExtinction[iteration,2] = 0
    PoolMedian[iteration,0] = numpy.median(PoolPrey[:,iteration])
    PoolMedian[iteration,1] = numpy.median(PoolPredator[:,iteration])
    PoolMedian[iteration,2] = numpy.median(PoolTotal[:,iteration])
    PoolMean[iteration,0] = numpy.mean(PoolPrey[:,iteration])
    PoolMean[iteration,1] = numpy.mean(PoolPredator[:,iteration])
    PoolMean[iteration,2] = numpy.mean(PoolTotal[:,iteration])
    

for i in range(0,n_runs):
	LVPoolRun(LVpool,i)
	print "LV Pool Iteration %i of %i" % (i+1,n_runs)

numpy.savetxt('PoolPrey.csv',PoolPrey,delimiter=',',header="",comments='')
numpy.savetxt('PoolPredator.csv',PoolPredator,delimiter=',',header="",comments='')
numpy.savetxt('PoolTotal.csv',PoolTotal,delimiter=',',header="",comments='')
numpy.savetxt('LVpoolExtinction.csv',PoolExtinction,delimiter=',',header="Prey,Predator,N",comments='')
numpy.savetxt('LVpoolMedian.csv',PoolMedian,delimiter=',', header="Prey,Predator,N",comments='')
numpy.savetxt('LVpoolMean.csv',PoolMean,delimiter=',',header="Prey,Predator,N",comments='')

print "LV Pool Model - Runs Complete"
    
#######################################
# Queue-based Birth/Death of Predator #
#######################################

LVqueue = stochpy.SSA()
LVqueue.Model(File='LVqueue.psc', dir = workingdir)
QueuePrey = numpy.empty([end_time,n_runs])
QueuePredator = numpy.empty([end_time,n_runs])
QueueTotal = numpy.empty([end_time,n_runs])
QueueExtinction = numpy.empty([n_runs,3])
QueueMedian = numpy.empty([n_runs,3])
QueueMean = numpy.empty([n_runs,3])


def LVQueueRun(model,iteration):
    model.Endtime(end_time)
    model.DoStochSim()
    model.GetRegularGrid(npoints=end_time*10)
    population = model.data_stochsim_grid.species
    for t in range(0,end_time):
        QueuePrey[t,iteration] = population[0][0][t]
        QueuePredator[t,iteration] = population[1][0][t]
        QueueTotal[t,iteration] = QueuePrey[t,iteration]+QueuePredator[t,iteration]
	if QueuePrey[-1,iteration] == 0:
		QueueExtinction[iteration,0] = 1
	else:
		QueueExtinction[iteration,0] = 0
	if QueuePredator[-1,iteration] == 0:
		QueueExtinction[iteration,1] = 1
	else:
		QueueExtinction[iteration,1] = 0
	if QueueTotal[-1,iteration] == 0:
		QueueExtinction[iteration,2] = 1
	else:
		QueueExtinction[iteration,2] = 0
	QueueMedian[iteration,0] = numpy.median(QueuePrey[:,iteration])
    QueueMedian[iteration,1] = numpy.median(QueuePredator[:,iteration])
    QueueMedian[iteration,2] = numpy.median(QueueTotal[:,iteration])
    QueueMean[iteration,0] = numpy.mean(QueuePrey[:,iteration])
    QueueMean[iteration,1] = numpy.mean(QueuePredator[:,iteration])
    QueueMean[iteration,2] = numpy.mean(QueueTotal[:,iteration])

for i in range(0,n_runs):
	LVQueueRun(LVqueue,i)
	print "LV Queue Iteration %i of %i" % (i+1,n_runs)

numpy.savetxt('QueuePrey.csv',QueuePrey,delimiter=',',header="Prey",comments='')
numpy.savetxt('QueuePredator.csv',QueuePredator,delimiter=',',header="Predator",comments='')
numpy.savetxt('QueueTotal.csv',QueueTotal,delimiter=',',header="TotalN",comments='')
numpy.savetxt('LVqueueExtinction.csv',QueueExtinction,delimiter=',',header="Prey,Predator,N",comments='')
numpy.savetxt('LVqueueMedian.csv',QueueMedian,delimiter=',', header="Prey,Predator,N",comments='')
numpy.savetxt('LVqueueMean.csv',QueueMean,delimiter=',',header="Prey,Predator,N",comments='')

print "LV Queue Model - Runs Complete"

#######################
# Deterministic Model #
#######################

import pysces
detLV = pysces.model('LVpool.psc', dir=workingdir)
detLV.doSim(end=end_time,points=end_time*10)
detLVTS = detLV.data_sim.getSpecies()
detLVHead = "Time," + ','.join(detLV.species)
os.chdir(workingdir)
numpy.savetxt('LVDeterministic.csv',detLVTS,delimiter=',',header=detLVHead,comments='')
