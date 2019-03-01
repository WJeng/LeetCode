/*** SQL: Easy: Second Highest Salary
****/

-- Solution 1: 
select max(Salary) as SecondHighestSalary
from Employee
where Salary < (select max(Salary) from Employee)

-- Solution 2: not necessarily the best when only 1 obs. or when tied
select min(Salary) as SecondHighestSalary
from (
	select top 2 Salary
	from Employee
	order by Salary desc
)

-- Solution 3: same issue when tied or only 1 obs.
select top 1 Salary as SecondHighestSalary
from (
	select top 2 Salary
	from Employee
	order by Salary desc
) as data
order by Salary asc

-- Solution 4: same issue when only 1 obs
select Salary as SecondHighestSalary
from (
	select Salary, dense_rank() over (order by Salary desc) as Rnk
	from Employee
) as data
where Rnk = 2

/*** SQL: Medium: Nth Highest Salary
***/
CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    RETURN (
        /* Write your T-SQL query statement below. */
        SELECT DISTINCT Salary
        FROM (
            SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS SALARY_RANK
            FROM Employee
        ) AS DATA
        WHERE SALARY_RANK = @N
    );
END