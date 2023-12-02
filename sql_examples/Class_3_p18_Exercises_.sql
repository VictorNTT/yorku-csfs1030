-- Answer questions in Page  18

-- Find the highest yearly salary in the job ads table.
select max(yearly_salary)  from job_ads;
-- Find the title and company id of the lowest paying (hourly) job.
select company_id, title from job_ads where hourly_pay = (select min(hourly_pay) mhs from job_ads) ;

-- Count how many currently active job ads there are in the database.
select count(*) from job_ads where expires_at > CURDATE();

-- Find the average hourly pay for all jobs of a specific company (e.g. company id = 1).
select avg(hourly_pay)  from job_ads where company_id = 2;

-- Find all jobs with a yearly salary between 60,000 and 80,000.
-- select *  from job_ads order by yearly_salary;
select *  from job_ads where yearly_salary >= 60000 and yearly_salary <= 80000;
select *  from job_ads where yearly_salary between 60000 and  80000;


-- List of all active job ads that contain "developer" in the title.
select *  from job_ads where title like '%developer%';

-- List of all active job ads that contain "dev" in the description.
select *  from job_ads where description like '%dev%';

-- List all job ads from companies which ids are given from a list (1, 2, 3).
select *  from job_ads where company_id in (1, 2, 3);


