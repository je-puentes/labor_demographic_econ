
use "C:\Users\bromo\OneDrive\Área de Trabalho\FGV - Mestrado\Optativas\Labor\data_PS1.dta", clear

/* Question 1 - A*/
g employed = 0
replace employed = 1 if empstat == 1
egen mean_labor = mean(employed), by(year)
scatter mean_labor year

/*Question 1 - B*/

* For this question since we don't observe if the child is under 16, 
* I will spearate the observations if the youngest child is below 5 year old or not

* For full time job i will consider if the person worked more than 30 hours per week

* For the Minser paper i have to filter for white wife-husband families and for the heads
* were self-emplyed or not gainfully occupied

*Taking only married observations
drop if marst > 2


*Taking out the observations in which any of the spouses are not the heads
drop if relate != 01 & relate_sp != 01

* Head is unemployed or not in the Labor Force
drop if relate == 01 & empstat > 1
drop if relate_sp == 01 & empstat_sp > 1

* Dropping if both spouses are not white
drop if race !=01 | race_sp !=01

*Elementary (<= Grade 9)

count if age <= 35 & nchlt5 != 0 & educ < 4 & uhrswork >= 30	
scalar NEL35D0FT = r(N)
*N - Number, E - Elementary, L35 - Less than 35, D0 - Nchlt different from 0
* FT - Full Time

count if age <= 35 & nchlt5 != 0 & educ < 4 & uhrswork < 30
scalar NEL35D0NFT = r(N)
*N - Number, E - Elementary, L35 - Less than 35, D0 - Nchlt different from 0
* NFT - Non Full Time


count if age <= 35 & nchlt5 == 0 & educ < 4 & uhrswork >= 30
scalar NEL35E0FT = r(N)
*N - Number, E - Elementary, L35 - Less than 35, E0 - Nchlt equal to 0
* FT - Full Time

count if age <= 35 & nchlt5 == 0 & educ < 4 & uhrswork < 30
scalar NEL35E0NFT = r(N)
*N - Number, E - Elementary, L35 - Less than 35, E0 - Nchlt equal to 0
* NFT - Non Full Time

count if age > 35 & age <= 55 & educ < 4 & uhrswork >= 30
scalar NEL55FT = r(N)
*N - Number, E - Elementary, L55 - Less than 55, FT - Full Time

count if age > 35 & age <= 55 & educ < 4 & uhrswork < 30
scalar NEL55NFT = r(N)
*N - Number, E - Elementary, L55 - Less than 55, NFT - Non Full Time

count if age > 55 & educ < 4 & uhrswork >= 30
scalar NEO55FT = r(N)
*N - Number, E - Elementary, L55 - Over 55, FT - Full Time

count if age > 55 & educ < 4 & uhrswork < 30
scalar NEO55NFT = r(N)
*N - Number, E - Elementary, O55 - Over 55, NFT - Non Full Time

*High School (Grade 9 <= x <= Grade 12)

count if age <= 35 & nchlt5 != 0 & (educ >= 4 | educ <=6)  & uhrswork >= 30
scalar NHL35D0FT = r(N)
*N - Number, H - High School, L35 - Less than 35, D0 - Nchlt different from 0
* FT - Full Time

count if age <= 35 & nchlt5 != 0 & (educ >= 4 | educ <=6) & uhrswork < 30
scalar NHL35D0NFT = r(N)
*N - Number, H - High School, L35 - Less than 35, D0 - Nchlt different from 0
* NFT - Non Full Time


count if age <= 35 & nchlt5 == 0 & (educ >= 4 | educ <=6) & uhrswork >= 30
scalar NHL35E0FT = r(N)
*N - Number, H - High School, L35 - Less than 35, E0 - Nchlt equal to 0
* FT - Full Time

count if age <= 35 & nchlt5 == 0 & (educ >= 4 | educ <=6) & uhrswork < 30
scalar NHL35E0NFT = r(N)
*N - Number, H - High School, L35 - Less than 35, E0 - Nchlt equal to 0
* NFT - Non Full Time

count if age > 35 & age <= 55 & (educ >= 4 | educ <=6) & uhrswork >= 30
scalar NHL55FT = r(N)
*N - Number, H - High School, L55 - Less than 55, FT - Full Time

count if age > 35 & age <= 55 & (educ >= 4 | educ <=6) & uhrswork < 30
scalar NHL55NFT = r(N)
*N - Number, H - High School, L55 - Less than 55, NFT - Non Full Time

count if age > 55 & (educ >= 4 | educ <=6) & uhrswork >= 30
scalar NHO55FT = r(N)
*N - Number, H - High School, L55 - Over 55, FT - Full Time

count if age > 55 & (educ >= 4 | educ <=6) & uhrswork < 30
scalar NHO55NFT = r(N)
*N - Number, H - High School, O55 - Over 55, NFT - Non Full Time


*College (>= College 1)

count if age <= 35 & nchlt5 != 0 & educ > 7  & uhrswork >= 30
scalar NCL35D0FT = r(N)
*N - Number, C - College, L35 - Less than 35, D0 - Nchlt different from 0
* FT - Full Time

count if age <= 35 & nchlt5 != 0 & educ > 7 & uhrswork < 30
scalar NCL35D0NFT = r(N)
*N - Number, C - College, L35 - Less than 35, D0 - Nchlt different from 0
* NFT - Non Full Time


count if age <= 35 & nchlt5 == 0 & educ > 7 & uhrswork >= 30
scalar NCL35E0FT = r(N)
*N - Number, C - College, L35 - Less than 35, E0 - Nchlt equal to 0
* FT - Full Time

count if age <= 35 & nchlt5 == 0 & educ > 7 & uhrswork < 30
scalar NCL35E0NFT = r(N)
*N - Number, C - College, L35 - Less than 35, E0 - Nchlt equal to 0
* NFT - Non Full Time

count if age > 35 & age <= 55 & educ > 7 & uhrswork >= 30
scalar NCL55FT = r(N)
*N - Number, C - College, L55 - Less than 55, FT - Full Time

count if age > 35 & age <= 55 & educ > 7 & uhrswork < 30
scalar NCL55NFT = r(N)
*N - Number, C - College, L55 - Less than 55, NFT - Non Full Time

count if age > 55 & educ > 7 & uhrswork >= 30
scalar NCO55FT = r(N)
*N - Number, C - College, L55 - Over 55, FT - Full Time

count if age > 55 & educ > 7 & uhrswork < 30
scalar NCO55NFT = r(N)
*N - Number, C - College, O55 - Over 55, NFT - Non Full Time

scalar list






