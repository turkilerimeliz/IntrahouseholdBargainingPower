/*==============================================================================
                       1:  Results
==============================================================================*/

use "`dataout'\master_dataset.dta", replace

**MODEL 0
*Sample= All sample
*Table 0- mobility estimates without bargaining and interactions
asdoc regress std_child_median std_mother_median std_father_median i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.gender i.country#i.gender  if  original_sample==1 , replace save(`dataout'\Table0.doc) title(Table 0) vce(cluster coupleid) nest cnames(All children) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender _cons) add(Gender Control, YES, Country*Gender FE, YES, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  if   gender==2 & original_sample==1 , save(`dataout'\Table0.doc) title(Table 0) vce(cluster coupleid) nest cnames(Daughters) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  if  gender==1 & original_sample==1 , save(`dataout'\Table0.doc) title(Table 0) vce(cluster coupleid) nest cnames(Sons) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe i.gender i.country#i.gender if  original_sample==1 , save(Table0.doc) title(Table 0) vce(cluster coupleid) nest cnames(All children) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender i.country_birth_fe i.gender _cons) add( Gender Control, YES, Country*Gender FE, YES, BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 , save(`dataout'\Table0.doc) title(Table 0) vce(cluster coupleid) nest cnames(Daughters) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender i.country_birth_fe i.gender _cons) add( Gender Control, NO, Country*Gender FE, NO, BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & original_sample==1 , save(`dataout'\Table0.doc) title(Table 0) vce(cluster coupleid) nest cnames(Sons) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender i.country_birth_fe i.gender _cons) add( Gender Control, NO, Country*Gender FE, NO, BC*CFE, YES,) dec(3) tzok label


 

**MODEL 1 -related tables
*Bargaining = maternal education/ paternal education
*Sample= All sample

*Table 1- original model
asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.gender i.country#i.gender  if  original_sample==1, replace save(`dataout'\Table1.doc) title(Table 1) vce(cluster coupleid) nest cnames(All children) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, YES, Country*Gender FE, YES, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  if   gender==2 & original_sample==1 , save(`dataout'\Table1.doc) title(Table 1) vce(cluster coupleid) nest cnames(Daughters) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, NO,) dec(3) tzok label

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  if  gender==1 & original_sample==1 , save(`dataout'\Table1.doc) title(Table 1) vce(cluster coupleid) nest cnames(Sons) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe i.gender i.country#i.gender if  original_sample==1 , save(`dataout'\Table1.doc) title(Table 1)  vce(cluster coupleid) nest cnames(All children) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  i.country_birth_fe i.gender _cons) add( Gender Control, YES, Country*Gender FE, YES, BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 , save(`dataout'\Table1.doc) title(Table 1) vce(cluster coupleid) nest cnames(Daughters) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender i.country_birth_fe i.gender _cons) add( Gender Control, NO, Country*Gender FE, NO, BC*CFE, YES,) dec(3) tzok label  

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & original_sample==1 , save(`dataout'\Table1.doc) title(Table 1) vce(cluster coupleid) nest cnames(Sons) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  i.country_birth_fe i.gender _cons) add( Gender Control, NO, Country*Gender FE, NO, BC*CFE, YES,) dec(3) tzok label 


*Bargaining = maternal education/ paternal education
*Sample= All sample
*Table A1 
asdoc regress std_child_median std_mother_median std_father_median c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 , replace save(`dataout'\TableA1.doc) title(Table A1) vce(cluster coupleid) nest cnames(Daughters) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe _cons) add(BC*CFE, YES,) dec(3) tzok label  

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 , save(`dataout'\TableA1.doc) title(Table A1) vce(cluster coupleid) nest cnames(Daughters) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe _cons) add(BC*CFE, YES,) dec(3) tzok label  

asdoc regress std_child_median std_mother_median std_father_median c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & original_sample==1 , save(`dataout'\TableA1.doc) title(Table A1) vce(cluster coupleid) nest cnames(Sons) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe _cons) add(BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & original_sample==1 , save(`dataout'\TableA1.doc) title(Table A1)  vce(cluster coupleid) nest cnames(Sons) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe _cons) add(BC*CFE, YES,) dec(3) tzok label 


*Bargaining = maternal education/ paternal education
*Sample= All sample
*Table A2-V2 original model + Controlling number of children 
asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate maks_number_child  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.gender i.country#i.gender  if  original_sample==1, replace save(`dataout'\TableA2.doc) title(Table A2) vce(cluster coupleid) nest cnames(All children) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, YES, Country*Gender FE, YES, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate maks_number_child i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  if   gender==2 & original_sample==1 , save(`dataout'\TableA2.doc) title(Table A2) vce(cluster coupleid) nest cnames(Daughters) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, NO,) dec(3) tzok label

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate maks_number_child i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  if  gender==1 & original_sample==1 , save(`dataout'\TableA2.doc) title(Table A2) vce(cluster coupleid) nest cnames(Sons) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate maks_number_child i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe i.gender i.country#i.gender if  original_sample==1 , save(`dataout'\TableA2.doc) title(Table A2) vce(cluster coupleid) nest cnames(All children) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  i.country_birth_fe i.gender _cons) add( Gender Control, YES, Country*Gender FE, YES, BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate maks_number_child i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 , save(`dataout'\TableA2.doc) title(Table A2) vce(cluster coupleid) nest cnames(Daughters) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender i.country_birth_fe i.gender _cons) add( Gender Control, NO, Country*Gender FE, NO, BC*CFE, YES,) dec(3) tzok label  

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate maks_number_child i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & original_sample==1 , save(`dataout'\TableA2.doc) title(Table A2) vce(cluster coupleid) nest cnames(Sons) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  i.country_birth_fe i.gender _cons) add( Gender Control, NO, Country*Gender FE, NO, BC*CFE, YES,) dec(3) tzok label 



**MODEL with gender norms -related tables
*Bargaining = maternal education/ paternal education
*Sample= All sample

*TABLE 13: Gender Inequality Index (G.I.I)

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate  c.std_mother_median#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate#c.gender_index_raw c.std_father_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate#c.gender_index_raw i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.gender i.country#i.gender if  original_sample==1 , replace save(`dataout'\Table13.doc) title(Table 13) vce(cluster coupleid) nest cnames(All children) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, YES, Country*Gender FE, YES, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate#c.gender_index_raw c.std_father_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate#c.gender_index_raw i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  if   gender==2 & original_sample==1 , save(`dataout'\Table13.doc) title(Table 13-  Gender Inequality Index (GII)) vce(cluster coupleid) nest cnames(Daughters) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate#c.gender_index_raw c.std_father_median#c.bargaining1_rate  c.std_father_median#c.bargaining1_rate#c.gender_index_raw i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  if  gender==1 & original_sample==1 , save(`dataout'\Table13.doc) title(Table 13-  Gender Inequality Index (GII)) vce(cluster coupleid) nest cnames(Sons) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate#c.gender_index_raw c.std_father_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate#c.gender_index_raw i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe i.gender i.country#i.gender if  original_sample==1 , save(`dataout'\Table13.doc) title(Table 13- Gender Inequality Index (GII)) vce(cluster coupleid) nest cnames(All children) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender i.country_birth_fe   _cons) add(Gender Control, YES, Country*Gender FE, YES, BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate#c.gender_index_raw c.std_father_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate#c.gender_index_raw i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 , save(`dataout'\Table13.doc) title(Table 13- Gender Inequality Index (GII)) vce(cluster coupleid) nest cnames(Daughters) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender i.country_birth_fe  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate#c.gender_index_raw c.std_father_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate#c.gender_index_raw i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & original_sample==1 , save(`dataout'\Table13.doc) title(Table 13- Gender Inequality Index (GII)) vce(cluster coupleid) nest cnames(Sons) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender i.country_birth_fe  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, YES,) dec(3) tzok label 


*TABLE 14:
corr gender_index_raw political_raw business_raw if country!=23 & country!=25 & country!=30 & country!=31 & original_sample==1

*Sample= Belgium, Ireland, Luxembourg and Israel are excluded from the sample.
*TABLE 16: Gender Inequality Index & World Value Surveys

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate#c.gender_index_raw c.std_father_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate#c.gender_index_raw i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if country!=23 & country!=25 & country!=30 & country!=31 & gender==2 & original_sample==1 , replace save(`dataout'\Table16.doc) title(Table 16- GII & World Value Survey) vce(cluster coupleid)  nest cnames(Norm1) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add( Birth Cohort FE, YES, Country FE, YES, Birth Cohort*Country FE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate#c.political_raw c.std_father_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate#c.political_raw i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 , save(`dataout'\Table16.doc) title(Table 16- GII & World Value Survey) vce(cluster coupleid) nest cnames(Norm2) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add( Birth Cohort FE, YES, Country FE, YES, Birth Cohort*Country FE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate#c.business_raw c.std_father_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate#c.business_raw i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 , save(`dataout'\Table16.doc) title(Table 16- GII & World Value Survey) vce(cluster coupleid) nest cnames(Norm3) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add( Birth Cohort FE, YES, Country FE, YES, Birth Cohort*Country FE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate#c.gender_index_raw c.std_father_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate#c.gender_index_raw i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if country!=23 & country!=25 & country!=30 & country!=31 & gender==1 & original_sample==1 , save(`dataout'\Table16.doc) title(Table 16- GII & World Value Survey) vce(cluster coupleid) nest cnames(Norm1) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add( Birth Cohort FE, YES, Country FE, YES, Birth Cohort*Country FE, YES,) dec(3) tzok label

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate#c.political_raw c.std_father_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate#c.political_raw i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & original_sample==1 , save(`dataout'\Table16.doc) title(Table 16- GII & World Value Survey) vce(cluster coupleid) nest cnames(Norm2) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add( Birth Cohort FE, YES, Country FE, YES, Birth Cohort*Country FE, YES,) dec(3) tzok label

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate#c.business_raw c.std_father_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate#c.business_raw i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & original_sample==1 , save(`dataout'\Table16.doc) title(Table 16- GII & World Value Survey)  vce(cluster coupleid) nest cnames(Norm3) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add( Birth Cohort FE, YES, Country FE, YES, Birth Cohort*Country FE, YES,) dec(3) tzok label



** Models with Father's Education Levels
*Bargaining = maternal educ/ paternal educ
*Sample= All sample

*TABLE 17: Father’s education status

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate  c.std_mother_median#c.bargaining1_rate  c.std_mother_median#c.bargaining1_rate#i.father_educ_dummy c.std_father_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate#i.father_educ_dummy i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.gender i.country#i.gender if  original_sample==1 , replace save(`dataout'\Table17.doc) title(Table 17- Father's education status) vce(cluster coupleid) nest cnames(All children) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, YES, Country*Gender FE, YES, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate#i.father_educ_dummy c.std_father_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate#i.father_educ_dummy i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  if   gender==2 & original_sample==1 , save(`dataout'\Table17.doc) title(Table 17- Father's education status) vce(cluster coupleid) nest cnames(Daughters) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate#i.father_educ_dummy c.std_father_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate#i.father_educ_dummy i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  if  gender==1 & original_sample==1 , save(`dataout'\Table17.doc) title(Table 17- Father's education status) vce(cluster coupleid) nest cnames(Sons) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, NO,) dec(3) tzok label

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate#i.father_educ_dummy c.std_father_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate#i.father_educ_dummy i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe i.gender i.country#i.gender if  original_sample==1 , save(`dataout'\Table17.doc) title(Table 17- Father's education status) vce(cluster coupleid) nest cnames(All children) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender i.country_birth_fe  _cons) add(Gender Control, YES, Country*Gender FE, YES, BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_mother_median#c.bargaining1_rate#i.father_educ_dummy c.std_father_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate#i.father_educ_dummy i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 , save(`dataout'\Table17.doc) title(Table 17- Father's education status) vce(cluster coupleid) nest cnames(Daughters) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender i.country_birth_fe  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, YES,) dec(3) tzok label

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate  c.std_mother_median#c.bargaining1_rate#i.father_educ_dummy c.std_father_median#c.bargaining1_rate  c.std_father_median#c.bargaining1_rate#i.father_educ_dummy i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & original_sample==1 , save(`dataout'\Table17.doc) title(Table 17- Father's education status)  vce(cluster coupleid) nest cnames(Sons) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender i.country_birth_fe _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, YES,) dec(3) tzok label




** Models for robustness check
*Bargaining dummy= maternal educ> paternal educ
*Sample= All sample

*Table 10
asdoc regress std_child_median std_mother_median std_father_median i.bargaining1 c.std_mother_median#i.bargaining1 c.std_father_median#i.bargaining1  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.gender i.country#i.gender  if  original_sample==1, replace save(`dataout'\Table10.doc) title(Table 10- ) vce(cluster coupleid) nest cnames(All children) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, YES, Country*Gender FE, YES, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median i.bargaining1 c.std_mother_median#i.bargaining1 c.std_father_median#i.bargaining1 i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  if   gender==2 & original_sample==1 , save(`dataout'\Table10.doc) title(Table 10- )  vce(cluster coupleid) nest cnames(Daughters) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, NO,) dec(3) tzok label

asdoc regress std_child_median std_mother_median std_father_median i.bargaining1 c.std_mother_median#i.bargaining1 c.std_father_median#i.bargaining1 i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  if  gender==1 & original_sample==1 , save(`dataout'\Table10.doc) title(Table 10- ) vce(cluster coupleid) nest cnames(Sons) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median i.bargaining1 c.std_mother_median#i.bargaining1 c.std_father_median#i.bargaining1 i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe i.gender i.country#i.gender if  original_sample==1 , save(`dataout'\Table10.doc) title(Table 10- ) vce(cluster coupleid) nest cnames(All children) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  i.country_birth_fe i.gender _cons) add( Gender Control, YES, Country*Gender FE, YES, BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median i.bargaining1 c.std_mother_median#i.bargaining1 c.std_father_median#i.bargaining1  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & original_sample==1 , save(`dataout'\Table10.doc) title(Table 10- ) vce(cluster coupleid) nest cnames(Daughters) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender i.country_birth_fe i.gender _cons) add( Gender Control, NO, Country*Gender FE, NO, BC*CFE, YES,) dec(3) tzok label  

asdoc regress std_child_median std_mother_median std_father_median i.bargaining1 c.std_mother_median#i.bargaining1 c.std_father_median#i.bargaining1 i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & original_sample==1 , save(`dataout'\Table10.doc) title(Table 10- ) vce(cluster coupleid) nest cnames(Sons) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  i.country_birth_fe i.gender _cons) add( Gender Control, NO, Country*Gender FE, NO, BC*CFE, YES,) dec(3) tzok label 


** Models with weights
**Bargaining = maternal educ/ paternal educ
*Sample= All sample
*TABLE A3: Weights

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate  c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & bargaining1_rate!=. , replace save(`dataout'\TableA3.doc) title(Table A3- ) vce(cluster coupleid)  nest cnames(W0) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add(Birth Cohort*Country FE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate  c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe [aweight = std_design_weight] if gender==2 & bargaining1_rate!=. , save(`dataout'\TableA3.doc) title(Table A3- ) vce(cluster coupleid) nest cnames(W1) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add(Birth Cohort*Country FE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate  c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe [aweight = weight_2] if gender==2 & bargaining1_rate!=. , save(`dataout'\TableA3.doc) title(Table A3- ) vce(cluster coupleid) nest cnames(W2) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add(Birth Cohort*Country FE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate  c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe [aweight = weight_3] if gender==2 & bargaining1_rate!=. , save(`dataout'\TableA3.doc) title(Table A3- ) vce(cluster coupleid) nest cnames(W3) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add(Birth Cohort*Country FE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate  c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & bargaining1_rate!=. , save(`dataout'\TableA3.doc) title(Table A3- ) vce(cluster coupleid) nest cnames(W0) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add(Birth Cohort*Country FE, YES,) dec(3) tzok label

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate  c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe [aweight = std_design_weight] if  gender==1 & bargaining1_rate!=. , save(`dataout'\TableA3.doc) title(Table A3- ) vce(cluster coupleid) nest cnames(W1) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add(Birth Cohort*Country FE, YES,) dec(3) tzok label

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate  c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe [aweight = weight_2] if  gender==1 & bargaining1_rate!=. , save(`dataout'\TableA3.doc) title(Table A3- ) vce(cluster coupleid) nest cnames(W2) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add(Birth Cohort*Country FE, YES,) dec(3) tzok label

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate  c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe [aweight = weight_3] if  gender==1 & bargaining1_rate!=. , save(`dataout'\TableA3.doc) title(Table A3- ) vce(cluster coupleid) nest cnames(W3) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add(Birth Cohort*Country FE, YES,) dec(3) tzok label



**MODEL 4 -related tables
*Bargaining = maternal education/ paternal education
*Sample= Wage sample

*Table 4- orjinal model
asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.gender i.country#i.gender  if  wage_sample4==1, replace save(`dataout'\Table4.doc) title(Table 4-) vce(cluster coupleid) nest cnames(All children) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, YES, Country*Gender FE, YES, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  if   gender==2 & wage_sample4==1 , save(`dataout'\Table4.doc) title(Table 4-) vce(cluster coupleid) nest cnames(Daughters) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, NO,) dec(3) tzok label

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  if  gender==1 & wage_sample4==1 , save(`dataout'\Table4.doc) title(Table 4-) vce(cluster coupleid) nest cnames(Sons) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe i.gender i.country#i.gender if  wage_sample4==1 , save(`dataout'\Table4.doc) title(Table 4-) vce(cluster coupleid) nest cnames(All children) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  i.country_birth_fe i.gender _cons) add( Gender Control, YES, Country*Gender FE, YES, BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & wage_sample4==1 , save(`dataout'\Table4.doc) title(Table 4-) vce(cluster coupleid) nest cnames(Daughters) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender i.country_birth_fe i.gender _cons) add( Gender Control, NO, Country*Gender FE, NO, BC*CFE, YES,) dec(3) tzok label  

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & wage_sample4==1 , save(`dataout'\Table4.doc) title(Table 4-) vce(cluster coupleid) nest cnames(Sons) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  i.country_birth_fe i.gender _cons) add( Gender Control, NO, Country*Gender FE, NO, BC*CFE, YES,) dec(3) tzok label 



*Table 4 v6-new (additional controls for family backgrounds)
asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & wage_sample4==1 , replace save(`dataout'\Table4v6.doc) title(Table 4-v6) vce(cluster coupleid) nest cnames(Daughters) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe  _cons) add(BC*CFE, YES,) dec(3) tzok label  

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort mother_lfs_total i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if wage_sample4==1 & gender==2  , save(`dataout'\Table4v6.doc) title(Table 4-v6) vce(cluster coupleid) nest cnames(Daughters) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe  _cons) add(BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate log_family_income_euro mother_lfs_total i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if wage_sample4==1 & gender==2  , save(`dataout'\Table4v6.doc) title(Table 4-v6) vce(cluster coupleid) nest cnames(Daughters) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add(BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate maks_number_child log_family_income_euro mother_lfs_total i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if wage_sample4==1 & gender==2 , save(`dataout'\Table4v6.doc) title(Table 4-v6) vce(cluster coupleid) nest cnames(Daughters) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add(BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & wage_sample4==1 , save(`dataout'\Table4v6.doc) title(Table 4-v6) vce(cluster coupleid) nest cnames(Sons) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe  _cons) add(BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate  i.child_birth_cohort mother_lfs_total i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if wage_sample4==1 &  gender==1  , save(`dataout'\Table4v6.doc) title(Table 4-v6) vce(cluster coupleid) nest cnames(Sons) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add(BC*CFE, YES,) dec(3) tzok label

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate log_family_income_euro mother_lfs_total i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if wage_sample4==1 &  gender==1  , save(`dataout'\Table4v6.doc) title(Table 4-v6) vce(cluster coupleid) nest cnames(Sons) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe _cons) add(BC*CFE, YES,) dec(3) tzok label

asdoc regress std_child_median std_mother_median std_father_median c.bargaining1_rate c.std_mother_median#c.bargaining1_rate c.std_father_median#c.bargaining1_rate maks_number_child log_family_income_euro mother_lfs_total i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if wage_sample4==1 &  gender==1  , save(`dataout'\Table4v6.doc) title(Table 4-v6) vce(cluster coupleid) nest cnames(Sons) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add(BC*CFE, YES,) dec(3) tzok label



**MODEL 7 -related tables
*Bargaining = maternal wage income/ paternal wage income
*Sample= Wage sample

*Table 7-v4 original model without controlling log family income
asdoc regress std_child_median std_mother_median std_father_median c.bargaining_wage c.std_mother_median#c.bargaining_wage c.std_father_median#c.bargaining_wage  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.gender i.country#i.gender  if  wage_sample4==1, replace save(`dataout'\Table7.doc) title(Table 7-) vce(cluster coupleid) nest cnames(All children) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, YES, Country*Gender FE, YES, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining_wage c.std_mother_median#c.bargaining_wage c.std_father_median#c.bargaining_wage i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  if   gender==2 & wage_sample4==1 , save(`dataout'\Table7.doc) title(Table 7-) vce(cluster coupleid) nest cnames(Daughters) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, NO,) dec(3) tzok label

asdoc regress std_child_median std_mother_median std_father_median c.bargaining_wage c.std_mother_median#c.bargaining_wage c.std_father_median#c.bargaining_wage  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  if  gender==1 & wage_sample4==1 , save(`dataout'\Table7.doc) title(Table 7-) vce(cluster coupleid) nest cnames(Sons) drop(i.gender i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  _cons) add(Gender Control, NO, Country*Gender FE, NO, BC*CFE, NO,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining_wage c.std_mother_median#c.bargaining_wage c.std_father_median#c.bargaining_wage  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe i.gender i.country#i.gender if  wage_sample4==1 , save(`dataout'\Table7.doc) title(Table 7-) vce(cluster coupleid) nest cnames(All children) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  i.country_birth_fe i.gender _cons) add( Gender Control, YES, Country*Gender FE, YES, BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining_wage c.std_mother_median#c.bargaining_wage c.std_father_median#c.bargaining_wage  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & wage_sample4==1 , save(`dataout'\Table7.doc) title(Table 7-) vce(cluster coupleid) nest cnames(Daughters) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender i.country_birth_fe i.gender _cons) add( Gender Control, NO, Country*Gender FE, NO, BC*CFE, YES,) dec(3) tzok label  

asdoc regress std_child_median std_mother_median std_father_median c.bargaining_wage c.std_mother_median#c.bargaining_wage c.std_father_median#c.bargaining_wage  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & wage_sample4==1 , save(`dataout'\Table7.doc) title(Table 7-) vce(cluster coupleid) nest cnames(Sons) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country#i.gender  i.country_birth_fe i.gender _cons) add( Gender Control, NO, Country*Gender FE, NO, BC*CFE, YES,) dec(3) tzok label 


*Table A4-new (additional controls for family backgrounds)
asdoc regress std_child_median std_mother_median std_father_median c.bargaining_wage c.std_mother_median#c.bargaining_wage c.std_father_median#c.bargaining_wage  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if gender==2 & wage_sample4==1 , replace save(`dataout'\TableA4.doc) title(Table A4-new) vce(cluster coupleid) nest cnames(Daughters) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe  _cons) add(BC*CFE, YES,) dec(3) tzok label  

asdoc regress std_child_median std_mother_median std_father_median c.bargaining_wage c.std_mother_median#c.bargaining_wage c.std_father_median#c.bargaining_wage  i.child_birth_cohort mother_lfs_total i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if wage_sample4==1 & gender==2  , save(`dataout'\TableA4.doc) title(Table A4-new) vce(cluster coupleid) nest cnames(Daughters) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe  _cons) add(BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining_wage c.std_mother_median#c.bargaining_wage c.std_father_median#c.bargaining_wage log_family_income_euro mother_lfs_total i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if wage_sample4==1 & gender==2  , save(`dataout'\TableA4.doc) title(Table A4-new) vce(cluster coupleid) nest cnames(Daughters) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add(BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining_wage c.std_mother_median#c.bargaining_wage c.std_father_median#c.bargaining_wage maks_number_child log_family_income_euro mother_lfs_total i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if wage_sample4==1 & gender==2 , save(`dataout'\TableA4.doc) title(Table A4-new) vce(cluster coupleid) nest cnames(Daughters) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add(BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining_wage c.std_mother_median#c.bargaining_wage c.std_father_median#c.bargaining_wage  i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if  gender==1 & wage_sample4==1 , save(`dataout'\TableA4.doc) title(Table A4-new) vce(cluster coupleid) nest cnames(Sons) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe  _cons) add(BC*CFE, YES,) dec(3) tzok label 

asdoc regress std_child_median std_mother_median std_father_median c.bargaining_wage c.std_mother_median#c.bargaining_wage c.std_father_median#c.bargaining_wage  i.child_birth_cohort mother_lfs_total i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if wage_sample4==1 &  gender==1  , save(`dataout'\TableA4.doc) title(Table A4-new) vce(cluster coupleid) nest cnames(Sons) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add(BC*CFE, YES,) dec(3) tzok label

asdoc regress std_child_median std_mother_median std_father_median c.bargaining_wage c.std_mother_median#c.bargaining_wage c.std_father_median#c.bargaining_wage log_family_income_euro mother_lfs_total i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if wage_sample4==1 &  gender==1  , save(`dataout'\TableA4.doc) title(Table A4-new) vce(cluster coupleid) nest cnames(Sons) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe _cons) add(BC*CFE, YES,) dec(3) tzok label

asdoc regress std_child_median std_mother_median std_father_median c.bargaining_wage c.std_mother_median#c.bargaining_wage c.std_father_median#c.bargaining_wage maks_number_child log_family_income_euro mother_lfs_total i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country  i.country_birth_fe if wage_sample4==1 &  gender==1  , save(`dataout'\TableA4.doc) title(Table A4-new) vce(cluster coupleid) nest cnames(Sons) drop(i.child_birth_cohort i.father_birth_cohort i.mother_birth_cohort i.country i.country_birth_fe  _cons) add(BC*CFE, YES,) dec(3) tzok label



** Correlation between bargaining clusters and child birth cohort
    preserve
	keep if original_sample==1
	sort country
	by country : gen corr_obs = _N	
	gen corr_weight= 1/corr_obs
	asdoc regress bargaining1_rate child_birth_cohort [aw=corr_weight],  replace save(`dataout'\Table Correlation.doc) title(Table Correlation) robust nest cnames(All) drop(_cons) dec(3) tzok label
	asdoc regress bargaining1_rate child_birth_cohort [aw=corr_weight] if  gender==2,  save(`dataout'\Table Correlation.doc) title(Table Correlation) robust  nest cnames(Daughters) drop(_cons) dec(3) tzok label
	asdoc regress bargaining1_rate child_birth_cohort [aw=corr_weight] if  gender==1,  save(`dataout'\Table Correlation.doc) title(Table Correlation) robust nest cnames(Sons) drop(_cons) dec(3) tzok label
	
	asdoc regress bargaining1_rate child_birth_cohort [aw=corr_weight], replace save(`dataout'\Table Correlation2.doc) title(Table Correlation) vce(cluster child_birth_cohort) nest cnames(All) drop(_cons) dec(3) tzok label
	asdoc regress bargaining1_rate child_birth_cohort [aw=corr_weight] if  gender==2,  save(`dataout'\Table Correlation2.doc) title(Table Correlation) vce(cluster child_birth_cohort) nest cnames(Daughters) drop(_cons) dec(3) tzok label
	asdoc regress bargaining1_rate child_birth_cohort [aw=corr_weight] if  gender==1,  save(`dataout'\Table Correlation2.doc) title(Table Correlation) vce(cluster child_birth_cohort) nest cnames(Sons) drop(_cons) dec(3) tzok label
	restore
	
	
/*==============================================================================
                       2: Descriptive Statistics
==============================================================================*/

preserve
keep if original_sample==1
gen number_of_observations=1
collapse (sum)number_of_observations (mean)child_median_1 (mean)mother_median_1 (mean)father_median_1 (mean)year_birth (mean)mother_year (mean)father_year,  by(country) 
export excel using "`dataout'\descriptive statistics.xlsx", sheet(AX) replace firstrow(variables)
restore


***Descriptive Statistics
**Panel A

*All sample
sum year_birth if original_sample==1 & gender==2
sum year_birth if original_sample==1 & gender==1
sum child_median_1 if original_sample==1 & gender==2
sum child_median_1 if original_sample==1 & gender==1
sum mother_median_1 if original_sample==1
sum father_median_1 if original_sample==1

*Wage sample
sum year_birth if wage_sample4==1 & gender==2 
sum year_birth if wage_sample4==1 & gender==1 
sum child_median_1 if wage_sample4==1 & gender==2 
sum child_median_1 if wage_sample4==1 & gender==1 
sum mother_median_1 if wage_sample4==1 
sum father_median_1 if wage_sample4==1 

**Panel B
*All sample
tab c_education3_level if original_sample==1 & gender==2
tab c_education3_level if original_sample==1 & gender==1
tab m_education3_level if original_sample==1
tab f_education3_level if original_sample==1 

*Wage sample
tab c_education3_level if  gender==2 & wage_sample4==1
tab c_education3_level if  gender==1 & wage_sample4==1
tab m_education3_level if  wage_sample4==1
tab f_education3_level if  wage_sample4==1

**Panel C

*All sample
sum bargaining1_rate if  original_sample==1
sum bargaining1 if  original_sample==1

*Wage sample
sum bargaining1_rate if wage_sample4==1 
sum bargaining1 if wage_sample4==1 
sum bargaining_wage if wage_sample4==1 

**Male ratio
preserve 
replace gender=0 if gender==2 
sum gender if original_sample==1
sum gender if wage_sample4==1
restore

/*==============================================================================
                      3: Models with household fixed effects
==============================================================================*/
preserve

  // sort data by country and coupleid, and keep only main sample
sort country coupleid
keep if original_sample==1

 // identify girls and boys
bysort coupleid: gen girl=(gender==2)
bysort coupleid: gen boy=(gender==1)

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

 // create a dummy for sex
gen sex=(gender==1)

**Table 18 
*Bargaining = maternal education/ paternal education
*Sample= Children which live in households where there is at least one child in each sex.

/*
1.	Gender + ME*Gender + PE*Gender+Bargaining*Gender+ME*BP*Gender + PE*BP*Gender +i.householdid   (cluster at household id)
2.	Gender + ME*Gender + PE*Gender+Bargaining*Gender+ME*BP*Gender + PE*BP*Gender +i.householdid   + Parent Cohort*Gender + Child Cohort*Gender + Country * Gender
*/

cd "C:\Users\WB586966\OneDrive - WBG\Desktop\Revized do_files_05.09"
   local do "C:\Users\WB586966\OneDrive - WBG\Desktop\Revized do_files_05.09\DO-Files"
   local figures "C:\Users\WB586966\OneDrive - WBG\Desktop\Revized do_files_05.09\Figures"
   local dataout "C:\Users\WB586966\OneDrive - WBG\Desktop\Revized do_files_05.09\Data_Out"

 keep if rank <=1000 
 /*
*Table 1- original model
asdoc regress std_child_median i.sex i.sex#c.std_mother_median i.sex#c.std_father_median i.sex#c.bargaining1_rate i.sex#c.std_mother_median#c.bargaining1_rate i.sex#c.std_father_median#c.bargaining1_rate i.rank if  original_sample==1, replace save(`dataout'\Table18.doc) title(Table 18) vce(cluster rank) nest cnames(1) drop(i.rank _cons) add(Household FE, YES) dec(3) tzok label 
*/


asdoc regress std_child_median i.sex i.sex#c.bargaining1_rate i.sex#c.std_mother_median#c.bargaining1_rate  i.sex#c.std_father_median#c.bargaining1_rate  i.rank if  original_sample==1, replace save(`dataout'\Table18.doc) title(Table 18) vce(cluster rank) nest cnames(1) drop(i.rank _cons) add(Household FE, YES) dec(3) tzok label 


/*
asdoc regress std_child_median i.sex i.sex#c.std_mother_median i.sex#c.std_father_median i.sex#c.bargaining1_rate i.sex#c.std_mother_median#c.bargaining1_rate i.sex#c.std_father_median#c.bargaining1_rate i.rank i.country#i.sex i.child_birth_cohort#i.sex  i.father_birth_cohort#i.sex  i.mother_birth_cohort#i.sex if  original_sample==1, replace save(`dataout'\Table18.doc) title(Table 18) vce(cluster rank) nest cnames(2) drop(i.rank i.country#i.sex i.child_birth_cohort#i.sex i.father_birth_cohort#i.sex i.mother_birth_cohort#i.sex _cons) add(Household FE, YES, Country*Gender FE, YES, BC*Gender, YES, PC*Gender, YES,) dec(3) tzok label 
*/
restore

*----------------------------END OF DO FILE-------------------------------------
*-------------------------------------------------------------------------------







