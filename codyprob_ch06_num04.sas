DATA QUES6_4;  
    DO GROUP = 'A','B','C';   
      DO I = 1 TO 10;      
         X = ROUND(RANNOR(135)*10 + 300 + 5*(GROUP EQ 'A') - 7*(GROUP EQ 'C')); 
         Y = ROUND(RANUNI(135)*100 + X);  
         OUTPUT;    
      END;   
    END;   
    DROP I;
RUN;

PROC TTEST data = QUES6_4;
    WHERE GROUP IN ('A', 'C');
    CLASS GROUP;
    VAR X Y;
    TITLE "Group A and C T-test";
RUN;
