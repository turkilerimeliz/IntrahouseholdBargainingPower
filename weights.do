/*==============================================================================
            1: Dataset Construction Weights
==============================================================================*/

use "sharew1_rel7-1-0_gv_weights.dta", replace 
drop cchw_w1-ssu
 
merge 1:1 mergeid country  using "sharew2_rel7-1-0_gv_weights.dta"
drop cchw_w2-_merge
 
merge 1:1 mergeid country  using "sharew3_rel7-1-0_gv_weights.dta"
drop cchw_w3-_merge

merge 1:1 mergeid country  using "sharew4_rel7-1-0_gv_weights.dta"
drop cchw_w4-_merge

merge 1:1 mergeid country  using "sharew5_rel7-1-0_gv_weights.dta"
drop cchw_w5-_merge

merge 1:1 mergeid country  using "sharew6_rel7-1-0_gv_weights.dta"
drop cchw_w6-_merge

merge 1:1 mergeid country  using "sharew7_rel7-1-1_gv_weights.dta"
drop cchw_w7-_merge

order hhid1 hhid2 hhid3 hhid4 hhid5 hhid6 hhid7, before(mergeidp1)
order coupleid1 coupleid2 coupleid3 coupleid4 coupleid5 coupleid6 coupleid7, before(mergeidp1)
order country, after(mergeid)
order language, after(mergeid)

order dw_w1 dw_w2 dw_w3 dw_w4 dw_w5 dw_w6 dw_w7, before(coupleid1)


foreach i of num 1/7 {
gen wave_id`i'=1 if hhid`i'!=""
replace wave_id`i'=0 if wave_id`i'!=1
}

label variable wave_id1 "attended the 1st wave"
label variable wave_id2 "attended the 2nd wave"
label variable wave_id3 "attended the 3rd wave"
label variable wave_id4 "attended the 4th wave"
label variable wave_id5 "attended the 5th wave"
label variable wave_id6 "attended the 6st wave"
label variable wave_id7 "attended the 7th wave"
label define _merge 1 "YES", modify
label define wave_atendance 1 "attended" 0 "not attended"
label values wave_id1-wave_id7 wave_atendance
 
save `merged_weights', replace

*----------------------------END OF DO FILE-------------------------------------
*-------------------------------------------------------------------------------
