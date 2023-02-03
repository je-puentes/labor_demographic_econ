* Keep variables
keep year empstat sex age wkswork2 marst relate relate_sp empstat empstat_sp race race_sp nchlt5 educd uhrswork

* Taking only married observations
drop if marst > 2

* Taking out the observations in which any of the spouses are not the heads
drop if relate != 01 & relate_sp != 01

* Head is unemployed or not in the Labor Force
drop if relate == 01 & empstat > 1
drop if relate_sp == 01 & empstat_sp > 1

* Drop if at least one spouse is not white
drop if race !=01 | race_sp !=01

* Under 35 - elementary school
count if age <= 35 & nchlt5 != 0 & educd > 2 & educd < 30 & uhrswork >= 30	
scalar under35_smallch_elem_FT = r(N)

count if age <= 35 & nchlt5 != 0 & educd > 2 & educd < 30 & uhrswork < 30 & uhrswork > 0
scalar  under35_smallch_elem_NFT = r(N)

count if age <= 35 & nchlt5 == 0 & educd > 2 & educd < 30 & uhrswork >= 30	
scalar under35_noch_elem_FT = r(N)

count if age <= 35 & nchlt5 == 0 & educd > 2 & educd < 30 & uhrswork < 30 & uhrswork > 0
scalar  under35_noch_elem_NFT = r(N)

* Under 55 - elementary school
count if age > 35 & age <= 55 & educd > 2 & educd < 30 & uhrswork >= 30	
scalar under55_elem_FT = r(N)

count if age > 35 & age <= 55 & educd > 2 & educd < 30 & uhrswork < 30 & uhrswork > 0
scalar  under55_elem_NFT = r(N)

* Older than 55 - elementary school
count if age > 55 & educd > 2 & educd < 30 & uhrswork >= 30	
scalar older55_elem_FT = r(N)

count if age > 55 & educd > 2 & educd < 30 & uhrswork < 30 & uhrswork > 0
scalar  older55_elem_NFT = r(N)

* Under 35 - high school
count if age <= 35 & nchlt5 != 0 & educd >= 30 & educd < 65 & uhrswork >= 30	
scalar under35_smallch_hs_FT = r(N)

count if age <= 35 & nchlt5 != 0 & educd >= 30 & educd < 65 & uhrswork < 30 & uhrswork > 0
scalar  under35_smallch_hs_NFT = r(N)

count if age <= 35 & nchlt5 == 0 & educd >= 30 & educd < 65 & uhrswork >= 30	
scalar under35_noch_hs_FT = r(N)

count if age <= 35 & nchlt5 == 0 & educd >= 30 & educd < 65 & uhrswork < 30 & uhrswork > 0
scalar  under35_noch_hs_NFT = r(N)

* Under 55 - high school
count if age > 35 & age <= 55 & educd >= 30 & educd < 65 & uhrswork >= 30	
scalar under55_hs_FT = r(N)

count if age > 35 & age <= 55 & educd >= 30 & educd < 65 & uhrswork < 30 & uhrswork > 0
scalar  under55_hs_NFT = r(N)

* Older than 55 - high school
count if age > 55 & educd >= 30 & educd < 65 & uhrswork >= 30	
scalar older55_elem_FT = r(N)

count if age > 55 & educd >= 30 & educd < 65 & uhrswork < 30 & uhrswork > 0
scalar  older55_elem_NFT = r(N)

* Under 35 - college
count if age <= 35 & nchlt5 != 0 & educd >= 65 & educd <= 116 & uhrswork >= 30	
scalar under35_smallch_college_FT = r(N)

count if age <= 35 & nchlt5 != 0 & educd >= 65 & educd <= 116 & uhrswork < 30 & uhrswork > 0
scalar  under35_smallch_college_NFT = r(N)

count if age <= 35 & nchlt5 == 0 & educd >= 65 & educd <= 116 & uhrswork >= 30	
scalar under35_noch_college_FT = r(N)

count if age <= 35 & nchlt5 == 0 & educd >= 65 & educd <= 116 & uhrswork < 30 & uhrswork > 0
scalar  under35_noch_college_NFT = r(N)

* Under 55 - college
count if age > 35 & age <= 55 & educd >= 65 & educd <= 116 & uhrswork >= 30	
scalar under55_college_FT = r(N)

count if age > 35 & age <= 55 & educd >= 65 & educd <= 116 & uhrswork < 30 & uhrswork > 0
scalar  under55_college_NFT = r(N)
