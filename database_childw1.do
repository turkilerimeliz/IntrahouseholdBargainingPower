
/*==============================================================================
                       1: Database Creation Child - Wave 1
==============================================================================*/

** combine child questionnaire-ISCED codes and technical variables
use "sharew1_rel7-1-0_ch.dta", clear
merge 1:1 mergeid country mergeidp1 hhid1 using "sharew1_rel7-1-0_gv_isced.dta"

 *tab merge
drop _merge

merge 1:1 mergeid country mergeidp1 hhid1 using "sharew1_rel7-1-0_technical_variables.dta"

 *tab merge
drop _merge

// define gender and year of birth for selected children 


forvalues i=1/4 {
       gen w1_ch`i'_gender=.
	   gen w1_ch`i'_year=.
	   }
	   

forvalues i=1/20 {
       replace w1_ch1_gender = ch005_`i' if chselch1==`i'
	   replace w1_ch1_year = ch006_`i' if chselch1==`i'
	   
	   replace w1_ch2_gender = ch005_`i' if chselch2==`i'
	   replace w1_ch2_year = ch006_`i' if chselch2==`i'
	   
	   replace w1_ch3_gender = ch005_`i' if chselch3==`i'
	   replace w1_ch3_year = ch006_`i' if chselch3==`i'
	   
	   replace w1_ch4_gender = ch005_`i' if chselch4==`i'
	   replace w1_ch4_year = ch006_`i' if chselch4==`i'
	   }

// keep necessary variables
keep mergeid hhid1 mergeidp1 coupleid1 country language ch001_ ch002_ ch010_1 ch010_2 ch010_3 ch010_4 ch011_1 ch011_2 ch011_3 ch011_4 ch015_1 ch015_2 ch015_3 ch015_4 ch016_1 ch016_2 ch016_3 ch016_4 chselch1 chselch2 chselch3 chselch4 isced1997_c1 isced1997_c2 isced1997_c3 isced1997_c4 isced1997y_c1 isced1997y_c2 isced1997y_c3 isced1997y_c4 fam_resp w1_ch1_gender w1_ch2_gender w1_ch3_gender w1_ch4_gender w1_ch1_year w1_ch2_year w1_ch3_year w1_ch4_year

// rename variables
rename ch* w1_ch*
rename isced* w1_isced*
rename hhid1 w1_hhid
rename mergeidp1 w1_mergeidp
rename coupleid1 w1_coupleid
rename fam_resp w1_fam_resp
gen w1_wave=1 

// label variables
forvalues i=1/4 {
       label variable w1_ch`i'_gender "child `i' gender"
	   label variable w1_ch`i'_year "child `i' year of birth"
	   }
label variable w1_wave "wave of survey"

// save
save `child1',replace

*------------------------------First Child--------------------------------------

preserve

// keep variables of the first child
keep mergeid w1_hhid w1_mergeidp w1_coupleid country language w1_ch001_ w1_ch002_ w1_wave w1_fam_resp w1_ch010_1 w1_ch011_1 w1_ch015_1 w1_ch016_1 w1_chselch1 w1_isced1997_c1 w1_isced1997y_c1 w1_ch1_gender w1_ch1_year
 
 rename w1_ch010_1 w1_ch010_
 rename w1_ch011_1 w1_ch011_
 rename w1_ch015_1 w1_ch015_
 rename w1_ch016_1 w1_ch016_
 rename w1_chselch1 w1_chselch
 rename w1_isced1997_c1 w1_isced1997_c
 rename w1_isced1997y_c1 w1_isced1997y_c
 rename w1_ch1_gender w1_ch_gender
 rename w1_ch1_year w1_ch_year

// define child number for corresponding child
 gen child_no=1

// keep observations of family respondents ( only family respondents provide information for child)
drop if w1_fam==0
 *tab w1_wave if w1_ch001_==0 & w1_ch_gender!=.
 *tab w1_wave if w1_ch001_==0 & w1_ch_gender==.
 
// drop obs where families without child 
drop if w1_ch001_==0
drop if w1_ch001_==.

// save
save `w1_child1', replace
 
restore
 
*------------------------------Second Child-------------------------------------

preserve
// keep variables of the second child
keep mergeid w1_hhid w1_mergeidp w1_coupleid country language w1_ch001_ w1_ch002_ w1_wave w1_fam_resp w1_ch010_2 w1_ch011_2 w1_ch015_2 w1_ch016_2 w1_chselch2 w1_isced1997_c2 w1_isced1997y_c2 w1_ch2_gender w1_ch2_year

rename w1_ch010_2 w1_ch010_
rename w1_ch011_2 w1_ch011_
rename w1_ch015_2 w1_ch015_
rename w1_ch016_2 w1_ch016_
rename w1_chselch2 w1_chselch
rename w1_isced1997_c2 w1_isced1997_c
rename w1_isced1997y_c2 w1_isced1997y_c
rename w1_ch2_gender w1_ch_gender
rename w1_ch2_year w1_ch_year

// define child number for corresponding child
gen child_no=2
// keep observations of family respondents ( only family respondents provide information for child)
drop if w1_fam==0
 *tab w1_wave if w1_ch001_<2 & w1_ch_gender!=. 
 
// drop obs where families do not report second child (but keep these children if main variables are not missing)
gen inconsisten_child_number=1 if w1_ch001_<2 & w1_ch_gender!=.
drop if w1_ch001_<2 & w1_ch_gender==.
 *tab w1_wave if w1_ch001_==.
 *tab w1_wave if w1_ch001_==. & w1_ch_gender==. 
drop if w1_ch001==.

// save
save `w1_child2', replace
restore

*------------------------------Third Child-------------------------------------
preserve
// keep variables of the third child
keep mergeid w1_hhid w1_mergeidp w1_coupleid country language w1_ch001_ w1_ch002_ w1_wave w1_fam_resp w1_ch010_3 w1_ch011_3 w1_ch015_3 w1_ch016_3 w1_chselch3 w1_isced1997_c3 w1_isced1997y_c3 w1_ch3_gender w1_ch3_year

rename w1_ch010_3 w1_ch010_
rename w1_ch011_3 w1_ch011_
rename w1_ch015_3 w1_ch015_
rename w1_ch016_3 w1_ch016_
rename w1_chselch3 w1_chselch
rename w1_isced1997_c3 w1_isced1997_c
rename w1_isced1997y_c3 w1_isced1997y_c
rename w1_ch3_gender w1_ch_gender
rename w1_ch3_year w1_ch_year

// define child number for corresponding child
gen child_no=3
// keep observations of family respondents ( only family respondents provide information for child)
drop if w1_fam==0
drop if w1_ch001_==.
*tab w1_wave if w1_ch001_<3 & w1_ch_gender!=. 
// drop obs where families do not report third child (but keep these children if main variables are not missing)
gen inconsisten_child_number=1 if w1_ch001_<3 & w1_ch_gender!=.
drop if w1_ch001_<3 & w1_ch_gender==.

// save
save `w1_child3', replace
restore


*------------------------------Fourth Child-------------------------------------

preserve
// keep variables of the fourth child
keep mergeid w1_hhid w1_mergeidp w1_coupleid country language w1_ch001_ w1_ch002_ w1_wave w1_fam_resp w1_ch010_4 w1_ch011_4 w1_ch015_4 w1_ch016_4 w1_chselch4 w1_isced1997_c4 w1_isced1997y_c4 w1_ch4_gender w1_ch4_year

rename w1_ch010_4 w1_ch010_
rename w1_ch011_4 w1_ch011_
rename w1_ch015_4 w1_ch015_
rename w1_ch016_4 w1_ch016_
rename w1_chselch4 w1_chselch
rename w1_isced1997_c4 w1_isced1997_c
rename w1_isced1997y_c4 w1_isced1997y_c
rename w1_ch4_gender w1_ch_gender
rename w1_ch4_year w1_ch_year

// define child number for corresponding child
gen child_no=4

// keep observations of family respondents ( only family respondents provide information for child)
drop if w1_fam==0
drop if w1_ch001_==.
*tab w1_wave if w1_ch001_<4 & w1_ch_gender!=. (23 observations)

// drop obs where families do not report fourth child (but keep these children if main variables are not missing)
gen inconsisten_child_number=1 if w1_ch001_<4 & w1_ch_gender!=.
drop if w1_ch001_<4 & w1_ch_gender==.

// save
save `w1_child4', replace
restore

*-----------------------Append all children from 1st wave-----------------------

use `w1_child1'
append using `w1_child2'
append using `w1_child3'
append using `w1_child4'

 // drop dublicated observations ( cases where gender or year data is missing) 
duplicates tag w1_coupleid w1_ch_gender w1_ch_year if w1_coupleid!="", generate(t1)
drop if t1==1
drop t1
duplicates tag w1_coupleid w1_ch_gender w1_ch_year if w1_coupleid!="", generate(t1)
drop if t1==2
drop t1
duplicates tag w1_coupleid w1_ch_gender w1_ch_year if w1_coupleid!="", generate(t1)
drop if t1==3

 // rename variables
rename mergeid w1_mergeid
rename w1_coupleid coupleid
rename w1_ch_gender gender
rename w1_ch_year year_birth
rename child_no w1_child_no
rename inconsisten_child_number w1_inconsistent_child_no
rename language w1_language

// drop obs if both parents can not identified 
drop if coupleid==""

// save
save `wave1_child', replace

*----------------------------END OF DO FILE-------------------------------------
*-------------------------------------------------------------------------------
