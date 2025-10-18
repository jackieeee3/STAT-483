/* Jackie Yang*/
/* Homework #13 */
/* 10/6/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';

LIBNAME STAT483 "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 481\Lesson 13";
/* Sorts the dataset by Vendor */
PROC SORT data = STAT483.tours out = sorted_bookings;
	by Vendor;
RUN;
/* Create a new dataset that is the sorted dataset */
DATA bookings;
	SET sorted_bookings;
	BY Vendor;
		IF first.Vendor THEN TotalBookings = 0;
		TotalBookings + Bookings;
		IF last.Vendor;
		DROP Country LandCost Bookings;
RUN;

PROC PRINT data = bookings NOOBS;
	TITLE 'Total Bookings by Vendor';
RUN;
/* Set up select conditions for determining age groups */
DATA walk;
	SET STAT483.walk;
	LENGTH AgeGroup $7;
	SELECT;
		WHEN (Age < 18) AgeGroup = 'Youth';
		WHEN (18 <= Age <= 62) AgeGroup = 'Adult';
		WHEN (Age > 62) AgeGroup = 'Senior';
		OTHERWISE AgeGroup = '.';
	END;
RUN;
/* Sort by age group and time */
PROC SORT data = walk;
	BY AgeGroup Time;
RUN;
/* Take the walk dataset and output the fastest time for each age group */
DATA fastest_times;
	SET walk;
	BY AgeGroup;
	IF first.AgeGroup THEN OUTPUT;
RUN;
/* Print the fastest times */
PROC PRINT data = fastest_times NOOBS;
	TITLE 'Winners in Each Age Group';
	VAR ID Age Time AgeGroup;
RUN;
