USE QuickCut;

SET GLOBAL event_scheduler = ON;



#################### SQL DATA QUERIES #######################

/**
Select name of the service for each barber shop with the biggest number of finished session
 */
SELECT B.vat_number, B.shop_name, S.service_name
FROM barber_shop B
       NATURAL LEFT JOIN service S
       NATURAL LEFT JOIN session SES
WHERE S.service_name = (
  SELECT SS.service_name
  FROM service SS
  NATURAL JOIN session
  WHERE S.vat_number = SS.vat_number
  GROUP BY 1
  ORDER BY Count(*) DESC
  LIMIT 1
)
GROUP BY 1, 2;

/**
  Select each service of each barber_shop and assign total sum of earned salary based on number of sessions
 */
SELECT B.vat_number, B.shop_name, S.service_name, S.service_price * COUNT(SES.session_id) AS "TOTAL SUM"
FROM barber_shop B
       NATURAL JOIN service S
       NATURAL LEFT JOIN session SES
GROUP BY 1, 2, 3;


/**
  Select each barber shop which approximately gives a service to at least 2 people every week
 */
SELECT B.vat_number, B.shop_name
FROM barber_shop B
NATURAL LEFT JOIN session C
GROUP BY 1, 2
HAVING (COUNT(C.session_id) / ((SELECT COUNT(DISTINCT SES.week) FROM session SES where SES.vat_number = B.vat_number))) >= 1;


/**
  Collect average satisfaction rate for each service in each barber_shop
 */
SELECT B.vat_number, B.shop_name, S.service_name, AVG(T.satisfaction) AS "RATE"
FROM barber_shop B
       NATURAL JOIN service S
       NATURAL JOIN takes T
GROUP BY 1, 2, 3;


################ SQL TABLE MODIFICATIONS ##################

# provide 5% discount to all services which haven't been taken by any client.
UPDATE service S
SET S.service_price = S.service_price + S.service_price * 0.05
WHERE s.service_name NOT IN (
  SELECT SS.service_name
  from service SS
  natural join session SES
  where ss.vat_number = s.vat_number
  );

select * from service;

#change price of services based on satisfaction for all barber shops
UPDATE service S
SET S.service_price =
  CASE
    WHEN 3 < (
      SELECT AVG(T.satisfaction)
      FROM takes T
      NATURAL JOIN session SES
      where S.vat_number = SES.vat_number
      )
  THEN
    S.service_price - S.service_price * 0.05
  ELSE
    S.service_price + S.service_price * 0.1
  END;

select * from service;


# delete barber shop which has no barbers
DELETE FROM barber_shop
WHERE vat_number IN (
  SELECT BB.vat_number FROM barber_shop BB
  NATURAL LEFT JOIN barber BA
  WHERE BA.email IS NULL
);

select * from barber_shop;
select * from service;

#################### SQL PROGRAMMING ######################

DELIMITER //
CREATE OR REPLACE PROCEDURE create_user(IN v_email VARCHAR(50),
                                        IN password VARCHAR(50))
BEGIN
  SET @hash_password = sha1(password);
  INSERT INTO user VALUES (v_email, @hash_password, NOW());
END;
DELIMITER ;

DELIMITER //
CREATE OR REPLACE PROCEDURE create_client(IN v_name VARCHAR(50),
                                          IN v_email VARCHAR(50),
                                          IN v_phone VARCHAR(15))
BEGIN
  SET @first_name = SUBSTRING_INDEX(v_name, ' ', 1);
  SET @second_name = SUBSTRING_INDEX(v_name, ' ', -1);
  INSERT INTO client (email, client_name, cliient_surname, phone_number)
  VALUES (v_email, @first_name, @second_name, v_phone);
END;
DELIMITER ;

DELIMITER //
CREATE OR REPLACE PROCEDURE create_barber(IN v_name VARCHAR(50),
                                          IN v_email VARCHAR(50),
                                          IN v_vat_number VARCHAR(10))
BEGIN
  SET @first_name = SUBSTRING_INDEX(v_name, ' ', 1);
  SET @second_name = SUBSTRING_INDEX(v_name, ' ', -1);
  INSERT INTO barber VALUES (v_email, @first_name, @second_name, v_vat_number);
END;
DELIMITER ;

DELIMITER //
CREATE OR REPLACE PROCEDURE backup_table(IN v_table VARCHAR(50))
BEGIN
  SET @sql_text = CONCAT('SELECT * FROM ',
                         v_table,
                         ' INTO OUTFILE ',
                         '''/tmp/backup/quickcutBackup-',
                         v_table,
                         '-',
                         DATE_FORMAT(NOW(), '%Y%m%d%h%m%s'),
                         '.csv''',
                         ' FIELDS TERMINATED BY ',
                         ''',''',
                         ' OPTIONALLY ENCLOSED BY ',
                         '''"''',
                         ' LINES TERMINATED BY ',
                         '''\n''',
                         ';');
  PREPARE statement FROM @sql_text;
  EXECUTE statement;
  DROP PREPARE statement;
END;
DELIMITER ;

/*
  Create user and then create either barber or client
  @v_name "name surname"
  @v_email "email of the user"
  @v_password "password of the user"
  @v_additional_data "vat or phone number"
  @type "either barber or client"
 */
DELIMITER //
CREATE OR REPLACE PROCEDURE create_account(IN v_name VARCHAR(50),
                                           IN v_email VARCHAR(50),
                                           IN v_password VARCHAR(50),
                                           IN v_additional_data VARCHAR(10),
                                           IN type ENUM ('barber', 'client'))
BEGIN
  START TRANSACTION;
  CALL create_user(v_email, v_password);
  CASE type
    WHEN 'barber' THEN
      CALL create_barber(v_name, v_email, v_additional_data);
    WHEN 'client' THEN
      CALL create_client(v_name, v_email, v_additional_data);
    ELSE
      rollback;
    END CASE;
  COMMIT;
END;
DELIMITER ;


/*
  @dateString - date string in format
    dd.mm.yyyy or
    dd/mm/yyyy or
    dd-mm-yyyy
 */
CREATE OR REPLACE FUNCTION get_week_from_date(dateString VARCHAR(10))
  RETURNS INT
BEGIN
  DECLARE vDate DATE;
  CASE substring(dateString, 3, 1)
    WHEN '/' THEN
      SELECT STR_TO_DATE(dateString, '%m/%d/%Y') INTO vDate;
    WHEN '.' THEN
      SELECT STR_TO_DATE('12.31.2011', '%m.%d.%Y') INTO vDate;
    WHEN '-' THEN
      SELECT STR_TO_DATE('12-31-2011', '%m-%d-%Y') INTO vDate;
    ELSE
      RETURN -1;
    END CASE;
  RETURN week(vDate);
END;


SELECT get_week_from_date('07.08.1999');

DELIMITER //
CREATE OR REPLACE EVENT clear_users_weekly
  ON SCHEDULE EVERY 1 WEEK
    STARTS CURRENT_TIMESTAMP
  DO
  BEGIN
    DELETE FROM user WHERE TIMESTAMPDIFF(YEAR, last_activity, NOW()) > 0;
  END //
DELIMITER ;

DELIMITER //
CREATE OR REPLACE EVENT backup_database_daily
  ON SCHEDULE EVERY 1 DAY
    STARTS CURRENT_TIMESTAMP
  DO
  BEGIN
    CALL backup_table('address');
    CALL backup_table('barber');
    CALL backup_table('barber_shop');
    CALL backup_table('client');
    CALL backup_table('invoice');
    CALL backup_table('phone_number');
    CALL backup_table('serves');
    CALL backup_table('service');
    CALL backup_table('session');
    CALL backup_table('takes');
    CALL backup_table('time_slot');
    CALL backup_table('user');
  END //
DELIMITER ;
