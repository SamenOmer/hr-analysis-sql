use hr;
select * from hr_raw;
ALTER TABLE hr_raw
  MODIFY COLUMN Employee_ID            INT,
  MODIFY COLUMN Department             VARCHAR(50),
  MODIFY COLUMN Gender                 VARCHAR(10),
  MODIFY COLUMN Age                    INT,
  MODIFY COLUMN Job_Title              VARCHAR(100),
  MODIFY COLUMN Hire_Date              DATE,
  MODIFY COLUMN Years_At_Company       INT,
  MODIFY COLUMN Education_Level        VARCHAR(20),
  MODIFY COLUMN Performance_Score      INT,
  MODIFY COLUMN Monthly_Salary         DECIMAL(10,2),
  MODIFY COLUMN Work_Hours_Per_Week    INT,
  MODIFY COLUMN Projects_Handled       INT,
  MODIFY COLUMN Overtime_Hours         INT,
  MODIFY COLUMN Sick_Days              INT,
  MODIFY COLUMN Remote_Work_Frequency  VARCHAR(5),
  MODIFY COLUMN Team_Size              INT,
  MODIFY COLUMN Training_Hours         INT,
  MODIFY COLUMN Promotions             INT,
  MODIFY COLUMN Employee_Satisfaction_Score DECIMAL(3,1),
  MODIFY COLUMN Resigned               char(50);
  select * from hr_raw;
  
  select distinct Resigned from hr_raw;
  
UPDATE hr_raw SET Resigned =
CASE 
  WHEN Resigned ='True' THEN 1
  WHEN Resigned='False' THEN 0
END;
select distinct Resigned from hr_raw;
ALTER TABLE hr_raw
modify column Resigned TINYINT(1);
  
  select * from hr_raw;
  SELECT Employee_ID, COUNT(*)
FROM hr_raw
GROUP BY Employee_ID
HAVING COUNT(*) > 1;

SELECT
    SUM(Employee_ID IS NULL) AS Employee_ID_nulls,
    SUM(Department IS NULL) AS Department_nulls,
    SUM(Gender IS NULL) AS Gender_nulls,
    SUM(Age IS NULL) AS Age_nulls,
    SUM(Job_Title IS NULL) AS Job_Title_nulls,
    SUM(Hire_Date IS NULL) AS Hire_Date_nulls,
    SUM(Years_At_Company IS NULL) AS Years_At_Company_nulls,
    SUM(Education_Level IS NULL) AS Education_Level_nulls,
    SUM(Performance_Score IS NULL) AS Performance_Score_nulls,
    SUM(Monthly_Salary IS NULL) AS Monthly_Salary_nulls,
    SUM(Work_Hours_Per_Week IS NULL) AS Work_Hours_Per_Week_nulls,
    SUM(Projects_Handled IS NULL) AS Projects_Handled_nulls,
    SUM(Overtime_Hours IS NULL) AS Overtime_Hours_nulls,
    SUM(Sick_Days IS NULL) AS Sick_Days_nulls,
    SUM(Remote_Work_Frequency IS NULL) AS Remote_Work_Frequency_nulls,
    SUM(Team_Size IS NULL) AS Team_Size_nulls,
    SUM(Training_Hours IS NULL) AS Training_Hours_nulls,
    SUM(Promotions IS NULL) AS Promotions_nulls,
    SUM(Employee_Satisfaction_Score IS NULL) AS Employee_Satisfaction_Score_nulls,
    SUM(Resigned IS NULL) AS Resigned_nulls
FROM hr_raw;

#making smll atbles
CREATE TABLE department (
  dept_id   INT PRIMARY KEY AUTO_INCREMENT,
  dept_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO department (dept_name)
SELECT DISTINCT Department FROM hr_raw;

CREATE TABLE job (
  job_id    INT PRIMARY KEY AUTO_INCREMENT,
  job_title VARCHAR(100) UNIQUE NOT NULL
);

INSERT INTO job (job_title)
SELECT DISTINCT Job_Title FROM hr_raw;

select * from job;

CREATE TABLE employees (
  employee_id      INT PRIMARY KEY,
  gender           VARCHAR(10),
  age              TINYINT,
  hire_date        DATE,
  years_at_company INT,
  team_size        TINYINT,
  dept_id          INT,
  job_id           INT,
  FOREIGN KEY (dept_id) REFERENCES department(dept_id),
  FOREIGN KEY (job_id)  REFERENCES job(job_id)
);

INSERT INTO employees
SELECT r.Employee_ID, r.Gender, r.Age, r.Hire_Date,
       r.Years_At_Company, r.Team_Size, d.dept_id, j.job_id
FROM hr_raw r
JOIN department d ON r.Department = d.dept_name
JOIN job       j ON r.Job_Title  = j.job_title;
select * from employees;

CREATE TABLE work_stats (
  employee_id           INT PRIMARY KEY,
  monthly_salary        DECIMAL(10,2),
  work_hours_per_week   TINYINT,
  projects_handled      INT,
  overtime_hours        INT,
  sick_days             TINYINT,
  remote_work_frequency TINYINT,
  training_hours        INT,
  promotions            TINYINT,
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO work_stats
SELECT Employee_ID, Monthly_Salary, Work_Hours_Per_Week,
       Projects_Handled, Overtime_Hours, Sick_Days,
       Remote_Work_Frequency, Training_Hours, Promotions
FROM hr_raw;

CREATE TABLE employee_outcomes (
  employee_id                 INT PRIMARY KEY,
  performance_score           TINYINT,
  employee_satisfaction_score DECIMAL(3,1),
  resigned                    TINYINT(1),
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO employee_outcomes
SELECT Employee_ID, Performance_Score,
       Employee_Satisfaction_Score, Resigned
FROM hr_raw;
select * from employee_outcomes;

-- Row counts must all equal hr_raw
SELECT COUNT(*) FROM hr_raw;          
SELECT COUNT(*) FROM employees;       
SELECT COUNT(*) FROM work_stats;      
SELECT COUNT(*) FROM employee_outcomes;

-- Full joined record check
SELECT
  e.employee_id,
  d.dept_name,
  j.job_title,
  w.monthly_salary,
  w.promotions,
  o.performance_score,
  o.resigned
FROM employees e
JOIN department     d ON e.dept_id     = d.dept_id
JOIN job           j ON e.job_id      = j.job_id
JOIN work_stats      w ON e.employee_id = w.employee_id
JOIN employee_outcomes o ON e.employee_id = o.employee_id
;

#resifnation rate vs department
select d.dept_name,count(*) as total,
sum(o.resigned) as resigned,
round(sum(o.resigned)/count(*) *100,2) as resignation_rate
from employees e
join department d on e.dept_id=d.dept_id
join employee_outcomes o on e.employee_id=o.employee_id
group by d.dept_name
order by resignation_rate DESC; 

#salary anlysis
select d.dept_name,round(avg(w.monthly_salary),2) as avg_salary
from employees e
join department d on e.dept_id=d.dept_id
join work_stats w on w.employee_id=e.employee_id
group by d.dept_name
order by avg_salary desc;

#performance analysis

select d.dept_name,round(avg(o.performance_score),2) as avg_performance_score
from employees e
join department d on e.dept_id=d.dept_id
join employee_outcomes o on e.employee_id=o.employee_id
group by d.dept_name
order by avg_performance_score desc;

#satisfaction vs resignation rate
select o.resigned,round(avg(o.employee_satisfaction_score),2) as avg_sat_score
from employee_outcomes o 
group by o.resigned;

#overtime impact
select o.resigned,round(avg(w.overtime_hours),2) as avg_ovrtime_hours
from work_stats w
join employee_outcomes o  on o.employee_id=w.employee_id
group by o.resigned;

#tenure anlysis vs resignation rate
SELECT
CASE
 when  e.years_at_company <1 then"less than 1 year"
 when e.years_at_company <=3 then"1-3 years"
 when e.years_at_company <=5 then"3-5 years"
 else "5+years"
END AS tenure_bucket,
count(*) as total,sum(o.resigned) as resigned,round(sum(o.resigned)/count(*)*100,2) as resignation_rate
from employees e
join employee_outcomes o on e.employee_id=o.employee_id
group by tenure_bucket
order by resignation_rate desc;

#detmining effect of traing on permance score
select min(training_hours) from work_stats;
select max(training_hours) from work_stats;

select
CASE
 WHEN w.training_hours <=25 then "low training"
 WHEN w.training_hours <=50 then "medium training"
 WHEN w.training_hours <=75 then "high training"
 ELSE "very high training"
end as training_bucket,
round(avg(o.performance_score),2) as avg_perf_score
from work_stats w
join employee_outcomes o on o.employee_id=w.employee_id
group by training_bucket
order by avg_perf_score desc;

#does promotion reduces resignation 
select w.promotions,count(*) as total,sum(o.resigned) as resigned,
round(sum(o.resigned)/count(*)*100) as resignation_rate
from work_stats w
join employee_outcomes o  on o.employee_id=w.employee_id
group by w.promotions
order by w.promotions desc;

#age group analysis 
select min(age) from employees;
select max(age) from employees;

select 
case 
 when age between 20 and 29 then "20-29"
 when age between 30 and 39 then "30-39"
 when age between 40 and 49 then "40-49"
 when age between 50 and 60 then "50-60"
 end as age_group,count(*) as employee_count,
round(count(*)/(select count(*) FROM employees)*100,2)
from employees 
group by age_group
order by age_group;

#select 
SELECT 
  CASE
    WHEN e.age < 30 THEN 'Under 30'
    WHEN e.age <= 40 THEN '30-40'
    WHEN e.age <= 50 THEN '40-50'
    ELSE '50+'
  END AS age_group,
round(avg(w.monthly_salary),2)as avg_salry,round(avg(o.performance_score),2)as avg_performance,
round(sum(o.resigned)/count(*)*100,2) as resignation_rate
from employees e
join work_stats w on e.employee_id=w.employee_id
join employee_outcomes o on e.employee_id=o.employee_id
group by age_group
order by age_group;

#performance vs salary

select o.performance_score,round(avg(w.monthly_salary),2) as avg_salary
from employee_outcomes o 
join work_stats w on o.employee_id=w.employee_id
group by o.performance_score
order by avg_salary desc;

#remote work analysis does working remote has effect on performance score and on satisfaction score
select distinct remote_work_frequency from work_stats;

select w. remote_work_frequency,count(*) as total_employees,
ROUND(AVG(w.work_hours_per_week),2) AS avg_hours,
round(avg(o.employee_satisfaction_score),2) as avg_sat_score,
round(avg(o.performance_score),2) as avg_performance
from work_stats w
join employee_outcomes o on w.employee_id=o.employee_id
group by w.remote_work_frequency 
order by w.remote_work_frequency;

#gender pay gap
select e.gender,round(avg(monthly_salary),2) as avg_salary,round(avg(o.performance_score),2) as avg_performance
from employees e
join work_stats w on e.employee_id=w.employee_id
join employee_outcomes o on e.employee_id=o.employee_id
group by e.gender;

#top 10 employees

select e.employee_id,e.gender,d.dept_name,j.job_title,w.monthly_salary,o.performance_score,e.years_at_company
from employees e
join work_stats w on e.employee_id=w.employee_id
join employee_outcomes o on e.employee_id=o.employee_id
join department d on e.dept_id=d.dept_id
join job j on e.job_id=j.job_id
order by w.monthly_salary DESC limit 10;

SELECT e.employee_id,d.dept_name,w.monthly_salary,
       RANK() OVER (PARTITION BY d.dept_name 
                    ORDER BY w.monthly_salary DESC) as salary_rank
from employees e
join work_stats w on e.employee_id=w.employee_id
join department d on e.dept_id=d.dept_id;
;
select * from 
(SELECT e.employee_id, d.dept_name, w.monthly_salary,
       RANK() OVER (PARTITION BY d.dept_name 
                    ORDER BY w.monthly_salary DESC) AS salary_rank
FROM employees e
JOIN department d ON e.dept_id = d.dept_id
JOIN work_stats w ON e.employee_id = w.employee_id)
as ranked 
where salary_rank=1
order by dept_name,salary_rank;

















