/************** Problem 4.4 *******************/
OPTIONS NODATE NONUMBER FORMDLIM = '_';

DATA clinical;     
     length PATIENT VISIT DATE_VISIT 8;   
     retain DATE_VISIT WEIGHT;   
     DO PATIENT = 1 TO 25;     
	        /* Gender assignment: 50% Female, 50% Male */
            IF RANUNI(135) LT .5 THEN GENDER = 'Female'; 
            ELSE GENDER = 'Male';    
			/* Group assignment: 33% A, 33% B, 34% C */
            X = RANUNI(135);     
            IF X LT .33 THEN GROUP = 'A';    
            ELSE IF X LT .66 THEN GROUP = 'B';   
            ELSE GROUP = 'C';    
			/* Create a random visit sequence */
            DO VISIT = 1 TO INT(RANUNI(135)*5); 
               IF VISIT = 1 THEN DO;     
                 DATE_VISIT = INT(RANUNI(135)*100) + 17250; 
                 WEIGHT = INT(RANNOR(135)*10 + 150);  
              END;   
              ELSE DO;  
                 DATE_VISIT = DATE_VISIT + VISIT*(10 + INT(RANUNI(135)*50));
                 WEIGHT = WEIGHT + INT(RANNOR(135)*10);  
              END;      
              OUTPUT;   
              IF RANUNI(135) LT .2 THEN LEAVE;  
            END;
     END; 
     DROP X;  
     FORMAT DATE_VISIT DATE9.;
RUN;

PROC PRINT data = clinical;
RUN;

/* Problem 4.4 */

DATA clinical_diff;
    SET clinical;
	BY PATIENT;
/* calculate weight difference between each patient's visit */
    WEIGHT_DIFF = DIF(WEIGHT);
/* only display non-missing differences */
    IF not first.PATIENT THEN OUTPUT;
RUN;

/* print between difference data */
PROC PRINT data = clinical_diff NOOBS;
	TITLE 'Weight Difference From Previous Visit';
RUN;

/* Problem 4.6 */

PROC SORT data = clinical;
	BY PATIRNT DATE_VISIT;
RUN;

DATA change;
	SET clinical;
	BY PATIENT;
	RETAIN FIRST_WEIGHT FIRST_DATE;
	IF first.PATIENT THEN DO;
		FIRST_WEIGHT = WEIGHT;
		FIRST_DATE = DATE_VISIT;
	END;
	IF last.PATIENT THEN DO;
		WEIGHT_DIFF = WEIGHT - FIRST_WEIGHT;
		DAYS_DIFF = DATE_VISIT - FIRST_DATE;
		IF DAYS_DIFF > 0 THEN OUTPUT;
	END;
	DROP FIRST_WEIGHT FIRST_DATE;
RUN;

PROC PRINT data = change;
	TITLE 'Change Dataset';
RUN;

/* Problem 4.10 */

PROC MEANS data = clinical mean median stddev noprint chartype;
    CLASS GENDER GROUP;
    VAR WEIGHT;
    OUTPUT OUT = summary_data 
        MEAN = mean_weight 
        MEDIAN = median_weight 
        STDDEV = stddev_weight;
RUN;

DATA grand_mean gender_stats group_stats gender_group_stats;
    SET summary_data;
    
    IF _TYPE_ = '00' THEN OUTPUT grand_mean;
    ELSE IF _TYPE_ = '10' THEN OUTPUT gender_stats;
    ELSE IF _TYPE_ = '01' THEN OUTPUT group_stats;
    ELSE IF _TYPE_ = '11' THEN OUTPUT gender_group_stats;
RUN;

PROC PRINT data = summary_data;
    TITLE "Summary Dataset: Mean, Median, and Standard Deviation by Gender and Group";
RUN;

PROC PRINT data = grand_mean;
    TITLE "Grand Mean Statistics";
RUN;

PROC PRINT data = gender_stats;
    TITLE "Statistics by Gender";
RUN;

PROC PRINT data = group_stats;
    TITLE "Statistics by Group";
RUN;

PROC PRINT data = gender_group_stats;
    TITLE "Statistics by Gender and Group";
RUN;
