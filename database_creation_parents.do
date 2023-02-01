
/*==============================================================================
                       1: Database Creation Parents
==============================================================================*/

*********************************Wave 1*****************************************
*Combine demographic questionnaire-child questionnaire-ISCED codes and technical variables

use "sharew1_rel7-1-0_dn.dta", clear
merge 1:1 mergeid country mergeidp1 hhid1 using "sharew1_rel7-1-0_gv_isced.dta"
 *tab _merge
drop _merge

merge 1:1 mergeid country mergeidp1 hhid1 using "sharew1_rel7-1-0_ch.dta"
 *tab _merge
drop _merge

merge 1:1 mergeid country mergeidp1 hhid1 using "sharew1_rel7-1-0_technical_variables.dta"
 *tab _merge
drop _merge

**************
ren *_ *_1
ren *c *c_1
ren *r *r1
ren *sp *sp1
ren isced1997y_sp1 isced1997y_sp_1
ren country country1
ren language language1

keep mergeid hhid1 mergeidp1 coupleid1 country1 language1 dn002_1 dn003_1 isced1997_r1 isced1997_sp1 dn004_1 dn005c_1 dn006_1 dn007_1 dn008c_1 dn014_1 dn015_1 dn016_1 dn017_1 dn018_1 dn019_1 dn020_1 dn042_1 ch001_1 isced1997y_r1 isced1997y_sp_1

save `parent1',replace


*********************************Wave 2*****************************************
*Combine demographic questionnaire-child questionnaire-ISCED codes and technical variables

use "sharew2_rel7-1-0_dn.dta", clear
merge 1:1 mergeid country mergeidp2 hhid2 using "sharew2_rel7-1-0_gv_isced.dta"
 *tab _merge
drop _merge

merge 1:1 mergeid country mergeidp2 hhid2 using "sharew2_rel7-1-0_ch.dta"
 *tab _merge
drop _merge

merge 1:1 mergeid country mergeidp2 hhid2 using "sharew2_rel7-1-0_technical_variables.dta"
 *tab _merge
drop _merge

**************
ren *_ *_2
ren *c *c_2
ren *r *r2
ren *sp *sp2
ren country country2
ren language language2

keep mergeid hhid2 mergeidp2 coupleid2 country2 language2 dn002_2 dn003_2 dn041_2 dn042_2 isced1997_r2 isced1997_sp2 mn101_2 dn004_2 dn005c_2 dn006_2 dn007_2 dn008c_2 dn014_2 dn015_2 dn016_2 dn017_2 dn018_2 dn019_2 dn020_2 dn042_2 ch001_2

save `parent2',replace


*********************************Wave 4*****************************************
*Combine demographic questionnaire-child questionnaire-ISCED codes and technical variables

use "sharew4_rel7-1-0_dn.dta", clear
merge 1:1 mergeid country mergeidp4 hhid4 using "sharew4_rel7-1-0_gv_isced.dta"
 *tab _merge
drop _merge

merge 1:1 mergeid country mergeidp4 hhid4 using "sharew4_rel7-1-0_ch.dta"
 *tab _merge
drop _merge

merge 1:1 mergeid country mergeidp4 hhid4 using "sharew4_rel7-1-0_technical_variables.dta"
 *tab _merge
drop _merge

**************

ren *_ *_4
ren *c *c_4
ren *r *r4
ren *sp *sp4
ren country country4
ren language language4

keep mergeid hhid4 mergeidp4 coupleid4 country4 language4 dn002_4 dn003_4 dn041_4 dn042_4 isced1997_r4 isced1997_sp4 mn101_4 dn004_4 dn005c_4 dn006_4 dn007_4 dn008c_4 dn014_4 dn015_4 dn016_4 dn017_4 dn018_4 dn019_4 dn020_4 dn042_4 dn044_4 ch001_4 ch508_4

save `parent4',replace


*********************************Wave 5*****************************************
*Combine demographic questionnaire-child questionnaire-ISCED codes and technical variables

use "sharew5_rel7-1-0_dn.dta", clear
merge 1:1 mergeid country mergeidp5 hhid5 using "sharew5_rel7-1-0_gv_isced.dta"
 *tab _merge
drop _merge

merge 1:1 mergeid country mergeidp5 hhid5 using "sharew5_rel7-1-0_ch.dta"
 *tab _merge
drop _merge

merge 1:1 mergeid country mergeidp5 hhid5 using "sharew5_rel7-1-0_technical_variables.dta"
 *tab _merge
drop _merge

**************
ren *_ *_5
ren *c *c_5
ren *r *r5
ren *_m *_m5
ren *_f *_f5
ren *sp *sp5
ren country country5
ren language language5

keep mergeid hhid5 mergeidp5 coupleid5 country5 language5 dn002_5 dn003_5 dn040_ dn041_5 dn042_5 isced1997_r5 isced1997_sp5 isced1997_m5 isced1997_f5 isced2011_r5 isced2011_sp5 isced2011_m5 isced2011_f5 mn101_5 dn004_5 dn005c_5 dn006_5 dn007_5 dn008c_5 dn014_5 dn015_5 dn016_5 dn017_5 dn018_5 dn019_5 dn020_5 dn042_5 dn044_5 dn504c_5 dn505c_5 ch001_5 ch508_5

save `parent5',replace



*********************************Wave 6*****************************************
*Combine demographic questionnaire-child questionnaire-ISCED codes and technical variables

use "sharew6_rel7-1-0_dn.dta", clear
merge 1:1 mergeid country mergeidp6 hhid6 using "sharew6_rel7-1-0_gv_isced.dta"
 *tab _merge
drop _merge

merge 1:1 mergeid country mergeidp6 hhid6 using "sharew6_rel7-1-0_ch.dta"
 *tab _merge
drop _merge

merge 1:1 mergeid country mergeidp6 hhid6 using "sharew6_rel7-1-0_technical_variables.dta"
 *tab _merge
drop _merge

**************
ren *_ *_6
ren *c *c_6
ren *r *r6
ren *_m *_m6
ren *_f *_f6
ren *sp *sp6
ren country country6
ren language language6

keep mergeid hhid6 mergeidp6 coupleid6 country6 language6 dn002_6 dn003_6 dn029isco_1 dn029isco_2 dn041_6 dn042_6 dn629_1 dn629_2 isced1997_r6 isced1997_sp6 isced1997_m6 isced1997_f6 isced2011_r6 isced2011_sp6 isced2011_m6 isced2011_f6 mn101_6 dn004_6 dn005c_6 dn006_6 dn007_6 dn008c_6 dn014_6 dn015_6 dn016_6 dn017_6 dn018_6 dn019_6 dn020_6 dn042_6 dn044_6 dn504c_6 dn505c_6 ch001_6 ch508_6

save `parent6',replace



****************************Combined all waves**********************************

use `parent1'
merge 1:1 mergeid using `parent2'
rename _merge merge1

merge 1:1 mergeid using `parent4'
rename _merge merge2

merge 1:1 mergeid using `parent5'
rename _merge merge3

merge 1:1 mergeid using `parent6'
rename _merge merge4

save `parents',replace

/*==============================================================================
                       2: Variable Creation Parents
==============================================================================*/
*-------------------------------------------------------------------------------

use `parents',replace

 ** create language variable
 gen language=language1
 order language, before(language1)
 replace language=language2 if language2!=.
 replace language=language4 if language4!=.
 replace language=language5 if language5!=.
 replace language=language6 if language6!=.
 
// check consistency of data
gen language_key=1 if language!=language1 & language1!=.
replace language_key=1 if language!=language2 & language2!=.
replace language_key=1 if language!=language4 & language4!=.
replace language_key=1 if language!=language5 & language5!=.
replace language_key=1 if language!=language6 & language6!=.
gen language_key2=1 if language1==. & language2==. & language4==. & language5==. & language6==.

replace language_key=0 if language_key!=1 & language_key2!=1

// define variables and values
label values language language
label variable language_key "consistency check for language"
label define consistency_check 1 "inconsistent" 0 "consistent"
label values language_key consistency_check

*-------------------------------------------------------------------------------

** create household id 
 gen hhid=hhid1
 order hhid, before(hhid1)
 replace hhid=hhid2 if hhid2!=""
 replace hhid=hhid4 if hhid4!=""
 replace hhid=hhid5 if hhid5!=""
 replace hhid=hhid6 if hhid6!=""
 
// check consistency of data
gen hhid_key=1 if hhid!=hhid1 & hhid1!=""
replace hhid_key=1 if hhid!=hhid2 & hhid2!=""
replace hhid_key=1 if hhid!=hhid4 & hhid4!=""
replace hhid_key=1 if hhid!=hhid5 & hhid5!=""
replace hhid_key=1 if hhid!=hhid6 & hhid6!=""
gen hhid_key2=1 if hhid1=="" & hhid2=="" & hhid4==""  & hhid5==""  & hhid6=="" 

replace hhid_key=0 if hhid_key!=1 & hhid_key2!=1

// define variables and values
label variable hhid_key "consistency check for household"
label values hhid_key consistency_check

// identify cases where hhid changed
gen hhid_second=hhid if hhid_key==1
order hhid_second, before (hhid1)
replace hhid=hhid1 if hhid1!="" & hhid_key==1
replace hhid=hhid2 if hhid1=="" & hhid2!="" & hhid_key==1
replace hhid=hhid4 if hhid1=="" & hhid2=="" & hhid4!="" & hhid_key==1
replace hhid=hhid5 if hhid1=="" & hhid2=="" & hhid4=="" & hhid5!="" & hhid_key==1

*-------------------------------------------------------------------------------

** create coupleid variable
 gen coupleid=coupleid1
 order coupleid, before(coupleid1)
 replace coupleid=coupleid2 if coupleid2!=""
 replace coupleid=coupleid4 if coupleid4!=""
 replace coupleid=coupleid5 if coupleid5!=""
 replace coupleid=coupleid6 if coupleid6!=""
 
// check consistency of data
gen coupleid_key=1 if coupleid!=coupleid1 & coupleid1!=""
replace coupleid_key=1 if coupleid!=coupleid2 & coupleid2!=""
replace coupleid_key=1 if coupleid!=coupleid4 & coupleid4!=""
replace coupleid_key=1 if coupleid!=coupleid5 & coupleid5!=""
replace coupleid_key=1 if coupleid!=coupleid6 & coupleid6!=""
gen coupleid_key2=1 if coupleid1=="" & coupleid2=="" & coupleid4==""  & coupleid5==""  & coupleid6=="" 

replace coupleid_key=0 if coupleid_key!=1 & coupleid_key2!=1

// define variables and values
label variable coupleid_key "consistency check for couple"
label values coupleid_key consistency_check


// identify cases where coupleid changed
gen coupleid_second=coupleid if coupleid_key==1
order coupleid_second, before (coupleid1)
replace coupleid=coupleid1 if coupleid1!="" & coupleid_key==1
replace coupleid=coupleid2 if coupleid1=="" & coupleid2!="" & coupleid_key==1
replace coupleid=coupleid4 if coupleid1=="" & coupleid2=="" & coupleid4!="" & coupleid_key==1
replace coupleid=coupleid5 if coupleid1=="" & coupleid2=="" & coupleid4=="" & coupleid5!="" & coupleid_key==1

*-------------------------------------------------------------------------------

** create years of education 
 gen dn041_v2=dn041_2
 order dn041_v2, before(dn041_2)
 replace dn041_v2=dn041_4 if dn041_4!=. 
 replace dn041_v2=dn041_5 if dn041_5!=.
 replace dn041_v2=dn041_6 if dn041_6!=. 

 // check consistency of data
gen dn041_v2_key=1 if dn041_v2!=dn041_2 & dn041_2!=. 
replace dn041_v2_key=1 if dn041_v2!=dn041_4 & dn041_4!=. 
replace dn041_v2_key=1 if dn041_v2!=dn041_5 & dn041_5!=. 
replace dn041_v2_key=1 if dn041_v2!=dn041_6 & dn041_6!=. 
order dn041_v2_key, before (dn041_2)
gen dn041_v2_key2=1 if dn041_2==. & dn041_4==. & dn041_5==. & dn041_6==. 
replace dn041_v2_key=0 if dn041_v2_key!=1 & dn041_v2_key2!=1

// define variables and values
label variable dn041_v2 "Respondent years of education v2"
label values dn041_v2 dkrfim
label variable dn041_v2_key "consistency check for years of education v2"
label values dn041_v2_key consistency_check

*-------------------------------------------------------------------------------

** create country variable
 gen country_p=country1
 order country_p, before(country1)
 replace country_p=country2 if country2!=.
 replace country_p=country4 if country4!=.
 replace country_p=country5 if country5!=.
 replace country_p=country6 if country6!=.

// check consistency of data
gen country_p_key=1 if country_p!=country1 & country1!=.
replace country_p_key=1 if country_p!=country2 & country2!=.
replace country_p_key=1 if country_p!=country4 & country4!=.
replace country_p_key=1 if country_p!=country5 & country5!=.
replace country_p_key=1 if country_p!=country6 & country6!=.
gen country_p_key2=1 if country1==. & country2==. & country4==. & country5==. & country6==.
replace country_p_key=0 if country_p_key!=1 & country_p_key2!=1

// define variables and values
label values country_p country
label variable country_p_key "consistency check for country"
label values country_p_key consistency_check

*-------------------------------------------------------------------------------

** create born in country variable
 gen dn004=dn004_1
 order dn004, before(dn004_1)
 replace dn004=dn004_2 if dn004_2!=. & dn004_2!=-1 & dn004_2!=-2 
 replace dn004=dn004_4 if dn004_4!=. & dn004_4!=-1 & dn004_4!=-2 
 replace dn004=dn004_5 if dn004_5!=. & dn004_5!=-1 & dn004_5!=-2 
 replace dn004=dn004_6 if dn004_6!=. & dn004_6!=-1 & dn004_6!=-2 
 
 replace dn004=dn004_2 if dn004==.
 replace dn004=dn004_4 if dn004==.
 replace dn004=dn004_5 if dn004==.
 replace dn004=dn004_6 if dn004==.
 
// check consistency of data
gen dn004_key=1 if dn004!=dn004_1 & dn004_1!=. 
replace dn004_key=1 if dn004!=dn004_2 & dn004_2!=. 
replace dn004_key=1 if dn004!=dn004_4 & dn004_4!=. 
replace dn004_key=1 if dn004!=dn004_5 & dn004_5!=. 
replace dn004_key=1 if dn004!=dn004_6 & dn004_6!=. 
order dn004_key, before (dn004_1)
gen dn004_key2=1 if dn004_1==. & dn004_2==. & dn004_4==. & dn004_5==. & dn004_6==.

replace dn004_key=0 if dn004_key!=1 & dn004_key2!=1

// define variables and values
label values dn004 yesno
label variable dn004 "Born in country"
label variable dn004_key "consistency check for born in country"
label values dn004_key consistency_check

*-------------------------------------------------------------------------------

** foreign country birth code
 gen dn005c=dn005c_1
 order dn005c, before(dn005c_1)
 replace dn005c=dn005c_2 if dn005c_2!=. & dn005c_2!=-4 & dn005c_2!=-1 & dn005c_2!=-2 & dn005c_2!=-7 
 replace dn005c=dn005c_4 if dn005c_4!=. & dn005c_4!=-4 & dn005c_4!=-1 & dn005c_4!=-2 & dn005c_4!=-7 
 replace dn005c=dn005c_5 if dn005c_5!=. & dn005c_5!=-4 & dn005c_5!=-1 & dn005c_5!=-2 & dn005c_5!=-7 
 replace dn005c=dn005c_6 if dn005c_6!=. & dn005c_6!=-4 & dn005c_6!=-1 & dn005c_6!=-2 & dn005c_6!=-7 
 
 replace dn005c=dn005c_2 if dn005c==.
 replace dn005c=dn005c_4 if dn005c==.
 replace dn005c=dn005c_5 if dn005c==.
 replace dn005c=dn005c_6 if dn005c==.
 
// check consistency of data
gen dn005c_key=1 if dn005c!=dn005c_1 & dn005c_1!=. 
replace dn005c_key=1 if dn005c!=dn005c_2 & dn005c_2!=. 
replace dn005c_key=1 if dn005c!=dn005c_4 & dn005c_4!=. 
replace dn005c_key=1 if dn005c!=dn005c_5 & dn005c_5!=. 
replace dn005c_key=1 if dn005c!=dn005c_6 & dn005c_6!=. 
order dn005c_key, before (dn005c_1)
gen dn005c_key2=1 if dn005c_1==. & dn005c_2==. & dn005c_4==. & dn005c_5==. & dn005c_6==.

replace dn005c_key=0 if dn005c_key!=1 & dn005c_key2!=1

// define variables and values
label values dn005c countryofbirth
label variable dn005c "Foreign country birth code"
label variable dn005c_key "consistency check for foreign country birth code"
label values dn005c_key consistency_check

*-------------------------------------------------------------------------------

** year came to live
 gen dn006=dn006_1
 order dn006, before(dn006_1)
 replace dn006=dn006_2 if dn006_2!=. & dn006_2!=-1 & dn006_2!=-2
 replace dn006=dn006_4 if dn006_4!=. & dn006_4!=-1 & dn006_4!=-2
 replace dn006=dn006_5 if dn006_5!=. & dn006_5!=-1 & dn006_5!=-2
 replace dn006=dn006_6 if dn006_6!=. & dn006_6!=-1 & dn006_6!=-2
 
 replace dn006=dn006_2 if dn006==.
 replace dn006=dn006_4 if dn006==.
 replace dn006=dn006_5 if dn006==.
 replace dn006=dn006_6 if dn006==.
 
** check consistency of data
gen dn006_key=1 if dn006!=dn006_1 & dn006_1!=. 
replace dn006_key=1 if dn006!=dn006_2 & dn006_2!=. 
replace dn006_key=1 if dn006!=dn006_4 & dn006_4!=. 
replace dn006_key=1 if dn006!=dn006_5 & dn006_5!=. 
replace dn006_key=1 if dn006!=dn006_6 & dn006_6!=. 
order dn006_key, before (dn006_1)
gen dn006_key2=1 if dn006_1==. & dn006_2==. & dn006_4==. & dn006_5==. & dn006_6==.

replace dn006_key=0 if dn006_key!=1 & dn006_key2!=1

// define variables and values
label values dn006 dkrf
label variable dn006 "Year came to live"
label variable dn006_key "consistency check for year came to live"
label values dn006_key consistency_check

*-------------------------------------------------------------------------------

** citizenship country of interview
 gen dn007=dn007_1
 order dn007, before(dn007_1)
 replace dn007=dn007_2 if dn007_2!=. & dn007_2!=-1 & dn007_2!=-2 
 replace dn007=dn007_4 if dn007_4!=. & dn007_4!=-1 & dn007_4!=-2 
 replace dn007=dn007_5 if dn007_5!=. & dn007_5!=-1 & dn007_5!=-2 
 replace dn007=dn007_6 if dn007_6!=. & dn007_6!=-1 & dn007_6!=-2 
 
 replace dn007=dn007_2 if dn007==.
 replace dn007=dn007_4 if dn007==.
 replace dn007=dn007_5 if dn007==.
 replace dn007=dn007_6 if dn007==.
 
// check consistency of data
gen dn007_key=1 if dn007!=dn007_1 & dn007_1!=. 
replace dn007_key=1 if dn007!=dn007_2 & dn007_2!=. 
replace dn007_key=1 if dn007!=dn007_4 & dn007_4!=. 
replace dn007_key=1 if dn007!=dn007_5 & dn007_5!=. 
replace dn007_key=1 if dn007!=dn007_6 & dn007_6!=. 
order dn007_key, before (dn007_1)
gen dn007_key2=1 if dn007_1==. & dn007_2==. & dn007_4==. & dn007_5==. & dn007_6==.

replace dn007_key=0 if dn007_key!=1 & dn007_key2!=1

// define variables and values
label values dn007 yesno
label variable dn007 "Citizenship country of interview"
label variable dn007_key "consistency check for citizenship country of interview"
label values dn007_key consistency_check

*-------------------------------------------------------------------------------

** other citizenship coding 
 gen dn008c=dn008c_1
 order dn008c, before(dn008c_1)
 replace dn008c=dn008c_2 if dn008c_2!=. & dn008c_2!=-4 & dn008c_2!=-1 & dn008c_2!=-2 & dn008c_2!=-7 
 replace dn008c=dn008c_4 if dn008c_4!=. & dn008c_4!=-4 & dn008c_4!=-1 & dn008c_4!=-2 & dn008c_4!=-7 
 replace dn008c=dn008c_5 if dn008c_5!=. & dn008c_5!=-4 & dn008c_5!=-1 & dn008c_5!=-2 & dn008c_5!=-7 
 replace dn008c=dn008c_6 if dn008c_6!=. & dn008c_6!=-4 & dn008c_6!=-1 & dn008c_6!=-2 & dn008c_6!=-7 
 
 replace dn008c=dn008c_2 if dn008c==.
 replace dn008c=dn008c_4 if dn008c==.
 replace dn008c=dn008c_5 if dn008c==.
 replace dn008c=dn008c_6 if dn008c==.
 
// check consistency of data
gen dn008c_key=1 if dn008c!=dn008c_1 & dn008c_1!=. 
replace dn008c_key=1 if dn008c!=dn008c_2 & dn008c_2!=. 
replace dn008c_key=1 if dn008c!=dn008c_4 & dn008c_4!=. 
replace dn008c_key=1 if dn008c!=dn008c_5 & dn008c_5!=. 
replace dn008c_key=1 if dn008c!=dn008c_6 & dn008c_6!=. 
order dn008c_key, before (dn008c_1)
gen dn008c_key2=1 if dn008c_1==. & dn008c_2==. & dn008c_4==. & dn008c_5==. & dn008c_6==.

replace dn008c_key=0 if dn008c_key!=1 & dn008c_key2!=1

// define variables and values
label values dn008c citizenship
label variable dn008c "Other citizenship coding"
label variable dn008c_key "consistency check for other citizenship coding"
label values dn008c_key consistency_check

*-------------------------------------------------------------------------------

** number of child
 gen ch001=ch001_1
 order ch001, before(ch001_1)
 replace ch001=ch001_2 if ch001_2!=. & ch001_2!=-1 & ch001_2!=-2 
 replace ch001=ch001_4 if ch001_4!=. & ch001_4!=-1 & ch001_4!=-2 
 replace ch001=ch001_5 if ch001_5!=. & ch001_5!=-1 & ch001_5!=-2 
 replace ch001=ch001_6 if ch001_6!=. & ch001_6!=-1 & ch001_6!=-2 
 
 replace ch001=ch001_2 if ch001==.
 replace ch001=ch001_4 if ch001==.
 replace ch001=ch001_5 if ch001==.
 replace ch001=ch001_6 if ch001==.
 
// check consistency of data
gen ch001_key=1 if ch001!=ch001_1 & ch001_1!=. 
replace ch001_key=1 if ch001!=ch001_2 & ch001_2!=. 
replace ch001_key=1 if ch001!=ch001_4 & ch001_4!=. 
replace ch001_key=1 if ch001!=ch001_5 & ch001_5!=. 
replace ch001_key=1 if ch001!=ch001_6 & ch001_6!=. 
order ch001_key, before (ch001_1)
gen ch001_key2=1 if ch001_1==. & ch001_2==. & ch001_4==. & ch001_5==. & ch001_6==.

replace ch001_key=0 if ch001_key!=1 & ch001_key2!=1

// define variables and values
label values ch001 dkrf
label variable ch001 "Number of child"
label variable ch001_key "consistency check for number of child"
label values ch001_key consistency_check

*-------------------------------------------------------------------------------

** children education changed
 gen ch508=ch508_4
 order ch508, before(ch508_4)
 replace ch508=ch508_5 if ch508_5!=. & ch508_5!=-1 & ch508_5!=-2 
 replace ch508=ch508_6 if ch508_6!=. & ch508_6!=-1 & ch508_6!=-2 
 replace ch508=ch508_5 if ch508==.
 replace ch508=ch508_6 if ch508==.

// check consistency of data
gen ch508_key=1 if ch508!=ch508_4 & ch508_4!=. 
replace ch508_key=1 if ch508!=ch508_5 & ch508_5!=. 
replace ch508_key=1 if ch508!=ch508_6 & ch508_6!=. 
order ch508_key, before (ch508_4)
gen ch508_key2=1 if ch508_4==. & ch508_5==. & ch508_6==.

replace ch508_key=0 if ch508_key!=1 & ch508_key2!=1

// define variables and values
label values ch508 yesno
label variable ch508 "Children education changed"
label variable ch508_key "consistency check for change in children's education'"
label values ch508_key consistency_check

*-------------------------------------------------------------------------------

** create month of birth v2 variable
 gen dn002_v2=dn002_1
 order dn002_v2, before(dn002_1)
 replace dn002_v2=dn002_2 if dn002_2!=. & dn002_2!=-1 & dn002_2!=-2 
 replace dn002_v2=dn002_4 if dn002_4!=. & dn002_4!=-1 & dn002_4!=-2 
 replace dn002_v2=dn002_5 if dn002_5!=. & dn002_5!=-1 & dn002_5!=-2 
 replace dn002_v2=dn002_6 if dn002_6!=. & dn002_6!=-1 & dn002_6!=-2 
 
 replace dn002_v2=dn002_2 if dn002_v2==.
 replace dn002_v2=dn002_4 if dn002_v2==.
 replace dn002_v2=dn002_5 if dn002_v2==.
 replace dn002_v2=dn002_6 if dn002_v2==.
 
// check consistency of data
gen dn002_v2_key=1 if dn002_v2!=dn002_1 & dn002_1!=. & dn002_1!=-1 & dn002_1!=-2
replace dn002_v2_key=1 if dn002_v2!=dn002_2 & dn002_2!=. 
replace dn002_v2_key=1 if dn002_v2!=dn002_4 & dn002_4!=. 
replace dn002_v2_key=1 if dn002_v2!=dn002_5 & dn002_5!=. 
replace dn002_v2_key=1 if dn002_v2!=dn002_6 & dn002_6!=. 
order dn002_v2_key, before (dn002_1)
gen dn002_v2_key2=1 if dn002_1==. & dn002_2==. & dn002_4==. & dn002_5==. & dn002_6==.

replace dn002_v2_key=0 if dn002_v2_key!=1 & dn002_v2_key2!=1

// define variables and values
label values dn002_v2 month
label variable dn002_v2"Month of birth"
label variable dn002_v2_key "consistency check for month of birth"
label values dn002_v2_key consistency_check

*-------------------------------------------------------------------------------

** create year of birth v2 variable
gen dn003_v2=dn003_1
 order dn003_v2, before(dn003_1)
 replace dn003_v2=dn003_2 if dn003_2!=. & dn003_2!=-1 & dn003_2!=-2 
 replace dn003_v2=dn003_4 if dn003_4!=. & dn003_4!=-1 & dn003_4!=-2 
 replace dn003_v2=dn003_5 if dn003_5!=. & dn003_5!=-1 & dn003_5!=-2 
 replace dn003_v2=dn003_6 if dn003_6!=. & dn003_6!=-1 & dn003_6!=-2 
 
 replace dn003_v2=dn003_2 if dn003_v2==.
 replace dn003_v2=dn003_4 if dn003_v2==.
 replace dn003_v2=dn003_5 if dn003_v2==.
 replace dn003_v2=dn003_6 if dn003_v2==.
  
// check consistency of data
gen dn003_v2_key=1 if dn003_v2!=dn003_1 & dn003_1!=. 
replace dn003_v2_key=1 if dn003_v2!=dn003_2 & dn003_2!=. 
replace dn003_v2_key=1 if dn003_v2!=dn003_4 & dn003_4!=.
replace dn003_v2_key=1 if dn003_v2!=dn003_5 & dn003_5!=. 
replace dn003_v2_key=1 if dn003_v2!=dn003_6 & dn003_6!=. 
order dn003_v2_key, before (dn003_1)
gen dn003_v2_key2=1 if dn003_1==. & dn003_2==. & dn003_4==. & dn003_5==. & dn003_6==.

replace dn003_v2_key=0 if dn003_v2_key!=1 & dn003_v2_key2!=1

// define variables and values
label values dn003_v2 dkrf
label variable dn003_v2 "Year of birth"
label variable dn003_v2_key "consistency check for year of birth"
label values dn003_v2_key consistency_check

*-------------------------------------------------------------------------------

** create isced1997_r_v2 variable
 gen isced1997_r_v2=isced1997_r1
 order isced1997_r_v2, before(isced1997_r1)
 replace isced1997_r_v2=isced1997_r2 if isced1997_r2!=. & isced1997_r2!=-1 & isced1997_r2!=-2 
 replace isced1997_r_v2=isced1997_r4 if isced1997_r4!=. & isced1997_r4!=-1 & isced1997_r4!=-2 
 replace isced1997_r_v2=isced1997_r5 if isced1997_r5!=. & isced1997_r5!=-1 & isced1997_r5!=-2 
 replace isced1997_r_v2=isced1997_r6 if isced1997_r6!=. & isced1997_r6!=-1 & isced1997_r6!=-2 
 
 replace isced1997_r_v2=isced1997_r2 if isced1997_r_v2==.
 replace isced1997_r_v2=isced1997_r4 if isced1997_r_v2==.
 replace isced1997_r_v2=isced1997_r5 if isced1997_r_v2==.
 replace isced1997_r_v2=isced1997_r6 if isced1997_r_v2==.
 
// check consistency of data
gen isced1997_r_v2_key=1 if isced1997_r_v2!=isced1997_r1 & isced1997_r1!=. 
replace isced1997_r_v2_key=1 if isced1997_r_v2!=isced1997_r2 & isced1997_r2!=. 
replace isced1997_r_v2_key=1 if isced1997_r_v2!=isced1997_r4 & isced1997_r4!=. 
replace isced1997_r_v2_key=1 if isced1997_r_v2!=isced1997_r5 & isced1997_r5!=. 
replace isced1997_r_v2_key=1 if isced1997_r_v2!=isced1997_r6 & isced1997_r6!=. 
order isced1997_r_v2_key, before (isced1997_r_v2)
gen isced1997_r_v2_key2=1 if isced1997_r1==. & isced1997_r2==. & isced1997_r4==. & isced1997_r5==. & isced1997_r6==.

replace isced1997_r_v2_key=0 if isced1997_r_v2_key!=1 & isced1997_r_v2_key2!=1

// define variables and values
label values isced1997_r_v2 isced
label variable isced1997_r_v2 "Respondent ISCED97 coding of education"
label variable isced1997_r_v2_key "consistency check for isced1997"
label values isced1997_r_v2_key consistency_check


*-------------------------------------------------------------------------------

** create gender v2 variable
 gen dn042_v2=dn042_1
 order dn042_v2, before(dn042_1)
 replace dn042_v2=dn042_2 if dn042_2!=. &  dn042_2!=-1  &  dn042_2!=-2 
 replace dn042_v2=dn042_4 if dn042_4!=. &  dn042_4!=-1  &  dn042_4!=-2 
 replace dn042_v2=dn042_5 if dn042_5!=. &  dn042_5!=-1  &  dn042_5!=-2 
 replace dn042_v2=dn042_6 if dn042_6!=. &  dn042_6!=-1  &  dn042_6!=-2 ,
 
 replace dn042_v2=dn042_2 if dn042_v2==.
 replace dn042_v2=dn042_4 if dn042_v2==.
 replace dn042_v2=dn042_5 if dn042_v2==.
 replace dn042_v2=dn042_6 if dn042_v2==.

// check consistency of data
gen dn042_v2_key=1 if dn042_v2!=dn042_2 & dn042_2!=. 
replace dn042_v2_key=1 if dn042_v2!=dn042_4 & dn042_4!=. 
replace dn042_v2_key=1 if dn042_v2!=dn042_5 & dn042_5!=. 
replace dn042_v2_key=1 if dn042_v2!=dn042_6 & dn042_6!=. 
order dn042_v2_key, before (dn042_v2)
gen dn042_v2_key2=1 if dn042_2==. & dn042_4==. & dn042_5==. & dn042_6==. 

replace dn042_v2_key=0 if dn042_v2_key!=1 & dn042_v2_key2!=1

// define variables and values
label values dn042_v2 gender
label variable dn042_v2 "Respondent gender"
label variable dn042_v2_key "consistency check for gender"
label values dn042_v2_key consistency_check

*-------------------------------------------------------------------------------

** create isced1997_m v2 variable
 gen isced1997_m_v2=isced1997_m5
 order isced1997_m_v2, before(isced1997_m5)
 replace isced1997_m_v2=isced1997_m6 if isced1997_m6!=. & isced1997_m6!=-1 & isced1997_m6!=-2 
 replace isced1997_m_v2=isced1997_m5 if isced1997_m_v2==.
 replace isced1997_m_v2=isced1997_m6 if isced1997_m_v2==.
 
// check consistency of data
gen isced1997_m_v2_key=1 if isced1997_m_v2!=isced1997_m5 & isced1997_m5!=. 
replace isced1997_m_v2_key=1 if isced1997_m_v2!=isced1997_m6 & isced1997_m6!=. 
order isced1997_m_v2_key, before (isced1997_m_v2)
gen isced1997_m_v2_key2=1 if isced1997_m5==. & isced1997_m6==. 

replace isced1997_m_v2_key=0 if isced1997_m_v2_key!=1 & isced1997_m_v2_key2!=1

// define variables and values
label values isced1997_m_v2 isced
label variable isced1997_m_v2 "Respondent mother's ISCED97 coding of education"
label variable isced1997_m_v2_key "consistency check for isced1997_m"
label values isced1997_m_v2_key consistency_check

*-------------------------------------------------------------------------------

** create isced1997_f  v2 variable
 gen isced1997_f_v2=isced1997_f5
 order isced1997_f_v2, before(isced1997_f5)
 replace isced1997_f_v2=isced1997_f6 if isced1997_f6!=. & isced1997_f6!=-1 & isced1997_f6!=-2 
 replace isced1997_f_v2=isced1997_f5 if isced1997_f_v2==.
 replace isced1997_f_v2=isced1997_f6 if isced1997_f_v2==.
 
//  check consistency of data
gen isced1997_f_v2_key=1 if isced1997_f_v2!=isced1997_f5 & isced1997_f5!=. 
replace isced1997_f_v2_key=1 if isced1997_f_v2!=isced1997_f6 & isced1997_f6!=. 
order isced1997_f_v2_key, before (isced1997_f_v2)
gen isced1997_f_v2_key2=1 if isced1997_f5==. & isced1997_f6==. 

replace isced1997_f_v2_key=0 if isced1997_f_v2_key!=1 & isced1997_f_v2_key2!=1

// define variables and values
label values isced1997_f_v2 isced
label variable isced1997_f_v2 "Respondent father's ISCED97 coding of education"
label variable isced1997_f_v2_key "consistency check for isced1997_f"
label values isced1997_f_v2_key consistency_check

*-------------------------------------------------------------------------------

** create isced2011_r v2 variable
 gen isced2011_r_v2=isced2011_r5
 order isced2011_r_v2, before(isced2011_r5)
 replace isced2011_r_v2=isced2011_r6 if isced2011_r6!=. & isced2011_r6!=-1 & isced2011_r6!=-2 
 
 replace isced2011_r_v2=isced2011_r5 if isced2011_r_v2==.
 replace isced2011_r_v2=isced2011_r6 if isced2011_r_v2==.
 
// check consistency of data
gen isced2011_r_v2_key=1 if isced2011_r_v2!=isced2011_r5 & isced2011_r5!=.
replace isced2011_r_v2_key=1 if isced2011_r_v2!=isced2011_r6 & isced2011_r6!=. 
order isced2011_r_v2_key, before (isced2011_r5)
gen isced2011_r_v2_key2=1 if isced2011_r5==. & isced2011_r6==. 

replace isced2011_r_v2_key=0 if isced2011_r_v2_key!=1 & isced2011_r_v2_key2!=1

// define variables and values
label values isced2011_r_v2 isced11
label variable isced2011_r_v2 "Respondent ISCED2011 coding of education"
label variable isced2011_r_v2_key "consistency check for isced2011_r"
label values isced2011_r_v2_key consistency_check

*-------------------------------------------------------------------------------

** create isced2011_m v2 variable
 gen isced2011_m_v2=isced2011_m5
 order isced2011_m_v2, before(isced2011_m5)
 replace isced2011_m_v2=isced2011_m6 if isced2011_m6!=. & isced2011_m6!=-1 & isced2011_m6!=-2 
 replace isced2011_m_v2=isced2011_m5 if isced2011_m_v2==.
 replace isced2011_m_v2=isced2011_m6 if isced2011_m_v2==.
 
 
// check consistency of data
gen isced2011_m_v2_key=1 if isced2011_m_v2!=isced2011_m5 & isced2011_m5!=.
replace isced2011_m_v2_key=1 if isced2011_m_v2!=isced2011_m6 & isced2011_m6!=. 
order isced2011_m_v2_key, before (isced2011_m_v2)
gen isced2011_m_v2_key2=1 if isced2011_m5==. & isced2011_m6==. 

replace isced2011_m_v2_key=0 if isced2011_m_v2_key!=1 & isced2011_m_v2_key2!=1

// define variables and values
label values isced2011_m_v2 isced11
label variable isced2011_m_v2 "Respondent mother's ISCED2011 coding of education"
label variable isced2011_m_v2_key "consistency check for isced2011_r"
label values isced2011_m_v2_key consistency_check

*-------------------------------------------------------------------------------

** create isced2011_f v2 variable
 gen isced2011_f_v2=isced2011_f5
 order isced2011_f_v2, before(isced2011_f5)
 replace isced2011_f_v2=isced2011_f6 if isced2011_f6!=. & isced2011_f6!=-1 & isced2011_f6!=-2 
 replace isced2011_f_v2=isced2011_f5 if isced2011_f_v2==.
 replace isced2011_f_v2=isced2011_f6 if isced2011_f_v2==.
 
// check consistency of data
gen isced2011_f_v2_key=1 if isced2011_f_v2!=isced2011_f5 & isced2011_f5!=.
replace isced2011_f_v2_key=1 if isced2011_f_v2!=isced2011_f6 & isced2011_f6!=. 
order isced2011_f_v2_key, before (isced2011_f_v2)
gen isced2011_f_v2_key2=1 if isced2011_f5==. & isced2011_f6==. 

replace isced2011_f_v2_key=0 if isced2011_f_v2_key!=1 & isced2011_f_v2_key2!=1

// define variables and values
label values isced2011_f_v2 isced11
label variable isced2011_f_v2 "Respondent father's ISCED2011 coding of education"
label variable isced2011_f_v2_key "consistency check for isced2011_r"
label values isced2011_f_v2_key consistency_check

*-------------------------------------------------------------------------------

** create years of education variable v3 (not the final version check below)
 gen dn041_v3=dn041_2
 order dn041_v3, before(dn041_2)
 replace dn041_v3=dn041_4 if dn041_4!=. & dn041_4!=-1 & dn041_4!=-2 & dn041_4!=-3
 replace dn041_v3=dn041_5 if dn041_5!=. & dn041_5!=-1 & dn041_5!=-2 & dn041_5!=-3
 replace dn041_v3=dn041_6 if dn041_6!=.  & dn041_6!=-1 & dn041_6!=-2 & dn041_6!=-3

 replace dn041_v3=dn041_4 if dn041_v3==. 
 replace dn041_v3=dn041_5 if dn041_v3==.  
 replace dn041_v3=dn041_6 if dn041_v3==. 
 

// check consistency of data
gen dn041_v3_key=1 if dn041_v3!=dn041_2 & dn041_2!=. 
replace dn041_v3_key=1 if dn041_v3!=dn041_4 & dn041_4!=. 
replace dn041_v3_key=1 if dn041_v3!=dn041_5 & dn041_5!=. 
replace dn041_v3_key=1 if dn041_v3!=dn041_6 & dn041_6!=. 
order dn041_v3_key, before (dn041_v3)
gen dn041_v3_key2=1 if dn041_2==. & dn041_4==. & dn041_5==. & dn041_6==. 

replace dn041_v3_key=0 if dn041_v3_key!=1 & dn041_v3_key2!=1

// define variables and values
label values dn041_v3 dkrfim
label variable dn041_v3 "Respondent years of education v3"
label variable dn041_v3_key "consistency check for years of education v3"
label define consistency_check2 -1 "missing value" 0 "consistent" 1 "inconsistent"
label values dn041_v3_key consistency_check2

*-------------------------------------------------------------------------------
** create years of education variable v4 ( final variable)
//self-reported years of education is not available in the first wave. Combined the final variable with imputed years of education (by SHARE) if individual only attended the first wave. 
gen dn041_v4=dn041_v3
replace dn041_v4=isced1997y_r1 if dn041_v4==.
replace dn041_v4=isced1997y_r1 if dn041_v4==-3 & isced1997y_r1!=. & isced1997y_r1!=-1 & isced1997y_r1!=-2 & isced1997y_r1!=-3
replace dn041_v4=isced1997y_r1 if dn041_v4==-2 & isced1997y_r1!=. & isced1997y_r1!=-1 & isced1997y_r1!=-2 & isced1997y_r1!=-3
replace dn041_v4=isced1997y_r1 if dn041_v4==-1 & isced1997y_r1!=. & isced1997y_r1!=-1 & isced1997y_r1!=-2 & isced1997y_r1!=-3

// check consistency of data
gen dn041_v4_key=2 if dn041_v3_key==-1 & isced1997y_r1!=. 
replace dn041_v4_key=1 if dn041_v3_key!=-1 & isced1997y_r1!=. & dn041_v4!=dn041_v3
replace dn041_v4_key=-1 if dn041_v4==.
replace dn041_v4_key=0 if dn041_v4_key==.
replace dn041_v4_key=1 if dn041_v3_key==1 & dn041_v4_key==0

// define variables and values
label variable dn041_v4_key "consistency check for years of education v4"
label define consistency_check3 -1 "missing value" 0 "consistent" 1 "inconsistent" 2 "Imputation-ISCED"
label values dn041_v4_key consistency_check3

*-------------------------------------------------------------------------------

** country of birth mother
 gen dn504c=dn504c_5
 order dn504c, before(dn504c_5)
 replace dn504c=dn504c_6 if dn504c_6!=. & dn504c_6!=-4 & dn504c_6!=-1 & dn504c_6!=-2 & dn504c_6!=-7 
 
 replace dn504c=dn504c_6 if dn504c==.
 
// check consistency of data
gen dn504c_key=1 if dn504c!=dn504c_5 & dn504c_5!=. 
replace dn504c_key=1 if dn504c!=dn504c_6 & dn504c_6!=. 
order dn504c_key, before (dn504c)
gen dn504c_key2=1 if dn504c_5==. & dn504c_6==. 

replace dn504c_key=0 if dn504c_key!=1 & dn504c_key2!=1

// define variables and values
label values dn504c countryofbirth
label variable dn504c "mother: country birth code"
label variable dn504c_key "consistency check for mother: country birth code"
label values dn504c_key consistency_check

*-------------------------------------------------------------------------------

** country of birth father
 gen dn505c=dn505c_5
 order dn505c, before(dn505c_5)
 replace dn505c=dn505c_6 if dn505c_6!=. & dn505c_6!=-4 & dn505c_6!=-1 & dn505c_6!=-2 & dn505c_6!=-7 
 
 replace dn505c=dn505c_6 if dn505c==.
 
// check consistency of data
gen dn505c_key=1 if dn505c!=dn505c_5 & dn505c_5!=. 
replace dn505c_key=1 if dn505c!=dn505c_6 & dn505c_6!=. 
order dn505c_key, before (dn505c)
gen dn505c_key2=1 if dn505c_5==. & dn505c_6==. 

replace dn505c_key=0 if dn505c_key!=1 & dn505c_key2!=1

// define variables and values
label values dn505c countryofbirth
label variable dn505c "father: country birth code"
label variable dn505c_key "consistency check for father: country birth code"
label values dn505c_key consistency_check

*-------------------------------------------------------------------------------
** identify first wave respondent attended

gen first_wave=1 if hhid1!=""
replace first_wave=2 if hhid1=="" & hhid2!=""
replace first_wave=4 if hhid1=="" & hhid2=="" & hhid4!=""
replace first_wave=5 if hhid1=="" & hhid2=="" & hhid4=="" & hhid5!=""
replace first_wave=6 if hhid1=="" & hhid2=="" & hhid4=="" & hhid5=="" & hhid6!=""

*-------------------------------------------------------------------------------
** clonevar country
clonevar country = country_p

*-------------------------------------------------------------------------------
** identify cases corresponding variable missing in all waves.

 replace country_p_key=-1 if country_p_key2==1
 replace dn004_key=-1 if dn004_key2==1
 replace dn006_key=-1 if dn006_key2==1
 replace dn007_key=-1 if dn007_key2==1
 replace dn008c_key=-1 if dn008c_key2==1
 replace dn005c_key=-1 if dn005c_key2==1
 replace ch001_key=-1 if ch001_key2==1
 replace ch508_key=-1 if ch508_key2==1
 replace dn002_v2_key=-1 if dn002_v2_key2==1
 replace dn003_v2_key=-1 if dn003_v2_key2==1
 replace isced1997_r_v2_key=-1 if isced1997_r_v2_key2==1
 replace dn042_v2_key=-1 if dn042_v2_key2==1
 replace  isced1997_m_v2_key=-1 if isced1997_m_v2_key2==1
 replace  isced1997_f_v2_key=-1 if isced1997_f_v2_key2==1
 replace isced2011_r_v2_key=-1 if isced2011_r_v2_key2==1
 replace isced2011_m_v2_key=-1 if isced2011_m_v2_key2==1 
 replace isced2011_f_v2_key=-1 if isced2011_f_v2_key2==1
 replace dn041_v3_key=-1 if dn041_v3_key2==1
 replace dn504c_key=-1 if dn504c_key2==1
 replace dn505c_key=-1 if dn505c_key2==1
 replace language_key=-1 if language_key2==1
 replace hhid_key=-1 if hhid_key2==1
 replace coupleid_key=-1 if coupleid_key2==1
 
 *-------------------------------------------------------------------------------
** keep necessary variables and save

keep mergeid country_p country_p_key dn004 dn004_key dn005c dn005c_key dn006 dn006_key dn007 dn007_key dn008c dn008c_key ch001 ch001_key ch508 ch508_key hhid hhid_key hhid_second coupleid coupleid_key coupleid_second language_key language dn002_v2 dn002_v2_key dn003_v2 dn003_v2_key  isced1997_r_v2_key isced1997_r_v2  isced2011_r_v2_key  isced2011_r_v2  dn042_v2_key dn042_v2  isced1997_m_v2_key isced1997_m_v2  isced1997_f_v2_key isced1997_f_v2 isced2011_m_v2_key isced2011_m_v2  isced2011_f_v2_key isced2011_f_v2 dn504c_key dn504c dn505c_key dn505c  first_wave  dn041_v4 dn041_v4_key 

label variable country_p "Country identifier"
label variable hhid "Household id"
label variable hhid_second "hhid for new couples"
label variable coupleid "Coupleid of respondent and partner"
label variable coupleid_second "Coupleid for new couples"
label variable language "Language of questionnaire"
label variable dn041_v4 "Respondent: years of schooling v4"
label variable dn041_v4_key "consistency check for years of education"
label variable first_wave "First wave id of respondent"

save `parents',replace

/*==============================================================================
                       3: Construction of Parents Datasets
==============================================================================*/

use `parents',replace

preserve
keep mergeid country_p country_p_key dn003_v2 dn003_v2_key dn004 dn004_key dn005c dn005c_key dn006 dn006_key isced1997_r_v2_key isced1997_r_v2 dn042_v2_key dn042_v2 dn041_v4 dn041_v4_key
rename country_p country

save `mergeid', replace
restore


preserve
keep mergeid country_p country_p_key dn003_v2 dn003_v2_key dn004 dn004_key dn005c dn005c_key dn006 dn006_key isced1997_r_v2_key isced1997_r_v2 dn042_v2_key dn042_v2 dn041_v4 dn041_v4_key

rename mergeid mergeidp
rename country_p country
rename country_p_key partner_country_p_key
rename dn003_v2 partner_dn003_v2
rename dn003_v2_key partner_dn003_v2_key
rename dn004 partner_dn004
rename dn004_key partner_dn004_key
rename dn005c partner_dn005c
rename dn005c_key partner_dn005c_key
rename dn006 partner_dn006
rename dn006_key partner_dn006_key
rename isced1997_r_v2_key partner_isced1997_r_v2_key
rename isced1997_r_v2 partner_isced1997_r_v2
rename dn042_v2 partner_dn042_v2
rename dn042_v2_key partner_dn042_v2_key
rename dn041_v4 partner_dn041_v4
rename dn041_v4_key partner_dn041_v4_key

label variable partner_country_p_key "Partner:consistency check for country"
label variable partner_dn004 "Partner:Born in country"
label variable partner_dn004_key "Partner:consistency check for born in country"
label variable partner_dn005c "Partner:Foreign country birth code"
label variable partner_dn005c_key "Partner:consistency check for foreign country birth code"
label variable partner_dn006 "Partner:Year came to live"
label variable partner_dn006_key "Partner:consistency check for year came to live"
label variable partner_dn003_v2 "Partner:Year of birth"
label variable partner_dn003_v2_key "Partner:consistency check for year of birth"
label variable partner_isced1997_r_v2_key "Partner:consistency check for isced1997"
label variable partner_isced1997_r_v2 "Partner:Respondent ISCED97 coding of education"
label variable partner_dn042_v2_key "Partner:consistency check for gender"
label variable partner_dn042_v2 "Partner:Respondent gender"
label variable partner_dn041_v4 "Partner:years of schooling v4"
label variable partner_dn041_v4_key "Partner:consistency check for years of education"


save `mergeidp', replace
restore

*----------------------------END OF DO FILE-------------------------------------
*-------------------------------------------------------------------------------

