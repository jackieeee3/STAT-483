/* Jackie Yang */
/* Homework #15 */
/* 10/13/2024 */
OPTIONS NODATE NONUMBER FORMDLIM = "_";

LIBNAME STAT483 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 15';

DATA qul11 (RENAME = (subj = subj_id));
    SET STAT483.qul11;
    subj = INPUT(subj_id, 9.);
    DROP subj_id;
RUN;

DATA qul21;
	SET STAT483.qul21;
RUN;

DATA qul (RENAME = (subj = subj_id));
    SET qul11 qul21;
	KEEP v_type v_date qul_1 qul_2 subj_id;
RUN;

PROC CONTENTS data = qul VARNUM;
	TITLE 'Contents of Combined qul';
RUN;

DATA south;
	INPUT Entrance $ PassNo PartySize Age;
DATALINES;
S 43 3 27
S 44 3 24
S 45 3  2
;
RUN;

DATA north;
	INPUT Entrance $ PassNo PartySize Age Lot;
DATALINES;
N 21 5 41 1
N 87 4 33 3
N 65 2 67 1
N 66 2  7 1
;
RUN;

DATA both_entrances;
	SET south north;
RUN;

PROC SORT data = both_entrances;
	BY PassNo;
RUN;

PROC PRINT data = both_entrances NOOBS;
	TITLE 'The entrances data set';
RUN;
