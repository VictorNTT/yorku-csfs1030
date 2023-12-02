
Use everything_auto;

-- select the product which has MAX qty available from Inventory (INNER JOIN w Product & Supplier)
select * from inventory order by avail_qty desc;
select * from product where id = 6;
Select i.prod_id, p.skew, p.prod_name, s.supplier_name, s.country 
from inventory i 
	inner join product p on i.id = p.id 
	inner join supplier s on p.supplier_id = s.id
where avail_qty = (select MAX(avail_qty) from inventory);


-- user UNION  -- must have the same column set
-- select products that have min and max available qty
Select i.prod_id, p.skew, p.prod_name, i.avail_qty, s.supplier_name, s.country 
from inventory i 
	inner join product p on i.id = p.id 
	inner join supplier s on p.supplier_id = s.id
where avail_qty =  (select MIN(avail_qty) from inventory)
UNION 
select i.prod_id, p.skew, p.prod_name,i.avail_qty, s.supplier_name, s.country 
from inventory i 
	inner join product p on i.id = p.id 
	inner join supplier s on p.supplier_id = s.id
where avail_qty =  (select MAX(avail_qty) from inventory);


-- Use ORDER BY and LIMIT
Select prod_id from inventory order by  avail_qty desc LIMIT 1;


-- user MIN, MAX 
Select MIN(avail_qty), MAX(avail_qty) from inventory;


-- Use inline tabler and GROUP BY
Select  orig_country, SUM(avail_qty) 
from (
	select i.id, i.prod_id, i.avail_qty, p.orig_country from inventory i inner join product p on i.id =  p.id where i.avail_qty > 4 ) 
	As InvByCountry 
GROUP BY orig_country;

-- Select all Manager and Dept's
Select p.first_name, p.last_name, d.name as Dept from personnel p 
inner join pers_role_dept prd on p.id = prd.personnel_id 
inner join role r on prd.role_id = r.id 
inner join department d on prd.dept_id = d.id 
where r.name = 'Manager';

-- Select all Sales and Finance employees
Select p.first_name, p.last_name, d.name as Dept  from personnel p 
inner join pers_role_dept prd on p.id = prd.personnel_id 
inner join role r on prd.role_id = r.id 
inner join department d on prd.dept_id = d.id 
where r.name = 'Employee' and d.name = 'Sales'
UNION 
Select p.first_name, p.last_name, d.name as Dept  from personnel p 
inner join pers_role_dept prd on p.id = prd.personnel_id 
inner join role r on prd.role_id = r.id 
inner join department d on prd.dept_id = d.id 
where r.name = 'Employee' and d.name = 'Finance';

-- select all orders (or by order ID) with details 
Select oi.order_id, p.prod_name, oi.qty, oi.unit_price, 
	(oi.qty * oi.unit_price) as subtotal, 
	(oi.qty * oi.unit_price * 0.13) as HST, 
    -- date_format(oi.last_updated, "%m-%d-%Y") as order_date 
    o.order_date 
from order_item oi 
inner join product p on oi.prod_id  = p.id
inner join orders  o on oi.order_id = o.id
-- where order_id != 0 -- replace with an order ID
order by oi.order_id;

-- Select the delivery contact using CASE WHEN 
Select 
	contact_type,
	CASE
		when contact_type = 'D' then id
		when contact_type = 'R' then id
		else -1 /* Return -1 ONLY when a contact is found, but contact_type is neither D or R (e.g try removing R mathching and set cust_id = 10).
				-1 is not returned (empty result set) if no contact is found (e.g try cust_id = 1000) */
	END as contact_id
from Contact where cust_id = 1 -- customer 1 and 5 both have two contacts R and D,
order by  contact_type desc
limit 1; -- select first matched contact only 

-- select the FASTEST shipment to date
select * from shipment where (exp_del_date - start_date) = (Select MIN(exp_del_date - start_date)  from shipment);

-- Find the shipment info of an order (or orders, remove order id check)
-- CREATE OR REPLACE VIEW ShipmentInfo_V AS 
Select 
	o.id as order_id, o.cust_id,
	cust.first_name, cust.last_name,
	c.contact_type, c.address, c.city, c.prov, c.postalcode, c.country, c.phone,
    s.status
from orders o
	inner join contact c on o.cust_id = c.cust_id 
    inner join customer cust on o.cust_id = cust.id 
    inner join shipment s on o.id = s.order_id 
where 
	-- o.id = 1	and 
    c.id = 
	(Select 
		CASE
			when contact_type = 'D' then id
			when contact_type = 'R' then id
			else -1 /* Return -1 ONLY when a contact is found, but contact_type is neither D or R (e.g try removing R mathching and set cust_id = 10).
					-1 is not returned (empty result set) if no contact is found (e.g try cust_id = 1000) */
		END as contact_id
	from Contact 
	where cust_id = c.cust_id  -- customer 1 and 5 both havve two contacts R and D,
	order by  contact_type desc
	 limit 1 -- select first matched contact only 
	);
    
-- Select * from ShipmentInfo_V;

-- select AVG population, UNION
SELECT 'Canada' as Country, AVG(population)   FROM world.city where CountryCode = 'CAN'
UNION  
SELECT 'USA' as Country,  AVG(population)  FROM world.city where CountryCode = 'USA'
UNION  
SELECT 'World' as Country, AVG(population)  FROM world.city;


-- HAVING, BETWEEN
SELECT *  FROM world.city HAVING Population > 5000000 or Population < 5000;
SELECT *  FROM world.city HAVING Population between 5000 and 60000;
SELECT *  FROM world.city HAVING Population > 10000000;

 

