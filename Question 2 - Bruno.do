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

*educ

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




///////////////////////////
* Doing using stata function - 5950 observations (more than that for some reason 
* the function return an error menssage)
///////////////////////////

* I will perform the Robinson estimator
* For the bandwidth i will let the stata do it by itself

*

npregress kernel employed NLIncome educ nchild age in 1/5000, estimator(constant) predict(P_hat D1 D2 D3 D4, replace)


/* Doing by hand */

timer on 1
mata
/* Defining variables */
P = st_data(1::10000, "employed")
X = st_data(1::10000, ("NLIncome", "age", "educ", "nchild"))

/* Covariance matrix*/
Sigma = variance(X)

/*Optimal Bandwidth*/
dig = J(1, 4,0)
for (i=1; i<=4;i++){
dig[i] = (4/(rank(X)+2))^(2/(rank(X)+4))*rows(X)^(-2/(rank(X)+4))*Sigma[i,i]
}

/* Creating the Kernel function*/
function indicator(x) {
if (abs(x) < 1) val = 1
else val = 0
return (val)

}

/* creating a function using the Epanechnikov kernel*/
function kernel(z){

Value = J(rows(z), cols(z),0)
for (i = 1; i <= cols(z); i++){

for (j=1; j<= rows(z); j++){
	Value[j, i] = 3/4*(1-z[j,i]^2)*indicator(z[j,i])
}
}
	return(Value)
	
}

/*Nadaraya-Watson Estimator*/

NW = J(rows(X), 1, 0)

for (i1 = 1; i1 <= rows(X); i1++){
v = kernel((X[i1,.]:-X):/dig)
v2 = v[.,1]:*v[.,2]:*v[.,3]:*v[.,4]:*P
v3 = v[.,1]:*v[.,2]:*v[.,3]:*v[.,4]
NW[i1] = sum(v2)/sum(v3)
printf("iteration = %g\n", i1)
}

/* Comparing the estimates found manueally with the ones found with the stata function*/
P_hat = st_data(1::5000, "P_hat")
A = NW[1::5000]:-P_hat
mean(A)



end

timer off 1
timer list 1
*/

/* Question 2 - B*/

*Real wage
replace incwage = incwage/Price_Index *100

* Doing it using the function

npregress kernel incwage P_hat in 1/5000,estimator(constant) predict(gwP D1, replace)

/* graph */
npgraph
graph export wageP.png

npregress kernel educ P_hat in 1/5000,estimator(constant) predict(geP D1, replace)

/* graph*/
npgraph		
graph export educP.png


npregress kernel age P_hat in 1/5000, estimator(constant) predict(gaP D1, replace)

/*graph*/
npgraph
graph export ageP.png

g e_wp = incwage - gwP

g e_ap = age - gaP

g e_ep = educ - geP

reg e_wp e_ap e_ep in 1/5000, nocons

* doing it manually

mata

/* Importing the data*/
X = st_data(1::10000, ("age", "educ"))
W = st_data(1::10000, "incwage")
/*Defining the Bandwidth*/
NW_bandwidth = (4/(1+2))^(2/(1+4))*1^(-2/(1+4))*variance(NW)

/*npregress kernel incwage P_hat in 1/5000,predict(gwP D1, replace)*/
gwp = J(rows(X), 1, 0)

for (i1 = 1; i1 <= rows(X); i1++){
v = kernel((NW[i1,.]:-NW):/NW_bandwidth)
v2 = v[.,1]:*W
gwp[i1] = sum(v2)/sum(v)
printf("iteration = %g\n", i1)
}

/*npregress kernel educ P_hat in 1/5000,predict(geP D1, replace)*/
gep = J(rows(X), 1, 0)

for (i1 = 1; i1 <= rows(X); i1++){
v = kernel((NW[i1,.]:-NW):/NW_bandwidth)
v2 = v[.,1]:*X[.,2]
gep[i1] = sum(v2)/sum(v)
printf("iteration = %g\n", i1)
}

/*npregress kernel educ P_hat in 1/5000,predict(geP D1, replace)*/
gap = J(rows(X), 1, 0)

for (i1 = 1; i1 <= rows(X); i1++){
v = kernel((NW[i1,.]:-NW):/NW_bandwidth)
v2 = v[.,1]:*X[.,1]
gap[i1] = sum(v2)/sum(v)
printf("iteration = %g\n", i1)
}

e_wp = W :- gwp
e_ap = X[.,1] :-gap
e_ep = X[.,2] :- gep
e_X = e_ep, e_ap

Gamma = invsym(e_X'*e_X)*e_X'*e_wp

end

/* Question 2-C */

/* using package st0144.pkg*/
g hhP = hhincome*P_hat

/*
sml employed hhincome P_hat hhP in 1/5000
*/

mata

void Log_Likelihood(todo, beta, BRUNO, g, H){


Y = st_data(1::10000, "employed")
NL = st_data(1::10000, "NLIncome")
Cons = J(rows(Y), 1, 1)
A = st_data(1::10000, "age")
NC = st_data(1::10000, "nchild")
E = st_data(1::10000, "educ")
bandwidth = rows(Y)^(-1/7)

Gamma =  1179.231203,84.75829114

val1 = beta[1]:*NL
val2 = beta[2]:*Cons :+ beta[3]:*A :+ beta[4]:*NC
val3 = Gamma[1]:*E + Gamma[2]:*A
val4 = (val1:+val2:-val3)

val7 = J(rows(Y), 1, 0)

for (i1 = 1; i1 <= rows(Y); i1++){
val5 = kernel((val4[i1]:-val4):/bandwidth)
val6 = val5:*Y
val7[i1] = sum(val6)/sum(val5)
}


P = 1:-val7
val8 = Y:*(ln(P)) :+ (1:-Y):*(1:-ln(P))
BRUNO = sum(val8)
}

S =optimize_init()
optimize_init_which(S, "max")
optimize_init_evaluator(S, &Log_Likelihood())
optimize_init_technique(S, "nm")
optimize_init_nmsimplexdeltas(S, J(1, 3, 1))
optimize_init_params(S, (10, 0, 0, 0))
p = optimize(S)
p
optimize_result_value(S)

end
