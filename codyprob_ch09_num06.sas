DATA EXERCISE; 
    DO SUBJ = 1 TO 500;   
       IF RANUNI(155) LT .5 THEN GENDER = 'Female';  
                            ELSE GENDER = 'Male';  
       PRESS = INT(RANNOR(0)*20 + 95 + 50*(GENDER EQ 'Male'));  
       CURL = RANNOR(0)*10 + 30 + .2*PRESS;  
       PUSHUPS = INT(RANNOR(0)*3 + 5 + 5*(GENDER EQ 'Male') 
                 + .1*CURL); 
       SITUPS = INT(RANNOR(0)*10 + 20 + .1*PRESS + PUSHUPS); 
       OUTPUT;  
    END;
RUN;

PROC CORR DATA = EXERCISE;
   VAR PRESS CURL PUSHUPS SITUPS;
   TITLE 'Correlations from EXERCISE data';
RUN;

DATA EXERCISE_DUMMIES;
   SET EXERCISE;
   GENDER_DUMMY = (GENDER = 'Male'); 
RUN;

PROC REG DATA = EXERCISE_DUMMIES;
   MODEL PRESS = GENDER_DUMMY CURL PUSHUPS SITUPS / SELECTION = STEPWISE;
   TITLE 'EXERCISE Data Stepwise Regression';
RUN;
QUIT;

/* The estimated regression equation that results from performing the stepwise regression
equation is PRESS = 59.0888 + 38.58506*GENDER + 0.7694*CURL */
/* If we run the simple linear regression with press as the response variable and pushups
as the predictor variable, we learn that pushups is significantly related to press.
If that's the case, why do you suppose the pushups variable did not enter into our final
stepwise regression. Pushups not entering the final model may be due to multicollinearity,
interaction effects, and model selection criteria where pushups does not reduce the value
of AIC or BIC compared to other variables */
