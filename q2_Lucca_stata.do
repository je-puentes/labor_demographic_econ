* Keep variables
keep year empstat hhincome incwage incwage_sp educd age nchild

* Age restriction
drop if age > 55
drop if age < 25

* Keep employed and non employed workers
drop if empstat == 0 | empstat == 3

* New variable employed - unemployed now receives zero
g employed = 0
* If employed
replace employed = 1 if empstat == 1

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

* Drop negative missing and negative income
drop if hhincome >= 9999998
drop if incwage >= 999998
drop if incwage_sp >= 999998
drop if hhincome < 0
drop if incwage < 0
drop if incwage_sp < 0

* Real income
generate real_hhincome = hhincome * 100 / ( Price_Index )
generate real_incwage = incwage * 100 / ( Price_Index )
generate real_incwage_sp = incwage_sp * 100 / ( Price_Index )

generate incnonlabor = real_hhincome - real_incwage - real_incwage_sp
drop if incnonlabor < 0

* Educ related variables
drop if educd <=1
drop if educd == 999

* Elementary
g elementary = 0
replace elementary = 1 if educd > 2 & educd < 30

* High School
g highschool = 0
replace highschool = 1 if educd >= 30 & educd < 65

* College
g college = 0
replace college = 1 if educd >= 65

* Drop if works but does not receive a wage
drop if real_incwage == 0 & employed == 1

* We will not use all these variables
drop Price_Index
drop educd
drop hhincome
drop real_hhincome
drop incwage
drop incwage_sp
drop real_incwage_sp
drop empstat
