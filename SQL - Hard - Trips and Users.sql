/*** Leetcode: Database: Hard: Trips and Users 
***/

create table ##Trips
(
	Id int identity(1, 1),
	Client_Id int,
	Driver_Id int,
	City_Id int, 
	Status varchar(50),
	Request_at date
)

insert into ##Trips
values 
	(1, 10, 1,  'completed',           '2013-10-01'),
	(2, 11, 1,  'cancelled_by_driver', '2013-10-01'),
	(3, 12, 6,  'completed',           '2013-10-01'),
	(4, 13, 6,  'cancelled_by_driver', '2013-10-01'),
	(1, 10, 1,  'completed',           '2013-10-02'),
	(2, 11, 6,  'completed',           '2013-10-02'),
	(3, 12, 6,  'completed',           '2013-10-02'),
	(2, 12, 12, 'completed',           '2013-10-03'),
	(3, 10, 12, 'completed',           '2013-10-03'),
	(4, 13, 12, 'cancelled_by_driver', '2013-10-03')

create table ##Users
(
	Users_Id int,
	Banned varchar(50),
	Role varchar(50)
)

insert into ##Users
values 
	(1,  'No',  'client'),
	(2,  'Yes', 'client'),
	(3,  'No',  'client'),
	(4,  'No',  'client'),
	(11, 'No',  'driver'),
	(12, 'No',  'driver'),
	(12, 'No',  'driver'),
	(13, 'No',  'driver')

select 
	trips.Request_at as Day, 
	round(sum(case when trips.status like '%cancelled%' then 1.0 else 0.0 end) / count(1), 2) as [Cancellation Rate]
from ##Trips as trips
join ##Users as users on trips.client_id = users.users_id
where users.Banned = 'No'
  and trips.Request_at between '2013-10-01' and '2013-10-03'
group by trips.Request_at
order by trips.Request_at

drop table ##Trips
drop table ##Users