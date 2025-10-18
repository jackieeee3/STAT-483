/**** SAS program: Q0101.sas ****/
DATA temp1;
	input subj a b;
	DATALINES;
11 23 34
12 24 35
13 25 36
14 26 37
;
RUN;

DATA temp2;
	input subj b;
	DATALINES;
11 47
12 63
13 42
14 26
;
RUN;

DATA temp (where=(subj = 12));
	merge temp1 temp2;
	total = a + b;
RUN;

PROC PRINT;
RUN;
