/*==============================================================================
                       1: Database Creation Child - Wave 5
==============================================================================*/

** combine child questionnaire-ISCED codes and technical variables

use "sharew5_rel7-1-0_ch.dta", clear
merge 1:1 mergeid country mergeidp5 hhid5 using "sharew5_rel7-1-0_gv_isced.dta"

 *tab merge
drop _merge

merge 1:1 mergeid country mergeidp5 hhid5 using "sharew5_rel7-1-0_technical_variables.dta"

 *tab merge
drop _merge

// keep necessary variables
keep mergeid-ch006_20 ch010_1-ch011_20 ch015_1-ch016_20 ch508_ isced1997_c1-isced1997_c20 isced2011_c1-isced2011_c20 fam_resp mn101_

// rename variables
rename ch* w5_ch*
rename isced* w5_isced*
rename hhid5 w5_hhid
rename mergeidp5 w5_mergeidp
rename coupleid5 w5_coupleid
rename fam_resp w5_fam_resp
rename mn101_ w5_mn101_

// define wave dummy
gen w5_wave=1 

// save
save `child5',replace

*------------------------------1st Child----------------------------------------

preserve
// keep variables of the corresponding child
keep w5_wave w5_fam_resp w5_mn101_ w5_ch508_ mergeid w5_hhid w5_mergeidp w5_coupleid country language w5_ch001_ w5_ch002_1 w5_ch005_1 w5_ch006_1 w5_ch010_1 w5_ch011_1 w5_ch015_1 w5_ch016_1 w5_isced1997_c1 

// rename variables
rename *1 *

// define child number for corresponding child
gen w5_child_no=1

// keep observations of family respondents ( only family respondents provide information for child)
drop if w5_fam==0

// drop obs where families without child (but keep these children if main variables are not missing)
*tab w5_wave if w5_ch001_==. & w5_ch005_!=.
drop if w5_ch001_==.
tab w5_wave if w5_ch001_==0 & w5_ch005_!=.
drop if w5_ch001_==0 & w5_ch005_==.

// save
save `w5_child1', replace
restore

*--------------------------Remaining Children-----------------------------------

*tab w5_ch001_ (maximum number of children = 17)

 forvalues i=2/17 {
preserve
// keep variables of the corresponding child
keep w5_wave w5_fam_resp w5_mn101_ w5_ch508_ mergeid w5_hhid w5_mergeidp w5_coupleid country language w5_ch001_ w5_ch002_`i' w5_ch005_`i' w5_ch006_`i' w5_ch010_`i' w5_ch011_`i' w5_ch015_`i' w5_ch016_`i' w5_isced1997_c`i' w5_isced2011_c`i'
 
rename *`i' *

// define child number for corresponding child
gen w5_child_no=`i'

// keep observations of family respondents ( only family respondents provide information for child)
drop if w5_fam==0

// drop obs where families do not report corresponding child (but keep these children if main variables are not missing)
drop if w5_ch001_==.
gen inconsisten_child_number=1 if w5_ch001_<`i' & w5_ch005_!=.
drop if w5_ch001_< `i' & w5_ch005_==.

// save
save `w5_child`i'', replace
restore
}


*-----------------------Append all children from 5th wave-----------------------
use `w5_child1', clear

forvalues i=2/17 {
      append using `w5_child`i''
	   }

// drop dublicated observations (cases where gender or year of birth data are missing) 	   	  
duplicates tag w5_coupleid w5_ch005_ w5_ch006_ if w5_coupleid!="", generate(t1)
drop if t1>=1 & t1!=.

// rename variables
rename mergeid w5_mergeid
rename w5_coupleid coupleid
rename w5_ch005_ gender
rename w5_ch006_ year_birth
rename inconsisten_child_number w5_inconsistent_child_no
rename language w5_language
drop t1

// drop obs if both parents can not identified 
drop if coupleid==""

// save
save `wave5_child', replace

*----------------------------END OF DO FILE-------------------------------------
*-------------------------------------------------------------------------------


