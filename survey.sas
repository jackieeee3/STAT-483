OPTIONS PS=58 LS=80;   LIBNAME stat 'c:\lsimon\stat480\data'; data survey1; */ Capitalized options, ps, ls, libname, datalines, run /*

input no init $ q1 q2 q3; DATALINES; 
     1 mn 2 0 1 
     2 cp 2 1 0
     3 ky 1 1 1 
     4 kd 0 1 0 
     5 cd 0 1 1 
     ;
 RUN;
PROC PRINT data=survey1; TITLE 'DATASET: survey1';  var no init q1 q2 q3; 
 RUN; 
*/ Capitalized proc print, title, run, 
