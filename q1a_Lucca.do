* Keep only the variables and observations we will use - women aged 15-65
keep year hhincome inctot incwage uhrswork empstat sex age wkswork2
drop if sex != 2
drop if age > 65
drop if age < 15

*Correcting to Real values
g Price_Index = 0
replace Price_Index = 208.80556984677200 if year == 2005
replace Price_Index = 215.34214811426400 if year == 2006
replace Price_Index = 221.92392295918700 if year == 2007
replace Price_Index = 227.93273798574800 if year == 2008
replace Price_Index = 230.81423554946100 if year == 2009
replace Price_Index = 232.48710665007100 if year == 2010
replace Price_Index = 237.86484774264700 if year == 2011
replace Price_Index = 242.97195785139900 if year == 2012
replace Price_Index = 248.15000694380300 if year == 2013
replace Price_Index = 253.70029024799400 if year == 2014
replace Price_Index = 259.5563650712550  if year == 2015
replace Price_Index = 266.24186043556700 if year == 2016
replace Price_Index = 272.73297356975500 if year == 2017
replace Price_Index = 280.16524554597400 if year == 2018
replace Price_Index = 288.28592794627100 if year == 2019

*Correcting weeks worked
replace wkswork2 = 7 if wkswork2 == 1
replace wkswork2 = 20 if wkswork2 == 2
replace wkswork2 = 33 if wkswork2 == 3
replace wkswork2 = 43.5 if wkswork2 == 4
replace wkswork2 = 48.5 if wkswork2 == 5
replace wkswork2 = 51 if wkswork2 == 6

* Real income
drop if hhincome < 0
drop if inctot < 0
drop if incwage < 0
drop if uhrswork < 0

generate real_hhincome = hhincome * 100 / ( Price_Index )
generate real_incwage = incwage * 100 / ( Price_Index )
generate real_inctot = inctot * 100 / ( Price_Index )

* Employment rate plot
g employed = 0
* If employed
replace employed = 1 if empstat == 1
* Missing values
replace employed = -1 if empstat == 0
* Plot
graph bar (mean) employed if employed >= 0, over(year)

* Other plots - uhrsworked = 0 is N/A
graph bar (mean) uhrswork if uhrswork > 0, over(year)

graph bar (mean) real_incwage if incwage < 999998, over(year)
