
/*
mysqldump is an utility and we run directly from CMD window  and not from mysql> prompt

*/
-- 1. create a new database and have some data

DROP DATABASE IF EXISTS TEST_DB1;
CREATE DATABASE TEST_DB1;
USE TEST_DB1;
DROP TABLE IF EXISTS TABLE1;

CREATE TABLE TABLE1 (ID INT AUTO_INCREMENT PRIMARY KEY, TXT VARCHAR (50));
INSERT INTO TABLE1 (TXT) VALUES 
	('The red fox jumps over the lazy doq!'), 
    ('Who let the dog out!');
SELECT * FROM TABLE1;

-- 2. Now open the DOS Command Windows and back up the DB TEST_DB1
-- cd C:\temp
-- mysqldump -u root -p TEST_DB1 > test_db1.dump.sql         -- not include 'CREATE  DATABASE' command
-- mysqldump -u root -p --databases TEST_DB1 > test_db1.dump.sql    -- to include  'CREATE  DATABASE' command
-- (enter password)
-- Check the file test_db1.dump.sql is created 

-- 3. Drop DB TEST_DB1 to showcase that we can get the db back using the backup file generated in above step
DROP DATABASE IF EXISTS TEST_DB1;

-- 4. Recreate the DB TEST_DB1 using mysqladmin utility via DOS Command 
-- (Skip this step if you already include 'CREATE DATABASE' command in the dump file above
-- 		$ mysqladmin -u root -p CREATE TEST_DB1
-- Check the db has been created but empty (no TABLE1)
-- 		$ mysql -u root -p 
-- mysql> 	use TEST_DB1;
-- mysql> 	show tables; 

-- 5. Load the tables back using the dump file 
-- mysql> 	source test_db1.dump.sql
 

