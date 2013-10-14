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

test = NetDrop('https://raw.github.com/elofgren/PML/master/SIR.psc','test.psc')
