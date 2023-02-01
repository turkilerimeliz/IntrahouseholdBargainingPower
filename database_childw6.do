/*==============================================================================
                       1: Database Creation Child - Wave 6
==============================================================================*/

** combine child questionnaire-ISCED codes and technical variables

use "sharew6_rel7-1-0_gv_children.dta", clear
merge 1:1 mergeid country mergeidp6 hhid6 using "sharew6_rel7-1-0_gv_isced.dta"

 *tab merge
drop _merge

merge 1:1 mergeid country mergeidp6 hhid6 using "sharew6_rel7-1-0_technical_variables.dta"

 *tab merge
drop _merge

// keep necessary variables
keep mergeid-ch_relation_20 ch_proximity_1-ch_move_out_year_20 ch_closeness_1-ch_occupation_20 isced1997_c1-isced1997_c20 isced2011_c1-isced2011_c20 fam_resp mn101_

// rename variables
rename ch_* w6_*
rename w6_gender* gender*
rename w6_yrbirth* year_birth*
rename isced* w6_isced*
rename hhid6 w6_hhid
rename mergeidp6 w6_mergeidp
rename mergeid w6_mergeid
rename coupleid6 coupleid
rename fam_resp w6_fam_resp
rename mn101_ w6_mn101
rename ch001_ w6_ch001
rename language w6_language

// define wave dummy
gen w6_wave=1 

// save
save `child6',replace

*------------------------------1st Child----------------------------------------
preserve
// keep variables of the corresponding child
keep w6_mergeid w6_hhid w6_mergeidp coupleid country w6_language w6_ch001 gender_1 year_birth_1 w6_relation_1 w6_proximity_1 w6_move_out_year_1 w6_closeness_1 w6_occupation_1 w6_isced1997_c1 w6_isced2011_c1 w6_fam_resp w6_mn101 w6_wave

// rename variables
rename *_1 *
rename w6_move_out_year  w6_move_out
rename *_c1 *

// define child number for corresponding child
gen w6_child_no=1

// keep observations of family respondents ( only family respondents provide information for child)
drop if w6_fam==0

// drop obs where families without child (but keep these children if main variables are not missing)
*tab w6_wave if w6_ch001==. & gender!=.
drop if w6_ch001==. & gender==.
tab w6_wave if w6_ch001==0 & gender!=. 
drop if w6_ch001==0 & gender==.

// save
save `w6_child1', replace
restore

*--------------------------Remaining Children-----------------------------------
 forvalues i=2/20 {
preserve
// keep variables of the corresponding child
keep w6_mergeid w6_hhid w6_mergeidp coupleid country w6_language w6_ch001 gender_`i' year_birth_`i' w6_relation_`i' w6_proximity_`i' w6_move_out_year_`i' w6_closeness_`i' w6_occupation_`i' w6_isced1997_c`i' w6_isced2011_c`i' w6_fam_resp w6_mn101 w6_wave

// rename variables
rename *_`i' *
rename w6_move_out_year  w6_move_out
rename *_c`i' *

// define child number for corresponding child
gen w6_child_no=`i'

// keep observations of family respondents ( only family respondents provide information for child)
drop if w6_fam==0

// drop obs where families do not report corresponding child (but keep these children if main variables are not missing)
drop if w6_ch001==. & gender==.
*tab w6_wave if w6_ch001<`i' & gender!=.
gen inconsisten_child_number=1 if w6_ch001<`i' & gender!=.
drop if w6_ch001<`i' & gender==.

// save
save `w6_child`i'', replace
restore
}


*-----------------------Append all children from 6th wave-----------------------
use `w6_child1', clear

forvalues i=2/20 {
      append using `w6_child`i''
	   }

// drop dublicated observations (cases where gender or year of birth data are missing) 	   	  
duplicates tag coupleid gender year_birth if coupleid!="", generate(t1)
drop if t1>=1 & t1!=.
drop t1

// rename variables
rename inconsisten_child_number w6_inconsistent_child_no

// drop obs if both parents can not identified 
drop if coupleid==""

// save
save `wave6_child', replace

*----------------------------END OF DO FILE-------------------------------------
*-------------------------------------------------------------------------------


