select employeeId,firstName,lastName,managerId from employee;
select e.firstName,e.lastName ,
m.firstName,m.lastName
from employee e
join employee m
on e.managerId=m.employeeId

select * from employee e
left join sales s
on e.employeeId=s.employeeId
where s.employeeId is null and e.title='Sales Person'


select distinct * from sales s
full outer join customer c
on s.customerId=c.customerId

select * from sales limit 5;
select * from inventory limit 5;
select * from model limit 5;
select e.employeeId,count(*) from sales s 
join employee e
on s.employeeId=e.employeeId
group by e.employeeId
order by count(*) desc


select date('now','start of year') from employee
select distinct substring(soldDate,1,4) from sales
select e.employeeId,e.firstName,e.lastName,s.soldDate
from employee e 
join sales s
on e.employeeId=s.employeeId
and s.soldDate >= '2023-01-01'
group by e.employeeId,e.firstName,e.lastName
having count(s.salesId)>5
order by count(s.salesId) desc

select substring(soldDate,1,4) saleyear , 
FORMAT("$%.2f",sum(salesAmount)) from sales
group by saleyear

select e.employeeId,e.firstName,e.lastName,salesAmount,soldDate
from employee e
join sales s on e.employeeId=s.employeeId
where s.soldDate>='2021-01-01' and s.soldDate<'2022-01-01'
order by e.employeeId,s.soldDate;

select e.employeeId,e.firstName,e.lastName ,
sum(case when strftime('%m',s.soldDate) = '01'
then s.salesAmount end) 
as JanSales,
sum(case when strftime('%m',s.soldDate) = '02'
then s.salesAmount end )
as FebSales,
(case when strftime('%m',s.soldDate) = '03'
then s.salesAmount end )
as MarSales,
sum(case when strftime('%m',s.soldDate) = '04'
then s.salesAmount end )
as AprSales,
sum(case when strftime('%m',s.soldDate) = '05'
then s.salesAmount end )
as MaySales,
sum(case when strftime('%m',s.soldDate) = '06'
then s.salesAmount end )
as JunSales,
sum(case when strftime('%m',s.soldDate) = '07'
then s.salesAmount end )
as JulySales,
sum(case when strftime('%m',s.soldDate) = '08'
then s.salesAmount end )
as AugSales,
sum(case when strftime('%m',s.soldDate) = '09'
then s.salesAmount end) 
as SepSales,
sum(case when strftime('%m',s.soldDate) = '10'
then s.salesAmount end )
as OctSales,
sum(case when strftime('%m',s.soldDate) = '11'
then s.salesAmount end )
as NovSales,
sum(case when strftime('%m',s.soldDate) = '12'
then s.salesAmount end) 
as DecSales
from employee e 
join sales s 
on e.employeeId=s.employeeId
where s.soldDate>='2021-01-01' and s.soldDate<'2022-01-01'
group by e.employeeId,e.firstName,e.lastName
order by e.employeeId;



select count(employeeId),count(distinct employeeId) 
from employee
