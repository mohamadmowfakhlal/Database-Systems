use University;



DELIMITER //
create function CPRTest(CPRNumber VARCHAR(10)) RETURNS boolean
BEGIN 
DECLARE num INT;
DECLARE Saleable Boolean;
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


if STR_TO_DATE(('mid(CPRNumber,1,6)'), '%d,%m,%Y') IS NOT NULL and num = '1'
    THEN Set Saleable = 1;  
    ELSE Set Saleable = 0; 
    END IF;
 

RETURN saleable;
END; //
DELIMITER;
#select CPRTest('1005873661');
#drop function CPRTest;





#show create table TimeSlot;

Delimiter //
create procedure InsertTimeSlot(In vTimeSlotID varchar(4),In vDayCode enum('M','T','W','R','F','S','U'),
In  vStartTime time,In vEndTime time)
begin

if vEndTime <= vStartTime #this is bad time interval
then signal sqlstate 'HY000'
Set MYSQL_ERRNO =2515,message_text = 'You should enter valid date where startdate less than Enddate';
END if;
if timeoverlabWithTable(vTimeSlotID,vDayCode,vStartTime,vEndTime)
then Signal SQLSTATE 'HY000'
	set MYSQL_ERRNO = 1525,	message_text ='time interval overlaps with existing timeinterval for the same timeslot';
END if;    
insert TimeSlot values(vTimeSlotID,vDayCode,vStartTime,vEndTime);
End; //
Delimiter 

create function timeoverlab(vDayCode1 enum('M','T','W','R','F','S','U'),vStartTime1 time,vEndTime1 time,vDayCode2
enum('M','T','W','R','F','S','U'),vStartTime2 time,vEndTime2 time)
returns Boolean
return vDayCode1=vDayCode2 and ( (vStartTime1 <= vStartTime2 and vStartTime2 <= vEndTime1) or (vStartTime2 <= vStartTime1 and 
vStartTime1 <= vEndTime2))


create function timeoverlabWithTable(vTimeSlotID VARCHAR(4),vDayCode enum('M','T','W','R','F','S','U'),vStartTime Time,vEndTime Time)
returns boolean 
return Exists 
(Select * from TimeSlot where TimeSlotID=vTimeSlotID and timeoverlab(vDayCode,vStartTime,vEndTime,DayCode,StartTime,EndTime));








use University;

#select * from TimeSlot ;
#insert TimeSlot values('A','M','09:00:00','09:30:00');
#drop function timeoverlabWithTable;

#Select * from TimeSlot where TimeSlotID='A' and timeoverlab('M','08.00.00','08.30.00',DayCode,StartTime,EndTime);
#select timeoverlabWithTable('A','M','08.10.00','08.40.0
#show triggers;
#create table BallRolls(RollNo int not null primary key auto_increment,LuckyNo int)
#insert into BallRolls(LuckyNo)values(floor(rand()*6)+1);
#drop event RollBall;


use University;

#select * from TimeSlot ;
#insert TimeSlot values('A','M','09:00:00','09:30:00');
#drop function timeoverlabWithTable;

#Select * from TimeSlot where TimeSlotID='A' and timeoverlab('M','08.00.00','08.30.00',DayCode,StartTime,EndTime);
#select timeoverlabWithTable('A','M','08.10.00','08.40.0
#show triggers;
#create table BallRolls(RollNo int not null primary key auto_increment,LuckyNo int)
#insert into BallRolls(LuckyNo)values(floor(rand()*6)+1);
#drop event RollBall1;


#select * from BallRolls;

select * from BallRolls;

#insert into BallRolls(LuckyNo)values(floor(rand()*36)+1);



