clear
clear mata

use "C:\Users\Adm\Downloads\data_PS1.dta"

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

///////////////////////////
* Doing using stata function - 5950 observations (more than that for some reason 
* the function return an error menssage)
///////////////////////////

* I will perform the Robinson estimator
* For the bandwidth i will let the stata do it by itself

*

npregress kernel employed NLIncome educ nchild age in 1/5000,predict(P_hat D1 D2 D3 D4, replace)


/* Doing by hand */

timer on 1
mata
/* Defining variables */
P = st_data(1::5000, "employed")
X = st_data(1::5000, ("NLIncome", "age", "educ", "nchild"))

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

for (i1 = 1; i1 <= 5000; i1++){
v = kernel((X[i1,.]:-X):/dig)
v2 = v[.,1]:*v[.,2]:*v[.,3]:*v[.,4]:*P
v3 = v[.,1]:*v[.,2]:*v[.,3]:*v[.,4]
NW[i1] = sum(v2)/sum(v3)
}

/* Comparing the estimates found manueally with the ones found with the stata function*/
P_hat = st_data(1::5000, "P_hat")
A = NW:-P_hat
A[1::50]



end

timer off 1
timer list 1
*/

/* Question 2 - B*/

*Real wage
replace incwage = incwage/Price_Index *100

* Doing it using the function

npregress kernel incwage P_hat in 1/5000,predict(gwP D1, replace)

npregress kernel educ P_hat in 1/5000,predict(geP D1, replace)

npregress kernel age P_hat in 1/5000,predict(gaP D1, replace)

g e_wp = incwage - gwP

g e_ap = age - gaP

g e_ep = educ - geP

reg e_wp e_ap e_ep in 1/5000

* doing it manually

mata

/* Importing the data*/
X = st_data(1::5000, ("age", "educ"))
W = st_data(1::5000, "incwage")
/*Defining the Bandwidth*/
wage_bandwidth = (4/(1+2))^(2/(1+4))*1^(-2/(1+4))*variance(NW)
X_bandwidth = (4/(1+2))^(2/(1+4))*1^(-2/(1+4)):*variance(NW)

/*npregress kernel incwage P_hat in 1/5000,predict(gwP D1, replace)*/
gwp = J(rows(X), 1, 0)

for (i1 = 1; i1 <= 5000; i1++){
v = kernel((NW[i1,.]:-NW):/wage_bandwidth)
v2 = v[.,1]:*W
gwp[i1] = sum(v2)/sum(v)
}

/*npregress kernel educ P_hat in 1/5000,predict(geP D1, replace)*/
gep = J(rows(X), 1, 0)

for (i1 = 1; i1 <= 5000; i1++){
v = kernel((NW[i1,.]:-NW):/X_bandwidth[2,2])
v2 = v[.,1]:*X[.,2]
gep[i1] = sum(v2)/sum(v)
}

/*npregress kernel educ P_hat in 1/5000,predict(geP D1, replace)*/
gap = J(rows(X), 1, 0)

for (i1 = 1; i1 <= 5000; i1++){
v = kernel((NW[i1,.]:-NW):/X_bandwidth[1,1])
v2 = v[.,1]:*X[.,1]
gap[i1] = sum(v2)/sum(v)
}

e_wp = W :- gwp
e_ep = X[.,2] :- gep
e_ap = X[.,1] :- gap
constant = J(rows(e_wp), 1, 1)
e_X = constant,e_ep, e_ap

gama = invsym(e_X'*e_X)*e_X'*e_wp

end

/* Question 2-C */

/* using package st0144.pkg*/
g hhP = hhincome*P_hat

sml employed hhincome P_hat hhP in 1/5000

mata
function ghat_i2 (z, i){
val1 = kernel(z)
val2 = sum(val1) - val1[i]
return(val2)
}

function Log_Likelihood(beta){
for (z = 1; z<= 5000; z++){
vector[z] = employed[z]*g_hat


}
