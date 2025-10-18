OPTIONS NODATE NONUMBER FORMDLIM = '_';

DATA dose_response;
   INPUT dose sbp dbp;
   DATALINES;
4  180   110
4  190   108
4  178   100
8  170   100
8  180   98
8  168   88
16 160   80
16 172   86
16 170   86
32 140   80
32 130   72
32 128   70
;
RUN;

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
