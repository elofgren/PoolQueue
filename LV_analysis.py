####################################
# Lotka-Volterra Competition Model #
# Pool versus Queue Migration      #
####################################

# Module Imports
import pumphandle as ph
import os
import stochpy
import pylab as pl
import numpy as numpy

# Pull down most recent files from internet
LVPoolDownload = ph.NetDrop('https://raw.github.com/elofgren/PML/master/Ecology/LVpred_secondary.psc','LVpool.psc')

LVQueueDownload = ph.NetDrop('https://raw.github.com/elofgren/PML/master/Ecology/LVpred_secondary_queue.psc','LVqueue.psc')	

# General simulation parameters
start_time = 0.0
end_time = 100
n_runs = 50

######################################
# Pool-based Birth/Death of Predator #
######################################

LVpool = stochpy.SSA()
LVpool.Model(File='LVpool.psc', dir = os.getcwd())
PoolPrey = numpy.empty([end_time,n_runs])
PoolPredator = numpy.empty([end_time,n_runs])
PoolTotal = numpy.empty([end_time,n_runs])

def LVPoolRun(model,iteration):
    model.Endtime(end_time)
    model.DoStochSim()
    model.GetRegularGrid(npoints=end_time*10)
    population = model.data_stochsim_grid.species
    for t in range(0,end_time):
        PoolPrey[t,iteration] = population[0][0][t]
        PoolPredator[t,iteration] = population[1][0][t]
        PoolTotal[t,iteration] = PoolPrey[t,iteration]+PoolPredator[t,iteration]

for i in range(0,n_runs):
	LVPoolRun(LVpool,i)
	print "LV Pool Iteration %i of %i" % (i+1,n_runs)

numpy.savetxt('PoolPrey.csv',PoolPrey,delimiter=',',header="Prey",comments='')
numpy.savetxt('PoolPredator.csv',PoolPredator,delimiter=',',header="Pred",comments='')
numpy.savetxt('PoolTotal.csv',PoolTotal,delimiter=',',header="TotalN",comments='')

print "LV Pool Model - Runs Complete"
    
#######################################
# Queue-based Birth/Death of Predator #
#######################################

LVqueue = stochpy.SSA()
LVqueue.Model(File='LVqueue.psc', dir = os.getcwd())
QueuePrey = numpy.empty([end_time,n_runs])
QueuePredator = numpy.empty([end_time,n_runs])
QueueTotal = numpy.empty([end_time,n_runs])

def LVQueueRun(model,iteration):
    model.Endtime(end_time)
    model.DoStochSim()
    model.GetRegularGrid(npoints=end_time*10)
    population = model.data_stochsim_grid.species
    for t in range(0,end_time):
        QueuePrey[t,iteration] = population[0][0][t]
        QueuePredator[t,iteration] = population[1][0][t]
        QueueTotal[t,iteration] = QueuePrey[t,iteration]+QueuePredator[t,iteration]

for i in range(0,n_runs):
	LVQueueRun(LVqueue,i)
	print "LV Queue Iteration %i of %i" % (i+1,n_runs)

numpy.savetxt('QueuePrey.csv',QueuePrey,delimiter=',',header="Prey",comments='')
numpy.savetxt('QueuePredator.csv',QueuePredator,delimiter=',',header="Predator",comments='')
numpy.savetxt('QueueTotal.csv',QueueTotal,delimiter=',',header="TotalN",comments='')

print "LV Queue Model - Runs Complete"
