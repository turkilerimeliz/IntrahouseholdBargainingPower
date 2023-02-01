

/*==============================================================================
                       1: Database Creation Child - Wave 2
==============================================================================*/

** combine child questionnaire-ISCED codes and technical variables

use "sharew2_rel7-1-0_ch.dta", clear
merge 1:1 mergeid country mergeidp2 hhid2 using "sharew2_rel7-1-0_gv_isced.dta"

 *tab merge
drop _merge

merge 1:1 mergeid country mergeidp2 hhid2 using "sharew2_rel7-1-0_technical_variables.dta"

 *tab merge
drop _merge

// define gender and year of birth for selected children 

forvalues i=1/4 {
       gen w2_ch`i'_gender=.
	   gen w2_ch`i'_year=.
	   }
	   

forvalues i=1/20 {
       replace w2_ch1_gender = ch005_`i' if chselch1==`i'
	   replace w2_ch1_year = ch006_`i' if chselch1==`i'
	   
	   replace w2_ch2_gender = ch005_`i' if chselch2==`i'
	   replace w2_ch2_year = ch006_`i' if chselch2==`i'
	   
	   replace w2_ch3_gender = ch005_`i' if chselch3==`i'
	   replace w2_ch3_year = ch006_`i' if chselch3==`i'
	   
	   replace w2_ch4_gender = ch005_`i' if chselch4==`i'
	   replace w2_ch4_year = ch006_`i' if chselch4==`i'
	   }
	   
// keep necessary variables
keep mergeid hhid2 mergeidp2 coupleid2 country language ch001_ ch002_ ch010_1 ch010_2 ch010_3 ch010_4 ch011_1 ch011_2 ch011_3 ch011_4 ch015_1 ch015_2 ch015_3 ch015_4 ch016_1 ch016_2 ch016_3 ch016_4 chselch1 chselch2 chselch3 chselch4 isced1997_c1 isced1997_c2 isced1997_c3 isced1997_c4 fam_resp mn101_ w2_ch1_gender w2_ch2_gender w2_ch3_gender w2_ch4_gender w2_ch1_year w2_ch2_year w2_ch3_year w2_ch4_year

// rename variables
rename ch* w2_ch*
rename isced* w2_isced*
rename hhid2 w2_hhid
rename mergeidp2 w2_mergeidp
rename coupleid2 w2_coupleid
rename fam_resp w2_fam_resp
rename mn101_ w2_mn101_
gen w2_wave=1 

// label variables
forvalues i=1/4 {
       label variable w2_ch`i'_gender "child `i' gender"
	   label variable w2_ch`i'_year "child `i' year of birth"
	   }
label variable w2_wave "wave of survey"

// save
save `child2',replace

*------------------------------First Child--------------------------------------

preserve
// keep variables of the first child
keep mergeid w2_hhid w2_mergeidp w2_coupleid country language w2_ch001_ w2_ch002_ w2_wave w2_fam_resp w2_mn101_ w2_ch010_1 w2_ch011_1 w2_ch015_1 w2_ch016_1 w2_chselch1 w2_isced1997_c1 w2_ch1_gender w2_ch1_year

// define child number for corresponding child
gen child_no=1
 
// rename variables
rename w2_ch010_1 w2_ch010_	
rename w2_ch011_1 w2_ch011_	
rename w2_ch015_1 w2_ch015_	
rename w2_ch016_1 w2_ch016_	
rename w2_chselch1 w2_chselch	
rename w2_isced1997_c1 w2_isced1997_c	
rename w2_ch1_gender w2_ch_gender	
rename w2_ch1_year w2_ch_year
 
// keep observations of family respondents ( only family respondents provide information for child)
drop if w2_fam==0
 *tab w2_wave if w2_ch001_==0 & w2_ch_gender!=.
 *tab w2_wave if w2_ch001_==0 & w2_ch_gender==.
 *tab w2_wave if w2_ch001_==. & w2_ch_gender!=.
 
// drop obs where families without child 
drop if w2_ch001_==.
drop if w2_ch001_==0

// save
save `w2_child1', replace

restore
 
*------------------------------Second Child-------------------------------------

preserve
// keep variables of the second child
keep mergeid w2_hhid w2_mergeidp w2_coupleid country language w2_ch001_ w2_ch002_ w2_wave w2_fam_resp w2_mn101_ w2_ch010_2 w2_ch011_2 w2_ch015_2 w2_ch016_2 w2_chselch2 w2_isced1997_c2 w2_ch2_gender w2_ch2_year

// define child number for corresponding child
gen child_no=2

// rename variables	
rename w2_ch010_2 w2_ch010_	
rename w2_ch011_2 w2_ch011_	
rename w2_ch015_2 w2_ch015_	
rename w2_ch016_2 w2_ch016_	
rename w2_chselch2 w2_chselch	
rename w2_isced1997_c2 w2_isced1997_c	
rename w2_ch2_gender w2_ch_gender	
rename w2_ch2_year w2_ch_year

// keep observations of family respondents ( only family respondents provide information for child)
drop if w2_fam==0

// drop obs where families do not report second child (but keep these children if main variables are not missing)
drop if w2_ch001_==.
 *tab w2_wave if w2_ch001_<2 & w2_ch_gender!=.  (0 obs)
drop if w2_ch001_<2

// save
save `w2_child2', replace
restore

*------------------------------Third Child-------------------------------------
 
preserve
// keep variables of the third child
keep mergeid w2_hhid w2_mergeidp w2_coupleid country language w2_ch001_ w2_ch002_ w2_wave w2_fam_resp w2_mn101_ w2_ch010_3 w2_ch011_3 w2_ch015_3 w2_ch016_3 w2_chselch3 w2_isced1997_c3 w2_ch3_gender w2_ch3_year
 
// define child number for corresponding child
gen child_no=3
	
// rename variables	
rename w2_ch010_3 w2_ch010_	
rename w2_ch011_3 w2_ch011_	
rename w2_ch015_3 w2_ch015_	
rename w2_ch016_3 w2_ch016_	
rename w2_chselch3 w2_chselch	
rename w2_isced1997_c3 w2_isced1997_c	
rename w2_ch3_gender w2_ch_gender	
rename w2_ch3_year w2_ch_year

// keep observations of family respondents ( only family respondents provide information for child)
drop if w2_fam==0
drop if w2_ch001_==.
 *tab w2_wave if w2_ch001_<3 & w2_ch_gender!=.
 
// drop obs where families do not report third child (but keep these children if main variables are not missing)
gen inconsisten_child_number=1 if w2_ch001_<3 & w2_ch_gender!=.
drop if w2_ch001_<3 & w2_ch_gender==.

// save
save `w2_child3', replace
restore


*------------------------------Fourth Child-------------------------------------

preserve
// keep variables of the fourth child
keep mergeid w2_hhid w2_mergeidp w2_coupleid country language w2_ch001_ w2_ch002_ w2_wave w2_fam_resp w2_mn101_ w2_ch010_4 w2_ch011_4 w2_ch015_4 w2_ch016_4 w2_chselch4 w2_isced1997_c4 w2_ch4_gender w2_ch4_year

// define child number for corresponding child
gen child_no=4
	
// rename variables
rename w2_ch010_4 w2_ch010_	
rename w2_ch011_4 w2_ch011_	
rename w2_ch015_4 w2_ch015_	
rename w2_ch016_4 w2_ch016_	
rename w2_chselch4 w2_chselch	
rename w2_isced1997_c4 w2_isced1997_c	
rename w2_ch4_gender w2_ch_gender	
rename w2_ch4_year w2_ch_year

// keep observations of family respondents ( only family respondents provide information for child)
drop if w2_fam==0

// drop obs where families do not report fourth child (but keep these children if main variables are not missing)
drop if w2_ch001_==.
 *tab w2_wave if w2_ch001_<4 & w2_ch_gender!=. (0 obs)
drop if w2_ch001_<4

// save
save `w2_child4', replace
restore

*-----------------------Append all children from 2nd wave-----------------------


use `w2_child1'
append using `w2_child2'
append using `w2_child3'
append using `w2_child4'

// drop dublicated observations (cases where gender or year of birth data are missing) 
duplicates tag w2_coupleid w2_ch_gender w2_ch_year if w2_coupleid!="", generate(t1)
drop if t1==1
drop t1
duplicates tag w2_coupleid w2_ch_gender w2_ch_year if w2_coupleid!="", generate(t1)
drop if t1==2
drop t1
duplicates tag w2_coupleid w2_ch_gender w2_ch_year if w2_coupleid!="", generate(t1)
drop if t1==3
drop t1
duplicates tag w2_coupleid w2_ch_gender w2_ch_year if w2_coupleid!="", generate(t1)

 // rename variables
rename mergeid w2_mergeid
rename w2_coupleid coupleid
rename w2_ch_gender gender
rename w2_ch_year year_birth
rename child_no w2_child_no
rename inconsisten_child_number w2_inconsistent_child_no
rename language w2_language
drop t1

// drop obs if both parents can not identified 
drop if coupleid==""

// save
save `wave2_child', replace


*----------------------------END OF DO FILE-------------------------------------
*-------------------------------------------------------------------------------

