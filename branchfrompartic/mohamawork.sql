#drop procedure add_barber_shop;
#we should pass one manatory phone number
DELIMITER $$
create procedure add_barber_shop(In vat_number VARCHAR(50),In shop_name varchar(50),In street varchar(50),In city varchar(50),In country varchar(50),In building_number varchar(50),In telephone_number varchar(50))
Begin
insert into barber_shop(vat_number,shop_name) values(vat_number,shop_name);
insert into address(vat_number,street,city,country,building_number)values(vat_number,street,city,country,building_number);
INSERT INTO phone_number (vat_number, number) VALUES (vat_number,telephone_number);
END; $$
DELIMITER ;
#drop procedure add_telephone_number;
DELIMITER $$
create procedure add_telephone_number(In vat_number VARCHAR(50),In telephone_number varchar(50))
begin
INSERT INTO phone_number (vat_number, number) VALUES (vat_number,telephone_number);
END; $$
DELIMITER ;

#call add_telephone_number('00000092','2314124');


#call add_barber_shop('00000092','quickcut','electronkvej','lyndby','Danmark','232','2232');

SELECT * FROM phone_number;
SELECT * FROM address;
SELECT * FROM serves;
SELECT * FROM invoice;
SELECT * FROM takes;
SELECT * FROM barber;
SELECT * FROM client;
SELECT * FROM user;
SELECT * FROM session;
SELECT * FROM service;
SELECT * FROM time_slot;
SELECT * FROM barber_shop;
SELECT * FROM barber_shop_info;
SELECT * FROM barber_shop_service_satisfaction;
                                                                                            
                                                                                            use QuickCut;

#drop table address_before_normalization;
/*
create or replace table address_before_normalization(address_id int auto_increment primary key not null,
door_number varchar(50),
street varchar(50),
town varchar(50),
town_code varchar (50),
city varchar(50),
city_code varchar(50),
state varchar(50),
state_code varchar(50),
country varchar(50),
country_code varchar(50));
/*
#You can make it completely normalized by having separate tables for street, town , city, state , country etc. 
That's good design , but downside is too many joins to get the required data.
 How much data do you anticipate , would you use it to just store with minimal reads ?
 or would you be accessing it on a regular basis ? if the requirement is to store and minimalistic read 
 , then you can still go ahead with the completely normalized approach. However, if we want to search based on address ,
 free text search and retrieve data , then normalized approach may not be the right choice
*/
/*
insert into address_before_normalization(door_number,street,town,town_code,city,city_code,state,state_code,country,country_code)
values('100 right','electctonicvej','lyndby','4343','copenhavn','5454','sjllænd','4556','Danmark','2323');
insert into address_before_normalization(door_number,street,town,town_code,city,city_code,state,state_code,country,country_code)
values('101 right','electctonicvej','lyndby','4343','copenhavn','5454','sjllænd','4556','Danmark','2323');
insert into address_before_normalization(door_number,street,town,town_code,city,city_code,state,state_code,country,country_code)
values('102 right','electctonicvej','lyndby','4343','copenhavn','5454','sjllænd','4556','Danmark','2323');
insert into address_before_normalization(door_number,street,town,town_code,city,city_code,state,state_code,country,country_code)
values('103 right','electctonicvej','lyndby','4343','copenhavn','5454','sjllænd','4556','Danmark','2323');
insert into address_before_normalization(door_number,street,town,town_code,city,city_code,state,state_code,country,country_code)
values('104 right','electctonicvej','lyndby','4343','copenhavn','5454','sjllænd','4556','Danmark','2323');
insert into address_before_normalization(door_number,street,town,town_code,city,city_code,state,state_code,country,country_code)
values('105 right','electctonicvej','lyndby','4343','copenhavn','5454','sjllænd','4556','Danmark','2323');
select * from address_before_normalization;
*/
/*
create or replace table town1(town_postnumber varchar(50) not null  primary key,town_name varchar(50));
create or replace table city1(city_postnumber varchar(50) not null primary key,city_name varchar(50));
create or replace table state1(state_postnumber varchar(50) not null  primary key,state_name varchar(50));
create or replace table country1(country_postnumber varchar(50) not null primary key,country_name varchar(50));
insert into town1(town_postnumber,town_name)values('6565','lyndby');
insert into city1(city_postnumber,city_name)values('6565','copenhavn');
insert into state1(state_postnumber,state_name)values('5656','sjllænd');
insert into country1(country_postnumber,country_name)values('656','Danmark');*/
insert into address1(door_number,street_name,town_postnumber,city_postnumber,state_postnumber,country_postnumber)values('42','elctronicvej','6565','6565','5656','656');

select * from address1;
/*
create or replace table address1(address_id int not null auto_increment primary key,
door_number varchar(50),
street_name varchar(50),
town_postnumber varchar(50),
city_postnumber varchar(50),
state_postnumber varchar(50),
country_postnumber varchar(50),
  FOREIGN KEY (town_postnumber) REFERENCES town1(town_postnumber) ON DELETE CASCADE,
  FOREIGN KEY (city_postnumber) REFERENCES city1(city_postnumber) ON DELETE CASCADE,
  FOREIGN KEY (state_postnumber) REFERENCES state1(state_postnumber) ON DELETE CASCADE,
  FOREIGN KEY (country_postnumber) REFERENCES country1(country_postnumber) ON DELETE CASCADE
);
*/
#delete from  address_before_normalization where address_id=1;
#insert into street1(door_number,street_name)values('330','electctonicvej');
/*
                                                                                            
                                                                                            select * from phone_number;
#INSERT INTO phone_number (vat_number, number,country_code) VALUES ('0000000000', '45661323',45);
#INSERT INTO phone_number (vat_number, number,country_code) VALUES ('0000000000', '11223344',45);
#delete from phone_number where vat_number=0000000000;
/*
#select * from phone_number;
#INSERT INTO phone_number (vat_number, number,country_code) VALUES ('0000000000', '45661323',45);
#INSERT INTO phone_number (vat_number, number,country_code) VALUES ('0000000000', '11223344',45);
#delete from phone_number where vat_number=0000000000;
/*
CREATE or replace TABLE barber_shop_before (
  vat_number varchar(10),
  shop_name varchar(50),
  telephone_number varchar(50),
  PRIMARY KEY (vat_number)
);
INSERT INTO barber_shop_before (vat_number, shop_name,telephone_number) VALUES ('0000000000', 'Cypis','4511223344,45661323');
INSERT INTO barber_shop_before (vat_number, shop_name,telephone_number) VALUES ('0000000001', 'Kaczmi','4555223344');
INSERT INTO barber_shop_before (vat_number, shop_name,telephone_number) VALUES ('0000000002', 'Kamien','4555663344');
INSERT INTO barber_shop_before (vat_number, shop_name,telephone_number) VALUES ('0000000003', 'Chwytak','55667744');
INSERT INTO barber_shop_before (vat_number, shop_name,telephone_number) VALUES ('0000000004', 'Krawczyk','55667788');
INSERT INTO barber_shop_before (vat_number, shop_name,telephone_number) VALUES ('0000000005', 'LChP','4599667788');
select * from barber_shop_before;
