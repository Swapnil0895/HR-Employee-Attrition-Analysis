use Hr_analytics_project;
drop table HR_1;
select  * from Hr_1;
select count(*) from HR_1;
drop table hr_1;

create table HR_1
(Age int,
Attrition varchar(255),
BusinessTravel varchar(255),
DailyRate int,
Department varchar(255),
DistanceFromHome int,
Education int,
EducationField varchar(255),
EmployeeCount int,
EmployeeNumber int,
EnvironmentSatisfaction int,
Gender varchar(255),
HourlyRate int,
JobInvolvement int,
JobLevel int,
JobRole varchar(255),
JobSatisfaction int,
MaritalStatus varchar(255)
);

select * from HR_1;

set global local_infile=on;
Load data local infile 'C:/Users/Swapnil/OneDrive/Desktop/DA project 2/P933  HR Analytics/P933  HR Analytics/HR_1.csv' into table HR_1
fields terminated by ','
ignore 1 lines;

select * from HR_1;

desc table HR_1;

create table HR_2
(Employee_ID int,	
MonthlyIncome int,
MonthlyRate	int,
NumCompaniesWorked int,
Over18 varchar (10),
OverTime int,
PercentSalaryHike int,
PerformanceRating int,	
RelationshipSatisfaction int,	
StandardHours int,
StockOptionLevel int,	
TotalWorkingYears int,	
TrainingTimesLastYear int,	
WorkLifeBalance	int,
YearsAtCompany int,
YearsInCurrentRole int,
YearsSinceLastPromotion int,	
YearsWithCurrManager int
);

set global local_infile=on;
Load data local infile "C:/Users/Swapnil/OneDrive/Desktop/DA project 2/P933  HR Analytics/P933  HR Analytics/HR_2.csv" into table Hr_2
fields terminated by ','
ignore 1 lines;

select * from HR_2;

-- Q5 Job Role Vs Work life balance --

select a.jobrole,avg(b.worklifebalance) as Avg_work_life_balance
from HR_1 as a inner join HR_2 as b
on a.employeenumber = b.employee_id
group by 1
order by 2 desc;

#Average Attrition rate for all Departments

select * from HR_1;
select * from HR_2;

select a.department,avg(case when a.attrition ='yes' then 1 else 0 end) as Avg_attrition_rate
from Hr_1 as a inner join hr_2 as b
on a.employeenumber = b.Employee_ID
group by   a.department
order by Avg_attrition_rate desc;

select a.department,avg(case when a.attrition ='yes' then 1 else 0 end) as Avg_attrition_rate
from Hr_1 as a inner join hr_2 as b
on a.employeenumber = b.Employee_ID
group by 1
order by 2 desc;

-- Q2 Average Hourly rate of Male Research Scientist --

select distinct jobrole from HR_1;
select * from Hr_1;

select avg(hourlyrate) as Avg_rate,Jobrole 
from Hr_1
where jobrole = "research Scientist" and gender = "male" 
group by 2
order by 1 desc; -- done by me no Join needed --

SELECT
    AVG(h1.HourlyRate) AS AvgHourlyRate
FROM
    HR_1 h1
JOIN
    HR_2 h2
    ON h1.EmployeeNumber = h2.Employee_ID
WHERE
    h1.Gender = 'Male'
    AND h1.JobRole = 'Research Scientist'; -- GPT solution --
    
    -- Q3 Attrition rate Vs Monthly income stats --

select a.employeenumber as ID,a.Attrition,b.monthlyincome
from Hr_1 as a inner join Hr_2 as b
on a.employeenumber  = b.employee_id;

select b.employee_id ,a.Attrition,b.monthlyincome
from Hr_1 as a inner join Hr_2 as b
on a.employeenumber  = b.employee_id;

SELECT
    h1.Attrition AS AttritionStatus,
    AVG(h2.MonthlyIncome) AS AvgIncome,
    PERCENTILE_CONT(0.5) WITHIN GROUP 
    (ORDER BY h2.MonthlyIncome) AS MedianIncome,
    MIN(h2.MonthlyIncome) AS MinIncome,
    MAX(h2.MonthlyIncome) AS MaxIncome,
    COUNT(*) AS EmployeeCount
FROM
    HR_1 h1
JOIN
    HR_2 h2
    ON h1.EmployeeNumber = h2.[Employee ID]
GROUP BY
    h1.Attrition;


-- Q4 Average working years for each Department --
 
select a.Department,avg(b.yearsatcompany) as Avg_working_years
from hr_1 as a inner join hr_2 as b
on a.EmployeeNumber = b.Employee_ID
group by 1
order by 2 desc;

-- Q6 Attrition rate Vs Year since last promotion relation --

select avg (case when a.attrition = "yes" then 1 else 0 end) as Attrition_rate,
b.YearsSinceLastPromotion,count(*) as Employee_count
from hr_1 as a inner join  Hr_2 as b
on a.EmployeeNumber = b.employee_id
group by 2
order by 3 desc ;

 








