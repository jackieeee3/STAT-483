/* Jackie Yang */
/* Homework #34 */
/* 10/08/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';
LIBNAME STAT483 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 482\Lesson 34';

PROC SORT data = STAT483.back out = sorted_back;
    BY sex;
RUN;

PROC SURVEYSELECT data = sorted_back out = sampled_subjects
    SEED = 12345
    METHOD = SRS
    SAMPRATE = (0.10 0.10)
    NOPRINT;
    STRATA sex;
RUN;

PROC PRINT data = sampled_subjects;
    VAR sex subj v_date b_date;
    TITLE "ICDB 10% SAS";
RUN;
	
DATA students;
    ARRAY methods[4] $1 ('A','B','C','D');
    CALL streaminit(12345);
    DO id = 1 to 32;
        method = methods[ceil(rand('uniform')*4)];
        OUTPUT;
    END;
RUN;

PROC SORT data = students;
    BY id;
RUN;

PROC PRINT data = students NOOBS;
    VAR id method;
	TITLE 'Random Assignment of Students to SAS Teaching Methods';
RUN;
