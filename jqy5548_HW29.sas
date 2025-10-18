/* Jackie Yang */
/* Homework #29 */
/* 11/17/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';

/* Problem 7.2 */
/* Read the data */
DATA cholesterol;
    INPUT TREAT $ @@;
    DO i = 1 TO 10;
        INPUT CVAL @@;
        OUTPUT;
    END;
    DROP i;
DATALINES;
A 220 190 180 185 210 170 178 200 177 189
B 160 168 178 200 172 155 159 167 185 199
P 240 220 246 244 198 238 277 255 190 188
;
RUN;

/* Print the data to verify */
PROC PRINT data = cholesterol;
    TITLE "Cholesterol Data";
RUN;

/* Perform one-way ANOVA */
PROC ANOVA data = cholesterol;
    CLASS TREAT;
    MODEL CVAL = TREAT;
    MEANS TREAT / SNK;
    TITLE 'Analysis of Cholesterol Data';
RUN;

/* Problem 7.6 */
/* Create the dataset */
DATA depression;
    INPUT group $ trt $ score;
    DATALINES;
Deficiency Drug 9
Deficiency Drug 11
Deficiency Drug 10
Deficiency Drug 10
Deficiency Placebo 9
Deficiency Placebo 6
Deficiency Placebo 6
Deficiency Placebo 7
Normal Drug 5
Normal Drug 4
Normal Drug 7
Normal Drug 7
Normal Placebo 12
Normal Placebo 11
Normal Placebo 10
Normal Placebo 11
;
RUN;

PROC GLM data = depression;
    CLASS group trt;
    MODEL score = group trt group*trt;
    TITLE "Two-Way ANOVA of Depression Data";
RUN;

/* Problem 7.8 */
/*********************************************************
 Create the co_vary data set.
 *********************************************************/
DATA co_vary; 
     DO I = 1 TO 20; 
       DO GROUP = 'A','B';  
           SUBJ + 1;      
           IQ = INT(RANNOR(124)*10 + 120 + 15*(GROUP EQ 'A'));
           SCORE = INT(.7*IQ + RANNOR(0)*10 + 100 + 10*(GROUP EQ 'B'));  
           OUTPUT;    
       END;  
     END;  
     DROP I;
RUN;

PROC PRINT data = co_vary NOOBS;
   TITLE 'The co_vary data set';
RUN;

/* Compute correlation between IQ and SCORE */
PROC CORR data = co_vary NOSIMPLE;
    VAR IQ SCORE;
    TITLE "IQ vs. Score Correlation";
RUN;

/* Conduct t-tests comparing the two groups on IQ and SCORE */
PROC TTEST data = co_vary;
    CLASS GROUP;
    VAR IQ SCORE;
    TITLE "IQ and Score T-tests";
RUN;

/* Test for homogeneity of slopes */
PROC GLM data = co_vary;
    CLASS GROUP;
    MODEL SCORE = GROUP IQ GROUP*IQ;
    TITLE "Slope Homogeneity Test";
RUN;

/* Conduct analysis of covariance */
PROC GLM data = co_vary;
    CLASS GROUP;
    MODEL SCORE = GROUP IQ;
    LSMEANS GROUP / ADJUST = TUKEY;
    TITLE "ANCOVA: Group vs. Score, IQ Adjusted";
RUN;
