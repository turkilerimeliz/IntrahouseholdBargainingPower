/*==============================================================================
                       1:  Main Figures
==============================================================================*/

use "`dataout'\master_dataset.dta", replace

keep if original_sample==1

*_____________________________1.1 Main Figure___________________________________

********* Model 0

regress std_child_median std_mother_median std_father_median i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 ,  vce(cluster coupleid) 

* First 2 coefficients for girl sample
*maternal education = .24280
*paternal education = .21899



regress std_child_median std_mother_median std_father_median i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & original_sample==1 ,  vce(cluster coupleid) 

* First 2 coefficients for boy sample
*maternal education = .204660  
*paternal education = .252865  


gen prediction_girls_v0 = (std_mother_median*.24280 ) + (std_father_median*.21899)  if gender==2 & original_sample==1 
gen prediction_boys_v0 = (std_mother_median*.204660) + (std_father_median*.252865)  if gender==1 & original_sample==1 

gen prediction_yrsch_v0= prediction_girls_v0 if gender==2 & original_sample==1 
replace prediction_yrsch_v0= prediction_boys_v0 if gender==1 & original_sample==1 
drop prediction_girls_v0 prediction_boys_v0

********* Model 1

regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 ,  vce(cluster coupleid) 

* First 5 coefficients for girl sampl
*maternal education = .2001388
*paternal education = .2293344 
*bargaining = .0027262
*ME*BP = .0383997 
*PE*BP = -.0062537


regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & original_sample==1 ,  vce(cluster coupleid) 

* First 5 coefficients for boy sample
*maternal education =  .1997653 
*paternal education =  .2798693 
*bargaining = -.0593731
*ME*BP =    .0187492
*PE*BP =  -.0415405



gen prediction_girls_v1 = (std_mother_median*.2001388) + (std_father_median*.2293344) + (bargaining1_rate*.0027262) + (std_mother_median*bargaining1_rate*.0383997) + (std_father_median*bargaining1_rate*-.0062537) if gender==2 & original_sample==1 
gen prediction_boys_v1 = (std_mother_median*.1997653) + (std_father_median*.2798693) + (bargaining1_rate*-.0593731) + (std_mother_median*bargaining1_rate*.0187492) + (std_father_median*bargaining1_rate*-.0415405) if gender==1 & original_sample==1 


gen prediction_yrsch_v1= prediction_girls_v1 if gender==2 & original_sample==1 
replace prediction_yrsch_v1= prediction_boys_v1 if gender==1 & original_sample==1 
drop prediction_girls_v1 prediction_boys_v1

 // estimate mean values by clusters and countries
bysort country bargaining_cluster: egen mean_prediction_v0 = mean(prediction_yrsch_v0) if prediction_yrsch_v0!=. & original_sample==1
bysort country bargaining_cluster: egen mean_prediction_v1 = mean(prediction_yrsch_v1) if prediction_yrsch_v1!=. & original_sample==1
bysort country bargaining_cluster: egen mean_actual = mean(std_child_median) if std_child_median!=. & original_sample==1


*control 
forval i=11(1)16 {
	tab mean_actual if bargaining_cluster==1 & country==`i'
}

forval i=11(1)16 {
	sum std_child_median if bargaining_cluster==1 & country==`i'
}

 // generate standardized predictions and actual years of schooling
gen std_prediction_yrsch_v0= prediction_yrsch_v0-mean_prediction_v0
gen std_prediction_yrsch_v1= prediction_yrsch_v1-mean_prediction_v1
gen std_actual_yrsch= std_child_median-mean_actual

	 
		 
**Produce the graph
gen alfa=1
preserve
collapse (mean)std_prediction_yrsch_v0 (mean)std_prediction_yrsch_v1 (mean)std_actual_yrsch (count)observation=alfa if std_prediction_yrsch_v0!=. & std_prediction_yrsch_v1!=. & std_actual_yrsch & original_sample==1, by( gender mean_clusters ) 
format %9.3f std_prediction_yrsch_v0 std_prediction_yrsch_v1 std_actual_yrsch

twoway (connected std_prediction_yrsch_v0 mean_clusters if gender==1, mlabel(std_prediction_yrsch_v0) msize(vsmall)) (connected std_prediction_yrsch_v1 mean_clusters if gender==1, mlabel(std_prediction_yrsch_v1) msize(vsmall)) (connected std_actual_yrsch mean_clusters if gender==1, mlabel(std_actual_yrsch) msize(vsmall))(connected std_prediction_yrsch_v0 mean_clusters if gender==2, mlabel(std_prediction_yrsch_v0) msize(vsmall)) (connected std_prediction_yrsch_v1 mean_clusters if gender==2, mlabel(std_prediction_yrsch_v1) msize(vsmall)) (connected std_actual_yrsch mean_clusters if gender==2, mlabel(std_actual_yrsch) msize(vsmall)), ytitle(Child's years of schooling ) xtitle(Bargaining clusters) title(Child's years of schooling by bargaining clusters) legend(order( 1 "boys-model 0"  2 "boys-original model" 3 "boys-actual"4 "girls-model 0"  5 "girls-original model" 6 "girls-actual") size(small)) 
 
 graph save Graph "`figures'\Graph 1.gph", replace
restore


*____________________1.2 Main Figure with Family Wage Income____________________
**Sample: wage sample


********* Model 0

regress std_child_median std_mother_median std_father_median log_family_income_euro i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 & wage_sample4==1 ,  vce(cluster coupleid) 

* First 2 coefficients for girl sample
*maternal education = .214784 
*paternal education = .1922559 



regress std_child_median std_mother_median std_father_median log_family_income_euro i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & original_sample==1 &  wage_sample4==1,  vce(cluster coupleid) 

* First 2 coefficients for boy sample
*maternal education = .1738954   
*paternal education = .2354495   


gen prediction_girls_v0_faminc = (std_mother_median*.214784 ) + (std_father_median*.1922559)  if gender==2 & original_sample==1 & wage_sample4==1
gen prediction_boys_v0_faminc = (std_mother_median*.1738954) + (std_father_median*.2354495)  if gender==1 & original_sample==1 & wage_sample4==1
gen prediction_yrsch_v0_faminc= prediction_girls_v0_faminc if gender==2 & original_sample==1 & wage_sample4==1
replace prediction_yrsch_v0_faminc= prediction_boys_v0_faminc if gender==1 & original_sample==1 & wage_sample4==1
 
drop prediction_girls_v0_faminc prediction_boys_v0_faminc

********* Model 1

regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate log_family_income_euro i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 & wage_sample4==1 ,  vce(cluster coupleid) 

* First 5 coefficients for girl sample
*maternal education = .1516756
*paternal education = .2669728 
*bargaining = -.0495779 
*ME*BP = .0692213 
*PE*BP = -.0846617  


regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate log_family_income_euro i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & original_sample==1 & wage_sample4==1 ,  vce(cluster coupleid) 

* First 5 coefficients for boy sample
*maternal education =  .1822282  
*paternal education =  .2725623  
*bargaining = .0013506  
*ME*BP =    -.0082964 
*PE*BP =  -.03796 


gen prediction_girls_v1_faminc = (std_mother_median*.1516756) + (std_father_median*.2669728) + (bargaining1_rate*-.0495779 ) + (std_mother_median*bargaining1_rate*.0692213) + (std_father_median*bargaining1_rate*-.0846617) if gender==2 & original_sample==1 & wage_sample4==1
gen prediction_boys_v1_faminc = (std_mother_median*.1822282) + (std_father_median*.2725623) + (bargaining1_rate*.0013506) + (std_mother_median*bargaining1_rate*-.0082964) + (std_father_median*bargaining1_rate*-.03796) if gender==1 & original_sample==1 & wage_sample4==1


gen prediction_yrsch_v1_faminc= prediction_girls_v1_faminc if gender==2 & original_sample==1 & wage_sample4==1
replace prediction_yrsch_v1_faminc= prediction_boys_v1_faminc if gender==1 & original_sample==1 & wage_sample4==1
drop prediction_girls_v1_faminc prediction_boys_v1_faminc

// estimate mean values by clusters and countries
bysort country bargaining_cluster: egen mean_prediction_v0_faminc = mean(prediction_yrsch_v0_faminc ) if prediction_yrsch_v0_faminc !=. & original_sample==1 & wage_sample4==1
bysort country bargaining_cluster: egen mean_prediction_v1_faminc  = mean(prediction_yrsch_v1_faminc ) if prediction_yrsch_v1_faminc !=. & original_sample==1 & wage_sample4==1
bysort country bargaining_cluster: egen mean_actual_faminc = mean(std_child_median) if std_child_median!=. & original_sample==1 & wage_sample4==1


forval i=11(1)16 {
	tab mean_prediction_v0_faminc if bargaining_cluster==1 & country==`i'
}

forval i=11(1)16 {
	sum prediction_yrsch_v0_faminc if bargaining_cluster==1 & country==`i'
}

 // generate standardized predictions 
gen std_prediction_yrsch_v0_faminc= prediction_yrsch_v0_faminc-mean_prediction_v0_faminc
gen std_prediction_yrsch_v1_faminc= prediction_yrsch_v1_faminc-mean_prediction_v1_faminc
gen std_actual_yrsch_faminc= std_child_median-mean_actual_faminc

		 
**Produce the graph
gen alfa=1
preserve
keep if original_sample==1 & wage_sample4==1
collapse (mean)std_prediction_yrsch_v0_faminc (mean)std_prediction_yrsch_v1_faminc (mean)std_actual_yrsch_faminc (count)observation=alfa if std_prediction_yrsch_v0_faminc!=. & std_prediction_yrsch_v1_faminc!=. , by( gender mean_clusters ) 
format %9.3f std_prediction_yrsch_v0_faminc std_prediction_yrsch_v1_faminc std_actual_yrsch_faminc

twoway (connected std_prediction_yrsch_v0_faminc mean_clusters if gender==1, mlabel(std_prediction_yrsch_v0_faminc) msize(vsmall)) (connected std_prediction_yrsch_v1_faminc mean_clusters if gender==1, mlabel(std_prediction_yrsch_v1_faminc) msize(vsmall)) (connected std_actual_yrsch_faminc mean_clusters if gender==1, mlabel(std_actual_yrsch_faminc) msize(vsmall)) (connected std_prediction_yrsch_v0_faminc mean_clusters if gender==2, mlabel(std_prediction_yrsch_v0_faminc) msize(vsmall)) (connected std_prediction_yrsch_v1_faminc mean_clusters if gender==2, mlabel(std_prediction_yrsch_v1_faminc) msize(vsmall)) (connected std_actual_yrsch_faminc mean_clusters if gender==2, mlabel(std_actual_yrsch_faminc) msize(vsmall)) , ytitle(Child's years of schooling ) xtitle(Bargaining clusters) title(Child's years of schooling by bargaining clusters) legend(order( 1 "boys-model 0"  2 "boys-original model"  3 "boys-actual" 4 "girls-model 0"  5 "girls-original model"6 "girls-actual" ) size(small)) 
 
* graph save Graph "`figures'\Graph 1_v2.gph", replace
restore

*____________________1.3 Main Figure with Wage Sample___________________________
**Sample: wage sample
**Without controlling for family wage income

********* Model 0

regress std_child_median std_mother_median std_father_median  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 & wage_sample4==1 ,  vce(cluster coupleid) 

* First 2 coefficients for girl sample
*maternal education = .2280646
*paternal education = .2095239



regress std_child_median std_mother_median std_father_median  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & original_sample==1 &  wage_sample4==1,  vce(cluster coupleid) 

* First 2 coefficients for boy sample
*maternal education = .1864021  
*paternal education = .2508774  


gen prediction_girls_v0_wagesamp = (std_mother_median*.2280646 ) + (std_father_median*.2095239)  if gender==2 & original_sample==1 & wage_sample4==1
gen prediction_boys_v0_wagesamp = (std_mother_median*.1864021) + (std_father_median*.2508774)  if gender==1 & original_sample==1 & wage_sample4==1
gen prediction_yrsch_v0_wagesamp= prediction_girls_v0_wagesamp if gender==2 & original_sample==1 & wage_sample4==1
replace prediction_yrsch_v0_wagesamp= prediction_boys_v0_wagesamp if gender==1 & original_sample==1 & wage_sample4==1
 
drop prediction_girls_v0_wagesamp prediction_boys_v0_wagesamp


********* Model 1

regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 & wage_sample4==1 ,  vce(cluster coupleid) 

* First 5 coefficients for girl sample
*maternal education = .1595535
*paternal education = .2819598
*bargaining = -.0483408
*ME*BP = .0735722
*PE*BP = -.0817547  


regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & original_sample==1 & wage_sample4==1 ,  vce(cluster coupleid) 

* First 5 coefficients for boy sample
*maternal education =  .1900347 
*paternal education =  .2882569  
*bargaining = .0051333 
*ME*BP =    -.0050634
*PE*BP =  -.0367589



gen prediction_girls_v1_wagesamp = (std_mother_median*.1595535) + (std_father_median*.2819598) + (bargaining1_rate*-.0483408 ) + (std_mother_median*bargaining1_rate*.0735722) + (std_father_median*bargaining1_rate*-.0817547) if gender==2 & original_sample==1 & wage_sample4==1
gen prediction_boys_v1_wagesamp = (std_mother_median*.1900347) + (std_father_median*.2882569) + (bargaining1_rate*.0051333) + (std_mother_median*bargaining1_rate*-.0050634) + (std_father_median*bargaining1_rate*-.0367589) if gender==1 & original_sample==1 & wage_sample4==1


gen prediction_yrsch_v1_wagesamp= prediction_girls_v1_wagesamp if gender==2 & original_sample==1 & wage_sample4==1
replace prediction_yrsch_v1_wagesamp= prediction_boys_v1_wagesamp if gender==1 & original_sample==1 & wage_sample4==1
drop prediction_girls_v1_wagesamp prediction_boys_v1_wagesamp



// estimate mean values by clusters and countries
bysort country bargaining_cluster: egen mean_prediction_v0_wagesamp = mean(prediction_yrsch_v0_wagesamp) if prediction_yrsch_v0_wagesamp !=. & original_sample==1 & wage_sample4==1
bysort country bargaining_cluster: egen mean_prediction_v1_wagesamp  = mean(prediction_yrsch_v1_wagesamp) if prediction_yrsch_v1_wagesamp !=. & original_sample==1 & wage_sample4==1
bysort country bargaining_cluster: egen mean_actual_wagesample = mean(std_child_median) if std_child_median!=. & original_sample==1 & wage_sample4==1


forval i=11(1)16 {
	tab mean_prediction_v0_wagesamp if bargaining_cluster==1 & country==`i'
}

forval i=11(1)16 {
	sum prediction_yrsch_v0_wagesamp if bargaining_cluster==1 & country==`i'
}



 // generate standardized predictions 
gen std_prediction_yrsch_v0_wagesamp= prediction_yrsch_v0_wagesamp-mean_prediction_v0_wagesamp
gen std_prediction_yrsch_v1_wagesamp= prediction_yrsch_v1_wagesamp-mean_prediction_v1_wagesamp
gen std_actual_yrsch_wagesamp= std_child_median-mean_actual_wagesamp
		 
**Produce the graph
gen alfa=1
preserve
keep if original_sample==1 & wage_sample4==1
collapse (mean)std_prediction_yrsch_v0_wagesamp (mean)std_prediction_yrsch_v1_wagesamp (mean)std_actual_yrsch_wagesamp (count)observation=alfa if std_prediction_yrsch_v0_wagesamp!=. & std_prediction_yrsch_v1_wagesamp!=. , by( gender mean_clusters ) 
format %9.3f std_prediction_yrsch_v0_wagesamp std_prediction_yrsch_v1_wagesamp std_actual_yrsch_wagesamp

twoway (connected std_prediction_yrsch_v0_wagesamp mean_clusters if gender==1, mlabel(std_prediction_yrsch_v0_wagesamp) msize(vsmall)) (connected std_prediction_yrsch_v1_wagesamp mean_clusters if gender==1, mlabel(std_prediction_yrsch_v1_wagesamp) msize(vsmall)) (connected std_actual_yrsch_wagesamp mean_clusters if gender==1, mlabel(std_actual_yrsch_wagesamp) msize(vsmall)) (connected std_prediction_yrsch_v0_wagesamp mean_clusters if gender==2, mlabel(std_prediction_yrsch_v0_wagesamp) msize(vsmall)) (connected std_prediction_yrsch_v1_wagesamp mean_clusters if gender==2, mlabel(std_prediction_yrsch_v1_wagesamp) msize(vsmall)) (connected std_actual_yrsch_wagesamp mean_clusters if gender==2, mlabel(std_actual_yrsch_wagesamp) msize(vsmall)) , ytitle(Child's years of schooling ) xtitle(Bargaining clusters) title(Child's years of schooling by bargaining clusters) legend(order( 1 "boys-model 0"  2 "boys-original model"  3 "boys-actual" 4 "girls-model 0"  5 "girls-original model"6 "girls-actual" ) size(small)) 

* graph save Graph "`figures'\Graph 1_v3.gph", replace
restore




*__________________________1.4 Additional Figurese______________________________


gen IG_maternal_girls = (.2001388)+ (bargaining1_rate*.0383997) if gender==2 & original_sample==1 
gen IG_paternal_girls = (.2293344)+ (bargaining1_rate*-.0062537) if gender==2 & original_sample==1 

gen IG_maternal_boys = (.1997653)+ (bargaining1_rate*.0187492) if gender==1 & original_sample==1 
gen IG_paternal_boys = (.2798693)+ (bargaining1_rate*-.0415405) if gender==1 & original_sample==1 



preserve
collapse (mean)IG_maternal_girls (mean)IG_paternal_girls (count)observation=alfa if IG_maternal_girls!=. & IG_paternal_girls!=.  & original_sample==1, by( gender mean_clusters ) 
format %9.3f IG_maternal_girls IG_paternal_girls 

twoway (connected IG_maternal_girls mean_clusters if gender==2, mlabel(IG_maternal_girls) msize(vsmall)) (connected IG_paternal_girls mean_clusters if gender==2, mlabel(IG_paternal_girls) msize(vsmall)), ytitle(Marginal effect) xtitle(Bargaining clusters) title(Marginal effects of parental education) subtitle(Daughters) legend(order( 1 "maternal education"  2 "paternal education" 3) size(vsmall)) 
graph save Graph "`figures'\Graph 2.gph", replace
restore

preserve
collapse (mean)IG_maternal_boys (mean)IG_paternal_boys (count)observation=alfa if IG_maternal_boys!=. & IG_paternal_boys!=.  & original_sample==1, by( gender mean_clusters ) 
format %9.3f IG_maternal_boys IG_paternal_boys 

twoway (connected IG_maternal_boys mean_clusters if gender==1, mlabel(IG_maternal_boys) msize(vsmall)) (connected IG_paternal_boys mean_clusters if gender==1, mlabel(IG_paternal_boys) msize(vsmall)), ytitle(Marginal effect) xtitle(Bargaining clusters) title(Marginal effects of parental education) subtitle(Sons) legend(order( 1 "maternal education"  2 "paternal education" 3) size(vsmall)) 
graph save Graph "`figures'\Graph 3.gph", replace
restore

graph combine "`figures'\Graph 2.gph" "`figures'\Graph 3.gph" 
graph save Graph "`figures'\Graph 4.gph", replace


** Figure with Gender Gaps

*create predicted years of schooling by original model for girls.
regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 ,  vce(cluster coupleid) 
predict female_yrschl_predict if gender==2 & original_sample==1

   // define beta values corresponds to difference between prediction and counterfactual
gen b  = .
	replace b  = _b[c.bargaining1_rate]*bargaining1_rate + _b[c.std_mother_median#c.bargaining1_rate]*bargaining1_rate*std_mother_median +_b[c.std_father_median#c.bargaining1_rate]*bargaining1_rate*std_father_median if gender==2 & original_sample==1 

*create predicted years of schooling by original model for boys.
regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==1 & original_sample==1 ,  vce(cluster coupleid) 
predict male_yrschl_predict if gender==1 & original_sample==1
  // define beta values corresponds to difference between prediction and counterfactual
   replace b  = _b[c.bargaining1_rate]*bargaining1_rate + _b[c.std_mother_median#c.bargaining1_rate]*bargaining1_rate*std_mother_median +_b[c.std_father_median#c.bargaining1_rate]*bargaining1_rate*std_father_median if gender==1 & original_sample==1 

* Combine predictions for boys and girls
gen child_yrschl_predict=female_yrschl_predict
replace child_yrschl_predict=male_yrschl_predict if child_yrschl_predict==.
drop  female_yrschl_predict male_yrschl_predict

* Define counterfactual outcomes
gen child_yrschl_counter  = child_yrschl_predict - b


* Collapse data and calculate gender gap
tempfile figure
		forvalues i=1/2 {
		preserve
		keep if original_sample==1 & gender==`i'
		keep  child_yrschl_counter child_yrschl_predict b country bargaining_cluster alfa
		collapse child_yrschl_counter child_yrschl_predict b (sum) alfa, by(bargaining_cluster country ) cw

	    if `i'==1 {
		rename ch* ch*_male
		rename b  b_male
		rename alfa  alfa_male
		}
		
		if `i'==2 { 
		rename ch* ch*_female
		rename b  b_female
		rename alfa  alfa_female
		}
		
		if `i' == 2 merge 1:1 bargaining_cluster country using `figure'
		if `i' == 2 keep if _merge==3
		save `figure', replace
		restore
		}
		
		use `figure', replace
		gen  gap_pred=child_yrschl_predict_female-child_yrschl_predict_male
		gen  gap_counter=child_yrschl_counter_female-child_yrschl_counter_male
		
		// define weighted means
		egen weight = rowmean(alfa_female alfa_male)
		asgen mean_gap_pred = gap_pred , weight(weight) by (bargaining_cluster)
		asgen mean_gap_counter = gap_counter , weight(weight) by (bargaining_cluster)
		
		// define unweighted means
		bys bargaining_cluster: egen mean_gap_pred2 = mean(gap_pred)
        bys bargaining_cluster: egen mean_gap_counter2 = mean(gap_counter)

		// collapse by bargaining level
		collapse mean_gap_pred mean_gap_counter mean_gap_pred2 mean_gap_counter2, by(bargaining_cluster) cw
			gen gap_overall= (mean_gap_pred-mean_gap_counter)/mean_gap_counter
		    gen gap_overall2= (mean_gap_pred2-mean_gap_counter2)/mean_gap_counter2
		
		// figures
		
		 format %03.2f mean_gap_pred
         format %03.2f mean_gap_counter
         format %03.2f mean_gap_pred2
         format %03.2f mean_gap_counter2
         format %03.2f gap_overall
         format %03.2f gap_overall2

		twoway (connected mean_gap_pred bargaining_cluster, mlabel(mean_gap_pred) color(maroon)  msymbol(T)) (connected mean_gap_counter bargaining_cluster,  mlabel(mean_gap_counter) color(teal)  msymbol(T)) ,  legend(on)  plotregion(icolor(white)) graphregion(fcolor(white) color(white)) bgcolor(white)  xtit("Bargaining clusters" , size(small)) ytit("Gender Gap" , size(small)) 
		graph save Graph "`figures'\Graph 5.gph", replace
	
	    twoway (connected mean_gap_pred2 bargaining_cluster, mlabel(mean_gap_pred2) color(maroon)  msymbol(T)) (connected mean_gap_counter2 bargaining_cluster, mlabel(mean_gap_counter2)  color(teal)  msymbol(T)) ,  legend(on)  plotregion(icolor(white)) graphregion(fcolor(white) color(white)) bgcolor(white)  xtit("Bargaining clusters" , size(small)) ytit("Gender Gap (w/o weight)") , size(small)) 
		graph save Graph "`figures'\Graph 6.gph", replace
	
	
		twoway (connected gap_overall bargaining_cluster, mlabel(gap_overall) color(maroon)  msymbol(T))  ,  legend(on)  plotregion(icolor(white)) graphregion(fcolor(white) color(white)) bgcolor(white)  xtit("Bargaining clusters" , size(small)) ytit("Gender Gap" , size(small)) 
	    graph save Graph "`figures'\Graph 7.gph", replace

		twoway (connected gap_overall2 bargaining_cluster, mlabel(gap_overall2) color(maroon)  msymbol(T))  ,  legend(on)  plotregion(icolor(white)) graphregion(fcolor(white) color(white)) bgcolor(white)  xtit("Bargaining clusters" , size(small)) ytit("Gender Gap (w/o weight))" , size(small)) 
	    graph save Graph "`figures'\Graph 8.gph", replace

	
clear 

/*==============================================================================
                       2:  Age-Earning Profiles
==============================================================================*/


** AUSTRIA

use `Austria_job_episode',replace

preserve
keep if parent_sample==2

collapse (mean)mean_w_hat=w_hat if w_hat!=. , by(age gender educ_3level) 
twoway (connected mean_w_hat age if educ_3level==1, msize(vsmall)) (connected mean_w_hat age if educ_3level==2, msize(vsmall)) (connected mean_w_hat age if educ_3level==3, msize(vsmall)), ytitle(Average log monthly wage - cpi adjusted) xtitle(Age of respondent)  by(, title(Austria-imputed)) legend(order( 1 "low education level" 2 "medium education level" 3 "high education level") size(small))  by(, graphregion(fcolor(white)))  by(gender)
graph save Graph "`figures'\Austria_age_earning.gph", replace
restore

** BELGIUM
use `Belgium_job_episode',replace

preserve
keep if parent_sample==2

collapse (mean)mean_w_hat=w_hat if w_hat!=. , by(age gender educ_3level) 
twoway (connected mean_w_hat age if educ_3level==1, msize(vsmall)) (connected mean_w_hat age if educ_3level==2, msize(vsmall)) (connected mean_w_hat age if educ_3level==3, msize(vsmall)), ytitle(Average log monthly wage - cpi adjusted) xtitle(Age of respondent)  by(, title(Belgium-imputed)) legend(order( 1 "low education level" 2 "medium education level" 3 "high education level") size(small))  by(, graphregion(fcolor(white)))  by(gender)
graph save Graph "`figures'\Belgium_age_earning.gph", replace
restore

** DENMARK
use `Denmark_job_episode', replace

preserve
keep if parent_sample==2

collapse (mean)mean_w_hat=w_hat if w_hat!=. , by(age gender educ_3level) 
twoway (connected mean_w_hat age if educ_3level==1, msize(vsmall)) (connected mean_w_hat age if educ_3level==2, msize(vsmall)) (connected mean_w_hat age if educ_3level==3, msize(vsmall)), ytitle(Average log monthly wage - cpi adjusted) xtitle(Age of respondent)  by(, title(Denmark-imputed)) legend(order( 1 "low education level" 2 "medium education level" 3 "high education level") size(small))  by(, graphregion(fcolor(white)))  by(gender)
graph save Graph "`figures'\Denmark_age_earning.gph", replace
restore


** GERMANY
use `Germany_job_episode', replace

preserve
keep if parent_sample==2

collapse (mean)mean_w_hat=w_hat if w_hat!=. , by(age gender educ_3level) 
twoway (connected mean_w_hat age if educ_3level==1, msize(vsmall)) (connected mean_w_hat age if educ_3level==2, msize(vsmall)) (connected mean_w_hat age if educ_3level==3, msize(vsmall)), ytitle(Average log monthly wage - cpi adjusted) xtitle(Age of respondent)  by(, title(Germany-imputed)) legend(order( 1 "low education level" 2 "medium education level" 3 "high education level") size(small))  by(, graphregion(fcolor(white)))  by(gender)
graph save Graph "`figures'\Germany_age_earning.gph", replace
restore


** FRANCE
use `France_job_episode', replace

preserve
keep if parent_sample==2

collapse (mean)mean_w_hat=w_hat if w_hat!=. , by(age gender educ_3level) 
twoway (connected mean_w_hat age if educ_3level==1, msize(vsmall)) (connected mean_w_hat age if educ_3level==2, msize(vsmall)) (connected mean_w_hat age if educ_3level==3, msize(vsmall)), ytitle(Average log monthly wage - cpi adjusted) xtitle(Age of respondent)  by(, title(France-imputed)) legend(order( 1 "low education level" 2 "medium education level" 3 "high education level") size(small))  by(, graphregion(fcolor(white)))  by(gender)
graph save Graph "`figures'\France_age_earning.gph", replace
restore


** GREECE
use `Greece_job_episode', replace

preserve
keep if parent_sample==2

collapse (mean)mean_w_hat=w_hat if w_hat!=. , by(age gender educ_3level) 
twoway (connected mean_w_hat age if educ_3level==1, msize(vsmall)) (connected mean_w_hat age if educ_3level==2, msize(vsmall)) (connected mean_w_hat age if educ_3level==3, msize(vsmall)), ytitle(Average log monthly wage - cpi adjusted) xtitle(Age of respondent)  by(, title(Greece-imputed)) legend(order( 1 "low education level" 2 "medium education level" 3 "high education level") size(small))  by(, graphregion(fcolor(white)))  by(gender)
graph save Graph "`figures'\Greece_age_earning.gph", replace
restore


** IRELAND
use `Ireland_job_episode', replace

preserve
keep if parent_sample==2

collapse (mean)mean_w_hat=w_hat if w_hat!=. , by(age gender educ_3level) 
twoway (connected mean_w_hat age if educ_3level==1, msize(vsmall)) (connected mean_w_hat age if educ_3level==2, msize(vsmall)) (connected mean_w_hat age if educ_3level==3, msize(vsmall)), ytitle(Average log monthly wage - cpi adjusted) xtitle(Age of respondent)  by(, title(Ireland-imputed)) legend(order( 1 "low education level" 2 "medium education level" 3 "high education level") size(small))  by(, graphregion(fcolor(white)))  by(gender)
graph save Graph "`figures'\Ireland_age_earning.gph", replace
restore


** ITALY
use `Italy_job_episode', replace

preserve
keep if parent_sample==2

collapse (mean)mean_w_hat=w_hat if w_hat!=. , by(age gender educ_3level) 
twoway (connected mean_w_hat age if educ_3level==1, msize(vsmall)) (connected mean_w_hat age if educ_3level==2, msize(vsmall)) (connected mean_w_hat age if educ_3level==3, msize(vsmall)), ytitle(Average log monthly wage - cpi adjusted) xtitle(Age of respondent)  by(, title(Italy-imputed)) legend(order( 1 "low education level" 2 "medium education level" 3 "high education level") size(small))  by(, graphregion(fcolor(white)))  by(gender)
graph save Graph "`figures'\Italy_age_earning.gph", replace
restore

** PORTUGAL
use `Portugal_job_episode', replace

preserve
keep if parent_sample==2

collapse (mean)mean_w_hat=w_hat if w_hat!=. , by(age gender educ_3level) 
twoway (connected mean_w_hat age if educ_3level==1, msize(vsmall)) (connected mean_w_hat age if educ_3level==2, msize(vsmall)) (connected mean_w_hat age if educ_3level==3, msize(vsmall)), ytitle(Average log monthly wage - cpi adjusted) xtitle(Age of respondent)  by(, title(Portugal-imputed)) legend(order( 1 "low education level" 2 "medium education level" 3 "high education level") size(small))  by(, graphregion(fcolor(white)))  by(gender)
graph save Graph "`figures'\Portugal_age_earning.gph", replace
restore


** NETHERLANDS
use `Netherlands_job_episode', replace

preserve
keep if parent_sample==2

collapse (mean)mean_w_hat=w_hat if w_hat!=. , by(age gender educ_3level) 
twoway (connected mean_w_hat age if educ_3level==1, msize(vsmall)) (connected mean_w_hat age if educ_3level==2, msize(vsmall)) (connected mean_w_hat age if educ_3level==3, msize(vsmall)), ytitle(Average log monthly wage - cpi adjusted) xtitle(Age of respondent)  by(, title(Netherlands-imputed)) legend(order( 1 "low education level" 2 "medium education level" 3 "high education level") size(small))  by(, graphregion(fcolor(white)))  by(gender)
graph save Graph "`figures'\Netherlands_age_earning.gph", replace
restore


**LUXEMBOURG
use `Luxembourg_job_episode', replace

preserve
keep if parent_sample==2

collapse (mean)mean_w_hat=w_hat if w_hat!=. , by(age gender educ_3level) 
twoway (connected mean_w_hat age if educ_3level==1, msize(vsmall)) (connected mean_w_hat age if educ_3level==2, msize(vsmall)) (connected mean_w_hat age if educ_3level==3, msize(vsmall)), ytitle(Average log monthly wage - cpi adjusted) xtitle(Age of respondent)  by(, title(Luxembourg-imputed)) legend(order( 1 "low education level" 2 "medium education level" 3 "high education level") size(small))  by(, graphregion(fcolor(white)))  by(gender)
graph save Graph "`figures'\Luxembourg_age_earning.gph", replace
restore


**SPAIN
use `Spain_job_episode', replace

preserve
keep if parent_sample==2

collapse (mean)mean_w_hat=w_hat if w_hat!=. , by(age gender educ_3level) 
twoway (connected mean_w_hat age if educ_3level==1, msize(vsmall)) (connected mean_w_hat age if educ_3level==2, msize(vsmall)) (connected mean_w_hat age if educ_3level==3, msize(vsmall)), ytitle(Average log monthly wage - cpi adjusted) xtitle(Age of respondent)  by(, title(Spain-imputed)) legend(order( 1 "low education level" 2 "medium education level" 3 "high education level") size(small))  by(, graphregion(fcolor(white)))  by(gender)
graph save Graph "`figures'\Spain_age_earning.gph", replace
restore


**SWEDEN
use `Sweden_job_episode', replace

preserve
keep if parent_sample==2

collapse (mean)mean_w_hat=w_hat if w_hat!=. , by(age gender educ_3level) 
twoway (connected mean_w_hat age if educ_3level==1, msize(vsmall)) (connected mean_w_hat age if educ_3level==2, msize(vsmall)) (connected mean_w_hat age if educ_3level==3, msize(vsmall)), ytitle(Average log monthly wage - cpi adjusted) xtitle(Age of respondent)  by(, title(Sweden-imputed)) legend(order( 1 "low education level" 2 "medium education level" 3 "high education level") size(small))  by(, graphregion(fcolor(white)))  by(gender)
graph save Graph "`figures'\Sweden_age_earning.gph", replace
restore


**SWITZERLAND
use `Switzerland_job_episode', replace

preserve
keep if parent_sample==2

collapse (mean)mean_w_hat=w_hat if w_hat!=. , by(age gender educ_3level) 
twoway (connected mean_w_hat age if educ_3level==1, msize(vsmall)) (connected mean_w_hat age if educ_3level==2, msize(vsmall)) (connected mean_w_hat age if educ_3level==3, msize(vsmall)), ytitle(Average log monthly wage - cpi adjusted) xtitle(Age of respondent)  by(, title(Switzerland-imputed)) legend(order( 1 "low education level" 2 "medium education level" 3 "high education level") size(small))  by(, graphregion(fcolor(white)))  by(gender)
graph save Graph "`figures'\Switzerland_age_earning.gph", replace
restore

use "`dataout'\master_dataset.dta", replace

*----------------------------END OF DO FILE-------------------------------------
*-------------------------------------------------------------------------------
