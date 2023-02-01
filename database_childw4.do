/*==============================================================================
                       1: Database Creation Child - Wave 4
==============================================================================*/

** combine child questionnaire-ISCED codes and technical variables

use "sharew4_rel7-1-0_ch.dta", clear
merge 1:1 mergeid country mergeidp4 hhid4 using "sharew4_rel7-1-0_gv_isced.dta"

 *tab merge
drop _merge

merge 1:1 mergeid country mergeidp4 hhid4 using "sharew4_rel7-1-0_technical_variables.dta"

 *tab merge
drop _merge

// keep necessary variables
keep mergeid-ch006_20 ch010_1-ch011_20 ch015_1-ch016_20 ch508_ isced1997_c1-isced1997_c20 fam_resp mn101_

// rename variables
rename ch* w4_ch*
rename isced* w4_isced*
rename hhid4 w4_hhid
rename mergeidp4 w4_mergeidp
rename coupleid4 w4_coupleid
rename fam_resp w4_fam_resp
rename mn101_ w4_mn101_

// define wave dummy
gen w4_wave=1 

// save

save `child4',replace

*------------------------------1st Child----------------------------------------

preserve
// keep variables of the corresponding child
keep w4_ch508_ w4_wave w4_fam_resp w4_mn101_ mergeid w4_hhid w4_mergeidp w4_coupleid country language w4_ch001_ w4_ch002_1 w4_ch005_1 w4_ch006_1 w4_ch010_1 w4_ch011_1 w4_ch015_1 w4_ch016_1 w4_isced1997_c1

// rename variables
rename w4_ch002_1 w4_ch002_
rename w4_ch005_1 w4_ch005_
rename w4_ch006_1 w4_ch006_
rename w4_ch010_1 w4_ch010_
rename w4_ch011_1 w4_ch011_
rename w4_ch015_1 w4_ch015_
rename w4_ch016_1 w4_ch016_
rename w4_isced1997_c1 w4_isced1997_c

// define child number for corresponding child
gen w4_child_no=1
 
// keep observations of family respondents ( only family respondents provide information for child)
drop if w4_fam==0

// drop obs where families without child (but keep these children if main variables are not missing)
*drop if w4_ch001_==.
*tab w4_wave if w4_ch001_==. & w4_ch005_!=.
*tab w4_wave if w4_ch001_==0 & w4_ch005_!=.
gen inconsisten_child_number=1 if w4_ch001_==0 & w4_ch005_!=.
drop if w4_ch001_==0 & w4_ch005_==.

// save
save `w4_child1', replace
 
restore
 

*--------------------------Remaining Children-----------------------------------
 *tab w4_ch001_ (maximum number of children = 17)

forvalues i=2/17 {
preserve
// keep variables of the corresponding child
keep w4_ch508_ w4_wave w4_fam_resp w4_mn101_ mergeid w4_hhid w4_mergeidp w4_coupleid country language w4_ch001_ w4_ch002_`i' w4_ch005_`i' w4_ch006_`i' w4_ch010_`i' w4_ch011_`i' w4_ch015_`i' w4_ch016_`i' w4_isced1997_c`i'

rename w4_ch002_`i' w4_ch002_
rename w4_ch005_`i' w4_ch005_
rename w4_ch006_`i' w4_ch006_
rename w4_ch010_`i' w4_ch010_
rename w4_ch011_`i' w4_ch011_
rename w4_ch015_`i' w4_ch015_
rename w4_ch016_`i' w4_ch016_
rename w4_isced1997_c`i' w4_isced1997_c

// define child number for corresponding child
gen w4_child_no=`i'

// keep observations of family respondents ( only family respondents provide information for child)
drop if w4_fam==0

// drop obs where families do not report corresponding child (but keep these children if main variables are not missing)
drop if w4_ch001_==.
gen inconsisten_child_number=1 if w4_ch001_<`i' & w4_ch005_!=.
drop if w4_ch001_< `i' & w4_ch005_==.

// save
save `w4_child`i'', replace
restore
}


*-----------------------Append all children from 4th wave-----------------------


use `w4_child1', clear

forvalues i=2/17 {
      append using `w4_child`i''
	   }

// drop dublicated observations (cases where gender or year of birth data are missing) 	   
duplicates tag w4_coupleid w4_ch005_ w4_ch006_ if w4_coupleid!="", generate(t1)
drop if t1>=1 & t1!=. 

// rename variables
rename mergeid w4_mergeid
rename w4_coupleid coupleid
rename w4_ch005_ gender
rename w4_ch006_ year_birth
rename inconsisten_child_number w4_inconsistent_child_no
rename language w4_language
drop t1

// drop obs if both parents can not identified 
drop if coupleid==""

// save
save `wave4_child', replace

*----------------------------END OF DO FILE-------------------------------------
*-------------------------------------------------------------------------------






