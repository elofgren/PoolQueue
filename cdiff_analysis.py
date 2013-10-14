###################################
# C. difficile Transmission Model #
# Pool versus Queue steady states #
# No modeled interventions        #
###################################

# Module Imports
import os
import stochpy
import pylab as pl
import numpy as numpy
import requests

# Pull down most recent files from internet

def NetDrop(url,filename):
	pmlfile = requests.get(url, verify=False)
	pmlout = os.path.join(os.getcwd(),filename)
	f = open(pmlout,'w')
	f.write(pmlfile.content)
	f.close()
	return()

CDIPoolDrop = NetDrop(URLHERE,'CDIpool.psc')
CDIQueueDrop = NetDrop(URLHERE,'CDIqueue.psc')	

# General simulations parameters
start_time = 0.0
end_time = 8760
n_runs = 50
header = "Incident, Recur, Level"



