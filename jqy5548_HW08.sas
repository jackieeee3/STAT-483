/* Jackie Yang Homework #08 Fall 2024 */

OPTIONS PS = 58 NODATE NONUMBER; /* 1)No semicolon for OPTIONS. 2)LS is too small. 3)NODATE spelled NODAT */

DATA sales; /* 4)Extra f's in sales */
    INPUT /* 5)INPUT spelled IMPUT */
		weekof ddmmyy8. /* 6)Date formatted mmddyy8. instead of ddmmyy8. */
		Store $ 
		Mon 
		Tues 
		Wed 
		Thur 
		Fri; 
	AvgSales = (Mon + Tues + Wed + Thur + Fri) / 5; 	/* 7)Thur has an s. 8)AvgSales divided by 4 instead of 5 */ 
	length Group $7; /* 9)Not long enough to print Average */
	LABEL weekof = 'Date';
	/* 10)LABEL spelled lable. 11)No apostrophe after 'Date' */
	FORMAT weekof ddmmyy8.;
	if missing(AvgSales) then Group = 'N/A'; 
	else if AvgSales LE 605 then Group = 'Low';
	else if 605 LT AvgSales LE 750 then Group = 'Average'; 		
	else if AvgSales GT 750 then Group = 'High'; /* 12)Letter O instead of 0 */ 

	if Store = 110 then region = 'South'; 
	else if Store = 111 then region = 'South';
	else if Store = 112 then region = 'North';
	else if Store = 113 then region = 'North';
	else if Store = 114 then region = 'North'; /* 13)No apostrophes for North */
/* 14)The variables Mon Tues Wed Thir Fri are dropped but are needed for calculations */ 
/* 15)No semicolon after DATALINES */
DATALINES;
10/12/07 110 412 532 641 701 802
10/12/07 111 478 567 699 789 821
10/12/07 112 399 501 650 712 812
10/12/07 113 421 532 698 756 872
10/12/07 114 401 510 612 721 899
17/12/07 110 710 725 789 721 799
17/12/07 111 689 701 729 703 721
17/12/07 112 899 812 802 738 712
17/12/07 113 700 712 748 765 801
17/12/07 114 699 799 899 608 .
24/12/07 110 340 333 321 401 490
24/12/07 111 801 793 721 763 798
24/12/07 112 598 798 684 502 412
24/12/07 113 980 921 832 812 849
24/12/07 114 798 709 721 799 724
31/12/07 110 487 321 399 312 321
31/12/07 111 501 532 598 581 601
31/12/07 112 598 512 540 523 549
31/12/07 113 601 625 674 698 601
31/12/07 114 900 805 700 601 811
;
/* 16)Letter O in first observation for store number */
/* 17)Missing data value for Fri for 17/12/07 114 699 799 899 608 (blank space instead of period) */ 
RUN; 
PROC PRINT data = sales LABEL; /* 18)Missing semicolon */
	TITLE 'Sales Data'; /* 19)Missing title */
		var weekof Store AvgSales Group region;
RUN; 
/* 20)PROC PRINT needs to be in separate line. No need for forward slash (/)*/
