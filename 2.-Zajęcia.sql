select (unitprice * quantity) * (1 - discount) from [Order Details]
where orderid = 10250

select supplierid, convert(varchar, isnull(phone,0)) + ',' + convert(varchar, isnull(fax,0)) as 'contact' from suppliers 

select count(*) from products 
where unitprice between 10 and 20

select max(unitprice) from products 
where unitprice < 20

select max(unitprice), min(unitprice), avg(unitprice) from products 
where quantityperunit like '%bottle%'

select * from products 
where unitprice > (select avg(unitprice) from products)

select sum((unitprice * quantity) * (1 - discount))
from [Order Details] where orderid = 10250

select max(unitprice) from [order details] group by orderid order by max(unitprice)

select max(unitprice), min(unitprice) from [order details] group by orderid

use northwind

/*cw 1 z 2 grupowanie*/
select orderid, count(orderid) from [order details] group by orderid
having count(orderid) > 5

select customerid, count(customerid), sum(Freight) from orders
where year(shippeddate) = 1998
group by customerid having count(customerid) > 8
order by sum(freight) desc

select * from orderhist

select productid, orderid, sum(quantity) as total_quantity
from orderhist group by productid, orderid
with cube
order by productid, orderid

/*ile lat przepracowal w firmie kazy z pracownikow*/
select employeeid, datediff(year, hiredate, getdate()) from employees

/*najkrotsze imie pracownika*/
select min(len(firstname)) from employees

select employeeid, count(orderid), min(orderdate) from orders group by employeeid

select customerid, sum(freight) from orders where requireddate - shippeddate < 0 group by customerid

use library
select top 1 year(out_date), count(fine_assessed) from loanhist group by year(out_date) order by count(fine_assessed) desc

