/* Jackie Yang */
/* Homework #32 */
/* 12/07/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';
LIBNAME STAT483 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 482\Lesson 32';

PROC SQL;
TITLE "Within Treatment Group Differences on the First Visit";
   SELECT 
      patient,
      gender,
      v_date AS First_visit format = date9.,
      mean(weight) AS Group_Average,
      weight - calculated Group_Average AS Within_Group_Diff
   FROM 
      STAT483.clinical
   WHERE 
      visit = 1
   GROUP BY
      GROUP
   ORDER BY 
      v_date;
QUIT;

PROC SQL;
TITLE 'AVG_MCV';
   CREATE TABLE AVG_MCV AS
   SELECT 
      b.country,
      avg(h.mcv) AS avg_MCV
   FROM 
      STAT483.back AS b
   INNER JOIN 
      STAT483.backhem AS h
   ON 
      b.subj = h.subj
   WHERE 
      h.mcv is NOT missing
   GROUP BY 
      b.country
   having 
      avg(h.mcv) between 80 AND 96;
QUIT;

PROC SQL;
   SELECT * 
   FROM AVG_MCV;
QUIT;
