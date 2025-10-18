/*********************************************************
 Create the co_vary data set.
 *********************************************************/
DATA co_vary; 
     DO I = 1 TO 20; 
       DO GROUP = 'A','B';  
           SUBJ + 1;      
           IQ = INT(RANNOR(124)*10 + 120 + 15*(GROUP EQ 'A'));
           SCORE = INT(.7*IQ + RANNOR(0)*10 + 100 + 10*(GROUP EQ 'B'));  
           OUTPUT;    
       END;  
     END;  
     DROP I;
RUN;

PROC PRINT data = co_vary NOOBS;
   title 'The co_vary data set';
RUN;
