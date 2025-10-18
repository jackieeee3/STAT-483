OPTIONS FORMDLIM = 'X';

DATA bonescore1;
	infile 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\STAT 480\Lesson05\Bonescor2.dat';
	input
	/* Read in the data from the .dat file */
		singh 1
		ccratio 3-5
		csi 7-9
		calcar 11-12
		bone 14-15
		dpa 17-21;
	/* If-Then-Else statements defined by criteria */
	if singh <= 4 then flag1 = 1;
		else if singh > 4 and singh <= 5 then flag1 = 2;
		else if singh > 5 then flag1 = 3;
	if ccratio > 0.67 then flag2 = 1;
		else if ccratio > 0.52 and ccratio <= 0.67 then flag2 = 2;
		else if ccratio <= 0.52 then flag2 = 3;
	if csi <= 0.55 then flag3 = 1;
		else if csi > 0.55 and csi <= 0.65 then flag3 = 2;
		else if csi > 0.65 then flag3 = 3;
	if calcar <= 6 then flag4 = 1;
		else if calcar > 6 and calcar <= 7 then flag4 = 2;
		else if calcar > 7 then flag4 = 3;
	ourscore = flag1 + flag2 + flag3 + flag4;

RUN;

PROC PRINT data = bonescore1;
	TITLE 'Output Dataset: Bone Score';
RUN;

DATA bonescore2;
	infile 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\Lesson05\Bonescor2.dat';
	input
	/* Read in the data from the .dat file */
		singh 1
		ccratio 3-5
		csi 7-9
		calcar 11-12
		bone 14-15
		dpa 17-21;
	/* If-Then-Else statements defined by criteria */
	if singh <= 4 then flag1 = 1;
		else if singh > 4 and singh <= 5 then flag1 = 2;
		else if singh > 5 then flag1 = 3;
		else if singh = . then flag1 = .;
	if ccratio > 0.67 then flag2 = 1;
		else if ccratio > 0.52 and ccratio <= 0.67 then flag2 = 2;
		else if ccratio <= 0.52 then flag2 = 3;
		else if ccratio = . then flag2 = .;
	if csi <= 0.55 then flag3 = 1;
		else if csi > 0.55 and csi <= 0.65 then flag3 = 2;
		else if csi > 0.65 then flag3 = 3;
		else if csi = . then flag3 = .;
	if calcar <= 6 then flag4 = 1;
		else if calcar > 6 and calcar <= 7 then flag4 = 2;
		else if calcar > 7 then flag4 = 3;
		else if calcar = . then flag4 = .;
	ourscore = flag1 + flag2 + flag3 + flag4;

RUN;

PROC PRINT data = bonescore2;
	TITLE 'Output Dataset: Bone Score';
RUN;

DATA bonescore3;
	infile 'C:\ESSENTIALS\School OS\Junior Fall 2024\STAT483\Lesson05\Bonescor2.dat';
	input
	/* Read in the data from the .dat file */
		singh 1
		ccratio 3-5
		csi 7-9
		calcar 11-12
		bone 14-15
		dpa 17-21;
	/* If-Then-Else statements defined by criteria */
	if singh = . then flag1 = .;
		else if singh <= 4 then flag1 = 1;
		else if singh > 4 and singh <= 5 then flag1 = 2;
		else if singh > 5 then flag1 = 3;
	if ccratio = . then flag2 = .;
		else if ccratio > 0.67 then flag2 = 1;
		else if ccratio > 0.52 and ccratio <= 0.67 then flag2 = 2;
		else if ccratio <= 0.52 then flag2 = 3;
	if csi = . then flag3 = .;
		else if csi <= 0.55 then flag3 = 1;
		else if csi > 0.55 and csi <= 0.65 then flag3 = 2;
		else if csi > 0.65 then flag3 = 3;
	if calcar = . then flag4 = .;
		else if calcar <= 6 then flag4 = 1;
		else if calcar > 6 and calcar <= 7 then flag4 = 2;
		else if calcar > 7 then flag4 = 3;
	ourscore = flag1 + flag2 + flag3 + flag4;

RUN;

PROC PRINT data = bonescore3;
	TITLE 'Output Dataset: Bone Score';
RUN;
