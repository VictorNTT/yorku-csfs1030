/*
1. Check for where MySQL's default 'Uploads' folder is: 
mysql> SELECT @@GLOBAL.secure_file_priv;
+------------------------------------------------+
| @@GLOBAL.secure_file_priv                      |
+------------------------------------------------+
| C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\ |
+------------------------------------------------+

2. Create a table
3. Create an input file, comma-separated values UPLOAD_FILE_TEST.csv
   and save it at the 'Uploads' folders
*/


DROP TABLE IF EXISTS UPLOAD_FILE_TEST;
CREATE TABLE UPLOAD_FILE_TEST (
 ID INT  NOT NULL,
 MSG VARCHAR(50) NOT NULL
);

/*
 SELECT @@GLOBAL.secure_file_priv;  
 To find out the the full path of 'Uploads' folder
*/
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/UPLOAD_FILE_TEST.txt' INTO TABLE UPLOAD_FILE_TEST FIELDS TERMINATED BY ',';

SELECT * FROM UPLOAD_FILE_TEST;

