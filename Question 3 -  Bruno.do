/* Question 3 */

*Importing the data set

clear
clear mata

use "C:\Users\bromo\OneDrive\Área de Trabalho\FGV - Mestrado\Optativas\Labor\data_PS1.dta"

drop if hhincome <0
drop if inctot <0
drop if age<25 | age > 55
drop if marst >= 3

/* Question 2- A*/
g employed = 0
replace employed = 1 if empstat == 1

*Real Non Labor income
g NLIncome = hhincome - incwage
replace NLIncome = NLIncome/Price_Index * 100
drop if NLIncome <0

replace incwage = incwage/Price_Index *100

mata
/* Let's define the Log likelihood function*/

void Log_Likelihood(todo, beta, val, g, H){
Y = st_data(1::5000, "employed")
NL = st_data(1::5000, "NLIncome")
Cons = J(5000, 1, 1)
A = st_data(1::5000, "age")
NC = st_data(1::5000, "nchild")
E = st_data(1::5000, "educ")
W = st_data(1::5000, "incwage")

Alpha = beta[2],beta[3],beta[4]
Gamma = beta[5], beta[6]
sigma_eps = beta[7]
sigma_csi = beta[8]
rho = beta[9]
sigma_v = sigma_eps^2+sigma_csi^2-2*rho*sigma_eps*sigma_csi

Pr0 = (beta[1]:*NL:+Alpha[1]:*Cons:+Alpha[2]:*A:+Alpha[3]:*NC:-Gamma[1]:*E:-Gamma[2]:*A):/sigma_v
Pr0 = normal(Pr0)

Pr1_1 = (W:-Gamma[1]:*E:-Gamma[2]:*A):/sigma_v

Pr1_2 = W:-Alpha[1]:*Cons:-Alpha[2]:*A:-Alpha[3]:*NC:-beta[1]:*NL
Pr1_2 = Pr1_2 :-(rho*sigma_eps/sigma_csi):*(W:-Gamma[1]:*E:-Gamma[2]:*A)
Pr1_2 = Pr1_2:/(sigma_eps*sqrt(1-rho^2))

Pr1 = (1/sigma_csi):*normalden(Pr1_1):*normal(Pr1_2)

val = sum(Y:*ln(Pr1):+(1:-Y):*ln(Pr0))
}

S =optimize_init()
optimize_init_which(S, "min")
optimize_init_evaluator(S, &Log_Likelihood())
optimize_init_technique(S, "nm")
optimize_init_nmsimplexdeltas(S, J(1, 3, 20))
optimize_init_params(S, (10.88, -0.46, 0.2265, 0.695, 1818, 117.9,100, 100, 0))
p = optimize(S)
p
optimize_result_value(S)

/**/
/*
function Log_Likelihood(beta){
Y = st_data(1::5000, "employed")
NL = st_data(1::5000, "NLIncome")
Cons = J(5000, 1, 1)
A = st_data(1::5000, "age")
NC = st_data(1::5000, "nchild")
E = st_data(1::5000, "educ")
W = st_data(1::5000, "incwage")

Alpha = beta[2],beta[3],beta[4]
Gamma = beta[5], beta[6]
sigma_eps = beta[7]
sigma_csi = beta[8]
rho = beta[9]
sigma_v = sigma_eps^2+sigma_csi^2-2*rho*sigma_eps*sigma_csi

Pr0 = (beta[1]:*NL:+Alpha[1]:*Cons:+Alpha[2]:*A:+Alpha[3]:*NC:-Gamma[1]:*E:-Gamma[2]:*A):/sigma_v
Pr0 = normal(Pr0)

Pr1_1 = (W:-Gamma[1]:*E:-Gamma[2]:*A):/sigma_v

Pr1_2 = W:-Alpha[1]:*Cons:-Alpha[2]:*A:-Alpha[3]:*NC:-beta[1]:*NL
Pr1_2 = Pr1_2 :-(rho*sigma_eps/sigma_csi):*(W:-Gamma[1]:*E:-Gamma[2]:*A)
Pr1_2 = Pr1_2:/(sigma_eps*sqrt(1-rho^2))

Pr1 = (1/sigma_csi):*normalden(Pr1_1):*normal(Pr1_2)

val = sum(Y:*ln(Pr1):+(1:-Y):*ln(Pr0))
return(val)
}
*/
end

