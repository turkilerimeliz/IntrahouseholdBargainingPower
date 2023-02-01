/*==============================================================================
            1: Master Dataset Creation - Children
==============================================================================*/

*------------Merge master child dataset with master parent job history----------
use `children', replace
merge 1:1 coupleid gender  year_birth mother_id father_id child_year_6 child_year_7 child_year_8 child_year_9 child_year_10 child_year_11 child_year_12 child_year_13 child_year_14 child_year_15 using `parents_job_master', keepusing(wage_residence total_wage_mother total_wage_father mother_self_employed father_self_employed mother_wage_euro ln_mother_wage_euro father_wage_euro ln_father_wage_euro mother_lfs_total father_lfs_total number_years use_wave country_res_key2 parent_never_matched )

* define maksimum number of children
egen maks_number_child= rowmax(w1_number_of_children w2_number_of_children w4_number_of_children w5_number_of_children w6_number_of_children)
order maks_number_child, before(w1_number_of_children)
label var maks_number_child "Maksimum number of children reported"

* flag main sample of the study
gen original_sample=1 if bargaining1_rate!=. & father_year!=-1 & mother_year!=-1 
replace original_sample=0 if original_sample==.
label var original_sample "Main sample of the study"

* define total family labor income (in national currency)
gen total_family_wage= ln(total_wage_mother+total_wage_father) if parent_never_matched==0
label var total_family_wage "Natural log of total_wage_mother + total_wage_father"

* construct bargaining power defined as parents reltive wage income
gen bargaining_wage = total_wage_mother/total_wage_father if total_wage_mother!=. & total_wage_father!=. & parent_never_matched==0
label var bargaining_wage "total_wage_mother/total_wage_father"

* define subsample named as wage sample
gen wage_sample4=1 if bargaining_wage!=. & original_sample==1 & country!=47 & country!=34
replace wage_sample4=0 if wage_sample4==.
label var wage_sample4 "Wage sample of the study"

* flag the cases if one of the parents worked as self employed at least 1 year
gen parents_self_employed=1 if (mother_self_employed==1 | father_self_employed==1) & parent_never_matched==0
replace parents_self_employed=0 if parents_self_employed==. & parent_never_matched==0
label var parents_self_employed "At least one of the parents is self_employed"

* define total family labor income (in euro)
gen family_income_euro=(total_wage_mother+total_wage_father)/13.7603 if wage_residence==40 & parent_never_matched==0
replace family_income_euro=(total_wage_mother+total_wage_father)/40.3399 if wage_residence==56 & parent_never_matched==0
replace family_income_euro=(total_wage_mother+total_wage_father)/7.4473 if wage_residence==208 & parent_never_matched==0
replace family_income_euro=(total_wage_mother+total_wage_father)/6.55957 if wage_residence==250 & parent_never_matched==0
replace family_income_euro=(total_wage_mother+total_wage_father)/1.95583 if wage_residence==276 & parent_never_matched==0
replace family_income_euro=(total_wage_mother+total_wage_father)/340.75 if wage_residence==300 & parent_never_matched==0
replace family_income_euro=(total_wage_mother+total_wage_father)/0.787564 if wage_residence==372 & parent_never_matched==0
replace family_income_euro=(total_wage_mother+total_wage_father)/1936.27 if wage_residence==380 & parent_never_matched==0
replace family_income_euro=(total_wage_mother+total_wage_father)/40.3399 if wage_residence==442 & parent_never_matched==0
replace family_income_euro=(total_wage_mother+total_wage_father)/2.20371 if wage_residence==528 & parent_never_matched==0
replace family_income_euro=(total_wage_mother+total_wage_father)/200.482 if wage_residence==620 & parent_never_matched==0
replace family_income_euro=(total_wage_mother+total_wage_father)/166.386 if wage_residence==724 & parent_never_matched==0
replace family_income_euro=(total_wage_mother+total_wage_father)/9.5373 if wage_residence==752 & parent_never_matched==0
replace family_income_euro=(total_wage_mother+total_wage_father)/1.3803 if wage_residence==756 & parent_never_matched==0

label var family_income_euro "Total family income (euro)"

gen log_family_income_euro= ln(family_income_euro) if parent_never_matched==0
label var log_family_income_euro "Natural log of total family income (euro)"

*flag the cases where father with zero earnings
gen father_zero_earning=1 if total_wage_mother!=. & total_wage_mother!=0 & total_wage_father==0 & parent_never_matched==0
label var father_zero_earning "Father's earning is 0 whitin this period"

*impute the bargaining_wage where father earns zero income ( use 2*percentile(99) as treshold and replace outliers with maximum bargaining rate within the treshold)
*winsorize outliers ( use 2*percentile(99) as treshold and replace outliers with maximum bargaining rate within the treshold)
replace bargaining_wage= 12.34306 if father_zero_earning==1 | (bargaining_wage>= 17.070 & bargaining_wage!=.)
*define bargaining_wage as 1 when mother and father do not earn wage income
replace bargaining_wage=1 if total_wage_mother==0 & total_wage_father==0 & bargaining_wage==.


/*
replace family_income_euro=1 if family_income_euro==0 & parent_never_matched==0
replace log_family_income_euro=ln(family_income_euro) if total_wage_mother==0 & total_wage_father==0 & parent_never_matched==0

replace total_family_wage= ln(total_wage_mother+total_wage_father+1) if total_wage_mother==0 & total_wage_father==0 & parent_never_matched==0
*/


*------------Construct birth cohorts and standardized years of schooling--------

*create standardized years of schooling
egen child_ATS2=std(child_median_1) if country==11 & original_sample==1
egen mother_ATS=std(mother_median_1) if country==11 & original_sample==1
egen father_ATS=std(father_median_1) if country==11 & original_sample==1

egen child_DEM2=std(child_median_1) if country==12 & original_sample==1
egen mother_DEM=std(mother_median_1) if country==12 & original_sample==1
egen father_DEM=std(father_median_1) if country==12 & original_sample==1

egen child_SWEDEN2=std(child_median_1) if country==13 & original_sample==1
egen mother_SWEDEN=std(mother_median_1) if country==13 & original_sample==1
egen father_SWEDEN=std(father_median_1) if country==13 & original_sample==1

egen child_NED2=std(child_median_1) if country==14 & original_sample==1
egen mother_NED=std(mother_median_1) if country==14 & original_sample==1
egen father_NED=std(father_median_1) if country==14 & original_sample==1

egen child_SPAIN2=std(child_median_1) if country==15 & original_sample==1
egen mother_SPAIN=std(mother_median_1) if country==15 & original_sample==1
egen father_SPAIN=std(father_median_1) if country==15 & original_sample==1

egen child_ITA2=std(child_median_1) if country==16 & original_sample==1
egen mother_ITA=std(mother_median_1) if country==16 & original_sample==1
egen father_ITA=std(father_median_1) if country==16 & original_sample==1

egen child_FR2=std(child_median_1) if country==17 & original_sample==1
egen mother_FR=std(mother_median_1) if country==17 & original_sample==1
egen father_FR=std(father_median_1) if country==17 & original_sample==1

egen child_DKK2=std(child_median_1) if country==18 & original_sample==1
egen mother_DKK=std(mother_median_1) if country==18 & original_sample==1
egen father_DKK=std(father_median_1) if country==18 & original_sample==1

egen child_GR2=std(child_median_1) if country==19 & original_sample==1
egen mother_GR=std(mother_median_1) if country==19 & original_sample==1
egen father_GR=std(father_median_1) if country==19 & original_sample==1

egen child_CHF2=std(child_median_1) if country==20 & original_sample==1
egen mother_CHF=std(mother_median_1) if country==20 & original_sample==1
egen father_CHF=std(father_median_1) if country==20 & original_sample==1

egen child_BEL2=std(child_median_1) if country==23 & original_sample==1
egen mother_BEL=std(mother_median_1) if country==23 & original_sample==1
egen father_BEL=std(father_median_1) if country==23 & original_sample==1

egen child_ISR2=std(child_median_1) if country==25 & original_sample==1
egen mother_ISR=std(mother_median_1) if country==25 & original_sample==1
egen father_ISR=std(father_median_1) if country==25 & original_sample==1

egen child_CZK2=std(child_median_1) if country==28 & original_sample==1
egen mother_CZK=std(mother_median_1) if country==28 & original_sample==1
egen father_CZK=std(father_median_1) if country==28 & original_sample==1

egen child_POL2=std(child_median_1) if country==29 & original_sample==1
egen mother_POL=std(mother_median_1) if country==29 & original_sample==1
egen father_POL=std(father_median_1) if country==29 & original_sample==1

egen child_IRL2=std(child_median_1) if country==30 & original_sample==1
egen mother_IRL=std(mother_median_1) if country==30 & original_sample==1
egen father_IRL=std(father_median_1) if country==30 & original_sample==1

egen child_LUX2=std(child_median_1) if country==31 & original_sample==1
egen mother_LUX=std(mother_median_1) if country==31 & original_sample==1
egen father_LUX=std(father_median_1) if country==31 & original_sample==1

egen child_HUN2=std(child_median_1) if country==32 & original_sample==1
egen mother_HUN=std(mother_median_1) if country==32 & original_sample==1
egen father_HUN=std(father_median_1) if country==32 & original_sample==1

egen child_POR2=std(child_median_1) if country==33 & original_sample==1
egen mother_POR=std(mother_median_1) if country==33 & original_sample==1
egen father_POR=std(father_median_1) if country==33 & original_sample==1

egen child_SLV2=std(child_median_1) if country==34 & original_sample==1
egen mother_SLV=std(mother_median_1) if country==34 & original_sample==1
egen father_SLV=std(father_median_1) if country==34 & original_sample==1

egen child_EST2=std(child_median_1) if country==35 & original_sample==1
egen mother_EST=std(mother_median_1) if country==35 & original_sample==1
egen father_EST=std(father_median_1) if country==35 & original_sample==1

egen child_CRT2=std(child_median_1) if country==47 & original_sample==1
egen mother_CRT=std(mother_median_1) if country==47 & original_sample==1
egen father_CRT=std(father_median_1) if country==47 & original_sample==1

gen std_child_median=child_ATS2
replace std_child_median=child_DEM2 if std_child_median==.
replace std_child_median=child_SWEDEN2 if std_child_median==.
replace std_child_median=child_NED2 if std_child_median==.
replace std_child_median=child_SPAIN2 if std_child_median==.
replace std_child_median=child_ITA2 if std_child_median==.
replace std_child_median=child_FR2 if std_child_median==.
replace std_child_median=child_DKK2 if std_child_median==.
replace std_child_median=child_GR2 if std_child_median==.
replace std_child_median=child_CHF2 if std_child_median==.
replace std_child_median=child_BEL2 if std_child_median==.
replace std_child_median=child_ISR2 if std_child_median==.
replace std_child_median=child_CZK2 if std_child_median==.
replace std_child_median=child_POL2 if std_child_median==.
replace std_child_median=child_IRL2 if std_child_median==.
replace std_child_median=child_LUX2 if std_child_median==.
replace std_child_median=child_HUN2 if std_child_median==.
replace std_child_median=child_SLV2 if std_child_median==.
replace std_child_median=child_EST2 if std_child_median==.
replace std_child_median=child_CRT2 if std_child_median==.
replace std_child_median=child_POR2 if std_child_median==.

gen std_mother_median=mother_ATS
replace std_mother_median=mother_DEM if std_mother_median==.
replace std_mother_median=mother_SWEDEN if std_mother_median==.
replace std_mother_median=mother_NED if std_mother_median==.
replace std_mother_median=mother_SPAIN if std_mother_median==.
replace std_mother_median=mother_ITA if std_mother_median==.
replace std_mother_median=mother_FR if std_mother_median==.
replace std_mother_median=mother_DKK if std_mother_median==.
replace std_mother_median=mother_GR if std_mother_median==.
replace std_mother_median=mother_CHF if std_mother_median==.
replace std_mother_median=mother_BEL if std_mother_median==.
replace std_mother_median=mother_ISR if std_mother_median==.
replace std_mother_median=mother_CZK if std_mother_median==.
replace std_mother_median=mother_POL if std_mother_median==.
replace std_mother_median=mother_IRL if std_mother_median==.
replace std_mother_median=mother_LUX if std_mother_median==.
replace std_mother_median=mother_HUN if std_mother_median==.
replace std_mother_median=mother_SLV if std_mother_median==.
replace std_mother_median=mother_EST if std_mother_median==.
replace std_mother_median=mother_CRT if std_mother_median==.
replace std_mother_median=mother_POR if std_mother_median==.

gen std_father_median=father_ATS
replace std_father_median=father_DEM if std_father_median==.
replace std_father_median=father_SWEDEN if std_father_median==.
replace std_father_median=father_NED if std_father_median==.
replace std_father_median=father_SPAIN if std_father_median==.
replace std_father_median=father_ITA if std_father_median==.
replace std_father_median=father_FR if std_father_median==.
replace std_father_median=father_DKK if std_father_median==.
replace std_father_median=father_GR if std_father_median==.
replace std_father_median=father_CHF if std_father_median==.
replace std_father_median=father_BEL if std_father_median==.
replace std_father_median=father_ISR if std_father_median==.
replace std_father_median=father_CZK if std_father_median==.
replace std_father_median=father_POL if std_father_median==.
replace std_father_median=father_IRL if std_father_median==.
replace std_father_median=father_LUX if std_father_median==.
replace std_father_median=father_HUN if std_father_median==.
replace std_father_median=father_SLV if std_father_median==.
replace std_father_median=father_EST if std_father_median==.
replace std_father_median=father_CRT if std_father_median==.
replace std_father_median=father_POR if std_father_median==.


*grouped birth_cohorts for child
*5 years
gen child_birth_cohort=1 if year_birth>1935 & year_birth<1941
replace child_birth_cohort=2 if year_birth>1940 & year_birth<1946
replace child_birth_cohort=3 if year_birth>1945 & year_birth<1951
replace child_birth_cohort=4 if year_birth>1950 & year_birth<1956
replace child_birth_cohort=5 if year_birth>1955 & year_birth<1961
replace child_birth_cohort=6 if year_birth>1960 & year_birth<1966
replace child_birth_cohort=7 if year_birth>1965 & year_birth<1971
replace child_birth_cohort=8 if year_birth>1970 & year_birth<1976
replace child_birth_cohort=9 if year_birth>1975 & year_birth<1981
replace child_birth_cohort=10 if year_birth>1980 & year_birth<1986
replace child_birth_cohort=11 if year_birth>1985 & year_birth<1991
replace child_birth_cohort=12 if year_birth>1990 & year_birth<1996


*grouped birth_cohorts for parents - 10 years
gen father_birth_cohort=1 if father_year>1904 & father_year<1915 
replace father_birth_cohort=2 if father_year>1914 & father_year<1925 
replace father_birth_cohort=3 if father_year>1924 & father_year<1935 
replace father_birth_cohort=4 if father_year>1934 & father_year<1945 
replace father_birth_cohort=5 if father_year>1944 & father_year<1955 
replace father_birth_cohort=6 if father_year>1954 & father_year<1965 
replace father_birth_cohort=7 if father_year>1964 & father_year<1975 
replace father_birth_cohort=8 if father_year>1964 & father_year<1977 


gen mother_birth_cohort=1 if mother_year>1904 & mother_year<1915 
replace mother_birth_cohort=2 if mother_year>1914 & mother_year<1925 
replace mother_birth_cohort=3 if mother_year>1924 & mother_year<1935 
replace mother_birth_cohort=4 if mother_year>1934 & mother_year<1945 
replace mother_birth_cohort=5 if mother_year>1944 & mother_year<1955 
replace mother_birth_cohort=6 if mother_year>1954 & mother_year<1965 
replace mother_birth_cohort=7 if mother_year>1964 & mother_year<1975 
replace mother_birth_cohort=8 if mother_year>1964 & mother_year<1977 


*Gen country FE* Birth Cohort FE interactions
gen country_birth_fe=111 if country==11 & child_birth_cohort==1
replace country_birth_fe=112 if country==11 & child_birth_cohort==2
replace country_birth_fe=113 if country==11 & child_birth_cohort==3
replace country_birth_fe=114 if country==11 & child_birth_cohort==4
replace country_birth_fe=115 if country==11 & child_birth_cohort==5
replace country_birth_fe=116 if country==11 & child_birth_cohort==6
replace country_birth_fe=117 if country==11 & child_birth_cohort==7
replace country_birth_fe=118 if country==11 & child_birth_cohort==8

replace country_birth_fe=121 if country==12 & child_birth_cohort==1
replace country_birth_fe=122 if country==12 & child_birth_cohort==2
replace country_birth_fe=123 if country==12 & child_birth_cohort==3
replace country_birth_fe=124 if country==12 & child_birth_cohort==4
replace country_birth_fe=125 if country==12 & child_birth_cohort==5
replace country_birth_fe=126 if country==12 & child_birth_cohort==6
replace country_birth_fe=127 if country==12 & child_birth_cohort==7
replace country_birth_fe=128 if country==12 & child_birth_cohort==8

replace country_birth_fe=131 if country==13 & child_birth_cohort==1
replace country_birth_fe=132 if country==13 & child_birth_cohort==2
replace country_birth_fe=133 if country==13 & child_birth_cohort==3
replace country_birth_fe=134 if country==13 & child_birth_cohort==4
replace country_birth_fe=135 if country==13 & child_birth_cohort==5
replace country_birth_fe=136 if country==13 & child_birth_cohort==6
replace country_birth_fe=137 if country==13 & child_birth_cohort==7
replace country_birth_fe=138 if country==13 & child_birth_cohort==8

replace country_birth_fe=141 if country==14 & child_birth_cohort==1
replace country_birth_fe=142 if country==14 & child_birth_cohort==2
replace country_birth_fe=143 if country==14 & child_birth_cohort==3
replace country_birth_fe=144 if country==14 & child_birth_cohort==4
replace country_birth_fe=145 if country==14 & child_birth_cohort==5
replace country_birth_fe=146 if country==14 & child_birth_cohort==6
replace country_birth_fe=147 if country==14 & child_birth_cohort==7
replace country_birth_fe=148 if country==14 & child_birth_cohort==8

replace country_birth_fe=151 if country==15 & child_birth_cohort==1
replace country_birth_fe=152 if country==15 & child_birth_cohort==2
replace country_birth_fe=153 if country==15 & child_birth_cohort==3
replace country_birth_fe=154 if country==15 & child_birth_cohort==4
replace country_birth_fe=155 if country==15 & child_birth_cohort==5
replace country_birth_fe=156 if country==15 & child_birth_cohort==6
replace country_birth_fe=157 if country==15 & child_birth_cohort==7
replace country_birth_fe=158 if country==15 & child_birth_cohort==8

replace country_birth_fe=161 if country==16 & child_birth_cohort==1
replace country_birth_fe=162 if country==16 & child_birth_cohort==2
replace country_birth_fe=163 if country==16 & child_birth_cohort==3
replace country_birth_fe=164 if country==16 & child_birth_cohort==4
replace country_birth_fe=165 if country==16 & child_birth_cohort==5
replace country_birth_fe=166 if country==16 & child_birth_cohort==6
replace country_birth_fe=167 if country==16 & child_birth_cohort==7
replace country_birth_fe=168 if country==16 & child_birth_cohort==8

replace country_birth_fe=171 if country==17 & child_birth_cohort==1
replace country_birth_fe=172 if country==17 & child_birth_cohort==2
replace country_birth_fe=173 if country==17 & child_birth_cohort==3
replace country_birth_fe=174 if country==17 & child_birth_cohort==4
replace country_birth_fe=175 if country==17 & child_birth_cohort==5
replace country_birth_fe=176 if country==17 & child_birth_cohort==6
replace country_birth_fe=177 if country==17 & child_birth_cohort==7
replace country_birth_fe=178 if country==17 & child_birth_cohort==8

replace country_birth_fe=181 if country==18 & child_birth_cohort==1
replace country_birth_fe=182 if country==18 & child_birth_cohort==2
replace country_birth_fe=183 if country==18 & child_birth_cohort==3
replace country_birth_fe=184 if country==18 & child_birth_cohort==4
replace country_birth_fe=185 if country==18 & child_birth_cohort==5
replace country_birth_fe=186 if country==18 & child_birth_cohort==6
replace country_birth_fe=187 if country==18 & child_birth_cohort==7
replace country_birth_fe=188 if country==18 & child_birth_cohort==8

replace country_birth_fe=191 if country==19 & child_birth_cohort==1
replace country_birth_fe=192 if country==19 & child_birth_cohort==2
replace country_birth_fe=193 if country==19 & child_birth_cohort==3
replace country_birth_fe=194 if country==19 & child_birth_cohort==4
replace country_birth_fe=195 if country==19 & child_birth_cohort==5
replace country_birth_fe=196 if country==19 & child_birth_cohort==6
replace country_birth_fe=197 if country==19 & child_birth_cohort==7
replace country_birth_fe=198 if country==19 & child_birth_cohort==8

replace country_birth_fe=201 if country==20 & child_birth_cohort==1
replace country_birth_fe=202 if country==20 & child_birth_cohort==2
replace country_birth_fe=203 if country==20 & child_birth_cohort==3
replace country_birth_fe=204 if country==20 & child_birth_cohort==4
replace country_birth_fe=205 if country==20 & child_birth_cohort==5
replace country_birth_fe=206 if country==20 & child_birth_cohort==6
replace country_birth_fe=207 if country==20 & child_birth_cohort==7
replace country_birth_fe=208 if country==20 & child_birth_cohort==8

replace country_birth_fe=231 if country==23 & child_birth_cohort==1
replace country_birth_fe=232 if country==23 & child_birth_cohort==2
replace country_birth_fe=233 if country==23 & child_birth_cohort==3
replace country_birth_fe=234 if country==23 & child_birth_cohort==4
replace country_birth_fe=235 if country==23 & child_birth_cohort==5
replace country_birth_fe=236 if country==23 & child_birth_cohort==6
replace country_birth_fe=237 if country==23 & child_birth_cohort==7
replace country_birth_fe=238 if country==23 & child_birth_cohort==8

replace country_birth_fe=251 if country==25 & child_birth_cohort==1
replace country_birth_fe=252 if country==25 & child_birth_cohort==2
replace country_birth_fe=253 if country==25 & child_birth_cohort==3
replace country_birth_fe=254 if country==25 & child_birth_cohort==4
replace country_birth_fe=255 if country==25 & child_birth_cohort==5
replace country_birth_fe=256 if country==25 & child_birth_cohort==6
replace country_birth_fe=257 if country==25 & child_birth_cohort==7
replace country_birth_fe=258 if country==25 & child_birth_cohort==8

replace country_birth_fe=281 if country==28 & child_birth_cohort==1
replace country_birth_fe=282 if country==28 & child_birth_cohort==2
replace country_birth_fe=283 if country==28 & child_birth_cohort==3
replace country_birth_fe=284 if country==28 & child_birth_cohort==4
replace country_birth_fe=285 if country==28 & child_birth_cohort==5
replace country_birth_fe=286 if country==28 & child_birth_cohort==6
replace country_birth_fe=287 if country==28 & child_birth_cohort==7
replace country_birth_fe=288 if country==28 & child_birth_cohort==8
replace country_birth_fe=291 if country==29 & child_birth_cohort==1
replace country_birth_fe=292 if country==29 & child_birth_cohort==2
replace country_birth_fe=293 if country==29 & child_birth_cohort==3
replace country_birth_fe=294 if country==29 & child_birth_cohort==4
replace country_birth_fe=295 if country==29 & child_birth_cohort==5
replace country_birth_fe=296 if country==29 & child_birth_cohort==6
replace country_birth_fe=297 if country==29 & child_birth_cohort==7
replace country_birth_fe=298 if country==29 & child_birth_cohort==8
replace country_birth_fe=301 if country==30 & child_birth_cohort==1
replace country_birth_fe=302 if country==30 & child_birth_cohort==2
replace country_birth_fe=303 if country==30 & child_birth_cohort==3
replace country_birth_fe=304 if country==30 & child_birth_cohort==4
replace country_birth_fe=305 if country==30 & child_birth_cohort==5
replace country_birth_fe=306 if country==30 & child_birth_cohort==6
replace country_birth_fe=307 if country==30 & child_birth_cohort==7
replace country_birth_fe=308 if country==30 & child_birth_cohort==8
replace country_birth_fe=311 if country==31 & child_birth_cohort==1
replace country_birth_fe=312 if country==31 & child_birth_cohort==2
replace country_birth_fe=313 if country==31 & child_birth_cohort==3
replace country_birth_fe=314 if country==31 & child_birth_cohort==4
replace country_birth_fe=315 if country==31 & child_birth_cohort==5
replace country_birth_fe=316 if country==31 & child_birth_cohort==6
replace country_birth_fe=317 if country==31 & child_birth_cohort==7
replace country_birth_fe=318 if country==31 & child_birth_cohort==8
replace country_birth_fe=321 if country==32 & child_birth_cohort==1
replace country_birth_fe=322 if country==32 & child_birth_cohort==2
replace country_birth_fe=323 if country==32 & child_birth_cohort==3
replace country_birth_fe=324 if country==32 & child_birth_cohort==4
replace country_birth_fe=325 if country==32 & child_birth_cohort==5
replace country_birth_fe=326 if country==32 & child_birth_cohort==6
replace country_birth_fe=327 if country==32 & child_birth_cohort==7
replace country_birth_fe=328 if country==32 & child_birth_cohort==8
replace country_birth_fe=331 if country==33 & child_birth_cohort==1
replace country_birth_fe=332 if country==33 & child_birth_cohort==2
replace country_birth_fe=333 if country==33 & child_birth_cohort==3
replace country_birth_fe=334 if country==33 & child_birth_cohort==4
replace country_birth_fe=335 if country==33 & child_birth_cohort==5
replace country_birth_fe=336 if country==33 & child_birth_cohort==6
replace country_birth_fe=337 if country==33 & child_birth_cohort==7
replace country_birth_fe=338 if country==33 & child_birth_cohort==8
replace country_birth_fe=341 if country==34 & child_birth_cohort==1
replace country_birth_fe=342 if country==34 & child_birth_cohort==2
replace country_birth_fe=343 if country==34 & child_birth_cohort==3
replace country_birth_fe=344 if country==34 & child_birth_cohort==4
replace country_birth_fe=345 if country==34 & child_birth_cohort==5
replace country_birth_fe=346 if country==34 & child_birth_cohort==6
replace country_birth_fe=347 if country==34 & child_birth_cohort==7
replace country_birth_fe=348 if country==34 & child_birth_cohort==8
replace country_birth_fe=351 if country==35 & child_birth_cohort==1
replace country_birth_fe=352 if country==35 & child_birth_cohort==2
replace country_birth_fe=353 if country==35 & child_birth_cohort==3
replace country_birth_fe=354 if country==35 & child_birth_cohort==4
replace country_birth_fe=355 if country==35 & child_birth_cohort==5
replace country_birth_fe=356 if country==35 & child_birth_cohort==6
replace country_birth_fe=357 if country==35 & child_birth_cohort==7
replace country_birth_fe=358 if country==35 & child_birth_cohort==8
replace country_birth_fe=471 if country==47 & child_birth_cohort==1
replace country_birth_fe=472 if country==47 & child_birth_cohort==2
replace country_birth_fe=473 if country==47 & child_birth_cohort==3
replace country_birth_fe=474 if country==47 & child_birth_cohort==4
replace country_birth_fe=475 if country==47 & child_birth_cohort==5
replace country_birth_fe=476 if country==47 & child_birth_cohort==6
replace country_birth_fe=477 if country==47 & child_birth_cohort==7
replace country_birth_fe=478 if country==47 & child_birth_cohort==8

  // drop unnecessary variables
drop child_ATS2-father_CRT
  
  // label variables
label variable problematic "transition countries, Israel and Portugal"
label variable transition "transition countries and Israel "
label variable std_child_median "standardized child median yrschl"
label variable std_mother_median "standardized mother median yrschl"
label variable std_father_median "standardized father median yrschl"
label variable child_birth_cohort "Child birth cohorts"
label variable father_birth_cohort "Father birth cohorts"
label variable mother_birth_cohort "Moher birth cohorts"
label variable country_birth_fe "Country Fixed Effects*Child Birth Cohort FE"

label values gender gender

*----------Construct variables for the heterogeneity part of the study----------

* flag cases where father's education level is above isced97-3
gen father_educ_dummy=1 if father_isced97==0 | father_isced97==1 | father_isced97==2 | father_isced97==3
replace father_educ_dummy=0 if father_isced97==4 | father_isced97==5 | father_isced97==6
label var father_educ_dummy "Fathers with ISCED 0-1-2-3 (dummy)"


* merge with gender norms dataset
drop _merge

merge m:1 country using "Gender_norms.dta"
 
drop if _merge==2
drop _merge
drop country_name

* define 3-level education categories
gen c_education3_level=1 if (isced97==0 | isced97==1 | isced97==2) & original_sample==1
replace c_education3_level=2 if (isced97==3 | isced97==4) & original_sample==1 
replace c_education3_level=3 if (isced97==5 | isced97==6) & original_sample==1

gen m_education3_level=1 if (mother_isced97==0 | mother_isced97==1 | mother_isced97==2) & original_sample==1
replace m_education3_level=2 if (mother_isced97==3 | mother_isced97==4) & original_sample==1 
replace m_education3_level=3 if (mother_isced97==5 | mother_isced97==6) & original_sample==1

gen f_education3_level=1 if (father_isced97==0 | father_isced97==1 | father_isced97==2) & original_sample==1
replace f_education3_level=2 if (father_isced97==3 | father_isced97==4) & original_sample==1 
replace f_education3_level=3 if (father_isced97==5 | father_isced97==6) & original_sample==1

label var c_education3_level "child education level-3 categories"
label var m_education3_level "mother education level-3 categories"
label var f_education3_level "father education level-3 categories"


*define bargaining clusters
gen bargaining_cluster=1 if bargaining1_rate<0.6 & bargaining1_rate!=. & original_sample==1
replace bargaining_cluster=2 if bargaining1_rate>=0.6 & bargaining1_rate<0.8 & bargaining1_rate!=. & original_sample==1
replace bargaining_cluster=3 if bargaining1_rate>=0.8 & bargaining1_rate<1 & bargaining1_rate!=. & original_sample==1
replace bargaining_cluster=4 if bargaining1_rate>=1 & bargaining1_rate<1.2 & bargaining1_rate!=. & original_sample==1
replace bargaining_cluster=5 if bargaining1_rate>=1.2 & bargaining1_rate<1.4 & bargaining1_rate!=. & original_sample==1
replace bargaining_cluster=6 if bargaining1_rate>=1.4 & bargaining1_rate!=. & original_sample==1

   // label variables
label var bargaining_cluster "Bargaining clusters"
lab define bargaining_cluster 1 "bargaining1_rate<0.6" 2 "0.6<=x<0.8" 3 "0.8<=x<1.0" 4 "1.0<=x<1.2" 5 "1.2<=x<1.4" 6 "1.4<=x"
lab values bargaining_cluster bargaining_cluster

  // create mean values for bargaining_clusters
bysort bargaining_cluster: egen mean_clusters = mean(bargaining1_rate) if bargaining1_rate!=. & original_sample==1
label variable mean_clusters "Mean bargaining1_rate values by bargaining_cluster_v2"
label var mean_clusters "Mean of bargaining clusters"

 
*--------------------------------Construct weights------------------------------

* merge with weights dataset

merge m:1 country mergeid using `merged_weights'
drop if _merge==2

*Weight1
gen design_weight=.

foreach i of num 1/6 {
replace design_weight=dw_w`i' if final_wave==`i'
}
order design_weight final_wave, before(coupleid1)

   // further checks for consistency
/*
  // Create controls for the consistency of data
gen design_key_hhid=.

foreach i of num 1/6 {
replace design_key_hhid=0 if final_wave==`i' & hhid!=hhid`i'
}

drop design_key_hhid 
  // All the values are consistent for hhid.

gen design_key_coupleid=.
foreach i of num 1/6 {
replace design_key_coupleid=0 if final_wave==`i' & coupleid!=coupleid`i'
}

drop design_key_coupleid
  // All the values are consistent for coupleid.


gen design_key_mergeidp=.
foreach i of num 1/6 {
replace design_key_mergeidp=0 if final_wave==`i' & mergeidp!=mergeidp`i'
}
  //All the values are consistent for mergeidp.

drop design_key_mergeidp
*/

drop hhid1-hhid7
drop coupleid1-H_SHARELIFE


// create country specific mean values of design_weights
replace design_weight=. if original_sample!=1
bysort country: egen mean_design_weight = mean(design_weight) if original_sample==1

// create standardized design weights
gen std_design_weight=design_weight/mean_design_weight if original_sample==1
  
  // control the std_design_weight
total std_design_weight, over(country)
tab country
  // label variables
label variable design_weight "weight from the survey"
label variable mean_design_weight "mean design_weight by country"
label variable std_design_weight "design_weight/mean_design_weight"
drop _merge

*Weight2 - Weight 3
merge m:1 country using "Country_population.dta"

sort country
gen control=1 if original_sample==1
by country: egen sample_size = total(control) if original_sample==1
drop control
gen weight_2=1/sample_size if original_sample==1
gen weight_3= pop_size/sample_size if original_sample==1
 
  // label variables
label var sample_size "Sample size of corresponding country"
label var pop_size "Population size of corresponding country"
label var weight_2 "1/sample_size"
label var weight_3 "pop_size/sample_size"

*--------------------------------Keep and Save ---------------------------------



save  "`dataout'\master_dataset.dta", replace

*----------------------------END OF DO FILE-------------------------------------
*-------------------------------------------------------------------------------


