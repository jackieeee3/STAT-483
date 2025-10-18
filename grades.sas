DATA grades;
    do i = 1 to 100;
       id = i;
       grade = int(100*ranuni(123)+1);
       output;
    end;
RUN;
