/* Question 4 */

*Importing the data set

clear
clear mata

use "C:\Users\bromo\OneDrive\Área de Trabalho\FGV - Mestrado\Optativas\Labor\data_PS1.dta"

drop if hhincome <0
drop if inctot <0
drop if age<25 | age > 55
drop if marst >=3

/* Question 2- A*/
g employed = 0
replace employed = 1 if empstat == 1

*Real Non Labor income
g NLIncome = hhincome - incwage
replace NLIncome = NLIncome/Price_Index * 100
drop if NLIncome <0

replace incwage = incwage/Price_Index *100

*educ

* dropping year

drop if year != 2005

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
replace educ = 13 if educd == 70
replace educ = 14 if educd == 80
replace educ = 15 if educd == 90
replace educ = 16 if educd == 100
replace educ = 17 if educd == 110
replace educ = 18 if educd == 111
replace educ = 19 if educd == 112
replace educ = 20 if educd == 113
drop if educ == -1

* I will assume that x contains the same variables as in question 2a
mata

void GMM(todo, beta, Results, g, H){
T = st_data(., "wkswork2")
Y = st_data(., "NLIncome")
W  = st_data(., "incwage")
X = st_data(., ("age", "educ", "nchild"))
L = 52 :- T
C = Y :+ W:*T :- W:*L /* There is negative consumption*/
B0 = beta[3], beta[4], beta[5]
/*Leisure moment function*/
val1 = mean(mean(X:*(W:*beta[1] :+ (X*B0'):*(Y:+W:*T :- beta[2]:-beta[1]:*W):-W:*L)))

/*Consumption moment function*/
val2 = mean(mean(X:*(beta[2] :+ (1:- X*B0'):*(Y:+W:*T:-beta[2]:-beta[1]:*W):-C)))

/*Roy's Identity moment*/
Roy_1 =  (X*B0'):*(-Y:/(W:^2) + beta[2]:/(W:^2))
Roy_2 = (Y:/W :+ T :- beta[2]:/W :-beta[1])
Roy_3 = (1:-X*B0'):*(T:-beta[1])
Roy_4 = Y:+W:*T:-beta[2]:-beta[1]:*W
Roy_5 = (X*B0'):/W
Roy_6 = (1:-X*B0')

Roy = - (Roy_1:/Roy_2 :+ Roy_3:/Roy_4) :/ (Roy_5:/Roy_2 :+ Roy_6:/Roy_4)
Marshall_leisure = beta[1] :+ (X*B0'):*(Y:+W:*T:-beta[2]:-beta[1]:*W) 

val3 = mean(Marshall_leisure - Roy)

/* Leisure demand moment*/
val4 = mean(mean(W:*L :- W:*beta[1] :- (X*B0'):*(Y:+W:*T:-beta[2]:-beta[1]:*W)))

/* Consumption demand moment*/
val5 = mean(C:-beta[2]:-(1:-X*B0'):*(Y:+W:*T:-beta[2]:-beta[1]:*W))

val = val1,val2,val3,val4,val5

Results = val*val' 

}

S =optimize_init()
optimize_init_which(S, "min")
optimize_init_evaluator(S, &GMM())
optimize_init_technique(S, "nm")
optimize_init_nmsimplexdeltas(S, J(1, 3, 1))
optimize_init_params(S, (10, 10, 10, 10, 10))
p = optimize(S)
p
optimize_result_value(S)


T = st_data(., "wkswork2")
Y = st_data(., "NLIncome")
W  = st_data(., "incwage")
X = st_data(., ("age", "educ", "nchild"))
S00 = mean(-(1-p[3]):*((T:-p[1]):*W:-T:*W):/(W:^2))
S00

end
