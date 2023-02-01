
/*==============================================================================
                       1: Creation of Main Children Dataset
==============================================================================*/
*-----------------Created a dataset reports interview year-----------------------

use "sharewX_rel7-1-0_gv_allwaves_cv_r.dta" 
keep mergeid country int_year_w1 int_year_w2 int_year_w3 int_year_w4 int_year_w5 int_year_w6 int_year_w7 int_month_w1 int_month_w2 int_month_w3 int_month_w4 int_month_w5 int_month_w6 int_month_w7
save `interview_date', replace

use `interview_date', replace

keep mergeid country int_year_w1 int_year_w2 int_year_w3 int_year_w4 int_year_w5 int_year_w6 int_year_w7 int_month_w1 int_month_w2 int_month_w3 int_month_w4 int_month_w5 int_month_w6 int_month_w7
rename mergeid mergeidp
ren int* partner_int*

save `partner_interview_date', replace

*---------------Combined children datasets from different waves-----------------

use `wave1_child', replace

// merge with wave 2
merge 1:1 coupleid country gender year_birth using `wave2_child'

rename _merge one_two
label define one_two 3 "Avaiable first and second wave" 2 "Only second wave" 1 "Only first wave"
label values one_two one_two

// merge with wave 4
merge 1:1 coupleid country gender year_birth using `wave4_child'

gen one_two_four=6 if one_two==3 & _merge==3
replace one_two_four=5 if one_two==1 & _merge==3
replace one_two_four=4 if one_two==2 & _merge==3
replace one_two_four=3 if _merge==2
replace one_two_four=2 if one_two==2 &_merge==1
replace one_two_four=1 if one_two==1 &_merge==1
replace one_two_four=0 if one_two==3 & w4_mergeid==""
drop _merge

label define one_two_four 6 "Available in 1-2-4 waves" 5 "Available in 1&4 waves" 4 "Available in 2&4 waves" 3 "Available in only 4" 2 "Available in only 2" 1 "Available in only 1"
label values one_two_four one_two_four
label define one_two_four 0 "1&2", add

// merge with wave 5
merge 1:1 coupleid country gender year_birth using `wave5_child'

gen one_two_four_five=12 if one_two_four==6 & _merge==3
replace one_two_four_five=11 if one_two_four==6 & _merge==1
replace one_two_four_five=10 if one_two_four==5 & _merge==3
replace one_two_four_five=9 if one_two_four==5 & _merge==1
replace one_two_four_five=8 if one_two_four==4 & _merge==3
replace one_two_four_five=7 if one_two_four==4 & _merge==1
replace one_two_four_five=6 if one_two_four==3 & _merge==3
replace one_two_four_five=6 if one_two_four==3 & _merge==1
replace one_two_four_five=5 if one_two_four==3 & _merge==1
replace one_two_four_five=4 if one_two_four==2 & _merge==3
replace one_two_four_five=3 if one_two_four==2 & _merge==1
replace one_two_four_five=2 if one_two_four==1 & _merge==3
replace one_two_four_five=1 if one_two_four==1 & _merge==1
replace one_two_four_five=0 if _merge==2
replace one_two_four_five=13 if one_two_four==0 & _merge==3
replace one_two_four_five=14 if one_two_four==0 & _merge==1
drop _merge

label define one_two_four_five 12 "Available in 1&2&4&5 waves" 11 "1&2&4 waves" 10 "1&4&5 waves" 9 "1&4 waves" 8 "2&4&5 waves" 7 "2&4 waves" 6 "4&5 waves" 5 "Only in wave4" 4 "2&5 waves" 3 "Only in wave2" 2 "1&5 waves" 1 "Only in wave1" 0 "Only in wave5"
label define one_two_four_five 13 "1&2&5", add
label define one_two_four_five 14 "1&2", add

label values one_two_four_five one_two_four_five
label variable one_two "Availability in first two waves"
label variable one_two_four "Availability in first three waves"
label variable one_two_four_five "Availability in first four waves"
label variable w1_inconsistent_child_no "child number inconsistent in wave1"
label variable w2_inconsistent_child_no "child number inconsistent in wave2"
label variable w4_inconsistent_child_no "child number inconsistent in wave4"
label variable w5_inconsistent_child_no "child number inconsistent in wave5"

// merge with wave 6
merge 1:1 coupleid country gender year_birth using `wave6_child'

gen wave_info=1 if one_two_four_five==0 & _merge==1
 replace wave_info=2 if one_two_four_five==0 & _merge==3
 replace wave_info=3 if one_two_four_five==1 & _merge==1
 replace wave_info=4 if one_two_four_five==1 & _merge==3
 replace wave_info=5 if one_two_four_five==2 & _merge==1
 replace wave_info=6 if one_two_four_five==2 & _merge==3
 replace wave_info=7 if one_two_four_five==3 & _merge==1
 replace wave_info=8 if one_two_four_five==3 & _merge==3
 replace wave_info=9 if one_two_four_five==4 & _merge==1
 replace wave_info=10 if one_two_four_five==4 & _merge==3
 replace wave_info=11 if one_two_four_five==5 & _merge==1
 replace wave_info=12 if one_two_four_five==5 & _merge==3
 replace wave_info=13 if one_two_four_five==6 & _merge==1
 replace wave_info=14 if one_two_four_five==6 & _merge==3
 replace wave_info=15 if one_two_four_five==7 & _merge==1
 replace wave_info=16 if one_two_four_five==7 & _merge==3
 replace wave_info=17 if one_two_four_five==8 & _merge==1
 replace wave_info=18 if one_two_four_five==8 & _merge==3
 replace wave_info=19 if one_two_four_five==9 & _merge==1
 replace wave_info=20 if one_two_four_five==9 & _merge==3
 replace wave_info=21 if one_two_four_five==10 & _merge==1
 replace wave_info=22 if one_two_four_five==10 & _merge==3
 replace wave_info=23 if one_two_four_five==11 & _merge==1
 replace wave_info=24 if one_two_four_five==11 & _merge==3
 replace wave_info=25 if one_two_four_five==12 & _merge==1
 replace wave_info=26 if one_two_four_five==12 & _merge==3
 replace wave_info=0 if _merge==2
replace wave_info=27 if one_two_four_five==13 & _merge==1
replace wave_info=28 if one_two_four_five==13 & _merge==3
replace wave_info=29 if one_two_four_five==14 & _merge==1
replace wave_info=30 if one_two_four_five==14 & _merge==3
 
drop _merge 
label define wave_info 0 "only wave 6" 1 "only wave 5" 2 "5&6" 3 "only wave 1" 4 "1&6" 5 "1&5" 6 "1&5&6" 7 "only wave 2" 8 "2&6" 9 "2&5" 10 "2&5&6" 11 "only wave 4" 12 "4&6" 13 "4&5" 14 "4&5&6" 15 "2&4" 16 "2&4&6" 17 "2&4&5" 18 "2&4&5&6" 19 "1&4" 20 "1&4&6" 21 "1&4&5" 22 "1&4&5&6" 23 "1&2&4" 24 "1&2&4&6" 25 "1&2&4&5" 26 "1&2&4&5&6"
 
label values wave_info wave_info
label define wave_info 27 "1&2&5", add
label define wave_info 28 "1&2&5&6", add
label define wave_info 29 "1&2", add
label define wave_info 30 "1&2&6", add
 
label variable w6_inconsistent_child_no "child number inconsistent in wave6"

*---------------------------Renamed and labelled variables--------------------------

// rename variables for consistency
rename w1_ch001_ w1_siblings_no
rename w1_ch002_ w1_all_natural
rename w1_ch010_ w1_step_child
rename w1_ch011_ w1_own_child
rename w1_ch015_ w1_move_out
rename w1_ch016_ w1_occupation
rename w1_chselch w1_number_selected_child
rename w1_isced1997_c w1_isced1997
rename w1_isced1997y_c w1_isced1997y
rename w2_ch001_ w2_siblings_no
rename w2_ch002_ w2_all_natural
rename w2_ch010_ w2_step_child
rename w2_ch011_ w2_own_child
rename w2_ch015_ w2_move_out
rename w2_ch016_ w2_occupation
rename w2_chselch w2_number_selected_child
rename w2_isced1997_c w2_isced1997
rename w4_ch001_ w4_siblings_no
rename w4_ch002_ w4_natural_child
rename w4_ch010_ w4_step_child
rename w4_ch011_ w4_own_child
rename w4_ch015_ w4_move_out
rename w4_ch016_ w4_occupation
rename w4_ch508_ w4_education_changed
rename w4_isced1997_c w4_isced1997
rename w5_ch001_ w5_siblings_no
rename w5_ch002_ w5_natural_child
rename w5_ch010_ w5_step_child
rename w5_ch011_ w5_own_child
rename w5_ch015_ w5_move_out
rename w5_ch016_ w5_occupation
rename w5_ch508_ w5_education_changed
rename w5_isced1997_c w5_isced1997
rename w5_isced2011_c w5_isced2011
rename w6_ch001 w6_siblings_no

// order variables
order coupleid,before (w1_mergeid)
order gender, before (w1_mergeid)
order year_birth, before (w1_mergeid)
order w2_mergeid, before (w1_hhid)
order w4_mergeid, before (w1_hhid)
order w5_mergeid, before (w1_hhid)
order w6_mergeid, before (w1_hhid)
order w2_hhid, before (w1_mergeidp)
order w4_hhid, before (w1_mergeidp)
order w5_hhid, before (w1_mergeidp)
order w6_hhid, before (w1_mergeidp)
order w2_mergeidp, before (country)
order w4_mergeidp, before (country)
order w5_mergeidp, before (country)
order w6_mergeidp, before (country)
order coupleid, before (country)
order w2_language, before (w1_siblings_no)
order w4_language, before (w1_siblings_no)
order w5_language, before (w1_siblings_no)
order w6_language, before (w1_siblings_no)
order w1_siblings_no, before (w2_siblings_no)
order w2_siblings_no, before (w1_mergeid)
order w4_siblings_no, before (w1_mergeid)
order w5_siblings_no, before (w1_mergeid)
order w6_siblings_no, before (w1_mergeid)
order w1_move_out, before (w1_mergeid)
order w2_move_out, before (w1_mergeid)
order w4_move_out, before (w1_mergeid)
order w5_move_out, before (w1_mergeid)
order w6_move_out, before (w1_mergeid)
order w1_isced1997, before (w1_siblings_no)
order w2_isced1997, before (w1_siblings_no)
order w4_isced1997, before (w1_siblings_no)
order w5_isced1997, before (w1_siblings_no)
order w6_isced1997, before (w1_siblings_no)
order w1_isced1997y, before (w1_siblings_no)
order w5_isced2011, before (w1_siblings_no)
order w6_isced2011, before (w1_siblings_no)
order w1_occupation, before (w1_siblings_no)
order w2_occupation, before (w1_siblings_no)
order w4_occupation, before (w1_siblings_no)
order w5_occupation, before (w1_siblings_no)
order w6_occupation, before (w1_siblings_no)
order w1_all_natural, before (w1_mergeid)
order w2_all_natural, before (w1_mergeid)
order w4_natural_child, before (w1_mergeid)
order w5_natural_child, before (w1_mergeid)
order w6_relation, before (w1_mergeid)
order w1_fam_resp, before (w1_step_child)
order w2_fam_resp, before (w1_step_child)
order w4_fam_resp, before (w1_step_child)
order w5_fam_resp, before (w1_step_child)
order w6_fam_resp, before (w1_step_child)
order w1_child_no, before (w1_step_child)
order w2_child_no, before (w1_step_child)
order w4_child_no, before (w1_step_child)
order w5_child_no, before (w1_step_child)
order w6_child_no, before (w1_step_child)
order w1_wave, before (w1_step_child)
order w2_wave, before (w1_step_child)
order w4_wave, before (w1_step_child)
order w5_wave, before (w1_step_child)
order w6_wave, before (w1_step_child)
order w2_mn101, before (w1_step_child)
order w4_mn101, before (w1_step_child)
order w5_mn101, before (w1_step_child)
order w6_mn101, before (w1_step_child)
order w1_inconsistent_child_no, before (w1_step_child)
order w2_inconsistent_child_no, before (w1_step_child)
order w4_inconsistent_child_no, before (w1_step_child)
order w5_inconsistent_child_no, before (w1_step_child)
order w6_inconsistent_child_no, before (w1_step_child)
order w1_number_selected_child, before (w1_wave)
order w2_number_selected_child, before (w1_wave)
order w1_step_child, before (w6_relation)
order w2_step_child, before (w6_relation)
order w4_step_child, before (w6_relation)
order w5_step_child, before (w6_relation)
order w1_own_child, before (w6_relation)
order w2_own_child, before (w6_relation)
order w4_own_child, before (w6_relation)
order w5_own_child, before (w6_relation)
order w6_proximity, before (w1_mergeid)
order w6_closeness, before (w1_mergeid)
order one_two_four, after(one_two)
order one_two_four_five, after(one_two_four)
order wave_info, before (gender)

// label variables
label variable gender "Gender"
label variable year_birth "Year of birth"
label variable w1_isced1997 "Wave1: ISCED-97 coding of education"
label variable w2_isced1997 "Wave2: ISCED-97 coding of education"
label variable w4_isced1997 "Wave4: ISCED-97 coding of education"
label variable w5_isced1997 "Wave5: ISCED-97 coding of education"
label variable w6_isced1997 "Wave6: ISCED-97 coding of education"
label variable w1_isced1997y "Wave 1: years of education derived from ISCED-97"
label variable w5_isced2011 "Wave5: ISCED-11 coding of education"
label variable w6_isced2011 "Wave6: ISCED-11 coding of education"
label variable w6_occupation "Wave6: employment status, based on ch016"
label variable w5_occupation "Wave5: employment status, based on ch016"
label variable w4_occupation "Wave4: employment status, based on ch016"
label variable w2_occupation "Wave2: employment status, based on ch016"
label variable w1_occupation "Wave1: employment status, based on ch016"
label variable w1_move_out "Wave1: year moved out from home, based on ch015"
label variable w2_move_out "Wave2: year moved out from home, based on ch015"
label variable w4_move_out "Wave4: year moved out from home, based on ch015"
label variable w5_move_out "Wave5: year moved out from home, based on ch015"
label variable w6_move_out "Wave6: year moved out from home, based on ch015"
label variable w1_siblings_no "Wave1: parents' number of children, based on ch001"
label variable w2_siblings_no "Wave2: parents' number of children, based on ch001"
label variable w4_siblings_no "Wave4: parents' number of children, based on ch001"
label variable w5_siblings_no "Wave5: parents' number of children, based on ch001"
label variable w6_siblings_no "Wave6: parents' number of children, based on ch001"
label variable w1_all_natural "Wave1: all children are parent's natural children"
label variable w1_all_natural "Wave1: all children are parent's natural children, based on ch002"
label variable w2_all_natural "Wave2: all children are parent's natural children, based on ch002"
label variable w4_natural_child "Wave4: Child is natural child, based on ch002"
label variable w5_natural_child "Wave5: Child is natural child, based on ch002"
label variable w1_step_child "Wave1: Child is step, adoptive or foster child, based on ch010"
label variable w2_step_child "Wave2: Child is step, adoptive or foster child, based on ch010"
label variable w4_step_child "Wave4: Child is step, adoptive or foster child, based on ch010"
label variable w5_step_child "Wave5: Child is step, adoptive or foster child, based on ch010"
label variable w1_own_child "Wave1: Child is parent's own child, based on ch011"
label variable w2_own_child "Wave2: Child is parent's own child, based on ch011"
label variable w4_own_child "Wave4: Child is parent's own child, basedon ch011"
label variable w5_own_child "Wave5: Child is parent's own child, basedon ch011"
label variable w6_relation "Wave6:Relation to child, based on ch302_, ch303_1 and ch102_1 to ch108_1"
label variable w6_proximity "Wave6: Proximity to child, based on ch007_1, ch526_1 or sn006_1"
label variable w6_closeness "Wave6: Emotional closeness to child (only if child in SN)"
label variable w1_mergeid "Wave1: family respondent id"
label variable w2_mergeid "Wave2: family respondent id"
label variable w4_mergeid "Wave4: family respondent id"
label variable w5_mergeid "Wave5: family respondent id"
label variable w6_mergeid "Wave6: family respondent id"
label variable w1_mergeidp "Partner identifier of family respondent (wave 1)"
label variable w2_mergeidp "Partner identifier of family respondent(wave 2)"
label variable w2_mergeidp "Partner identifier of family respondent (wave 2)"
label variable w4_mergeidp "Partner identifier of family respondent (wave 4)"
label variable w5_mergeidp "Partner identifier of family respondent (wave 5)"
label variable w6_mergeidp "Partner identifier of family respondent (wave 6)"
label variable w1_language "Wave1:Language of questionnaire"
label variable w2_language "Wave2:Language of questionnaire"
label variable w4_language "Wave4:Language of questionnaire"
label variable w5_language "Wave5:Language of questionnaire"
label variable w6_language "Wave6:Language of questionnaire"
label variable w1_fam_resp "Wave1: Family respondent check"
label variable w2_fam_resp "Wave2: Family respondent check"
label variable w4_fam_resp "Wave4: Family respondent check"
label variable w5_fam_resp "Wave5: Family respondent check"
label variable w6_fam_resp "Wave5: Family respondent check"
label variable w1_child_no "Wave1: child's order"
label variable w2_child_no "Wave2: child's order"
label variable w4_child_no "Wave4: child's order"
label variable w5_child_no "Wave5: child's order"
label variable w6_child_no "Wave6: child's order"
label variable w1_number_selected_child "Wave1: selected child number,based on chselch"
label variable w2_number_selected_child "Wave2: selected child number,based on chselch"
label variable w2_mn101_ "Wave2: Questionnaire version"
label variable w4_mn101_ "Wave2: Questionnaire version"
label variable w4_mn101_ "Wave4: Questionnaire version"
label variable w5_mn101_ "Wave5: Questionnaire version"
label variable w6_mn101 "Wave6: Questionnaire version"
label variable w1_inconsistent_child_no "number of child is inconsistent in wave1"
label variable w2_inconsistent_child_no "number of child is inconsistent in wave2"
label variable w4_inconsistent_child_no "number of child is inconsistent in wave4"
label variable w5_inconsistent_child_no "number of child is inconsistent in wave5"
label variable w6_inconsistent_child_no "number of child is inconsistent in wave6"
label variable w4_education_changed "Wave4: there is a change in the education info of one of the children"
label variable w5_education_changed "Wave4: there is a change in the education info of one of the children"
label variable w4_education_changed "Wave4: change in children education, based on ch508"
label variable w5_education_changed "Wave5: change in children education, based on ch508"
label variable w4_wave "wave of survey"
label variable w5_wave "wave of survey"
label variable w6_wave "wave of survey"
label variable wave_info "waves children observed"
rename w1_siblings_no w1_number_of_children
rename  w2_siblings_no w2_number_of_children
rename  w4_siblings_no w4_number_of_children
rename  w5_siblings_no w5_number_of_children
rename  w6_siblings_no w6_number_of_children

/*==============================================================================
                       2: Variable Preparation Children
==============================================================================*/

// define questionnaire version for wave 1
gen w1_mn101=0 if one_two==1
replace w1_mn101=0 if one_two==3
label values w1_mn101 mn101_
order w1_mn101, before (w2_mn101)
label variable w1_mn101 "Wave1: Questionnaire version"


// fix the problem in wave info where observations available in 1&2&6 and 1&2&5
replace wave_info=27 if w1_mergeid!="" & w2_mergeid!="" & w5_mergeid!="" & w6_mergeid=="" & w4_mergeid==""
replace wave_info=30 if w1_mergeid!="" & w2_mergeid!="" & w6_mergeid!="" & w5_mergeid=="" & w4_mergeid==""
replace one_two_four_five=13 if w1_mergeid!="" & w2_mergeid!="" & w5_mergeid!="" & w6_mergeid=="" & w4_mergeid==""
replace one_two_four_five=14 if w1_mergeid!="" & w2_mergeid!="" & w6_mergeid!="" & w5_mergeid=="" & w4_mergeid==""

// identify last_wave child attended
gen last_wave=6 if wave_info==0
replace last_wave=5 if wave_info==1
replace last_wave=6 if wave_info==2
replace last_wave=1 if wave_info==3
replace last_wave=6 if wave_info==4
replace last_wave=5 if wave_info==5
replace last_wave=6 if wave_info==6
replace last_wave=2 if wave_info==7
replace last_wave=6 if wave_info==8
replace last_wave=5 if wave_info==9
replace last_wave=6 if wave_info==10
replace last_wave=4 if wave_info==11
replace last_wave=6 if wave_info==12
replace last_wave=5 if wave_info==13
replace last_wave=6 if wave_info==14
replace last_wave=4 if wave_info==15
replace last_wave=6 if wave_info==16
replace last_wave=5 if wave_info==17
replace last_wave=6 if wave_info==18
replace last_wave=4 if wave_info==19
replace last_wave=6 if wave_info==20
replace last_wave=5 if wave_info==21
replace last_wave=6 if wave_info==22
replace last_wave=4 if wave_info==23
replace last_wave=6 if wave_info==24
replace last_wave=5 if wave_info==25
replace last_wave=6 if wave_info==26
replace last_wave=5 if wave_info==27
replace last_wave=6 if wave_info==28
replace last_wave=2 if wave_info==29
replace last_wave=6 if wave_info==30

** define main variables for the children observed in a unique wave 

// define isced97 for the observations only available in a unique wave.
gen isced97=w1_isced1997 if wave_info==3
replace isced97=w2_isced1997 if wave_info==7
replace isced97=w4_isced1997 if wave_info==11
replace isced97=w5_isced1997 if wave_info==1
replace isced97=w6_isced1997 if wave_info==0

// define occupation for the observations only available in a unique wave.
gen occupation=w1_occupation if wave_info==3
replace occupation=w2_occupation if wave_info==7
replace occupation=w4_occupation if wave_info==11
replace occupation=w5_occupation if wave_info==1
replace occupation=w6_occupation if wave_info==0

// define number_children for the observations only available in a unique wave.
gen number_children=w1_number_of_children if wave_info==3
replace number_children=w2_number_of_children if wave_info==7
replace number_children=w4_number_of_children if wave_info==11
replace number_children=w5_number_of_children if wave_info==1
replace number_children=w6_number_of_children if wave_info==0

// define move_out for the observations only available in a unique wave.
gen move_out=w1_move_out if wave_info==3
replace move_out=w2_move_out if wave_info==7
replace move_out=w4_move_out if wave_info==11
replace move_out=w5_move_out if wave_info==1
replace move_out=w6_move_out if wave_info==0

// label variables
label values number_children dkrf
label variable last_wave "Last wave that child attend the survey"
label variable isced97 "Isced97 coding of education"
label variable occupation "Employment status "
label variable number_children "Number of children, child's parent's have"
label variable move_out "Year move out from home"
label values move_out dkrf

// order variable
order isced97, before(w1_isced1997)
order occupation, before(w1_occupation)
order number_children, before(w1_number_of_children)
order move_out, before(w1_move_out)
 
 ** define main variables for children observed more than one wave

// flag the observations where isced97 is missing in the last wave where children observed
gen y=1 if w1_isced1997==. & last_wave==1 & wave_info!=3
replace y=1 if w2_isced1997==. & last_wave==2 & wave_info!=7
replace y=1 if w4_isced1997==. & last_wave==4 & wave_info!=11
replace y=1 if w5_isced1997==. & last_wave==5 & wave_info!=1
replace y=1 if w6_isced1997==. & last_wave==6 & wave_info!=0


// define main variables if isced97 is not missing in the last wave where child observed

gen isced97_2=w1_isced1997 if last_wave==1 & wave_info!=3 & y!=1
replace isced97_2=w2_isced1997 if last_wave==2 & wave_info!=7 & y!=1
replace isced97_2=w4_isced1997 if last_wave==4 & wave_info!=11 & y!=1
replace isced97_2=w5_isced1997 if last_wave==5 & wave_info!=1 & y!=1
replace isced97_2=w6_isced1997 if last_wave==6 & wave_info!=0 & y!=1

gen occupation_2=w1_occupation if last_wave==1 & wave_info!=3 & y!=1
replace occupation_2=w2_occupation if last_wave==2 & wave_info!=7 & y!=1
replace occupation_2=w4_occupation if last_wave==4 & wave_info!=11 & y!=1
replace occupation_2=w5_occupation if last_wave==5 & wave_info!=1 & y!=1
replace occupation_2=w6_occupation if last_wave==6 & wave_info!=0 & y!=1

gen number_children_2=w1_number_of_children if last_wave==1 & wave_info!=3 & y!=1
replace number_children_2=w2_number_of_children if last_wave==2 & wave_info!=7 & y!=1
replace number_children_2=w4_number_of_children if last_wave==4 & wave_info!=11 & y!=1
replace number_children_2=w5_number_of_children if last_wave==5 & wave_info!=1 & y!=1
replace number_children_2=w6_number_of_children if last_wave==6 & wave_info!=0 & y!=1

gen move_out_2=w1_move_out if last_wave==1 & wave_info!=3 & y!=1
replace move_out_2=w2_move_out if last_wave==2 & wave_info!=7 & y!=1
replace move_out_2=w4_move_out if last_wave==4 & wave_info!=11 & y!=1
replace move_out_2=w5_move_out if last_wave==5 & wave_info!=1 & y!=1
replace move_out_2=w6_move_out if last_wave==6 & wave_info!=0 & y!=1

  // label variables
label values occupation_2 ch016
label values number_children_2 dkrf
label values move_out_2 dkrf


// flag the observations where isced97 is missing in the last two wave where child observed
gen z=1 if w5_isced1997==. & y==1 & wave_info==2
replace z=1 if w1_isced1997==. & y==1 & wave_info==4
replace z=1 if w1_isced1997==. & y==1 & wave_info==5
replace z=1 if w5_isced1997==. & y==1 & wave_info==6
replace z=1 if w2_isced1997==. & y==1 & wave_info==8
replace z=1 if w2_isced1997==. & y==1 & wave_info==9
replace z=1 if w5_isced1997==. & y==1 & wave_info==10
replace z=1 if w4_isced1997==. & y==1 & wave_info==12
replace z=1 if w4_isced1997==. & y==1 & wave_info==13
replace z=1 if w5_isced1997==. & y==1 & wave_info==14
replace z=1 if w2_isced1997==. & y==1 & wave_info==15
replace z=1 if w4_isced1997==. & y==1 & wave_info==16
replace z=1 if w4_isced1997==. & y==1 & wave_info==17
replace z=1 if w5_isced1997==. & y==1 & wave_info==18
replace z=1 if w1_isced1997==. & y==1 & wave_info==19
replace z=1 if w4_isced1997==. & y==1 & wave_info==20
replace z=1 if w4_isced1997==. & y==1 & wave_info==21
replace z=1 if w5_isced1997==. & y==1 & wave_info==22
replace z=1 if w2_isced1997==. & y==1 & wave_info==23
replace z=1 if w4_isced1997==. & y==1 & wave_info==24
replace z=1 if w4_isced1997==. & y==1 & wave_info==25
replace z=1 if w5_isced1997==. & y==1 & wave_info==26
replace z=1 if w2_isced1997==. & y==1 & wave_info==27
replace z=1 if w5_isced1997==. & y==1 & wave_info==28
replace z=1 if w1_isced1997==. & y==1 & wave_info==29
replace z=1 if w2_isced1997==. & y==1 & wave_info==30


// define main variables if isced97 is not missing in the t-1 (it is missing in t) wave where child observed ( t corresponds to last wave where child observed)

gen isced97_3=w5_isced1997 if y==1 & z!=1 & wave_info==2
replace isced97_3=w1_isced1997 if y==1 & z!=1 & wave_info==4
replace isced97_3=w1_isced1997 if y==1 & z!=1 & wave_info==5
replace isced97_3=w5_isced1997 if y==1 & z!=1 & wave_info==6
replace isced97_3=w2_isced1997 if y==1 & z!=1 & wave_info==8
replace isced97_3=w2_isced1997 if y==1 & z!=1 & wave_info==9
replace isced97_3=w5_isced1997 if y==1 & z!=1 & wave_info==10
replace isced97_3=w4_isced1997 if y==1 & z!=1 & wave_info==12
replace isced97_3=w4_isced1997 if y==1 & z!=1 & wave_info==13
replace isced97_3=w5_isced1997 if y==1 & z!=1 & wave_info==14
replace isced97_3=w2_isced1997 if y==1 & z!=1 & wave_info==15
replace isced97_3=w4_isced1997 if y==1 & z!=1 & wave_info==16
replace isced97_3=w4_isced1997 if y==1 & z!=1 & wave_info==17
replace isced97_3=w5_isced1997 if y==1 & z!=1 & wave_info==18
replace isced97_3=w1_isced1997 if y==1 & z!=1 & wave_info==19
replace isced97_3=w4_isced1997 if y==1 & z!=1 & wave_info==20
replace isced97_3=w4_isced1997 if y==1 & z!=1 & wave_info==21
replace isced97_3=w5_isced1997 if y==1 & z!=1 & wave_info==22
replace isced97_3=w2_isced1997 if y==1 & z!=1 & wave_info==23
replace isced97_3=w4_isced1997 if y==1 & z!=1 & wave_info==24
replace isced97_3=w4_isced1997 if y==1 & z!=1 & wave_info==25
replace isced97_3=w5_isced1997 if y==1 & z!=1 & wave_info==26
replace isced97_3=w2_isced1997 if y==1 & z!=1 & wave_info==27
replace isced97_3=w5_isced1997 if y==1 & z!=1 & wave_info==28
replace isced97_3=w1_isced1997 if y==1 & z!=1 & wave_info==29
replace isced97_3=w2_isced1997 if y==1 & z!=1 & wave_info==30

gen occupation_3=w5_occupation if y==1 & z!=1 & wave_info==2
replace occupation_3=w1_occupation if y==1 & z!=1 & wave_info==4
replace occupation_3=w1_occupation if y==1 & z!=1 & wave_info==5
replace occupation_3=w5_occupation if y==1 & z!=1 & wave_info==6
replace occupation_3=w2_occupation if y==1 & z!=1 & wave_info==8
replace occupation_3=w2_occupation if y==1 & z!=1 & wave_info==9
replace occupation_3=w5_occupation if y==1 & z!=1 & wave_info==10
replace occupation_3=w4_occupation if y==1 & z!=1 & wave_info==12
replace occupation_3=w4_occupation if y==1 & z!=1 & wave_info==13
replace occupation_3=w5_occupation if y==1 & z!=1 & wave_info==14
replace occupation_3=w2_occupation if y==1 & z!=1 & wave_info==15
replace occupation_3=w4_occupation if y==1 & z!=1 & wave_info==16
replace occupation_3=w4_occupation if y==1 & z!=1 & wave_info==17
replace occupation_3=w5_occupation if y==1 & z!=1 & wave_info==18
replace occupation_3=w1_occupation if y==1 & z!=1 & wave_info==19
replace occupation_3=w4_occupation if y==1 & z!=1 & wave_info==20
replace occupation_3=w4_occupation if y==1 & z!=1 & wave_info==21
replace occupation_3=w5_occupation if y==1 & z!=1 & wave_info==22
replace occupation_3=w2_occupation if y==1 & z!=1 & wave_info==23
replace occupation_3=w4_occupation if y==1 & z!=1 & wave_info==24
replace occupation_3=w4_occupation if y==1 & z!=1 & wave_info==25
replace occupation_3=w5_occupation if y==1 & z!=1 & wave_info==26
replace occupation_3=w2_occupation if y==1 & z!=1 & wave_info==27
replace occupation_3=w5_occupation if y==1 & z!=1 & wave_info==28
replace occupation_3=w1_occupation if y==1 & z!=1 & wave_info==29
replace occupation_3=w2_occupation if y==1 & z!=1 & wave_info==30

gen number_child_3=w5_number_of_child if y==1 & z!=1 & wave_info==2
replace number_child_3=w1_number_of_child if y==1 & z!=1 & wave_info==4
replace number_child_3=w1_number_of_child if y==1 & z!=1 & wave_info==5
replace number_child_3=w5_number_of_child if y==1 & z!=1 & wave_info==6
replace number_child_3=w2_number_of_child if y==1 & z!=1 & wave_info==8
replace number_child_3=w2_number_of_child if y==1 & z!=1 & wave_info==9
replace number_child_3=w5_number_of_child if y==1 & z!=1 & wave_info==10
replace number_child_3=w4_number_of_child if y==1 & z!=1 & wave_info==12
replace number_child_3=w4_number_of_child if y==1 & z!=1 & wave_info==13
replace number_child_3=w5_number_of_child if y==1 & z!=1 & wave_info==14
replace number_child_3=w2_number_of_child if y==1 & z!=1 & wave_info==15
replace number_child_3=w4_number_of_child if y==1 & z!=1 & wave_info==16
replace number_child_3=w4_number_of_child if y==1 & z!=1 & wave_info==17
replace number_child_3=w5_number_of_child if y==1 & z!=1 & wave_info==18
replace number_child_3=w1_number_of_child if y==1 & z!=1 & wave_info==19
replace number_child_3=w4_number_of_child if y==1 & z!=1 & wave_info==20
replace number_child_3=w4_number_of_child if y==1 & z!=1 & wave_info==21
replace number_child_3=w5_number_of_child if y==1 & z!=1 & wave_info==22
replace number_child_3=w2_number_of_child if y==1 & z!=1 & wave_info==23
replace number_child_3=w4_number_of_child if y==1 & z!=1 & wave_info==24
replace number_child_3=w4_number_of_child if y==1 & z!=1 & wave_info==25
replace number_child_3=w5_number_of_child if y==1 & z!=1 & wave_info==26
replace number_child_3=w2_number_of_child if y==1 & z!=1 & wave_info==27
replace number_child_3=w5_number_of_child if y==1 & z!=1 & wave_info==28
replace number_child_3=w1_number_of_child if y==1 & z!=1 & wave_info==29
replace number_child_3=w2_number_of_child if y==1 & z!=1 & wave_info==30

gen move_out_3=w5_move_out if y==1 & z!=1 & wave_info==2
replace move_out_3=w1_move_out if y==1 & z!=1 & wave_info==4
replace move_out_3=w1_move_out if y==1 & z!=1 & wave_info==5
replace move_out_3=w5_move_out if y==1 & z!=1 & wave_info==6
replace move_out_3=w2_move_out if y==1 & z!=1 & wave_info==8
replace move_out_3=w2_move_out if y==1 & z!=1 & wave_info==9
replace move_out_3=w5_move_out if y==1 & z!=1 & wave_info==10
replace move_out_3=w4_move_out if y==1 & z!=1 & wave_info==12
replace move_out_3=w4_move_out if y==1 & z!=1 & wave_info==13
replace move_out_3=w5_move_out if y==1 & z!=1 & wave_info==14
replace move_out_3=w2_move_out if y==1 & z!=1 & wave_info==15
replace move_out_3=w4_move_out if y==1 & z!=1 & wave_info==16
replace move_out_3=w4_move_out if y==1 & z!=1 & wave_info==17
replace move_out_3=w5_move_out if y==1 & z!=1 & wave_info==18
replace move_out_3=w1_move_out if y==1 & z!=1 & wave_info==19
replace move_out_3=w4_move_out if y==1 & z!=1 & wave_info==20
replace move_out_3=w4_move_out if y==1 & z!=1 & wave_info==21
replace move_out_3=w5_move_out if y==1 & z!=1 & wave_info==22
replace move_out_3=w2_move_out if y==1 & z!=1 & wave_info==23
replace move_out_3=w4_move_out if y==1 & z!=1 & wave_info==24
replace move_out_3=w4_move_out if y==1 & z!=1 & wave_info==25
replace move_out_3=w5_move_out if y==1 & z!=1 & wave_info==26
replace move_out_3=w2_move_out if y==1 & z!=1 & wave_info==27
replace move_out_3=w5_move_out if y==1 & z!=1 & wave_info==28
replace move_out_3=w1_move_out if y==1 & z!=1 & wave_info==29
replace move_out_3=w2_move_out if y==1 & z!=1 & wave_info==30

  // label variables
label values isced97_3 isced
label values occupation_3 ch016
label values number_child_3 dkrf
label values move_out_3 dkrf

  // order variables
order isced97_3, after(isced97_2)
order occupation_3, after(occupation_2)
order number_child_3, after(number_children_2)
order move_out_3, after(move_out_2)

  // rename variables
rename number_child_3 number_children_3


// flag the observations where isced97 is missing in last three waves where child observed 
gen x=1 if z==1 & w1_isced1997==. & wave_info==6
replace x=1 if z==1 & w2_isced1997==. & wave_info==10
replace x=1 if z==1 & w4_isced1997==. & wave_info==14
replace x=1 if z==1 & w2_isced1997==. & wave_info==16
replace x=1 if z==1 & w2_isced1997==. & wave_info==17
replace x=1 if z==1 & w4_isced1997==. & wave_info==18
replace x=1 if z==1 & w1_isced1997==. & wave_info==20
replace x=1 if z==1 & w1_isced1997==. & wave_info==21
replace x=1 if z==1 & w4_isced1997==. & wave_info==22
replace x=1 if z==1 & w1_isced1997==. & wave_info==23
replace x=1 if z==1 & w2_isced1997==. & wave_info==24
replace x=1 if z==1 & w2_isced1997==. & wave_info==25
replace x=1 if z==1 & w4_isced1997==. & wave_info==26
replace x=1 if z==1 & w1_isced1997==. & wave_info==27
replace x=1 if z==1 & w2_isced1997==. & wave_info==28
replace x=1 if z==1 & w1_isced1997==. & wave_info==30


// define main variables if isced97 is not missing in the t-2 wave (it is missing in t and t-1) where child observed(t corresponds to last wave where child observed)

gen isced97_4=w1_isced1997 if wave_info==6 & z==1 & x!=1
replace isced97_4=w2_isced1997 if wave_info==10 & z==1 & x!=1
replace isced97_4=w4_isced1997 if wave_info==14 & z==1 & x!=1
replace isced97_4=w2_isced1997 if wave_info==16 & z==1 & x!=1
replace isced97_4=w2_isced1997 if wave_info==17 & z==1 & x!=1
replace isced97_4=w4_isced1997 if wave_info==18 & z==1 & x!=1
replace isced97_4=w1_isced1997 if wave_info==20 & z==1 & x!=1
replace isced97_4=w1_isced1997 if wave_info==21 & z==1 & x!=1
replace isced97_4=w4_isced1997 if wave_info==22 & z==1 & x!=1
replace isced97_4=w1_isced1997 if wave_info==23 & z==1 & x!=1
replace isced97_4=w2_isced1997 if wave_info==24 & z==1 & x!=1
replace isced97_4=w2_isced1997 if wave_info==25 & z==1 & x!=1
replace isced97_4=w4_isced1997 if wave_info==26 & z==1 & x!=1
replace isced97_4=w1_isced1997 if wave_info==27 & z==1 & x!=1
replace isced97_4=w2_isced1997 if wave_info==28 & z==1 & x!=1
replace isced97_4=w1_isced1997 if wave_info==30 & z==1 & x!=1

gen occupation_4=w1_occupation if wave_info==6 & z==1 & x!=1
replace occupation_4=w2_occupation if wave_info==10 & z==1 & x!=1
replace occupation_4=w4_occupation if wave_info==14 & z==1 & x!=1
replace occupation_4=w2_occupation if wave_info==16 & z==1 & x!=1
replace occupation_4=w2_occupation if wave_info==17 & z==1 & x!=1
replace occupation_4=w4_occupation if wave_info==18 & z==1 & x!=1
replace occupation_4=w1_occupation if wave_info==20 & z==1 & x!=1
replace occupation_4=w1_occupation if wave_info==21 & z==1 & x!=1
replace occupation_4=w4_occupation if wave_info==22 & z==1 & x!=1
replace occupation_4=w1_occupation if wave_info==23 & z==1 & x!=1
replace occupation_4=w2_occupation if wave_info==24 & z==1 & x!=1
replace occupation_4=w2_occupation if wave_info==25 & z==1 & x!=1
replace occupation_4=w4_occupation if wave_info==26 & z==1 & x!=1
replace occupation_4=w1_occupation if wave_info==27 & z==1 & x!=1
replace occupation_4=w2_occupation if wave_info==28 & z==1 & x!=1
replace occupation_4=w1_occupation if wave_info==30 & z==1 & x!=1

gen number_children_4=w1_number_of_children if wave_info==6 & z==1 & x!=1
replace number_children_4=w2_number_of_children if wave_info==10 & z==1 & x!=1
replace number_children_4=w4_number_of_children if wave_info==14 & z==1 & x!=1
replace number_children_4=w2_number_of_children if wave_info==16 & z==1 & x!=1
replace number_children_4=w2_number_of_children if wave_info==17 & z==1 & x!=1
replace number_children_4=w4_number_of_children if wave_info==18 & z==1 & x!=1
replace number_children_4=w1_number_of_children if wave_info==20 & z==1 & x!=1
replace number_children_4=w1_number_of_children if wave_info==21 & z==1 & x!=1
replace number_children_4=w4_number_of_children if wave_info==22 & z==1 & x!=1
replace number_children_4=w1_number_of_children if wave_info==23 & z==1 & x!=1
replace number_children_4=w2_number_of_children if wave_info==24 & z==1 & x!=1
replace number_children_4=w2_number_of_children if wave_info==25 & z==1 & x!=1
replace number_children_4=w4_number_of_children if wave_info==26 & z==1 & x!=1
replace number_children_4=w1_number_of_children if wave_info==27 & z==1 & x!=1
replace number_children_4=w2_number_of_children if wave_info==28 & z==1 & x!=1
replace number_children_4=w1_number_of_children if wave_info==30 & z==1 & x!=1

gen move_out_4=w1_move_out if wave_info==6 & z==1 & x!=1
replace move_out_4=w2_move_out if wave_info==10 & z==1 & x!=1
replace move_out_4=w4_move_out if wave_info==14 & z==1 & x!=1
replace move_out_4=w2_move_out if wave_info==16 & z==1 & x!=1
replace move_out_4=w2_move_out if wave_info==17 & z==1 & x!=1
replace move_out_4=w4_move_out if wave_info==18 & z==1 & x!=1
replace move_out_4=w1_move_out if wave_info==20 & z==1 & x!=1
replace move_out_4=w1_move_out if wave_info==21 & z==1 & x!=1
replace move_out_4=w4_move_out if wave_info==22 & z==1 & x!=1
replace move_out_4=w1_move_out if wave_info==23 & z==1 & x!=1
replace move_out_4=w2_move_out if wave_info==24 & z==1 & x!=1
replace move_out_4=w2_move_out if wave_info==25 & z==1 & x!=1
replace move_out_4=w4_move_out if wave_info==26 & z==1 & x!=1
replace move_out_4=w1_move_out if wave_info==27 & z==1 & x!=1
replace move_out_4=w2_move_out if wave_info==28 & z==1 & x!=1
replace move_out_4=w1_move_out if wave_info==30 & z==1 & x!=1

  // label variables
label values isced97_4 isced
label values occupation_4 ch016
label values number_children_4 dkrf
label values move_out_4 dkrf

  // order variables
order isced97_4, after(isced97_3)
order occupation_4, after(occupation_3)
order number_children_4, after(number_children_3)
order move_out_4, after(move_out_3)

// define main variables using the first wave if isced97 is missing in last three waves and the child was observed in four different waves.

gen isced97_5= w1_isced1997 if x==1 & wave_info==22
replace isced97_5= w1_isced1997 if x==1 & wave_info==24
replace isced97_5= w1_isced1997 if x==1 & wave_info==25
replace isced97_5= w1_isced1997 if x==1 & wave_info==28
replace isced97_5= w2_isced1997 if x==1 & wave_info==18

gen occupation_5= w1_occupation if x==1 & wave_info==22
replace occupation_5= w1_occupation if x==1 & wave_info==24
replace occupation_5= w1_occupation if x==1 & wave_info==25
replace occupation_5= w1_occupation if x==1 & wave_info==28
replace occupation_5= w2_occupation if x==1 & wave_info==18

gen number_children_5= w1_number_of_children if x==1 & wave_info==22
replace number_children_5= w1_number_of_children if x==1 & wave_info==24
replace number_children_5= w1_number_of_children if x==1 & wave_info==25
replace number_children_5= w1_number_of_children if x==1 & wave_info==28
replace number_children_5= w2_number_of_children if x==1 & wave_info==18

gen move_out_5= w1_move_out if x==1 & wave_info==22
replace move_out_5= w1_move_out if x==1 & wave_info==24
replace move_out_5= w1_move_out if x==1 & wave_info==25
replace move_out_5= w1_move_out if x==1 & wave_info==28
replace move_out_5= w2_move_out if x==1 & wave_info==18

// flag the observations where  isced97 is missing in each waves where child was observed.
gen missing=1 if z==1 & wave_info==2
replace missing=1 if z==1 & wave_info==4
replace missing=1 if z==1 & wave_info==5
replace missing=1 if z==1 & wave_info==8
replace missing=1 if z==1 & wave_info==9
replace missing=1 if z==1 & wave_info==12
replace missing=1 if z==1 & wave_info==13
replace missing=1 if z==1 & wave_info==15
replace missing=1 if z==1 & wave_info==19
replace missing=1 if z==1 & wave_info==29
replace missing=1 if x==1 & wave_info==6
replace missing=1 if x==1 & wave_info==10
replace missing=1 if x==1 & wave_info==14
replace missing=1 if x==1 & wave_info==16
replace missing=1 if x==1 & wave_info==17
replace missing=1 if x==1 & wave_info==21
replace missing=1 if x==1 & wave_info==23
replace missing=1 if x==1 & wave_info==27
replace missing=1 if x==1 & wave_info==30

// flag the observations where  isced97 is missing in last four waves where child was observed in five different waves
gen j=1 if x==1 & w2_isced1997==. & wave_info==26

// define main variables using the second wave if isced97 is missing in last three waves and the child was observed in five different waves.
replace isced97_5= w2_isced1997 if x==1 & wave_info==26 & j!=1
replace occupation_5= w2_occupation if x==1 & wave_info==26 & j!=1
replace number_children_5= w2_number_of_children if x==1 & wave_info==26 & j!=1
replace move_out_5= w2_move_out if x==1 & wave_info==26 & j!=1

// define main variables using the first wave if isced97 is missing in last four waves and the child was observed in five different waves.
replace isced97_5= w1_isced1997 if x==1 & wave_info==26 & j==1
replace occupation_5= w1_occupation if x==1 & wave_info==26 & j==1
replace number_children_5= w1_number_of_children if x==1 & wave_info==26 & j==1
replace move_out_5= w1_move_out if x==1 & wave_info==26 & j==1

 // order variables
order isced97_5, after (isced97_4)
order occupation_5, after (occupation_4)
order number_children_5, after (number_children_4)
order move_out_5, after (move_out_4)

** define the wave where child's variables derived. (the latest available wave where child's isced information is not missing)

gen final_wave=1 if wave_info==3 & isced97!=.
replace final_wave=2 if wave_info==7 & isced97!=.
replace final_wave=4 if wave_info==11 & isced97!=.
replace final_wave=5 if wave_info==1 & isced97!=.
replace final_wave=6 if wave_info==0 & isced97!=.
replace final_wave=1 if last_wave==1 & isced97_2!=.
replace final_wave=2 if last_wave==2 & isced97_2!=.
replace final_wave=4 if last_wave==4 & isced97_2!=.
replace final_wave=5 if last_wave==5 & isced97_2!=.
replace final_wave=6 if last_wave==6 & isced97_2!=.
replace final_wave=5 if  wave_info==2 & isced97_3!=.
replace final_wave=1 if  wave_info==4 & isced97_3!=.
replace final_wave=1 if  wave_info==5 & isced97_3!=.
replace final_wave=5 if  wave_info==6 & isced97_3!=.
replace final_wave=2 if  wave_info==8 & isced97_3!=.
replace final_wave=2 if  wave_info==9 & isced97_3!=.
replace final_wave=5 if  wave_info==10 & isced97_3!=.
replace final_wave=4 if  wave_info==12 & isced97_3!=.
replace final_wave=4 if  wave_info==13 & isced97_3!=.
replace final_wave=5 if  wave_info==14 & isced97_3!=.
replace final_wave=2 if  wave_info==15 & isced97_3!=.
replace final_wave=4 if  wave_info==16 & isced97_3!=.
replace final_wave=4 if  wave_info==17 & isced97_3!=.
replace final_wave=5 if  wave_info==18 & isced97_3!=.
replace final_wave=1 if  wave_info==19 & isced97_3!=.
replace final_wave=4 if  wave_info==20 & isced97_3!=.
replace final_wave=4 if  wave_info==21 & isced97_3!=.
replace final_wave=5 if  wave_info==22 & isced97_3!=.
replace final_wave=2 if  wave_info==23 & isced97_3!=.
replace final_wave=4 if  wave_info==24 & isced97_3!=.
replace final_wave=4 if  wave_info==25 & isced97_3!=.
replace final_wave=5 if  wave_info==26 & isced97_3!=.
replace final_wave=2 if  wave_info==27 & isced97_3!=.
replace final_wave=5 if  wave_info==28 & isced97_3!=.
replace final_wave=1 if  wave_info==29 & isced97_3!=.
replace final_wave=2 if  wave_info==30 & isced97_3!=.
replace final_wave=1 if wave_info==6 & isced97_4!=.
replace final_wave=2 if wave_info==10 & isced97_4!=.
replace final_wave=4 if wave_info==14 & isced97_4!=.
replace final_wave=2 if wave_info==16 & isced97_4!=.
replace final_wave=2 if wave_info==17 & isced97_4!=.
replace final_wave=4 if wave_info==18 & isced97_4!=.
replace final_wave=1 if wave_info==20 & isced97_4!=.
replace final_wave=1 if wave_info==21 & isced97_4!=.
replace final_wave=4 if wave_info==22 & isced97_4!=.
replace final_wave=1 if wave_info==23 & isced97_4!=.
replace final_wave=2 if wave_info==24 & isced97_4!=.
replace final_wave=2 if wave_info==25 & isced97_4!=.
replace final_wave=4 if wave_info==26 & isced97_4!=.
replace final_wave=1 if wave_info==27 & isced97_4!=.
replace final_wave=2 if wave_info==28 & isced97_4!=.
replace final_wave=1 if wave_info==30 & isced97_4!=.
replace final_wave=1 if wave_info==22 & isced97_5!=.
replace final_wave=1 if wave_info==24 & isced97_5!=.
replace final_wave=1 if wave_info==25 & isced97_5!=.
replace final_wave=1 if wave_info==28 & isced97_5!=.
replace final_wave=2 if wave_info==18 & isced97_5!=.
replace final_wave=2 if x==1 & wave_info==26 & j!=1
replace final_wave=1 if x==1 & wave_info==26 & j==1


// flag observations where isced information is not available
gen missing2=1 if w1_isced1997==. & w2_isced1997==.  &  w4_isced1997==. & w5_isced1997==. & w6_isced1997==. 
replace final_wave=0 if missing2==1

// label variables
label variable final_wave "Key variables come from this wave"
label variable missing2 "Education information is missing (no waves)"
label variable z "Education info is missing in last 2 wave"
label variable x "Education info is missing in last 3 waves"
label variable j "Education info is missing in last 4 wavs"
label var wave_info "Availability across waves"

// order variables
order coupleid country last_wave, before(wave_info)
order isced97 isced97_2 isced97_3 isced97_4 isced97_5 w1_isced1997 w2_isced1997 w4_isced1997 w5_isced1997 w6_isced1997 w1_isced1997y w5_isced2011 w6_isced2011 occupation occupation_2 occupation_3 occupation_4 occupation_5 w1_occupation w2_occupation w4_occupation w5_occupation w6_occupation number_children number_children_2 number_children_3 number_children_4 number_children_5 w1_number_of_children w2_number_of_children w4_number_of_children w5_number_of_children w6_number_of_children move_out move_out_2 move_out_3 move_out_4 move_out_5 w1_move_out w2_move_out w4_move_out w5_move_out w6_move_out w1_all_natural w2_all_natural w4_natural_child w5_natural_child, after(year_birth)
drop missing t1

/*==============================================================================
                       3: Variable Creation Children
==============================================================================*/

** define education 
replace isced97=isced97_2 if isced97==. 
replace isced97=isced97_3 if isced97==. 
replace isced97=isced97_4 if isced97==. 
replace isced97=isced97_5 if isced97==. 

**define occupation
replace occupation=occupation_2 if occupation==. 
replace occupation=occupation_3 if occupation==. 
replace occupation=occupation_4 if occupation==. 
replace occupation=occupation_5 if occupation==. 

**define parents' number of children
replace number_children=number_children_2 if number_children==. 
replace number_children=number_children_3 if number_children==. 
replace number_children=number_children_4 if number_children==. 
replace number_children=number_children_5 if number_children==. 

**define move out year from home
replace move_out=move_out_2 if move_out==. 
replace move_out=move_out_3 if move_out==. 
replace move_out=move_out_4 if move_out==. 
replace move_out=move_out_5 if move_out==. 

  // drop intermediate variables
drop isced97_2 isced97_3 isced97_4 isced97_5 occupation_2 occupation_3 occupation_4 occupation_5 number_children_2 number_children_3 number_children_4 number_children_5 move_out_2 move_out_3 move_out_4 move_out_5 
  // order variables
order occupation number_children move_out, before (w1_isced1997)
order final_wave, before (gender)


** define id variable of family respondent (1st parent)
gen mergeid=w1_mergeid if final_wave==1
replace mergeid=w2_mergeid if final_wave==2
replace mergeid=w4_mergeid if final_wave==4
replace mergeid=w5_mergeid if final_wave==5
replace mergeid=w6_mergeid if final_wave==6

** define id variable of partner (2nd parent)
gen mergeidp=w1_mergeidp if final_wave==1
replace mergeidp=w2_mergeidp if final_wave==2
replace mergeidp=w4_mergeidp if final_wave==4
replace mergeidp=w5_mergeidp if final_wave==5
replace mergeidp=w6_mergeidp if final_wave==6

** define household id
gen hhid=w1_hhid if final_wave==1
replace hhid=w2_hhid if final_wave==2
replace hhid=w4_hhid if final_wave==4
replace hhid=w5_hhid if final_wave==5
replace hhid=w6_hhid if final_wave==6

** define language
gen language=w1_language if final_wave==1
replace language=w2_language if final_wave==2
replace language=w4_language if final_wave==4
replace language=w5_language if final_wave==5
replace language=w6_language if final_wave==6

  // order variables
order mergeid mergeidp hhid language, before (w1_isced1997)
  // label variables
label variable mergeid "ID of family respondent"
label variable mergeid "Family respondent's ID in final_wave"
label variable mergeidp "Partner of Family Respondent -ID in final wave"
label variable hhid "Household ID in final wave"
label variable language "Language in Final wave"

** define the first wave where child was observed
gen first_wave=1 if w1_mergeid!=""
replace first_wave=2 if w2_mergeid!="" & first_wave==.
replace first_wave=4 if w4_mergeid!="" & first_wave==.
replace first_wave=5 if w5_mergeid!="" & first_wave==.
replace first_wave=6 if w6_mergeid!="" & first_wave==.

**construct relationship variable ( own child of parents / natural child of parents etc.)

gen relationship=w6_relation if final_wave==6
replace relationship=w6_relation if wave_info==2 & final_wave==5 & w5_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==4 & final_wave==1 & w1_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==8 & final_wave==2 & w2_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==12 & final_wave==4 & w4_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==10 & final_wave==2 & w2_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==10 & final_wave==5 & w5_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==14 & final_wave==4 & w4_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==14 & final_wave==5 & w5_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==16 & final_wave==2 & w2_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==16 & final_wave==4 & w4_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==20 & final_wave==1 & w1_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==20 & final_wave==4 & w4_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==30 & final_wave==1 & w1_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==30 & final_wave==2 & w2_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==6 & final_wave==1 & w1_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==6 & final_wave==5 & w5_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==18 & final_wave==2 & w2_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==18 & final_wave==4 & w4_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==18 & final_wave==5 & w5_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==22 & final_wave==1 & w1_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==22 & final_wave==4 & w4_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==22 & final_wave==5 & w5_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==24 & final_wave==1 & w1_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==24 & final_wave==2 & w2_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==24 & final_wave==4 & w4_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==28 & final_wave==1 & w1_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==28 & final_wave==2 & w2_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==28 & final_wave==5 & w5_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==26 & final_wave==1 & w1_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==26 & final_wave==2 & w2_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==26 & final_wave==4 & w4_mergeid==w6_mergeid
replace relationship=w6_relation if wave_info==26 & final_wave==5 & w5_mergeid==w6_mergeid

replace relationship=2 if w1_all_natural==1 & final_wave==1 & relationship==.
replace relationship=2 if w2_all_natural==1 & final_wave==2 & relationship==.
replace relationship=2 if w4_natural_child==1 & final_wave==4 & relationship==.
replace relationship=2 if w5_natural_child==1 & final_wave==5 & relationship==.

gen relationship2=1 if relationship==1
replace relationship2=2 if relationship==2
replace relationship2=3 if relationship==3|relationship==5
replace relationship2=4 if relationship==4|relationship==6
replace relationship2=5 if relationship==7|relationship==8
replace relationship2=6 if relationship==9

replace relationship2=2 if w1_own_child==1 & final_wave==1 & relationship2==.
replace relationship2=3 if w1_own_child==2 & final_wave==1 & relationship2==.
replace relationship2=4 if w1_own_child==3 & final_wave==1 & relationship2==.
replace relationship2=5 if w1_own_child==4 & final_wave==1 & relationship2==.
replace relationship2=6 if w1_own_child==5 & final_wave==1 & relationship2==.

replace relationship2=2 if w2_own_child==1 & final_wave==2 & relationship2==.
replace relationship2=3 if w2_own_child==2 & final_wave==2 & relationship2==.
replace relationship2=4 if w2_own_child==3 & final_wave==2 & relationship2==.
replace relationship2=5 if w2_own_child==4 & final_wave==2 & relationship2==.
replace relationship2=6 if w2_own_child==5 & final_wave==2 & relationship2==.

replace relationship2=2 if w4_own_child==1 & final_wave==4 & relationship2==. 
replace relationship2=3 if w4_own_child==2 & final_wave==4 & relationship2==.
replace relationship2=4 if w4_own_child==3 & final_wave==4 & relationship2==.
replace relationship2=5 if w4_own_child==4 & final_wave==4 & relationship2==.
replace relationship2=6 if w4_own_child==5 & final_wave==4 & relationship2==.

replace relationship2=2 if w5_own_child==1 & final_wave==5 & relationship2==.
replace relationship2=3 if w5_own_child==2 & final_wave==5 & relationship2==.
replace relationship2=4 if w5_own_child==3 & final_wave==5 & relationship2==.
replace relationship2=5 if w5_own_child==4 & final_wave==5 & relationship2==.
replace relationship2=6 if w5_own_child==5 & final_wave==5 & relationship2==.

  // label variables
label variable relationship "Natural child of family respondent and current partner"
label variable relationship2 "Own child of family respondent and current partner"

  // rename variables
rename relationship natural_child
rename relationship2 own_child

  // label values
label define child_rel2 1 "Natural child of respondent(single)" 2 "Own child of respondent and current partner" 3 "Own child of respondent not current partner" 4 "own child of current partner not respondent" 5 "Adopted child" 6 "Foster child"
label val own_child child_rel2

*-------------------------Combined with interview date--------------------------

merge m:1 mergeid country using `interview_date'
drop if _merge==2

*gen interview year
gen int_year=int_year_w1 if final_wave==1
replace int_year=int_year_w2 if final_wave==2
replace int_year=int_year_w4 if final_wave==4
replace int_year=int_year_w5 if final_wave==5
replace int_year=int_year_w6 if final_wave==6

*gen interview month
gen int_month=int_month_w1 if final_wave==1
replace int_month=int_month_w2 if final_wave==2
replace int_month=int_month_w4 if final_wave==4
replace int_month=int_month_w5 if final_wave==5
replace int_month=int_month_w6 if final_wave==6

  // label values and variables
label values int_year na_extended
label values int_month month2
label variable int_year "Interview year of final_wave"
label variable int_month "Interview month of final_wave"

  // rename variable
rename _merge famresp


merge m:1 mergeidp country using `partner_interview_date'
drop if _merge==2


*gen wave_int_year variable with respect to the wave_mergeid information
gen w1_int_year=int_year_w1 if mergeid==w1_mergeid 
replace w1_int_year=partner_int_year_w1 if mergeid==w1_mergeidp
gen w2_int_year=int_year_w2 if mergeid==w2_mergeid 
replace w2_int_year=partner_int_year_w2 if mergeid==w2_mergeidp
gen w4_int_year=int_year_w4 if mergeid==w4_mergeid 
replace w4_int_year=partner_int_year_w4 if mergeid==w4_mergeidp
gen w5_int_year=int_year_w5 if mergeid==w5_mergeid 
replace w5_int_year=partner_int_year_w5 if mergeid==w5_mergeidp
gen w6_int_year=int_year_w6 if mergeid==w6_mergeid 
replace w6_int_year=partner_int_year_w6 if mergeid==w6_mergeidp

*gen wave_int_month variable with respect to the wave_mergeid information
gen w1_int_month=int_month_w1 if mergeid==w1_mergeid 
replace w1_int_month=partner_int_month_w1 if mergeid==w1_mergeidp
gen w2_int_month=int_month_w2 if mergeid==w2_mergeid 
replace w2_int_month=partner_int_month_w2 if mergeid==w2_mergeidp
gen w4_int_month=int_month_w4 if mergeid==w4_mergeid 
replace w4_int_month=partner_int_month_w4 if mergeid==w4_mergeidp
gen w5_int_month=int_month_w5 if mergeid==w5_mergeid 
replace w5_int_month=partner_int_month_w5 if mergeid==w5_mergeidp
gen w6_int_month=int_month_w6 if mergeid==w6_mergeid 
replace w6_int_month=partner_int_month_w6 if mergeid==w6_mergeidp

   // keep necessary variables
drop partner_int_year_w1 partner_int_year_w2 partner_int_year_w4 partner_int_year_w5 partner_int_year_w6 partner_int_month_w1 partner_int_month_w2 partner_int_month_w3 partner_int_month_w4 partner_int_month_w5 partner_int_month_w6 partner_int_month_w7 int_year_w1 int_year_w2 int_year_w4 int_year_w5 int_year_w6  int_month_w1 int_month_w2 int_month_w3 int_month_w4 int_month_w5 int_month_w6 int_month_w7 famresp _merge
 
  // order variable
order first_wave, after(country)
order natural_child own_child int_year int_month, after(language)
order partner_int_year_w3 partner_int_year_w7 int_year_w3 int_year_w7, after(w6_int_month)

  // label variable
label var first_wave "First wave that child attend the survey"
label var y "Education info is missing in last wave"
label var w1_int_year "Interview year (wavve 1)"
label var w2_int_year "Interview year (wavve 2)"
label var w4_int_year "Interview year (wavve 4)"
label var w5_int_year "Interview year (wavve 5)"
label var w6_int_year "Interview year (wavve 6)"

label var w1_int_month "Interview month (wavve 1)"
label var w2_int_month "Interview month (wavve 2)"
label var w4_int_month "Interview month (wavve 4)"
label var w5_int_month "Interview month (wavve 5)"
label var w6_int_month "Interview month (wavve 6)"


*-------------------------Combined with parents' demographic--------------------

// merge with the family respondent's demographics ( 1st parent)
merge m:1 country mergeid using `mergeid'
drop if _merge==2
rename _merge mergeid_merge

// merge with the second parent (partner of family respondent)
merge m:1 country mergeidp using `mergeidp'
drop if _merge==2
rename _merge mergeidp_merge

// label variables
label variable country_p_key "family respondent: consistency check for country"
label variable dn003_v2 "family respondent:Year of birth"
label variable dn003_v2_key "family respondent:consistency check for year of birth"
label variable isced1997_r_v2_key "family respondent:consistency check for isced1997"
label variable isced1997_r_v2 "family respondent:Respondent ISCED97 coding of education"
label variable dn041_v4 "family respondent: years of educationv4"
label variable dn041_v4_key "family respondent:consistency check for years of education"
label variable dn004_key "family respondent: born in countryconsistency check for born in country"
label variable dn004 "family respondent: born in country"
label variable dn004_key "family respondent: consistency check for born in country"
label variable dn005c "family respondent: Foreign country birth code"
label variable dn005c_key "family respondent: consistency check for foreign country birth code"
label variable dn006 "family respondent: Year came to live"
label variable dn006_key "family respondent: consistency check for year came to live"
label variable dn042_v2_key "family respondent:consistency check for gender"
label variable dn042_v2 "family respondent:Respondent gender"
label variable partner_country_p_key "partner: consistency check for country"
label variable partner_dn003_v2 "partner:Year of birth"
label variable partner_dn003_v2_key "partner:consistency checkfor year of birth"
label variable partner_isced1997_r_v2_key "partner:consistencycheck for isced1997"
label variable partner_isced1997_r_v2 "partner: ISCED97 coding of education"
label variable partner_dn041_v4 "partner: years of education v4"
label variable partner_dn041_v4_key "partner:consistency check for years of education"
label variable partner_dn004 "partner: Born in country"
label variable partner_dn004_key "partner: consistency check for born in country"
label variable partner_dn005c "partner: Foreign country birth code"
label variable partner_dn005c_key "partner: consistency check for foreign country birth code"
label variable partner_dn006 "partner: Year came to live"
label variable partner_dn006_key "partner: consistency check for year came to live"
label variable partner_dn042_v2_key "partner:consistency check for gender"
label variable partner_dn042_v2 "partner: gender"
label variable mergeid_merge "_merge status for family respondent"
label variable mergeidp_merge "merge status for partner"

  // order variables
order dn004 dn004_key dn005c dn005c_key dn006 dn006_key, before(isced1997_r_v2_key)
order partner_dn004 partner_dn004_key partner_dn005c partner_dn005c_key partner_dn006 partner_dn006_key, before(partner_isced1997_r_v2_key)


** flag cases where two parents are available 
gen parent_match=1 if mergeid_merge==3 & mergeidp_merge==3
replace parent_match=2 if mergeid_merge==3 & mergeidp_merge==1
replace parent_match=3 if mergeid_merge==1 & mergeidp_merge==3

  // label variable and values
label variable parent_match "Parent match for demographic questionnaires"
label define parent_match 1 "Two parents is available in dn" 2 "Only family respondent is available" 3 "Only family respondent's current partner is available"
label values parent_match parent_match

** define age of child
gen age=.
replace age=int_year-year_birth if year_birth!=. & year_birth>=0
replace age=-1 if year_birth==-1
replace age=-2 if year_birth==-2
order age, before(isced97)

  // label variable and values
label var age "Age in final wave"
label define age -1 "Don't know" -2 "Refusal" -3 "implausible"
label values age age

*-----------------Defined maternal and paternal characteristics-----------------

** create mother & father id
gen mother_id= mergeid if dn042_v2==2
replace mother_id=mergeidp if partner_dn042_v2==2 & mother_id=="" 

gen father_id= mergeid if dn042_v2==1
replace father_id=mergeidp if partner_dn042_v2==1 & father_id=="" 

*-------------------------------------------------

* create mother & father year of birth 

gen mother_year= dn003_v2 if dn042_v2==2
replace mother_year=partner_dn003_v2 if partner_dn042_v2==2 & mother_year==.

gen father_year= dn003_v2 if dn042_v2==1
replace father_year=partner_dn003_v2 if partner_dn042_v2==1 & father_year==.

gen mother_year_key= dn003_v2_key if dn042_v2==2
replace mother_year_key=partner_dn003_v2_key if partner_dn042_v2==2 & mother_year_key==.

gen father_year_key= dn003_v2_key if dn042_v2==1
replace father_year_key=partner_dn003_v2_key if partner_dn042_v2==1 & father_year_key==.
*-------------------------------------------------

* create mother & father born in country

gen mother_born= dn004 if dn042_v2==2
replace mother_born=partner_dn004 if partner_dn042_v2==2 & mother_born==.

gen father_born= dn004 if dn042_v2==1
replace father_born=partner_dn004 if partner_dn042_v2==1 & father_born==.

gen mother_born_key= dn004_key if dn042_v2==2
replace mother_born_key=partner_dn004_key if partner_dn042_v2==2 & mother_born_key==.

gen father_born_key= dn004_key if dn042_v2==1
replace father_born_key=partner_dn004_key if partner_dn042_v2==1 &father_born_key==.
*-------------------------------------------------

* create mother & father foreign country birth
 
gen mother_foreign= dn005c if dn042_v2==2
replace mother_foreign=partner_dn005c if partner_dn042_v2==2 & mother_foreign==.

gen father_foreign= dn005c if dn042_v2==1
replace father_foreign=partner_dn005c if partner_dn042_v2==1 & father_foreign==.

gen mother_foreign_key= dn005c_key if dn042_v2==2
replace mother_foreign_key=partner_dn005c_key if partner_dn042_v2==2 & mother_foreign_key==.

gen father_foreign_key= dn005c_key if dn042_v2==1
replace father_foreign_key=partner_dn005c_key if partner_dn042_v2==1 & father_foreign_key==.
*-------------------------------------------------

*create mother & father year came to live in country

gen mother_came= dn006 if dn042_v2==2
replace mother_came=partner_dn006 if partner_dn042_v2==2 & mother_came==.

gen father_came= dn006 if dn042_v2==1
replace father_came=partner_dn006 if partner_dn042_v2==1 & father_came==.

gen mother_came_key= dn006_key if dn042_v2==2
replace mother_came_key=partner_dn006_key if partner_dn042_v2==2 & mother_came_key==.

gen father_came_key= dn006_key if dn042_v2==1
replace father_came_key=partner_dn006_key if partner_dn042_v2==1 & father_came_key==.
*-------------------------------------------------

*create mother & father isced97

gen mother_isced97= isced1997_r_v2 if dn042_v2==2
replace mother_isced97=partner_isced1997_r_v2 if partner_dn042_v2==2 & mother_isced97==.

gen father_isced97= isced1997_r_v2 if dn042_v2==1
replace father_isced97=partner_isced1997_r_v2 if partner_dn042_v2==1 & father_isced97==.

gen mother_isced97_key= isced1997_r_v2_key if dn042_v2==2
replace mother_isced97_key=partner_isced1997_r_v2_key if partner_dn042_v2==2 & mother_isced97_key==.

gen father_isced97_key= isced1997_r_v2_key if dn042_v2==1
replace father_isced97_key=partner_isced1997_r_v2_key if partner_dn042_v2==1 & father_isced97_key==.
*-------------------------------------------------

*create mother & father years_of_educ

gen mother_years_educ= dn041_v4 if dn042_v2==2
replace mother_years_educ=partner_dn041_v4 if partner_dn042_v2==2 & mother_years_educ==.

gen father_years_educ= dn041_v4 if dn042_v2==1
replace father_years_educ=partner_dn041_v4 if partner_dn042_v2==1 & father_years_educ==.

gen mother_years_educ_key= dn041_v4_key if dn042_v2==2
replace mother_years_educ_key=partner_dn041_v4_key if partner_dn042_v2==2 & mother_years_educ_key==.

gen father_years_educ_key= dn041_v4_key if dn042_v2==1
replace father_years_educ_key=partner_dn041_v4_key if partner_dn042_v2==1 & father_years_educ_key==.


// label variables and values

label values mother_year dkrf
label values father_year dkrf
label values mother_year_key consistency_check
label values father_year_key consistency_check
label values mother_born yesno
label values father_born yesno
label values mother_born_key consistency_check
label values father_born_key consistency_check
label values mother_foreign countryofbirth
label values father_foreign countryofbirth
label values mother_foreign_key consistency_check
label values father_foreign_key consistency_check
label values mother_came dkrf
label values father_came dkrf
label values mother_came_key consistency_check
label values father_came_key consistency_check
label values mother_isced97 isced
label values father_isced97 isced
label values mother_isced97_key consistency_check
label values father_isced97_key consistency_check
label values mother_years_educ dkrfim
label values father_years_educ dkrfim
label values mother_years_educ_key consistency_check
label values father_years_educ_key consistency_check
label variable mother_id "Mother id: based on mergeidp or mergeid"
label variable father_id "Father id: based on mergeidp or mergeid"
label variable mother_year "Mother year of birth, based on dn003"
label variable father_year "Father year of birth, based on dn003"
label variable mother_year_key "Mother year of birth consistency check"
label variable father_year_key "Father year of birth consistency check"
label variable mother_born "Mother born in country, based on dn004"
label variable father_born "Father born in country, based on dn004"
label variable mother_born_key "Mother born in country consistency check"
label variable father_born_key "Father born in country consistency check"
label variable mother_foreign "Mother country of birth, based on dn005c if dn004 is no"
label variable father_foreign "Father country of birth, based on dn005c if dn004 is no"
label variable mother_foreign_key "Mother country of birth consistency check"
label variable father_foreign_key "Father country of birth consistency check"
label variable mother_came "Mother: year migrated to country, based on dn006"
label variable father_came "Father: year migrated to country, based on dn006"
label variable mother_came_key "Mother year came to country consistency check"
label variable father_came_key "Father year came to country consistency check"
label variable mother_isced97 "Mother isced97 education level, based on isced1997_r_v2"
label variable father_isced97 "Father isced97 education level, based on isced1997_r_v2"
label variable mother_isced97_key "Mother isced97 consistency check"
label variable father_isced97_key "Father isced97 consistency check"
label variable mother_years_educ "Mother years of education, based on dn041_v4"
label variable father_years_educ "Father years of education, based on dn041_v4"
label variable mother_years_educ_key "mother years of education consistency check "
label variable father_years_educ_key "Father years of education consistency check "
label variable mother_years_educ_key "Mother years of education consistency check "

*-------------------------------------------------
*flag for availability of parental information

gen same_sex=1 if dn042_v2==partner_dn042_v2 & dn042_v2!=. & partner_dn042_v2!=.
gen b=1 if father_id=="" & mother_id!=""
replace father_id=mergeidp if b==1

gen c=1 if father_id!="" & mother_id==""
replace mother_id=mergeidp if c==1

replace b=. if same_sex==1
replace c=. if same_sex==1

gen situation=1 if b==1
replace situation=2 if c==1
replace situation=3 if same_sex==1
replace situation=4 if mother_id=="" & father_id==""
replace situation=5 if situation==.
drop same_sex b c 

 //label variables and values
label variable situation "Parental dn information: availability"
label define situation 1 "only mother is available in dn" 2 "only father is available in dn" 3 "same sex partners" 4 "child's isced97 is not available" 5 "both parents are available in dn"
label values situation situation

 // order variables
order mother_id, before (mergeid)
order father_id, before (mergeid)
order mother_year, before (mergeid)
order father_year, before (mergeid)
order mother_born, before (mergeid)
order father_born, before (mergeid)
order mother_foreign, before (mergeid)
order father_foreign, before (mergeid)
order mother_came, before (mergeid)
order father_came, before (mergeid)
order mother_isced97, before (mergeid)
order father_isced97, before (mergeid)
order mother_years_educ, before (mergeid)
order father_years_educ, before (mergeid)
order situation, before(mergeid)

// inconsistency check for mother's and father's country of birth 
replace mother_foreign_key=-2 if mother_born==1 & mother_foreign_key==-1 
replace father_foreign_key=-2 if father_born==1 & father_foreign_key==-1 
replace mother_came_key=-2 if mother_born==1 & mother_came_key==-1 
replace father_came_key=-2 if father_born==1 & father_came_key==-1 
label define consistency_check2 0 "consistent" 1 "inconsistent" -1 "missing value" -2 "born in this country"

 //label values
label values mother_foreign_key consistency_check2
label values father_foreign_key consistency_check2
label values mother_came_key consistency_check2
label values father_came_key consistency_check2

*-------------------------------------------------
*further checks for implausible observations

**age control - flag implausible observations
gen age_control=1 if year_birth<mother_year+13 & mother_year!=. & mother_year!=-1 & mother_year!=-2 & year_birth!=. & year_birth!=-1 & year_birth!=-2
gen age_control2=1 if year_birth<father_year+13 & father_year!=. & father_year!=-1 & father_year!=-2 & year_birth!=. & year_birth!=-1 & year_birth!=-2

gen age_control_new=1 if age_control==1 & age_control2==.
replace age_control_new=2 if age_control2==1 & age_control==.
replace age_control_new=3 if age_control2==1 & age_control==1
replace age_control_new=0 if age_control_new==.
drop age_control age_control2

  //label variable and values
label define age_control_new 0 "consistent" 1 "Maternal age-offspring age<14" 2 "Paternal age-offspring age<14" 3 "Parental age-offspring age<14"
label values age_control_new age_control_new
order age_control_new, after(age)
label variable age_control_new "Check for age consistency"

**move out - winsorize implausible observations
label define move_out -1 "Don't know" -2 "Refusal" -3 "Implausible" 0 "Still live in home"
label values move_out move_out
replace move_out=0 if move_out==2999

  //latest int_year=2015 in the dataset
replace move_out=-3 if move_out>2016 & move_out!=.
gen move_out_key=.
replace move_out_key=0 if move_out!=. & move_out_key!=1
replace move_out_key=-1 if move_out==.

 //label variable and values
label define move_out_key -1 "Missing value" 0 "Came from the final_wave" 
label values move_out_key move_out_key
order move_out_key, after(move_out)
label var move_out_key "Move out availability"

**year of came to country - flag implausible observations
gen came_control=1 if year_birth<mother_came & mother_came!=-1 & mother_came!=-2 & mother_came!=. & year_birth!=-1 & year_birth!=-2 & year_birth!=.
gen came_control2=1 if year_birth<father_came & father_came!=-1 & father_came!=-2 & father_came!=. & year_birth!=-1 & year_birth!=-2 & year_birth!=.

gen came_control_new=1 if came_control==1 & came_control2!=1
replace came_control_new=2 if came_control2==1 & came_control!=1
replace came_control_new=3 if came_control==1 & came_control2==1
replace came_control_new=0 if came_control_new==.
drop came_control came_control2
 
  //label variable and values
label define came_control 1 "year_birth<mother_came" 2 "year_birth<father_came" 3 "year_birth< mother&father_came" 0 "born in this country"
label values came_control_new came_control
label variable came_control_new "Check for born this country"

*-------------------Merged with imputed years of schooling----------------------

// merge with years of schooling dataset
rename isced97 isced97_educ
merge m:1 country isced97_educ using  `median_yrschl'

// impute child years of schooling based on country and isced97
drop if _merge==2
drop observation1 sd1 min1 max1 

rename median_1 child_median_1
rename mean_1 child_mean_1
rename isced97_educ isced97
drop _merge

// impute mother years of schooling based on country and isced97
rename mother_isced97 isced97_educ
merge m:1 country isced97_educ using  `median_yrschl'

drop if _merge==2
drop observation1 sd1 min1 max1 

rename median_1 mother_median_1
rename mean_1 mother_mean_1
rename isced97_educ mother_isced97
drop _merge

// impute father years of schooling based on country and isced97
rename father_isced97 isced97_educ
merge m:1 country isced97_educ using  `median_yrschl'

drop if _merge==2
drop observation1 sd1 min1 max1 

rename median_1 father_median_1
rename mean_1 father_mean_1
rename isced97_educ father_isced97
drop _merge

/*==============================================================================
                       4: Final Sample - Children
==============================================================================*/

*-----------------Dropped missing or implausible observations-------------------


*drop obs where gender or year_birth missing
drop if gender==. | year_birth==. 

*drop obs where child born in another country
*tab came_control_new, m
keep if came_control_new==0

*drop obs where imputed years of schooling is missing
drop if  child_median_1==.

*drop obs where both parents are not available
*tab parent_match, m
keep if parent_match==1

*drop obs where child's age is implausible
*tab age_control_new, m
keep if age_control_new==0

*keep children aged 24+
*tab age, m
keep if age>23

*drop obs where the child is not own child of both parents
keep if own_child==2 | own_child==.
*tab own_child, m

*drop obs where parental education or parents' year of birth is missing. 
drop if  mother_median_1 ==. | father_median_1 ==. | mother_year==. | father_year==.

*drop obs where child gender recorded as "refusal" or "dont know"
drop if gender==-1 | gender==-2

*--------------------Defined bargaining measures--------------------------------

**create bargaining measures

// bargaining dummy: mother is more educated than the father
gen bargaining1=1 if mother_median_1>father_median_1
replace  bargaining1=0 if bargaining1==.
label variable bargaining1 "mother_median_1>father_median_1"

// bargaining defined as relative years of education of parents
gen bargaining1_rate=mother_median_1/father_median_1
label variable bargaining1_rate "mother_median_1/father_median_1"

** gen child's age structure
gen child_year_6=year_birth+6
gen child_year_7=year_birth+7
gen child_year_8=year_birth+8
gen child_year_9=year_birth+9
gen child_year_10=year_birth+10
gen child_year_11=year_birth+11
gen child_year_12=year_birth+12
gen child_year_13=year_birth+13
gen child_year_14=year_birth+14
gen child_year_15=year_birth+15

label variable child_year_6 "Year when child is ages of 6"
label variable child_year_7 "Year when child is ages of 7"
label variable child_year_6 "Year when child aged 6"
label variable child_year_7 "Year when child aged 7"
label variable child_year_8 "Year when child aged 8"
label variable child_year_9 "Year when child aged 9"
label variable child_year_10 "Year when child aged 10"
label variable child_year_11 "Year when child aged 11"
label variable child_year_12 "Year when child aged 12"
label variable child_year_13 "Year when child aged 13"
label variable child_year_14 "Year when child aged 14"
label variable child_year_15 "Year when child aged 15"

order year_birth, before (child_year_6)


**flag the subsamples of countries

// flagged transition countries, Israel and Portugal
gen problematic=1 if country==25 | country==28 | country==29 | country==32 | country==33 | country==34 | country==35 | country==47
replace problematic=0 if problematic==. 

// flagged transition countries and Israel 
gen transition=1 if country==25 | country==28 | country==29 | country==32 | country==34 | country==35 | country==47
replace transition=0 if transition==. 

save `children' , replace

*----------------------------END OF DO FILE-------------------------------------
*-------------------------------------------------------------------------------

