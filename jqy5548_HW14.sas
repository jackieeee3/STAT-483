/* Jackie Yang */ 
/* Homework #14 */
/* 10/13/2024 */
OPTIONS NODATE NONUMBER FORMDLIM = "_";

LIBNAME STAT483 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 14';

DATA qul;
	SET STAT483.qul (WHERE = (v_type = 0 AND (int(subj/10000) = 31)) 
		RENAME = (qul_3a = qul3a 
					qul_3b = qul3b 
					qul_3c = qul3c 
					qul_3d = qul3d 
					qul_3e = qul3e 
					qul_3f = qul3f 
					qul_3g = qul3g 
					qul_3h = qul3h 
					qul_3i = qul3i 
					qul_3j = qul3j));
	scale1 = qul3a + qul3b + qul3c + qul3d + qul3e + qul3f + qul3g + qul3h + qul3i + qul3j;
	FORMAT scale1 4.1;
	KEEP subj v_type v_date scale1;
RUN;

PROC PRINT data = qul;
	TITLE 'Output Dataset: Quality of Life Form';
RUN;
