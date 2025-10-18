/* Jackie Yang */
/* Homework #24 */
/* 11/03/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';

LIBNAME STAT483 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 24';

DATA back_filtered;
    SET STAT483.back;
    WHERE income IS NOT MISSING;
RUN;

PROC SORT data = back_filtered;
    BY income;
	WHERE _TYPE_ IN (11, 10, 01, 00);
RUN;

ODS TRACE ON;

DATA income2;
    SET income2;
    WHERE income = 2;
    DROP income Table F_sex F_mar_st;
RUN;

PROC SORT data = income2;
    BY DESCENDING _TYPE_ sex mar_st;
RUN;

ODS TRACE OFF;

ODS RTF FILE = "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 24\jqy5548_HW24.rtf" STYLE = Brick;

PROC FREQ data = back_filtered;
    WHERE income = 1;
    TABLES sex * mar_st / NOROW NOCOL NOPERCENT;
    ODS OUTPUT CrossTabFreqs = income1;
	TITLE1 "Marital Status and Gender of Subjects";
    TITLE2 "with Income GE $30,000";
	TITLE3 "income=1";
RUN;

PROC FREQ data = back_filtered;
    WHERE income = 2;
    TABLES sex * mar_st / NOROW NOCOL NOPERCENT;
    ODS OUTPUT CrossTabFreqs = income2;
	TITLE1 "Marital Status and Gender of Subjects";
    TITLE2 "with Income GE $30,000";
	TITLE3 "income=2";
RUN;

PROC PRINT data = income2 NOOBS;
    VAR sex mar_st _TYPE_ Frequency;
RUN;

ODS RTF CLOSE;
