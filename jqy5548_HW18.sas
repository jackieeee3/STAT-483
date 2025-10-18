/* Jackie Yang */
/* Homework #18 */
/* 10/20/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';

DATA multiplication;
	DO i = 1 to 9 by 1;
		var1 = 1 * i;
		var2 = 2 * i;
		var3 = 3 * i;
		var4 = 4 * i;
		var5 = 5 * i;
		var6 = 6 * i;
		var7 = 7 * i;
		var8 = 8 * i;
		var9 = 9 * i;
		OUTPUT;
	END;
	STOP;
RUN;

PROC PRINT data = multiplication LABEL NOOBS;
	TITLE 'Multiplication table';
	LABEL var1 = '1' var2 = '2' var3 = '3' var4 = '4' var5 = '5' var6 = '6'
		var7 = '7' var8 = '8' var9 = '9';
RUN;

DATA savings (DROP = i);
	DO UNTIL (earned >= 10000);
	earned + 300;
		earned + earned * 0.005;
		months + 1;
		OUTPUT;
	END;
RUN;

PROC PRINT data = savings NOOBS;
	TITLE 'Amount Saved';
RUN;
