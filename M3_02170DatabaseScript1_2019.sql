DROP DATABASE IF EXISTS QuickCut;
CREATE DATABASE QuickCut;
USE QuickCut;

DROP TABLE IF EXISTS phone_number;
DROP TABLE IF EXISTS address;
DROP TABLE IF EXISTS serves;
DROP TABLE IF EXISTS invoice;
DROP TABLE IF EXISTS takes;
DROP TABLE IF EXISTS barber;
DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS session;
DROP TABLE IF EXISTS service;
DROP TABLE IF EXISTS time_slot;
DROP TABLE IF EXISTS barber_shop;

DROP VIEW IF EXISTS barber_shop_info;
DROP VIEW IF EXISTS barber_shop_service_satisfaction;


CREATE TABLE time_slot (
  time_slot_id int AUTO_INCREMENT,
  week_day ENUM ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
  start_time TIME,
  end_time TIME,
  PRIMARY KEY (time_slot_id, start_time, week_day)
                       #consider primary key
);

CREATE TABLE barber_shop (
  vat_number varchar(10),
  shop_name varchar(50),
  PRIMARY KEY (vat_number)
);

CREATE TABLE service (
  vat_number varchar(10),
  service_name varchar(50),
  service_price int,
  service_duration int,
  PRIMARY KEY (vat_number, service_name),
  FOREIGN KEY (vat_number) REFERENCES barber_shop(vat_number) ON DELETE CASCADE
);

CREATE TABLE session (
  session_identifier int AUTO_INCREMENT,
  vat_number         varchar(10),
  service_name       varchar(50),
  week               int,
  year               YEAR,
  time_slot_id       int,
  PRIMARY KEY (session_identifier, vat_number, service_name, week, year),
  FOREIGN KEY (vat_number, service_name) REFERENCES service (vat_number, service_name) ON DELETE CASCADE
);

CREATE TABLE address (
  vat_number varchar(10),
  street varchar(50),
  city varchar(50),
  country varchar(50),
  building_number varchar(50),
  PRIMARY KEY (vat_number),
  FOREIGN KEY (vat_number) REFERENCES barber_shop(vat_number) ON DELETE CASCADE
);

CREATE TABLE user (
  email varchar(50),
  password varchar(50),
  PRIMARY KEY (email)
);

CREATE TABLE client (
  email varchar(50),
  client_name varchar(50),
  cliient_surname varchar(50),
  phone_number varchar(8),
  PRIMARY KEY (email),
  FOREIGN KEY (email) REFERENCES user(email) ON DELETE CASCADE
);

CREATE TABLE barber (
  email varchar(50),
  barber_name varchar(50),
  barber_surname varchar(50),
  vat_number varchar(10),
  PRIMARY KEY (email),
  FOREIGN KEY (vat_number) REFERENCES barber_shop(vat_number) ON DELETE CASCADE,#was SET NULL intuitively
  FOREIGN KEY (email) REFERENCES user(email) ON DELETE CASCADE
);

CREATE TABLE phone_number (
  vat_number varchar(10),
  number varchar(8),
  PRIMARY KEY (vat_number, number),
  FOREIGN KEY (vat_number) REFERENCES barber_shop(vat_number) ON DELETE CASCADE
);

CREATE TABLE serves (
  email varchar(50),
  session_identifier int,
  vat_number varchar(10),
  service_name varchar(50),
  week int,
  year YEAR,
  PRIMARY KEY (email, session_identifier, vat_number, service_name, week, year),
  FOREIGN KEY (email) REFERENCES barber(email) ON DELETE CASCADE,
  FOREIGN KEY (session_identifier, vat_number, service_name, week, year)
    REFERENCES session(session_identifier, vat_number, service_name, week, year)
    ON DELETE CASCADE
);

CREATE TABLE takes (
  email varchar(50),
  session_identifier int,
  vat_number varchar(10),
  service_name varchar(50),
  week int,
  year YEAR,
  satisfaction int,
  PRIMARY KEY (email, session_identifier, vat_number, service_name, week, year),
  FOREIGN KEY (email) REFERENCES client(email),
  FOREIGN KEY (session_identifier, vat_number, service_name, week, year)
    REFERENCES session(session_identifier, vat_number, service_name, week, year) ON DELETE CASCADE
);

CREATE TABLE invoice (
  invoice_number int,
  email varchar(50),
  session_identifier int,
  vat_number varchar(10),
  service_name varchar(50),
  week int,
  year YEAR,
  creation_date DATETIME,
  payment_type varchar(50),
  PRIMARY KEY (invoice_number, email, session_identifier, vat_number, service_name, week, year),
  FOREIGN KEY (email, session_identifier, vat_number, service_name, week, year)
  REFERENCES takes(email, session_identifier, vat_number, service_name, week, year)
  ON DELETE CASCADE
);
# should not cascade on delete except for email

INSERT INTO barber_shop (vat_number, shop_name) VALUES ('0000000000', 'Cypis');
INSERT INTO barber_shop (vat_number, shop_name) VALUES ('0000000001', 'Kaczmi');
INSERT INTO barber_shop (vat_number, shop_name) VALUES ('0000000002', 'Kamien');
INSERT INTO barber_shop (vat_number, shop_name) VALUES ('0000000003', 'Chwytak');
INSERT INTO barber_shop (vat_number, shop_name) VALUES ('0000000004', 'Krawczyk');
INSERT INTO barber_shop (vat_number, shop_name) VALUES ('0000000005', 'LChP');

INSERT INTO time_slot (week_day, start_time, end_time) VALUES ('Monday', '10:00', '12:00');
INSERT INTO time_slot (week_day, start_time, end_time) VALUES ('Monday', '11:00', '12:00');
INSERT INTO time_slot (week_day, start_time, end_time) VALUES ('Tuesday', '11:00', '12:00');
INSERT INTO time_slot (week_day, start_time, end_time) VALUES ('Wednesday', '11:30', '12:00');
INSERT INTO time_slot (week_day, start_time, end_time) VALUES ('Thursday', '10:00', '12:00');
INSERT INTO time_slot (week_day, start_time, end_time) VALUES ('Friday', '10:00', '12:00');
INSERT INTO time_slot (week_day, start_time, end_time) VALUES ('Saturday', '10:00', '12:00');

INSERT INTO service (vat_number, service_name, service_price, service_duration) VALUES ('0000000000', 'Gentlemen', '100', '60');
INSERT INTO service (vat_number, service_name, service_price, service_duration) VALUES ('0000000000', 'Ladies', '200', '60');
INSERT INTO service (vat_number, service_name, service_price, service_duration) VALUES ('0000000001', 'Gentlemen', '100', '60');
INSERT INTO service (vat_number, service_name, service_price, service_duration) VALUES ('0000000001', 'Ladies', '100', '60');
INSERT INTO service (vat_number, service_name, service_price, service_duration) VALUES ('0000000002', 'Gentlemen', '200', '60');
INSERT INTO service (vat_number, service_name, service_price, service_duration) VALUES ('0000000002', 'Ladies', '100', '60');
INSERT INTO service (vat_number, service_name, service_price, service_duration) VALUES ('0000000003', 'Gentlemen', '100', '60');
INSERT INTO service (vat_number, service_name, service_price, service_duration) VALUES ('0000000003', 'Ladies', '200', '60');

INSERT INTO session (vat_number, service_name, week, year, time_slot_id) VALUES ('0000000000', 'Gentlemen', 1, 2019, 1);
INSERT INTO session (vat_number, service_name, week, year, time_slot_id) VALUES ('0000000000', 'Ladies', 2, 2019, 2);
INSERT INTO session (vat_number, service_name, week, year, time_slot_id) VALUES ('0000000001', 'Ladies', 1, 2019, 4);
INSERT INTO session (vat_number, service_name, week, year, time_slot_id) VALUES ('0000000002', 'Gentlemen', 1, 2019, 5);
INSERT INTO session (vat_number, service_name, week, year, time_slot_id) VALUES ('0000000003', 'Gentlemen', 1, 2019, 6);
INSERT INTO session (vat_number, service_name, week, year, time_slot_id) VALUES ('0000000003', 'Gentlemen', 2, 2019, 6);
INSERT INTO session (vat_number, service_name, week, year, time_slot_id) VALUES ('0000000003', 'Gentlemen', 3, 2019, 6);

INSERT INTO user (email, password) VALUES ('s0000000@client.dtu.dk', 'password');
INSERT INTO user (email, password) VALUES ('s0000001@client.dtu.dk', 'password');
INSERT INTO user (email, password) VALUES ('s0000002@client.dtu.dk', 'password');
INSERT INTO user (email, password) VALUES ('s0000003@client.dtu.dk', 'password');
INSERT INTO user (email, password) VALUES ('s0000004@client.dtu.dk', 'password');
INSERT INTO user (email, password) VALUES ('s0000005@client.dtu.dk', 'password');
INSERT INTO user (email, password) VALUES ('s0000006@client.dtu.dk', 'password');
INSERT INTO user (email, password) VALUES ('s0000007@barber.dtu.dk', 'password');
INSERT INTO user (email, password) VALUES ('s0000008@barber.dtu.dk', 'password');
INSERT INTO user (email, password) VALUES ('s0000009@barber.dtu.dk', 'password');
INSERT INTO user (email, password) VALUES ('s0000010@barber.dtu.dk', 'password');
INSERT INTO user (email, password) VALUES ('s0000011@barber.dtu.dk', 'password');
INSERT INTO user (email, password) VALUES ('s0000012@barber.dtu.dk', 'password');
INSERT INTO user (email, password) VALUES ('s0000013@barber.dtu.dk', 'password');

INSERT INTO client (email, client_name, cliient_surname, phone_number) VALUES ('s0000000@client.dtu.dk', 'John', 'Doe', '00000001');
INSERT INTO client (email, client_name, cliient_surname, phone_number) VALUES ('s0000001@client.dtu.dk', 'Alice', 'Wonderland', '00000002');
INSERT INTO client (email, client_name, cliient_surname, phone_number) VALUES ('s0000002@client.dtu.dk', 'Kate', 'Middleton', '00000003');
INSERT INTO client (email, client_name, cliient_surname, phone_number) VALUES ('s0000003@client.dtu.dk', 'Andrzej', 'Duda', '00000004');
INSERT INTO client (email, client_name, cliient_surname, phone_number) VALUES ('s0000004@client.dtu.dk', 'Zbigniew', 'Stonoga', '00000005');
INSERT INTO client (email, client_name, cliient_surname, phone_number) VALUES ('s0000005@client.dtu.dk', 'Esmeralda', 'Godlewska', '00000006');
INSERT INTO client (email, client_name, cliient_surname, phone_number) VALUES ('s0000006@client.dtu.dk', 'Krystyna', 'Pawlowicz', '00000007');

INSERT INTO barber (email, barber_name, barber_surname, vat_number) VALUES ('s0000007@barber.dtu.dk', 'Janusz', 'Palikot', '0000000000');
INSERT INTO barber (email, barber_name, barber_surname, vat_number) VALUES ('s0000008@barber.dtu.dk', 'Iwona', 'Pawlowicz', '0000000001');
INSERT INTO barber (email, barber_name, barber_surname, vat_number) VALUES ('s0000009@barber.dtu.dk', 'Andrzej', 'Grabowski', '0000000000');
INSERT INTO barber (email, barber_name, barber_surname, vat_number) VALUES ('s0000010@barber.dtu.dk', 'Maryla', 'Rodowicz', '0000000001');
INSERT INTO barber (email, barber_name, barber_surname, vat_number) VALUES ('s0000011@barber.dtu.dk', 'Lech', 'Kaczynski', '0000000002');
INSERT INTO barber (email, barber_name, barber_surname, vat_number) VALUES ('s0000012@barber.dtu.dk', 'Jaroslaw', 'Kaczynski', '0000000003');
INSERT INTO barber (email, barber_name, barber_surname, vat_number) VALUES ('s0000013@barber.dtu.dk', 'Adam', 'Graczyk', '0000000004');

INSERT INTO takes (email, session_identifier, vat_number, service_name, week, year, satisfaction)
  VALUES ('s0000001@client.dtu.dk', 2, '0000000000', 'Ladies', 2, 2019, 5);
INSERT INTO takes (email, session_identifier, vat_number, service_name, week, year, satisfaction)
  VALUES ('s0000001@client.dtu.dk', 3, '0000000001', 'Ladies', 1, 2019, 4);
INSERT INTO takes (email, session_identifier, vat_number, service_name, week, year, satisfaction)
  VALUES ('s0000002@client.dtu.dk', 1, '0000000000', 'Gentlemen', 1, 2019, 3);
INSERT INTO takes (email, session_identifier, vat_number, service_name, week, year, satisfaction)
  VALUES ('s0000003@client.dtu.dk', 4, '0000000002', 'Gentlemen', 1, 2019, 2);
INSERT INTO takes (email, session_identifier, vat_number, service_name, week, year, satisfaction)
  VALUES ('s0000004@client.dtu.dk', 5, '0000000003', 'Gentlemen', 1, 2019, 1);
INSERT INTO takes (email, session_identifier, vat_number, service_name, week, year, satisfaction)
  VALUES ('s0000005@client.dtu.dk', 5, '0000000003', 'Gentlemen', 1, 2019, 5);
INSERT INTO takes (email, session_identifier, vat_number, service_name, week, year, satisfaction)
  VALUES ('s0000006@client.dtu.dk', 5, '0000000003', 'Gentlemen', 1, 2019, 5);

INSERT INTO invoice (invoice_number, email, session_identifier, vat_number, service_name, week, year, creation_date, payment_type)
  VALUES (0, 's0000001@client.dtu.dk', 2, '0000000000', 'Ladies', 2, 2019, CURDATE(), 'Dankort');
INSERT INTO invoice (invoice_number, email, session_identifier, vat_number, service_name, week, year, creation_date, payment_type)
  VALUES (0, 's0000001@client.dtu.dk', 3, '0000000001', 'Ladies', 1, 2019, CURDATE(), 'Cash');
INSERT INTO invoice (invoice_number, email, session_identifier, vat_number, service_name, week, year, creation_date, payment_type)
  VALUES (0, 's0000002@client.dtu.dk', 1, '0000000000', 'Gentlemen', 1, 2019, CURDATE(), 'Visa');
INSERT INTO invoice (invoice_number, email, session_identifier, vat_number, service_name, week, year, creation_date, payment_type)
  VALUES (0, 's0000003@client.dtu.dk', 4, '0000000002', 'Gentlemen', 1, 2019, CURDATE(), 'MasterCard');
INSERT INTO invoice (invoice_number, email, session_identifier, vat_number, service_name, week, year, creation_date, payment_type)
  VALUES (0, 's0000004@client.dtu.dk', 5, '0000000003', 'Gentlemen', 1, 2019, CURDATE(), 'Coupon');

INSERT INTO serves (email, session_identifier, vat_number, service_name, week, year)
  VALUES ('s0000007@barber.dtu.dk', 2, '0000000000', 'Ladies', 2, 2019);
INSERT INTO serves (email, session_identifier, vat_number, service_name, week, year)
  VALUES ('s0000008@barber.dtu.dk', 3, '0000000001', 'Ladies', 1, 2019);
INSERT INTO serves (email, session_identifier, vat_number, service_name, week, year)
  VALUES ('s0000009@barber.dtu.dk', 1, '0000000000', 'Gentlemen', 1, 2019);
INSERT INTO serves (email, session_identifier, vat_number, service_name, week, year)
  VALUES ('s0000011@barber.dtu.dk', 4, '0000000002', 'Gentlemen', 1, 2019);
INSERT INTO serves (email, session_identifier, vat_number, service_name, week, year)
  VALUES ('s0000012@barber.dtu.dk', 5, '0000000003', 'Gentlemen', 1, 2019);

INSERT INTO address (vat_number, street, city, country,building_number)
  VALUES ('0000000000', 'Wiejska 10', 'Warszawa', 'Poland','23');
INSERT INTO address (vat_number, street, city, country,building_number)
  VALUES ('0000000001', 'Wiejska 4/6/8', 'Warszawa', 'Poland','23');
INSERT INTO address (vat_number, street, city, country,building_number)
  VALUES ('0000000002', 'Aleje Ujazdowskie 1/3', 'Warszawa', 'Poland','232');
INSERT INTO address (vat_number, street, city, country,building_number)
  VALUES ('0000000003', 'Aleja Szucha 25', 'Warszawa', 'Poland','232');
INSERT INTO address (vat_number, street, city, country,building_number)
  VALUES ('0000000004', 'Nowogrodzka 1/3/5', 'Warszawa', 'Poland','232');
INSERT INTO address (vat_number, street, city, country,building_number)
  VALUES ('0000000005', 'J. P. Woronicza', 'Warszawa', 'Poland','2323');

INSERT INTO phone_number (vat_number, number) VALUES ('0000000000', '11223344');
INSERT INTO phone_number (vat_number, number) VALUES ('0000000001', '55223344');
INSERT INTO phone_number (vat_number, number) VALUES ('0000000002', '55663344');
INSERT INTO phone_number (vat_number, number) VALUES ('0000000003', '55667744');
INSERT INTO phone_number (vat_number, number) VALUES ('0000000004', '55667788');
INSERT INTO phone_number (vat_number, number) VALUES ('0000000005', '99667788');

CREATE VIEW barber_shop_info AS
  SELECT barber_shop.vat_number, barber_shop.shop_name, address.street, address.city, address.country, phone_number.number FROM barber_shop
    JOIN address ON barber_shop.vat_number = address.vat_number
    JOIN phone_number ON barber_shop.vat_number = phone_number.vat_number;

CREATE VIEW barber_shop_service_satisfaction AS
  SELECT barber_shop.shop_name, takes.service_name, AVG(takes.satisfaction) AS 'Average satisfaction' FROM barber_shop
    JOIN takes ON barber_shop.vat_number = takes.vat_number GROUP BY barber_shop.vat_number, takes.service_name;

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
