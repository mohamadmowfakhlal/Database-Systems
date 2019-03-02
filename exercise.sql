
use University;
#select count(*) from Student;
#select count(*) from Department;
#select count(*) from Student S natural join Department D
#4-1-1
#select S.studID,S.StudName,D.Building from Student S natural join Department D
#4-1-2
#select * from Teaches;
#select * from Instructor;
#select I.instID,I.InstName,count(SectionID) as sections from Instructor I natural left outer join Teaches T group by InstID;
#select T.instID,sum(SectionID) from Teaches T group by InstID;
#select instID,InstName,(select count(SectionID) from Teaches T where T.instID=I.instID) from Instructor I;
#create view SeniorStudents as 
#select StudName,StudID from Student S where S.TotCredits > 100
#select * from SeniorStudents
create view CreditView11ssddd as(
select T.StudID,sum(C.Credits) as YEEE,T.StudyYear from Takes T natural left outer join Course C group by T.StudID,T.StudyYear)
#select * from CreditView1;








2-3-2019
use University;
#select count(*) from Student;
#select count(*) from Department;
#select count(*) from Student S natural join Department D
#4-1-1
#select S.studID,S.StudName,D.Building from Student S natural join Department D
#4-1-2
#select * from Teaches;
#select * from Instructor;
#select I.instID,I.InstName,count(SectionID) as sections from Instructor I natural left outer join Teaches T group by InstID;
#select T.instID,sum(SectionID) from Teaches T group by InstID;
#select instID,InstName,(select count(SectionID) from Teaches T where T.instID=I.instID) from Instructor I;
#create view SeniorStudents as 
#select StudName,StudID from Student S where S.TotCredits > 100
#select * from SeniorStudents
#create view CreditView11ssddd as(
#select T.StudID,sum(C.Credits) as YEEE,T.StudyYear from Takes T natural left outer join Course C group by T.StudID,T.StudyYear)
#select * from CreditView1;
#select DeptName,Count(InstID) from Department natural left outer join Instructor group by DeptName;
#select * from (Takes natural left outer join Student)  join Course using(CourseID);
#select * from Student;
#select studName,Title from (Takes natural join Student)join Course USING(courseID) order by studName;
#create view SeniorInstructor as 
#select InstID,InstName,DeptName from Instructor where salary > 80000
#select * from SeniorInstructor;
#create user 'Karen'@'localhost' identified by 'SetPassword';
#create user 'Linda'@'localhost' identified by 'SetPassword1';
#create user 'Susan'@'localhost' identified by 'SetPassword2';
#select user from mysql.user r;
#grant select on University.* TO 'Karen'@'localhost';
#grant All on University.* TO 'Linda'@'localhost';
#grant select on University.* TO 'Susan'@'localhost';
#show grants for 'Susan'@'localhost'
#drop user 'Linda'@'localhost';
#select * from mysql.user r;
