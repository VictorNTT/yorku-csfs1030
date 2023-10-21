-- 1) Export data to a file
-- 2) Import a file into a table

-- Check the uploads folder: 
SELECT @@GLOBAL.secure_file_priv;  
	C:/ProgramData/MySQL/MySQL Server 8.0/Uploads

-- export  data from city table 
select * from city
into outfile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cities.csv'
fields terminated by ','
enclosed by '"'
lines terminated by '\n';

-- export  data from country table 
select * from country
into outfile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/countries.csv'
fields terminated by ','
enclosed by '"'
lines terminated by '\n';


-- Create two new tables: city2 and country2 so that we can load the data in 

Drop table if exists city2; 
Drop table if exists country2; 

CREATE TABLE `country2` (
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
  
 CREATE TABLE `city2` (
   `ID` int NOT NULL AUTO_INCREMENT,
   `Name` char(35) NOT NULL DEFAULT '',
   `CountryCode` char(3) NOT NULL DEFAULT '',
   `District` char(20) NOT NULL DEFAULT '',
   `Population` int NOT NULL DEFAULT '0',
   PRIMARY KEY (`ID`),
   KEY `CountryCode` (`CountryCode`),
   CONSTRAINT `city_ibfk_2` FOREIGN KEY (`CountryCode`) REFERENCES `country2` (`Code`)
 ) ENGINE=InnoDB AUTO_INCREMENT=4080 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 

-- Import must the same params as when you export the data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/countries.csv' 
INTO TABLE country2 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Import must the same params as when you export the data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cities.csv'
INTO TABLE city2 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED by '\n';

-- check the imports
select * from city2 where countrycode = 'CAN';
select * from country2 limit 5;

