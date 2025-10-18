LIBNAME STAT483 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 480\Lesson03'; /* Creating a permanent SAS data set */

DATA STAT483.Lesson03;
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
/* First question */

PROC PRINT data = STAT483.Lesson03;
	TITLE 'Output dataset: Lesson03 HW';
RUN;

OPTIONS CENTER LS = 80 FORMDLIM = 'X';

PROC CONTENTS data = STAT483.Lesson03;
RUN;
/* Displays descriptor portion */

DATA rats;
	infile 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\Lesson03\rats.dat';
	input
		rat 1
		+1 dob $ 9.
		@13 disease $ 9.
		@23 death mmddyy8.
		group $ 32;
	FORMAT death mmddyy8.;
RUN;
/* Reads data with mixture of methods */

OPTIONS PS = 56 LS = 78 CENTER NODATE;

PROC PRINT data = rats;
	TITLE 'Output Dataset: rats';
RUN;
