elect * from Section where Building='Taylor';
#select * from Department;
#update Department set Building='Taylor' where DeptName='Finance' ;
#lect * from Takes where CourseIDa='CS-102' ;
#select c.CourseID,t.StudyYear,t.Grade from Course c natural join  Takes t natural join Student s where s.StudName='Shankar';
#insert Course values('CS-103','Monthly Seminar','Comp. Sci.',0);
#update Section Set StudyYear='2010' where CourseID='CS-102';
#Select * from Student where Student.DeptName='Comp. Sci.' 
#select * from Section where CourseID='CS-102'
#insert into Takes (StudID,SectionID,CourseID,Semester,StudyYear)
 #Select StudID,'1','CS-102','Fall','2010' from Student where Student.DeptName='Comp. Sci.';
 #delete from  Takes where CourseID='CS-103'
 #use University;
#select * from Takes;
#select STudyYear,CourseID,Count(StudID) from Takes Where StudyYear=2009 Group By CourseID ; 
#select sum(C.Credits),C.Title from Department D join Instructor I join Course C where I.InstName='Brandt' group by C.Title
use University;
#select courseID from Section;
#delete  from Course  where CourseID ='sadfsafsa';
#delete  from Course  where CourseID not in(
#select courseID from Section);
#select Max(Salary) from Instructor
#select InstName,salary from Instructor where salary > (select AVG(salary) from Instructor)
#Delete from Takes where CourseID in ('BIO-101','BIO-301')
#select StudID,StudName from Student where StudID not in (Select StudID from Takes)
#select * from Department where Budget > All(select AVG(Budget) from Department);
#select * from Student where StudName = some (select InstName from Instructor)
select * from Student where StudName in (Select InstName from Instructor)
