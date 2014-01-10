###################################
# Lotka-Volterra Predation Model  #
# Pool versus Queue Predation     #
###################################

# Module Imports
import pumphandle as ph
import os
import stochpy
import pylab as pl
import numpy as numpy

# Pull down most recent files from internet
LVPoolDrop = ph.NetDrop('https://raw.github.com/elofgren/PML/master/Ecology/logisticLV.psc',
'LVpool.psc')

LVQueueDrop = ph.NetDrop('https://raw.github.com/elofgren/PML/master/Ecology/logisticLV_queue.psc'
,'LVqueue.psc')	

# General simulation parameters
start_time = 0.0
end_time = 100
n_runs = 5000

#########################
# Pool-based Entry/Exit #
#########################

LVPool = stochpy.SSA()
LVPool.Model(File='LVpool.psc', dir=os.getcwd())
PoolRabbits = numpy.empty([end_time,n_runs])
PoolFoxes = numpy.empty([end_time,n_runs])
PoolTotal = numpy.empty([end_time,n_runs])

# Note - specific model outcome array references will change for each model file
def LVPoolRun(model,iteration):
    model.Endtime(end_time)
    #model.Method('Direct')
    model.DoStochSim()
    model.GetRegularGrid(npoints=end_time*10)
    population = model.data_stochsim_grid.species
    for t in range(0,end_time):
    	PoolRabbits[t,iteration] = population[0][0][t]
    	PoolFoxes[t,iteration] = population[1][0][t]
    	PoolTotal[t,iteration] = PoolRabbits[t,iteration] + PoolFoxes[t,iteration]

for i in range(0,n_runs):
    print "LV Pool Iteration %i of %i" % (i+1,n_runs)
    LVPoolRun(LVPool,i)
    
numpy.savetxt('PoolRabbits.csv',PoolRabbits,delimiter=',',header="Rabbits",comments='')
numpy.savetxt('PoolFoxes.csv',PoolFoxes,delimiter=',',header="Foxes",comments='')
numpy.savetxt('PoolWholeLV.csv',PoolTotal,delimiter=',',header="N",comments='')

print "LV Pool Model - Runs Complete"

##########################
# Queue-based Entry/Exit #
##########################

LVQueue = stochpy.SSA()
LVQueue.Model(File='LVqueue.psc', dir=os.getcwd())
QueueRabbits = numpy.empty([end_time,n_runs])
QueueFoxes = numpy.empty([end_time,n_runs])
QueueTotal = numpy.empty([end_time,n_runs])

# Note - specific model outcome array references will change for each model file
def LVQueueRun(model,iteration):
    model.Endtime(end_time)
    #model.Method('Direct')
    model.DoStochSim()
    model.GetRegularGrid(npoints=end_time*10)
    population = model.data_stochsim_grid.species
    for t in range(0,end_time):
    	QueueRabbits[t,iteration] = population[0][0][t]
    	QueueFoxes[t,iteration] = population[1][0][t]
    	QueueTotal[t,iteration] = PoolRabbits[t,iteration] + PoolFoxes[t,iteration]

for i in range(0,n_runs):
    print "LV Queue Iteration %i of %i" % (i+1,n_runs)
    LVQueueRun(LVQueue,i)
    
numpy.savetxt('QueueRabbits.csv',QueueRabbits,delimiter=',',header="Rabbits",comments='')
numpy.savetxt('QueueFoxes.csv',QueueFoxes,delimiter=',',header="Foxes",comments='')
numpy.savetxt('QueueWholeLV.csv',QueueTotal,delimiter=',',header="N",comments='')

print "LV Queue Model - Runs Complete"

