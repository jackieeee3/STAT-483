LIBNAME STAT483 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\Lesson02'; /* Specify SAS data library*/

DATA STAT483.grades;
  infile 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\Lesson02\grades.dat';
  input id 1-2 gender $ 3 exam1 4-5 exam2 6-7 grade $ 8;
RUN;

PROC PRINT data=STAT483.grades;
  title 'Output dataset: Grades';
RUN;
