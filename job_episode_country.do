/*==============================================================================
                   Country Specific Age-Earning Profiles
==============================================================================*/

use `job_episode' ,replace

/*==============================================================================
                            1: AUSTRIA
==============================================================================*/

preserve
keep if	country_res==40

*define cpi adjusted net annual wage & log versions 
gen euro_wage=wage if currency_new==1
replace euro_wage=wage*(1/CHF) if currency_new==14
replace euro_wage=wage*(1/DEM) if currency_new==18
replace euro_wage=wage*(1/DEM) if currency_new==267
replace euro_wage=wage*(1/DKK) if currency_new==19
replace euro_wage=wage*(1/FRF) if currency_new==23
replace euro_wage=wage*(1/GBP) if currency_new==24
replace euro_wage=wage*(1/GRD) if currency_new==25
replace euro_wage=wage*(1/SEK) if currency_new==186
gen nat_wage=wage if currency_new==2
replace nat_wage=wage if currency_new==266
replace nat_wage=euro_wage*ATS if nat_wage==.
gen cpi_wage=(nat_wage/cpi)*100
gen log_cpi_wage = ln(cpi_wage) 

*define partnership status, age2, 3 levels education codes
replace gender=0 if gender==2
label define gender 2 "", modify
label define gender 0 "Female", add
gen partner_married=1 if withpartner==1 | married==1
replace partner_married=0 if withpartner==0 & married==0
gen age2= age^2
gen educ_3level=1 if isced97_educ==0 | isced97_educ==1 | isced97_educ==2
replace educ_3level=2 if isced97_educ==3 | isced97_educ==4 
replace educ_3level=3 if isced97_educ==5 | isced97_educ==6
replace educ_3level=. if isced97_educ==.
replace educ_3level=-1 if isced97_educ_key==1 | isced97_educ==95 | isced97_educ==97

 // label and order variables
label variable partner_married "Married or have cohabited partner"
label variable log_cpi_wage "Log of annual net wage, cpi adjusted"
label variable nat_wage "Annual net wage,national currrency"
label variable cpi_wage "Annual net wage, national currency, cpi adjusted"
label variable log_cpi_wage "Log of annual net wage,national currency, cpi adjusted"
label variable age2 "age^2"
label variable educ_3level "Education level in 3 categories, low-medium-high"
label variable country_educ "country for educ document"
label var euro_wage "Wage info in euro currency"
order log_cpi_wage, before(wage)
order nat_wage, before(wage)
order cpi_wage, before(wage)
order euro_wage, before(wage)
order educ_3level, before(years_of_educ)
order age2, before(age)
order partner_married, before(married)

*drop obs recorded as part-time 
drop if working_hours==2

*drop obs where cpi value does not accessible
drop if year<1960

*drop obs where currency is not converted to national currency unit (exchange rate is not available in corresponding year)
drop if log_cpi_wage==.

*restrict the sample age
drop if age<16
drop if age>66

*drop obs where education info is missing, or recorded as don't know or refusal
drop if years_of_educ==. & isced97_educ==.
drop if years_of_educ==-1 & isced97_educ==-1
drop if years_of_educ==-2 & isced97_educ==-2

*drop outliers
drop if nat_wage>500000

*append with parents job episode
append using `Austria_parents_job'

replace parent_sample=2 if parent_sample==.
replace median_1=median1 if parent_sample==1
replace isced97_educ_key=isced97_key if parent_sample==1

*apply model to create w_hat
reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==1 & parent_sample==2, robust  
scalar  RMSE1= e(rmse)
predict w_hat1 if educ_3level==1 & gender==1
gen w_hat1_level= exp(w_hat1)* exp(RMSE1^2/2) if educ_3level==1 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==0 & parent_sample==2, robust 
scalar  RMSE1w= e(rmse)
predict w_hat1w if educ_3level==1 & gender==0
gen w_hat1w_level= exp(w_hat1w)* exp(RMSE1w^2/2) if educ_3level==1 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==1 & parent_sample==2, robust  
scalar  RMSE2= e(rmse)
predict w_hat2 if educ_3level==2 & gender==1
gen w_hat2_level= exp(w_hat2)* exp(RMSE2^2/2) if educ_3level==2 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==0 & parent_sample==2, robust  
scalar  RMSE2w= e(rmse)
predict w_hat2w if educ_3level==2 & gender==0
gen w_hat2w_level= exp(w_hat2w)* exp(RMSE2w^2/2) if educ_3level==2 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==1 & parent_sample==2, robust  
scalar  RMSE3= e(rmse)
predict w_hat3 if educ_3level==3 & gender==1
gen w_hat3_level= exp(w_hat3)* exp(RMSE3^2/2) if educ_3level==3 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==0 & parent_sample==2, robust  
scalar  RMSE3w= e(rmse)
predict w_hat3w if educ_3level==3 & gender==0
gen w_hat3w_level= exp(w_hat3w)* exp(RMSE3w^2/2) if educ_3level==3 & gender==0

* combine w_hat(i)
gen w_hat= w_hat1
replace w_hat= w_hat2 if w_hat==.
replace w_hat= w_hat3 if w_hat==.
replace w_hat= w_hat1w if w_hat==.
replace w_hat= w_hat2w if w_hat==.
replace w_hat= w_hat3w if w_hat==.

* combine w_hat_level(i)
gen w_hat_level= w_hat1_level
replace w_hat_level= w_hat2_level if w_hat_level==.
replace w_hat_level= w_hat3_level if w_hat_level==.
replace w_hat_level= w_hat1w_level if w_hat_level==.
replace w_hat_level= w_hat2w_level if w_hat_level==.
replace w_hat_level= w_hat3w_level if w_hat_level==.
label variable w_hat_level "Imputed wage, based on median education level"

* drop intermediate variables
drop w_hat1 w_hat1w w_hat2 w_hat2w w_hat3 w_hat3w w_hat2_level w_hat3_level w_hat1w_level w_hat2w_level w_hat3w_level

// save
save `Austria_job_episode', replace

// keep only parents
drop if parent_sample==2 

// keep necessary variables
keep  mergeid father_id mother_id gender yrbirth age2 age year country situation educ_3level years_of_educ years_of_educ_key isced97_educ isced97_educ_key working unemployed in_education retired mainjob ordjob industry job_title working_hours country_res_ nchildren_nat nchildren withpartner partner_married married child_coupleid child_country parent_status foreign_live migration_year parent_sample w_hat median_1 w_hat_level

// label variables
label variable parent_status "Identification for parent sample"
label variable parent_status "Identification for mergeid belongs to father/mother"
label variable parent_sample "Identification for parent sample"
label variable w_hat "Imputed log wage, based on median education level"

// define spouse_id
gen spouse_id=father_id
replace spouse_id=mother_id if spouse_id==""
label variable spouse_id "Spouse's mergeid"

drop father_id mother_id

// save
save  `Austria_parents_job_2'
restore 

/*==============================================================================
                            2: BELGIUM
==============================================================================*/

preserve
keep if	country_res==56

*define cpi adjusted net annual wage & log versions 
gen euro_wage=wage if currency_new==1
replace euro_wage=wage*(1/ATS) if currency_new==2
replace euro_wage=wage*(1/CHF) if currency_new==14
replace euro_wage=wage*(1/DEM) if currency_new==18
replace euro_wage=wage*(1/DKK) if currency_new==19
replace euro_wage=wage*(1/ESP) if currency_new==21
replace euro_wage=wage*(1/FRF) if currency_new==23
replace euro_wage=wage*(1/GBP) if currency_new==24
replace euro_wage=wage*(1/GRD) if currency_new==25
replace euro_wage=wage*(1/LUF) if currency_new==29
replace euro_wage=wage*(1/NLG) if currency_new==31
replace euro_wage=wage*(1/USD) if currency_new==41
replace euro_wage=wage*(1/SEK) if currency_new==186
replace euro_wage=wage*(1/ATS) if currency_new==266
replace euro_wage=wage*(1/DEM) if currency_new==267
replace euro_wage=wage*(1/NLG) if currency_new==269

gen nat_wage=wage if currency_new==5
replace nat_wage=wage if currency_new==260 & nat_wage==.
replace nat_wage=wage if currency_new==261  & nat_wage==.
replace nat_wage=euro_wage*BEF if nat_wage==.
gen cpi_wage=(nat_wage/cpi)*100
gen log_cpi_wage = ln(cpi_wage) 

*define partnership status, age2, 3 levels education codes
replace gender=0 if gender==2
label define gender 2 "", modify
label define gender 0 "Female", add
gen partner_married=1 if withpartner==1 | married==1
replace partner_married=0 if withpartner==0 & married==0
gen age2= age^2
gen educ_3level=1 if isced97_educ==0 | isced97_educ==1 | isced97_educ==2
replace educ_3level=2 if isced97_educ==3 | isced97_educ==4 
replace educ_3level=3 if isced97_educ==5 | isced97_educ==6
replace educ_3level=. if isced97_educ==.
replace educ_3level=-1 if isced97_educ_key==1 | isced97_educ==95 | isced97_educ==97 | isced97_educ==-1 | isced97_educ==-2
  // label and order variables
label variable partner_married "Married or have cohabited partner"
label variable log_cpi_wage "Log of annual net wage, cpi adjusted"
label variable nat_wage "Annual net wage,national currrency"
label variable cpi_wage "Annual net wage, national currency, cpi adjusted"
label variable log_cpi_wage "Log of annual net wage,national currency, cpi adjusted"
label variable age2 "age^2"
label variable educ_3level "Education level in 3 categories, low-medium-high"
label variable country_educ "country for educ document"

 //further checks
/*tab x
tab x if year>1954
tab educ_3level if year>1954
tab age if year>1954
tab x if log_cpi_wage!=. & year>1954
tab gender if year>1954
tab isced97_educ
tab years_of_educ
*/

  //flag implausible observations
replace years_of_educ=-3 if years_of_educ==1983

  //order variables
order log_cpi_wage, before(wage)
order nat_wage, before(wage)
order cpi_wage, before(wage)
order educ_3level, before(years_of_educ)
order age2, before(age)
order partner_married, before(married)

*restrict the sample age
drop if age<16
drop if age>66

*drop obs recorded as part-time
drop if working_hours==2

*drop obs where cpi value does not accessible
drop if year<1955

*drop obs where currency is not converted to national currency unit (exchange rate is not available in corresponding year)
drop if log_cpi_wage==.
 
*drop obs where education info is missing, or recorded as don't know or refusal
drop if years_of_educ==. & isced97_educ==.
drop if years_of_educ==-1 & isced97_educ==-1
drop if years_of_educ==-2 & isced97_educ==-2

*drop outliers
*tab cpi_wage if cpi_wage >745643
drop if cpi_wage> 745643

*append with parents job episode
append using `Belgium_parents_job'

replace parent_sample=2 if parent_sample==.
replace median_1=median1 if parent_sample==1
replace isced97_educ_key=isced97_key if parent_sample==1

*apply model to create w_hat
reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==1 & parent_sample==2, robust  
scalar  RMSE1= e(rmse)
predict w_hat1 if educ_3level==1 & gender==1
gen w_hat1_level= exp(w_hat1)* exp(RMSE1^2/2) if educ_3level==1 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==0 & parent_sample==2, robust 
scalar  RMSE1w= e(rmse)
predict w_hat1w if educ_3level==1 & gender==0
gen w_hat1w_level= exp(w_hat1w)* exp(RMSE1w^2/2) if educ_3level==1 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==1 & parent_sample==2, robust  
scalar  RMSE2= e(rmse)
predict w_hat2 if educ_3level==2 & gender==1
gen w_hat2_level= exp(w_hat2)* exp(RMSE2^2/2) if educ_3level==2 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==0 & parent_sample==2, robust  
scalar  RMSE2w= e(rmse)
predict w_hat2w if educ_3level==2 & gender==0
gen w_hat2w_level= exp(w_hat2w)* exp(RMSE2w^2/2) if educ_3level==2 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==1 & parent_sample==2, robust  
scalar  RMSE3= e(rmse)
predict w_hat3 if educ_3level==3 & gender==1
gen w_hat3_level= exp(w_hat3)* exp(RMSE3^2/2) if educ_3level==3 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==0 & parent_sample==2, robust  
scalar  RMSE3w= e(rmse)
predict w_hat3w if educ_3level==3 & gender==0
gen w_hat3w_level= exp(w_hat3w)* exp(RMSE3w^2/2) if educ_3level==3 & gender==0

* combine w_hat(i)
gen w_hat= w_hat1
replace w_hat= w_hat2 if w_hat==.
replace w_hat= w_hat3 if w_hat==.
replace w_hat= w_hat1w if w_hat==.
replace w_hat= w_hat2w if w_hat==.
replace w_hat= w_hat3w if w_hat==.

* combine w_hat_level(i)
gen w_hat_level= w_hat1_level
replace w_hat_level= w_hat2_level if w_hat_level==.
replace w_hat_level= w_hat3_level if w_hat_level==.
replace w_hat_level= w_hat1w_level if w_hat_level==.
replace w_hat_level= w_hat2w_level if w_hat_level==.
replace w_hat_level= w_hat3w_level if w_hat_level==.
label variable w_hat_level "Imputed wage, based on median education level"

* drop intermediate variables
drop w_hat1 w_hat1w w_hat2 w_hat2w w_hat3 w_hat3w w_hat2_level w_hat3_level w_hat1w_level w_hat2w_level w_hat3w_level

//save
save `Belgium_job_episode' , replace

// keep only parents
drop if parent_sample==2

// keep necessary variables
keep  mergeid father_id mother_id gender yrbirth age2 age year country situation educ_3level years_of_educ years_of_educ_key isced97_educ isced97_educ_key working unemployed in_education retired mainjob ordjob industry job_title working_hours country_res_ nchildren_nat nchildren withpartner partner_married married child_coupleid child_country parent_status foreign_live migration_year parent_sample w_hat median_1 w_hat_level

 // label variables
label variable parent_status "Identification for parent sample"
label variable parent_status "Identification for mergeid belongs to father/mother"
label variable parent_sample "Identification for parent sample"
label variable w_hat "Imputed log wage, based on median education level"

// define spouse_id
gen spouse_id=father_id
replace spouse_id=mother_id if spouse_id==""
label variable spouse_id "Spouse's mergeid"

drop father_id mother_id

//save
save  `Belgium_parents_job_2', replace
restore 


/*==============================================================================
                            3: DENMARK
==============================================================================*/

preserve
keep if	country_res==208

*define cpi adjusted net annual wage & log versions
gen euro_wage=wage if currency_new==1
replace euro_wage=wage*(1/ATS) if currency_new==2
replace euro_wage=wage*(1/BEF) if currency_new==5
replace euro_wage=wage*(1/CHF) if currency_new==14
replace euro_wage=wage*(1/DEM) if currency_new==18
replace euro_wage=wage*(1/ESP) if currency_new==21
replace euro_wage=wage*(1/FRF) if currency_new==23
replace euro_wage=wage*(1/GBP) if currency_new==24
replace euro_wage=wage*(1/GRD) if currency_new==25
replace euro_wage=wage*(1/ITL) if currency_new==28
replace euro_wage=wage*(1/LUF) if currency_new==29
replace euro_wage=wage*(1/NLG) if currency_new==31
replace euro_wage=wage*(1/USD) if currency_new==41
replace euro_wage=wage*(1/NOK) if currency_new==164
replace euro_wage=wage*(1/SEK) if currency_new==186
replace euro_wage=wage*(1/GBP) if currency_new==265
replace euro_wage=wage*(1/DEM) if currency_new==267
replace euro_wage=wage*(1/USD) if currency_new==277

gen nat_wage=wage if currency_new==19
replace nat_wage=wage if currency_new==272 & nat_wage==.
replace nat_wage=euro_wage*DKK if nat_wage==.

gen cpi_wage=(nat_wage/cpi)*100
gen log_cpi_wage = ln(cpi_wage) 


*define partnership status, age2, 3 levels education codes
replace gender=0 if gender==2
label define gender 2 "", modify
label define gender 0 "Female", add
gen partner_married=1 if withpartner==1 | married==1
replace partner_married=0 if withpartner==0 & married==0
gen age2= age^2
gen educ_3level=1 if isced97_educ==0 | isced97_educ==1 | isced97_educ==2
replace educ_3level=2 if isced97_educ==3 | isced97_educ==4 
replace educ_3level=3 if isced97_educ==5 | isced97_educ==6
replace educ_3level=. if isced97_educ==.
replace educ_3level=-1 if isced97_educ_key==1 | isced97_educ==95 | isced97_educ==97 | isced97_educ==-1 | isced97_educ==-2

 // label variables
label variable partner_married "Married or have cohabited partner"
label variable log_cpi_wage "Log of annual net wage, cpi adjusted"
label variable nat_wage "Annual net wage,national currrency"
label variable cpi_wage "Annual net wage, national currency, cpi adjusted"
label variable log_cpi_wage "Log of annual net wage,national currency, cpi adjusted"
label variable age2 "age^2"
label variable educ_3level "Education level in 3 categories, low-medium-high"
label variable country_educ "country for educ document"

 // further checks
/*tab x
tab x if year>1959
tab educ_3level if year>1959
tab age if year>1959
tab x if log_cpi_wage!=. & year>1959
tab gender if year>1959
tab isced97_educ if year>1959
tab years_of_educ if year>1959
*/

 // order variables
order log_cpi_wage, before(wage)
order nat_wage, before(wage)
order cpi_wage, before(wage)
order educ_3level, before(years_of_educ)
order age2, before(age)
order partner_married, before(married)

*restrict the sample age
drop if age<16
drop if age>66

*drop obs recorded as part-time
drop if working_hours==2

*drop obs where cpi value does not accessible
drop if year<1960

*drop obs where currency is not converted to national currency unit (exchange rate is not available in corresponding year)
 drop if log_cpi_wage==.

*drop obs where education info is missing, or recorded as don't know or refusal
drop if years_of_educ==. & isced97_educ==.
drop if years_of_educ==-1 & isced97_educ==-1
drop if years_of_educ==-2 & isced97_educ==-2

*drop outliers
*tab cpi_wage 
*tab cpi_wage if cpi_wage> 117638
drop if cpi_wage> 117638

*append with parents job episode
append using `Denmark_parents_job'

replace parent_sample=2 if parent_sample==.
replace median_1=median1 if parent_sample==1
replace isced97_educ_key=isced97_key if parent_sample==1

*apply model to create w_hat
reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==1 & parent_sample==2, robust  
scalar  RMSE1= e(rmse)
predict w_hat1 if educ_3level==1 & gender==1
gen w_hat1_level= exp(w_hat1)* exp(RMSE1^2/2) if educ_3level==1 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==0 & parent_sample==2, robust 
scalar  RMSE1w= e(rmse)
predict w_hat1w if educ_3level==1 & gender==0
gen w_hat1w_level= exp(w_hat1w)* exp(RMSE1w^2/2) if educ_3level==1 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==1 & parent_sample==2, robust  
scalar  RMSE2= e(rmse)
predict w_hat2 if educ_3level==2 & gender==1
gen w_hat2_level= exp(w_hat2)* exp(RMSE2^2/2) if educ_3level==2 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==0 & parent_sample==2, robust  
scalar  RMSE2w= e(rmse)
predict w_hat2w if educ_3level==2 & gender==0
gen w_hat2w_level= exp(w_hat2w)* exp(RMSE2w^2/2) if educ_3level==2 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==1 & parent_sample==2, robust  
scalar  RMSE3= e(rmse)
predict w_hat3 if educ_3level==3 & gender==1
gen w_hat3_level= exp(w_hat3)* exp(RMSE3^2/2) if educ_3level==3 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==0 & parent_sample==2, robust  
scalar  RMSE3w= e(rmse)
predict w_hat3w if educ_3level==3 & gender==0
gen w_hat3w_level= exp(w_hat3w)* exp(RMSE3w^2/2) if educ_3level==3 & gender==0

* combine w_hat(i)
gen w_hat= w_hat1
replace w_hat= w_hat2 if w_hat==.
replace w_hat= w_hat3 if w_hat==.
replace w_hat= w_hat1w if w_hat==.
replace w_hat= w_hat2w if w_hat==.
replace w_hat= w_hat3w if w_hat==.

* combine w_hat_level(i)
gen w_hat_level= w_hat1_level
replace w_hat_level= w_hat2_level if w_hat_level==.
replace w_hat_level= w_hat3_level if w_hat_level==.
replace w_hat_level= w_hat1w_level if w_hat_level==.
replace w_hat_level= w_hat2w_level if w_hat_level==.
replace w_hat_level= w_hat3w_level if w_hat_level==.
label variable w_hat_level "Imputed wage, based on median education level"

* drop intermediate variables
drop w_hat1 w_hat1w w_hat2 w_hat2w w_hat3 w_hat3w w_hat2_level w_hat3_level w_hat1w_level w_hat2w_level w_hat3w_level

// save
save `Denmark_job_episode', replace

// keep only parents
drop if parent_sample==2

// keep necessary variables
keep  mergeid father_id mother_id gender yrbirth age2 age year country situation educ_3level years_of_educ years_of_educ_key isced97_educ isced97_educ_key working unemployed in_education retired mainjob ordjob industry job_title working_hours country_res_ nchildren_nat nchildren withpartner partner_married married child_coupleid child_country parent_status foreign_live migration_year parent_sample w_hat median_1 w_hat_level

 // label variables
label variable parent_status "Identification for parent sample"
label variable parent_status "Identification for mergeid belongs to father/mother"
label variable parent_sample "Identification for parent sample"
label variable w_hat "Imputed log wage, based on median education level"

// define spouse id 
gen spouse_id=father_id
replace spouse_id=mother_id if spouse_id==""
label variable spouse_id "Spouse's mergeid"

drop father_id mother_id

//save
save  `Denmark_parents_job_2', replace
restore 

/*==============================================================================
                            4: GERMANY
==============================================================================*/

preserve
keep if	country_res==276 | country_res==278 | country_res==280

*define cpi adjusted net annual wage & log versions
gen euro_wage=wage if currency_new==1
replace euro_wage=wage*(1/ATS) if currency_new==2
replace euro_wage=wage*(1/BEF) if currency_new==5
replace euro_wage=wage*(1/CHF) if currency_new==14
replace euro_wage=wage*(1/CZK) if currency_new==16
replace euro_wage=wage*(1/DKK) if currency_new==19
replace euro_wage=wage*(1/ESP) if currency_new==21
replace euro_wage=wage*(1/FRF) if currency_new==23
replace euro_wage=wage*(1/GBP) if currency_new==24
replace euro_wage=wage*(1/GRD) if currency_new==25
replace euro_wage=wage*(1/IEP) if currency_new==26
replace euro_wage=wage*(1/ITL) if currency_new==28
replace euro_wage=wage*(1/LUF) if currency_new==29
replace euro_wage=wage*(1/NLG) if currency_new==31
replace euro_wage=wage*(1/PLN) if currency_new==32
replace euro_wage=wage*(1/PTE) if currency_new==34
replace euro_wage=wage*(1/RUB) if currency_new==35
replace euro_wage=wage*(1/USD) if currency_new==41
replace euro_wage=wage*(1/HRK) if currency_new==109
replace euro_wage=wage*(1/HUF) if currency_new==111
replace euro_wage=wage*(1/NOK) if currency_new==164
replace euro_wage=wage*(1/SEK) if currency_new==186
replace euro_wage=wage*(1/GBP) if currency_new==265
replace euro_wage=wage*(1/ATS) if currency_new==266
replace euro_wage=wage*(1/NLG) if currency_new==269
replace euro_wage=wage*(1/ESP) if currency_new==273
replace euro_wage=wage*(1/USD) if currency_new==277
replace euro_wage=wage*(1/PTE) if currency_new==281

gen nat_wage=wage if currency_new==18
replace nat_wage=wage if currency_new==267 & nat_wage==.
replace nat_wage=euro_wage*DEM if nat_wage==.
gen cpi_wage=(nat_wage/cpi)*100
gen log_cpi_wage = ln(cpi_wage) 

*define partnership status, age2, 3 levels education codes
replace gender=0 if gender==2
label define gender 2 "", modify
label define gender 0 "Female", add

gen partner_married=1 if withpartner==1 | married==1
replace partner_married=0 if withpartner==0 & married==0
gen age2= age^2
gen educ_3level=1 if isced97_educ==0 | isced97_educ==1 | isced97_educ==2
replace educ_3level=2 if isced97_educ==3 | isced97_educ==4 
replace educ_3level=3 if isced97_educ==5 | isced97_educ==6
replace educ_3level=. if isced97_educ==.
replace educ_3level=-1 if isced97_educ_key==1 | isced97_educ==95 | isced97_educ==97 | isced97_educ==-1 | isced97_educ==-2

 // label variables
label variable partner_married "Married or have cohabited partner"
label variable log_cpi_wage "Log of annual net wage, cpi adjusted"
label variable nat_wage "Annual net wage,national currrency"
label variable cpi_wage "Annual net wage, national currency, cpi adjusted"
label variable log_cpi_wage "Log of annual net wage,national currency, cpi adjusted"
label variable age2 "age^2"
label variable educ_3level "Education level in 3 categories, low-medium-high"
label variable country_educ "country for educ document"

 // further checks
/*
tab x
tab x if year>1955
tab educ_3level if year>1955
tab age if year>1955
tab x if log_cpi_wage!=. & year>1955
tab gender if year>1955
tab isced97_educ if year>1955
tab years_of_educ if year>1955
*/

// flag implausible observations
replace years_of_educ=-3 if years_of_educ==1969
replace years_of_educ=-3 if years_of_educ==1970
replace years_of_educ=-3 if years_of_educ==1973
replace years_of_educ=-3 if years_of_educ==1969
replace years_of_educ=-3 if years_of_educ==9000

  // order variables
order log_cpi_wage, before(wage)
order nat_wage, before(wage)
order cpi_wage, before(wage)
order educ_3level, before(years_of_educ)
order age2, before(age)
order partner_married, before(married)

*restrict the sample age
drop if age<16
drop if age>66

*drop obs recorded as part-time
drop if working_hours==2
*drop obs where cpi value does not accessible
drop if year<1955
*drop obs where currency is not converted to national currency unit (exchange rate is not available in corresponding year)
drop if log_cpi_wage==.

*drop obs where education info is missing, or recorded as don't know or refusal
drop if years_of_educ==. & isced97_educ==.
drop if years_of_educ==-1 & isced97_educ==-1
drop if years_of_educ==-2 & isced97_educ==-2

*drop outliers
*sum cpi_wage, d
*tab cpi_wage if cpi_wage>11899
drop if cpi_wage>15287.18 

*append with parents job episode
append using `Germany_parents_job'

replace parent_sample=2 if parent_sample==.
replace median_1=median1 if parent_sample==1
replace isced97_educ_key=isced97_key if parent_sample==1

*apply model to create w_hat
reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==1 & parent_sample==2, robust  
scalar  RMSE1= e(rmse)
predict w_hat1 if educ_3level==1 & gender==1
gen w_hat1_level= exp(w_hat1)* exp(RMSE1^2/2) if educ_3level==1 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==0 & parent_sample==2, robust 
scalar  RMSE1w= e(rmse)
predict w_hat1w if educ_3level==1 & gender==0
gen w_hat1w_level= exp(w_hat1w)* exp(RMSE1w^2/2) if educ_3level==1 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==1 & parent_sample==2, robust  
scalar  RMSE2= e(rmse)
predict w_hat2 if educ_3level==2 & gender==1
gen w_hat2_level= exp(w_hat2)* exp(RMSE2^2/2) if educ_3level==2 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==0 & parent_sample==2, robust  
scalar  RMSE2w= e(rmse)
predict w_hat2w if educ_3level==2 & gender==0
gen w_hat2w_level= exp(w_hat2w)* exp(RMSE2w^2/2) if educ_3level==2 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==1 & parent_sample==2, robust  
scalar  RMSE3= e(rmse)
predict w_hat3 if educ_3level==3 & gender==1
gen w_hat3_level= exp(w_hat3)* exp(RMSE3^2/2) if educ_3level==3 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==0 & parent_sample==2, robust  
scalar  RMSE3w= e(rmse)
predict w_hat3w if educ_3level==3 & gender==0
gen w_hat3w_level= exp(w_hat3w)* exp(RMSE3w^2/2) if educ_3level==3 & gender==0

* combine w_hat(i)
gen w_hat= w_hat1
replace w_hat= w_hat2 if w_hat==.
replace w_hat= w_hat3 if w_hat==.
replace w_hat= w_hat1w if w_hat==.
replace w_hat= w_hat2w if w_hat==.
replace w_hat= w_hat3w if w_hat==.

* combine w_hat_level(i)
gen w_hat_level= w_hat1_level
replace w_hat_level= w_hat2_level if w_hat_level==.
replace w_hat_level= w_hat3_level if w_hat_level==.
replace w_hat_level= w_hat1w_level if w_hat_level==.
replace w_hat_level= w_hat2w_level if w_hat_level==.
replace w_hat_level= w_hat3w_level if w_hat_level==.
label variable w_hat_level "Imputed wage, based on median education level"

* drop intermediate variables
drop w_hat1 w_hat1w w_hat2 w_hat2w w_hat3 w_hat3w w_hat2_level w_hat3_level w_hat1w_level w_hat2w_level w_hat3w_level

// save
save `Germany_job_episode', replace

// keep only parents
drop if parent_sample==2

// keep necessary variables
keep  mergeid father_id mother_id gender yrbirth age2 age year country situation educ_3level years_of_educ years_of_educ_key isced97_educ isced97_educ_key working unemployed in_education retired mainjob ordjob industry job_title working_hours country_res_ nchildren_nat nchildren withpartner partner_married married child_coupleid child_country parent_status foreign_live migration_year parent_sample w_hat median_1 w_hat_level

   // label variables
label variable parent_status "Identification for parent sample"
label variable parent_status "Identification for mergeid belongs to father/mother"
label variable parent_sample "Identification for parent sample"
label variable w_hat "Imputed log wage, based on median education level"

// define spouse id
gen spouse_id=father_id
replace spouse_id=mother_id if spouse_id==""
label variable spouse_id "Spouse's mergeid"

drop father_id mother_id

// save
save  `Germany_parents_job_2', replace
restore 

/*==============================================================================
                            5: FRANCE
==============================================================================*/

preserve
keep if	country_res==250

*define cpi adjusted net annual wage & log versions
gen euro_wage=wage if currency_new==1
replace euro_wage=wage*(1/ATS) if currency_new==2
replace euro_wage=wage*(1/BEF) if currency_new==5
replace euro_wage=wage*(1/CHF) if currency_new==14
replace euro_wage=wage*(1/DEM) if currency_new==18
replace euro_wage=wage*(1/DKK) if currency_new==19
replace euro_wage=wage*(1/ESP) if currency_new==21
replace euro_wage=wage*(1/FRF) if currency_new==23
replace euro_wage=wage*(1/GBP) if currency_new==24
replace euro_wage=wage*(1/GRD) if currency_new==25
replace euro_wage=wage*(1/IEP) if currency_new==26
replace euro_wage=wage*(1/ITL) if currency_new==28
replace euro_wage=wage*(1/LUF) if currency_new==29
replace euro_wage=wage*(1/NLG) if currency_new==31
replace euro_wage=wage*(1/PTE) if currency_new==34
replace euro_wage=wage*(1/USD) if currency_new==41
replace euro_wage=wage*(1/HRK) if currency_new==109
replace euro_wage=wage*(1/NOK) if currency_new==164
replace euro_wage=wage*(1/SEK) if currency_new==186
replace euro_wage=wage*(1/GBP) if currency_new==265
replace euro_wage=wage*(1/DEM) if currency_new==267
replace euro_wage=wage*(1/NLG) if currency_new==269
replace euro_wage=wage*(1/USD) if currency_new==277
replace euro_wage=wage*(1/PTE) if currency_new==281

gen nat_wage=wage if currency_new==23
replace nat_wage=wage if currency_new==261 & nat_wage==.
replace nat_wage=euro_wage*FRF if nat_wage==.
gen cpi_wage=(nat_wage/cpi)*100
gen log_cpi_wage = ln(cpi_wage) 

*define partnership status, age2, 3 levels education codes
replace gender=0 if gender==2
label define gender 2 "", modify
label define gender 0 "Female", add

gen partner_married=1 if withpartner==1 | married==1
replace partner_married=0 if withpartner==0 & married==0
gen age2= age^2
gen educ_3level=1 if isced97_educ==0 | isced97_educ==1 | isced97_educ==2
replace educ_3level=2 if isced97_educ==3 | isced97_educ==4 
replace educ_3level=3 if isced97_educ==5 | isced97_educ==6
replace educ_3level=. if isced97_educ==.
replace educ_3level=-1 if isced97_educ_key==1 | isced97_educ==95 | isced97_educ==97 | isced97_educ==-1 | isced97_educ==-2

  // label variables
label variable partner_married "Married or have cohabited partner"
label variable log_cpi_wage "Log of annual net wage, cpi adjusted"
label variable nat_wage "Annual net wage,national currrency"
label variable cpi_wage "Annual net wage, national currency, cpi adjusted"
label variable log_cpi_wage "Log of annual net wage,national currency, cpi adjusted"
label variable age2 "age^2"
label variable educ_3level "Education level in 3 categories, low-medium-high"
label variable country_educ "country for educ document"

  // further checks
/*
*kontroller
tab x
tab x if year>1955
tab educ_3level if year>1955
tab age if year>1955
tab x if log_cpi_wage!=. & year>1955
tab gender if year>1955
tab isced97_educ if year>1955
tab years_of_educ if year>1955
*/

  //order variables
order log_cpi_wage, before(wage)
order nat_wage, before(wage)
order cpi_wage, before(wage)
order educ_3level, before(years_of_educ)
order age2, before(age)
order partner_married, before(married)

*restrict the sample age
drop if age<16
drop if age>66

*drop obs recorded as part-time
drop if working_hours==2

*drop obs where cpi value does not accessible
drop if year<1955

*drop obs where currency is not converted to national currency unit (exchange rate is not available in corresponding year)
drop if log_cpi_wage==.

*drop obs where education info is missing, or recorded as don't know or refusal
drop if years_of_educ==. & isced97_educ==.
drop if years_of_educ==-1 & isced97_educ==-1
drop if years_of_educ==-2 & isced97_educ==-2

*drop outliers
sum cpi_wage, d 
tab cpi_wage if cpi_wage>258278 
drop if cpi_wage>259382 

*append with parents job episode
append using `France_parents_job'

replace parent_sample=2 if parent_sample==.
replace median_1=median1 if parent_sample==1
replace isced97_educ_key=isced97_key if parent_sample==1

*apply model to create w_hat
reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==1 & parent_sample==2, robust  
scalar  RMSE1= e(rmse)
predict w_hat1 if educ_3level==1 & gender==1
gen w_hat1_level= exp(w_hat1)* exp(RMSE1^2/2) if educ_3level==1 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==0 & parent_sample==2, robust 
scalar  RMSE1w= e(rmse)
predict w_hat1w if educ_3level==1 & gender==0
gen w_hat1w_level= exp(w_hat1w)* exp(RMSE1w^2/2) if educ_3level==1 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==1 & parent_sample==2, robust  
scalar  RMSE2= e(rmse)
predict w_hat2 if educ_3level==2 & gender==1
gen w_hat2_level= exp(w_hat2)* exp(RMSE2^2/2) if educ_3level==2 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==0 & parent_sample==2, robust  
scalar  RMSE2w= e(rmse)
predict w_hat2w if educ_3level==2 & gender==0
gen w_hat2w_level= exp(w_hat2w)* exp(RMSE2w^2/2) if educ_3level==2 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==1 & parent_sample==2, robust  
scalar  RMSE3= e(rmse)
predict w_hat3 if educ_3level==3 & gender==1
gen w_hat3_level= exp(w_hat3)* exp(RMSE3^2/2) if educ_3level==3 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==0 & parent_sample==2, robust  
scalar  RMSE3w= e(rmse)
predict w_hat3w if educ_3level==3 & gender==0
gen w_hat3w_level= exp(w_hat3w)* exp(RMSE3w^2/2) if educ_3level==3 & gender==0

* combine w_hat(i)
gen w_hat= w_hat1
replace w_hat= w_hat2 if w_hat==.
replace w_hat= w_hat3 if w_hat==.
replace w_hat= w_hat1w if w_hat==.
replace w_hat= w_hat2w if w_hat==.
replace w_hat= w_hat3w if w_hat==.

* combine w_hat_level(i)
gen w_hat_level= w_hat1_level
replace w_hat_level= w_hat2_level if w_hat_level==.
replace w_hat_level= w_hat3_level if w_hat_level==.
replace w_hat_level= w_hat1w_level if w_hat_level==.
replace w_hat_level= w_hat2w_level if w_hat_level==.
replace w_hat_level= w_hat3w_level if w_hat_level==.
label variable w_hat_level "Imputed wage, based on median education level"

* drop intermediate variables
drop w_hat1 w_hat1w w_hat2 w_hat2w w_hat3 w_hat3w w_hat2_level w_hat3_level w_hat1w_level w_hat2w_level w_hat3w_level

// save
save `France_job_episode', replace

// keep only parents 
drop if parent_sample==2
keep  mergeid father_id mother_id gender yrbirth age2 age year country situation educ_3level years_of_educ years_of_educ_key isced97_educ isced97_educ_key working unemployed in_education retired mainjob ordjob industry job_title working_hours country_res_ nchildren_nat nchildren withpartner partner_married married child_coupleid child_country parent_status foreign_live migration_year parent_sample w_hat median_1 w_hat_level

   // label variables
label variable parent_status "Identification for parent sample"
label variable parent_status "Identification for mergeid belongs to father/mother"
label variable parent_sample "Identification for parent sample"
label variable w_hat "Imputed log wage, based on median education level"

// define spouse id
gen spouse_id=father_id
replace spouse_id=mother_id if spouse_id==""
label variable spouse_id "Spouse's mergeid"

drop father_id mother_id

// save
save  `France_parents_job_2', replace
restore 

/*==============================================================================
                            6: GREECE
==============================================================================*/

preserve
keep if	country_res==300

*define cpi adjusted net annual wage & log versions
gen euro_wage=wage if currency_new==1
replace euro_wage=wage*(1/ATS) if currency_new==2
replace euro_wage=wage*(1/BEF) if currency_new==5
replace euro_wage=wage*(1/CHF) if currency_new==14
replace euro_wage=wage*(1/CZK) if currency_new==16
replace euro_wage=wage*(1/DEM) if currency_new==18
replace euro_wage=wage*(1/DKK) if currency_new==19
replace euro_wage=wage*(1/ESP) if currency_new==21
replace euro_wage=wage*(1/FRF) if currency_new==23
replace euro_wage=wage*(1/GBP) if currency_new==24
replace euro_wage=wage*(1/IEP) if currency_new==26
replace euro_wage=wage*(1/ITL) if currency_new==28
replace euro_wage=wage*(1/LUF) if currency_new==29
replace euro_wage=wage*(1/NLG) if currency_new==31
replace euro_wage=wage*(1/PLN) if currency_new==32
replace euro_wage=wage*(1/PTE) if currency_new==34
replace euro_wage=wage*(1/RUB) if currency_new==35
replace euro_wage=wage*(1/USD) if currency_new==41
replace euro_wage=wage*(1/HRK) if currency_new==109
replace euro_wage=wage*(1/HUF) if currency_new==111
replace euro_wage=wage*(1/NOK) if currency_new==164
replace euro_wage=wage*(1/SEK) if currency_new==186
replace euro_wage=wage*(1/GBP) if currency_new==265
replace euro_wage=wage*(1/ATS) if currency_new==266
replace euro_wage=wage*(1/DEM) if currency_new==267
replace euro_wage=wage*(1/NLG) if currency_new==269
replace euro_wage=wage*(1/ESP) if currency_new==273
replace euro_wage=wage*(1/USD) if currency_new==277
replace euro_wage=wage*(1/PTE) if currency_new==281

gen nat_wage=wage if currency_new==25
replace nat_wage=euro_wage*GRD if nat_wage==.
gen cpi_wage=(nat_wage/cpi)*100
gen log_cpi_wage = ln(cpi_wage) 

*define partnership status, age2, 3 levels education codes
replace gender=0 if gender==2
label define gender 2 "", modify
label define gender 0 "Female", add

gen partner_married=1 if withpartner==1 | married==1
replace partner_married=0 if withpartner==0 & married==0
gen age2= age^2
gen educ_3level=1 if isced97_educ==0 | isced97_educ==1 | isced97_educ==2
replace educ_3level=2 if isced97_educ==3 | isced97_educ==4 
replace educ_3level=3 if isced97_educ==5 | isced97_educ==6
replace educ_3level=. if isced97_educ==.
replace educ_3level=-1 if isced97_educ_key==1 | isced97_educ==95 | isced97_educ==97 | isced97_educ==-1 | isced97_educ==-2

  // label variables
label variable partner_married "Married or have cohabited partner"
label variable log_cpi_wage "Log of annual net wage, cpi adjusted"
label variable nat_wage "Annual net wage,national currrency"
label variable cpi_wage "Annual net wage, national currency, cpi adjusted"
label variable log_cpi_wage "Log of annual net wage,national currency, cpi adjusted"
label variable age2 "age^2"
label variable educ_3level "Education level in 3 categories, low-medium-high"
label variable country_educ "country for educ document"

  // further checks
/*
tab x
tab x if year>1955
tab educ_3level if year>1955
tab age if year>1955
tab x if log_cpi_wage!=. & year>1955
tab gender if year>1955
tab isced97_educ if year>1955
tab years_of_educ if year>1955
*/

// flag implausible observations
replace years_of_educ=-3 if years_of_educ==1964

  // order variables
order log_cpi_wage, before(wage)
order nat_wage, before(wage)
order cpi_wage, before(wage)
order educ_3level, before(years_of_educ)
order age2, before(age)
order partner_married, before(married)

*restrict the sample age
. drop if age<16
. drop if age>66

*drop obs recorded as part-time
drop if working_hours==2

*drop obs where cpi value does not accessible
drop if year<1955

*drop obs where currency is not converted to national currency unit (exchange rate is not available in corresponding year)
drop if log_cpi_wage==.

*drop obs where education info is missing, or recorded as don't know or refusal
drop if years_of_educ==. & isced97_educ==.
drop if years_of_educ==-1 & isced97_educ==-1
drop if years_of_educ==-2 & isced97_educ==-2

*drop outliers
*sum cpi_wage, d 
drop if cpi_wage>9579171

*append with parents job episode
append using `Greece_parents_job'

replace parent_sample=2 if parent_sample==.
replace median_1=median1 if parent_sample==1
replace isced97_educ_key=isced97_key if parent_sample==1

*apply model to create w_hat
reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==1 & parent_sample==2, robust  
scalar  RMSE1= e(rmse)
predict w_hat1 if educ_3level==1 & gender==1
gen w_hat1_level= exp(w_hat1)* exp(RMSE1^2/2) if educ_3level==1 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==0 & parent_sample==2, robust 
scalar  RMSE1w= e(rmse)
predict w_hat1w if educ_3level==1 & gender==0
gen w_hat1w_level= exp(w_hat1w)* exp(RMSE1w^2/2) if educ_3level==1 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==1 & parent_sample==2, robust  
scalar  RMSE2= e(rmse)
predict w_hat2 if educ_3level==2 & gender==1
gen w_hat2_level= exp(w_hat2)* exp(RMSE2^2/2) if educ_3level==2 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==0 & parent_sample==2, robust  
scalar  RMSE2w= e(rmse)
predict w_hat2w if educ_3level==2 & gender==0
gen w_hat2w_level= exp(w_hat2w)* exp(RMSE2w^2/2) if educ_3level==2 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==1 & parent_sample==2, robust  
scalar  RMSE3= e(rmse)
predict w_hat3 if educ_3level==3 & gender==1
gen w_hat3_level= exp(w_hat3)* exp(RMSE3^2/2) if educ_3level==3 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==0 & parent_sample==2, robust  
scalar  RMSE3w= e(rmse)
predict w_hat3w if educ_3level==3 & gender==0
gen w_hat3w_level= exp(w_hat3w)* exp(RMSE3w^2/2) if educ_3level==3 & gender==0

* combine w_hat(i)
gen w_hat= w_hat1
replace w_hat= w_hat2 if w_hat==.
replace w_hat= w_hat3 if w_hat==.
replace w_hat= w_hat1w if w_hat==.
replace w_hat= w_hat2w if w_hat==.
replace w_hat= w_hat3w if w_hat==.

* combine w_hat_level(i)
gen w_hat_level= w_hat1_level
replace w_hat_level= w_hat2_level if w_hat_level==.
replace w_hat_level= w_hat3_level if w_hat_level==.
replace w_hat_level= w_hat1w_level if w_hat_level==.
replace w_hat_level= w_hat2w_level if w_hat_level==.
replace w_hat_level= w_hat3w_level if w_hat_level==.
label variable w_hat_level "Imputed wage, based on median education level"

* drop intermediate variables
drop w_hat1 w_hat1w w_hat2 w_hat2w w_hat3 w_hat3w w_hat2_level w_hat3_level w_hat1w_level w_hat2w_level w_hat3w_level

// save
save `Greece_job_episode', replace

// keep only parents
drop if parent_sample==2
keep  mergeid father_id mother_id gender yrbirth age2 age year country situation educ_3level years_of_educ years_of_educ_key isced97_educ isced97_educ_key working unemployed in_education retired mainjob ordjob industry job_title working_hours country_res_ nchildren_nat nchildren withpartner partner_married married child_coupleid child_country parent_status foreign_live migration_year parent_sample w_hat median_1 w_hat_level

  // label variables
label variable parent_status "Identification for parent sample"
label variable parent_status "Identification for mergeid belongs to father/mother"
label variable parent_sample "Identification for parent sample"
label variable w_hat "Imputed log wage, based on median education level"

// define spouse id
gen spouse_id=father_id
replace spouse_id=mother_id if spouse_id==""
label variable spouse_id "Spouse's mergeid"

drop father_id mother_id
 
// save
save `Greece_parents_job_2', replace
restore 

/*==============================================================================
                            7: IRELAND
==============================================================================*/

preserve
keep if	country_res==372

*define cpi adjusted net annual wage & log versions
gen euro_wage=wage if currency_new==1
replace euro_wage=wage*(1/ATS) if currency_new==2
replace euro_wage=wage*(1/BEF) if currency_new==5
replace euro_wage=wage*(1/CHF) if currency_new==14
replace euro_wage=wage*(1/CZK) if currency_new==16
replace euro_wage=wage*(1/DEM) if currency_new==18
replace euro_wage=wage*(1/DKK) if currency_new==19
replace euro_wage=wage*(1/ESP) if currency_new==21
replace euro_wage=wage*(1/FRF) if currency_new==23
replace euro_wage=wage*(1/GBP) if currency_new==24
replace euro_wage=wage*(1/ITL) if currency_new==28
replace euro_wage=wage*(1/LUF) if currency_new==29
replace euro_wage=wage*(1/NLG) if currency_new==31
replace euro_wage=wage*(1/PLN) if currency_new==32
replace euro_wage=wage*(1/PTE) if currency_new==34
replace euro_wage=wage*(1/RUB) if currency_new==35
replace euro_wage=wage*(1/USD) if currency_new==41
replace euro_wage=wage*(1/HRK) if currency_new==109
replace euro_wage=wage*(1/HUF) if currency_new==111
replace euro_wage=wage*(1/NOK) if currency_new==164
replace euro_wage=wage*(1/SEK) if currency_new==186
replace euro_wage=wage*(1/ATS) if currency_new==266
replace euro_wage=wage*(1/DEM) if currency_new==267
replace euro_wage=wage*(1/NLG) if currency_new==269
replace euro_wage=wage*(1/ESP) if currency_new==273
replace euro_wage=wage*(1/USD) if currency_new==277
replace euro_wage=wage*(1/PTE) if currency_new==281

gen nat_wage=wage if currency_new==26
replace nat_wage=wage if currency_new==265 & nat_wage==.
replace nat_wage=euro_wage*IEP if nat_wage==.
gen cpi_wage=(nat_wage/cpi)*100
gen log_cpi_wage = ln(cpi_wage) 

*define partnership status, age2, 3 levels education codes
replace gender=0 if gender==2
label define gender 2 "", modify
label define gender 0 "Female", add

gen partner_married=1 if withpartner==1 | married==1
replace partner_married=0 if withpartner==0 & married==0
gen age2= age^2
gen educ_3level=1 if isced97_educ==0 | isced97_educ==1 | isced97_educ==2
replace educ_3level=2 if isced97_educ==3 | isced97_educ==4 
replace educ_3level=3 if isced97_educ==5 | isced97_educ==6
replace educ_3level=. if isced97_educ==.
replace educ_3level=-1 if isced97_educ_key==1 | isced97_educ==95 | isced97_educ==97 | isced97_educ==-1 | isced97_educ==-2

  // label variables
label variable partner_married "Married or have cohabited partner"
label variable log_cpi_wage "Log of annual net wage, cpi adjusted"
label variable nat_wage "Annual net wage,national currrency"
label variable cpi_wage "Annual net wage, national currency, cpi adjusted"
label variable log_cpi_wage "Log of annual net wage,national currency, cpi adjusted"
label variable age2 "age^2"
label variable educ_3level "Education level in 3 categories, low-medium-high"
label variable country_educ "country for educ document"

  // further checks
/*
tab x
tab x if year>1955
tab educ_3level if year>1955
tab age if year>1955
tab x if log_cpi_wage!=. & year>1955
tab gender if year>1955
tab isced97_educ if year>1955
tab years_of_educ if year>1955
*/

  // order variables
order log_cpi_wage, before(wage)
order nat_wage, before(wage)
order cpi_wage, before(wage)
order educ_3level, before(years_of_educ)
order age2, before(age)
order partner_married, before(married)

*restrict the sample age
drop if age<16
drop if age>66

*drop obs recorded as part-time
drop if working_hours==2

*drop obs where cpi value does not accessible
drop if year<1960

*drop obs where currency is not converted to national currency unit (exchange rate is not available in corresponding year)
drop if log_cpi_wage==.

*drop obs where education info is missing, or recorded as don't know or refusal
drop if years_of_educ==. & isced97_educ==.
drop if years_of_educ==-1 & isced97_educ==-1
drop if years_of_educ==-2 & isced97_educ==-2

*drop outliers
*sum cpi_wage, d
drop if cpi_wage>48192

*append with parents job episode
append using `Ireland_parents_job'

replace parent_sample=2 if parent_sample==.
replace median_1=median1 if parent_sample==1
replace isced97_educ_key=isced97_key if parent_sample==1

*apply model to create w_hat
reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==1 & parent_sample==2, robust  
scalar  RMSE1= e(rmse)
predict w_hat1 if educ_3level==1 & gender==1
gen w_hat1_level= exp(w_hat1)* exp(RMSE1^2/2) if educ_3level==1 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==0 & parent_sample==2, robust 
scalar  RMSE1w= e(rmse)
predict w_hat1w if educ_3level==1 & gender==0
gen w_hat1w_level= exp(w_hat1w)* exp(RMSE1w^2/2) if educ_3level==1 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==1 & parent_sample==2, robust  
scalar  RMSE2= e(rmse)
predict w_hat2 if educ_3level==2 & gender==1
gen w_hat2_level= exp(w_hat2)* exp(RMSE2^2/2) if educ_3level==2 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==0 & parent_sample==2, robust  
scalar  RMSE2w= e(rmse)
predict w_hat2w if educ_3level==2 & gender==0
gen w_hat2w_level= exp(w_hat2w)* exp(RMSE2w^2/2) if educ_3level==2 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==1 & parent_sample==2, robust  
scalar  RMSE3= e(rmse)
predict w_hat3 if educ_3level==3 & gender==1
gen w_hat3_level= exp(w_hat3)* exp(RMSE3^2/2) if educ_3level==3 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==0 & parent_sample==2, robust  
scalar  RMSE3w= e(rmse)
predict w_hat3w if educ_3level==3 & gender==0
gen w_hat3w_level= exp(w_hat3w)* exp(RMSE3w^2/2) if educ_3level==3 & gender==0

* combine w_hat(i)
gen w_hat= w_hat1
replace w_hat= w_hat2 if w_hat==.
replace w_hat= w_hat3 if w_hat==.
replace w_hat= w_hat1w if w_hat==.
replace w_hat= w_hat2w if w_hat==.
replace w_hat= w_hat3w if w_hat==.

* combine w_hat_level(i)
gen w_hat_level= w_hat1_level
replace w_hat_level= w_hat2_level if w_hat_level==.
replace w_hat_level= w_hat3_level if w_hat_level==.
replace w_hat_level= w_hat1w_level if w_hat_level==.
replace w_hat_level= w_hat2w_level if w_hat_level==.
replace w_hat_level= w_hat3w_level if w_hat_level==.
label variable w_hat_level "Imputed wage, based on median education level"

* drop intermediate variables
drop w_hat1 w_hat1w w_hat2 w_hat2w w_hat3 w_hat3w w_hat2_level w_hat3_level w_hat1w_level w_hat2w_level w_hat3w_level

// save
save `Ireland_job_episode', replace

// keep only parents
drop if parent_sample==2

// keep necessary variables
keep  mergeid father_id mother_id gender yrbirth age2 age year country situation educ_3level years_of_educ years_of_educ_key isced97_educ isced97_educ_key working unemployed in_education retired mainjob ordjob industry job_title working_hours country_res_ nchildren_nat nchildren withpartner partner_married married child_coupleid child_country parent_status foreign_live migration_year parent_sample w_hat median_1 w_hat_level

  // label variables
label variable parent_status "Identification for parent sample"
label variable parent_status "Identification for mergeid belongs to father/mother"
label variable parent_sample "Identification for parent sample"
label variable w_hat "Imputed log wage, based on median education level"

// define spouse id
gen spouse_id=father_id
replace spouse_id=mother_id if spouse_id==""
label variable spouse_id "Spouse's mergeid"

drop father_id mother_id

//save
save  `Ireland_parents_job_2', replace
restore 

/*==============================================================================
                            8: ITALY
==============================================================================*/
preserve
keep if	country_res==380

*define cpi adjusted net annual wage & log versions
gen euro_wage=wage if currency_new==1
replace euro_wage=wage*(1/ATS) if currency_new==2
replace euro_wage=wage*(1/BEF) if currency_new==5
replace euro_wage=wage*(1/CHF) if currency_new==14
replace euro_wage=wage*(1/CZK) if currency_new==16
replace euro_wage=wage*(1/DEM) if currency_new==18
replace euro_wage=wage*(1/DKK) if currency_new==19
replace euro_wage=wage*(1/ESP) if currency_new==21
replace euro_wage=wage*(1/FRF) if currency_new==23
replace euro_wage=wage*(1/GBP) if currency_new==24
replace euro_wage=wage*(1/GRD) if currency_new==25
replace euro_wage=wage*(1/IEP) if currency_new==26
replace euro_wage=wage*(1/ITL) if currency_new==28
replace euro_wage=wage*(1/LUF) if currency_new==29
replace euro_wage=wage*(1/PLN) if currency_new==32
replace euro_wage=wage*(1/PTE) if currency_new==34
replace euro_wage=wage*(1/RUB) if currency_new==35
replace euro_wage=wage*(1/USD) if currency_new==41
replace euro_wage=wage*(1/HRK) if currency_new==109
replace euro_wage=wage*(1/HUF) if currency_new==111
replace euro_wage=wage*(1/NOK) if currency_new==164
replace euro_wage=wage*(1/SEK) if currency_new==186
replace euro_wage=wage*(1/RON) if currency_new==177
replace euro_wage=wage*(1/GBP) if currency_new==265
replace euro_wage=wage*(1/ATS) if currency_new==266
replace euro_wage=wage*(1/DEM) if currency_new==267
replace euro_wage=wage*(1/NLG) if currency_new==269
replace euro_wage=wage*(1/USD) if currency_new==277
replace euro_wage=wage*(1/PTE) if currency_new==281

gen nat_wage=wage if currency_new==28
replace nat_wage=wage if currency_new==274 & nat_wage==.
replace nat_wage=wage if currency_new==286 & nat_wage==.
replace nat_wage=euro_wage*ITL if nat_wage==.
gen cpi_wage=(nat_wage/cpi)*100
gen log_cpi_wage = ln(cpi_wage) 

*define partnership status, age2, 3 levels education codes
replace gender=0 if gender==2
label define gender 2 "", modify
label define gender 0 "Female", add

gen partner_married=1 if withpartner==1 | married==1
replace partner_married=0 if withpartner==0 & married==0
gen age2= age^2
gen educ_3level=1 if isced97_educ==0 | isced97_educ==1 | isced97_educ==2
replace educ_3level=2 if isced97_educ==3 | isced97_educ==4 
replace educ_3level=3 if isced97_educ==5 | isced97_educ==6
replace educ_3level=. if isced97_educ==.
replace educ_3level=-1 if isced97_educ_key==1 | isced97_educ==95 | isced97_educ==97 | isced97_educ==-1 | isced97_educ==-2

  // label variables
label variable partner_married "Married or have cohabited partner"
label variable log_cpi_wage "Log of annual net wage, cpi adjusted"
label variable nat_wage "Annual net wage,national currrency"
label variable cpi_wage "Annual net wage, national currency, cpi adjusted"
label variable log_cpi_wage "Log of annual net wage,national currency, cpi adjusted"
label variable age2 "age^2"
label variable educ_3level "Education level in 3 categories, low-medium-high"
label variable country_educ "country for educ document"

  // further checks
/*
tab x
tab x if year>1954
tab educ_3level if year>1954
tab age if year>1954
tab x if log_cpi_wage!=. & year>1954
tab gender if year>1954
tab isced97_educ if year>1954
tab years_of_educ if year>1954
*/

  // order variables
order log_cpi_wage, before(wage)
order nat_wage, before(wage)
order cpi_wage, before(wage)
order educ_3level, before(years_of_educ)
order age2, before(age)
order partner_married, before(married)

*restrict the sample age
drop if age<16
drop if age>66

*drop obs recorded as part-time
drop if working_hours==2

*drop obs where cpi value does not accessible
drop if year<1955

*drop obs where currency is not converted to national currency unit (exchange rate is not available in corresponding year)
drop if log_cpi_wage==.

*drop obs where education info is missing, or recorded as don't know or refusal
drop if years_of_educ==. & isced97_educ==.
drop if years_of_educ==-1 & isced97_educ==-1
drop if years_of_educ==-2 & isced97_educ==-2

*drop outliers
*sum cpi_wage, d
drop if cpi_wage>12400000

*append with parents job episode
append using `Italy_parents_job'

replace parent_sample=2 if parent_sample==.
replace median_1=median1 if parent_sample==1
replace isced97_educ_key=isced97_key if parent_sample==1

*apply model to create w_hat
reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==1 & parent_sample==2, robust  
scalar  RMSE1= e(rmse)
predict w_hat1 if educ_3level==1 & gender==1
gen w_hat1_level= exp(w_hat1)* exp(RMSE1^2/2) if educ_3level==1 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==0 & parent_sample==2, robust 
scalar  RMSE1w= e(rmse)
predict w_hat1w if educ_3level==1 & gender==0
gen w_hat1w_level= exp(w_hat1w)* exp(RMSE1w^2/2) if educ_3level==1 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==1 & parent_sample==2, robust  
scalar  RMSE2= e(rmse)
predict w_hat2 if educ_3level==2 & gender==1
gen w_hat2_level= exp(w_hat2)* exp(RMSE2^2/2) if educ_3level==2 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==0 & parent_sample==2, robust  
scalar  RMSE2w= e(rmse)
predict w_hat2w if educ_3level==2 & gender==0
gen w_hat2w_level= exp(w_hat2w)* exp(RMSE2w^2/2) if educ_3level==2 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==1 & parent_sample==2, robust  
scalar  RMSE3= e(rmse)
predict w_hat3 if educ_3level==3 & gender==1
gen w_hat3_level= exp(w_hat3)* exp(RMSE3^2/2) if educ_3level==3 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==0 & parent_sample==2, robust  
scalar  RMSE3w= e(rmse)
predict w_hat3w if educ_3level==3 & gender==0
gen w_hat3w_level= exp(w_hat3w)* exp(RMSE3w^2/2) if educ_3level==3 & gender==0

* combine w_hat(i)
gen w_hat= w_hat1
replace w_hat= w_hat2 if w_hat==.
replace w_hat= w_hat3 if w_hat==.
replace w_hat= w_hat1w if w_hat==.
replace w_hat= w_hat2w if w_hat==.
replace w_hat= w_hat3w if w_hat==.

* combine w_hat_level(i)
gen w_hat_level= w_hat1_level
replace w_hat_level= w_hat2_level if w_hat_level==.
replace w_hat_level= w_hat3_level if w_hat_level==.
replace w_hat_level= w_hat1w_level if w_hat_level==.
replace w_hat_level= w_hat2w_level if w_hat_level==.
replace w_hat_level= w_hat3w_level if w_hat_level==.
label variable w_hat_level "Imputed wage, based on median education level"

* drop intermediate variables
drop w_hat1 w_hat1w w_hat2 w_hat2w w_hat3 w_hat3w w_hat2_level w_hat3_level w_hat1w_level w_hat2w_level w_hat3w_level

// save
save `Italy_job_episode', replace

// keep only parents
drop if parent_sample==2
keep  mergeid father_id mother_id gender yrbirth age2 age year country situation educ_3level years_of_educ years_of_educ_key isced97_educ isced97_educ_key working unemployed in_education retired mainjob ordjob industry job_title working_hours country_res_ nchildren_nat nchildren withpartner partner_married married child_coupleid child_country parent_status foreign_live migration_year parent_sample w_hat median_1 w_hat_level

   // label variables
label variable parent_status "Identification for parent sample"
label variable parent_status "Identification for mergeid belongs to father/mother"
label variable parent_sample "Identification for parent sample"
label variable w_hat "Imputed log wage, based on median education level"

// define spouse id
gen spouse_id=father_id
replace spouse_id=mother_id if spouse_id==""
label variable spouse_id "Spouse's mergeid"

drop father_id mother_id

// save
save  `Italy_parents_job_2', replace
restore 


/*==============================================================================
                            9: LUXEMBOURG
==============================================================================*/
preserve
keep if	country_res==442

*define cpi adjusted net annual wage & log versions
gen euro_wage=wage if currency_new==1
replace euro_wage=wage*(1/ATS) if currency_new==2
replace euro_wage=wage*(1/BEF) if currency_new==5
replace euro_wage=wage*(1/CHF) if currency_new==14
replace euro_wage=wage*(1/CZK) if currency_new==16
replace euro_wage=wage*(1/DEM) if currency_new==18
replace euro_wage=wage*(1/DKK) if currency_new==19
replace euro_wage=wage*(1/ESP) if currency_new==21
replace euro_wage=wage*(1/FRF) if currency_new==23
replace euro_wage=wage*(1/GBP) if currency_new==24
replace euro_wage=wage*(1/ITL) if currency_new==28
replace euro_wage=wage*(1/NLG) if currency_new==31
replace euro_wage=wage*(1/PLN) if currency_new==32
replace euro_wage=wage*(1/PTE) if currency_new==34
replace euro_wage=wage*(1/RUB) if currency_new==35
replace euro_wage=wage*(1/USD) if currency_new==41
replace euro_wage=wage*(1/HRK) if currency_new==109
replace euro_wage=wage*(1/HUF) if currency_new==111
replace euro_wage=wage*(1/NOK) if currency_new==164
replace euro_wage=wage*(1/SEK) if currency_new==186
replace euro_wage=wage*(1/ATS) if currency_new==266
replace euro_wage=wage*(1/DEM) if currency_new==267
replace euro_wage=wage*(1/NLG) if currency_new==269
replace euro_wage=wage*(1/ESP) if currency_new==273
replace euro_wage=wage*(1/USD) if currency_new==277
replace euro_wage=wage*(1/PTE) if currency_new==281

gen nat_wage=wage if currency_new==29
replace nat_wage=euro_wage*LUF if nat_wage==.
gen cpi_wage=(nat_wage/cpi)*100
gen log_cpi_wage = ln(cpi_wage) 


*define partnership status, age2, 3 levels education codes
replace gender=0 if gender==2
label define gender 2 "", modify
label define gender 0 "Female", add

gen partner_married=1 if withpartner==1 | married==1
replace partner_married=0 if withpartner==0 & married==0
gen age2= age^2
gen educ_3level=1 if isced97_educ==0 | isced97_educ==1 | isced97_educ==2
replace educ_3level=2 if isced97_educ==3 | isced97_educ==4 
replace educ_3level=3 if isced97_educ==5 | isced97_educ==6
replace educ_3level=. if isced97_educ==.
replace educ_3level=-1 if isced97_educ_key==1 | isced97_educ==95 | isced97_educ==97 | isced97_educ==-1 | isced97_educ==-2

  // label variables
label variable partner_married "Married or have cohabited partner"
label variable log_cpi_wage "Log of annual net wage, cpi adjusted"
label variable nat_wage "Annual net wage,national currrency"
label variable cpi_wage "Annual net wage, national currency, cpi adjusted"
label variable log_cpi_wage "Log of annual net wage,national currency, cpi adjusted"
label variable age2 "age^2"
label variable educ_3level "Education level in 3 categories, low-medium-high"
label variable country_educ "country for educ document"

  // further checks
/*
tab x
tab x if year>1955
tab educ_3level if year>1955
tab age if year>1955
tab x if log_cpi_wage!=. & year>1955
tab gender if year>1955
tab isced97_educ if year>1955
tab years_of_educ if year>1955
*/

// flag implausible observations
replace years_of_educ=-3 if years_of_educ==1981

  // order variables
order log_cpi_wage, before(wage)
order nat_wage, before(wage)
order cpi_wage, before(wage)
order educ_3level, before(years_of_educ)
order age2, before(age)
order partner_married, before(married)

*restrict the sample age
drop if age<16
drop if age>66

*drop obs recorded as part-time
drop if working_hours==2

*drop obs where cpi value does not accessible
drop if year<1955

*drop obs where currency is not converted to national currency unit (exchange rate is not available in corresponding year)
drop if log_cpi_wage==.

*drop obs where education info is missing, or recorded as don't know or refusal
drop if years_of_educ==. & isced97_educ==.
drop if years_of_educ==-1 & isced97_educ==-1
drop if years_of_educ==-2 & isced97_educ==-2

*drop outliers
*sum cpi_wage, d
drop if cpi_wage>633630.5

*append with parents job episode
append using `Luxembourg_parents_job'

replace parent_sample=2 if parent_sample==.
replace median_1=median1 if parent_sample==1
replace isced97_educ_key=isced97_key if parent_sample==1

*apply model to create w_hat
reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==1 & parent_sample==2, robust  
scalar  RMSE1= e(rmse)
predict w_hat1 if educ_3level==1 & gender==1
gen w_hat1_level= exp(w_hat1)* exp(RMSE1^2/2) if educ_3level==1 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==0 & parent_sample==2, robust 
scalar  RMSE1w= e(rmse)
predict w_hat1w if educ_3level==1 & gender==0
gen w_hat1w_level= exp(w_hat1w)* exp(RMSE1w^2/2) if educ_3level==1 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==1 & parent_sample==2, robust  
scalar  RMSE2= e(rmse)
predict w_hat2 if educ_3level==2 & gender==1
gen w_hat2_level= exp(w_hat2)* exp(RMSE2^2/2) if educ_3level==2 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==0 & parent_sample==2, robust  
scalar  RMSE2w= e(rmse)
predict w_hat2w if educ_3level==2 & gender==0
gen w_hat2w_level= exp(w_hat2w)* exp(RMSE2w^2/2) if educ_3level==2 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==1 & parent_sample==2, robust  
scalar  RMSE3= e(rmse)
predict w_hat3 if educ_3level==3 & gender==1
gen w_hat3_level= exp(w_hat3)* exp(RMSE3^2/2) if educ_3level==3 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==0 & parent_sample==2, robust  
scalar  RMSE3w= e(rmse)
predict w_hat3w if educ_3level==3 & gender==0
gen w_hat3w_level= exp(w_hat3w)* exp(RMSE3w^2/2) if educ_3level==3 & gender==0

* combine w_hat(i)
gen w_hat= w_hat1
replace w_hat= w_hat2 if w_hat==.
replace w_hat= w_hat3 if w_hat==.
replace w_hat= w_hat1w if w_hat==.
replace w_hat= w_hat2w if w_hat==.
replace w_hat= w_hat3w if w_hat==.

* combine w_hat_level(i)
gen w_hat_level= w_hat1_level
replace w_hat_level= w_hat2_level if w_hat_level==.
replace w_hat_level= w_hat3_level if w_hat_level==.
replace w_hat_level= w_hat1w_level if w_hat_level==.
replace w_hat_level= w_hat2w_level if w_hat_level==.
replace w_hat_level= w_hat3w_level if w_hat_level==.
label variable w_hat_level "Imputed wage, based on median education level"

* drop intermediate variables
drop w_hat1 w_hat1w w_hat2 w_hat2w w_hat3 w_hat3w w_hat2_level w_hat3_level w_hat1w_level w_hat2w_level w_hat3w_level

// save
save `Luxembourg_job_episode', replace

// keep only parents
drop if parent_sample==2

// keep necessary variables
keep  mergeid father_id mother_id gender yrbirth age2 age year country situation educ_3level years_of_educ years_of_educ_key isced97_educ isced97_educ_key working unemployed in_education retired mainjob ordjob industry job_title working_hours country_res_ nchildren_nat nchildren withpartner partner_married married child_coupleid child_country parent_status foreign_live migration_year parent_sample w_hat median_1 w_hat_level

// label variables
label variable parent_status "Identification for parent sample"
label variable parent_status "Identification for mergeid belongs to father/mother"
label variable parent_sample "Identification for parent sample"
label variable w_hat "Imputed log wage, based on median education level"

// define spouse id
gen spouse_id=father_id
replace spouse_id=mother_id if spouse_id==""
label variable spouse_id "Spouse's mergeid"

drop father_id mother_id

// save
save  `Luxembourg_parents_job_2', replace
restore 


/*==============================================================================
                           10: NETHERLANDS
==============================================================================*/

preserve
keep if	country_res==528

*define cpi adjusted net annual wage & log versions
gen euro_wage=wage if currency_new==1
replace euro_wage=wage*(1/ATS) if currency_new==2
replace euro_wage=wage*(1/BEF) if currency_new==5
replace euro_wage=wage*(1/CHF) if currency_new==14
replace euro_wage=wage*(1/CZK) if currency_new==16
replace euro_wage=wage*(1/DEM) if currency_new==18
replace euro_wage=wage*(1/DKK) if currency_new==19
replace euro_wage=wage*(1/ESP) if currency_new==21
replace euro_wage=wage*(1/FRF) if currency_new==23
replace euro_wage=wage*(1/GBP) if currency_new==24
replace euro_wage=wage*(1/ITL) if currency_new==28
replace euro_wage=wage*(1/PLN) if currency_new==32
replace euro_wage=wage*(1/PTE) if currency_new==34
replace euro_wage=wage*(1/RUB) if currency_new==35
replace euro_wage=wage*(1/USD) if currency_new==41
replace euro_wage=wage*(1/HRK) if currency_new==109
replace euro_wage=wage*(1/HUF) if currency_new==111
replace euro_wage=wage*(1/NOK) if currency_new==164
replace euro_wage=wage*(1/SEK) if currency_new==186
replace euro_wage=wage*(1/ATS) if currency_new==266
replace euro_wage=wage*(1/DEM) if currency_new==267
replace euro_wage=wage*(1/ESP) if currency_new==273
replace euro_wage=wage*(1/USD) if currency_new==277
replace euro_wage=wage*(1/PTE) if currency_new==281

gen nat_wage=wage if currency_new==31
replace nat_wage=wage if currency_new==269
replace nat_wage=euro_wage*NLG if nat_wage==.
gen cpi_wage=(nat_wage/cpi)*100
gen log_cpi_wage = ln(cpi_wage) 

*define partnership status, age2, 3 levels education codes
replace gender=0 if gender==2
label define gender 2 "", modify
label define gender 0 "Female", add

gen partner_married=1 if withpartner==1 | married==1
replace partner_married=0 if withpartner==0 & married==0
gen age2= age^2
gen educ_3level=1 if isced97_educ==0 | isced97_educ==1 | isced97_educ==2
replace educ_3level=2 if isced97_educ==3 | isced97_educ==4 
replace educ_3level=3 if isced97_educ==5 | isced97_educ==6
replace educ_3level=. if isced97_educ==.
replace educ_3level=-1 if isced97_educ_key==1 | isced97_educ==95 | isced97_educ==97 | isced97_educ==-1 | isced97_educ==-2

  // label variables
label variable partner_married "Married or have cohabited partner"
label variable log_cpi_wage "Log of annual net wage, cpi adjusted"
label variable nat_wage "Annual net wage,national currrency"
label variable cpi_wage "Annual net wage, national currency, cpi adjusted"
label variable log_cpi_wage "Log of annual net wage,national currency, cpi adjusted"
label variable age2 "age^2"
label variable educ_3level "Education level in 3 categories, low-medium-high"
label variable country_educ "country for educ document"

  // further checks
/*
tab x
tab x if year>1960
tab educ_3level if year>1960
tab age if year>1960
tab x if log_cpi_wage!=. & year>1960
tab gender if year>1960
tab isced97_educ if year>1960
tab years_of_educ if year>1960
*/

  // order variables
order log_cpi_wage, before(wage)
order nat_wage, before(wage)
order cpi_wage, before(wage)
order educ_3level, before(years_of_educ)
order age2, before(age)
order partner_married, before(married)

*restrict the sample age
drop if age<16
drop if age>66

*drop obs recorded as part-time
drop if working_hours==2

*drop obs where cpi value does not accessible
drop if year<1960

*drop obs where currency is not converted to national currency unit (exchange rate is not available in corresponding year)
drop if log_cpi_wage==.

*drop obs where education info is missing, or recorded as don't know or refusal
drop if years_of_educ==. & isced97_educ==.
drop if years_of_educ==-1 & isced97_educ==-1
drop if years_of_educ==-2 & isced97_educ==-2

*drop outliers
sum cpi_wage, d
drop if cpi_wage>18582

*append with parents job episode
append using `Netherlands_parents_job'

replace parent_sample=2 if parent_sample==.
replace median_1=median1 if parent_sample==1
replace isced97_educ_key=isced97_key if parent_sample==1

*apply model to create w_hat
reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==1 & parent_sample==2, robust  
scalar  RMSE1= e(rmse)
predict w_hat1 if educ_3level==1 & gender==1
gen w_hat1_level= exp(w_hat1)* exp(RMSE1^2/2) if educ_3level==1 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==0 & parent_sample==2, robust 
scalar  RMSE1w= e(rmse)
predict w_hat1w if educ_3level==1 & gender==0
gen w_hat1w_level= exp(w_hat1w)* exp(RMSE1w^2/2) if educ_3level==1 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==1 & parent_sample==2, robust  
scalar  RMSE2= e(rmse)
predict w_hat2 if educ_3level==2 & gender==1
gen w_hat2_level= exp(w_hat2)* exp(RMSE2^2/2) if educ_3level==2 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==0 & parent_sample==2, robust  
scalar  RMSE2w= e(rmse)
predict w_hat2w if educ_3level==2 & gender==0
gen w_hat2w_level= exp(w_hat2w)* exp(RMSE2w^2/2) if educ_3level==2 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==1 & parent_sample==2, robust  
scalar  RMSE3= e(rmse)
predict w_hat3 if educ_3level==3 & gender==1
gen w_hat3_level= exp(w_hat3)* exp(RMSE3^2/2) if educ_3level==3 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==0 & parent_sample==2, robust  
scalar  RMSE3w= e(rmse)
predict w_hat3w if educ_3level==3 & gender==0
gen w_hat3w_level= exp(w_hat3w)* exp(RMSE3w^2/2) if educ_3level==3 & gender==0

* combine w_hat(i)
gen w_hat= w_hat1
replace w_hat= w_hat2 if w_hat==.
replace w_hat= w_hat3 if w_hat==.
replace w_hat= w_hat1w if w_hat==.
replace w_hat= w_hat2w if w_hat==.
replace w_hat= w_hat3w if w_hat==.

* combine w_hat_level(i)
gen w_hat_level= w_hat1_level
replace w_hat_level= w_hat2_level if w_hat_level==.
replace w_hat_level= w_hat3_level if w_hat_level==.
replace w_hat_level= w_hat1w_level if w_hat_level==.
replace w_hat_level= w_hat2w_level if w_hat_level==.
replace w_hat_level= w_hat3w_level if w_hat_level==.
label variable w_hat_level "Imputed wage, based on median education level"

* drop intermediate variables
drop w_hat1 w_hat1w w_hat2 w_hat2w w_hat3 w_hat3w w_hat2_level w_hat3_level w_hat1w_level w_hat2w_level w_hat3w_level

// save 
save `Netherlands_job_episode', replace

// keep only parents
drop if parent_sample==2

// keep necessary observations
keep  mergeid father_id mother_id gender yrbirth age2 age year country situation educ_3level years_of_educ years_of_educ_key isced97_educ isced97_educ_key working unemployed in_education retired mainjob ordjob industry job_title working_hours country_res_ nchildren_nat nchildren withpartner partner_married married child_coupleid child_country parent_status foreign_live migration_year parent_sample w_hat median_1 w_hat_level

  // label variables
label variable parent_status "Identification for parent sample"
label variable parent_status "Identification for mergeid belongs to father/mother"
label variable parent_sample "Identification for parent sample"
label variable w_hat "Imputed log wage, based on median education level"

// define spouse id
gen spouse_id=father_id
replace spouse_id=mother_id if spouse_id==""
label variable spouse_id "Spouse's mergeid"

drop father_id mother_id

// save
save  `Netherlands_parents_job_2', replace
restore 

/*==============================================================================
                           11: PORTUGAL
==============================================================================*/

preserve
keep if	country_res==620

*define cpi adjusted net annual wage & log versions
gen euro_wage=wage if currency_new==1
replace euro_wage=wage*(1/ATS) if currency_new==2
replace euro_wage=wage*(1/BEF) if currency_new==5
replace euro_wage=wage*(1/CHF) if currency_new==14
replace euro_wage=wage*(1/CZK) if currency_new==16
replace euro_wage=wage*(1/DEM) if currency_new==18
replace euro_wage=wage*(1/DKK) if currency_new==19
replace euro_wage=wage*(1/ESP) if currency_new==21
replace euro_wage=wage*(1/FRF) if currency_new==23
replace euro_wage=wage*(1/GBP) if currency_new==24
replace euro_wage=wage*(1/GRD) if currency_new==25
replace euro_wage=wage*(1/IEP) if currency_new==26
replace euro_wage=wage*(1/ITL) if currency_new==28
replace euro_wage=wage*(1/LUF) if currency_new==29
replace euro_wage=wage*(1/PLN) if currency_new==32
replace euro_wage=wage*(1/RUB) if currency_new==35
replace euro_wage=wage*(1/USD) if currency_new==41
replace euro_wage=wage*(1/HRK) if currency_new==109
replace euro_wage=wage*(1/HUF) if currency_new==111
replace euro_wage=wage*(1/NOK) if currency_new==164
replace euro_wage=wage*(1/SEK) if currency_new==186
replace euro_wage=wage*(1/RON) if currency_new==177
replace euro_wage=wage*(1/GBP) if currency_new==265
replace euro_wage=wage*(1/ATS) if currency_new==266
replace euro_wage=wage*(1/DEM) if currency_new==267
replace euro_wage=wage*(1/NLG) if currency_new==269
replace euro_wage=wage*(1/USD) if currency_new==277

gen nat_wage=wage if currency_new==34
replace nat_wage=wage if currency_new==281 & nat_wage==.
replace nat_wage=euro_wage*PTE if nat_wage==.
gen cpi_wage=(nat_wage/cpi)*100
gen log_cpi_wage = ln(cpi_wage) 

*define partnership status, age2, 3 levels education codes
replace gender=0 if gender==2
label define gender 2 "", modify
label define gender 0 "Female", add

gen partner_married=1 if withpartner==1 | married==1
replace partner_married=0 if withpartner==0 & married==0
gen age2= age^2
gen educ_3level=1 if isced97_educ==0 | isced97_educ==1 | isced97_educ==2
replace educ_3level=2 if isced97_educ==3 | isced97_educ==4 
replace educ_3level=3 if isced97_educ==5 | isced97_educ==6
replace educ_3level=. if isced97_educ==.
replace educ_3level=-1 if isced97_educ_key==1 | isced97_educ==95 | isced97_educ==97 | isced97_educ==-1 | isced97_educ==-2

   // label variables
label variable partner_married "Married or have cohabited partner"
label variable log_cpi_wage "Log of annual net wage, cpi adjusted"
label variable nat_wage "Annual net wage,national currrency"
label variable cpi_wage "Annual net wage, national currency, cpi adjusted"
label variable log_cpi_wage "Log of annual net wage,national currency, cpi adjusted"
label variable age2 "age^2"
label variable educ_3level "Education level in 3 categories, low-medium-high"
label variable country_educ "country for educ document"

  // further checks
/*
tab x
tab x if year>1954
tab educ_3level if year>1954
tab age if year>1954
tab x if log_cpi_wage!=. & year>1954
tab gender if year>1954
tab isced97_educ if year>1954
tab years_of_educ if year>1954
*/

  // order variables
order log_cpi_wage, before(wage)
order nat_wage, before(wage)
order cpi_wage, before(wage)
order educ_3level, before(years_of_educ)
order age2, before(age)
order partner_married, before(married)

*restrict the sample age
drop if age<16
drop if age>66

*drop obs recorded as part-time
drop if working_hours==2

*drop obs where cpi value does not accessible
drop if year<1955

*drop obs where currency is not converted to national currency unit (exchange rate is not available in corresponding year)
drop if log_cpi_wage==.

*drop obs where education info is missing, or recorded as don't know or refusal
drop if years_of_educ==. & isced97_educ==.
drop if years_of_educ==-1 & isced97_educ==-1
drop if years_of_educ==-2 & isced97_educ==-2

*drop outliers
sum cpi_wage, d
drop if cpi_wage>2010857

*append with parents job episode
append using `Portugal_parents_job'

replace parent_sample=2 if parent_sample==.
replace median_1=median1 if parent_sample==1
replace isced97_educ_key=isced97_key if parent_sample==1

*apply model to create w_hat
reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==1 & parent_sample==2, robust  
scalar  RMSE1= e(rmse)
predict w_hat1 if educ_3level==1 & gender==1
gen w_hat1_level= exp(w_hat1)* exp(RMSE1^2/2) if educ_3level==1 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==0 & parent_sample==2, robust 
scalar  RMSE1w= e(rmse)
predict w_hat1w if educ_3level==1 & gender==0
gen w_hat1w_level= exp(w_hat1w)* exp(RMSE1w^2/2) if educ_3level==1 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==1 & parent_sample==2, robust  
scalar  RMSE2= e(rmse)
predict w_hat2 if educ_3level==2 & gender==1
gen w_hat2_level= exp(w_hat2)* exp(RMSE2^2/2) if educ_3level==2 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==0 & parent_sample==2, robust  
scalar  RMSE2w= e(rmse)
predict w_hat2w if educ_3level==2 & gender==0
gen w_hat2w_level= exp(w_hat2w)* exp(RMSE2w^2/2) if educ_3level==2 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==1 & parent_sample==2, robust  
scalar  RMSE3= e(rmse)
predict w_hat3 if educ_3level==3 & gender==1
gen w_hat3_level= exp(w_hat3)* exp(RMSE3^2/2) if educ_3level==3 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==0 & parent_sample==2, robust  
scalar  RMSE3w= e(rmse)
predict w_hat3w if educ_3level==3 & gender==0
gen w_hat3w_level= exp(w_hat3w)* exp(RMSE3w^2/2) if educ_3level==3 & gender==0

* combine w_hat(i)
gen w_hat= w_hat1
replace w_hat= w_hat2 if w_hat==.
replace w_hat= w_hat3 if w_hat==.
replace w_hat= w_hat1w if w_hat==.
replace w_hat= w_hat2w if w_hat==.
replace w_hat= w_hat3w if w_hat==.

* combine w_hat_level(i)
gen w_hat_level= w_hat1_level
replace w_hat_level= w_hat2_level if w_hat_level==.
replace w_hat_level= w_hat3_level if w_hat_level==.
replace w_hat_level= w_hat1w_level if w_hat_level==.
replace w_hat_level= w_hat2w_level if w_hat_level==.
replace w_hat_level= w_hat3w_level if w_hat_level==.
label variable w_hat_level "Imputed wage, based on median education level"

* drop intermediate variables
drop w_hat1 w_hat1w w_hat2 w_hat2w w_hat3 w_hat3w w_hat2_level w_hat3_level w_hat1w_level w_hat2w_level w_hat3w_level

// save
save  `Portugal_job_episode', replace

// keep only parents
drop if parent_sample==2

// keep necessary variables
keep  mergeid father_id mother_id gender yrbirth age2 age year country situation educ_3level years_of_educ years_of_educ_key isced97_educ isced97_educ_key working unemployed in_education retired mainjob ordjob industry job_title working_hours country_res_ nchildren_nat nchildren withpartner partner_married married child_coupleid child_country parent_status foreign_live migration_year parent_sample w_hat median_1 w_hat_level

  // label variables
label variable parent_status "Identification for parent sample"
label variable parent_status "Identification for mergeid belongs to father/mother"
label variable parent_sample "Identification for parent sample"
label variable w_hat "Imputed log wage, based on median education level"

// define spouse id
gen spouse_id=father_id
replace spouse_id=mother_id if spouse_id==""
label variable spouse_id "Spouse's mergeid"

drop father_id mother_id

// save
save  `Portugal_parents_job_2', replace
restore 


/*==============================================================================
                           12: SPAIN
==============================================================================*/

preserve
keep if	country_res==724

*define cpi adjusted net annual wage & log versions
gen euro_wage=wage if currency_new==1
replace euro_wage=wage*(1/ATS) if currency_new==2
replace euro_wage=wage*(1/BEF) if currency_new==5
replace euro_wage=wage*(1/CHF) if currency_new==14
replace euro_wage=wage*(1/CZK) if currency_new==16
replace euro_wage=wage*(1/DEM) if currency_new==18
replace euro_wage=wage*(1/DKK) if currency_new==19
replace euro_wage=wage*(1/FRF) if currency_new==23
replace euro_wage=wage*(1/GBP) if currency_new==24
replace euro_wage=wage*(1/IEP) if currency_new==26
replace euro_wage=wage*(1/ITL) if currency_new==28
replace euro_wage=wage*(1/LUF) if currency_new==29
replace euro_wage=wage*(1/PLN) if currency_new==32
replace euro_wage=wage*(1/PTE) if currency_new==34
replace euro_wage=wage*(1/RUB) if currency_new==35
replace euro_wage=wage*(1/USD) if currency_new==41
replace euro_wage=wage*(1/HRK) if currency_new==109
replace euro_wage=wage*(1/HUF) if currency_new==111
replace euro_wage=wage*(1/NOK) if currency_new==164
replace euro_wage=wage*(1/SEK) if currency_new==186
replace euro_wage=wage*(1/GBP) if currency_new==265
replace euro_wage=wage*(1/ATS) if currency_new==266
replace euro_wage=wage*(1/DEM) if currency_new==267
replace euro_wage=wage*(1/NLG) if currency_new==269
replace euro_wage=wage*(1/USD) if currency_new==277
replace euro_wage=wage*(1/PTE) if currency_new==281

gen nat_wage=wage if currency_new==21
replace nat_wage=wage if currency_new==273 & nat_wage==.
replace nat_wage=euro_wage*ESP if nat_wage==.
gen cpi_wage=(nat_wage/cpi)*100
gen log_cpi_wage = ln(cpi_wage) 

*define partnership status, age2, 3 levels education codes
replace gender=0 if gender==2
label define gender 2 "", modify
label define gender 0 "Female", add

gen partner_married=1 if withpartner==1 | married==1
replace partner_married=0 if withpartner==0 & married==0
gen age2= age^2
gen educ_3level=1 if isced97_educ==0 | isced97_educ==1 | isced97_educ==2
replace educ_3level=2 if isced97_educ==3 | isced97_educ==4 
replace educ_3level=3 if isced97_educ==5 | isced97_educ==6
replace educ_3level=. if isced97_educ==.
replace educ_3level=-1 if isced97_educ_key==1 | isced97_educ==95 | isced97_educ==97 | isced97_educ==-1 | isced97_educ==-2

  // label variables
label variable partner_married "Married or have cohabited partner"
label variable log_cpi_wage "Log of annual net wage, cpi adjusted"
label variable nat_wage "Annual net wage,national currrency"
label variable cpi_wage "Annual net wage, national currency, cpi adjusted"
label variable log_cpi_wage "Log of annual net wage,national currency, cpi adjusted"
label variable age2 "age^2"
label variable educ_3level "Education level in 3 categories, low-medium-high"
label variable country_educ "country for educ document"

  // further checks
/*
tab x
tab x if year>1954
tab educ_3level if year>1954
tab age if year>1954
tab x if log_cpi_wage!=. & year>1954
tab gender if year>1954
tab isced97_educ if year>1954
tab years_of_educ if year>1954
*/
replace years_of_educ=-3 if years_of_educ==1964
replace years_of_educ=-3 if years_of_educ==9000

  // order variables
order log_cpi_wage, before(wage)
order nat_wage, before(wage)
order cpi_wage, before(wage)
order educ_3level, before(years_of_educ)
order age2, before(age)
order partner_married, before(married)

*restrict the sample age
drop if age<16
drop if age>66

*drop obs recorded as part-time
drop if working_hours==2

*drop obs where cpi value does not accessible
drop if year<1955

*drop obs where currency is not converted to national currency unit (exchange rate is not available in corresponding year)
drop if log_cpi_wage==.

*drop obs where education info is missing, or recorded as don't know or refusal
drop if years_of_educ==. & isced97_educ==.
drop if years_of_educ==-1 & isced97_educ==-1
drop if years_of_educ==-2 & isced97_educ==-2

*drop outliers
*sum cpi_wage, d
drop if cpi_wage>27400000

*append with parents job episode
append using `Spain_parents_job'

replace parent_sample=2 if parent_sample==.
replace median_1=median1 if parent_sample==1
replace isced97_educ_key=isced97_key if parent_sample==1

*apply model to create w_hat
reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==1 & parent_sample==2, robust  
scalar  RMSE1= e(rmse)
predict w_hat1 if educ_3level==1 & gender==1
gen w_hat1_level= exp(w_hat1)* exp(RMSE1^2/2) if educ_3level==1 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==0 & parent_sample==2, robust 
scalar  RMSE1w= e(rmse)
predict w_hat1w if educ_3level==1 & gender==0
gen w_hat1w_level= exp(w_hat1w)* exp(RMSE1w^2/2) if educ_3level==1 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==1 & parent_sample==2, robust  
scalar  RMSE2= e(rmse)
predict w_hat2 if educ_3level==2 & gender==1
gen w_hat2_level= exp(w_hat2)* exp(RMSE2^2/2) if educ_3level==2 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==0 & parent_sample==2, robust  
scalar  RMSE2w= e(rmse)
predict w_hat2w if educ_3level==2 & gender==0
gen w_hat2w_level= exp(w_hat2w)* exp(RMSE2w^2/2) if educ_3level==2 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==1 & parent_sample==2, robust  
scalar  RMSE3= e(rmse)
predict w_hat3 if educ_3level==3 & gender==1
gen w_hat3_level= exp(w_hat3)* exp(RMSE3^2/2) if educ_3level==3 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==0 & parent_sample==2, robust  
scalar  RMSE3w= e(rmse)
predict w_hat3w if educ_3level==3 & gender==0
gen w_hat3w_level= exp(w_hat3w)* exp(RMSE3w^2/2) if educ_3level==3 & gender==0

* combine w_hat(i)
gen w_hat= w_hat1
replace w_hat= w_hat2 if w_hat==.
replace w_hat= w_hat3 if w_hat==.
replace w_hat= w_hat1w if w_hat==.
replace w_hat= w_hat2w if w_hat==.
replace w_hat= w_hat3w if w_hat==.

* combine w_hat_level(i)
gen w_hat_level= w_hat1_level
replace w_hat_level= w_hat2_level if w_hat_level==.
replace w_hat_level= w_hat3_level if w_hat_level==.
replace w_hat_level= w_hat1w_level if w_hat_level==.
replace w_hat_level= w_hat2w_level if w_hat_level==.
replace w_hat_level= w_hat3w_level if w_hat_level==.
label variable w_hat_level "Imputed wage, based on median education level"

* drop intermediate variables
drop w_hat1 w_hat1w w_hat2 w_hat2w w_hat3 w_hat3w w_hat2_level w_hat3_level w_hat1w_level w_hat2w_level w_hat3w_level

// save
save `Spain_job_episode', replace

// keep only parents
drop if parent_sample==2

// keep necessary variables
keep  mergeid father_id mother_id gender yrbirth age2 age year country situation educ_3level years_of_educ years_of_educ_key isced97_educ isced97_educ_key working unemployed in_education retired mainjob ordjob industry job_title working_hours country_res_ nchildren_nat nchildren withpartner partner_married married child_coupleid child_country parent_status foreign_live migration_year parent_sample w_hat median_1 w_hat_level

   // label variables
label variable parent_status "Identification for parent sample"
label variable parent_status "Identification for mergeid belongs to father/mother"
label variable parent_sample "Identification for parent sample"
label variable w_hat "Imputed log wage, based on median education level"

// define spouse id
gen spouse_id=father_id
replace spouse_id=mother_id if spouse_id==""
label variable spouse_id "Spouse's mergeid"

drop father_id mother_id

// save
save  `Spain_parents_job_2', replace
restore 


/*==============================================================================
                           13: SWEDEN
==============================================================================*/

preserve
keep if	country_res==752

*define cpi adjusted net annual wage & log versions
gen euro_wage=wage if currency_new==1
replace euro_wage=wage*(1/ATS) if currency_new==2
replace euro_wage=wage*(1/BEF) if currency_new==5
replace euro_wage=wage*(1/CHF) if currency_new==14
replace euro_wage=wage*(1/CZK) if currency_new==16
replace euro_wage=wage*(1/DEM) if currency_new==18
replace euro_wage=wage*(1/DKK) if currency_new==19
replace euro_wage=wage*(1/ESP) if currency_new==21
replace euro_wage=wage*(1/FRF) if currency_new==23
replace euro_wage=wage*(1/GBP) if currency_new==24
replace euro_wage=wage*(1/ITL) if currency_new==28
replace euro_wage=wage*(1/PLN) if currency_new==32
replace euro_wage=wage*(1/PTE) if currency_new==34
replace euro_wage=wage*(1/RUB) if currency_new==35
replace euro_wage=wage*(1/USD) if currency_new==41
replace euro_wage=wage*(1/HRK) if currency_new==109
replace euro_wage=wage*(1/HUF) if currency_new==111
replace euro_wage=wage*(1/NOK) if currency_new==164
replace euro_wage=wage*(1/GBP) if currency_new==266
replace euro_wage=wage*(1/ATS) if currency_new==266
replace euro_wage=wage*(1/DEM) if currency_new==267
replace euro_wage=wage*(1/NLG) if currency_new==269
replace euro_wage=wage*(1/ESP) if currency_new==273
replace euro_wage=wage*(1/USD) if currency_new==277
replace euro_wage=wage*(1/PTE) if currency_new==281

gen nat_wage=wage if currency_new==186
replace nat_wage=wage if currency_new==270
replace nat_wage=euro_wage*SEK if nat_wage==.
gen cpi_wage=(nat_wage/cpi)*100
gen log_cpi_wage = ln(cpi_wage) 

*define partnership status, age2, 3 levels education codes
replace gender=0 if gender==2
label define gender 2 "", modify
label define gender 0 "Female", add

gen partner_married=1 if withpartner==1 | married==1
replace partner_married=0 if withpartner==0 & married==0
gen age2= age^2
gen educ_3level=1 if isced97_educ==0 | isced97_educ==1 | isced97_educ==2
replace educ_3level=2 if isced97_educ==3 | isced97_educ==4 
replace educ_3level=3 if isced97_educ==5 | isced97_educ==6
replace educ_3level=. if isced97_educ==.
replace educ_3level=-1 if isced97_educ_key==1 | isced97_educ==95 | isced97_educ==97 | isced97_educ==-1 | isced97_educ==-2

   // label variables
label variable partner_married "Married or have cohabited partner"
label variable log_cpi_wage "Log of annual net wage, cpi adjusted"
label variable nat_wage "Annual net wage,national currrency"
label variable cpi_wage "Annual net wage, national currency, cpi adjusted"
label variable log_cpi_wage "Log of annual net wage,national currency, cpi adjusted"
label variable age2 "age^2"
label variable educ_3level "Education level in 3 categories, low-medium-high"
label variable country_educ "country for educ document"

   // further checks
/*
tab x
tab x if year>1954
tab educ_3level if year>1954
tab age if year>1954
tab x if log_cpi_wage!=. & year>1954
tab gender if year>1954
tab isced97_educ if year>1954
tab years_of_educ if year>1954
*/

  // order variables
order log_cpi_wage, before(wage)
order nat_wage, before(wage)
order cpi_wage, before(wage)
order educ_3level, before(years_of_educ)
order age2, before(age)
order partner_married, before(married)

*restrict the sample age
drop if age<16
drop if age>66

*drop obs recorded as part-time
drop if working_hours==2

*drop obs where cpi value does not accessible
drop if year<1955

*drop obs where currency is not converted to national currency unit (exchange rate is not available in corresponding year)
drop if log_cpi_wage==.

*drop obs where education info is missing, or recorded as don't know or refusal
drop if years_of_educ==. & isced97_educ==.
drop if years_of_educ==-1 & isced97_educ==-1
drop if years_of_educ==-2 & isced97_educ==-2

*drop outliers
*sum cpi_wage, d
drop if cpi_wage>145318

*append with parents job episode
append using `Sweden_parents_job'

replace parent_sample=2 if parent_sample==.
replace median_1=median1 if parent_sample==1
replace isced97_educ_key=isced97_key if parent_sample==1

*apply model to create w_hat
reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==1 & parent_sample==2, robust  
scalar  RMSE1= e(rmse)
predict w_hat1 if educ_3level==1 & gender==1
gen w_hat1_level= exp(w_hat1)* exp(RMSE1^2/2) if educ_3level==1 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==0 & parent_sample==2, robust 
scalar  RMSE1w= e(rmse)
predict w_hat1w if educ_3level==1 & gender==0
gen w_hat1w_level= exp(w_hat1w)* exp(RMSE1w^2/2) if educ_3level==1 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==1 & parent_sample==2, robust  
scalar  RMSE2= e(rmse)
predict w_hat2 if educ_3level==2 & gender==1
gen w_hat2_level= exp(w_hat2)* exp(RMSE2^2/2) if educ_3level==2 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==0 & parent_sample==2, robust  
scalar  RMSE2w= e(rmse)
predict w_hat2w if educ_3level==2 & gender==0
gen w_hat2w_level= exp(w_hat2w)* exp(RMSE2w^2/2) if educ_3level==2 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==1 & parent_sample==2, robust  
scalar  RMSE3= e(rmse)
predict w_hat3 if educ_3level==3 & gender==1
gen w_hat3_level= exp(w_hat3)* exp(RMSE3^2/2) if educ_3level==3 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==0 & parent_sample==2, robust  
scalar  RMSE3w= e(rmse)
predict w_hat3w if educ_3level==3 & gender==0
gen w_hat3w_level= exp(w_hat3w)* exp(RMSE3w^2/2) if educ_3level==3 & gender==0

* combine w_hat(i)
gen w_hat= w_hat1
replace w_hat= w_hat2 if w_hat==.
replace w_hat= w_hat3 if w_hat==.
replace w_hat= w_hat1w if w_hat==.
replace w_hat= w_hat2w if w_hat==.
replace w_hat= w_hat3w if w_hat==.

* combine w_hat_level(i)
gen w_hat_level= w_hat1_level
replace w_hat_level= w_hat2_level if w_hat_level==.
replace w_hat_level= w_hat3_level if w_hat_level==.
replace w_hat_level= w_hat1w_level if w_hat_level==.
replace w_hat_level= w_hat2w_level if w_hat_level==.
replace w_hat_level= w_hat3w_level if w_hat_level==.
label variable w_hat_level "Imputed wage, based on median education level"

* drop intermediate variables
drop w_hat1 w_hat1w w_hat2 w_hat2w w_hat3 w_hat3w w_hat2_level w_hat3_level w_hat1w_level w_hat2w_level w_hat3w_level

// save
save `Sweden_job_episode', replace

// keep only parents
drop if parent_sample==2

// keep necessary variables
keep  mergeid father_id mother_id gender yrbirth age2 age year country situation educ_3level years_of_educ years_of_educ_key isced97_educ isced97_educ_key working unemployed in_education retired mainjob ordjob industry job_title working_hours country_res_ nchildren_nat nchildren withpartner partner_married married child_coupleid child_country parent_status foreign_live migration_year parent_sample w_hat median_1 w_hat_level

  // label variables
label variable parent_status "Identification for parent sample"
label variable parent_status "Identification for mergeid belongs to father/mother"
label variable parent_sample "Identification for parent sample"
label variable w_hat "Imputed log wage, based on median education level"

// define spouse id
gen spouse_id=father_id
replace spouse_id=mother_id if spouse_id==""
label variable spouse_id "Spouse's mergeid"

drop father_id mother_id

save  `Sweden_parents_job_2', replace
restore 

/*==============================================================================
                           14: SWITZERLAND
==============================================================================*/

preserve
keep if	country_res==756

*define cpi adjusted net annual wage & log versions
gen euro_wage=wage if currency_new==1
replace euro_wage=wage*(1/ATS) if currency_new==2
replace euro_wage=wage*(1/BEF) if currency_new==5
replace euro_wage=wage*(1/CZK) if currency_new==16
replace euro_wage=wage*(1/DEM) if currency_new==18
replace euro_wage=wage*(1/DKK) if currency_new==19
replace euro_wage=wage*(1/ESP) if currency_new==21
replace euro_wage=wage*(1/FRF) if currency_new==23
replace euro_wage=wage*(1/GBP) if currency_new==24
replace euro_wage=wage*(1/ITL) if currency_new==28
replace euro_wage=wage*(1/LUF) if currency_new==29
replace euro_wage=wage*(1/PLN) if currency_new==32
replace euro_wage=wage*(1/PTE) if currency_new==34
replace euro_wage=wage*(1/RUB) if currency_new==35
replace euro_wage=wage*(1/USD) if currency_new==41
replace euro_wage=wage*(1/HRK) if currency_new==109
replace euro_wage=wage*(1/HUF) if currency_new==111
replace euro_wage=wage*(1/NOK) if currency_new==164
replace euro_wage=wage*(1/SEK) if currency_new==186
replace euro_wage=wage*(1/GBP) if currency_new==265
replace euro_wage=wage*(1/ATS) if currency_new==266
replace euro_wage=wage*(1/DEM) if currency_new==267
replace euro_wage=wage*(1/NLG) if currency_new==269
replace euro_wage=wage*(1/ESP) if currency_new==273
replace euro_wage=wage*(1/USD) if currency_new==277
replace euro_wage=wage*(1/PTE) if currency_new==281

gen nat_wage=wage if currency_new==14
replace nat_wage=wage if currency_new==260 & nat_wage==.
replace nat_wage=wage if currency_new==261 & nat_wage==.
replace nat_wage=euro_wage*CHF if nat_wage==.
gen cpi_wage=(nat_wage/cpi)*100
gen log_cpi_wage = ln(cpi_wage) 

*define partnership status, age2, 3 levels education codes
replace gender=0 if gender==2
label define gender 2 "", modify
label define gender 0 "Female", add

gen partner_married=1 if withpartner==1 | married==1
replace partner_married=0 if withpartner==0 & married==0
gen age2= age^2
gen educ_3level=1 if isced97_educ==0 | isced97_educ==1 | isced97_educ==2
replace educ_3level=2 if isced97_educ==3 | isced97_educ==4 
replace educ_3level=3 if isced97_educ==5 | isced97_educ==6
replace educ_3level=. if isced97_educ==.
replace educ_3level=-1 if isced97_educ_key==1 | isced97_educ==95 | isced97_educ==97 | isced97_educ==-1 | isced97_educ==-2

   // label variables
label variable partner_married "Married or have cohabited partner"
label variable log_cpi_wage "Log of annual net wage, cpi adjusted"
label variable nat_wage "Annual net wage,national currrency"
label variable cpi_wage "Annual net wage, national currency, cpi adjusted"
label variable log_cpi_wage "Log of annual net wage,national currency, cpi adjusted"
label variable age2 "age^2"
label variable educ_3level "Education level in 3 categories, low-medium-high"
label variable country_educ "country for educ document"

  // further checks
/*
tab x
tab x if year>1954
tab educ_3level if year>1954
tab age if year>1954
tab x if log_cpi_wage!=. & year>1954
tab gender if year>1954
tab isced97_educ if year>1954
*/

// flag implausible observations
replace years_of_educ=-3 if years_of_educ==1983
replace years_of_educ=-3 if years_of_educ==1993

  // order variables
order log_cpi_wage, before(wage)
order nat_wage, before(wage)
order cpi_wage, before(wage)
order educ_3level, before(years_of_educ)
order age2, before(age)
order partner_married, before(married)

*restrict the sample age
drop if age<16
drop if age>66

*drop obs recorded as part-time
drop if working_hours==2

*drop obs where cpi value does not accessible
drop if year<1955

*drop obs where currency is not converted to national currency unit (exchange rate is not available in corresponding year)
drop if log_cpi_wage==.

*drop obs where education info is missing, or recorded as don't know or refusal
drop if years_of_educ==. & isced97_educ==.
drop if years_of_educ==-1 & isced97_educ==-1
drop if years_of_educ==-2 & isced97_educ==-2

*drop outliers
*sum cpi_wage, d
drop if cpi_wage>29086

*append with parents job episode
append using `Switzerland_parents_job'

replace parent_sample=2 if parent_sample==.
replace median_1=median1 if parent_sample==1
replace isced97_educ_key=isced97_key if parent_sample==1

*apply model to create w_hat
reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==1 & parent_sample==2, robust  
scalar  RMSE1= e(rmse)
predict w_hat1 if educ_3level==1 & gender==1
gen w_hat1_level= exp(w_hat1)* exp(RMSE1^2/2) if educ_3level==1 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==1 & gender==0 & parent_sample==2, robust 
scalar  RMSE1w= e(rmse)
predict w_hat1w if educ_3level==1 & gender==0
gen w_hat1w_level= exp(w_hat1w)* exp(RMSE1w^2/2) if educ_3level==1 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==1 & parent_sample==2, robust  
scalar  RMSE2= e(rmse)
predict w_hat2 if educ_3level==2 & gender==1
gen w_hat2_level= exp(w_hat2)* exp(RMSE2^2/2) if educ_3level==2 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==2 & gender==0 & parent_sample==2, robust  
scalar  RMSE2w= e(rmse)
predict w_hat2w if educ_3level==2 & gender==0
gen w_hat2w_level= exp(w_hat2w)* exp(RMSE2w^2/2) if educ_3level==2 & gender==0

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==1 & parent_sample==2, robust  
scalar  RMSE3= e(rmse)
predict w_hat3 if educ_3level==3 & gender==1
gen w_hat3_level= exp(w_hat3)* exp(RMSE3^2/2) if educ_3level==3 & gender==1

reg log_cpi_wage median_1 age age2 partner_married if educ_3level==3 & gender==0 & parent_sample==2, robust  
scalar  RMSE3w= e(rmse)
predict w_hat3w if educ_3level==3 & gender==0
gen w_hat3w_level= exp(w_hat3w)* exp(RMSE3w^2/2) if educ_3level==3 & gender==0

* combine w_hat(i)
gen w_hat= w_hat1
replace w_hat= w_hat2 if w_hat==.
replace w_hat= w_hat3 if w_hat==.
replace w_hat= w_hat1w if w_hat==.
replace w_hat= w_hat2w if w_hat==.
replace w_hat= w_hat3w if w_hat==.

* combine w_hat_level(i)
gen w_hat_level= w_hat1_level
replace w_hat_level= w_hat2_level if w_hat_level==.
replace w_hat_level= w_hat3_level if w_hat_level==.
replace w_hat_level= w_hat1w_level if w_hat_level==.
replace w_hat_level= w_hat2w_level if w_hat_level==.
replace w_hat_level= w_hat3w_level if w_hat_level==.
label variable w_hat_level "Imputed wage, based on median education level"

* drop intermediate variables
drop w_hat1 w_hat1w w_hat2 w_hat2w w_hat3 w_hat3w w_hat2_level w_hat3_level w_hat1w_level w_hat2w_level w_hat3w_level

// save
save `Switzerland_job_episode', replace

// keep only parents
drop if parent_sample==2

// keep necessary variables
keep  mergeid father_id mother_id gender yrbirth age2 age year country situation educ_3level years_of_educ years_of_educ_key isced97_educ isced97_educ_key working unemployed in_education retired mainjob ordjob industry job_title working_hours country_res_ nchildren_nat nchildren withpartner partner_married married child_coupleid child_country parent_status foreign_live migration_year parent_sample w_hat median_1 w_hat_level

  // label variables
label variable parent_status "Identification for parent sample"
label variable parent_status "Identification for mergeid belongs to father/mother"
label variable parent_sample "Identification for parent sample"
label variable w_hat "Imputed log wage, based on median education level"

 // define spouse id 
gen spouse_id=father_id
replace spouse_id=mother_id if spouse_id==""
label variable spouse_id "Spouse's mergeid"

drop father_id mother_id

// save
save  `Switzerland_parents_job_2', replace
restore 

*----------------------------END OF DO FILE-------------------------------------
*-------------------------------------------------------------------------------





















