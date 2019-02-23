
use University;
#create table Testscores(Student VARCHAR(45),Test CHAR,Score int);

#insert into Testscores values('Brandt','A',47);
/*
insert into Testscores values('Brandt','B',50);
insert into Testscores(Student,Test) values('Brandt','C');
insert into Testscores(Student,Test) values('Brandt','D');
insert into Testscores values('Chavez','A',52);
insert into Testscores values('Chavez','B',45);
insert into Testscores values('Chavez','C',53);
insert into Testscores(Student,Test) values('Chavez','D');
*/
#select * from Testscores;
select Student,avg(score) from Testscores   group by Student having avg(Score) > 49
