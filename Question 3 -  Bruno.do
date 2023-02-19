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

drop if educd <=1
drop if educd == 999
replace educ = -1
replace educ = 0 if educd == 2
replace educ = 1 if educd == 14
replace educ = 2 if educd == 15
replace educ = 2.5 if educd == 13
replace educ = 3 if educd == 16
replace educ = 4 if educd == 17
replace educ = 5 if educd == 22
replace educ = 5.5 if educd == 21
replace educ = 6 if educd == 23
replace educ = 6.5 if educd == 20
replace educ = 7 if educd == 25
replace educ = 7.5 if educd == 24
replace educ = 8 if educd == 26
replace educ = 9 if educd == 30
replace educ = 10 if educd == 40
replace educ = 11 if educd == 50
replace educ = 12 if educd == 60
replace educ = 12 if educd == 61
replace educ = 12 if educd == 62
replace educ = 12 if educd == 63
replace educ = 12 if educd == 64
replace educ = 12 if educd == 65
replace educ = 13 if educd == 70
replace educ = 13 if educd == 71
replace educ = 14 if educd == 80
replace educ = 15 if educd == 90
replace educ = 16 if educd == 100
replace educ = 16 if educd == 101
replace educ = 17 if educd == 110
replace educ = 18 if educd == 111
replace educ = 19 if educd == 112
replace educ = 20 if educd == 113
replace educ = 20 if educd == 114
replace educ = 20 if educd == 116
drop if educ == -1

mata
/* Let's define the Log likelihood function*/

void Log_Likelihood(todo, beta, val, g, H){
Y = st_data(1::50000, "employed")
NL = st_data(1::50000, "NLIncome")
Cons = J(50000, 1, 1)
A = st_data(1::50000, "age")
NC = st_data(1::50000, "nchild")
E = st_data(1::50000, "educ")
W = st_data(1::50000, "incwage")

Alpha = beta[2],beta[3],beta[4]
Gamma = beta[5], beta[6]
sigma_eps = beta[7]
sigma_csi = beta[8]
rho = beta[9]
sigma_v = sigma_eps^2+sigma_csi^2-2*rho*sigma_eps*sigma_csi

Pr0 = (beta[1]:*NL:+Alpha[1]:*Cons:+Alpha[2]:*A:+Alpha[3]:*NC:-Gamma[1]:*E:-Gamma[2]:*A):/sigma_v
Pr0 = normal(Pr0)
Pr0 =  exp(Pr0):/(1:+exp(Pr0))

Pr1_1 = (W:-Gamma[1]:*E:-Gamma[2]:*A):/sigma_v

Pr1_2 = W:-Alpha[1]:*Cons:-Alpha[2]:*A:-Alpha[3]:*NC:-beta[1]:*NL
Pr1_2 = Pr1_2 :-(rho*sigma_eps/sigma_csi):*(W:-Gamma[1]:*E:-Gamma[2]:*A)
Pr1_2 = Pr1_2:/(sigma_eps*sqrt(1-rho^2))

Pr1 = (1/sigma_csi):*normalden(Pr1_1):*normal(Pr1_2)
Pr1 =  exp(Pr1):/(1:+exp(Pr1))

/* using logit transformation */

Pr0 = ln(Pr0:/(1:-Pr0))
Pr1 = ln(Pr1:/(1:-Pr1))

val = sum(Y:*ln(Pr1):+(1:-Y):*ln(Pr0))
}

S =optimize_init()
optimize_init_which(S, "min")
optimize_init_evaluator(S, &Log_Likelihood())
optimize_init_technique(S, "nm")
optimize_init_nmsimplexdeltas(S, J(1, 3, 1))
optimize_init_params(S, (9.156, 0.858, -0.609, 1.265, 1232.229, 60.274,100, 100, 0))
p = optimize(S)
p
optimize_result_value(S)


end

