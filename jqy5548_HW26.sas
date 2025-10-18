/* Jackie Yang */
/* Homework #26 */
/* 11/10/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';

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
	BY PATIENT DATE_VISIT;
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
