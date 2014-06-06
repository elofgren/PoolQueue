###################################################
# Dynamic Transmission Model of C. difficile      #
# Fecal Microbiota Transplant Based Interventions #
# Queue-based Steady State Population             #
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
	H*iota
	
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
	Up > Up
	theta_p*Up*nu_up

R12:
	Up > Ua
	theta_p*Up*nu_ua
	
R13:	
	Up > Cp
	theta_p*Up*nu_cp
R14:
	Up > Ca
	theta_p*Up*nu_ca

R15:
	Up > D
	theta_p*Up*nu_d	


# Reactions Involving Uncontaminated, High Risk Patients (Ua) #
R16:
	Ua > Ca
	rho_a*psi_a*Ua*(H/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))

R17:
	Ua > Ca
	mu_p*sigma_p*Ua*(Cp/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))

R18:
	Ua > Ca
	mu_a*sigma_a*Ua*(Ca/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))
	
R19:
	Ua > Ca
	mu_p*sigma_p*Ua*(Ct/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))

R20:
	Ua > Ua
	theta_a*Ua*nu_ua

R21:
	Ua > Up
	theta_a*Ua*nu_up

R22:
	Ua > Ca
	theta_a*Ua*nu_ca

R23:
	Ua > Cp
	theta_a*Ua*nu_cp

R24:
	Ua > D
	theta_a*Ua*nu_d	

R25:
	Ua > Ut + Treated
	chi*phi_u*Ua
	
# Reactions Involving Contaminated, Low Risk Patients (Cp) #
R26:
	Cp > Ca
	alpha*Cp

R27:
	Cp > D + Incident
	kappa*colonization*incubation*Cp
	
R28:
	Cp > Cp
	theta_p*Cp*nu_cp

R29:
	Cp > Ca
	theta_p*Cp*nu_ca

R30:
	Cp > Up
	theta_p*Cp*nu_up

R31:
	Cp > Ua
	theta_p*Cp*nu_ua

R32:	
	Cp > D
	theta_p*Cp*nu_d
	
# Reactions Involving Contaminated, High Risk Patients (Ca) #	
R33:
	Ca > D + Incident
	kappa*colonization*incubation*tau*Ca

R34:
	Ca > Ca
	theta_a*Ca*nu_ca

R35:
	Ca > Cp
	theta_a*Ca*nu_cp

R36:
	Ca > Ua
	theta_a*Ca*nu_ua

R37:
	Ca > Up
	theta_a*Ca*nu_up

R38:
	Ca > D
	theta_a*Ca*nu_d

R39:
	Ca > Ct + Treated
	chi*phi_c*Ca
	
# Reactions Involving Patients Under Treatment (Xt) *	
R40:
	Ut > Ua
	theta_p*Ut*nu_ua

R41:
	Ut > Up
	theta_p*Ut*nu_up

R42:
	Ut > Ca
	theta_p*Ut*nu_ca

R43:
	Ut > Cp
	theta_p*Ut*nu_cp

R44:	
	Ut > D
	theta_p*Ut*nu_d

R45:
	Ct > Ua
	theta_p*Ct*nu_ua	
	
R46:
	Ct > Up
	theta_p*Ct*nu_up	
	
R47:
	Ct > Ca
	theta_p*Ct*nu_ca	
	
R48:
	Ct > Cp
	theta_p*Ct*nu_cp	
	
R49:	
	Ct > D
	theta_p*Ct*nu_d		
	
R50:
	Ct > Ca
	alpha_t*Ct
	
R51:
	Ut > Ua
	alpha_t*Ut
	
R52:
	Ct > D + Incident
	kappa*colonization*incubation*Ct	

R53:
	Ut > Ct
	rho_a*psi_a*Ut*(H/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))

R54:
	Ut > Ct
	mu_p*sigma_p*Ut*(Cp/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))

R55:
	Ut > Ct
	mu_a*sigma_a*Ut*(Ca/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))
	
R56:
	Ut > Ct
	mu_p*sigma_p*Ut*(Ct/(Us + H + Cp + Ca + Up + Ua + Ct + Ca + D))
 
# Reactions Involving Active CDI Cases *
R57:
	D > Up
	gamma*(1-chi_postCDI)*D*(1-omega)*nu_up
	
R58: 
	D > Ua
	gamma*(1-chi_postCDI)*D*(1-omega)*nu_ua

R59: 
	D > Cp
	gamma*(1-chi_postCDI)*D*(1-omega)*nu_cp

R60: 
	D > Ca
	gamma*(1-chi_postCDI)*D*(1-omega)*nu_ca

R61: 
	D > D
	gamma*(1-chi_postCDI)*D*(1-omega)*nu_d

R62: 
	D > Up + Treated
	gamma*chi_postCDI*D*nu_up*eta*(1-omega)

R63: 
	D > Ua + Treated
	gamma*chi_postCDI*D*nu_ua*eta*(1-omega)

R64: 
	D > Cp + Treated
	gamma*chi_postCDI*D*nu_cp*eta*(1-omega)

R65: 
	D > Ca + Treated
	gamma*chi_postCDI*D*nu_ca*eta*(1-omega)

R66: 
	D > D + Treated
	gamma*chi_postCDI*D*nu_d*eta*(1-omega)

R67: 
	D > Up + Recur
	gamma*(1-chi_postCDI)*D*nu_up*omega

R68: 
	D > Ua + Recur
	gamma*(1-chi_postCDI)*D*nu_ua*omega

R69: 
	D > Cp + Recur
	gamma*(1-chi_postCDI)*D*nu_cp*omega

R70: 
	D > Ca + Recur
	gamma*(1-chi_postCDI)*D*nu_ca*omega

R71: 
	D > D + Recur
	gamma*(1-chi_postCDI)*D*nu_d*omega

R72: 
	D > Up + Recur + Treated
	D*gamma*chi_postCDI*(1-eta)*omega*nu_up

R73: 
	D > Ua + Recur + Treated
	D*gamma*chi_postCDI*(1-eta)*omega*nu_ua

R74: 
	D > Cp + Recur + Treated
	D*gamma*chi_postCDI*(1-eta)*omega*nu_cp

R75: 
	D > Ca + Recur + Treated
	D*gamma*chi_postCDI*(1-eta)*omega*nu_ca

R76: 
	D > D + Recur + Treated
	D*gamma*chi_postCDI*(1-eta)*omega*nu_d

R77: 
	D > Up + Death
	zeta*D*nu_up

R78: 
	D > Ua + Death
	zeta*D*nu_ua

R79: 
	D > Cp + Death
	zeta*D*nu_cp

R80: 
	D > Ca + Death
	zeta*D*nu_ca

R81: 
	D > D + Death
	zeta*D*nu_d

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
Recur = 0
Incident = 0
Treated = 0
Death = 0

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
