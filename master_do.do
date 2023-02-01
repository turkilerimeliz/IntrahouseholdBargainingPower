/*==============================================================================
Project: Intergenerational Education Mobility and Bargaining Power

Author:
--------------------------------------------------------------------------------
Creation Date:
Modification Date:
Do-file version:
Output:
==============================================================================*/

drop _all
clear all

/*==============================================================================
            0: Set locals and Paths
==============================================================================*/

* Set Directory

cd "C:\Users\WB586966\OneDrive - WBG\Desktop\Revized do_files_10.08"
   local do "C:\Users\WB586966\OneDrive - WBG\Desktop\Revized do_files_10.08\DO-Files"
   local figures "C:\Users\WB586966\OneDrive - WBG\Desktop\Revized do_files_10.08\Figures"
   local dataout "C:\Users\WB586966\OneDrive - WBG\Desktop\Revized do_files_10.08\Data_Out"

* Set Temporary Files

tempfile parent1 parent2 parent4 parent5 parent6 parents mergeid mergeidp
tempfile median_yrschl median_yrschl_job
tempfile child1 w1_child1 w1_child2 w1_child3 w1_child4 wave1_child
tempfile child2 w2_child1 w2_child2 w2_child3 w2_child4 wave2_child
tempfile child4 w4_child1 w4_child2 w4_child3 w4_child4 w4_child5 w4_child6 w4_child7 w4_child8 w4_child9 w4_child10 w4_child11 w4_child12 w4_child13 w4_child14 w4_child15 w4_child16 w4_child17 wave4_child
tempfile child5 w5_child1 w5_child2 w5_child3 w5_child4 w5_child5 w5_child6 w5_child7 w5_child8 w5_child9 w5_child10 w5_child11 w5_child12 w5_child13 w5_child14 w5_child15 w5_child16 w5_child17 wave5_child
tempfile child6 w6_child1 w6_child2 w6_child3 w6_child4 w6_child5 w6_child6 w6_child7 w6_child8 w6_child9 w6_child10 w6_child11 w6_child12 w6_child13 w6_child14 w6_child15 w6_child16 w6_child17 w6_child18 w6_child19 w6_child20 wave6_child
tempfile interview_date partner_interview_date children
tempfile childAge_mother childAge_father mother_job_episode mother_job_episode_unmatch father_job_episode father_job_episode_unmatch parents_job_episode Austria_parents_job Germany_parents_job Sweden_parents_job Netherlands_parents_job Spain_parents_job Italy_parents_job France_parents_job Denmark_parents_job Greece_parents_job Switzerland_parents_job Belgium_parents_job Ireland_parents_job Luxembourg_parents_job Portugal_parents_job
tempfile job_episode respondents_w7
tempfile Austria_job_episode Austria_parents_job_2 Belgium_job_episode Belgium_parents_job_2 Denmark_job_episode Denmark_parents_job_2 Germany_job_episode Germany_parents_job_2 France_job_episode France_parents_job_2 Greece_job_episode Greece_parents_job_2 Ireland_job_episode Ireland_parents_job_2 Italy_job_episode Italy_parents_job_2 Luxembourg_job_episode Luxembourg_parents_job_2 Netherlands_job_episode Netherlands_parents_job_2 Portugal_job_episode Portugal_parents_job_2 Spain_job_episode Spain_parents_job_2 Sweden_job_episode Sweden_parents_job_2 Switzerland_job_episode Switzerland_parents_job_2 
tempfile parents_job_episode_2 parents_job_master
tempfile merged_weights


/*==============================================================================
            1: Dataset and Variable Creation - Parents
==============================================================================*/
include "`do'\database_creation_parents.do"


/*==============================================================================
            2: Years of Schooling Imputation
==============================================================================*/
include "`do'\years_schooling.do"

/*==============================================================================
            3:Dataset Creation Children - Wave1 
==============================================================================*/
include "`do'\database_childw1.do"

/*==============================================================================
            4:Dataset Creation Children - Wave2 
==============================================================================*/
include "`do'\database_childw2.do"

/*==============================================================================
            5:Dataset Creation Children - Wave4
==============================================================================*/
include "`do'\database_childw4.do"

/*==============================================================================
            6:Dataset Creation Children - Wave5
==============================================================================*/
include "`do'\database_childw5.do"

/*==============================================================================
            7:Dataset Creation Children - Wave6
==============================================================================*/
include "`do'\database_childw6.do"

/*==============================================================================
            8:Variable Creation - Children 
==============================================================================*/
include "`do'\variable_creation_child.do"

/*==============================================================================
            9:Job History Creation - Parents
==============================================================================*/
include "`do'\job_history_parents.do"
 
/*==============================================================================
            10: Dataset Creation for Age-Earning Profiles
==============================================================================*/
include "`do'\job_episode.do"
 
/*==============================================================================
            11: Variable Creation for Age-Earning Profiles
==============================================================================*/
include "`do'\job_episode_country.do"
 
/*==============================================================================
            12: Variable Creation Family Backgrounds
==============================================================================*/
include "`do'\family_background.do"
 
 
/*==============================================================================
            13: Dataset Construction Weights
==============================================================================*/
include "`do'\weights.do"
 
/*==============================================================================
            14: Master Dataset Creation
==============================================================================*/
include "`do'\master_dataset.do"
 
   
/*==============================================================================
            15: Results
==============================================================================*/
include "`do'\results.do"
 

/*==============================================================================
            16: Figures
==============================================================================*/
include "`do'\figures.do"
 
exit
