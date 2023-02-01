/*==============================================================================
                  1: Dataset Creation for Age-Earning Profiles
==============================================================================*/
*-----Create main dataset used to estimate age-earning profiles-------

*-------Keep all the available data points report wage information-------------*
use "sharewX_rel7-1-0_gv_job_episodes_panel.dta", replace


*drop observations where wage_info recorded as missing
drop if first_wage==. & lastwage==. & current_wage==.
gen control=1

*combined all available data points
gen wage=first_wage
replace wage=lastwage if wage==.
replace wage=current_wage if wage==.

*define a currency variable
gen currency_new= currency_fw if wage==first_wage
replace currency_new= currency_lw if wage==lastwage
replace currency_new= current_currency_w if wage==current_wage

 // iterate the wage_info to access an available data points
gen control2=1 if wage==-1 | wage==-2
replace wage=first_wage if first_wage!=-1 & first_wage!=-2 & first_wage!=. & control2==1
replace wage=lastwage if lastwage!=-1 & lastwage!=-2 & lastwage!=. & control2==1
replace currency_new=currency_lw if lastwage!=-1 & lastwage!=-2 & lastwage!=. & control2==1

drop control2
gen control2=1 if wage==-1 | wage==-2
replace wage=current_wage if current_wage!=-1 & current_wage!=-2 & current_wage!=. & control2==1
replace currency_new=current_currency_w if current_wage!=-1 & current_wage!=-2 & current_wage!=. & control2==1
drop control control2

 // label values and order variables
label values currency_new currencycoded
label values wage rfdkfin
order wage, before (first_wage)
order currency_new, before (first_wage)

*---Combine with years of schooling and ISCED97 information of individuals------

merge m:1 mergeid using `parents'
keep mergeid hhid7 hhid3 jep_w gender yrbirth age year country situation working unemployed in_education retired mainjob ordjob industry job_title working_hours wage currency_new first_wage currency_fw first_income currency_fi reason_endjob afterlast lastwage currency_lw lastincome currency_li first_pension currency_fp country_res_ nchildren_nat nchildren age_youngest age_youngest_nat withpartner married contrib_employee contrib_employer early_ret_reduction currency_min_pension currency_max_pension ret_age early_age min_pension max_pension current_wage current_currency_w current_income current_currency_i dn041_v4 dn041_v4_key isced1997_r_v2 isced1997_r_v2_key _merge

drop if _merge==2
rename _merge merge1

save `job_episode' ,replace

*===============================================================================
* Some observations come from the 7th wave. Access years of schooling and ISCED for them
use "sharew7_rel7-1-1_dn.dta", clear
merge 1:1 mergeid country mergeidp7 hhid7 using "sharew7_rel7-1-1_gv_isced.dta"
 *tab _merge
drop _merge
save `respondents_w7' ,replace
*===============================================================================

use `job_episode', replace
merge m:1 mergeid using `respondents_w7'

//keep necessary variables
keep mergeid hhid7 hhid3 jep_w gender yrbirth age year country situation working unemployed in_education retired mainjob ordjob industry job_title working_hours wage currency_new first_wage currency_fw first_income currency_fi reason_endjob afterlast lastwage currency_lw lastincome currency_li first_pension currency_fp country_res_ nchildren_nat nchildren age_youngest age_youngest_nat withpartner married contrib_employee contrib_employer early_ret_reduction currency_min_pension currency_max_pension ret_age early_age min_pension max_pension current_wage current_currency_w current_income current_currency_i dn041_v4 dn041_v4_key isced1997_r_v2 isced1997_r_v2_key merge1 isced1997_r dn041_ _merge
rename isced1997_r isced1997_w7
rename dn041_ dn041_w7
drop if _merge==2
rename _merge merge2

// flag the merge status
gen merge3=1 if merge1==3 & merge2==3
replace merge3=0 if merge1==3 & merge2!=3
replace merge3=-1 if merge1!=3 & merge2==3
label define merge_new 1 "merge in two data" 0 "merge in first not in 7 wave" -1 "merge in 7 not in first" -2 "no merge"
label values merge3 merge_new

*combined years of schooling and ISCED97 comes from different waves.
gen years_of_educ=dn041_v4
replace years_of_educ=dn041_w7 if merge3==-1
gen years_of_educ_key=dn041_v4_key
replace years_of_educ_key=0 if merge3==-1 & dn041_w7!=.
replace years_of_educ_key=-1 if merge3==-1 & dn041_w7==.

replace years_of_educ=dn041_w7 if merge3==1 & dn041_v4==.
replace years_of_educ_key=1 if merge3==1 & dn041_v4!=dn041_w7 & dn041_v4!=. & dn041_w7!=.
order dn041_w7, before(merge1)
order years_of_educ, before(merge1)
order merge3, before(merge1)
order years_of_educ_key, before(merge3)
replace years_of_educ_key=0 if years_of_educ!=. & years_of_educ_key==-1

gen educ_ISCED=isced1997_r_v2
replace educ_ISCED=isced1997_w7 if merge3==-1
gen educ_ISCED_key=isced1997_r_v2_key
replace educ_ISCED_key=0 if merge3==-1 & isced1997_w7!=.
replace educ_ISCED_key=-1 if merge3==-1 & isced1997_w7==.

replace educ_ISCED=isced1997_w7 if merge3==1 & isced1997_r_v2==.
replace educ_ISCED_key=1 if merge3==1 & isced1997_r_v2!=isced1997_w7 & isced1997_r_v2!=. & isced1997_w7!=.
replace educ_ISCED_key=0 if educ_ISCED!=. & educ_ISCED_key==-1

// order, rename and label variables
order isced1997_r_v2, before(years_of_educ_key)
order isced1997_w7, before(years_of_educ_key)
order educ_ISCED, before(years_of_educ_key)
order educ_ISCED_key, before(years_of_educ_key)
order years_of_educ, before(working)
order educ_ISCED, before(working)
order educ_ISCED_key, before(working)
order years_of_educ_key, before(educ_ISCED)

rename educ_ISCED isced97_educ
rename educ_ISCED_key isced97_educ_key

label values isced97_educ isced
label values years_of_educ dkrfim
label values years_of_educ_key consistency_check3
label values isced97_educ_key consistency_check3

label var wage "derived from first wage, last wage or current wage"
label var currency_new "indicated the currency from first wage, last wage or current wage"
label var isced1997_w7 "Wave7: Respondent: ISCED-97 coding of education"
label var dn041_w7 "Wave7: Years of schooling"
label var merge3 "merge detail of merge1 and merge2"
label var merge1 "merge with parent main dataset"
label var merge2 "merge with wave7 dn"
label var years_of_educ "Years of Education- final version"
label var years_of_educ_key "consistency check"
label var isced97_educ "Education-ISCED code-final version"
label var isced97_educ_key "consistency check"


*---Keep observations from the countries that included in child dataset---------

* keep observations from the countries that included in child dataset. 

keep if country_res_==40 | country_res_==276 | country_res_==278 | country_res_==280 | country_res_==752 | country_res_==528 | country_res_==724 | country_res_==380 | country_res_==250 | country_res_==208 | country_res_==300 | country_res_==756 | country_res_==56 | country_res_==376 | country_res_==200 | country_res_==203 | country_res_==616 | country_res_==372 | country_res_==442 | country_res_==348 | country_res_==620 | country_res_==705 | country_res_==233 | country_res_==191 | country_res_==.

*drop obs where recorded as not working
. drop if working==0 

*drop obs where recorded as self-employed
drop if job_title==3 

* drop obs if respondents report their wage as "don't know". 
drop if wage==-1

* drop if respondents refuse to answer 
drop if wage==-2

*current wage is recorded as 0 in some cases.
drop if wage==0

*drop obs where currency_info is not accessible 
drop if	currency_new==-4
drop if	currency_new==-2
drop if	currency_new==-1
drop if	currency_new==.


*Use country and currency info to impute missing country of residence values 

replace country_res=40 if country_res==. & currency_new==2 & country==11
replace country_res=56 if country_res==. & currency_new==5 & country==23
replace country_res=208 if country_res==. & currency_new==19 & country==18
replace country_res=724 if country_res==. & currency_new==21 & country==15
replace country_res=250 if country_res==. & currency_new==23 & country==17
replace country_res=300 if country_res==. & currency_new==25 & country==19
replace country_res=372 if country_res==. & currency_new==26 & country==30
replace country_res=376 if country_res==. & currency_new==27 & country==25
replace country_res=380 if country_res==. & currency_new==28 & country==16
replace country_res=442 if country_res==. & currency_new==29 & country==31
replace country_res=616 if country_res==. & currency_new==32 & country==29
replace country_res=620 if country_res==. & currency_new==34 & country==33
replace country_res=705 if country_res==. & currency_new==37 & country==34
replace country_res=233 if country_res==. & currency_new==90 & country==35
replace country_res=191 if country_res==. & currency_new==109 & country==47
replace country_res=348 if country_res==. & currency_new==111 & country==32
replace country_res=752 if country_res==. & currency_new==186 & country==13
replace country_res=616 if country_res==. & currency_new==251 & country==29
replace country_res=250 if country_res==. & currency_new==253 & country==17
replace country_res=616 if country_res==. & currency_new==264 & country==29
replace country_res=376 if country_res==. & currency_new==301 & country==25
replace country_res=376 if country_res==. & currency_new==303 & country==25
replace country_res=528 if country_res==. & currency_new==269 & country==14
replace country_res=200 if country_res==. & currency_new==320 & country==28 & year<1993
replace country_res=200 if country_res==. & currency_new==322 & country==28 & year<1993
replace country_res=203 if country_res==. & currency_new==320 & country==28 & year>1993
replace country_res=203 if country_res==. & currency_new==322 & country==28 & year>1993
replace country_res=278 if country_res==. & currency_new==17 & country==12 & year<1990
replace country_res=276 if country_res==. & currency_new==17 & country==12 & year>1990
replace country_res=280 if country_res==. & currency_new==18 & country==12 & year<1990
replace country_res=276 if country_res==. & currency_new==18 & country==12 & year>1990
replace country_res=620 if country_res==. & currency_new==281 & country==33

*Drop obs with missing country_res if currency does not match with national currency in the target countries. 

drop if country_res==. & currency_new==7
drop if country_res==. & currency_new==15
drop if country_res==. & currency_new==22
drop if country_res==. & currency_new==30
drop if country_res==. & currency_new==35
drop if country_res==. & currency_new==41
drop if country_res==. & currency_new==113
drop if country_res==. & currency_new==134
drop if country_res==. & currency_new==139
drop if country_res==. & currency_new==164
drop if country_res==. & currency_new==176
drop if country_res==. & currency_new==177
drop if country_res==. & currency_new==210
drop if country_res==. & currency_new==238
drop if country_res==. & currency_new==241

*use country and currency info to impute country of residence (only for obs with missing country of residence info and reports old currency unit of the related country.)

tab country if country_res==. & currency_new==260
replace country_res=56 if country_res==. & currency_new==260 & country==23
tab country if country_res==. & currency_new==261
replace country_res=56 if country_res==. & currency_new==261 & country==23
tab country if country_res==. & currency_new==265
tab country if country_res==. & currency_new==266
replace country_res=40 if country_res==. & currency_new==266 & country==11
tab country if country_res==. & currency_new==278
replace country_res=233 if country_res==. & currency_new==278 & country==35

replace country_res=756 if country_res==. & currency_new==14 & country==20
replace country_res=200 if country_res==. & currency_new==16 & country==28 & year<1993
replace country_res=203 if country_res==. & currency_new==16 & country==28 & year>1993

*drop obs with missing country_res
drop if country_res==.

*----------------------Merge with CPI and Exchange rate-------------------------


*merge with CPI, exchange rate, imputed years of schooling 
merge m:1 country_res_  year using "CPI_historical.dta"
drop if _merge==2
rename _merge merge_cpi

merge m:1 year using "Exchange_rate_historical.dta"
drop if _merge==2
rename _merge merge_exchange

*----------------------Merge with median years of schooling --------------------


merge m:1 country_res_ isced97_educ using `median_yrschl_job'
drop if _merge==2
rename _merge merge_educ

drop observation1 sd1 min1 max1 

 // label variables
label variable mean_1 "Imputed education: mean value version1"
label variable median_1 "Imputed education median value version1"
label var country_educ "Country where imputed yrschl belonged"

label variable merge_cpi "Merge info for cpi document"
label variable merge_exchange "Merge info for exchange rate document"
label variable merge_educ "Merge info for years of educ document"

// save
save `job_episode' ,replace

*----------------------------END OF DO FILE-------------------------------------
*-------------------------------------------------------------------------------


