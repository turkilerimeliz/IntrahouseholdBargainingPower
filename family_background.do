/*==============================================================================
                1: Master Dataset Creation - Parents Job Histories
==============================================================================*/

*---------------Append country-specific parents job episode datasets------------

use `Austria_parents_job_2', replace 

append using `Belgium_parents_job_2' , nolabel nonotes
append using `Denmark_parents_job_2' , nolabel nonotes
append using `France_parents_job_2'  , nolabel nonotes
append using `Germany_parents_job_2'  , nolabel nonotes
append using `Greece_parents_job_2'  , nolabel nonotes
append using `Ireland_parents_job_2'  , nolabel nonotes
append using `Italy_parents_job_2'  , nolabel nonotes
append using `Luxembourg_parents_job_2'  , nolabel nonotes
append using `Netherlands_parents_job_2'  , nolabel nonotes
append using `Portugal_parents_job_2'  , nolabel nonotes
append using `Spain_parents_job_2'  , nolabel nonotes
append using `Sweden_parents_job_2'  , nolabel nonotes
append using `Switzerland_parents_job_2'  , nolabel nonotes

drop median_1
save  `parents_job_episode_2', replace 


*---------------Merge children dataset with maternal job history----------------

use `children', replace

// keep necessary variables

keep coupleid father_id mother_id gender year_birth child_year_6 child_year_7 child_year_8 child_year_9 child_year_10 child_year_11 child_year_12 child_year_13 child_year_14 child_year_15
rename gender child_gender
rename year_birth child_year_birth

// key id variable is mother's id for this step
rename mother_id mergeid 

// for each years where child is ages of 6-15 recall mother's job history
 forvalues i=6/15 {
 
rename child_year_`i' year
merge m:1 mergeid year using `parents_job_episode_2'

drop if _merge==2
drop retired 
drop ordjob
drop withpartner
drop partner_married
drop married
drop child_coupleid
drop child_country
drop foreign_live
drop migration_year
drop parent_sample
drop spouse_id
drop nchildren_nat
drop parent_status
drop  age2


rename age mother_age_`i'
rename situation mother_situation_`i'
rename w_hat mother_w_hat_`i'
rename w_hat_level mother_w_hat_level_`i'
rename working mother_working_`i'
rename unemployed mother_unemployed_`i'
rename in_education mother_in_education_`i'
rename mainjob mother_mainjob_`i'
rename industry mother_industry_`i'
rename job_title mother_job_title_`i'
rename working_hours mother_working_hours_`i'
rename country_res mother_country_res_`i'
rename nchildren mother_nchildren_`i'
rename _merge mother_merge_`i'

rename year child_year_`i' 
}

// rename maternal variables
rename gender mother_gender
rename yrbirth mother_yrbirth
rename mergeid mother_id
rename country mother_country

// drop unnecessary variables
drop educ_3level years_of_educ years_of_educ_key isced97_educ isced97_educ_key 

*---------------Merge children dataset with paternal job history----------------

// key id variable is father's id for this step
rename father_id mergeid

// for each years where child is ages of 6-15 recall father's job history
 forvalues i=6/15 {
 
rename child_year_`i' year
merge m:1 mergeid year using `parents_job_episode_2'

drop if _merge==2
drop retired 
drop ordjob
drop withpartner
drop partner_married
drop married
drop child_coupleid
drop child_country
drop foreign_live
drop migration_year
drop parent_sample
drop spouse_id
drop nchildren_nat
drop parent_status
drop  age2

rename age father_age_`i'
rename situation father_situation_`i'
rename w_hat father_w_hat_`i'
rename w_hat_level father_w_hat_level_`i'
rename working father_working_`i'
rename unemployed father_unemployed_`i'
rename in_education father_in_education_`i'
rename mainjob father_mainjob_`i'
rename industry father_industry_`i'
rename job_title father_job_title_`i'
rename working_hours father_working_hours_`i'
rename country_res father_country_res_`i'
rename nchildren father_nchildren_`i'
rename _merge father_merge_`i'

rename year child_year_`i'
}

// rename paternal variables
rename gender father_gender
rename yrbirth father_yrbirth
rename mergeid father_id
rename country father_country

// drop unnecessary variables
drop educ_3level years_of_educ years_of_educ_key isced97_educ isced97_educ_key 
 
*Label variables
label variable child_year_6 "Year when child at age 6"
label variable child_year_7 "Year when child at age 7"
label variable child_year_8 "Year when child at age 8"
label variable child_year_9 "Year when child at age 9"
label variable child_year_10 "Year when child at age 10"
label variable child_year_11 "Year when child at age 11"
label variable child_year_12 "Year when child at age 12"
label variable child_year_13 "Year when child at age 13"
label variable child_year_14 "Year when child at age 14"
label variable child_year_15 "Year when child at age 15"

*Order variables
order mother_country, after (mother_yrbirth)
order mother_age_7 mother_age_8 mother_age_9 mother_age_10 mother_age_11 mother_age_12 mother_age_13 mother_age_14 mother_age_15, before(mother_situation_6)

order mother_situation_6 mother_situation_7 mother_situation_8 mother_situation_9 mother_situation_10 mother_situation_11 mother_situation_12 mother_situation_13 mother_situation_14 mother_situation_15 mother_working_6 mother_working_7 mother_working_8 mother_working_9 mother_working_10 mother_working_11 mother_working_12 mother_working_13 mother_working_14 mother_working_15 mother_in_education_6 mother_in_education_7 mother_in_education_8 mother_in_education_9 mother_in_education_10 mother_in_education_11 mother_in_education_12 mother_in_education_13 mother_in_education_14 mother_in_education_15 mother_job_title_6 mother_job_title_7 mother_job_title_8 mother_job_title_9 mother_job_title_10 mother_job_title_11 mother_job_title_12 mother_job_title_13 mother_job_title_14 mother_job_title_15 mother_working_hours_6 mother_working_hours_7 mother_working_hours_8 mother_working_hours_9 mother_working_hours_10 mother_working_hours_11 mother_working_hours_12 mother_working_hours_13 mother_working_hours_14 mother_working_hours_15 mother_industry_6 mother_industry_7 mother_industry_8 mother_industry_9 mother_industry_10 mother_industry_11 mother_industry_12 mother_industry_13 mother_industry_14 mother_industry_15, before(mother_w_hat_6)

order mother_w_hat_6 mother_w_hat_7 mother_w_hat_8 mother_w_hat_9 mother_w_hat_10 mother_w_hat_11 mother_w_hat_12 mother_w_hat_13 mother_w_hat_14 mother_w_hat_15, after(mother_industry_15)
order mother_unemployed_6 mother_unemployed_7 mother_unemployed_8 mother_unemployed_9 mother_unemployed_10 mother_unemployed_11 mother_unemployed_12 mother_unemployed_13 mother_unemployed_14 mother_unemployed_15 mother_mainjob_6 mother_mainjob_7 mother_mainjob_8 mother_mainjob_9 mother_mainjob_10 mother_mainjob_11 mother_mainjob_12 mother_mainjob_13 mother_mainjob_14 mother_mainjob_15 mother_country_res_6 mother_country_res_7 mother_country_res_8 mother_country_res_9 mother_country_res_10 mother_country_res_11 mother_country_res_12 mother_country_res_13 mother_country_res_14 mother_country_res_15 mother_nchildren_6 mother_nchildren_7 mother_nchildren_8 mother_nchildren_9 mother_nchildren_10 mother_nchildren_11 mother_nchildren_12 mother_nchildren_13 mother_nchildren_14 mother_nchildren_15, before(mother_merge_6)

order father_country, after (father_yrbirth)
order father_age_7 father_age_8 father_age_9 father_age_10 father_age_11 father_age_12 father_age_13 father_age_14 father_age_15, before(father_situation_6)

order father_situation_6 father_situation_7 father_situation_8 father_situation_9 father_situation_10 father_situation_11 father_situation_12 father_situation_13 father_situation_14 father_situation_15 father_working_6 father_working_7 father_working_8 father_working_9 father_working_10 father_working_11 father_working_12 father_working_13 father_working_14 father_working_15 father_in_education_6 father_in_education_7 father_in_education_8 father_in_education_9 father_in_education_10 father_in_education_11 father_in_education_12 father_in_education_13 father_in_education_14 father_in_education_15 father_job_title_6 father_job_title_7 father_job_title_8 father_job_title_9 father_job_title_10 father_job_title_11 father_job_title_12 father_job_title_13 father_job_title_14 father_job_title_15 father_working_hours_6 father_working_hours_7 father_working_hours_8 father_working_hours_9 father_working_hours_10 father_working_hours_11 father_working_hours_12 father_working_hours_13 father_working_hours_14 father_working_hours_15 father_industry_6 father_industry_7 father_industry_8 father_industry_9 father_industry_10 father_industry_11 father_industry_12 father_industry_13 father_industry_14 father_industry_15 , before(father_w_hat_6)

order father_w_hat_6 father_w_hat_7 father_w_hat_8 father_w_hat_9 father_w_hat_10 father_w_hat_11 father_w_hat_12 father_w_hat_13 father_w_hat_14 father_w_hat_15, after(father_industry_15)
order father_unemployed_6 father_unemployed_7 father_unemployed_8 father_unemployed_9 father_unemployed_10 father_unemployed_11 father_unemployed_12 father_unemployed_13 father_unemployed_14 father_unemployed_15 father_mainjob_6 father_mainjob_7 father_mainjob_8 father_mainjob_9 father_mainjob_10 father_mainjob_11 father_mainjob_12 father_mainjob_13 father_mainjob_14 father_mainjob_15 father_country_res_6 father_country_res_7 father_country_res_8 father_country_res_9 father_country_res_10 father_country_res_11 father_country_res_12 father_country_res_13 father_country_res_14 father_country_res_15 father_nchildren_6 father_nchildren_7 father_nchildren_8 father_nchildren_9 father_nchildren_10 father_nchildren_11 father_nchildren_12 father_nchildren_13 father_nchildren_14 father_nchildren_15, before(father_merge_6)

*--------------------Define flag variables for important cases -----------------


*flag the cases where mother_never_worked and father_never_worked
gen mother_never_worked=1 if mother_working_6==0 & mother_working_7==0 & mother_working_8==0 & mother_working_9==0 & mother_working_10==0 & mother_working_11==0 & mother_working_12==0 & mother_working_13==0 & mother_working_14==0 & mother_working_15==0
gen mother_never_matched=1 if mother_merge_6==1 & mother_merge_7==1 & mother_merge_8==1 & mother_merge_9==1 & mother_merge_10==1 & mother_merge_11==1 & mother_merge_12==1& mother_merge_13==1 & mother_merge_14==1 & mother_merge_15==1
replace mother_never_matched=0 if mother_never_matched==.  
replace mother_never_worked=0 if mother_never_worked==. & mother_never_matched==0

gen father_never_worked=1 if father_working_6==0 & father_working_7==0 & father_working_8==0 & father_working_9==0 & father_working_10==0 & father_working_11==0 & father_working_12==0 & father_working_13==0 & father_working_14==0 & father_working_15==0

gen father_never_matched=1 if father_merge_6==1 & father_merge_7==1 & father_merge_8==1 & father_merge_9==1 & father_merge_10==1 & father_merge_11==1 & father_merge_12==1& father_merge_13==1 & father_merge_14==1 & father_merge_15==1  
replace father_never_matched=0 if father_never_matched==.  
replace father_never_worked=0 if father_never_worked==. & father_never_matched==0

 // label variables
label define Never_worked 1 "Never worked " 0 "Worked at least one year"
label values mother_never_worked Never_worked
label values father_never_worked Never_worked
label variable mother_never_worked "Flag for the mothers who have never worked"
label variable father_never_worked "Flag for the father who have never worked"
label variable mother_never_worked "Flag for the mother who have never worked"
label define Job_match 1 "Individual is not in job episode" 0 "Individual is in job episode"
label values mother_never_matched Job_match
label values father_never_matched Job_match
label variable mother_never_matched "Flag for mother is respondent at job episode panel"
label variable father_never_matched "Flag for father is respondent at job episode panel"

 // order variables
order mother_never_worked, before(mother_situation_6)
order mother_never_matched, before(mother_country)
order father_never_worked, before(father_situation_6)
order father_never_matched, before(father_country)

*identify cases where parent_never_matched
gen parent_never_matched=1 if mother_never_matched==1 & father_never_matched==1
replace parent_never_matched=2 if mother_never_matched==1 & father_never_matched!=1
replace parent_never_matched=3 if mother_never_matched!=1 & father_never_matched==1
replace parent_never_matched=0 if mother_never_matched==0 & father_never_matched==0
 
 // label variables 
label variable parent_never_matched "Identification for parent's in job episode"
label define parent_never_matched 0 "Father and mother are in job episode pane" 1 "None of them in job episode panel" 2 "Only father in job episode panel" 3 "Only mother in job episode panel"
label values parent_never_matched parent_never_matched

drop mother_never_matched
drop father_never_matched


*flag the cases where mother's country_res does not fit with father_country_res
gen country_res_key_6=1 if mother_country_res_6!=father_country_res_6 & parent_never_matched==0
gen country_res_key_7=1 if mother_country_res_7!=father_country_res_7 & parent_never_matched==0
gen country_res_key_8=1 if mother_country_res_8!=father_country_res_8 & parent_never_matched==0
gen country_res_key_9=1 if mother_country_res_9!=father_country_res_9 & parent_never_matched==0
gen country_res_key_10=1 if mother_country_res_10!=father_country_res_10 & parent_never_matched==0
gen country_res_key_11=1 if mother_country_res_11!=father_country_res_11 & parent_never_matched==0
gen country_res_key_12=1 if mother_country_res_12!=father_country_res_12 & parent_never_matched==0
gen country_res_key_13=1 if mother_country_res_13!=father_country_res_13 & parent_never_matched==0
gen country_res_key_14=1 if mother_country_res_14!=father_country_res_14 & parent_never_matched==0
gen country_res_key_15=1 if mother_country_res_15!=father_country_res_15 & parent_never_matched==0

replace country_res_key_6=0 if country_res_key_6==. & parent_never_matched==0
replace country_res_key_7=0 if country_res_key_7==. & parent_never_matched==0
replace country_res_key_8=0 if country_res_key_8==. & parent_never_matched==0
replace country_res_key_9=0 if country_res_key_9==. & parent_never_matched==0
replace country_res_key_10=0 if country_res_key_10==. & parent_never_matched==0
replace country_res_key_11=0 if country_res_key_11==. & parent_never_matched==0
replace country_res_key_12=0 if country_res_key_12==. & parent_never_matched==0
replace country_res_key_13=0 if country_res_key_13==. & parent_never_matched==0
replace country_res_key_14=0 if country_res_key_14==. & parent_never_matched==0
replace country_res_key_15=0 if country_res_key_15==. & parent_never_matched==0


*flag the cases where parents' country_res is inconsistent at least once.
gen country_res_key2=1 if country_res_key_6==1 | country_res_key_7==1 | country_res_key_8==1 | country_res_key_9==1 | country_res_key_10==1 | country_res_key_11==1 | country_res_key_12==1 | country_res_key_13==1 | country_res_key_14==1 | country_res_key_15==1
replace country_res_key2=0 if country_res_key2==. & parent_never_matched==0

 // label variables
label variable country_res_key_6 "Inconsistency for mathers' residence & fathers' residence"
label variable country_res_key_7 "Inconsistency for mathers' residence & fathers' residence"
label variable country_res_key_8 "Inconsistency for mathers' residence & fathers' residence"
label variable country_res_key_9 "Inconsistency for mathers' residence & fathers' residence"
label variable country_res_key_10 "Inconsistency for mathers' residence & fathers' residence"
label variable country_res_key_11 "Inconsistency for mathers' residence & fathers' residence"
label variable country_res_key_12 "Inconsistency for mathers' residence & fathers' residence"
label variable country_res_key_13 "Inconsistency for mathers' residence & fathers' residence"
label variable country_res_key_14 "Inconsistency for mathers' residence & fathers' residence"
label variable country_res_key_15 "Inconsistency for mathers' residence & fathers' residence"
label variable country_res_key2 "Inconsistency at least once for mother's residence & father's residence"

label define residence_consistency 0 "Consistent" 1 "Inconsistent"
label values country_res_key_6 residence_consistency
label values country_res_key_7 residence_consistency
label values country_res_key_8 residence_consistency
label values country_res_key_9 residence_consistency
label values country_res_key_10 residence_consistency
label values country_res_key_11 residence_consistency
label values country_res_key_12 residence_consistency
label values country_res_key_13 residence_consistency
label values country_res_key_14 residence_consistency
label values country_res_key_15 residence_consistency
label values country_res_key2 residence_consistency

*flag cases where mother_residence_never_changed
gen mother_residence_never_changed=1 if mother_country_res_6==mother_country_res_7 & mother_country_res_7==mother_country_res_8 & mother_country_res_8==mother_country_res_9 & mother_country_res_9==mother_country_res_10 & mother_country_res_10==mother_country_res_11 & mother_country_res_11==mother_country_res_12 & mother_country_res_12==mother_country_res_13 & mother_country_res_13==mother_country_res_14 & mother_country_res_14==mother_country_res_15 & mother_country_res_6!=. & mother_country_res_7!=. & mother_country_res_8!=. & mother_country_res_9!=. & mother_country_res_10!=. & mother_country_res_11!=. & mother_country_res_12!=. & mother_country_res_13!=. & mother_country_res_14!=. & mother_country_res_15!=.

replace mother_residence_never_changed=0 if mother_residence_never_changed==. & mother_country_res_6!=. & mother_country_res_7!=. & mother_country_res_8!=. & mother_country_res_9!=. & mother_country_res_10!=. & mother_country_res_11!=. & mother_country_res_12!=. & mother_country_res_13!=. & mother_country_res_14!=. & mother_country_res_15!=.

*flag cases father_residence_never_change
gen father_residence_never_changed=1 if father_country_res_6==father_country_res_7 & father_country_res_7==father_country_res_8 & father_country_res_8==father_country_res_9 & father_country_res_9==father_country_res_10 & father_country_res_10==father_country_res_11 & father_country_res_11==father_country_res_12 & father_country_res_12==father_country_res_13 & father_country_res_13==father_country_res_14 & father_country_res_14==father_country_res_15 & father_country_res_6!=. & father_country_res_7!=. & father_country_res_8!=. & father_country_res_9!=. & father_country_res_10!=. & father_country_res_11!=. & father_country_res_12!=. & father_country_res_13!=. & father_country_res_14!=. & father_country_res_15!=.

replace father_residence_never_changed=0 if father_residence_never_changed==. & father_country_res_6!=. & father_country_res_7!=. & father_country_res_8!=. & father_country_res_9!=. & father_country_res_10!=. & father_country_res_11!=. & father_country_res_12!=. & father_country_res_13!=. & father_country_res_14!=. & father_country_res_15!=.

  // label variables and values
label define residence_never_changed 1 "Never changed" 0 "Changed at least once"
label values mother_residence_never_changed residence_never_changed
label values father_residence_never_changed residence_never_changed
label variable mother_residence_never_changed "Mother's country of residence has never changed"
label variable father_residence_never_changed "Father's country of residence has never changed"

* flag the cases where parent_residence_never_changed
gen parent_residence_never_changed=1 if father_residence_never_changed==1 & mother_residence_never_changed==1 & country_res_key2==0

replace parent_residence_never_changed=0 if father_residence_never_changed==0 & parent_never_matched==0
replace parent_residence_never_changed=0 if mother_residence_never_changed==0  & parent_never_matched==0

*--------------------Define maternal and paternal labor income -----------------

***MOTHER
*def exp of maternal income
/*
gen wage_mother_6= exp(mother_w_hat_6)
gen wage_mother_7= exp(mother_w_hat_7)
gen wage_mother_8= exp(mother_w_hat_8)
gen wage_mother_9= exp(mother_w_hat_9)
gen wage_mother_10= exp(mother_w_hat_10)
gen wage_mother_11= exp(mother_w_hat_11)
gen wage_mother_12= exp(mother_w_hat_12)
gen wage_mother_13= exp(mother_w_hat_13)
gen wage_mother_14= exp(mother_w_hat_14)
gen wage_mother_15= exp(mother_w_hat_15)
*/

gen wage_mother_6= mother_w_hat_level_6
gen wage_mother_7= mother_w_hat_level_7
gen wage_mother_8= mother_w_hat_level_8
gen wage_mother_9= mother_w_hat_level_9
gen wage_mother_10= mother_w_hat_level_10
gen wage_mother_11= mother_w_hat_level_11
gen wage_mother_12= mother_w_hat_level_12
gen wage_mother_13= mother_w_hat_level_13
gen wage_mother_14= mother_w_hat_level_14
gen wage_mother_15= mother_w_hat_level_15



*replace obs where mother does not work
replace wage_mother_6=0 if mother_working_6==0
replace wage_mother_7=0 if mother_working_7==0
replace wage_mother_8=0 if mother_working_8==0
replace wage_mother_9=0 if mother_working_9==0
replace wage_mother_10=0 if mother_working_10==0
replace wage_mother_11=0 if mother_working_11==0
replace wage_mother_12=0 if mother_working_12==0
replace wage_mother_13=0 if mother_working_13==0
replace wage_mother_14=0 if mother_working_14==0
replace wage_mother_15=0 if mother_working_15==0


***FATHER
*def exp of paternal income
/*
gen wage_father_6= exp(father_w_hat_6)
gen wage_father_7= exp(father_w_hat_7)
gen wage_father_8= exp(father_w_hat_8)
gen wage_father_9= exp(father_w_hat_9)
gen wage_father_10= exp(father_w_hat_10)
gen wage_father_11= exp(father_w_hat_11)
gen wage_father_12= exp(father_w_hat_12)
gen wage_father_13= exp(father_w_hat_13)
gen wage_father_14= exp(father_w_hat_14)
gen wage_father_15= exp(father_w_hat_15)
*/

gen wage_father_6= father_w_hat_level_6
gen wage_father_7= father_w_hat_level_7
gen wage_father_8= father_w_hat_level_8
gen wage_father_9= father_w_hat_level_9
gen wage_father_10= father_w_hat_level_10
gen wage_father_11= father_w_hat_level_11
gen wage_father_12= father_w_hat_level_12
gen wage_father_13= father_w_hat_level_13
gen wage_father_14= father_w_hat_level_14
gen wage_father_15= father_w_hat_level_15

*replace obs where father does not work
replace wage_father_6=0 if father_working_6==0
replace wage_father_7=0 if father_working_7==0
replace wage_father_8=0 if father_working_8==0
replace wage_father_9=0 if father_working_9==0
replace wage_father_10=0 if father_working_10==0
replace wage_father_11=0 if father_working_11==0
replace wage_father_12=0 if father_working_12==0
replace wage_father_13=0 if father_working_13==0
replace wage_father_14=0 if father_working_14==0
replace wage_father_15=0 if father_working_15==0

*______________________________________________________________________________

**Apply part-time full-time corrections by country and gender

*-----------------------------------MOTHER--------------------------------------

*BELGIUM
replace wage_mother_6=wage_mother_6*0.39 if mother_working_hours_6==2 & mother_country_res_6==56
replace wage_mother_7=wage_mother_7*0.39 if mother_working_hours_7==2 & mother_country_res_7==56
replace wage_mother_8=wage_mother_8*0.39 if mother_working_hours_8==2 & mother_country_res_8==56
replace wage_mother_9=wage_mother_9*0.39 if mother_working_hours_9==2 & mother_country_res_9==56
replace wage_mother_10=wage_mother_10*0.39 if mother_working_hours_10==2 & mother_country_res_10==56
replace wage_mother_11=wage_mother_11*0.39 if mother_working_hours_11==2 & mother_country_res_11==56
replace wage_mother_12=wage_mother_12*0.39 if mother_working_hours_12==2 & mother_country_res_12==56
replace wage_mother_13=wage_mother_13*0.39 if mother_working_hours_13==2 & mother_country_res_13==56
replace wage_mother_14=wage_mother_14*0.39 if mother_working_hours_14==2 & mother_country_res_14==56
replace wage_mother_15=wage_mother_15*0.39 if mother_working_hours_15==2 & mother_country_res_15==56


*DENMARK
replace wage_mother_6=wage_mother_6*0.42 if mother_working_hours_6==2 & mother_country_res_6==208
replace wage_mother_7=wage_mother_7*0.42 if mother_working_hours_7==2 & mother_country_res_7==208
replace wage_mother_8=wage_mother_8*0.42 if mother_working_hours_8==2 & mother_country_res_8==208
replace wage_mother_9=wage_mother_9*0.42 if mother_working_hours_9==2 & mother_country_res_9==208
replace wage_mother_10=wage_mother_10*0.42 if mother_working_hours_10==2 & mother_country_res_10==208
replace wage_mother_11=wage_mother_11*0.42 if mother_working_hours_11==2 & mother_country_res_11==208
replace wage_mother_12=wage_mother_12*0.42 if mother_working_hours_12==2 & mother_country_res_12==208
replace wage_mother_13=wage_mother_13*0.42 if mother_working_hours_13==2 & mother_country_res_13==208
replace wage_mother_14=wage_mother_14*0.42 if mother_working_hours_14==2 & mother_country_res_14==208
replace wage_mother_15=wage_mother_15*0.42 if mother_working_hours_15==2 & mother_country_res_15==208


*IRELAND
replace wage_mother_6=wage_mother_6*0.41 if mother_working_hours_6==2 & mother_country_res_6==372
replace wage_mother_7=wage_mother_7*0.41 if mother_working_hours_7==2 & mother_country_res_7==372
replace wage_mother_8=wage_mother_8*0.41 if mother_working_hours_8==2 & mother_country_res_8==372
replace wage_mother_9=wage_mother_9*0.41 if mother_working_hours_9==2 & mother_country_res_9==372
replace wage_mother_10=wage_mother_10*0.41 if mother_working_hours_10==2 & mother_country_res_10==372
replace wage_mother_11=wage_mother_11*0.41 if mother_working_hours_11==2 & mother_country_res_11==372
replace wage_mother_12=wage_mother_12*0.41 if mother_working_hours_12==2 & mother_country_res_12==372
replace wage_mother_13=wage_mother_13*0.41 if mother_working_hours_13==2 & mother_country_res_13==372
replace wage_mother_14=wage_mother_14*0.41 if mother_working_hours_14==2 & mother_country_res_14==372
replace wage_mother_15=wage_mother_15*0.41 if mother_working_hours_15==2 & mother_country_res_15==372


*GREECE
replace wage_mother_6=wage_mother_6*0.46 if mother_working_hours_6==2 & mother_country_res_6==300
replace wage_mother_7=wage_mother_7*0.46 if mother_working_hours_7==2 & mother_country_res_7==300
replace wage_mother_8=wage_mother_8*0.46 if mother_working_hours_8==2 & mother_country_res_8==300
replace wage_mother_9=wage_mother_9*0.46 if mother_working_hours_9==2 & mother_country_res_9==300
replace wage_mother_10=wage_mother_10*0.46 if mother_working_hours_10==2 & mother_country_res_10==300
replace wage_mother_11=wage_mother_11*0.46 if mother_working_hours_11==2 & mother_country_res_11==300
replace wage_mother_12=wage_mother_12*0.46 if mother_working_hours_12==2 & mother_country_res_12==300
replace wage_mother_13=wage_mother_13*0.46 if mother_working_hours_13==2 & mother_country_res_13==300
replace wage_mother_14=wage_mother_14*0.46 if mother_working_hours_14==2 & mother_country_res_14==300
replace wage_mother_15=wage_mother_15*0.46 if mother_working_hours_15==2 & mother_country_res_15==300


*SPAIN
replace wage_mother_6=wage_mother_6*0.40 if mother_working_hours_6==2 & mother_country_res_6==724
replace wage_mother_7=wage_mother_7*0.40 if mother_working_hours_7==2 & mother_country_res_7==724
replace wage_mother_8=wage_mother_8*0.40 if mother_working_hours_8==2 & mother_country_res_8==724
replace wage_mother_9=wage_mother_9*0.40 if mother_working_hours_9==2 & mother_country_res_9==724
replace wage_mother_10=wage_mother_10*0.40 if mother_working_hours_10==2 & mother_country_res_10==724
replace wage_mother_11=wage_mother_11*0.40 if mother_working_hours_11==2 & mother_country_res_11==724
replace wage_mother_12=wage_mother_12*0.40 if mother_working_hours_12==2 & mother_country_res_12==724
replace wage_mother_13=wage_mother_13*0.40 if mother_working_hours_13==2 & mother_country_res_13==724
replace wage_mother_14=wage_mother_14*0.40 if mother_working_hours_14==2 & mother_country_res_14==724
replace wage_mother_15=wage_mother_15*0.40 if mother_working_hours_15==2 & mother_country_res_15==724


*FRANCE
replace wage_mother_6=wage_mother_6*0.45 if mother_working_hours_6==2 & mother_country_res_6==250
replace wage_mother_7=wage_mother_7*0.45 if mother_working_hours_7==2 & mother_country_res_7==250
replace wage_mother_8=wage_mother_8*0.45 if mother_working_hours_8==2 & mother_country_res_8==250
replace wage_mother_9=wage_mother_9*0.45 if mother_working_hours_9==2 & mother_country_res_9==250
replace wage_mother_10=wage_mother_10*0.45 if mother_working_hours_10==2 & mother_country_res_10==250
replace wage_mother_11=wage_mother_11*0.45 if mother_working_hours_11==2 & mother_country_res_11==250
replace wage_mother_12=wage_mother_12*0.45 if mother_working_hours_12==2 & mother_country_res_12==250
replace wage_mother_13=wage_mother_13*0.45 if mother_working_hours_13==2 & mother_country_res_13==250
replace wage_mother_14=wage_mother_14*0.45 if mother_working_hours_14==2 & mother_country_res_14==250
replace wage_mother_15=wage_mother_15*0.45 if mother_working_hours_15==2 & mother_country_res_15==250


*ITALY
replace wage_mother_6=wage_mother_6*0.49 if mother_working_hours_6==2 & mother_country_res_6==380
replace wage_mother_7=wage_mother_7*0.49 if mother_working_hours_7==2 & mother_country_res_7==380
replace wage_mother_8=wage_mother_8*0.49 if mother_working_hours_8==2 & mother_country_res_8==380
replace wage_mother_9=wage_mother_9*0.49 if mother_working_hours_9==2 & mother_country_res_9==380
replace wage_mother_10=wage_mother_10*0.49 if mother_working_hours_10==2 & mother_country_res_10==380
replace wage_mother_11=wage_mother_11*0.49 if mother_working_hours_11==2 & mother_country_res_11==380
replace wage_mother_12=wage_mother_12*0.49 if mother_working_hours_12==2 & mother_country_res_12==380
replace wage_mother_13=wage_mother_13*0.49 if mother_working_hours_13==2 & mother_country_res_13==380
replace wage_mother_14=wage_mother_14*0.49 if mother_working_hours_14==2 & mother_country_res_14==380
replace wage_mother_15=wage_mother_15*0.49 if mother_working_hours_15==2 & mother_country_res_15==380


*NETHERLANDS
replace wage_mother_6=wage_mother_6*0.35 if mother_working_hours_6==2 & mother_country_res_6==528
replace wage_mother_7=wage_mother_7*0.35 if mother_working_hours_7==2 & mother_country_res_7==528
replace wage_mother_8=wage_mother_8*0.35 if mother_working_hours_8==2 & mother_country_res_8==528
replace wage_mother_9=wage_mother_9*0.35 if mother_working_hours_9==2 & mother_country_res_9==528
replace wage_mother_10=wage_mother_10*0.35 if mother_working_hours_10==2 & mother_country_res_10==528
replace wage_mother_11=wage_mother_11*0.35 if mother_working_hours_11==2 & mother_country_res_11==528
replace wage_mother_12=wage_mother_12*0.35 if mother_working_hours_12==2 & mother_country_res_12==528
replace wage_mother_13=wage_mother_13*0.35 if mother_working_hours_13==2 & mother_country_res_13==528
replace wage_mother_14=wage_mother_14*0.35 if mother_working_hours_14==2 & mother_country_res_14==528
replace wage_mother_15=wage_mother_15*0.35 if mother_working_hours_15==2 & mother_country_res_15==528


*AUSTRIA
replace wage_mother_6=wage_mother_6*0.37 if mother_working_hours_6==2 & mother_country_res_6==40
replace wage_mother_7=wage_mother_7*0.37 if mother_working_hours_7==2 & mother_country_res_7==40
replace wage_mother_8=wage_mother_8*0.37 if mother_working_hours_8==2 & mother_country_res_8==40
replace wage_mother_9=wage_mother_9*0.37 if mother_working_hours_9==2 & mother_country_res_9==40
replace wage_mother_10=wage_mother_10*0.37 if mother_working_hours_10==2 & mother_country_res_10==40
replace wage_mother_11=wage_mother_11*0.37 if mother_working_hours_11==2 & mother_country_res_11==40
replace wage_mother_12=wage_mother_12*0.37 if mother_working_hours_12==2 & mother_country_res_12==40
replace wage_mother_13=wage_mother_13*0.37 if mother_working_hours_13==2 & mother_country_res_13==40
replace wage_mother_14=wage_mother_14*0.37 if mother_working_hours_14==2 & mother_country_res_14==40
replace wage_mother_15=wage_mother_15*0.37 if mother_working_hours_15==2 & mother_country_res_15==40


*PORTUGAL

replace wage_mother_6=wage_mother_6*0.41 if mother_working_hours_6==2 & mother_country_res_6==620
replace wage_mother_7=wage_mother_7*0.41 if mother_working_hours_7==2 & mother_country_res_7==620
replace wage_mother_8=wage_mother_8*0.41 if mother_working_hours_8==2 & mother_country_res_8==620
replace wage_mother_9=wage_mother_9*0.41 if mother_working_hours_9==2 & mother_country_res_9==620
replace wage_mother_10=wage_mother_10*0.41 if mother_working_hours_10==2 & mother_country_res_10==620
replace wage_mother_11=wage_mother_11*0.41 if mother_working_hours_11==2 & mother_country_res_11==620
replace wage_mother_12=wage_mother_12*0.41 if mother_working_hours_12==2 & mother_country_res_12==620
replace wage_mother_13=wage_mother_13*0.41 if mother_working_hours_13==2 & mother_country_res_13==620
replace wage_mother_14=wage_mother_14*0.41 if mother_working_hours_14==2 & mother_country_res_14==620
replace wage_mother_15=wage_mother_15*0.41 if mother_working_hours_15==2 & mother_country_res_15==620


*SWEDEN
replace wage_mother_6=wage_mother_6*0.42 if mother_working_hours_6==2 & mother_country_res_6==752
replace wage_mother_7=wage_mother_7*0.42 if mother_working_hours_7==2 & mother_country_res_7==752
replace wage_mother_8=wage_mother_8*0.42 if mother_working_hours_8==2 & mother_country_res_8==752
replace wage_mother_9=wage_mother_9*0.42 if mother_working_hours_9==2 & mother_country_res_9==752
replace wage_mother_10=wage_mother_10*0.42 if mother_working_hours_10==2 & mother_country_res_10==752
replace wage_mother_11=wage_mother_11*0.42 if mother_working_hours_11==2 & mother_country_res_11==752
replace wage_mother_12=wage_mother_12*0.42 if mother_working_hours_12==2 & mother_country_res_12==752
replace wage_mother_13=wage_mother_13*0.42 if mother_working_hours_13==2 & mother_country_res_13==752
replace wage_mother_14=wage_mother_14*0.42 if mother_working_hours_14==2 & mother_country_res_14==752
replace wage_mother_15=wage_mother_15*0.42 if mother_working_hours_15==2 & mother_country_res_15==752


* SWITZERLAND
replace wage_mother_6=wage_mother_6*0.32 if mother_working_hours_6==2 & mother_country_res_6==756
replace wage_mother_7=wage_mother_7*0.32 if mother_working_hours_7==2 & mother_country_res_7==756
replace wage_mother_8=wage_mother_8*0.32 if mother_working_hours_8==2 & mother_country_res_8==756
replace wage_mother_9=wage_mother_9*0.32 if mother_working_hours_9==2 & mother_country_res_9==756
replace wage_mother_10=wage_mother_10*0.32 if mother_working_hours_10==2 & mother_country_res_10==756
replace wage_mother_11=wage_mother_11*0.32 if mother_working_hours_11==2 & mother_country_res_11==756
replace wage_mother_12=wage_mother_12*0.32 if mother_working_hours_12==2 & mother_country_res_12==756
replace wage_mother_13=wage_mother_13*0.32 if mother_working_hours_13==2 & mother_country_res_13==756
replace wage_mother_14=wage_mother_14*0.32 if mother_working_hours_14==2 & mother_country_res_14==756
replace wage_mother_15=wage_mother_15*0.32 if mother_working_hours_15==2 & mother_country_res_15==756


*LUXEMBOURG
replace wage_mother_6=wage_mother_6*0.41 if mother_working_hours_6==2 & mother_country_res_6==442
replace wage_mother_7=wage_mother_7*0.41 if mother_working_hours_7==2 & mother_country_res_7==442
replace wage_mother_8=wage_mother_8*0.41 if mother_working_hours_8==2 & mother_country_res_8==442
replace wage_mother_9=wage_mother_9*0.41 if mother_working_hours_9==2 & mother_country_res_9==442
replace wage_mother_10=wage_mother_10*0.41 if mother_working_hours_10==2 & mother_country_res_10==442
replace wage_mother_11=wage_mother_11*0.41 if mother_working_hours_11==2 & mother_country_res_11==442
replace wage_mother_12=wage_mother_12*0.41 if mother_working_hours_12==2 & mother_country_res_12==442
replace wage_mother_13=wage_mother_13*0.41 if mother_working_hours_13==2 & mother_country_res_13==442
replace wage_mother_14=wage_mother_14*0.41 if mother_working_hours_14==2 & mother_country_res_14==442
replace wage_mother_15=wage_mother_15*0.41 if mother_working_hours_15==2 & mother_country_res_15==442


*GERMANY1
replace wage_mother_6=wage_mother_6*0.33 if mother_working_hours_6==2 & mother_country_res_6==276
replace wage_mother_7=wage_mother_7*0.33 if mother_working_hours_7==2 & mother_country_res_7==276
replace wage_mother_8=wage_mother_8*0.33 if mother_working_hours_8==2 & mother_country_res_8==276
replace wage_mother_9=wage_mother_9*0.33 if mother_working_hours_9==2 & mother_country_res_9==276
replace wage_mother_10=wage_mother_10*0.33 if mother_working_hours_10==2 & mother_country_res_10==276
replace wage_mother_11=wage_mother_11*0.33 if mother_working_hours_11==2 & mother_country_res_11==276
replace wage_mother_12=wage_mother_12*0.33 if mother_working_hours_12==2 & mother_country_res_12==276
replace wage_mother_13=wage_mother_13*0.33 if mother_working_hours_13==2 & mother_country_res_13==276
replace wage_mother_14=wage_mother_14*0.33 if mother_working_hours_14==2 & mother_country_res_14==276
replace wage_mother_15=wage_mother_15*0.33 if mother_working_hours_15==2 & mother_country_res_15==276


*GERMANY2
replace wage_mother_6=wage_mother_6*0.33 if mother_working_hours_6==2 & mother_country_res_6==278
replace wage_mother_7=wage_mother_7*0.33 if mother_working_hours_7==2 & mother_country_res_7==278
replace wage_mother_8=wage_mother_8*0.33 if mother_working_hours_8==2 & mother_country_res_8==278
replace wage_mother_9=wage_mother_9*0.33 if mother_working_hours_9==2 & mother_country_res_9==278
replace wage_mother_10=wage_mother_10*0.33 if mother_working_hours_10==2 & mother_country_res_10==278
replace wage_mother_11=wage_mother_11*0.33 if mother_working_hours_11==2 & mother_country_res_11==278
replace wage_mother_12=wage_mother_12*0.33 if mother_working_hours_12==2 & mother_country_res_12==278
replace wage_mother_13=wage_mother_13*0.33 if mother_working_hours_13==2 & mother_country_res_13==278
replace wage_mother_14=wage_mother_14*0.33 if mother_working_hours_14==2 & mother_country_res_14==278
replace wage_mother_15=wage_mother_15*0.33 if mother_working_hours_15==2 & mother_country_res_15==278


*GERMANY3
replace wage_mother_6=wage_mother_6*0.33 if mother_working_hours_6==2 & mother_country_res_6==280
replace wage_mother_7=wage_mother_7*0.33 if mother_working_hours_7==2 & mother_country_res_7==280
replace wage_mother_8=wage_mother_8*0.33 if mother_working_hours_8==2 & mother_country_res_8==280
replace wage_mother_9=wage_mother_9*0.33 if mother_working_hours_9==2 & mother_country_res_9==280
replace wage_mother_10=wage_mother_10*0.33 if mother_working_hours_10==2 & mother_country_res_10==280
replace wage_mother_11=wage_mother_11*0.33 if mother_working_hours_11==2 & mother_country_res_11==280
replace wage_mother_12=wage_mother_12*0.33 if mother_working_hours_12==2 & mother_country_res_12==280
replace wage_mother_13=wage_mother_13*0.33 if mother_working_hours_13==2 & mother_country_res_13==280
replace wage_mother_14=wage_mother_14*0.33 if mother_working_hours_14==2 & mother_country_res_14==280
replace wage_mother_15=wage_mother_15*0.33 if mother_working_hours_15==2 & mother_country_res_15==280

*-----------------------------------FATHER--------------------------------------


*BELGIUM
replace wage_father_6=wage_father_6*0.33 if father_working_hours_6==2 & father_country_res_6==56
replace wage_father_7=wage_father_7*0.33 if father_working_hours_7==2 & father_country_res_7==56
replace wage_father_8=wage_father_8*0.33 if father_working_hours_8==2 & father_country_res_8==56
replace wage_father_9=wage_father_9*0.33 if father_working_hours_9==2 & father_country_res_9==56
replace wage_father_10=wage_father_10*0.33 if father_working_hours_10==2 & father_country_res_10==56
replace wage_father_11=wage_father_11*0.33 if father_working_hours_11==2 & father_country_res_11==56
replace wage_father_12=wage_father_12*0.33 if father_working_hours_12==2 & father_country_res_12==56
replace wage_father_13=wage_father_13*0.33 if father_working_hours_13==2 & father_country_res_13==56
replace wage_father_14=wage_father_14*0.33 if father_working_hours_14==2 & father_country_res_14==56
replace wage_father_15=wage_father_15*0.33 if father_working_hours_15==2 & father_country_res_15==56


*DENMARK
replace wage_father_6=wage_father_6*0.33 if father_working_hours_6==2 & father_country_res_6==208
replace wage_father_7=wage_father_7*0.33 if father_working_hours_7==2 & father_country_res_7==208
replace wage_father_8=wage_father_8*0.33 if father_working_hours_8==2 & father_country_res_8==208
replace wage_father_9=wage_father_9*0.33 if father_working_hours_9==2 & father_country_res_9==208
replace wage_father_10=wage_father_10*0.33 if father_working_hours_10==2 & father_country_res_10==208
replace wage_father_11=wage_father_11*0.33 if father_working_hours_11==2 & father_country_res_11==208
replace wage_father_12=wage_father_12*0.33 if father_working_hours_12==2 & father_country_res_12==208
replace wage_father_13=wage_father_13*0.33 if father_working_hours_13==2 & father_country_res_13==208
replace wage_father_14=wage_father_14*0.33 if father_working_hours_14==2 & father_country_res_14==208
replace wage_father_15=wage_father_15*0.33 if father_working_hours_15==2 & father_country_res_15==208


*IRELAND
replace wage_father_6=wage_father_6*0.41 if father_working_hours_6==2 & father_country_res_6==372
replace wage_father_7=wage_father_7*0.41 if father_working_hours_7==2 & father_country_res_7==372
replace wage_father_8=wage_father_8*0.41 if father_working_hours_8==2 & father_country_res_8==372
replace wage_father_9=wage_father_9*0.41 if father_working_hours_9==2 & father_country_res_9==372
replace wage_father_10=wage_father_10*0.41 if father_working_hours_10==2 & father_country_res_10==372
replace wage_father_11=wage_father_11*0.41 if father_working_hours_11==2 & father_country_res_11==372
replace wage_father_12=wage_father_12*0.41 if father_working_hours_12==2 & father_country_res_12==372
replace wage_father_13=wage_father_13*0.41 if father_working_hours_13==2 & father_country_res_13==372
replace wage_father_14=wage_father_14*0.41 if father_working_hours_14==2 & father_country_res_14==372
replace wage_father_15=wage_father_15*0.41 if father_working_hours_15==2 & father_country_res_15==372


*GREECE
replace wage_father_6=wage_father_6*0.44 if father_working_hours_6==2 & father_country_res_6==300
replace wage_father_7=wage_father_7*0.44 if father_working_hours_7==2 & father_country_res_7==300
replace wage_father_8=wage_father_8*0.44 if father_working_hours_8==2 & father_country_res_8==300
replace wage_father_9=wage_father_9*0.44 if father_working_hours_9==2 & father_country_res_9==300
replace wage_father_10=wage_father_10*0.44 if father_working_hours_10==2 & father_country_res_10==300
replace wage_father_11=wage_father_11*0.44 if father_working_hours_11==2 & father_country_res_11==300
replace wage_father_12=wage_father_12*0.44 if father_working_hours_12==2 & father_country_res_12==300
replace wage_father_13=wage_father_13*0.44 if father_working_hours_13==2 & father_country_res_13==300
replace wage_father_14=wage_father_14*0.44 if father_working_hours_14==2 & father_country_res_14==300
replace wage_father_15=wage_father_15*0.44 if father_working_hours_15==2 & father_country_res_15==300


*SPAIN
replace wage_father_6=wage_father_6*0.39 if father_working_hours_6==2 & father_country_res_6==724
replace wage_father_7=wage_father_7*0.39 if father_working_hours_7==2 & father_country_res_7==724
replace wage_father_8=wage_father_8*0.39 if father_working_hours_8==2 & father_country_res_8==724
replace wage_father_9=wage_father_9*0.39 if father_working_hours_9==2 & father_country_res_9==724
replace wage_father_10=wage_father_10*0.39 if father_working_hours_10==2 & father_country_res_10==724
replace wage_father_11=wage_father_11*0.39 if father_working_hours_11==2 & father_country_res_11==724
replace wage_father_12=wage_father_12*0.39 if father_working_hours_12==2 & father_country_res_12==724
replace wage_father_13=wage_father_13*0.39 if father_working_hours_13==2 & father_country_res_13==724
replace wage_father_14=wage_father_14*0.39 if father_working_hours_14==2 & father_country_res_14==724
replace wage_father_15=wage_father_15*0.39 if father_working_hours_15==2 & father_country_res_15==724


*FRANCE
replace wage_father_6=wage_father_6*0.42 if father_working_hours_6==2 & father_country_res_6==250
replace wage_father_7=wage_father_7*0.42 if father_working_hours_7==2 & father_country_res_7==250
replace wage_father_8=wage_father_8*0.42 if father_working_hours_8==2 & father_country_res_8==250
replace wage_father_9=wage_father_9*0.42 if father_working_hours_9==2 & father_country_res_9==250
replace wage_father_10=wage_father_10*0.42 if father_working_hours_10==2 & father_country_res_10==250
replace wage_father_11=wage_father_11*0.42 if father_working_hours_11==2 & father_country_res_11==250
replace wage_father_12=wage_father_12*0.42 if father_working_hours_12==2 & father_country_res_12==250
replace wage_father_13=wage_father_13*0.42 if father_working_hours_13==2 & father_country_res_13==250
replace wage_father_14=wage_father_14*0.42 if father_working_hours_14==2 & father_country_res_14==250
replace wage_father_15=wage_father_15*0.42 if father_working_hours_15==2 & father_country_res_15==250


*ITALY
replace wage_father_6=wage_father_6*0.50 if father_working_hours_6==2 & father_country_res_6==380
replace wage_father_7=wage_father_7*0.50 if father_working_hours_7==2 & father_country_res_7==380
replace wage_father_8=wage_father_8*0.50 if father_working_hours_8==2 & father_country_res_8==380
replace wage_father_9=wage_father_9*0.50 if father_working_hours_9==2 & father_country_res_9==380
replace wage_father_10=wage_father_10*0.50 if father_working_hours_10==2 & father_country_res_10==380
replace wage_father_11=wage_father_11*0.50 if father_working_hours_11==2 & father_country_res_11==380
replace wage_father_12=wage_father_12*0.50 if father_working_hours_12==2 & father_country_res_12==380
replace wage_father_13=wage_father_13*0.50 if father_working_hours_13==2 & father_country_res_13==380
replace wage_father_14=wage_father_14*0.50 if father_working_hours_14==2 & father_country_res_14==380
replace wage_father_15=wage_father_15*0.50 if father_working_hours_15==2 & father_country_res_15==380


*NETHERLANDS
replace wage_father_6=wage_father_6*0.34 if father_working_hours_6==2 & father_country_res_6==528
replace wage_father_7=wage_father_7*0.34 if father_working_hours_7==2 & father_country_res_7==528
replace wage_father_8=wage_father_8*0.34 if father_working_hours_8==2 & father_country_res_8==528
replace wage_father_9=wage_father_9*0.34 if father_working_hours_9==2 & father_country_res_9==528
replace wage_father_10=wage_father_10*0.34 if father_working_hours_10==2 & father_country_res_10==528
replace wage_father_11=wage_father_11*0.34 if father_working_hours_11==2 & father_country_res_11==528
replace wage_father_12=wage_father_12*0.34 if father_working_hours_12==2 & father_country_res_12==528
replace wage_father_13=wage_father_13*0.34 if father_working_hours_13==2 & father_country_res_13==528
replace wage_father_14=wage_father_14*0.34 if father_working_hours_14==2 & father_country_res_14==528
replace wage_father_15=wage_father_15*0.34 if father_working_hours_15==2 & father_country_res_15==528


*AUSTRIA
replace wage_father_6=wage_father_6*0.35 if father_working_hours_6==2 & father_country_res_6==40
replace wage_father_7=wage_father_7*0.35 if father_working_hours_7==2 & father_country_res_7==40
replace wage_father_8=wage_father_8*0.35 if father_working_hours_8==2 & father_country_res_8==40
replace wage_father_9=wage_father_9*0.35 if father_working_hours_9==2 & father_country_res_9==40
replace wage_father_10=wage_father_10*0.35 if father_working_hours_10==2 & father_country_res_10==40
replace wage_father_11=wage_father_11*0.35 if father_working_hours_11==2 & father_country_res_11==40
replace wage_father_12=wage_father_12*0.35 if father_working_hours_12==2 & father_country_res_12==40
replace wage_father_13=wage_father_13*0.35 if father_working_hours_13==2 & father_country_res_13==40
replace wage_father_14=wage_father_14*0.35 if father_working_hours_14==2 & father_country_res_14==40
replace wage_father_15=wage_father_15*0.35 if father_working_hours_15==2 & father_country_res_15==40


*PORTUGAL

replace wage_father_6=wage_father_6*0.42 if father_working_hours_6==2 & father_country_res_6==620
replace wage_father_7=wage_father_7*0.42 if father_working_hours_7==2 & father_country_res_7==620
replace wage_father_8=wage_father_8*0.42 if father_working_hours_8==2 & father_country_res_8==620
replace wage_father_9=wage_father_9*0.42 if father_working_hours_9==2 & father_country_res_9==620
replace wage_father_10=wage_father_10*0.42 if father_working_hours_10==2 & father_country_res_10==620
replace wage_father_11=wage_father_11*0.42 if father_working_hours_11==2 & father_country_res_11==620
replace wage_father_12=wage_father_12*0.42 if father_working_hours_12==2 & father_country_res_12==620
replace wage_father_13=wage_father_13*0.42 if father_working_hours_13==2 & father_country_res_13==620
replace wage_father_14=wage_father_14*0.42 if father_working_hours_14==2 & father_country_res_14==620
replace wage_father_15=wage_father_15*0.42 if father_working_hours_15==2 & father_country_res_15==620


*SWEDEN
replace wage_father_6=wage_father_6*0.36 if father_working_hours_6==2 & father_country_res_6==752
replace wage_father_7=wage_father_7*0.36 if father_working_hours_7==2 & father_country_res_7==752
replace wage_father_8=wage_father_8*0.36 if father_working_hours_8==2 & father_country_res_8==752
replace wage_father_9=wage_father_9*0.36 if father_working_hours_9==2 & father_country_res_9==752
replace wage_father_10=wage_father_10*0.36 if father_working_hours_10==2 & father_country_res_10==752
replace wage_father_11=wage_father_11*0.36 if father_working_hours_11==2 & father_country_res_11==752
replace wage_father_12=wage_father_12*0.36 if father_working_hours_12==2 & father_country_res_12==752
replace wage_father_13=wage_father_13*0.36 if father_working_hours_13==2 & father_country_res_13==752
replace wage_father_14=wage_father_14*0.36 if father_working_hours_14==2 & father_country_res_14==752
replace wage_father_15=wage_father_15*0.36 if father_working_hours_15==2 & father_country_res_15==752


*SWITZERLAND
replace wage_father_6=wage_father_6*0.35 if father_working_hours_6==2 & father_country_res_6==756
replace wage_father_7=wage_father_7*0.35 if father_working_hours_7==2 & father_country_res_7==756
replace wage_father_8=wage_father_8*0.35 if father_working_hours_8==2 & father_country_res_8==756
replace wage_father_9=wage_father_9*0.35 if father_working_hours_9==2 & father_country_res_9==756
replace wage_father_10=wage_father_10*0.35 if father_working_hours_10==2 & father_country_res_10==756
replace wage_father_11=wage_father_11*0.35 if father_working_hours_11==2 & father_country_res_11==756
replace wage_father_12=wage_father_12*0.35 if father_working_hours_12==2 & father_country_res_12==756
replace wage_father_13=wage_father_13*0.35 if father_working_hours_13==2 & father_country_res_13==756
replace wage_father_14=wage_father_14*0.35 if father_working_hours_14==2 & father_country_res_14==756
replace wage_father_15=wage_father_15*0.35 if father_working_hours_15==2 & father_country_res_15==756



*LUXEMBOURG
replace wage_father_6=wage_father_6*0.40 if father_working_hours_6==2 & father_country_res_6==442
replace wage_father_7=wage_father_7*0.40 if father_working_hours_7==2 & father_country_res_7==442
replace wage_father_8=wage_father_8*0.40 if father_working_hours_8==2 & father_country_res_8==442
replace wage_father_9=wage_father_9*0.40 if father_working_hours_9==2 & father_country_res_9==442
replace wage_father_10=wage_father_10*0.40 if father_working_hours_10==2 & father_country_res_10==442
replace wage_father_11=wage_father_11*0.40 if father_working_hours_11==2 & father_country_res_11==442
replace wage_father_12=wage_father_12*0.40 if father_working_hours_12==2 & father_country_res_12==442
replace wage_father_13=wage_father_13*0.40 if father_working_hours_13==2 & father_country_res_13==442
replace wage_father_14=wage_father_14*0.40 if father_working_hours_14==2 & father_country_res_14==442
replace wage_father_15=wage_father_15*0.40 if father_working_hours_15==2 & father_country_res_15==442


*GERMANY1
replace wage_father_6=wage_father_6*0.31 if father_working_hours_6==2 & father_country_res_6==276
replace wage_father_7=wage_father_7*0.31 if father_working_hours_7==2 & father_country_res_7==276
replace wage_father_8=wage_father_8*0.31 if father_working_hours_8==2 & father_country_res_8==276
replace wage_father_9=wage_father_9*0.31 if father_working_hours_9==2 & father_country_res_9==276
replace wage_father_10=wage_father_10*0.31 if father_working_hours_10==2 & father_country_res_10==276
replace wage_father_11=wage_father_11*0.31 if father_working_hours_11==2 & father_country_res_11==276
replace wage_father_12=wage_father_12*0.31 if father_working_hours_12==2 & father_country_res_12==276
replace wage_father_13=wage_father_13*0.31 if father_working_hours_13==2 & father_country_res_13==276
replace wage_father_14=wage_father_14*0.31 if father_working_hours_14==2 & father_country_res_14==276
replace wage_father_15=wage_father_15*0.31 if father_working_hours_15==2 & father_country_res_15==276


*GERMANY2
replace wage_father_6=wage_father_6*0.31 if father_working_hours_6==2 & father_country_res_6==278
replace wage_father_7=wage_father_7*0.31 if father_working_hours_7==2 & father_country_res_7==278
replace wage_father_8=wage_father_8*0.31 if father_working_hours_8==2 & father_country_res_8==278
replace wage_father_9=wage_father_9*0.31 if father_working_hours_9==2 & father_country_res_9==278
replace wage_father_10=wage_father_10*0.31 if father_working_hours_10==2 & father_country_res_10==278
replace wage_father_11=wage_father_11*0.31 if father_working_hours_11==2 & father_country_res_11==278
replace wage_father_12=wage_father_12*0.31 if father_working_hours_12==2 & father_country_res_12==278
replace wage_father_13=wage_father_13*0.31 if father_working_hours_13==2 & father_country_res_13==278
replace wage_father_14=wage_father_14*0.31 if father_working_hours_14==2 & father_country_res_14==278
replace wage_father_15=wage_father_15*0.31 if father_working_hours_15==2 & father_country_res_15==278



*GERMANY3
replace wage_father_6=wage_father_6*0.31 if father_working_hours_6==2 & father_country_res_6==280
replace wage_father_7=wage_father_7*0.31 if father_working_hours_7==2 & father_country_res_7==280
replace wage_father_8=wage_father_8*0.31 if father_working_hours_8==2 & father_country_res_8==280
replace wage_father_9=wage_father_9*0.31 if father_working_hours_9==2 & father_country_res_9==280
replace wage_father_10=wage_father_10*0.31 if father_working_hours_10==2 & father_country_res_10==280
replace wage_father_11=wage_father_11*0.31 if father_working_hours_11==2 & father_country_res_11==280
replace wage_father_12=wage_father_12*0.31 if father_working_hours_12==2 & father_country_res_12==280
replace wage_father_13=wage_father_13*0.31 if father_working_hours_13==2 & father_country_res_13==280
replace wage_father_14=wage_father_14*0.31 if father_working_hours_14==2 & father_country_res_14==280
replace wage_father_15=wage_father_15*0.31 if father_working_hours_15==2 & father_country_res_15==280

*_______________________________________________________________________________

*Identify cases where we can impute maternal and paternal income for each year where child is ages of 6-15 

gen mother_waves_attend=""
replace mother_waves_attend="6-15" if mother_residence_never_changed!=.

gen father_waves_attend=""
replace father_waves_attend="6-15" if father_residence_never_changed!=.

order father_residence_never_changed, before (father_country_res_6)
order father_waves_attend, before (father_country_res_6)

gen use_wave=""
replace use_wave="6-15" if parent_residence_never_changed==1 & country_res_key2==0
*tab x if  country_res_key2==0 & parent_residence_never_changed==0 & parent_never_matched==0
*765 obs

*replace country_codes for germany ( Country of residences different for east and west germany and after transition)
replace mother_country_res_6=276 if mother_country_res_6==280 | mother_country_res_6==278
replace mother_country_res_7=276 if mother_country_res_7==280 | mother_country_res_7==278
replace mother_country_res_8=276 if mother_country_res_8==280 | mother_country_res_8==278
replace mother_country_res_9=276 if mother_country_res_9==280 | mother_country_res_9==278
replace mother_country_res_10=276 if mother_country_res_10==280 | mother_country_res_10==278
replace mother_country_res_11=276 if mother_country_res_11==280 | mother_country_res_11==278
replace mother_country_res_12=276 if mother_country_res_12==280 | mother_country_res_12==278
replace mother_country_res_13=276 if mother_country_res_13==280 | mother_country_res_13==278
replace mother_country_res_14=276 if mother_country_res_14==280 | mother_country_res_14==278
replace mother_country_res_15=276 if mother_country_res_15==280 | mother_country_res_15==278
 
replace father_country_res_6=276 if father_country_res_6==280 | father_country_res_6==278
replace father_country_res_7=276 if father_country_res_7==280 | father_country_res_7==278
replace father_country_res_8=276 if father_country_res_8==280 | father_country_res_8==278
replace father_country_res_9=276 if father_country_res_9==280 | father_country_res_9==278
replace father_country_res_10=276 if father_country_res_10==280 | father_country_res_10==278
replace father_country_res_11=276 if father_country_res_11==280 | father_country_res_11==278
replace father_country_res_12=276 if father_country_res_12==280 | father_country_res_12==278
replace father_country_res_13=276 if father_country_res_13==280 | father_country_res_13==278
replace father_country_res_14=276 if father_country_res_14==280 | father_country_res_14==278
replace father_country_res_15=276 if father_country_res_15==280 | father_country_res_15==278

replace mother_residence_never_changed=1 if mother_country_res_6==mother_country_res_7 & mother_country_res_7==mother_country_res_8 & mother_country_res_8==mother_country_res_9 & mother_country_res_9==mother_country_res_10 & mother_country_res_10==mother_country_res_11 & mother_country_res_11==mother_country_res_12 & mother_country_res_12==mother_country_res_13 & mother_country_res_13==mother_country_res_14 & mother_country_res_14==mother_country_res_15 & mother_country_res_6!=. & mother_country_res_7!=. & mother_country_res_8!=. & mother_country_res_9!=. & mother_country_res_10!=. & mother_country_res_11!=. & mother_country_res_12!=. & mother_country_res_13!=. & mother_country_res_14!=. & mother_country_res_15!=. & mother_country_res_6==276

replace father_residence_never_changed=1 if father_country_res_6==father_country_res_7 & father_country_res_7==father_country_res_8 & father_country_res_8==father_country_res_9 & father_country_res_9==father_country_res_10 & father_country_res_10==father_country_res_11 & father_country_res_11==father_country_res_12 & father_country_res_12==father_country_res_13 & father_country_res_13==father_country_res_14 & father_country_res_14==father_country_res_15 & father_country_res_6!=. & father_country_res_7!=. & father_country_res_8!=. & father_country_res_9!=. & father_country_res_10!=. & father_country_res_11!=. & father_country_res_12!=. & father_country_res_13!=. & father_country_res_14!=. & father_country_res_15!=. & father_country_res_6==276

 gen german=1 if  country_res_key2==0 & parent_residence_never_changed==0 & parent_never_matched==0 & mother_country_res_6==276 & father_residence_never_changed==1 & mother_residence_never_changed==1 & mother_country_res_6==father_country_res_6
 
replace parent_residence_never_changed=1 if german==1
replace use_wave="6-15" if german==1
replace use_wave="6-15" if use_wave=="" & parent_never_matched==0 & mother_residence_never_changed==1 & father_residence_never_changed==1 & mother_country_res_6==father_country_res_6
replace parent_residence_never_changed=1 if use_wave=="6-15" & parent_res==0

* define number of years we can observe parental income
gen number_years=10 if use_wave=="6-15"
label variable number_years "Number of years that we use for wage calculation, based on use_wave"

* define parents' total_wage_income in 10 years
gen total_wage_mother= (wage_mother_6+wage_mother_7+ wage_mother_8+wage_mother_9+wage_mother_10+wage_mother_11+wage_mother_12+wage_mother_13+wage_mother_14+wage_mother_15)*12 if use_wave=="6-15"
gen total_wage_father= (wage_father_6+wage_father_7+ wage_father_8+wage_father_9+wage_father_10+wage_father_11+wage_father_12+wage_father_13+wage_father_14+wage_father_15)*12 if use_wave=="6-15"

* flag the observations where parents are self-employed
gen mother_self_employed=1 if mother_job_title_6==3 | mother_job_title_7==3 | mother_job_title_8==3 | mother_job_title_9==3 | mother_job_title_10==3 | mother_job_title_11==3 | mother_job_title_12==3 | mother_job_title_13==3 | mother_job_title_14==3 | mother_job_title_14==3 
replace mother_self_employed=0 if mother_self_employed==.

gen father_self_employed=1 if father_job_title_6==3 | father_job_title_7==3 | father_job_title_8==3 | father_job_title_9==3 | father_job_title_10==3 | father_job_title_11==3 | father_job_title_12==3 | father_job_title_13==3 | father_job_title_14==3 | father_job_title_14==3 
replace father_self_employed=0 if father_self_employed==.

  // label variables
label define Self_employed 0 "No" 1 "YES"
label values mother_self_employed Self_employed
label values father_self_employed Self_employed
label variable mother_self_employed "Mother is self employed at least once"
label variable father_self_employed "Father is self employed at least once"


*parents  residence never_change in below obs
gen wage_residence=mother_country_res_6 if use_wave=="6-15" 
*assert mother_country_res_6==father_country_res_6 if wage_residence!=.

   // label variables
label values wage_residence country_res_lbl
label variable wage_residence "Country of residence where the wage info was derived"

// rename main variables
rename child_gender gender
rename child_year_birth year_birth

// drop intermediate variable
drop german

// label variables
label var parent_residence_never_changed "Country of residence has never changed for parents"
label var total_wage_mother "Mother's total wage, based on median years of education (period=use_wave)"
label var total_wage_father "Father's total wage, based on median years of education (period=use_wave)"
label var wage_mother_6 "Mother's monthly wage, child's ages of 6"
label var wage_mother_7 "Mother's monthly wage, child's ages of 7"
label var wage_mother_8 "Mother's monthly wage, child's ages of 8"
label var wage_mother_9 "Mother's monthly wage, child's ages of 9"
label var wage_mother_10 "Mother's monthly wage, child's ages of 10"
label var wage_mother_11 "Mother's monthly wage, child's ages of 11"
label var wage_mother_12 "Mother's monthly wage, child's ages of 12"
label var wage_mother_13 "Mother's monthly wage, child's ages of 13"
label var wage_mother_14 "Mother's monthly wage, child's ages of 14"
label var wage_mother_15 "Mother's monthly wage, child's ages of 15"

label var wage_father_6 "Father's monthly wage, child's ages of 6"
label var wage_father_7 "Father's monthly wage, child's ages of 7"
label var wage_father_8 "Father's monthly wage, child's ages of 8"
label var wage_father_9 "Father's monthly wage, child's ages of 9"
label var wage_father_10 "Father's monthly wage, child's ages of 10"
label var wage_father_11 "Father's monthly wage, child's ages of 11"
label var wage_father_12 "Father's monthly wage, child's ages of 12"
label var wage_father_13 "Father's monthly wage, child's ages of 13"
label var wage_father_14 "Father's monthly wage, child's ages of 14"
label var wage_father_15 "Father's monthly wage, child's ages of 15"
label var use_wave "ages of child used for total wage imputation"


*define maternal and paternal income separately (in euro)

*maternal income
gen mother_wage_euro=(total_wage_mother)/13.7603 if wage_residence==40 
replace mother_wage_euro=(total_wage_mother)/40.3399 if wage_residence==56 
replace mother_wage_euro=(total_wage_mother)/7.4473 if wage_residence==208 
replace mother_wage_euro=(total_wage_mother)/6.55957 if wage_residence==250 
replace mother_wage_euro=(total_wage_mother)/1.95583 if wage_residence==276 
replace mother_wage_euro=(total_wage_mother)/340.75 if wage_residence==300 
replace mother_wage_euro=(total_wage_mother)/0.787564 if wage_residence==372 
replace mother_wage_euro=(total_wage_mother)/1936.27 if wage_residence==380 
replace mother_wage_euro=(total_wage_mother)/40.3399 if wage_residence==442 
replace mother_wage_euro=(total_wage_mother)/2.20371 if wage_residence==528 
replace mother_wage_euro=(total_wage_mother)/200.482 if wage_residence==620 
replace mother_wage_euro=(total_wage_mother)/166.386 if wage_residence==724 
replace mother_wage_euro=(total_wage_mother)/9.5373 if wage_residence==752 
replace mother_wage_euro=(total_wage_mother)/1.3803 if wage_residence==756 
label var mother_wage_euro "change total_mother_wage to euro"

gen ln_mother_wage_euro=ln(mother_wage_euro+1) 
label var ln_mother_wage_euro "ln(mother_wage_euro+1)"

*paternal income
gen father_wage_euro=(total_wage_father)/13.7603 if wage_residence==40 
replace father_wage_euro=(total_wage_father)/40.3399 if wage_residence==56 
replace father_wage_euro=(total_wage_father)/7.4473 if wage_residence==208 
replace father_wage_euro=(total_wage_father)/6.55957 if wage_residence==250 
replace father_wage_euro=(total_wage_father)/1.95583 if wage_residence==276 
replace father_wage_euro=(total_wage_father)/340.75 if wage_residence==300 
replace father_wage_euro=(total_wage_father)/0.787564 if wage_residence==372 
replace father_wage_euro=(total_wage_father)/1936.27 if wage_residence==380 
replace father_wage_euro=(total_wage_father)/40.3399 if wage_residence==442 
replace father_wage_euro=(total_wage_father)/2.20371 if wage_residence==528 
replace father_wage_euro=(total_wage_father)/200.482 if wage_residence==620 
replace father_wage_euro=(total_wage_father)/166.386 if wage_residence==724 
replace father_wage_euro=(total_wage_father)/9.5373 if wage_residence==752 
replace father_wage_euro=(total_wage_father)/1.3803 if wage_residence==756 
label var father_wage_euro "change total_father_wage to euro"

gen ln_father_wage_euro=ln(father_wage_euro+1) 
label var ln_father_wage_euro "ln(father_wage_euro+1)"


* define mother's and father's working intensity

merge m:1 wage_residence using "part_time_correction_rates.dta", keepusing(country_name m_parttime_correction f_parttime_correction)

drop if _merge==2
drop _merge
drop country_name

destring f_parttime_correction, replace
destring m_parttime_correction, replace

local code 6 7 8 9 10 11 12 13 14 15
foreach m of local code {
gen mother_lfs_`m'=1 if mother_working_`m'==1
replace mother_lfs_`m'=0 if mother_working_`m'==0
replace mother_lfs_`m'=mother_lfs_`m'*m_parttime_correction if mother_working_hours_`m'==2
}

gen mother_lfs_total= mother_lfs_6 + mother_lfs_7 + mother_lfs_8 + mother_lfs_9 + mother_lfs_10 + mother_lfs_11 + mother_lfs_12 + mother_lfs_13 + mother_lfs_14 + mother_lfs_15

local code_2 6 7 8 9 10 11 12 13 14 15
foreach m of local code_2 {
gen father_lfs_`m'=1 if father_working_`m'==1
replace father_lfs_`m'=0 if father_working_`m'==0
replace father_lfs_`m'=father_lfs_`m'*f_parttime_correction if father_working_hours_`m'==2
}

gen father_lfs_total= father_lfs_6 + father_lfs_7 + father_lfs_8 + father_lfs_9 + father_lfs_10 + father_lfs_11 + father_lfs_12 + father_lfs_13 + father_lfs_14 + father_lfs_15

 // label variables
label variable father_lfs_total "Father's working intensity-total"
label variable mother_lfs_total "Mother's working intensity-total"
label var mother_lfs_6 "Mother's working intensity when child ages of 6"
label var mother_lfs_7 "Mother's working intensity when child ages of 7"
label var mother_lfs_8 "Mother's working intensity when child ages of 8"
label var mother_lfs_9 "Mother's working intensity when child ages of 9"
label var mother_lfs_10 "Mother's working intensity when child ages of 10"
label var mother_lfs_11 "Mother's working intensity when child ages of 11"
label var mother_lfs_12 "Mother's working intensity when child ages of 12"
label var mother_lfs_13 "Mother's working intensity when child ages of 13"
label var mother_lfs_14 "Mother's working intensity when child ages of 14"
label var mother_lfs_15 "Mother's working intensity when child ages of 15"

label var father_lfs_6 "Father's working intensity when child ages of 6"
label var father_lfs_7 "Father's working intensity when child ages of 7"
label var father_lfs_8 "Father's working intensity when child ages of 8"
label var father_lfs_9 "Father's working intensity when child ages of 9"
label var father_lfs_10 "Father's working intensity when child ages of 10"
label var father_lfs_11 "Father's working intensity when child ages of 11"
label var father_lfs_12 "Father's working intensity when child ages of 12"
label var father_lfs_13 "Father's working intensity when child ages of 13"
label var father_lfs_14 "Father's working intensity when child ages of 14"
label var father_lfs_15 "Father's working intensity when child ages of 15"

// save

save `parents_job_master', replace
*----------------------------END OF DO FILE-------------------------------------
*-------------------------------------------------------------------------------

