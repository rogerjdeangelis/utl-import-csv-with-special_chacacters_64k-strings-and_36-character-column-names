Import csv with special_chacacters 64k strings and 36 character column names;                                                                                  
                                                                                                                                                               
github                                                                                                                                                         
https://tinyurl.com/y2dl8emw                                                                                                                                   
https://github.com/rogerjdeangelis/utl-import-csv-with-special_chacacters_64k-strings-and_36-character-column-names                                            
                                                                                                                                                               
github input CSV file                                                                                                                                          
https://tinyurl.com/yyxh479a                                                                                                                                   
https://github.com/rogerjdeangelis/utl-import-csv-with-special_chacacters_64k-strings-and_36-character-column-names/blob/master/eDiary_small.csv               
                                                                                                                                                               
SAS Forum                                                                                                                                                      
https://tinyurl.com/y3owmvwx                                                                                                                                   
https://communities.sas.com/t5/SAS-Programming/Reading-a-csv-file-with-records-length-more-than-33-000/m-p/678395                                              
                                                                                                                                                               
Best with classic editor because of full screen procs do not work in other editord, like EG.                                                                   
                                                                                                                                                               
  This is a very complex CSV file, see csv issues below.                                                                                                       
  This code should help you read the most problematic CSVs.                                                                                                    
                                                                                                                                                               
  Note:                                                                                                                                                        
        R and Python dataframes handle variable names longer that 32 characters                                                                                
        R and Python handle longer then 32k strings (in fact an entire file)                                                                                   
                                                                                                                                                               
  Two solutions (R and Python)                                                                                                                                 
                                                                                                                                                               
      a. R and SAS                                                                                                                                             
         Drop mysql table if it exists (we use mysql to send data from R to SAS)                                                                               
         Translate special character cicumflex A to A (cannot set utf-8 in R?)                                                                                 
         Convert the csv to an R dataframe (force all columns to be character)                                                                                 
         Export the dataframe to MysSQL                                                                                                                        
         Find the variables whose lengths are greater than 32757                                                                                               
         Split the lontext variables into mutiple 32k pieces                                                                                                   
         convert MySQL table to SAS table                                                                                                                      
         run utl_optlen to optimize variable lengths                                                                                                           
                                                                                                                                                               
      b. Pytyhon and SAS (Only the python code changes)                                                                                                        
         Drop mysql table if it exists (we use mysql to send data from Python to SAS)                                                                          
         No neeed to translate cicumflex A (handles the encoding of cicumflex A                                                                                
         Convert the csv to an Pandas dataframe (force all columns to be character)                                                                            
         Export the dataframe to MysSQL                                                                                                                        
         Find the variables whose lengths are greater than 32757                                                                                               
         Split the lontext variables into mutiple 32k pieces                                                                                                   
         convert MySQL table to SAS table                                                                                                                      
         run utl_optlen to optimize variable lengths                                                                                                           
                                                                                                                                                               
This solution requires                                                                                                                                         
                                                                                                                                                               
  1. MySQL                                                                                                                                                     
                                                                                                                                                               
  2. Macros                                                                                                                                                    
                                                                                                                                                               
       array                                                                                                                                                   
       do_over                                                                                                                                                 
       utl_optlen                                                                                                                                              
       arraydelet                                                                                                                                              
                                                                                                                                                               
/*                _                                                                                                                                            
  ___ _____   __ (_)___ ___ _   _  ___  ___                                                                                                                    
 / __/ __\ \ / / | / __/ __| | | |/ _ \/ __|                                                                                                                   
| (__\__ \\ V /  | \__ \__ \ |_| |  __/\__ \                                                                                                                   
 \___|___/ \_/   |_|___/___/\__,_|\___||___/                                                                                                                   
                                                                                                                                                               
*/                                                                                                                                                             
                                                                                                                                                               
Potential csv file issues                                                                                                                                      
                                                                                                                                                               
  1. The quoted string "100.0..F" has a embeded 'C2'x which is cicumflex A.                                                                                    
     Note: Yoy don't have to do this with Python                                                                                                               
                                                                                                                                                               
    I need to convert cicumflex A to 'A' prior to importing                                                                                                    
                                                                                                                                                               
      "100.0..F"                                                                                                                                               
      5...40  .    .   .4                                                                                                                                      
      233323  C    B   42                                                                                                                                      
      2100E0  2    0   62                                                                                                                                      
              |    |                                                                                                                                           
              |    V                                                                                                                                           
              V    degree symbol part of ascii ok                                                                                                              
         Circumflex A                                                                                                                                          
                                                                                                                                                               
  2. Embeded commas                                                                                                                                            
                                                                                                                                                               
     "Grade the severity of muscle aches experienced in the last 24 hours, based on the descriptions below:"                                                   
                                                                                                                                                               
     2476662766276767677266267766626666726776766666626627662667723326677722667662662766266767677666726666732                                                   
     27214504850356529490F60D533C501385305805295E35409E04850C13402408F523C0213540FE04850453329049FE3025CF7A2                                                   
                                                                                                                                                               
  3. Some of the column names are over 32 characters                                                                                                           
                                                                                                                                                               
     VTR4_CROSS_REFERENCE_SUBJECT_ID__C                                                                                                                        
                                                                                                                                                               
  4. Strings longer than 32k                                                                                                                                   
                                                                                                                                                               
                                                                                                                                                               
/*                   _                                                                                                                                         
(_)_ __  _ __  _   _| |_                                                                                                                                       
| | `_ \| `_ \| | | | __|                                                                                                                                      
| | | | | |_) | |_| | |_                                                                                                                                       
|_|_| |_| .__/ \__,_|\__|                                                                                                                                      
        |_|                                                                                                                                                    
*/                                                                                                                                                             
                                                                                                                                                               
                                                                                                                                                               
d:/csv/eDiary_small.csv (also in github)                                                                                                                       
                                                                                                                                                               
                                                                                                                                                               
"VTD2_STUDY_NICKNAME__C","VTR4_CROSS_REFERENCE_SUBJECT_ID__C","ANSWER_ID","DIAR..."VTR4_PERCENTAGE_COMPLETED__C"                                               
"AZD1222 COVID-19 VACCINE","3652984-265","a2Y0r000ASPoEA38","a2Y0r000ASPoEA38",...Site Coordinator","19","270","100"                                           
"AZD1222 COVID-19 VACCINE","3652984-265","a2Y0r000ASPoEA39","a2Y0r000ASPoEA39",...1test1test1test11test1test1test1test1test1test1test1test1test1test1te        
"AZD1222 COVID-19 VACCINE","3652984-265","a2Y0r000ASPoEA4","","Symptoms Associa...Coordinator","19","270","100"                                                
"AZD1222 COVID-19 VACCINE","3652984-265","a2Y0r000ASPoEA40","a2Y0r000ASPoEA40",...t1test1test1test1test1test1test1test1test11test1test1test1test1test1t        
"AZD1222 COVID-19 VACCINE","3652984-265","a2Y0r000ASPoEA41","a2Y0r000ASPoEA41",...est1test1test1test11test1test1test1test1test1test1test1test1test1test        
"AZD1222 COVID-19 VACCINE","3652984-265","a2Y0r000ASPoEA42","a2Y0r000ASPoEA42",.. ator","19","270","100"                                                       
                                                                                                                                                               
/*           _               _                                                                                                                                 
  ___  _   _| |_ _ __  _   _| |_                                                                                                                               
 / _ \| | | | __| `_ \| | | | __|                                                                                                                              
| (_) | |_| | |_| |_) | |_| | |_                                                                                                                               
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                                              
                |_|                                                                                                                                            
*/                                                                                                                                                             
                                                                                                                                                               
WORK.WANT                               NOTE These are max lengths in the entire table                                                                         
                                                                                                                                                               
ANSWER_ID                          Char       16                                                                                                               
CREATEDDATE                        Char       25                                                                                                               
DIARY_ID                           Char       16                                                                                                               
NAME                               Char       33                                                                                                               
                                                                                                                                                               
VTD1_ANSWER1                       Char    32757  ** Split into two strings                                                                                    
VTD1_ANSWER2                       Char        3                                                                                                               
                                                                                                                                                               
VTD1_COMPLETION_TIME               Char       24                                                                                                               
VTD1_DATE_AVAILABLE                Char       24                                                                                                               
VTD1_DUE_DATE                      Char       24                                                                                                               
VTD1_NUMBER_OF_ANSWERS             Char        2                                                                                                               
VTD1_NUMBER_OF_SCORED_ANSWERS      Char        2                                                                                                               
VTD1_REMINDER_DUE_DATE             Char       24                                                                                                               
VTD1_REMINDER_WINDOW               Char        1                                                                                                               
VTD1_STATUS                        Char       30                                                                                                               
VTD1_SURVEY                        Char       19                                                                                                               
VTD2_PATIENT_S_DUE_TIME            Char       24                                                                                                               
VTD2_PATIENT_S_NUMERIC_TIMEZONE    Char       19                                                                                                               
VTD2_STUDY_NICKNAME                Char       24                                                                                                               
VTR2_DOC_LANGUAGE                  Char        5                                                                                                               
                                                                                                                                                               
VTR2_ENGLISH_ANSWER1               Char    32757  ** Split into two strings                                                                                    
VTR2_ENGLISH_ANSWER2               Char        3                                                                                                               
                                                                                                                                                               
VTR2_NUMBER_OF_ANSWERED_ANSWERS    Char        2                                                                                                               
                                                                                                                                                               
VTR2_QUESTION_CONTENT1             Char    32757  ** Split into two strings                                                                                    
VTR2_QUESTION_CONTENT2             Char        3                                                                                                               
                                                                                                                                                               
VTR2_REVIEWER_USER                 Char       16                                                                                                               
VTR2_TOTAL_SCORE                   Char        3                                                                                                               
VTR4_CROSS_REFERENCE_SUBJECT_ID    Char       11                                                                                                               
VTR4_PERCENTAGE_COMPLETED          Char        3                                                                                                               
                                                                                                                                                               
                                                                                                                                                               
SAMPLE OF WANT                                                                                                                                                 
                                                                                                                                                               
                               VTR4_CROSS_                                                                                                                     
                               REFERENCE_                                                                                                                      
Obs   VTD2_STUDY_NICKNAME      SUBJECT_ID  .. VTD1_ANSWER1                  VTD1_ANSWER1   ..                                                                  
                                                                                                                                                               
 1  AZD1222 COVID-19 VACCINE   3652984-265 .. 3 (Severe): Signific                         ..                                                                  
 2  AZD1222 COVID-19 VACCINE   3652984-265 .. testtest1test1test1t==>32k    tes ==> 3 more ..                                                                  
 3  AZD1222 COVID-19 VACCINE   3652984-265 .. 100.0A<U+00B0>F                              ..                                                                  
 4  AZD1222 COVID-19 VACCINE   3652984-265 .. 0 (None): No body ac                         ..                                                                  
 5  AZD1222 COVID-19 VACCINE   3652984-265 .. 1 (Mild): No interfe                         ..                                                                  
 6  AZD1222 COVID-19 VACCINE   3652984-265 .. 2 (Moderate): Some i                         ..                                                                  
                                                                                                                                                               
                                                                                                                                                               
/*         _       _   _                                                                                                                                       
 ___  ___ | |_   _| |_(_) ___  _ __  ___                                                                                                                       
/ __|/ _ \| | | | | __| |/ _ \| `_ \/ __|                                                                                                                      
\__ \ (_) | | |_| | |_| | (_) | | | \__ \                                                                                                                      
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/                                                                                                                      
 ____     ___                                                                                                                                                  
|  _ \   ( _ )    ___  __ _ ___                                                                                                                                
| |_) |  / _ \/\ / __|/ _` / __|                                                                                                                               
|  _ <  | (_>  < \__ \ (_| \__ \                                                                                                                               
|_| \_\  \___/\/ |___/\__,_|___/                                                                                                                               
  __ _                                                                                                                                                         
 / _(_)_  __   ___ _____   __                                                                                                                                  
| |_| \ \/ /  / __/ __\ \ / /                                                                                                                                  
|  _| |>  <  | (__\__ \\ V /                                                                                                                                   
|_| |_/_/\_\  \___|___/ \_/                                                                                                                                    
                                                                                                                                                               
*/                                                                                                                                                             
                                                                                                                                                               
%utlfkil(d:/csv/eDiary_nocirc.csv);                                                                                                                            
                                                                                                                                                               
* DROP MYSQL TABLE IF IT EXISTS;                                                                                                                               
                                                                                                                                                               
proc sql;                                                                                                                                                      
                                                                                                                                                               
   connect to mysql (user=root password=xxxxxxxx database=sakila  port=3306 dbmax_text=32757);                                                                 
       execute (drop table if exists sqldat) by mysql;                                                                                                         
    disconnect from mysql;                                                                                                                                     
                                                                                                                                                               
quit;                                                                                                                                                          
                                                                                                                                                               
* CONVERT CICUMFLEX A TO JUST A;                                                                                                                               
data _null_;                                                                                                                                                   
  infile "d:/csv/eDiary_small.csv" lrecl=100 pad  recfm=f;                                                                                                     
  file "d:/csv/eDiary_nocirc.csv" lrecl=100  recfm=f;                                                                                                          
  input bytchr $char100.;                                                                                                                                      
  bytchr=translate(bytchr,'A','C2'x);                                                                                                                          
  if bytchr='C2'x then putlog bytchr=;                                                                                                                         
  put bytchr $char100.;                                                                                                                                        
run;quit;                                                                                                                                                      
                                                                                                                                                               
/*                                                                                                                                                             
* VERIFY THAT CICUMFLEX IS GONE;                                                                                                                               
* YOU SHOULD SEE "100.0A°F";                                                                                                                                   
* TURN MUBERS ONAND HEX ON IN COMMAND LINE;                                                                                                                    
                                                                                                                                                               
filename fsl 'd:/csv/eDiary_nocirc.csv' lrecl=100000 recfm=v;                                                                                                  
proc fslist file=fsl;                                                                                                                                          
run;quit;                                                                                                                                                      
*/                                                                                                                                                             
                                                                                                                                                               
%utlfkil(d:/xpt/colnam.xpt);                                                                                                                                   
                                                                                                                                                               
proc datasets lib=work nolist;                                                                                                                                 
  delete colnam maxlength max32k want;                                                                                                                         
run;quit;                                                                                                                                                      
                                                                                                                                                               
* LOAD CSV INTO R DATAFRAME;                                                                                                                                   
* GET COLUMN NAMES AND EXPORT TO SAS;                                                                                                                          
* LOAD DATAFRAME INT MYSQL;                                                                                                                                    
                                                                                                                                                               
%utl_submit_r64('                                                                                                                                              
library(SASxport);                                                                                                                                             
library(data.table);                                                                                                                                           
library(RMySQL);                                                                                                                                               
library(readr);                                                                                                                                                
sqldat <- read_csv("d:/csv/eDiary_nocirc.csv",col_types = cols(.default = "c"));                                                                               
colnam<-as.data.table(colnames(sqldat));                                                                                                                       
colnames(colnam)<-"colnam";                                                                                                                                    
con <- dbConnect(MySQL(), user="root", password="xxxxxxxx",dbname="sakila", host="localhost");                                                                 
dbListTables(con);                                                                                                                                             
dbSendQuery(con, "SET GLOBAL local_infile = true;");                                                                                                           
dbWriteTable(con, "sqldat", sqldat, overwrite = TRUE);                                                                                                         
dbDisconnect(con);                                                                                                                                             
write.xport(colnam,file="d:/xpt/colnam.xpt");                                                                                                                  
');                                                                                                                                                            
                                                                                                                                                               
* CREATE SAS DATASET WITH OLD AND SHORTED NEW NAMES;                                                                                                           
                                                                                                                                                               
libname xpt xport "d:/xpt/colnam.xpt";                                                                                                                         
data colnam;                                                                                                                                                   
  set xpt.colnam;                                                                                                                                              
  colCut=prxchange('s/__C//',-1,colnam);                                                                                                                       
run;quit;                                                                                                                                                      
libname xpt clear;                                                                                                                                             
                                                                                                                                                               
/* MAPPINGS                                                                                                                                                    
                                                                                                                                                               
 WORK.COLNAM total obs=25                                                                                                                                      
                                                                                                                                                               
  LONG NAMES COME OVER 23 CHARS         LESS THAT 32 CHARS (drop __C)                                                                                          
                                                                                                                                                               
  COLNAM                                COLCUT                                                                                                                 
                                                                                                                                                               
  VTD2_STUDY_NICKNAME__C                VTD2_STUDY_NICKNAME                                                                                                    
  VTR4_CROSS_REFERENCE_SUBJECT_ID__C    VTR4_CROSS_REFERENCE_SUBJECT_ID                                                                                        
  ANSWER_ID                             ANSWER_ID                                                                                                              
  DIARY_ID                              DIARY_ID                                                                                                               
  NAME                                  NAME                                                                                                                   
  VTD1_SURVEY__C                        VTD1_SURVEY                                                                                                            
  VTD1_ANSWER__C                        VTD1_ANSWER                                                                                                            
  VTR2_ENGLISH_ANSWER__C                VTR2_ENGLISH_ANSWER                                                                                                    
  VTR2_QUESTION_CONTENT__C              VTR2_QUESTION_CONTENT                                                                                                  
  CREATEDDATE                           CREATEDDATE                                                                                                            
  VTD1_COMPLETION_TIME__C               VTD1_COMPLETION_TIME                                                                                                   
  VTD1_DATE_AVAILABLE__C                VTD1_DATE_AVAILABLE                                                                                                    
  VTD1_DUE_DATE__C                      VTD1_DUE_DATE                                                                                                          
  VTD2_PATIENT_S_DUE_TIME__C            VTD2_PATIENT_S_DUE_TIME                                                                                                
  VTD2_PATIENT_S_NUMERIC_TIMEZONE__C    VTD2_PATIENT_S_NUMERIC_TIMEZONE                                                                                        
  VTD1_STATUS__C                        VTD1_STATUS                                                                                                            
  VTR2_DOC_LANGUAGE__C                  VTR2_DOC_LANGUAGE                                                                                                      
  VTD1_REMINDER_DUE_DATE__C             VTD1_REMINDER_DUE_DATE                                                                                                 
  VTD1_REMINDER_WINDOW__C               VTD1_REMINDER_WINDOW                                                                                                   
  VTD1_NUMBER_OF_ANSWERS__C             VTD1_NUMBER_OF_ANSWERS                                                                                                 
  VTD1_NUMBER_OF_SCORED_ANSWERS__C      VTD1_NUMBER_OF_SCORED_ANSWERS                                                                                          
  VTR2_REVIEWER_USER__C                 VTR2_REVIEWER_USER                                                                                                     
  VTR2_NUMBER_OF_ANSWERED_ANSWERS__C    VTR2_NUMBER_OF_ANSWERED_ANSWERS                                                                                        
  VTR2_TOTAL_SCORE__C                   VTR2_TOTAL_SCORE                                                                                                       
  VTR4_PERCENTAGE_COMPLETED__C          VTR4_PERCENTAGE_COMPLETED                                                                                              
*/                                                                                                                                                             
                                                                                                                                                               
* MAP LONG COLUMN NAMES TO SHORTER COLUMN NAMES;                                                                                                               
                                                                                                                                                               
* DELETE ARRAYS ;                                                                                                                                              
                                                                                                                                                               
%arraydelete(nam);                                                                                                                                             
%arraydelete(cut);                                                                                                                                             
%arraydelete(max32k);                                                                                                                                          
                                                                                                                                                               
* CREATE MACRO ARRAYS;                                                                                                                                         
                                                                                                                                                               
%array(nam,data=colnam,var=colnam);                                                                                                                            
%array(cut,data=colnam,var=colcut);                                                                                                                            
                                                                                                                                                               
%put Number of variables &=cutn;                                                                                                                               
%put Sample mapping  &&nam&namn ==> &&cut&cutn;                                                                                                                
                                                                                                                                                               
/*                                                                                                                                                             
Number of variables = 25                                                                                                                                       
                                                                                                                                                               
Sample mapping  VTR4_PERCENTAGE_COMPLETED__C ==> VTR4_PERCENTAGE_COMPLETED                                                                                     
*/                                                                                                                                                             
                                                                                                                                                               
* FIND VARIABLES AND THERE MAX LENGTHS;                                                                                                                        
                                                                                                                                                               
proc sql;                                                                                                                                                      
                                                                                                                                                               
   connect to mysql (user=root password=xxxxxxxx database=sakila  port=3306 dbmax_text=32756);                                                                 
                                                                                                                                                               
   create                                                                                                                                                      
        table maxlength as                                                                                                                                     
   select                                                                                                                                                      
        *                                                                                                                                                      
     from connection to mysql                                                                                                                                  
       (                                                                                                                                                       
       select                                                                                                                                                  
            %do_over(nam cut,phrase=%str(max(length(?nam)) as ?cut), between=comma)                                                                            
       from                                                                                                                                                    
            sqldat                                                                                                                                             
       );                                                                                                                                                      
    disconnect from mysql;                                                                                                                                     
                                                                                                                                                               
quit;                                                                                                                                                          
                                                                                                                                                               
* FILTER JUST THE VARIABLES WITH STRINGS OVER 32K;                                                                                                             
;                                                                                                                                                              
proc transpose data=maxlength out=max32k(rename=_name_=max32k where=(col1 > 32757));                                                                           
var _all_;                                                                                                                                                     
run;quit;                                                                                                                                                      
                                                                                                                                                               
/*                                                                                                                                                             
WORK.MAX32k total obs=3                                                                                                                                        
                                                                                                                                                               
Obs   CUTNAM                       COL1                                                                                                                        
                                                                                                                                                               
 1     VTD1_ANSWER                32759                                                                                                                        
 2     VTR2_ENGLISH_ANSWER        32759                                                                                                                        
 3     VTR2_QUESTION_CONTENT      32759                                                                                                                        
*/                                                                                                                                                             
                                                                                                                                                               
*PUT VARIABLES IN A MACRO ARRAY;                                                                                                                               
                                                                                                                                                               
%array(max32k,data=max32k,var=max32k);                                                                                                                         
                                                                                                                                                               
proc sql;                                                                                                                                                      
                                                                                                                                                               
   connect to mysql (user=root password=xxxxxxxx database=sakila  port=3306 dbmax_text=32757);                                                                 
                                                                                                                                                               
   create                                                                                                                                                      
        table want(drop=%do_over(max32k,phrase=?)) as                                                                                                          
   select                                                                                                                                                      
        *                                                                                                                                                      
     from connection to mysql                                                                                                                                  
       (                                                                                                                                                       
       select                                                                                                                                                  
           %do_over(nam cut,phrase=                                                                                                                            
                 ?nam as ?cut                                                                                                                                  
           ,between=comma)                                                                                                                                     
                                                                                                                                                               
           ,%do_over(max32k,phrase=%str(                                                                                                                       
                  substring(?max32k__C,1,32757)         as ?max32k1                                                                                            
                 ,substring(?max32k__C,32757)           as ?max32k2)                                                                                           
           ,between=comma)                                                                                                                                     
                                                                                                                                                               
       from                                                                                                                                                    
            sqldat                                                                                                                                             
       );                                                                                                                                                      
    disconnect from mysql;                                                                                                                                     
                                                                                                                                                               
quit;                                                                                                                                                          
                                                                                                                                                               
%utl_optlen(inp=want,out=want);                                                                                                                                
                                                                                                                                                               
/*           _   _                                                                                                                                             
 _ __  _   _| |_| |__   ___  _ __    ___  __ _ ___                                                                                                             
| `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` / __|                                                                                                            
| |_) | |_| | |_| | | | (_) | | | | \__ \ (_| \__ \                                                                                                            
| .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__,_|___/                                                                                                            
|_|    |___/                                                                                                                                                   
*/                                                                                                                                                             
                                                                                                                                                               
                                                                                                                                                               
%utlfkil(d:/csv/eDiary_nocirc.csv);                                                                                                                            
                                                                                                                                                               
* DROP MYSQL TABLE IF IT EXISTS;                                                                                                                               
                                                                                                                                                               
proc sql;                                                                                                                                                      
                                                                                                                                                               
   connect to mysql (user=root password=xxxxxxxx database=sakila  port=3306 dbmax_text=32757);                                                                 
       execute (drop table if exists sqldat) by mysql;                                                                                                         
    disconnect from mysql;                                                                                                                                     
                                                                                                                                                               
quit;                                                                                                                                                          
                                                                                                                                                               
* CONVERT CICUMFLEX A TO JUST A;                                                                                                                               
data _null_;                                                                                                                                                   
  infile "d:/csv/eDiary_small.csv" lrecl=100 pad  recfm=f;                                                                                                     
  file "d:/csv/eDiary_nocirc.csv" lrecl=100  recfm=f;                                                                                                          
  input bytchr $char100.;                                                                                                                                      
  bytchr=translate(bytchr,'A','C2'x);                                                                                                                          
  if bytchr='C2'x then putlog bytchr=;                                                                                                                         
  put bytchr $char100.;                                                                                                                                        
run;quit;                                                                                                                                                      
                                                                                                                                                               
/*                                                                                                                                                             
* VERIFY THAT CICUMFLEX IS GONE;                                                                                                                               
* YOU SHOULD SEE "100.0A°F";                                                                                                                                   
* TURN MUBERS ONAND HEX ON IN COMMAND LINE;                                                                                                                    
                                                                                                                                                               
filename fsl 'd:/csv/eDiary_nocirc.csv' lrecl=100000 recfm=v;                                                                                                  
proc fslist file=fsl;                                                                                                                                          
run;quit;                                                                                                                                                      
*/                                                                                                                                                             
                                                                                                                                                               
%utlfkil(d:/xpt/colnam.xpt);                                                                                                                                   
                                                                                                                                                               
proc datasets lib=work nolist;                                                                                                                                 
  delete colnam maxlength max32k want;                                                                                                                         
run;quit;                                                                                                                                                      
                                                                                                                                                               
* LOAD CSV INTO R DATAFRAME;                                                                                                                                   
* GET COLUMN NAMES AND EXPORT TO SAS;                                                                                                                          
* LOAD DATAFRAME INT MYSQL;                                                                                                                                    
                                                                                                                                                               
                                                                                                                                                               
%utl_submit_py64_38("                                                                                                                                          
import pyreadstat;                                                                                                                                             
from sqlalchemy import create_engine;                                                                                                                          
import pandas as pd  ;                                                                                                                                         
import csv           ;                                                                                                                                         
sqldat = pd.read_csv('d:/csv/eDiary_small.csv',dtype=str);                                                                                                     
colnam  = pd.DataFrame(list(sqldat));                                                                                                                          
colnam.rename(columns = {0:'COLNAM'}, inplace=True);                                                                                                           
print(colnam);                                                                                                                                                 
my_connect = create_engine('mysql+mysqldb://root:xxxxxxxx@localhost/sakila');                                                                                  
sqldat.to_sql(con=my_connect,name='sqldat',if_exists='replace', index=False);                                                                                  
pyreadstat.write_xport(colnam, 'd:/xpt/colnam.xpt',table_name='colnam');                                                                                       
");                                                                                                                                                            
                                                                                                                                                               
                                                                                                                                                               
* CREATE SAS DATASET WITH OLD AND SHORTED NEW NAMES;                                                                                                           
                                                                                                                                                               
libname xpt xport "d:/xpt/colnam.xpt";                                                                                                                         
data colnam;                                                                                                                                                   
  set xpt.colnam;                                                                                                                                              
  colCut=prxchange('s/__C//',-1,colnam);                                                                                                                       
run;quit;                                                                                                                                                      
libname xpt clear;                                                                                                                                             
                                                                                                                                                               
/* MAPPINGS                                                                                                                                                    
                                                                                                                                                               
 WORK.COLNAM total obs=25                                                                                                                                      
                                                                                                                                                               
  LONG NAMES COME OVER 23 CHARS         LESS THAT 32 CHARS (drop __C)                                                                                          
                                                                                                                                                               
  COLNAM                                COLCUT                                                                                                                 
                                                                                                                                                               
  VTD2_STUDY_NICKNAME__C                VTD2_STUDY_NICKNAME                                                                                                    
  VTR4_CROSS_REFERENCE_SUBJECT_ID__C    VTR4_CROSS_REFERENCE_SUBJECT_ID                                                                                        
  ANSWER_ID                             ANSWER_ID                                                                                                              
  DIARY_ID                              DIARY_ID                                                                                                               
  NAME                                  NAME                                                                                                                   
  VTD1_SURVEY__C                        VTD1_SURVEY                                                                                                            
  VTD1_ANSWER__C                        VTD1_ANSWER                                                                                                            
  VTR2_ENGLISH_ANSWER__C                VTR2_ENGLISH_ANSWER                                                                                                    
  VTR2_QUESTION_CONTENT__C              VTR2_QUESTION_CONTENT                                                                                                  
  CREATEDDATE                           CREATEDDATE                                                                                                            
  VTD1_COMPLETION_TIME__C               VTD1_COMPLETION_TIME                                                                                                   
  VTD1_DATE_AVAILABLE__C                VTD1_DATE_AVAILABLE                                                                                                    
  VTD1_DUE_DATE__C                      VTD1_DUE_DATE                                                                                                          
  VTD2_PATIENT_S_DUE_TIME__C            VTD2_PATIENT_S_DUE_TIME                                                                                                
  VTD2_PATIENT_S_NUMERIC_TIMEZONE__C    VTD2_PATIENT_S_NUMERIC_TIMEZONE                                                                                        
  VTD1_STATUS__C                        VTD1_STATUS                                                                                                            
  VTR2_DOC_LANGUAGE__C                  VTR2_DOC_LANGUAGE                                                                                                      
  VTD1_REMINDER_DUE_DATE__C             VTD1_REMINDER_DUE_DATE                                                                                                 
  VTD1_REMINDER_WINDOW__C               VTD1_REMINDER_WINDOW                                                                                                   
  VTD1_NUMBER_OF_ANSWERS__C             VTD1_NUMBER_OF_ANSWERS                                                                                                 
  VTD1_NUMBER_OF_SCORED_ANSWERS__C      VTD1_NUMBER_OF_SCORED_ANSWERS                                                                                          
  VTR2_REVIEWER_USER__C                 VTR2_REVIEWER_USER                                                                                                     
  VTR2_NUMBER_OF_ANSWERED_ANSWERS__C    VTR2_NUMBER_OF_ANSWERED_ANSWERS                                                                                        
  VTR2_TOTAL_SCORE__C                   VTR2_TOTAL_SCORE                                                                                                       
  VTR4_PERCENTAGE_COMPLETED__C          VTR4_PERCENTAGE_COMPLETED                                                                                              
*/                                                                                                                                                             
                                                                                                                                                               
* MAP LONG COLUMN NAMES TO SHORTER COLUMN NAMES;                                                                                                               
                                                                                                                                                               
* DELETE ARRAYS ;                                                                                                                                              
                                                                                                                                                               
%arraydelete(nam);                                                                                                                                             
%arraydelete(cut);                                                                                                                                             
%arraydelete(max32k);                                                                                                                                          
                                                                                                                                                               
* CREATE MACRO ARRAYS;                                                                                                                                         
                                                                                                                                                               
%array(nam,data=colnam,var=colnam);                                                                                                                            
%array(cut,data=colnam,var=colcut);                                                                                                                            
                                                                                                                                                               
%put Number of variables &=cutn;                                                                                                                               
%put Sample mapping  &&nam&namn ==> &&cut&cutn;                                                                                                                
                                                                                                                                                               
/*                                                                                                                                                             
Number of variables = 25                                                                                                                                       
                                                                                                                                                               
Sample mapping  VTR4_PERCENTAGE_COMPLETED__C ==> VTR4_PERCENTAGE_COMPLETED                                                                                     
*/                                                                                                                                                             
                                                                                                                                                               
* FIND VARIABLES AND THERE MAX LENGTHS;                                                                                                                        
                                                                                                                                                               
proc sql;                                                                                                                                                      
                                                                                                                                                               
   connect to mysql (user=root password=xxxxxxxx database=sakila  port=3306 dbmax_text=32756);                                                                 
                                                                                                                                                               
   create                                                                                                                                                      
        table maxlength as                                                                                                                                     
   select                                                                                                                                                      
        *                                                                                                                                                      
     from connection to mysql                                                                                                                                  
       (                                                                                                                                                       
       select                                                                                                                                                  
            %do_over(nam cut,phrase=%str(max(length(?nam)) as ?cut), between=comma)                                                                            
       from                                                                                                                                                    
            sqldat                                                                                                                                             
       );                                                                                                                                                      
    disconnect from mysql;                                                                                                                                     
                                                                                                                                                               
quit;                                                                                                                                                          
                                                                                                                                                               
* FILTER JUST THE VARIABLES WITH STRINGS OVER 32K;                                                                                                             
;                                                                                                                                                              
proc transpose data=maxlength out=max32k(rename=_name_=max32k where=(col1 > 32757));                                                                           
var _all_;                                                                                                                                                     
run;quit;                                                                                                                                                      
                                                                                                                                                               
/*                                                                                                                                                             
WORK.MAX32k total obs=3                                                                                                                                        
                                                                                                                                                               
Obs   CUTNAM                       COL1                                                                                                                        
                                                                                                                                                               
 1     VTD1_ANSWER                32759                                                                                                                        
 2     VTR2_ENGLISH_ANSWER        32759                                                                                                                        
 3     VTR2_QUESTION_CONTENT      32759                                                                                                                        
*/                                                                                                                                                             
                                                                                                                                                               
*PUT VARIABLES IN A MACRO ARRAY;                                                                                                                               
                                                                                                                                                               
%array(max32k,data=max32k,var=max32k);                                                                                                                         
                                                                                                                                                               
proc sql;                                                                                                                                                      
                                                                                                                                                               
   connect to mysql (user=root password=xxxxxxxx database=sakila  port=3306 dbmax_text=32757);                                                                 
                                                                                                                                                               
   create                                                                                                                                                      
        table want (drop=%do_over(max32k,phrase=?)) as                                                                                                         
   select                                                                                                                                                      
        *                                                                                                                                                      
     from connection to mysql                                                                                                                                  
       (                                                                                                                                                       
       select                                                                                                                                                  
           %do_over(nam cut,phrase=                                                                                                                            
                 ?nam as ?cut                                                                                                                                  
           ,between=comma)                                                                                                                                     
                                                                                                                                                               
           ,%do_over(max32k,phrase=%str(                                                                                                                       
                  substring(?max32k__C,1,32757)         as ?max32k1                                                                                            
                 ,substring(?max32k__C,32757)           as ?max32k2)                                                                                           
           ,between=comma)                                                                                                                                     
                                                                                                                                                               
       from                                                                                                                                                    
            sqldat                                                                                                                                             
       );                                                                                                                                                      
    disconnect from mysql;                                                                                                                                     
                                                                                                                                                               
quit;                                                                                                                                                          
                                                                                                                                                               
%utl_optlen(inp=want,out=want);                                                                                                                                
                                                                                                                                                               
                                                                                                                                                               
