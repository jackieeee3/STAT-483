OPTIONS

LIBNAME STAT483 "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 480\Lesson10";
/* Creating data set called analysis */
DATA analysis;
    SET STAT483.analysis;
RUN;
/* Creating value formats for sex and income */
PROC FORMAT;
    VALUE sexfmt 1 = 'Male'
                 2 = 'Female';
    VALUE incomefmt 1 = 'LT $30,000'
                    2 = 'GE $30,000';
RUN;
/*  */
PROC REPORT data = STAT483.analysis NOWINDOWS HEADLINE SPLIT = '*';
    TITLE 'ICDB Study Pain Score';
    COLUMN sex income n purg_1;
    DEFINE sex / group 'Gender' left FORMAT = sexfmt.;
	DEFINE income / group 'Income Range' FORMAT = incomefmt.;
    DEFINE n / 'Household Income*GE $30,000  LT $30,000' width = 30 center FORMAT = incomefmt.;
    DEFINE purg_1 / 'Pain*Score' right;
    DEFINE purg_1 / mean format = comma5.3;
RUN;

DATA parks;
	INFILE "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 480\Lesson10\natparks.dat";
		INPUT
		ParkName $ 1-21
		Type $ 23-24
		Region $ 26-29
		Museums 31
		Camping 33-34
	;
RUN;

PROC REPORT data = parks NOWINDOWS;
    TITLE 'National Parks';
    COLUMN Region Museums Camping Facilities;
    DEFINE Region / group width = 7;
    DEFINE Museums / center;
    DEFINE Camping / center;
    DEFINE Facilities / computed width = 15 center;

    COMPUTE Facilities;
        Facilities = Museums.sum + Camping.sum;
    ENDCOMP;
RUN;
