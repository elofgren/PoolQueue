###################################
# C. difficile Transmission Model #
# Pool versus Queue steady states #
# No modeled interventions        #
###################################

# Module Imports
import pumphandle as ph
import os
import stochpy
import pylab as pl
import numpy as numpy

# Pull down most recent files from internet

CDIPoolDrop = ph.NetDrop('https://raw.github.com/elofgren/PML/PoolQueue-Models/cdiff_FT.psc','CDIpool.psc')
CDIQueueDrop = ph.NetDrop('https://raw.github.com/elofgren/PML/PoolQueue-Models/cdiff_FT_queue.psc','CDIqueue.psc')	

# General simulation parameters
start_time = 0.0
end_time = 8760
n_runs = 10
header = "Incident, Recur"

#########################
# Pool-based Entry/Exit #
#########################

CDIPool = stochpy.SSA()
CDIPool.Model(File='CDIpool.psc', dir=os.getcwd())
PoolOutcomes = numpy.zeros([n_runs,2])
PoolTrajectories = numpy.zeros([8760,n_runs])

def CDIPoolRun(model,iteration):
    model.Endtime(end_time)
    model.DoStochSim()
    outcomes = model.data_stochsim.getSpecies()
    Incident = outcomes[-1,9]
    Recur = outcomes[-1,13]
    PoolOutcomes[iteration,0] = Incident
    PoolOutcomes[iteration,1] = Recur

for i in range(0,n_runs):
    print "CDI Pool Iteration %i of %i" % (i+1,n_runs)
    CDIPoolRun(CDIPool,i)

print PoolOutcomes

print PoolTrajectories

    


