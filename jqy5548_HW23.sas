/* Jackie Yang */
/* Homework #23 */
/* 11/03/2024 */

OPTIONS NODATE NONUMBER FORMDLIM = '_';

DATA address;
    INPUT #1 @1 line1 $50.
	      #2 @1 line2 $50.
		  #3 @1 line3 $50.;
DATALINES;
Mr.  Jason    Simmons
123  Sesame  Street
Madison, WI
Dr.    Justin  Case
78    River  Road
Flemington, NJ
Ms. Marilyn  Crow
777 Jewell   Avenue
Pittsburgh,    PA
;
RUN;

DATA formatted_address;
    SET address;
    name = CATS(':', CATX(' ', SCAN(line1, 2), SCAN(line1, 3)), ':');
    street = TRANWRD(TRANWRD(TRANWRD(CATX(' ', SCAN(line2, 1), SCAN(line2, 2), SCAN(line2, 3)),
    	'Road', 'Rd.'),
    	'Street', 'St.'),
    	'Avenue', 'Ave.');
    street = CATS(':', street, ':');
    city = CATX(', ', SCAN(line3, 1), SCAN(line3, 2));
    city = CATS(':', city, ':');
RUN;

PROC PRINT data = formatted_address NOOBS;
    VAR name street city;
    TITLE "The address data set";
RUN;

DATA string;
    input string $10.;
DATALINES;
123nj76543
892NY10203
876pA83745
;
RUN;

DATA new_string;
    SET string;
    x = INPUT(SUBSTR(string, 1, 2), 2.);
    y = INPUT(SUBSTR(string, 3, 1), 1.);
    state = UPCASE(SUBSTR(string, 4, 2));
    n1 = INPUT(SUBSTR(string, 6, 1), 1.);
    n2 = INPUT(SUBSTR(string, 7, 1), 1.);
    n3 = INPUT(SUBSTR(string, 8, 1), 1.);
    n4 = INPUT(SUBSTR(string, 9, 1), 1.);
    n5 = INPUT(SUBSTR(string, 10, 1), 1.);
    
RUN;

PROC PRINT data = new_string NOOBS;
    TITLE "The string data set";
RUN;
