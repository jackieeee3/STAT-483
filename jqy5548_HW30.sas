/* Jackie Yang */
/* Homework #30 */
/* 11/22/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';

DATA statin;  
    DO SUBJ = 1 TO 20;   
        IF RANUNI(1557) LT .5 THEN GENDER = 'FEMALE';  
                              ELSE GENDER = 'MALE'; 
        IF RANUNI(0) LT .3 THEN DIET = 'HIGH FAT'; 
                           ELSE DIET = 'LOW FAT';      
        DO DRUG = 'A','B','C';     
                LDL = ROUND(RANNOR(1557)*20 + 110 
                             + 5*(DRUG EQ 'A') 
                             - 10*(DRUG EQ 'B') 
                             - 5*(GENDER EQ 'FEMALE')  
                             + 10*(DIET EQ 'HIGH FAT'));   
                HDL = ROUND(RANNOR(1557)*10 + 20      
                             + .2*LDL         
                             + 12*(DRUG EQ 'B'));   
                TOTAL = ROUND(RANNOR(1557)*20 + LDL + HDL + 50  
                             -10*(GENDER EQ 'FEMALE')     
                             +10*(DIET EQ 'HIGH FAT'));   
                OUTPUT;  
        END;  
    END;
RUN;

/* Problem 8.2 */
PROC PRINT DATA = statin NOOBS;
   TITLE 'The statin data set';
RUN;

PROC SORT DATA = statin;
  BY SUBJ DRUG;
RUN;

PROC GLM DATA = statin;
  CLASS SUBJ DRUG;
  MODEL HDL = DRUG SUBJ;
  REPEATED DRUG 3 (A B C) / SUMMARY PRINTE;
  TITLE 'One-Way Repeated Measures ANOVA for HDL';
RUN;

/* After performing the GLM procedure, the p-value for DRUG is 0.003 < 0.05, indicating that
there is a significant difference in HDL levels among the three drugs (A, B, C) at the
95% significance level. But, the p-value for the regression model is 0.0666 > 0.05, indicating
that the regression model is not statistically significant (drug does not have a statistically
signifcant effect on HDL. */

PROC SORT DATA = statin;
  BY SUBJ DRUG;
RUN;

PROC TRANSPOSE DATA = statin OUT = fatstatin PREFIX = hdl;
  BY SUBJ;
  ID DRUG;
  VAR HDL;
RUN;

DATA fatstatin;
  SET fatstatin;
  RENAME hdlA = hdl1 hdlB = hdl2 hdlC = hdl3;
  DROP _NAME_;
RUN;

PROC PRINT DATA = fatstatin;
  TITLE 'Fatstatin Dataset';
RUN;

PROC GLM DATA = fatstatin;
  CLASS SUBJ;
  MODEL hdl1 hdl2 hdl3 = / NOUNI;
  REPEATED DRUG 3 (1 2 3) / SUMMARY PRINTE;
  CONTRAST 'A vs B' DRUG 1 -1 0; /* Compare Drug A to Drug B */
  CONTRAST 'A vs C' DRUG 1 0 -1; /* Compare Drug A to Drug C */
  CONTRAST 'B vs C' DRUG 0 1 -1; /* Compare Drug B to Drug C */
  TITLE 'Repeated Measures ANOVA with Pairwise Comparisons for HDL';
RUN;

/* Based on the p-values for comparisons, they indicate that there is a statistically
significant difference in HDL levels due to the different drugs. (A to C and B to C) */

/* Problem 8.4 */
DATA statin;  
    DO SUBJ = 1 TO 20;   
        IF RANUNI(1557) LT .5 THEN GENDER = 'FEMALE';  
                              ELSE GENDER = 'MALE'; 
        IF RANUNI(0) LT .3 THEN DIET = 'HIGH FAT'; 
                           ELSE DIET = 'LOW FAT';      
        DO DRUG = 'A','B','C';     
                LDL = ROUND(RANNOR(1557)*20 + 110 
                             + 5*(DRUG EQ 'A') 
                             - 10*(DRUG EQ 'B') 
                             - 5*(GENDER EQ 'FEMALE')  
                             + 10*(DIET EQ 'HIGH FAT'));   
                HDL = ROUND(RANNOR(1557)*10 + 20      
                             + .2*LDL         
                             + 12*(DRUG EQ 'B'));   
                TOTAL = ROUND(RANNOR(1557)*20 + LDL + HDL + 50  
                             -10*(GENDER EQ 'FEMALE')     
                             +10*(DIET EQ 'HIGH FAT'));   
                OUTPUT;  
        END;  
    END;
RUN;

PROC SORT DATA = statin;
    BY SUBJ DRUG;
RUN;

PROC GLM DATA = statin;
    CLASS SUBJ GENDER DRUG;
    MODEL HDL = GENDER DRUG GENDER*DRUG / SS3;
    REPEATED DRUG 3 (A B C) / SUMMARY PRINTE;
    TITLE 'Two-Way Repeated Measures ANOVA for HDL with GENDER and DRUG';
RUN;

PROC GPLOT DATA = statin;
   PLOT HDL*DRUG = GENDER / VAXIS = LABEL; /* Plot HDL by DRUG with GENDER as symbol */
   TITLE 'Interaction Plot for HDL by DRUG and GENDER';
RUN;

/* The p-value for GENDER is 0.1239, indicating that GENDER is significant and the
relationship between DRUG and HDL is not consistent across GENDER. As for DRUG, the
p-value is 0.0029, indicating that the type of drug significantly affects HDL levels.
Lastly, for DRUG*GENDER, the p-value is 0.0486, indicating that the effect of the drug
on HDL differes between males and females */


