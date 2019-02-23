
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
