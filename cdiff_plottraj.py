###################################
# C. difficile Transmission Model #
# Pool versus Queue steady states #
# No modeled interventions        #
###################################

# Module Imports
import os
import stochpy
import pylab as plt
import numpy as numpy

workingdir = os.getcwd()

# General simulation parameters
start_time = 0.0
end_time = 8760
n_runs = 10000

#########################
# Pool-based Entry/Exit #
#########################

CDIPool = stochpy.SSA()
CDIPool.Model(File='CDIpool.psc', dir=workingdir)
PoolOutcomes = numpy.empty([n_runs,3])
PoolDTrajectories = numpy.empty([end_time,n_runs])
PoolNTrajectories = numpy.empty([end_time,n_runs])
PoolExtinction = numpy.empty([n_runs,1])

##########################
# Queue-based Entry/Exit #
##########################

CDIQueue = stochpy.SSA()
CDIQueue.Model(File='CDIqueue.psc', dir=workingdir)
QueueOutcomes = numpy.empty([n_runs,3])
QueueDTrajectories = numpy.empty([end_time,n_runs])
QueueNTrajectories = numpy.empty([end_time,n_runs])
QueueExtinction = numpy.empty([n_runs,1])

# Note - specific model outcome array references will change for each model file
def CDIQueueRun(model,iteration):
    model.Endtime(end_time)
    model.DoStochSim()
    model.GetRegularGrid(n_samples=end_time)
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
    if QueueNTrajectories[-1,iteration] == 0:
    	QueueExtinction[iteration,0] = 1
    else:
    	QueueExtinction[iteration,0] = 0

for i in range(0,n_runs):
    print "CDI Queue Iteration %i of %i" % (i+1,n_runs)
    CDIQueueRun(CDIQueue,i)

print "C. difficile Queue Model - Runs Complete"

predictaxis = numpy.arange(start=0,stop=8760,step=1)
plt.figure(figsize=(10,6))
plt.xlim(xmax=(8760+5))
plt.ylim(ymax=14)
for k in range(n_runs):
	plt.plot(predictaxis,QueueDTrajectories[:,k],color='red',alpha=0.10)
a = plt.Rectangle((0, 0), 1, 1, fc="red", alpha=1.00)
plt.legend([a], ["Active C. difficile Cases"],loc=2,fontsize='medium')
plt.xlabel("Time (Hours)",fontsize=16)
plt.ylabel("Prevalent Infections",fontsize=16)
plt.savefig('/Users/elofgren/Desktop/UNCEpiTraj.pdf')
	