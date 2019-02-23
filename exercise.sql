
use University;
#select courseID from Section;
#delete  from Course  where CourseID ='sadfsafsa';
#delete  from Course  where CourseID not in(
#select courseID from Section);

#Find the highest salary of any instructor
#select Max(Salary) from Instructor

#Find all instructors earning the highest salary.
#There might be more than one with the same
#salary
#select InstName,salary from Instructor where salary > (select AVG(salary) from Instructor)

#Delete courses BIO-101 and BIO-301 in the Takes table.
#Delete from Takes where CourseID in ('BIO-101','BIO-301')

#Find those students who have not taken a course.
#select StudID,StudName from Student where StudID not in (Select StudID from Takes)
#Find the names of those departments which have
#a budget which is higher than those for all other departments
#select * from Department where Budget > All(select AVG(Budget) from Department);

#Find the names of those students who have the same name as some instructor. Use the SOME  operator for this
#select * from Student where StudName = some (select InstName from Instructor)
#Make another statement querying the same, but without using SOME
##select * from Student where StudName in (select InstName from Instructor)

#Delete all courses that have never been offered
#(that is, do not occur in the Section table

#select * from Student where StudName in (Select InstName from Instructor)


#we have two correction
#note there is a difference between naturlal join and inner join 
#Find the number of enrolments of each course
#section that was offered in Fall 2009.
#select STudyYear,CourseID,SectionID,Count(StudID) from Takes Where StudyYear=2009 Group By SectionID,CourseID ; 


#What is the course title and sum of course credits
#of the courses taught by instructor Brandt?
#select Title,sum(Credits) from Instructor I Natural join  Teaches Natural join Course  where I.instName='Brandt' group by Title

#select distinct(grade) from Takes
#create table GradePoints2(Grade VARCHAR(2),Points FLOAT(2,2) ,PRIMARY KEY(Grade))
#create table GradePoints(Grade VARCHAR(2),Points DECIMAL(1,1) ,PRIMARY KEY(Grade))
#insert into GradePoints2(Grade) select distinct(grade) from Takes#
#update GradePoint set Grade='A' where Grade='1.'; 
#delete from GradePoint where Grade='1.'
#select *  from GradePoint;
#insert into GradePoint values('A',4.0);
#insert into GradePoint values('A-',3.7);
#insert into GradePoint values('B+',3.5);
#insert into GradePoint values('B',3.0);
#insert into GradePoint values('B-',2.7);
#insert into GradePoint values('C+',2.5);
#insert into GradePoint values('C',2.0);
#insert into GradePoint values('C-',1.5);
#insert into GradePoint values('F',1.0);
#drop table GradePoints
#select Points from GradePoint where grade in ( select Grade from Course natural join Takes natural join Section); 
#alter table Takes add foreign key( Grade) REFERENCES GradePoint(Grade);
select StudName,Title,avg(Credits * Points) from Takes natural join GradePoint natural join Section natural join Course natural join Student Group by StudID order by avg(Credits * Points) desc;

#select count(*) from Student;
