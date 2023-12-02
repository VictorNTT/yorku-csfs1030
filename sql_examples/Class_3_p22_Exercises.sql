-- Class 3 Exercises - Challenge on Page 22

use job_board_demo;

-- #1: Find the title and company id of the lowest paying job and display the name of the company.

select * from job_ads where hourly_pay is not null order by hourly_pay asc limit 1;  -- 2
select company_id, yearly_salary from job_ads where yearly_salary is not null order by yearly_salary
limit 1;  -- 3

select * from job_ads;

select 
	c.id, c.name, ja.hourly_pay
from 
	companies c inner join job_ads ja on c.id = ja.company_id
where 
	ja.hourly_pay = (select min(hourly_pay) from job_ads);

select 
	DISTINCT 
    c.id, c.name, ja.yearly_salary
     , ja.location
from 
	companies c inner join job_ads ja on c.id = ja.company_id
where 
	ja.yearly_salary = (select min(yearly_salary) from job_ads);  
-- A company has the same yearly_salary for two different roles - this will return duplicate data
-- > hint: DISTINCT 


-- #2: List all of the applicants for a specific position (consider which information to include).
-- #3: Add the name of the company to the list above.
select * from job_seekers order by id;
select * from applications order by job_ad_id, job_seeker_id;

select job_ad_id, count(job_ad_id) 
from applications group by job_ad_id order by job_ad_id;

-- Answer: given a Job Ad ID e.g 1 list all applicant's first and last name, job title, company name
select 	Distinct
	a.job_ad_id, a.job_seeker_id,
    js.first_name, js.last_name, ja.title, c.name, ja.location 
from applications a 
	inner join job_ads ja on a.job_ad_id = ja.id
    inner join companies c on ja.company_id = c.id
    inner join job_seekers js on a.job_seeker_id = js.id
 where a.job_ad_id = 1
order by a.job_ad_id, js.first_name, js.last_name

-- Duplicate records?
-- > hint: DISTINCT can't help!!! See the issue below:
-- Data accuracy:
-- The issue is that applications table does not have Job Location. 
-- The same company (by ID) has exact same role by for more than one location. We can't really
-- tell candidates have applied which role and location!!!!





