/* Jackie Yang */
/* Homework #19 */
/* 10/20/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';

LIBNAME STAT483 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 19';

DATA tallgrades;
	SET STAT483.fatgrades;
	BY idno;
	ARRAY allgrades(6) G1-G6;

	DO i = 1 TO 6;
		grade = allgrades(i);
		gtype = cats('G', i);
		OUTPUT;
	END;
	KEEP idno l_name gtype grade;
RUN;

PROC PRINT data = tallgrades NOOBS;
	TITLE 'Tall Grades Dataset';
RUN;

DATA answers (DROP = i);
	INFILE 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 19\grades.dat';
	INPUT 
		id
		score1
		score2
		score3
		score4
		score5
	;		
	ARRAY allscores(5) score1-score5;
	ARRAY passing(5) _TEMPORARY_ (65, 70, 60, 75, 66);
	passed = 0;

	DO i = 1 TO 5;
		IF allscores(i) >= passing(i) THEN passed + 1;
	END;
RUN;

PROC PRINT data = answers NOOBS;
	TITLE 'Answers Dataset';
RUN;
