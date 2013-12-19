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

CDIPoolDrop = ph.NetDrop('https://raw.github.com/elofgren/PML/master/Epidemiology/cdiff_FT.psc','CDIpool.psc')

CDIQueueDrop = ph.NetDrop('https://raw.github.com/elofgren/PML/master/Epidemiology/cdiff_FT_queue.psc','CDIqueue.psc')	


# General simulation parameters
start_time = 0.0
end_time = 8760
n_runs = 5000

#########################
# Pool-based Entry/Exit #
#########################

CDIPool = stochpy.SSA()
CDIPool.Model(File='CDIpool.psc', dir=os.getcwd())
PoolOutcomes = numpy.empty([n_runs,3])
PoolDTrajectories = numpy.empty([end_time,n_runs])
PoolNTrajectories = numpy.empty([end_time,n_runs])

# Note - specific model outcome array references will change for each model file
def CDIPoolRun(model,iteration):
    model.Endtime(end_time)
    model.DoStochSim()
    model.GetRegularGrid(npoints=end_time)
    outcomes = model.data_stochsim_grid.species
    Incident = outcomes[9][0][-1]
    Recur = outcomes[13][0][-1]
    # N = sum(Up,Ua,Ut,Cp,Ca,Ct,D)
    N = (outcomes[2][0][-1] + outcomes[3][0][-1] +
        outcomes[4][0][-1] + outcomes[5][0][-1] + outcomes[6][0][-1] + 
        outcomes[8][0][-1] + outcomes[10][0][-1])
    PoolOutcomes[iteration,0] = Incident
    PoolOutcomes[iteration,1] = Recur
    PoolOutcomes[iteration,2] = N
    for t in range(0,end_time):
        PoolDTrajectories[t,iteration] = outcomes[8][0][t]
        PoolNTrajectories[t,iteration] = (outcomes[2][0][t] + outcomes[3][0][t] +
        outcomes[4][0][t] + outcomes[5][0][t] + outcomes[6][0][t] + outcomes[8][0][t] +
        outcomes[10][0][t])

for i in range(0,n_runs):
    print "CDI Pool Iteration %i of %i" % (i+1,n_runs)
    CDIPoolRun(CDIPool,i)

numpy.savetxt('CDIPoolOutcomes.csv',PoolOutcomes,delimiter=','
,header="Incident,Recur,N",comments='')
numpy.savetxt('CDIPoolDTrajectories.csv',PoolDTrajectories,delimiter=','
,header="D",comments='')
numpy.savetxt('CDIPoolNTrajectories.csv',PoolNTrajectories,delimiter=','
,header="N",comments='')

print "C. difficile Pool Model - Runs Complete"

##########################
# Queue-based Entry/Exit #
##########################

CDIQueue = stochpy.SSA()
CDIQueue.Model(File='CDIqueue.psc', dir=os.getcwd())
QueueOutcomes = numpy.empty([n_runs,3])
QueueDTrajectories = numpy.empty([end_time,n_runs])
QueueNTrajectories = numpy.empty([end_time,n_runs])

# Note - specific model outcome array references will change for each model file
def CDIQueueRun(model,iteration):
    model.Endtime(end_time)
    model.DoStochSim()
    model.GetRegularGrid(npoints=end_time)
    outcomes = model.data_stochsim_grid.species
    Incident = outcomes[9][0][-1]
    Recur = outcomes[11][0][-1]
    # N = sum(Up,Ua,Ut,Cp,Ca,Ct,D)
    N = (outcomes[2][0][-1] + outcomes[3][0][-1] +
        outcomes[4][0][-1] + outcomes[5][0][-1] + outcomes[6][0][-1] + 
        outcomes[7][0][-1] + outcomes[10][0][-1])
    QueueOutcomes[iteration,0] = Incident
    QueueOutcomes[iteration,1] = Recur
    QueueOutcomes[iteration,2] = N
    for t in range(0,end_time):
        QueueDTrajectories[t,iteration] = outcomes[6][0][t]
        QueueNTrajectories[t,iteration] = (outcomes[2][0][t] + outcomes[3][0][t] +
        outcomes[4][0][t] + outcomes[5][0][t] + outcomes[6][0][t] + outcomes[7][0][t] +
        outcomes[10][0][t])

for i in range(0,n_runs):
    print "CDI Queue Iteration %i of %i" % (i+1,n_runs)
    CDIQueueRun(CDIQueue,i)

numpy.savetxt('CDIQueueOutcomes.csv',QueueOutcomes,delimiter=','
,header="Incident,Recur,N",comments='')
numpy.savetxt('CDIQueueDTrajectories.csv',QueueDTrajectories,delimiter=','
,header="D",comments='')
numpy.savetxt('CDIQueueNTrajectories.csv',QueueNTrajectories,delimiter=','
,header="N",comments='')

print "C. difficile Queue Model - Runs Complete"

    


