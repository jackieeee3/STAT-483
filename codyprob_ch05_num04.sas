OPTIONS NODATE NONUMBER FORMDLIM = '_';

DATA SCORES;   
   DO SUBJECT = 1 TO 100;
      IF RANUNI(1357) LT .5 THEN GROUP = 'A'; 
	                        ELSE GROUP = 'B';
      MATH = ROUND(RANNOR(1357)*20 + 550 + 10*(GROUP EQ 'A'));
      SCIENCE = ROUND(RANNOR(1357)*15 + .4*MATH + 300);  
      ENGLISH = ROUND(RANNOR(1357)*20 + 500 + .05*SCIENCE + .05*MATH); 
      SPELLING = ROUND(RANNOR(1357)*15 + 500 + .1*ENGLISH);  
      VOCAB = ROUND(RANNOR(1357)*5 + 400 + .1*SPELLING + .2*ENGLISH);  
      PHYSICAL = ROUND(RANNOR(1357)*20 + 550);     
      OVERALL = ROUND(MEAN(MATH, SCIENCE, ENGLISH, SPELLING, VOCAB, PHYSICAL));  
      OUTPUT;  
   END;
RUN;

/* Question 1 */
/* Part A */
PROC CORR data = SCORES NOSIMPLE;
   VAR MATH SCIENCE ENGLISH SPELLING VOCAB PHYSICAL OVERALL;
   TITLE 'Correlation Matrix of All Test Scores and Overall Score';
RUN;

/* Part C */
PROC CORR data = SCORES NOSIMPLE;
   VAR MATH SCIENCE ENGLISH SPELLING VOCAB PHYSICAL;
   WITH OVERALL;
   TITLE 'Correlation Matrix of Each Score with Overall';
RUN;

PROC PRINT data = SCORES;
	TITLE 'SCORES Dataset';
RUN;

/* Part B */

/* The varaible PHYSICAL is independent of all the other test scores but is correlated
to OVERALL. Using properly notated SAS comment at the end of your code, explain why */

/* PHYSICAL is independent of all other test scores because it is calculated without
using the other subject variables. However, it is correlated to OVERALL because OVERALL
is the mean of all scores which includes PHYSICAL */

/* Question 2 */

/* Part A */
PROC REG data = SCORES PLOTS(ONLY) = (FIT RESIDUALS);
    MODEL SCIENCE = MATH;
    TITLE "Regression of SCIENCE on MATH";
RUN;

/* Part B */
PROC REG data = SCORES NOPRINT OUTEST = ESTIMATES TABLEOUT;
    MODEL SCIENCE = MATH / CLB CLM;
    OUTPUT OUT = REGOUT PREDICTED = PRED LCL = LCL UCL = UCL;
RUN;

PROC SORT data = REGOUT;
    BY MATH;
RUN;

PROC GPLOT data = REGOUT;
    PLOT SCIENCE*MATH PRED*MATH LCL*MATH UCL*MATH / OVERLAY HAXIS = AXIS1 VAXIS = AXIS2;
    SYMBOL1 V = DOT I = NONE C = BLUE;
    SYMBOL2 V = NONE I = JOIN C = RED;
    SYMBOL3 V = NONE I = JOIN C = GREEN L = 2;
    SYMBOL4 V = NONE I = JOIN C = GREEN L = 2;
    AXIS1 LABEL = ('MATH Score');
    AXIS2 LABEL = (A = 90 'SCIENCE Score');
    TITLE "Scatter Plot of SCIENCE vs MATH with Regression Line and 95% CI";
RUN;
QUIT;

/* MATH is a significant predictor of SCIENCE as its p-value is 0.0011. However, the
R-squared value is 0.1041, indicating that only 10.41% of the variation in SCIENCE is
explained by the regression model that includes MATH */

