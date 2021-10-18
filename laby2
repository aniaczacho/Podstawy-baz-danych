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
