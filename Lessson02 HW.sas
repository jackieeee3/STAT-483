LIBNAME STAT483 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\Lesson02'; /* Specifies SAS data library */

DATA STAT483.Lesson02;
	input
		town $ 1-6
		num 8-9
		month 11-12
		year 14-17
		low 19-20
		high 22-23
	;
DATALINES;
Kane   20 12 2005 12 25
Ambler 22 12 2005  8 20
Kane   20 01 2006 13 32
Oakey  32 12 2005 30 50
Oakey  32 01 2006 25 45
Ambler 22 01 2006 15 28
;
RUN;

PROC PRINT data=STAT483.Lesson02;
	TITLE 'Output dataset: Lesson02 HW';
RUN;
