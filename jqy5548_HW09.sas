OPTIONS NODATE NONUMBER FORMDLIM = ".";
LIBNAME icdb 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 480\Lesson09';
/* Specify variables to keep */
DATA back;
	SET icdb.back;
	KEEP subj r_id country race state mar_st;
RUN;
/* Using codebook for states */
DATA states;
	SET icdb.state_cd (rename = (code = start name=label));
	fmtname = 'stat2fmt';
RUN;

PROC FORMAT CNTLIN = states;
RUN;
/* Picture and value formts for variables */
PROC FORMAT;
	PICTURE subjpix LOW-HIGH = '00-00000' (prefix = '#');
	PICTURE r_idpix LOW-HIGH = '0000' (fill = '0');
	VALUE countryfmt 1 = 'United States'
		2 = 'Canada'
		3 = 'Mexico'
		OTHER = 'Other';
	VALUE racefmt 4 = 'White'
		3 = 'Black'
		OTHER = 'Other';
	VALUE mar_stfmt 1 = 'Married'
		2 = 'Living with a partner'
		3 = 'Separated'
		4 = 'Divorced'
		5 = 'Widowed'
		6 = 'Never married';
RUN;
/* Prints the first 1 observations of the dataset along with observation number */
PROC PRINT data = back (OBS = 10);
	TITLE "Subjects";
	FORMAT subj subjpix.;
	VAR subj;
RUN;
/* Display frequency table for state */
PROC FREQ data = back;
	TITLE 'Frequency tables for the BACK data set';
	FORMAT state stat2fmt.;
	TABLE state / MISSING;
RUN;
/* Display frequency tables for other variables */ 
PROC FREQ data = back;
	TITLE 'Frequency tables for the BACK data set';
	FORMAT race racefmt.;
	FORMAT mar_st mar_stfmt.;
	FORMAT r_id r_idpix.;
	FORMAT country countryfmt.;
	TABLE country race mar_st r_id / MISSING;
RUN;
/* List of all formats */ 
PROC FORMAT FMTLIB;
   title 'Selected Formats from WORK.FORMAT Catalog';
   select countryfmt mar_stfmt racefmt r_idpix stat2fmt subjpix;
RUN;
