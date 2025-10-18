/* Jackie Yang */
/* Homework #21 */
/* 10/27/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';

DATA results;
	INFILE "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 21\results.dat";
	INPUT team member $ score @@;
RUN;

PROC PRINT data = results NOOBS;
	TITLE 'The results data set';
RUN;

DATA addresses;
	INFILE "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 21\addresses.dat";
	INPUT #4 ID
		  #1 Name & $17.
		  #2 Street & $19.
		  #3 Town & $11. State $2. Zip;
RUN;

PROC PRINT data = addresses NOOBS;
	TITLE 'The addresses data set';
RUN;

DATA results2;
    INFILE "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 21\results2.dat" PAD;
    INPUT @10 source 1. @;
    IF source = 1 THEN DO;
        INPUT id 1-2 name $ 4-8 source 10 score $ 12-13;
        OUTPUT;
    END;
    ELSE IF source = 2 THEN DO;
        INPUT id 1-2 name $ 12-16 source 10 score $ 4-5;
        OUTPUT;
    END;
RUN;

PROC PRINT DATA=results2 NOOBS;
    TITLE 'The results2 data set';
RUN;
