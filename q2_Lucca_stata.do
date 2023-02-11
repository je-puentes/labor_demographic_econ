* Keep variables
keep year empstat hhincome incwage educd age nchild sex marst

* Age restriction
drop if age > 55
drop if age < 25

* Only women
drop if sex == 1

* Only married
drop if marst >=3

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
drop if hhincome < 0
drop if incwage < 0

* Real income
generate real_hhincome = hhincome * 100 / ( Price_Index )
generate real_incwage = incwage * 100 / ( Price_Index )

generate incnonlabor = real_hhincome - real_incwage
drop if incnonlabor < 0

* Educ related variables
drop if educd <=1
drop if educd == 999
g education = -1
replace education = 0 if educd == 2
replace education = 1 if educd == 14
replace education = 2 if educd == 15
replace education = 2.5 if educd == 13
replace education = 3 if educd == 16
replace education = 4 if educd == 17
replace education = 5 if educd == 22
replace education = 5.5 if educd == 21
replace education = 6 if educd == 23
replace education = 6.5 if educd == 20
replace education = 7 if educd == 25
replace education = 7.5 if educd == 24
replace education = 8 if educd == 26
replace education = 9 if educd == 30
replace education = 10 if educd == 40
replace education = 11 if educd == 50
replace education = 12 if educd == 60
replace education = 12 if educd == 61
replace education = 12 if educd == 62
replace education = 12 if educd == 63
replace education = 12 if educd == 64
replace education = 12 if educd == 65
replace education = 13 if educd == 70
replace education = 13 if educd == 71
replace education = 14 if educd == 80
replace education = 15 if educd == 90
replace education = 16 if educd == 100
replace education = 16 if educd == 101
replace education = 17 if educd == 110
replace education = 18 if educd == 111
replace education = 19 if educd == 112
replace education = 20 if educd == 113
replace education = 20 if educd == 114
replace education = 20 if educd == 116
drop if education == -1

* Drop if works but does not receive a wage
drop if real_incwage == 0 & employed == 1

* We will not use all these variables
drop Price_Index
drop educd
drop hhincome
drop real_hhincome
drop incwage
drop empstat
drop marst
drop sex
