DATA dietdata;
	infile 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 480\Lesson04\dietdata.dat';
	input
		subj $ 1-3
		height $ 4-5
		wt_init 6-8
		wt_final 9-11;
	height_num = input(height, comma2.);
	height_num = height * 0.0254;
		bmi_init = (wt_init / 2.2) / (height_num ** 2);
	bmi_final = (wt_final / 2.2) / (height_num ** 2);
	bmi_diff = bmi_init - bmi_final;
	FORMAT bmi_init bmi_final bmi_diff 8.2;
/* BMI = weight (kg) / height(m) squared (only denominator)
		Convert lb to kg: Divide lb by 2.2.
		Convert in to m: Multiply in by 0.0254 */
RUN;

OPTIONS PS = 58 LS = 80;

PROC PRINT data = dietdata;
	TITLE 'Output Dataset: Diet Data';
RUN;

DATA temp;
    /* Define the variables */
    input abc def ghi jkl;
    
    /* Calculate values for different variables */
    one = abc + def - ghi + jkl;
    two = (ghi + jkl) - (abc - def);
    three = abc + jkl + (def - ghi);
    four = abc + jkl + def / ghi;
    five = (abc + def) / (ghi + jkl);

  	/* Read the supposed values of initial variables */
    DATALINES;
    10 5 2 4
    ;
    
    OUTPUT;
RUN;

PROC PRINT data=temp;
    TITLE 'Output Dataset: temp';
RUN;
