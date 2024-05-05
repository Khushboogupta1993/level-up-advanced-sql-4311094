select e.employeeId,e.firstName,e.lastName ,
sum(case when strftime('%m',s.soldDate) = '01'
then s.salesAmount end) 
as JanSales,
sum(case when strftime('%m',s.soldDate) = '02'
then s.salesAmount end )
as FebSales,
sum(case when strftime('%m',s.soldDate) = '03'
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


select s.salesId,s.salesAmount,s.soldDate 
,m.EngineType
from sales s 
join inventory i 
on s.inventoryId=i.inventoryId
join model m 
on i.modelId=m.modelid and m.EngineType='Electric'


select E.EMPLOYEEID,E.FIRSTNAME,E.LASTNAME,
M.model, COUNT(M.MODEL) SALESCOUNT,
DENSE_RANK() OVER (PARTITION BY E.employeeId
ORDER BY COUNT(M.model) DESC ) AS RANK
from sales s
join employee e 
on s.employeeId=e.employeeID 
join inventory i 
on s.inventoryId=i.inventoryId
join model m 
on i.modelId=m.modelid
GROUP BY E.EMPLOYEEID,E.FIRSTNAME,E.LASTNAME,
M.model
ORDER BY E.employeeId, RANK 


SELECT STRFTIME('%Y',soldDate),
STRFTIME('%m',soldDate),
sum(salesAmount),
sum(sum(salesAmount)) over (PARTITION by STRFTIME('%Y',soldDate)
order by STRFTIME('%Y',soldDate),
STRFTIME('%m',soldDate)) annualrun FROM SALES
group by STRFTIME('%Y',soldDate),
STRFTIME('%m',soldDate)
order by STRFTIME('%Y',soldDate),
STRFTIME('%m',soldDate);


select strftime('%Y-%m', solddate) ,
count(*) as numberofcarssold,
lag(count(*),1,0) over (order by strftime('%Y-%m', solddate) ) previous 
from sales
group by strftime('%Y-%m', solddate)
order by strftime('%Y-%m', solddate)