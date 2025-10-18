/* Jackie Yang */
/* Homework #27 */
/* 11/16/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';

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

/* Question 3 */
PROC PRINT data = dose_response;
	TITLE 'Dose Response Dataset';
RUN;

PROC REG data = dose_response PLOTS(ONLY) = (FIT RESIDUALS);
    MODEL sbp = dose;
    PLOT sbp*dose;
    PLOT r.*dose;
    TITLE "Regression of SBP on DOSE";
RUN;

PROC REG data = dose_response PLOTS(ONLY) = (FIT RESIDUALS);
    MODEL dbp = dose;
    PLOT dbp*dose;
    PLOT r.*dose;
    TITLE "Regression of DBP on DOSE";
RUN;

/* Question 4 */
DATA dose_response_log;
   SET dose_response;
   log_dose = LOG(dose);
RUN;

PROC REG data = dose_response_log PLOTS(ONLY) = (FIT RESIDUALS);
   MODEL sbp = log_dose;
   PLOT sbp*log_dose;
   PLOT r.*log_dose;
   TITLE "Regression of SBP on LOG(DOSE)";
RUN;

PROC REG data = dose_response_log PLOTS(ONLY) = (FIT RESIDUALS);
   MODEL dbp = log_dose;
   PLOT dbp*log_dose;
   PLOT r.*log_dose;
   TITLE "Regression of DBP on LOG(DOSE)";
RUN;

/* For SBP, DOSE seems to be a better predictor because the r-squared value is 0.9008
and the RMSE value is 6.7402. For SBP and log(DOSE), the r-squared value is 0.7903 and
the RMSE value is 9.8. SBP and DOSE have a higher r-square value and a lower RMSE value,
indicating that 90.08% of the variation in the dependent variable is explained and 
a lower RMSE value indicates that the predictions are closer to the actual values. */

/* As for DBP, LOG(DOSE) seems to be a better predictor because its r-squared value is 
0.8872. and the RMSE value is 4.6861. For SBP and DOSE, the r-sqaured value is 0.8084 
and the RMSE value is 6.1095. DBP and LOG(DOSE) have a higher r-squared value and lower
RMSE value, indicating that 88.72% of the variation in the dependent variable is 
explained and a lower RMSE value indicates that the predictions are closer to the
actual values. */
