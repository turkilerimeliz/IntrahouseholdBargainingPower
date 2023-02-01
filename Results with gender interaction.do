/*==============================================================================
                      Models with gender interactions
==============================================================================*/

  // define working directory
cd "C:\Users\WB586966\OneDrive - WBG\Desktop\Revized do_files_05.09"
local do "C:\Users\WB586966\OneDrive - WBG\Desktop\Revized do_files_05.09\DO-Files"
local figures "C:\Users\WB586966\OneDrive - WBG\Desktop\Revized do_files_05.09\Figures"
local dataout "C:\Users\WB586966\OneDrive - WBG\Desktop\Revized do_files_05.09\Data_Out"
   
   
  // deploy dataset
use "`dataout'\master_dataset.dta", replace

 // gen dummy for sex
gen sex=(gender==1)
label define sex  0 "female" 1 "male"
lab val sex sex 
tab sex 

*_______________________________________________________________________________
* Alternative version for table 1

 // cluster at household id
regress std_child_median i.sex std_mother_median i.sex#c.std_mother_median std_father_median  i.sex#c.std_father_median   c.bargaining1_rate i.sex#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate  i.sex#c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate i.sex#c.std_father_median#c.bargaining1_rate i.child_birth_cohort i.sex#i.child_birth_cohort i.father_birth_cohort i.sex#i.father_birth_cohort i.mother_birth_cohort  i.sex#i.mother_birth_cohort i.country  i.country#i.sex  if  original_sample==1,  vce(cluster coupleid)

 // cluster at child_birth_cohort
regress std_child_median i.sex std_mother_median i.sex#c.std_mother_median std_father_median  i.sex#c.std_father_median   c.bargaining1_rate i.sex#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate  i.sex#c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate i.sex#c.std_father_median#c.bargaining1_rate i.child_birth_cohort i.sex#i.child_birth_cohort i.father_birth_cohort i.sex#i.father_birth_cohort i.mother_birth_cohort  i.sex#i.mother_birth_cohort i.country  i.country#i.sex  if  original_sample==1,  vce(cluster child_birth_cohort)


*_______________________________________________________________________________
* Alternative version with household FE

preserve
 // sort data by country and coupleid, and keep only main sample
sort country coupleid
keep if original_sample==1

 // identify girls and boys
bysort coupleid: gen girl=(sex==0)
bysort coupleid: gen boy=(sex==1)

 // create keys show whetheir there is at least a boy/girl exist in the family
bysort coupleid: egen couple_boy=max(boy)
bysort coupleid: egen couple_girl=max(girl)

 // grouped families based on the existence of each sex children
gen child_sex=1 if  couple_boy==1 & couple_girl==1
replace child_sex=2 if  couple_boy==1 & couple_girl==0
replace child_sex=3 if  couple_boy==0 & couple_girl==1
label define child_sex 1 "at least one child with each sex"  2 "only boys" 3 "only girls"
label val  child_sex child_sex

 // keep only families where there is at leas one child with each sex.
keep if child_sex==1

 // create ranks by coupleid which are used as the couple fixed effects
egen rank = group(coupleid)
keep if rank <=1000 
tab country

 // regression
regress std_child_median i.sex  i.sex#c.std_mother_median  i.sex#c.std_mother_median#c.bargaining1_rate i.sex#c.std_father_median  i.sex#c.std_father_median#c.bargaining1_rate  i.sex#c.bargaining1_rate   i.sex#i.child_birth_cohort  i.sex#i.father_birth_cohort   i.sex#i.mother_birth_cohort   i.country#i.sex  i.rank  if  original_sample==1,  vce(cluster rank)

restore 

*_______________________________________________________________________________
*_______________________________________________________________________________