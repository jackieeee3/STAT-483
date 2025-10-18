/* Jackie Yang */
/* Homework #31 */
/* 11/23/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_' LS = 120;

/* Problem 9.2 */
DATA yield_data;
    INFILE "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 482\Lesson 31\cody_chap09_num02.dat";
    INPUT yield light water;

    light1 = (light = 2);
    light2 = (light = 3);
    water1 = (water = 2);
RUN;

PROC PRINT DATA = yield_data;
    TITLE 'Yield Data with Dummy Variables';
RUN;

PROC REG DATA = yield_data;
    MODEL yield = light1 light2 water1;
    TITLE 'Regression of Light and Water on Yield';

    OUTPUT OUT = reg_output 
        P = Predicted Value
        R = Residual
        STUDENT = Student Residual
        COOKD = Cooks D
        STDP = Std Error Predict
        STDR = Std Error Residual;
RUN;
QUIT;

PROC PRINT DATA = reg_output SPLIT = '/';
    TITLE 'Regression of Light and Water on Yield';
RUN;

/* Based on the analysis results, the R-square value for the model is 0.8902, indicating
that 89.02% of the variation in yield is explained by light1, light2, and water1. */
/* The predicted tomato yield when a potted plant receives 10 hours of light and 2 quarts
of water is yield = 9.5555 + 3.8333*light1 + 12.1666*light2 + 4.55556*water1. Upon
calculating this value, the predicted yield is 140.33262 */
/* No observations in the data set unduly influence the estimated regression equation as
all Cook's Distance values are less than 1 */

/* Problem 9.6 */
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


/* Problem 9.8 */
PROC FORMAT; 
    VALUE YESNO 1='YES' 0='NO';  
    VALUE OUTCOME 1='Case' 0='Control';
RUN;

DATA SMOKING;
    DO SUBJECT = 1 TO 1000;
       DO OUTCOME = 0,1;  
          IF RANUNI(567) LT .1 OR RANUNI(0)*OUTCOME GT .5 THEN SMOKING = 1;  
                                                          ELSE SMOKING = 0;     
          IF RANUNI(0) LT .05 OR     
             (RANUNI(0)*OUTCOME + .1*SMOKING) GT .6 THEN ASBESTOS = 1;  
                                                    ELSE ASBESTOS = 0;     
          IF RANUNI(0) LT .3 OR OUTCOME*RANUNI(0) GT .9 THEN SES = '1-Low   '; 
     ELSE IF RANUNI(0) LT .3 OR OUTCOME*RANUNI(0) GT .8 THEN SES = '2-Medium'; 
                                                        ELSE SES = '3-High';       
          OUTPUT;   
       END;  
    END;  
    FORMAT SMOKING ASBESTOS YESNO. OUTCOME OUTCOME.;
RUN;

PROC FREQ DATA = SMOKING;
    TABLES OUTCOME*SMOKING / ALL;
    TITLE 'Crosstabulation of OUTCOME and SMOKING';
RUN;

PROC LOGISTIC DATA = SMOKING DESCENDING;
    MODEL OUTCOME = SMOKING;
    TITLE 'Predicting OUTCOME from SMOKING';
RUN;

/* The chi-square value is 444.1202 and the odds ratio is 10.4911. */
