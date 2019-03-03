
;with over100 as (
    select 
        *, 
        case when people >= 100 then 1 else 0 end as flag
    from stadium
),

nums_grp as (
    select min(id) as min_id, max(id) as max_id, count(1) as ConsecutiveNums
    from (
        select 
            id, 
            flag, 
            row_number() over (order by id) - row_number() over (partition by flag order by id) as grp
        from over100
    ) as t
    group by grp, flag
    having count(*) >= 3
)

select s.*
from stadium as s
join nums_grp as g on s.id between g.min_id and g.max_id