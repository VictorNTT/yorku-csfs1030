/*
1. Check for where MySQL's default 'Uploads' folder is: 
mysql> SELECT @@GLOBAL.secure_file_priv;
+------------------------------------------------+
| @@GLOBAL.secure_file_priv                      |
+------------------------------------------------+
| C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\ |
+------------------------------------------------+

2. Create a table UPLOAD_FILE_TEST

3. Create an input file, comma-separated values UPLOAD_FILE_TEST.csv
   and save it at the 'Uploads' folders. The file should have two columns: ID, MSG. 
   
   Example   
+----------------------------------------------   
	1, The fox jumps over the lazy dog
	2, There are several ways to update data
+----------------------------------------------
*/


DROP TABLE IF EXISTS UPLOAD_FILE_TEST;
CREATE TABLE UPLOAD_FILE_TEST (
 ID INT  NOT NULL,
 MSG VARCHAR(50) NOT NULL
);

/*
 To find out the the full path of 'Uploads' folder
 SELECT @@GLOBAL.secure_file_priv;  
 
 Note: Use the forward slash / instead of backward slash \ in the file path 
 
*/
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/UPLOAD_FILE_TEST.csv' INTO TABLE UPLOAD_FILE_TEST FIELDS TERMINATED BY ',';

SELECT * FROM UPLOAD_FILE_TEST;

