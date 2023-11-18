/**

INSTRUCTION 
1 - Copy the data files: countries.csv and cities.csv
		to the my UPLOAD folder, e.g : C:/ProgramData/MySQL/MySQL Server 8.0/Uploads
   
   
   If you are unsure, execute this SQL to find out the UPLOAD folder:    
   SELECT @@GLOBAL.secure_file_priv

2 - Execute the SQL statments in this script.  NOTE: It will drop the 'world' db if exists!!!

3) refresh your MySQL Workbench to see the new db created 'world'

**/

START TRANSACTION;

DROP DATABASE IF EXISTS world;
CREATE DATABASE world;

USE world;


CREATE TABLE country (
   `Code` char(3) NOT NULL DEFAULT '',
   `Name` char(52) NOT NULL DEFAULT '',
   `Continent` enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') NOT NULL DEFAULT 'Asia',
   `Region` char(26) NOT NULL DEFAULT '',
   `SurfaceArea` decimal(10,2) NOT NULL DEFAULT '0.00',
   `IndepYear` smallint DEFAULT NULL,
   `Population` int NOT NULL DEFAULT '0',
   `LifeExpectancy` decimal(3,1) DEFAULT NULL,
   `GNP` decimal(10,2) DEFAULT NULL,
   `GNPOld` decimal(10,2) DEFAULT NULL,
   `LocalName` char(45) NOT NULL DEFAULT '',
   `GovernmentForm` char(45) NOT NULL DEFAULT '',
   `HeadOfState` char(60) DEFAULT NULL,
   `Capital` int DEFAULT NULL,
   `Code2` char(2) NOT NULL DEFAULT '',
   PRIMARY KEY (`Code`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
  
 CREATE TABLE city (
   `ID` int NOT NULL AUTO_INCREMENT,
   `Name` char(35) NOT NULL DEFAULT '',
   `CountryCode` char(3) NOT NULL DEFAULT '',
   `District` char(20) NOT NULL DEFAULT '',
   `Population` int NOT NULL DEFAULT '0',
   PRIMARY KEY (`ID`),
   KEY `CountryCode` (`CountryCode`),
   CONSTRAINT `city_ibfk_2` FOREIGN KEY (`CountryCode`) REFERENCES `country` (`Code`)
 ) ENGINE=InnoDB AUTO_INCREMENT=4080 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 

-- Import must the same params as when you export the data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/countries.csv' 
INTO TABLE country 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Import must the same params as when you export the data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cities.csv'
INTO TABLE city 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED by '\n';

COMMIT;


USE world;

-- check the imports
select * from city where countrycode = 'CAN';
select * from country limit 5;

