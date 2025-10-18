OPTIONS NODATE NONUMBER;

LIBNAME STAT483 "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 480\Lesson11";

/* Formatting race */ 
PROC FORMAT;
    VALUE racefmt 1 = 'AmIndian'
                 2 = 'Asian'
                 3 = 'Black'
                 4 = 'Caucasian'
                 5 = 'Multi-racial'
                 6 = 'Other';
RUN;

PROC MEANS data = STAT483.backhem maxdec = 2 MEAN STD MIN MAX NWAY;
    VAR mcv;
    CLASS race;
    FORMAT race racefmt.;
    OUTPUT out = mcvsummary (DROP = _TYPE_ _FREQ_)
            MIN = MinimumMCV
            MEDIAN = MedianMCV
            MAX = MaximumMCV
            N = SampleSize;
RUN;

PROC PRINT data = mcvsummary DOUBLE NOOBS;
    TITLE 'The summary data set';
RUN;
