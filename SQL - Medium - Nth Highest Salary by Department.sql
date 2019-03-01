/*** Nth Highest Salary by Department
***/

-- Solution 1
select d.Department, e.Name as Employee, e.Salary
from Employee as e
join (
    select d.Id, d.Name as Department, max(e.Salary) as Salary
    from Employee as e
    join Department as d on e.DepartmentId = d.Id
    group by d.Id, d.Name
) as d on e.Salary = d.Salary and e.DepartmentId = d.Id

-- Solution 2: faster?
select Department, Employee, Salary
from (
    select 
        d.Name as Department, 
        e.Name as Employee,
        e.Salary,
        dense_rank() over (partition by e.DepartmentId order by e.Salary desc) as Salary_Rank
    from Employee as e
    join Department as d on e.DepartmentId = d.Id
) as data
where Salary_Rank = 1