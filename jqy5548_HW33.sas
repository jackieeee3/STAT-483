/* Jackie Yang */
/* Homework #33 */
/* 12/07/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';

DATA grades;
    DO i = 1 to 100;
       id = i;
       grade = int(100*ranuni(123)+1);
       OUTPUT;
    END;
RUN;

PROC PRINT DATA = grades;
	TITLE 'Grades Dataset';
RUN;

%LET Cutoff = 70;

DATA grades_with_status;
    SET grades;
    IF grade > &Cutoff THEN Status = 2;
    ELSE Status = 1;
RUN;

PROC FORMAT;
    VALUE StatusFmt
        1 = 'Failed'
        2 = 'Passed';
RUN;

PROC FREQ DATA = grades_with_status;
    TABLES Status / NOCUM;
    FORMAT Status StatusFmt.;
    TITLE "Grade Distribution When Cutoff = 70";
RUN;

%MACRO GRADECUTS(cutoff);
    DATA grades_with_status;
        SET grades;
        IF grade > &cutoff THEN Status = 2;
        ELSE Status = 1;
    RUN;

    PROC FORMAT;
        value StatusFmt
            1 = 'Failed'
            2 = 'Passed';
    RUN;

    PROC FREQ data = grades_with_status;
        TABLES Status / nocum;
        FORMAT Status StatusFmt.;
        TITLE "Grade Distribution When Cutoff = &cutoff";
    RUN;
%MEND GRADECUTS;

/* Invoke the macro with cutoff values 60, 70, and 80 */
%GRADECUTS(60);
%GRADECUTS(70);
%GRADECUTS(80);
