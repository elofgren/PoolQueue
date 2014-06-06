###################################################
# Dynamic Transmission Model of C. difficile      #
# Fecal Microbiota Transplant Based Interventions #
# Author: Eric Lofgren (Eric.Lofgren@gmail.com)   #
###################################################

# Descriptive Information for PML File
Modelname: FecalTransplant
Description: PML Implementation of C. difficile transmission model with FMT intervention

# Set model to run with numbers of individuals
Species_In_Conc: False
Output_In_Conc: False

### Model Reactions ###

# Reactions Governing Movement of Healthcare Workers #
R1:
	H > Us
	iota*H
	
R2:
	Us > H
	rho_p*sigma_p*Cp*(Us/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))

R3:
	Us > H
	rho_d*sigma_d*D*(Us/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))

R4:
	Us > H
	rho_a*sigma_a*Ca*(Us/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))

R5:
	Us > H
	rho_p*sigma_p*Ct*(Us/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))

# Reactions Involving Uncontaminated, Low Risk Patients (Up) #
R6:
	Up > Ua
	alpha*Up

R7:
	Up > Cp
	rho_p*psi_p*Up*(H/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))
	
R8: 
	Up > Cp
	mu_p*sigma_p*Up*(Cp/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))

R9: 
	Up > Cp
	mu_a*sigma_a*Up*(Ca/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))
	
R10:
	Up > Cp
	mu_p*sigma_p*Up*(Ct/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))

R11: 
	Up > $pool
	theta_p*Up	

R12: 
	$pool > Up
	nu_up*(theta_p*(Up+Cp+Ut+Ct)+theta_a*(Ua+Ca)+zeta*D+gamma*D)

# Reactions Involving Uncontaminated, High Risk Patients (Ua) #
R13:
	Ua > Ca
	rho_a*psi_a*Ua*(H/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))

R14:
	Ua > Ca
	mu_p*sigma_p*Ua*(Cp/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))

R15:
	Ua > Ca
	mu_a*sigma_a*Ua*(Ca/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))
	
R16:
	Ua > Ca
	mu_p*sigma_p*Ua*(Ct/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))

R17:
	Ua > $pool
	theta_a*Ua

R18:
	$pool > Ua
	nu_ua*(theta_p*(Up+Cp+Ut+Ct)+theta_a*(Ua+Ca)+zeta*D+gamma*D)

R19:
	Ua > Ut + Treated
	chi*phi_u*Ua
	
# Reactions Involving Contaminated, Low Risk Patients (Cp) #
R20:
	Cp > Ca
	alpha*Cp

R21:
	Cp > D + Incident
	kappa*colonization*incubation*Cp

R22:
	Cp > $pool
	theta_p*Cp

R23:
	$pool > Cp
	nu_cp*(theta_p*(Up+Cp+Ut+Ct)+theta_a*(Ua+Ca)+zeta*D+gamma*D)
	
# Reactions Involving Contaminated, High Risk Patients (Ca) #	
R24:
	Ca > D + Incident
	kappa*colonization*incubation*tau*Ca

R25:
	Ca > $pool
	theta_a*Ca

R26:
	$pool > Ca
	nu_ca*(theta_p*(Up+Cp+Ut+Ct)+theta_a*(Ua+Ca)+zeta*D+gamma*D)
	
R27:
	Ca > Ct + Treated
	chi*phi_c*Ca
	
# Reactions Involving Patients Under Treatment (Xt) *	
R28:
	Ut > $pool
	theta_p*Ut

R29:
	Ct > $pool
	theta_p*Ct	
	
R30:
	Ct > Ca
	alpha_t*Ct
	
R31:
	Ut > Ua
	alpha_t*Ut
	
R32:
	Ct > D + Incident
	kappa*colonization*incubation*Ct	

R33:
	Ut > Ct
	rho_a*psi_a*Ut*(H/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))

R34:
	Ut > Ct
	mu_p*sigma_p*Ut*(Cp/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))

R35:
	Ut > Ct
	mu_a*sigma_a*Ut*(Ca/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))
	
R36:
	Ut > Ct
	mu_p*sigma_p*Ut*(Ct/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))
	
# Reactions Involving Active CDI Cases #
R37:
	D > FT + Treated
	gamma*chi_postCDI*D

R38:
	D > NFT
	gamma*(1-chi_postCDI)*D
	
R39:
	D > $pool
	zeta*D
	
R40:
	$pool > D
	nu_d*(theta_p*(Up+Cp+Ut+Ct)+theta_a*(Ua+Ca)+zeta*D+gamma*D)
	
# Reactions Involving the Fate of Discharged Patients #
R41:
	FT > $pool
	eta*(1-omega)*FT

R42:
	FT > Recur
	(1-eta)*omega*FT

R43:
	NFT > $pool
	(1-omega)*NFT

R44:
	NFT > Recur
	omega*NFT

### Parameter Values ###
## Time Values are in HOURS ##
# Compartments #
Us = 4
H = 1
Up = 3
Cp = 3
Ua = 3
Ca = 3
Ut = 0
Ct = 0
D = 0
FT = 0
NFT = 0
Recur = 0
Incident = 0
Treated = 0

# Contact Rates and Contamination Probabilities
rho_p = 4.244 # direct care tasks per patient per hour
rho_d = 4.244
rho_a = 4.244
sigma_p = 0.35
sigma_d = 0.50
sigma_a = 0.35
psi_p = 0.90 
psi_a = 0.90

# High-risk treatment rates
# Currently disabled
# Risk determined at admission
alpha = 0

# Patient to Patient transmission rates
# Currently disabled
mu_p = 0
mu_a = 0

# Exit (death/discharge) rates
theta_p = 0.01255717
theta_a = 0.003470383
zeta = 0.0006252176
gamma = 0.001880387

# Admission Proportions
# 77.65% are high risk
# Cx  =0.02, Ux = 0.936
nu_cp = 0.00447
nu_ca = 0.01553
nu_up = 0.209196
nu_ua = 0.726804
nu_d = 0.044

# Disease Natural History Parameters
incubation = 0.01389
kappa = 0.0002077
colonization = 1.00 # Colonization/disease are a single process
tau = 3.37 # RR for high-risk patients

# Handwashing Rate
iota = 9.365 #10.187 direct care tasks per hour with 94% compliance and 97.8% efficacy

# Fecal Transplant Intervention Parameters
eta = 0.938
omega = 0.30
chi = 0
chi_postCDI = 0
phi_c = 0
phi_u = 0 
alpha_t = 0
