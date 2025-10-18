/* Jackie Yang */
/* Homework #16 */
/* 10/13/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';

LIBNAME STAT483 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 16';

PROC SORT data = STAT483.golfbyid OUT = sorted_golfbyid;
	BY ID;
RUN;

PROC SORT data = STAT483.golfbyname OUT = sorted_golfbyname;
	BY ID;
RUN;

DATA golf;
    MERGE sorted_golfbyid (KEEP = ID Name Rentals Fees IN = a)
          sorted_golfbyname (WHERE = (Slope >= 127)
                             KEEP  = ID Name Par Yards Slope IN = b);
    BY ID;
    IF b;
RUN;

PROC PRINT data = golf NOOBS;
	TITLE 'The merged golf data set';
	VAR ID Name Par Yards Slope Rentals Fees;
RUN;
/* Second part of the Homework */

PROC SORT data = STAT483.icdbpatients OUT = sorted_icdbpatients;
    BY subj;
RUN;

PROC SORT data = STAT483.back OUT = sorted_back;
    BY subj;
RUN;

PROC SORT data = STAT483.qul OUT = sorted_qul;
    BY subj;
RUN;

DATA analysis_final;
    MERGE sorted_icdbpatients (KEEP = subj IN = inpatients)
          sorted_back (KEEP = subj mar_st ed_level v_date 
                       RENAME = (v_date = backdate))
          sorted_qul (WHERE = (v_type = 0)
                      KEEP = subj v_date qul_1 qul_2
                      RENAME = (v_date = quldate));
    BY subj;
    IF inpatients;
RUN;

PROC SORT DATA = analysis_final OUT = analysis_final_sorted NODUPKEY;
    BY subj;
RUN;

PROC PRINT DATA=analysis_final_sorted NOOBS;
    TITLE 'Final merged analysis dataset (First observation per subject)';
    VAR subj backdate mar_st ed_level quldate qul_1 qul_2;
RUN;
