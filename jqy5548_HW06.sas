OPTIONS PS = 38 NONUMBER NODATE;

DATA kidsbooks;
    INFILE "C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 480\Lesson06\kidsbooks.txt";
    INPUT
        title $ 1-20
        author $ 22-40
        publisher $ 43-58
        @61 publication_date mmddyy10.
        @72 price dollar6.2
        pages 79-80;
    ppp = price / pages;
	FORMAT price dollar6.2;
	FORMAT ppp dollar5.2;
	FORMAT publication_date DATE9.;
RUN;

PROC SORT data = kidsbooks OUT = srted_kidsbooks;
	by descending price;
RUN;

PROC PRINT data = srted_kidsbooks NOOBS DOUBLE LABEL SPLIT = '/';
	LABEL 
		title = 'Title'
		author = 'Author'
		publisher = 'Publisher'
		publication_date = 'Publication/Date'
		price = 'Price'
		pages = 'No. of/Pages'
		ppp = 'Price/Per Page';
	TITLE "Popular Books for Children";
		var title author price pages ppp title publisher publication_date;
		WHERE ppp > 0.30;
		SUM price;
	FOOTNOTE1 'Price obtained from Amazon.com';
RUN;
