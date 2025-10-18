/* Jackie Yang */
/* Homework #28 */
/* 11/16/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_' LINESIZE = 130;

/* Problem 6.2 */
DATA reading;
	INFILE "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 482\Lesson 28\cody_chap06_num02.dat";
	INPUT program $ score1-score14;
RUN;

PROC PRINT data = reading NOOBS;
	TITLE 'Reading Dataset';
RUN;

DATA reading_long;
    SET reading;
    ARRAY scores{14} score1-score14;
    DO i = 1 TO 14;
        score = scores{i};
        OUTPUT;
    END;
    DROP score1-score14 i;
RUN;

PROC TTEST data = reading_long;
    CLASS program;
    VAR score;
    TITLE "Reading Speed T=test";
RUN;

PROC NPAR1WAY data = reading_long WILCOXON;
    CLASS program;
    VAR score;
    EXACT WILCOXON;
    TITLE "Reading Speed Wilcoxon Test";
RUN;

/* Problem 6.4 */
DATA QUES6_4;  
    DO GROUP = 'A','B','C';   
      DO I = 1 TO 10;      
         X = ROUND(RANNOR(135)*10 + 300 + 5*(GROUP EQ 'A') - 7*(GROUP EQ 'C')); 
         Y = ROUND(RANUNI(135)*100 + X);  
         OUTPUT;    
      END;   
    END;   
    DROP I;
RUN;

PROC TTEST data = QUES6_4;
    WHERE GROUP IN ('A', 'C');
    CLASS GROUP;
    VAR X Y;
    TITLE "Group A and C T-test";
RUN;

/* Problem 6.6 */
DATA diet;
    INFILE "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 482\Lesson 28\cody_chap06_num06.dat" PAD;
    INPUT time $ weight1-weight12;
RUN;

DATA diet_long;
    SET diet;
    ARRAY weights[12] weight1-weight12;
    DO subject = 1 TO 12;
        weight = weights[subject];
        OUTPUT;
    END;
    DROP weight1-weight12;
RUN;

DATA PAIRED_WEIGHTS;
    ARRAY Before[12] (300 350 190 400 244 321 330 250 190 160 260 240);
    ARRAY After[12]  (290 331 200 395 240 300 332 242 185 158 256 220);
    
    DO Subject = 1 TO 12;
        Before_Weight = Before[Subject];
        After_Weight = After[Subject];
        OUTPUT;
    END;
RUN;

PROC TTEST data = PAIRED_WEIGHTS;
    PAIRED Before_Weight*After_Weight;
    TITLE 'South Beach Diet Paired T-test';
RUN;

PROC TTEST data = diet_long;
    CLASS time;
    VAR weight;
    TITLE "South Beach Diet Non-paired T-test";
RUN;
