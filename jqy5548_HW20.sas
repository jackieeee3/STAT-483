/* Jackie Yang */
/* Homework #20 */
/* 10/27/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';

DATA pumpkins;
	INFILE "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 20\pumpkins.dat" MISSOVER;
		INPUT Name & $16. Age Type $ EnterDate mmddyy10. j1-j5;
		FORMAT EnterDate mmddyy10.;
RUN;

PROC PRINT data = pumpkins;
	TITLE 'Pumpkins Data Set';
RUN;

DATA pumpkins2;
	INFILE "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 20\pumpkins2.dat" MISSOVER DSD;
		INPUT Name :$16. Age Type :$1. EnterDate :mmddyy10. j1-j5;
		FORMAT EnterDate mmddyy10.;
RUN;

PROC PRINT data = pumpkins2;
	TITLE 'Pumpkins2 Data Set';
RUN;

DATA pumpkins3;
	INFILE "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 20\pumpkins3.dat" MISSOVER FIRSTOBS = 2;
	INPUT Name $ 1-16 
		  Age 18-19 
		  Type $ 21 
		  EnterDate_char $ 23-32 
		  j1 34-36
		  j2 38-40
		  j3 42-45
		  j4 47-49
		  j5 51-53;
	EnterDate = INPUT(EnterDate_char, MMDDYY10.);
    FORMAT EnterDate MMDDYY10.;
    DROP EnterDate_char;
RUN;

PROC PRINT data = pumpkins3;
	TITLE 'Pumpkins3 Data Set';
	VAR Name Age Type EnterDate j1 j2 j3 j4 j5;
RUN;
