/*==============================================================================
                       1: Dataset Creation - Child Age
==============================================================================*/

*----Create dataset reports years corresponding child's ages of 6 to 15---------

use `children' , replace

** create dataset for mothers
preserve
keep coupleid country gender year_birth mother_id father_id child_year_6 child_year_7 child_year_8 child_year_9 child_year_10 child_year_11 child_year_12 child_year_13 child_year_14 child_year_15 mother_median_1 mother_years_educ mother_years_educ_key mother_isced97 mother_isced97_key mother_foreign mother_came

reshape long child_year_, i(coupleid country gender year_birth) j(child_age) 
rename gender child_gender
rename year_birth  child_year_birth
rename child_year_ year

rename mother_id mergeid
rename coupleid child_coupleid
rename country child_country

rename mother_foreign foreign_live
rename mother_came migration_year
rename mother_isced97 isced97_educ
rename mother_median_1 median1
rename mother_years_educ years_of_educ
rename mother_isced97_key isced97_key
rename mother_years_educ_key years_of_educ_key

duplicates drop mergeid year, force

save `childAge_mother',replace
restore

** create dataset for fathers
preserve
keep coupleid country gender year_birth mother_id father_id child_year_6 child_year_7 child_year_8 child_year_9 child_year_10 child_year_11 child_year_12 child_year_13 child_year_14 child_year_15 father_median_1 father_years_educ father_years_educ_key father_isced97 father_isced97_key father_foreign father_came

reshape long child_year_, i(coupleid country gender year_birth) j(child_age) 
rename gender child_gender
rename year_birth  child_year_birth
rename child_year_ year

rename father_id mergeid
rename coupleid child_coupleid
rename country child_country

rename father_foreign foreign_live
rename father_came migration_year
rename father_isced97 isced97_educ
rename father_median_1 median1
rename father_years_educ years_of_educ
rename father_isced97_key isced97_key
rename father_years_educ_key years_of_educ_key

duplicates drop mergeid year, force

save `childAge_father',replace
restore
clear

/*==============================================================================
                       2: Job History Datasets - Parents
==============================================================================*/

*Combine job episode panel with childAge datasets report years corresponding child's ages of 6 to 15

use "sharewX_rel7-1-0_gv_job_episodes_panel.dta", replace

** merge with dataset for mothers
preserve
merge m:1 mergeid year using `childAge_mother'

drop if _merge==1

gen mother_history=1 if _merge==3
replace mother_history=0 if _merge==2
label variable mother_history "Mothers' job history match info"

drop _merge
drop child_gender 
drop child_year_birth 

gen parent_status=1
label define parent_status 1 "Mergeid is mother_id" 2 "Mergeid is father_id"
label values parent_status parent_status
save `mother_job_episode',replace

drop if  mother_history!=0
save `mother_job_episode_unmatch',replace
restore


** merge with dataset for fathers 
preserve
merge m:1 mergeid year using `childAge_father'
drop if _merge==1

gen father_history=1 if _merge==3
replace father_history=0 if _merge==2

drop _merge
drop child_gender 
drop child_year_birth 

gen parent_status=2
label define parent_status 1 "Mergeid is mother_id" 2 "Mergeid is father_id"
label values parent_status parent_status
label variable father_history "Fathers' job history match info"
save `father_job_episode',replace

drop if  father_history!=0
save `father_job_episode_unmatch',replace
restore

*--------------Append mother's and father's job episode datasets---------------- 

use `mother_job_episode', replace
append using `father_job_episode'

drop if mother_history!=1 & parent_status==1
drop if father_history!=1 & parent_status==2


//use country information when country of residence missing in a given year
replace country_res_=40 if country_res_==. & country==11
replace country_res_=276 if country_res_==. & country==12
replace country_res_=752 if country_res_==. & country==13
replace country_res_=528 if country_res_==. & country==14
replace country_res_=724 if country_res_==. & country==15
replace country_res_=380 if country_res_==. & country==16
replace country_res_=250 if country_res_==. & country==17
replace country_res_=208 if country_res_==. & country==18
replace country_res_=300 if country_res_==. & country==19
replace country_res_=756 if country_res_==. & country==20
replace country_res_=56 if country_res_==. & country==23
replace country_res_=376 if country_res_==. & country==25
replace country_res_=203 if country_res_==. & country==28
replace country_res_=616 if country_res_==. & country==29
replace country_res_=372 if country_res_==. & country==30
replace country_res_=442 if country_res_==. & country==31
replace country_res_=348 if country_res_==. & country==32
replace country_res_=620 if country_res_==. & country==33
replace country_res_=705 if country_res_==. & country==34
replace country_res_=233 if country_res_==. & country==35
replace country_res_=191 if country_res_==. & country==47


// redefine gender
replace gender=0 if gender==2
label define gender 2 "", modify
label define gender 0 "Female", add

// define marital status
gen partner_married=1 if withpartner==1 | married==1
replace partner_married=0 if withpartner==0 & married==0

// define age
gen age2= age^2

// define 3-levels education variable
gen educ_3level=1 if isced97_educ==0 | isced97_educ==1 | isced97_educ==2
replace educ_3level=2 if isced97_educ==3 | isced97_educ==4 
replace educ_3level=3 if isced97_educ==5 | isced97_educ==6
replace educ_3level=. if isced97_educ==.
replace educ_3level=-1 if isced97_educ==95 | isced97_educ==97

//label variable
label variable father_id "Spouse id: based on mergeidp or mergeid"
label variable mother_id "Spouse id: based on mergeidp or mergeid"

// flag the sample
gen parent_sample=1

// save
save `parents_job_episode',replace

/*==============================================================================
             3: Country Specific Job History Datasets - Parents
==============================================================================*/

*-------Split parents job episode dataset based on country of residence--------- 

preserve
keep if country_res_==40 
save `Austria_parents_job', replace
restore 

preserve
keep if country_res_==276 | country_res_==278 | country_res_==280 
save `Germany_parents_job', replace
restore 

preserve
keep if country_res_==752
save `Sweden_parents_job', replace
restore

preserve
keep if country_res_==528
save `Netherlands_parents_job', replace
restore

preserve
keep if country_res_==724
save `Spain_parents_job', replace
restore

preserve
keep if country_res_==380
save `Italy_parents_job', replace
restore

preserve
keep if country_res_==250
save `France_parents_job', replace
restore

preserve
keep if country_res_==208
save `Denmark_parents_job', replace
restore

preserve
keep if country_res_==300
save `Greece_parents_job', replace
restore

preserve
keep if country_res_==756
save `Switzerland_parents_job', replace
restore

preserve
keep if country_res_==56
save `Belgium_parents_job', replace
restore


preserve
keep if country_res_==372
save `Ireland_parents_job', replace
restore

preserve
keep if country_res_==442
save `Luxembourg_parents_job', replace
restore

preserve
keep if country_res_==620
save `Portugal_parents_job', replace
restore


*----------------------------END OF DO FILE-------------------------------------
*-------------------------------------------------------------------------------

