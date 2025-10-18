/* Jackie Yang */
/* Homework #17 */
/* 10/21/2024 */
OPTIONS NODATE NONUMBER FORMDLIM = '_';

LIBNAME STAT483 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 17';

DATA change;
	SET STAT483.clinical;
	BY patient;
	RETAIN startweight endweight;
	IF first.patient THEN startweight = weight;
	IF last.patient THEN DO 
		endweight = weight;
		changeweight = startweight - endweight;
		OUTPUT;
	END;
RUN;

PROC PRINT DATA = change NOOBS;
	TITLE 'Output dataset: Weight Change';
	VAR patient gender group startweight endweight changeweight;
RUN;

DATA fat;
	SET STAT483.clinical;
	BY patient;
	RETAIN weight1 weight2 weight3 weight4;
	IF first.patient THEN DO;
		weight1 = .;
		weight2 = .;
		weight3 = .;
		weight4 = .;
	END;
	IF visit = 1 THEN weight1 = weight;
	ELSE IF visit = 2 THEN weight2 = weight;
	ELSE IF visit = 3 THEN weight3 = weight;
	ELSE IF visit = 4 THEN weight4 = weight; 
	IF last.patient THEN OUTPUT;
RUN;

PROC PRINT DATA = fat NOOBS;
	TITLE 'Output dataset: Fat';
	VAR patient gender group weight1 weight2 weight3 weight4;
RUN;
