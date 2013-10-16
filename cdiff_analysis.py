###################################
# C. difficile Transmission Model #
# Pool versus Queue steady states #
# No modeled interventions        #
###################################

# Module Imports
import pumphandle as ph
import stochpy
import pylab as pl
import numpy as numpy


# Pull down most recent files from internet

CDIPoolDrop = ph.NetDrop('https://raw.github.com/elofgren/PML/master/LV.psc','CDIpool.psc')
CDIQueueDrop = ph.NetDrop('https://raw.github.com/elofgren/PML/master/SIR_BirthDeath.psc','CDIqueue.psc')	

# General simulations parameters
start_time = 0.0
end_time = 8760
n_runs = 50
header = "Incident, Recur, Level"





