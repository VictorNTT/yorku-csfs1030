/*
Example of inner join, left outer join, right outer join.
Prerequisite: Run Customers_Orders_Tables_Setup.sql 
*/

/* INNER JOIN returns all records matched between two tables */
SELECT c.FNAME, c.LNAME, o.ORDER_DESC FROM ORDERS o INNER JOIN CUSTOMERS c ON o.CUST_ID = c.ID;

/* LEFT JOIN returns all records matched between two tables, plus all records of the left table */
SELECT c.FNAME, c.LNAME, o.ORDER_DESC FROM ORDERS o LEFT OUTER JOIN CUSTOMERS c ON o.CUST_ID = c.ID;

/* RIGHT JOIN returns all records matched between two tables, plus all records of the right table */
SELECT c.FNAME, c.LNAME, o.ORDER_DESC FROM ORDERS o RIGHT OUTER JOIN CUSTOMERS c ON o.CUST_ID = c.ID;

/* Work like inner join */
SELECT c.FNAME, c.LNAME, o.ORDER_DESC FROM ORDERS o CROSS JOIN CUSTOMERS c WHERE o.CUST_ID = c.ID;

/* Find the customer who has most orders*/
select 'Shopper of the month' as AWARD,  c.FNAME, c.LNAME, MAX(ORDER_COUNT) ORDER_COUNT from  
	(Select CUST_ID,  COUNT(CUST_ID) as ORDER_COUNT from ORDERS group by CUST_ID) as oc, CUSTOMERS c
    where c.ID = oc.CUST_ID;
	
	
