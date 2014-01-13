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
LVPoolDownload = ph.NetDrop('https://raw.github.com/elofgren/PML/master/Ecology/LVcomp.psc',
'LVcomp_pool.psc')

LVQueueDownload = ph.NetDrop('https://raw.github.com/elofgren/PML/master/Ecology/LVcomp_queue.psc'
,'LVcomp_queue.psc')	

# General simulation parameters
start_time = 0.0
end_time = 100
n_runs = 50

########################
# Pool-based Migration #
########################

LVpool = stochpy.SSA()
LVpool.Model(File='LVcomp_pool.psc', dir = os.getcwd())
PoolInvader = numpy.empty([end_time,n_runs])
PoolNative = numpy.empty([end_time,n_runs])
PoolTotal = numpy.empty([end_time,n_runs])

def LVPoolRun(model,iteration):
    model.Endtime(end_time)
    model.DoStochSim()
    model.GetRegularGrid(npoints=end_time*10)
    population = model.data_stohsim_grid.species
    for t in range(0,end_time):
        PoolInvader[t,iteration] = population[0][0][t]
        PoolNative[t,iteration] = population[1][0][t]
        PoolTotal[t,iteration] = PoolInvader[t,iteration]+PoolNative[t,iteration]

for i in range(0,n_runs):
    print "LV Pool Iteration %i of %i" % (i+1,n_runs)

numpy.savetxt('PoolInvader.csv',PoolInvader,delimiter=',',header="Invader",comments='')
numpy.savetxt('PoolNative.csv',PoolNative,delimiter=',',header="Native",comments='')
numpy.savetxt('PoolTotal.csv',PoolTotal,delimiter=',',header="TotalN",comments='')

print "LV Pool Model - Runs Complete"
    
#########################
# Queue-based Migration #
#########################

LVqueue = stochpy.SSA()
LVqueue.Model(File='LVcomp_queue.psc', dir = os.getcwd())
QueueInvader = numpy.empty([end_time,n_runs])
QueueNative = numpy.empty([end_time,n_runs])
QueueTotal = numpy.empty([end_time,n_runs])

def LVQueueRun(model,iteration):
    model.Endtime(end_time)
    model.DoStochSim()
    model.GetRegularGrid(npoints=end_time*10)
    population = model.data_stohsim_grid.species
    for t in range(0,end_time):
        QueueInvader[t,iteration] = population[0][0][t]
        QueueNative[t,iteration] = population[1][0][t]
        QueueTotal[t,iteration] = QueueInvader[t,iteration]+QueueNative[t,iteration]

for i in range(0,n_runs):
    print "LV Queue Iteration %i of %i" % (i+1,n_runs)

numpy.savetxt('QueueInvader.csv',QueueInvader,delimiter=',',header="Invader",comments='')
numpy.savetxt('QueueNative.csv',QueueNative,delimiter=',',header="Native",comments='')
numpy.savetxt('QueueTotal.csv',QueueTotal,delimiter=',',header="TotalN",comments='')

print "LV Queue Model - Runs Complete"
