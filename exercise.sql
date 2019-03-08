
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





use University;



#drop procedure InstBackup2;
#drop table InstLog;
/*
 DELIMITER //
create function CPRTest(CPRNumber VARCHAR(10)) RETURNS boolean
BEGIN 
DECLARE num INT;
SET num = (((4 * mid(CPRNumber,1,1))+
(3 * mid(CPRNumber,2,1)) +
(2 * mid(CPRNumber,3,1)) +
(7 * mid(CPRNumber,4,1)) + 
(6 * mid(CPRNumber,5,1))
+(5 * mid(CPRNumber,6,1))
+ (4 * mid(CPRNumber,7,1))
 + (3 * mid(CPRNumber,8,1)) 
 + (2 * mid(CPRNumber,9,1))
 + (1 * mid(CPRNumber,10,1)))%11);

RETURN num;
END; //
DELIMITER;
#drop function CPRTest;

select CPRTest('1005873661');




*/
#create table get112 like Instructor;

#select * from get112;
#drop procedure InstBackup;

#call InstBackup13();
#insert into Instructor values (2345,'Ahma2d','Finance',40000);
#show triggers in University;
#call InstBackup();
#call InstBackup();

#select * from InstLog;
 

#create table InstLog(currentDate Date);

 
#drop procedure instBackup16;


#select * from instOld4;
DELIMITER $$
create procedure InstBackup16()
BEGIN
create table instOld16 like InstLog;
insert into instOld16 select * from InstLog;
Delete from InstLog;
select * from instOld16;
END; $$
DELIMITER
#drop table if exists InstLog;




use University;
#create table InstLog (DateofAdd VARCHAR(20));
#select * from InstOld;

#drop table if exists InstLog;
DELIMITER $$
create procedure InstBackup1()
BEGIN
DECLARE vSQLSTATE char(5) DEFAULT '00000';
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN 
GET DIAGNOSTICS CONDITION 1
vSQLSTATE = RETURNED_SQLSTATE;
END;
START TRANSACTION;
delete from InstOld;
create table InstOld like InstLog;
insert into InstOld select * from InstLog;
Delete from InstLog;
SELECT vSØLSTATE;
IF vSQLSTATE='00000' then COMMIT;
	else ROLLBACK;
    END IF;
    
END; $$
DELIMITER



use University;
#create table InstLog (DateofAdd VARCHAR(20));
#select * from InstOld;

#insert Instructor values(43345,'amar','Finance',444);
#select * from InstLog;
#Set SQL_SAFE_UPDATES=0;
#Call InstBackup1;
#select * from InstOld;
#call InstBackup1;

create table InstLog like Instructor;
alter table InstLog Add logTime TIMESTAMP(6);
create EVENT sfs on schedule EVERY 1 week starts '2016-02-21 00:00:01' 
DO call InstBackup1;

SET GLOBAL event_scheduler = 1;
show variables like 'event_scheduler';




#create table DiceRolls (RollNo int,DiceEyes int);

#alter table DiceRolls Modify Column	RollNo Int  auto_Increment primary key;



#drop event dice;
#select * from DiceRolls where DiceEyes=6;
#select Distinct DiceEyes,count(*) from DiceRolls where DiceEyes=6  and RollNo < 20 ;

