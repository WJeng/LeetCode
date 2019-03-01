/*** Leetcode: Database: Hard: Top 3 Salary by Department 
***/

create table ##Department
(
	Id int identity(1, 1),
	Name varchar(50)
)

insert into ##Department
values 
	('IT'   ), 
	('Sales')

create table ##Employee
(
	Id int identity(1, 1),
	Name varchar(50),
	Salary int,
	DepartmentId int
)

insert into ##Employee
values 
	('Joe',   70000, 1), 
	('Henry', 80000, 2),
	('Sam',   60000, 2),
	('Max',   90000, 1),
	('Janet', 69000, 1),
	('Randy', 85000, 1)

-- Solution 1
select 
    depart.Name as Department,
    employ.Name as Employee,
    employ.Salary
from Employee as employ
join Department as depart on employ.DepartmentId = depart.Id
where 3 > (
    select count(distinct yee.Salary)
    from Employee as yee
    where yee.Salary > employ.Salary
      and yee.DepartmentId = employ.DepartmentId
)

-- Solution 2: similar perf. to sol. 1
select 
	Department, 
	Employee,
	Salary
from (
	select 
		depart.Name as Department, 
		employ.Name as Employee,
		employ.Salary, 
		dense_rank() over (partition by depart.Id order by employ.Salary desc) as Salary_Rank
	from ##Department as depart
	join ##Employee as employ on depart.Id = employ.DepartmentId
) as data
where Salary_Rank <= 3

drop table ##Department
drop table ##Employee