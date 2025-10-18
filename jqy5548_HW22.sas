/* Jackie Yang */
/* Homework #22 */
/* 11/03/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';

DATA next_appt;
    INFILE "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 22\FALLscheduling.dat";
    INPUT patient $ 1-16 @18 bdate mmddyy10. @30 lastappt mmddyy10.;
    FORMAT bdate mmddyy10. lastappt mmddyy10.;
	age = INTCK('YEAR', bdate, lastappt);
    IF age <= 45 THEN nextappt = INTNX('YEAR', lastappt, 2, 'S');
    ELSE nextappt = INTNX('YEAR', lastappt, 1, 'S');
    FORMAT nextappt mmddyy10.;
RUN;

PROC PRINT DATA = next_appt NOOBS;
    VAR patient lastappt age nextappt;
    TITLE "Patients' Next Appointment";
RUN;

DATA birthday_report;
    INFILE "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 22\FALLscheduling.dat";
    INPUT patient $ 1-16 @18 bdate mmddyy10. @30 lastappt mmddyy10.;
    FORMAT bdate mmddyy10. lastappt mmddyy10.;
	today = TODAY();
    IF MONTH(bdate) = MONTH(today) AND DAY(bdate) = DAY(today) THEN birthday_today = 'Yes';
    ELSE birthday_today = 'No';
    FORMAT today mmddyy10.;
RUN;

PROC PRINT DATA = birthday_report NOOBS;
    WHERE birthday_today = 'Yes';
    VAR patient lastappt bdate today;
    TITLE "Patients with a Birthday Today";
RUN;

DATA day_report;
    INFILE "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 22\FALLscheduling.dat";
    INPUT patient $ 1-16 @18 bdate mmddyy10. @30 lastappt mmddyy10.;
    FORMAT bdate lastappt mmddyy10.;
	day_num = WEEKDAY(lastappt);
    FORMAT day $9.;

    SELECT (day_num);
        WHEN (1) day = 'Sunday';
        WHEN (2) day = 'Monday';
        WHEN (3) day = 'Tuesday';
        WHEN (4) day = 'Wednesday';
        WHEN (5) day = 'Thursday';
        WHEN (6) day = 'Friday';
        WHEN (7) day = 'Saturday';
    END;
RUN;

PROC PRINT data = day_report NOOBS;
    VAR patient lastappt day;
    TITLE "Patients' Last Appointment Day of the Week";
RUN;
