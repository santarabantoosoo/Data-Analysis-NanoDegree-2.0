
-- techTFQ youtube channel 

-- Subquery in SQL | Correlated Subquery + Complete SQL Subqueries Tutorial - YouTube
-- https://www.youtube.com/watch?v=nJIEIzF7tDw&t=398s 



-- SELECT *
-- FROM EMPLOYEE;
--  select * from department;


 -- CHOOSE
 -- SELECT
-- WHERE
-- FROM
-- WITH
-- correlated
-- nested
-- join

--  /* QUESTION: Find the employees who's salary is more than the average salary earned by all employees. */ 

-- /* QUESTION: Find the employees who earn the highest salary in each department. */ 

--  /* QUESTION: Find department who do not have any employees */

--  /* QUESTION: Find the employees in each department who earn more than the average salary in that department. */ 

	/* QUESTION: Find department who do not have any employees */ -- Using correlated subquery

--  /* QUESTION: Find stores with sales that are better than the average sales accross all stores */ -- Hint what is the unit of analysis?

--  /* QUESTION: Find the employees who belong to the departments that are having average salaries more than the overall average





DROP TABLE employee_history;
DROP TABLE EMPLOYEE;
drop table department;
DROP table sales ;

create table department
(
	dept_id		int ,
	dept_name	varchar(50) PRIMARY KEY,
	location	varchar(100)
);
insert into department values (1, 'Admin', 'Bangalore');
insert into department values (2, 'HR', 'Bangalore');
insert into department values (3, 'IT', 'Bangalore');
insert into department values (4, 'Finance', 'Mumbai');
insert into department values (5, 'Marketing', 'Bangalore');
insert into department values (6, 'Sales', 'Mumbai');

CREATE TABLE EMPLOYEE
(
    EMP_ID      INT PRIMARY KEY,
    EMP_NAME    VARCHAR(50) NOT NULL,
    DEPT_NAME   VARCHAR(50) NOT NULL,
    SALARY      INT,
    constraint fk_emp foreign key(dept_name) references department(dept_name)
);
insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);


CREATE TABLE employee_history
(
    emp_id      INT PRIMARY KEY,
    emp_name    VARCHAR(50) NOT NULL,
    dept_name   VARCHAR(50),
    salary      INT,
    location    VARCHAR(100),
    constraint fk_emp_hist_01 foreign key(dept_name) references department(dept_name),
    constraint fk_emp_hist_02 foreign key(emp_id) references employee(emp_id)
);

create table sales
(
	store_id  		int,
	store_name  	varchar(50),
	product_name	varchar(50),
	quantity		int,
	price	     	int
);
insert into sales values
(1, 'Apple Store 1','iPhone 13 Pro', 1, 1000),
(1, 'Apple Store 1','MacBook pro 14', 3, 6000),
(1, 'Apple Store 1','AirPods Pro', 2, 500),
(2, 'Apple Store 2','iPhone 13 Pro', 2, 2000),
(3, 'Apple Store 3','iPhone 12 Pro', 1, 750),
(3, 'Apple Store 3','MacBook pro 14', 1, 2000),
(3, 'Apple Store 3','MacBook Air', 4, 4400),
(3, 'Apple Store 3','iPhone 13', 2, 1800),
(3, 'Apple Store 3','AirPods Pro', 3, 750),
(4, 'Apple Store 4','iPhone 12 Pro', 2, 1500),
(4, 'Apple Store 4','MacBook pro 16', 1, 3500);


select * from employee;
select * from department;
select * from employee_history;
select * from sales;


-- INTRO
--------------------------------------------------------------------------------
/* < WHAT IS SUBQUERIES? Sample subquery. How SQL processes this statement containing subquery? > */

/* QUESTION: Find the employees who's salary is more than the average salary earned by all employees. */
-- 1) find the avg salary
-- 2) filter employees based on the above avg salary
select *
from employee e
where salary > (select avg(salary) from employee)
order by e.salary;


-- another solution using window function

with salary as (
SELECT *,
avg(salary) OVER() avg_sal
FROM EMPLOYEE E
)

select * 
from salary
where salary > avg_sal

-- another solution using with clause

 WITH AVG_SALARY AS
	(SELECT AVG(SALARY) AS AVG_SAL
		FROM EMPLOYEE)
SELECT *
FROM EMPLOYEE
WHERE SALARY >
		(SELECT *
			FROM AVG_SALARY)

-- another solution using subquery within select 

with avg_salary as (
SELECT *, (select avg(salary) from employee) avg
FROM EMPLOYEE
	)
select * from avg_salary 
where salary > avg

-- TYPES OF SUBQUERY
--------------------------------------------------------------------------------
/* < SCALAR SUBQUERY > */
/* QUESTION: Find the employees who earn more than the average salary earned by all employees. */
-- it return exactly 1 row and 1 column

select *
from employee e
where salary > (select avg(salary) from employee)
order by e.salary;

select e.*, round(avg_sal.sal,2) as avg_salary
from employee e
join (select avg(salary) sal from employee) avg_sal
	on e.salary > avg_sal.sal;


--------------------------------------------------------------------------------
/* < MULTIPLE ROW SUBQUERY > */
-- Multiple column, multiple row subquery
/* QUESTION: Find the employees who earn the highest salary in each department. */
1) find the highest salary in each department.
2) filter the employees based on above result.
select *
from employee e
where (dept_name,salary) in (select dept_name, max(salary) from employee group by dept_name)
order by dept_name, salary;


-- another solution using WITH clause and join 

with max_salary as (
select dept_name, max(salary) max_sal
from employee 
group by dept_name 
)

select * 
from employee 
join max_salary 
using(dept_name)
where salary = max_sal


-- another solution using window functions 


-- Single column, multiple row subquery
/* QUESTION: Find department who do not have any employees */
1) find the departments where employees are present.
2) from the department table filter out the above results.
select *
from department
where dept_name not in (select distinct dept_name from employee);

-- another solution using JOINS 

SELECT *
FROM DEPARTMENT
LEFT JOIN EMPLOYEE USING(DEPT_NAME)
WHERE EMP_NAME IS NULL


-------------------------------------------------------------------------------
-- subquery returning a list 
 /* QUESTION: Find the employees who belong to the departments that are having average salaries more than the overall average 

 1- get the overall average 
 2- get the average per department 
 3- filter departments with average salaries > overall averages 
 4- select employees from these departments 
*/

-- if overall average means just the overall average across all employees

WITH LUX_DEPT AS
	(SELECT DEPT_NAME,
			AVG(SALARY)
		FROM EMPLOYEE
		GROUP BY 1
		HAVING AVG(SALARY) >
			(SELECT AVG(SALARY)
				FROM EMPLOYEE))

SELECT * FROM employee 
WHERE dept_name IN
(SELECT DEPT_NAME
FROM LUX_DEPT )


-- if overall average means average of dept average 

 WITH AVG_DEP AS
	(SELECT DEPT_NAME,
			AVG(SALARY) AVG_SAL
		FROM EMPLOYEE
		GROUP BY DEPT_NAME)
SELECT *
FROM EMPLOYEE
WHERE DEPT_NAME in
		(SELECT DEPT_NAME
			FROM AVG_DEP
			WHERE AVG_SAL >
					(SELECT AVG(AVG_SAL)
						FROM AVG_DEP))


-- a solution with window functions 

WITH AVG_DEP AS
	(SELECT *,
			AVG(SALARY) OVER(PARTITION BY DEPT_NAME) AVG_DEPART
		FROM EMPLOYEE),
	TBL AS
	(SELECT *,
			AVG(AVG_DEPART) OVER()
		FROM AVG_DEP)
SELECT *
FROM TBL
WHERE AVG_DEPART > AVG



--------------------------------------------------------------------------------
/* < CORRELATED SUBQUERY >
-- A subquery which is related to the Outer query
/* QUESTION: Find the employees in each department who earn more than the average salary in that department. */
1) find the avg salary per department
2) filter data from employee tables based on avg salary from above result.

select *
from employee e
where salary > (select avg(salary) from employee e2 where e2.dept_name=e.dept_name)
order by dept_name, salary;

-- another solution with joins 

with avg_dept as (
SELECT DEPT_NAME,
	AVG(SALARY) dept_avg
FROM EMPLOYEE
GROUP BY 1
)

select * from employee 
join avg_dept
using(dept_name)
where salary > dept_avg 

-- another solution using window function 

 WITH TBL AS
	(SELECT *,
			AVG(SALARY) OVER(PARTITION BY DEPT_NAME)
		FROM EMPLOYEE)
SELECT *
FROM TBL
WHERE SALARY > AVG

-- a try that should fail (check the error message)

SELECT *,
	(SELECT AVG(SALARY)
		FROM EMPLOYEE
		GROUP BY DEPT_NAME)
FROM EMPLOYEE


/* QUESTION: Find department who do not have any employees */
-- Using correlated subquery
SELECT *
FROM department d
where not exists (
select 1 
from employee e
	where e.dept_name = d.dept_name
)

-- this solution also works 

SELECT *
FROM DEPARTMENT D
WHERE dept_name NOT IN (select dept_name from employee)


-- another solutuion 

SELECT *
FROM DEPARTMENT
LEFT JOIN EMPLOYEE USING (DEPT_NAME)
where emp_id IS NULL  

--------------------------------------------------------------------------------
/* < SUBQUERY inside SUBQUERY (NESTED Query/Subquery)> */

/* QUESTION: Find stores whose sales were better than the average sales accross all stores */
1) find the sales for each store
2) average sales for all stores
3) compare 2 with 1
-- Using multiple subquery
select *
from (select store_name, sum(price) as total_sales
	 from sales
	 group by store_name) sales
join (select avg(total_sales) as avg_sales
	 from (select store_name, sum(price) as total_sales
		  from sales
		  group by store_name) x
	 ) avg_sales
on sales.total_sales > avg_sales.avg_sales;

-- Using WITH clause
with sales as
	(select store_name, sum(price) as total_sales
	 from sales
	 group by store_name)
select *
from sales
join (select avg(total_sales) as avg_sales from sales) avg_sales
	on sales.total_sales > avg_sales.avg_sales;

-- using WITH clause and subquery 

with store_pr as(
select store_id, sum(price) sum_price
from sales 
group by store_id
	)
	
select * from store_pr
where sum_price > (
	select avg(sum_price)
	from store_pr
)

-- Note: I think u shouldn't use OVER here. Simply u want to aggregate the data (reduce the number of rows) instead of calculating something for all
--  rows present. 



-- CLAUSES WHERE SUBQUERY CAN BE USED
--------------------------------------------------------------------------------
/* < Using Subquery in WHERE clause > */
/* QUESTION:  Find the employees who earn more than the average salary earned by all employees. */
select *
from employee e
where salary > (select avg(salary) from employee)
order by e.salary;


--------------------------------------------------------------------------------
/* < Using Subquery in FROM clause > */
/* QUESTION: Find stores who's sales where better than the average sales accross all stores */
-- Using WITH clause
with sales as
	(select store_name, sum(price) as total_sales
	 from sales
	 group by store_name)
select *
from sales
join (select avg(total_sales) as avg_sales from sales) avg_sales
	on sales.total_sales > avg_sales.avg_sales;


--------------------------------------------------------------------------------
/* < USING SUBQUERY IN SELECT CLAUSE > */
-- Only subqueries which return 1 row and 1 column is allowed (scalar or correlated)
/* QUESTION: Fetch all employee details and add remarks to those employees who earn more than the average pay. */
select e.*
, case when e.salary > (select avg(salary) from employee)
			then 'Above average Salary'
	   else null
  end remarks
from employee e;

-- Alternative approach
select e.*
, case when e.salary > avg_sal.sal
			then 'Above average Salary'
	   else null
  end remarks
from employee e
cross join (select avg(salary) sal from employee) avg_sal;



--------------------------------------------------------------------------------
/* < Using Subquery in HAVING clause > */
/* QUESTION: Find the stores who have sold more units than the average units sold by all stores. */
select store_name, sum(quantity) Items_sold
from sales
group by store_name
having sum(quantity) > (select avg(quantity) from sales);




-- SQL COMMANDS WHICH ALLOW A SUBQUERY
--------------------------------------------------------------------------------
/* < Using Subquery with INSERT statement > */
/* QUESTION: Insert data to employee history table. Make sure not insert duplicate records. */
insert into employee_history
select e.emp_id, e.emp_name, d.dept_name, e.salary, d.location
from employee e
join department d on d.dept_name = e.dept_name
where not exists (select 1
				  from employee_history eh
				  where eh.emp_id = e.emp_id);


--------------------------------------------------------------------------------
/* < Using Subquery with UPDATE statement > */
/* QUESTION: Give 10% increment to all employees in Bangalore location based on the maximum
salary earned by an emp in each dept. Only consider employees in employee_history table. */
update employee e
set salary = (select max(salary) + (max(salary) * 0.1)
			  from employee_history eh
			  where eh.dept_name = e.dept_name)
where dept_name in (select dept_name
				   from department
				   where location = 'Bangalore')
and e.emp_id in (select emp_id from employee_history);


--------------------------------------------------------------------------------
/* < Using Subquery with DELETE statement > */
/* QUESTION: Delete all departments who do not have any employees. */
delete from department d1
where dept_name in (select dept_name from department d2
				    where not exists (select 1 from employee e
									  where e.dept_name = d2.dept_name));
