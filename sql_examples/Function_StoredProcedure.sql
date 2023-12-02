USE world;

/* -----------------------------  PROCEDURE  ------------------------------------- */

delimiter //
DROP PROCEDURE IF EXISTS citycount;
CREATE PROCEDURE citycount (
							IN country CHAR(3) -- parameter in 
							, OUT cities INT   -- sending back to the caller
                           )
BEGIN
	SELECT COUNT(*) INTO cities FROM world.city   
	WHERE CountryCode = country;
END//

/* ------------------------------------------------------------------ */
delimiter ;
CALL citycount('CAN', @cities);
SELECT @cities;

/* ----------------------------- FUNCTION ------------------------------------- */

DROP FUNCTION  IF EXISTS world.greating;
CREATE FUNCTION world.greating (
		msg CHAR(20)    -- all paramters passing to a functions are considered IN (not OUT)
        )
		RETURNS CHAR(50) DETERMINISTIC   -- https://dev.mysql.com/doc/refman/8.0/en/stored-programs-logging.html
	RETURN CONCAT('Hello, ', msg ,'!');  -- function must RETURN a value

/* ------------------------------------------------------------------ */

SELECT world.greating('world');


