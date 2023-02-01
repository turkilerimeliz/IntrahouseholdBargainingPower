/*==============================================================================
                       1: Years of Schooling Imputation
==============================================================================*/
*-------------------------------------------------------------------------------
**Create a dataset reports median years of schooling by ISCED97 and country

use `parents',replace

// drop observations where years of schooling recorded as inconsistent
drop if dn041_v4_key==-1
drop if dn041_v4_key==1

// drop observations where years of schooling recorded as suspected,refusal, dont know 
drop if dn041_v4==-3
drop if dn041_v4==-2
drop if dn041_v4==-1

// drop observations where years of schooling recorded as still in school or other
drop if dn041_v4==95
drop if dn041_v4==97

// drop observations 
drop if isced1997_r_v2_key!=0

// use only reported years of schooling
keep if dn041_v4_key==0

// collapse median level by isced and country
collapse (count)observation1=dn041_v4 (mean) mean_1=dn041_v4 (p50) median_1=dn041_v4 (sd) sd1=dn041_v4 (min) min1=dn041_v4 (max) max1=dn041_v4, by(isced1997_r_v2 country_p)
sort country_p isced1997_r_v2

// check for implausible estimations - winsorize them
replace median_1=5 if country_p==16 & isced1997_r_v2==0
replace median_1=8 if country_p==17 & isced1997_r_v2==0
replace median_1=. if isced1997_r_v2==-2 | isced1997_r_v2==-1 | isced1997_r_v2==95 | isced1997_r_v2==97  

// label variables
rename isced1997_r_v2 isced97_educ
rename country_p country

// save
save `median_yrschl' ,replace

*-------------------------------------------------------------------------------
* Expand the dataset based on country_res (this part will use for wage modelling)

gen country_res_=.
replace country_res_=40 if country==11
replace country_res_=276 if country==12
replace country_res_=752 if country==13
replace country_res_=528 if country==14
replace country_res_=724 if country==15
replace country_res_=380 if country==16
replace country_res_=250 if country==17
replace country_res_=208 if country==18
replace country_res_=300 if country==19
replace country_res_=756 if country==20
replace country_res_=56 if country==23
replace country_res_=376 if country==25
replace country_res_=203 if country==28
replace country_res_=616 if country==29
replace country_res_=372 if country==30
replace country_res_=442 if country==31
replace country_res_=348 if country==32
replace country_res_=620 if country==33
replace country_res_=705 if country==34
replace country_res_=233 if country==35
replace country_res_=191 if country==47

// there are more than 1 residence code for Germany ( west-east-after transition)
expand 2 if country==12, generate(newv1)
replace country_res_=278 if country==12 & newv1==1
expand 2 if country_res_==278, generate(newv2)
replace country_res_=280 if country==12 & newv2==1

expand 2 if country==28, generate(newv3)
replace country_res_=200 if country==28 & newv3==1

// label variables
rename country country_educ
drop newv1 newv2 newv3

// keep necessary variables and save
save `median_yrschl_job',replace

*----------------------------END OF DO FILE-------------------------------------
*-------------------------------------------------------------------------------

