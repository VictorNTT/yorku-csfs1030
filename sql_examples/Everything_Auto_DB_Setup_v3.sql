/*
Description:  Setup Database 'Everything_Auto'
Author: Victor Nguyen  
Last updated: Dec 01, 2023
Version: 1.0

Note: This material is for education purpose. 
*/

DROP DATABASE IF EXISTS EVERYTHING_AUTO;
CREATE DATABASE EVERYTHING_AUTO;
USE EVERYTHING_AUTO;
commit;

drop table if exists sys_account;
create table sys_account (
	id int auto_increment primary key,
    sys_account_id varchar(50) not null,   
    passwd varchar(100) not null,  /* store sha1('password') */
    email varchar(50) not null,
    activated enum('Y', 'N') not null default 'N',
    activated_date int default 0,     
    reg_date int not null,    
    note varchar(50) null,
    created_time datetime not null default current_timestamp(),
    last_updated datetime not null default current_timestamp()
);

delete from sys_account;
alter table sys_account auto_increment = 1;
insert into sys_account (sys_account_id, passwd, email, activated, activated_date, reg_date)  
values
('James', SHA1('Smith'), 'James.Smith@mail.com', 'Y', 20201110, 20201110),
('Mary', SHA1('Johnson'), 'Mary.Johnson@mail.com', 'Y', 20211012, 20211012),
('Robert', SHA1('Williams'), 'Robert.Williams@mail.com', 'Y', 20190710, 20190710),
('Patricia', SHA1('Brown'), 'Patricia.Brown@mail.com', 'Y', 20220510, 20220510),
('John', SHA1('Miller'), 'John.Miller@mail.com', 'Y', 20181025, 20181025),
('Jennifer', SHA1('Garcia'), 'Jennifer.Garcia@mail.com', 'Y', 20170130, 20170130),
('Michael', SHA1('Jones'), 'Michael.Jones@mail.com', 'Y', 202305112, 202305112),
('Linda', SHA1('Miller'), 'Linda.Miller@mail.com', 'Y', 20230228, 20230228),
('David', SHA1('Rodriguez'), 'David.Rodriguez@mail.com', 'Y', 20230117, 20230117),
('Elizabeth', SHA1('Martinez'), 'Elizabeth.Martinez@mail.com', 'Y', 20201225, 20201225),
('William', SHA1('Davis'), 'William.Davis@mail.com', 'Y', 20190910, 20190910),
('Barbara', SHA1('Hernandez'), 'Barbara.Hernandez@mail.com', 'Y', 20220430, 20220430),
('Richard', SHA1('Lopez'), 'Richard.Lopez@mail.com', 'Y', 20231103, 20231103),
('Susan', SHA1('Gonzalez'), 'Susan.Gonzalez@mail.com', 'Y', 20200921, 20200921),
('Joseph', SHA1('Wilson'), 'Joseph.Wilson@mail.com', 'Y', 20210319, 20210319),
('Jessica', SHA1('Anderson'), 'Jessica.Anderson@mail.com', 'Y', 20221102, 20221102),
('Thomas', SHA1('Martin'), 'Thomas.Martin@mail.com', 'Y', 20230216, 20230216),
('Sarah', SHA1('Thomas'), 'Sarah.Thomas@mail.com', 'Y', 20210923, 20210923),
('Christopher', SHA1('Taylor'), 'Christopher.Taylor@mail.com', 'Y', 20220125, 20220125),
('Karen', SHA1('Moore'), 'Karen.Moore@mail.com', 'Y', 20181005, 20181005) ;

select * from sys_account;

drop table if exists customer;
create table customer (
	id int auto_increment primary key,
    sys_acct_id int not null,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    dob int not null,
    enabled enum('Y', 'N') not null default 'Y',
    last_updated datetime not null default current_timestamp()
    , constraint fk_customer_sys_account_id foreign key (sys_acct_id) references sys_account (id) ON UPDATE CASCADE ON DELETE CASCADE 
);

delete from customer;
alter table customer auto_increment = 1;
insert into customer (sys_acct_id, first_name, last_name, dob, enabled) values 
(1,'James','Smith',19901010,'Y'),
(2,'Mary','Johnson',19951219,'Y'),
(3,'Robert','Williams',19910128,'Y'),
(4,'Patricia','Brown',20001208,'Y'),
(5,'John','Miller',19980527,'Y'),
(6,'Jennifer','Garcia',20050530,'Y'),
(7,'Michael','Jones',19851019,'Y'),
(8,'Linda','Miller',20010709,'Y'),
(9,'David','Rodriguez',19790211,'Y'),
(10,'Elizabeth','Martinez',20030829,'Y'),
(11,'William','Davis',20021209,'Y'),
(12,'Barbara','Hernandez',19991122,'Y'),
(13,'Richard','Lopez',19950721,'Y'),
(14,'Susan','Gonzalez',20000128,'Y'),
(15,'Joseph','Wilson',19940928,'Y'),
(16,'Jessica','Anderson',19900321,'Y'),
(17,'Thomas','Martin',19970209,'Y'),
(18,'Sarah','Thomas',20010730,'Y'),
(19,'Christopher','Taylor',19960810,'Y'),
(20,'Karen','Moore',19910429,'Y');

select * from customer;


drop table if exists contact;
create table contact (
	id int auto_increment primary key,
    cust_id int not null,
    contact_type enum ('R', 'D') not null, -- R(esidence) D(elivery)
    address varchar(100) not null,
    city varchar(50) not null,
    prov varchar(50) not null,
    postalcode varchar(10) not null,
    country varchar(50) not null,
    phone varchar(15) not null,
    phone_label varchar(50),
	created_time datetime not null default current_timestamp(),
    last_updated datetime not null default current_timestamp()
    , CONSTRAINT fk_contact_cust_id  FOREIGN KEY  (cust_id) references customer (id) ON UPDATE CASCADE ON DELETE CASCADE    
);
delete from contact;
alter table contact auto_increment = 1;
insert into contact (cust_id, contact_type, address, city, prov, postalcode, country, phone, phone_label) values 
(1,'R', '1 Queen St W', 'Toronto', 'ON', 'A1A 1A1', 'Canada', '416-123-1234', 'Work'),
(1,'D', '1 Homestead St S', 'Toronto', 'ON', 'Y1Y 1Y1', 'Canada', '646-123-1234', 'Home'),
(2,'R', '2 King St E', 'Cape Breton', 'NS', 'B1B 1B1', 'Canada', '416-234-5678', 'Personal'),
(3,'R', '3 Jane St S', 'Richmond Hill', 'ON', 'C1C 1C1', 'Canada', '416-222-3424', 'Cell'),
(4,'R', '4 Keeles St N', 'Vaughan', 'ON', 'D1D 1D1', 'Canada', '416-454-3535', 'Mobile'),
(5,'R', '5 Carton St W', 'Calgary', 'AB', 'E1E 1E1', 'Canada', '416-232-8765', 'Work'),
(5,'D', '5 Homestead St S', 'Toronto', 'ON', 'Z1Y 1Z1', 'Canada', '646-232-8765', 'Home'),
(6,'R', '6 Prince St S', 'Mississauga', 'ON', 'F1F 1F1', 'Canada', '647-675-2363', 'Desk'),
(7,'R', '7 Seewall St N', 'Victoria', 'BC', 'I1I 1I1', 'Canada', '416-232-2396', 'Home'),
(8,'R', '8 Mill St E', 'Montreal', 'QC', 'J1J 1J1', 'Canada', '437-644-8855', 'Cell'),
(9,'R', '9 Pond St W', 'Edmonton', 'AB', 'K1K 1K1', 'Canada', '416-675-3347', 'Mobile'),
(10,'R', '10 Carter St S', 'Vancouver', 'BC', 'L1L 1L1', 'Canada', '416-723-4552', 'Personal'),
(11,'R', '11 Bayview St N', 'Toronto', 'ON', 'M1M 1M1', 'Canada', '416-764-2321', 'Home'),
(12,'R', '12 Yonge St E', 'Laval', 'QC', 'N1N 1N1', 'Canada', '416-324-6424', 'Work'),
(13,'R', '13 Dandus St W', 'Winnipeg', 'AB', 'O1O 1O1', 'Canada', '416-973-2324', 'Personal'),
(14,'R', '14 Church St S', 'Halifax	Nova', 'NS', 'P1P 1P1', 'Canada', '416-874-4232', 'Mobile'),
(15,'R', '15 George St N', 'Saint John', 'NF', 'Q1A 1Q1', 'Canada', '416-236-2352', 'Cell'),
(16,'R', '16 Wellington St W', 'Toronto', 'ON', 'R1R 1R1', 'Canada', '416-774-3463', 'Mobile'),
(17,'R', '17 Elington St E', 'Longueuil', 'BC', 'S1S 1S1', 'Canada', '416-431-3411', 'Home'),
(18,'R', '18 St Clair St W', 'Toronto', 'ON', 'T1T 1T1', 'Canada', '416-985-1114', 'Work'),
(19,'R', '19 Finch St W', 'Regina', 'ON', 'U1U 1U1', 'Canada', '416-232-2421', 'Home'),
(20,'R', '20 Bloor St E', 'Saskatoon', 'SK', 'V1V 1V1', 'Canada', '416-373-3224', 'Cell');
select * from contact;

drop table if exists department;
create table department (
	id int auto_increment primary key,
    name varchar(50) not null
);

delete from department;
alter table department auto_increment = 1;
insert into department (name) values ('Sales'), ('Finance'), ('Administrative');
select * from department;

drop table if exists personnel;
create table personnel (
	id int auto_increment primary key,
    first_name varchar(50) not null, 
    last_name varchar(50) not null, 
    phone varchar(15) not null, 
    email varchar(50) not null,
    dept_id int not null,
    created_time datetime not null default current_timestamp(),
    last_updated datetime not null default current_timestamp()
    , CONSTRAINT fk_personnel_dept_id  FOREIGN KEY  (dept_id) references department (id) ON UPDATE CASCADE ON DELETE CASCADE    
);

delete from personnel;
alter table personnel auto_increment = 1;
insert into personnel (first_name, last_name, phone, email, dept_id) values
('Elen','Park','416-973-2324','Elen.Park@everythingauto.com', 1),
('Jason','Church','416-342-2231','Jason.Church@everythingauto.com', 2),
('Dimitri','Wang','416-756-4323','Dimitri.Wang@everythingauto.com', 3),
('Hooman','Kasim','416-675-0855','Hooman.Kasim@everythingauto.com', 1),
('Laura','Lin','416-349-4534','Laura.Lin@everythingauto.com', 1),
('Ali','Khan','416-344-9456', 'Ali.Khan@everythingauto.com', 1),
('Kiatisak','Nathan','416-346-3368','Kiatisak.Nathan@everythingauto.com', 1),
('Jose','Pena','416-088-5454','Jose.Pena@everythingauto.com', 1),
('Geoff','Yang','416-443-342','Geoff.Yang@everythingauto.com', 1),
('Hyumin','Kim','416-674-6458','Hyumin.Kim@everythingauto.com', 1),
('Alena','Kosak','416-234-3462','Alena.Kosak@everythingauto.com', 2),
('Erika','Valik','416-346-6763','Erika.Valik@everythingauto.com', 2);
select * from personnel;

drop table if exists role;
create table role (
	id int auto_increment primary key,
    name varchar(50) not null      
);
delete from role;
alter table role auto_increment = 1;
insert into role (name) values ('Manager'), ('Employee'), ('SysAdmin');
select * from role;

drop table if exists pers_role;
create table pers_role (
	id int auto_increment primary key,
    personnel_id int not null,
    role_id int not null
    , CONSTRAINT fk_pers_role_personnel_id FOREIGN KEY (personnel_id) REFERENCES personnel (id) ON UPDATE CASCADE ON DELETE CASCADE
    , CONSTRAINT fk_pers_role_role_id FOREIGN KEY (role_id) REFERENCES role (id) ON UPDATE CASCADE ON DELETE CASCADE
);
delete from pers_role;
alter table pers_role auto_increment = 1;
insert into pers_role (personnel_id, role_id)  values
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 2),
(10, 2),
(11, 2),
(12, 2);
select * from pers_role;

drop table if exists store;
create table store (
	id int auto_increment primary key, 
    address varchar(100) not null, 
    city varchar(50) not null, 
    prov varchar(50) not null, 
    postalcode varchar(50) not null,
    country varchar(50) not null,
    phone varchar(15) not null, 
    email varchar(50) not null, 
    mgr_id int not null,
    created_time datetime not null default current_timestamp(),
    last_updated datetime not null default current_timestamp()
    , CONSTRAINT fk_store_personnel_id  FOREIGN KEY  (mgr_id) references personnel (id) ON UPDATE CASCADE ON DELETE CASCADE  
);

delete from store;
alter table store auto_increment = 1;
insert into store (address, city, prov, postalcode, country, phone, email, mgr_id) values 
('353 Queen St W', 'Toronto', 'ON', 'A1G 2Z2', 'Canada', '416-234-5233', 'store1@everythingauto.com', 6),
('85 King St E', 'Markham', 'ON', 'B1B 2K2', 'Canada', '905-435-3455', 'store2@everythingauto.com', 5),
('92 Bathus St N', 'Subury', 'ON', 'P2H 5E8', 'Canada', '905-435-3455', 'store3@everythingauto.com', 4),
('74 Jane St W', 'Niagara', 'ON', 'F1D 9U2', 'Canada', '905-435-3455', 'store4@everythingauto.com', 3),
('29 Loon St S', 'Kingston', 'ON', 'K5S 3K1', 'Canada', '905-435-3455', 'store5@everythingauto.com', 2),
('35 Bay St S', 'Hamilton', 'ON', 'E6M 0W2', 'Canada', '905-435-3455', 'store6@everythingauto.com', 1);
select * from store;


drop table if exists payment;
create table payment (
	id int auto_increment primary key,
	cust_id int not null,
    method enum ('VS', 'MC') not null,
    card_number varchar(16) not null, 
    card_first_name varchar(50) not null,     
    card_last_name varchar(50) not null,
    card_middle_name varchar(50), 
    exp_mm tinyint not null,
    exp_yy tinyint not null,
    sec_code mediumint not null,
    created_time datetime not null default current_timestamp(),
    last_updated datetime not null default current_timestamp(),
    CHECK (exp_mm > 0 and exp_mm < 13),
    CHECK (exp_yy > 22 and exp_yy < 100)
    , CONSTRAINT fk_payment_cust_id  FOREIGN KEY  (cust_id) references customer (id) ON UPDATE CASCADE ON DELETE CASCADE  
);
delete from payment;
alter table payment auto_increment = 1;
insert into payment (cust_id, method, card_number, card_first_name, card_last_name, exp_mm, exp_yy, sec_code) values 
(1, 'VS', '1234567890123456', 'James', 'Smith', 1, 25, 123),
(2, 'VS', '1234567890123457', 'James', 'Smith', 2, 26, 223),
(3, 'VS', '1234567890123458', 'James', 'Smith', 3, 27, 323),
(4, 'VS', '1234567890123459', 'James', 'Smith', 4, 28, 423),
(5, 'VS', '1234567890123450', 'James', 'Smith', 5, 29, 523),
(6, 'VS', '1234567890123411', 'James', 'Smith', 6, 27, 623),
(7, 'VS', '1234567890123412', 'James', 'Smith', 7, 24, 723),
(8, 'VS', '1234567890123413', 'James', 'Smith', 8, 29, 823),
(9, 'VS', '1234567890123414', 'James', 'Smith', 9, 26, 923),
(10, 'MC', '1234567890123415', 'James', 'Smith', 10, 27, 343),
(11, 'MC', '1234567890123416', 'James', 'Smith', 11, 28, 353),
(12, 'MC', '1234567890123417', 'James', 'Smith', 12, 29, 363),
(13, 'MC', '1234567890123418', 'James', 'Smith', 11, 29, 373),
(14, 'MC', '1234567890123419', 'James', 'Smith', 10, 24, 383),
(15, 'MC', '1234567890123420', 'James', 'Smith', 9, 25, 393),
(16, 'MC', '1234567890123421', 'James', 'Smith', 8, 26, 403),
(17, 'MC', '1234567890123422', 'James', 'Smith', 7, 27, 413),
(18, 'MC', '1234567890123423', 'James', 'Smith', 6, 28, 423),
(19, 'MC', '1234567890123424', 'James', 'Smith', 5, 29, 433),
(20, 'MC', '1234567890123425', 'James', 'Smith', 4, 25, 443);
select * from payment;

drop table if exists supplier;
create table supplier (
	id int auto_increment primary key,
    supplier_name varchar(50) not null, 
    address varchar(100) not null, 
    city varchar(50) not null,
    prov varchar(50) not null,
    postalcode varchar(50) not null,
    country varchar(50) not null,
    phone varchar(15) not null, 
    email varchar(50) not null, 
    website varchar(50) not null, 
    rep_name varchar(50),
    created_time datetime not null default current_timestamp(),
    last_updated datetime not null default current_timestamp()
);

delete from supplier;
alter table supplier auto_increment = 1;
insert into supplier (supplier_name, address, city, prov, postalcode, country, phone, email, website, rep_name) values 
('Magna International Inc','20 Rain Deer St E', 'Brampton', 'ON', 'V1V 1V1', 'Canada', '416-436-1341', 'sales@magna.com', 'http://magna.com', 'Takis Mehran'),
('Linama Autoparts Inc','199 Seeroad St S', 'Mississauga', 'ON', 'A1V 1Z1', 'Canada', '905-453-7842', 'sales@linama.com', 'http://linama.com', 'Cherry Park'),
('Johndeer Autoparts Inc','23 Whitehead St S', 'New Mexico', 'TX', '123456', 'USA', '705-435-3432', 'sales@johndeer.com', 'http://johndeer.com', 'Sindie Colhm'),
('Blue Engine Inc','67 Prince St S', 'Montreal', 'QC', 'D5V 2H9', 'Canada', '634-435-3432', 'sales@blueengine.ca', 'http://blueengine.ca', 'Halar Van Dersak'),
('Out Of Bussiness Inc','01 Bankrupcy Ave', 'Montreal', 'QC', 'D5V 2H9', 'England', '123-456-0000', 'sales@oob.uk', 'http://oob.uk', 'John Doe');
select * from supplier;

drop table if exists product;
create table product (
	id int auto_increment primary key,
    skew varchar(50) not null,
    prod_name varchar(100) not null,
    man_date int not null,
    orig_country varchar(100) not null,
    supplier_id int not null,
    created_time datetime not null default current_timestamp(),
    last_updated datetime not null default current_timestamp()
    , CONSTRAINT fk_product_supplier_id FOREIGN KEY (supplier_id) REFERENCES supplier (id) ON UPDATE CASCADE ON DELETE CASCADE
);
delete from product;
alter table product auto_increment = 1;
insert into product (skew, prod_name, man_date, orig_country, supplier_id) values
('1225030', 'CB90283 ProSeries OE Control Arm', 19990830, 'USA', 3),
('0176066', '2994 Anchor Engine Mount', 20050725, 'CAN', 1),
('0150285', '50-2740 Perfection Flywheel', 20051225, 'CAN', 2),
('1122596', '50463 Walker Ultra (Direct Fit) Catalytic Converter', 20081129, 'CAN', 4),
('1413488', '15778 MagnaFlow Cat-Back Performance Series Exhaust System', 20110502, 'CAN', 4),
('1120572', '18823 Walker SoundFX Muffler', 20150502, 'USA', 3),
('0158323', '360128 Perfection Clutch Hydraulics', 20000120, 'USA', 3),
('0150581', 'PT614174 PTC Driveline Bearings', 20000120, 'CAN', 2),
('1171113', '31554 Nickson Exhaust Gasket', 20230621, 'CAN', 2),
('1232885', 'LO186 Spectra Fuel Tank Locking Ring', 20220218, 'CAN', 1),
('1202043', '746-011 Dorman Door Lock Actuator', 20160922, 'CAN', 1),
('1125400', '52216 Walker Pipe', 20100429, 'CAN', 4);
;
select * from product;

drop table if exists inventory;
create table inventory  (
	id int auto_increment primary key,    
    prod_id int not null,
    avail_qty int not null default 0,
    note varchar(100),
    created_time datetime not null default current_timestamp(),
    last_updated datetime not null default current_timestamp()
    , CONSTRAINT fk_inventory_product_id FOREIGN KEY (prod_id) REFERENCES product (id) ON UPDATE CASCADE ON DELETE CASCADE
);

delete from inventory;
alter table inventory auto_increment = 1;
insert into inventory (prod_id, avail_qty) values
(1, 34), 
(2, 48), 
(3, 53),
(4, 15), 
(5, 23), 
(6, 71),
(7, 43), 
(8, 40), 
(9, 29),
(10, 38), 
(11, 9), 
(12, 4);
select * from inventory;

drop table if exists orders;
create table orders (
	id int auto_increment primary key,
    order_date int not null,
    cust_id int not null,
    note varchar(50), 
    created_time datetime not null default current_timestamp(),
    last_updated datetime not null default current_timestamp(),
    CONSTRAINT fk_order_cust_id FOREIGN KEY (cust_id) REFERENCES customer (id) ON UPDATE CASCADE ON DELETE CASCADE
);

delete from orders;
alter table orders auto_increment = 1;
insert into orders (order_date, cust_id) values 
(20210101, 1),
(20220102, 2),
(20230103, 3),
(20230104, 4),
(20210107, 5),
(20220105, 5),
(20230106, 5)
;
select * from orders;


drop table if exists order_item;
create table order_item (
	id int auto_increment primary key,
    order_id int not null,
    prod_id int not null,
    qty int not null,
    unit_price decimal(10, 2) not null,
    amount decimal(10, 2) not null default (qty * unit_price),     
    created_time datetime not null default current_timestamp(),
    last_updated datetime not null default current_timestamp()
    , CONSTRAINT fk_order_item_order_id FOREIGN KEY (order_id) REFERENCES orders (id) ON UPDATE CASCADE ON DELETE CASCADE
    , CONSTRAINT fk_order_item_product_id FOREIGN KEY (prod_id) REFERENCES product (id) ON UPDATE CASCADE ON DELETE CASCADE
);
delete from order_item;
alter table order_item auto_increment = 1;
insert into order_item (order_id, prod_id, qty, unit_price) values 
(1, 1, 1, 50.99),
(1, 2, 2, 51.39),
(1, 3, 3, 52.49),
(2, 5, 1, 53.99),
(2, 6, 2, 60.39),
(3, 7, 3, 61.39),
(3, 8, 4, 62.39),
(4, 9, 5, 63.39),
(4, 1, 6, 50.39),
(4, 2, 6, 51.39),
(5, 10, 6, 71.39),
(6, 1, 7, 50.99),
(6, 2, 6, 51.39)
;
select * from order_item;


drop table if exists shipment;
create table shipment (  
	id int auto_increment primary key,   
    order_id int not null, 
	start_date int default (date_format(curdate(), '%Y%m%d') * 1) not null,
    exp_del_date int,
    status enum ('PACKAGING', 'STARTED', 'ON_ROUTE', 'ARRIVED', 'DELIVERED') not null,
	note varchar(100),  
    CONSTRAINT fk_shipment_order_id FOREIGN KEY (order_id) REFERENCES orders (id) ON UPDATE CASCADE ON DELETE CASCADE
);

delete from shipment;
alter table shipment auto_increment = 1;
insert into shipment (order_id, start_date, exp_del_date, status) values 
(1, 20210101, 20210101+7, 'DELIVERED'),
(2, 20220102, 20220102+2, 'DELIVERED'),
(3, 20230103, 20230103+5, 'DELIVERED'), 
(4, 20230104, 20230104+7, 'DELIVERED'),
(5, 20210107, 20210107+3, 'DELIVERED'),
(6, 20230103, 20230103+7, 'DELIVERED'),
(7, 20230106, 20230106+7, 'DELIVERED');

select * from shipment;




SHOW TABLES;
Select FOUND_ROWS() as SETUP_COMPLETED_FOR_TOTAL_TABLES;

commit;

