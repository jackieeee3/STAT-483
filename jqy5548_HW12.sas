OPTIONS NODATE NONUMBER;

LIBNAME STAT483 "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 480\Lesson12";
/* Read in data */
DATA back;
	SET STAT483.back;
RUN;
/* Produce first table with ed_level only */
PROC FREQ DATA = back;
	TABLE ed_level / NOCUM;
RUN;
/* Produce a two-way table: sex by ed_level with no columns and no percentages */
PROC FREQ DATA = back;
	TABLES sex*ed_level / nocol nopercent;
RUN;
/* New data set */
PROC FREQ DATA = STAT483.back;
    TABLES sex*mar_st / NOPRINT OUT = summary_data sparse;
RUN;
/* Format using codebook */
PROC FORMAT;
	VALUE sexfmt 1 = 'Male'
	2 = 'Female'
	;
	VALUE mar_stfmt 1 = 'Married'
	2 = 'Partner'
	3 = 'Separated'
	4 = 'Divorced'
	5 = 'Widowed'
	6 = 'Never'
	;
RUN;
/* Print the summary dataset */
PROC PRINT DATA = summary_data;
	FORMAT sex sexfmt.;
	FORMAT mar_st mar_stfmt.;
    TITLE 'Summary data set';
RUN;
