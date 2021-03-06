use northwind
--1.1
select productname, unitprice, Address from products inner join suppliers on suppliers.supplierID=products.SupplierID
where unitprice between 20 and 30

--1.2
select productname, unitsinstock from products
inner join suppliers on suppliers.SupplierID=products.SupplierID
where companyname='Tokyo Traders'

--1.3
select customers.customerid, Address from customers
left join Orders on customers.CustomerID=orders.CustomerID and year(orderdate)=1997 where orderid is null 

--1.4
select companyname, phone from Suppliers
inner join products on products.SupplierID=Suppliers.SupplierID
where isnull(unitsinstock,0)=0



use library
--2.1
select firstname, lastname, birth_date from juvenile 
inner join member on member.member_no=juvenile.member_no

--2.2
select distinct title from title inner join loan on loan.title_no=title.title_no

--2.3
select title, due_date, fine_paid, datediff(day, in_date,due_date) from loanhist 
inner join title on title.title_no=loanhist.title_no 
where title like 'Tao Teh King' and fine_paid is not null

--2.4
select isbn, lastname from reservation 
inner join member on member.member_no=reservation.member_no
where firstname='Stephen' and lastname='Graff' and middleinitial='A'



use northwind
--3.1
select productname, unitprice, address from products
inner join suppliers s on s.supplierid =products.SupplierID
inner join Categories c on c.CategoryID=products.CategoryID
where unitprice between 20 and 30 and categoryname like 'Meat/Poultry'

--3.2
select productname, unitprice, CompanyName from products
inner join suppliers s on s.supplierid =products.SupplierID
inner join Categories c on c.CategoryID=products.CategoryID
where categoryname like 'Confections'

--3.3
select distinct customers.CompanyName, customers.Phone from Customers
inner join orders o on o.CustomerID=customers.CustomerID and year(shippeddate)=1997
inner join shippers s on s.ShipperID=o.ShipVia and s.CompanyName='United Package'

--3.4
select distinct c.CompanyName, c.Phone from Customers c
inner join orders o on o.CustomerID=c.CustomerID
inner join [Order Details] oo on oo.OrderID=o.OrderID
inner join products p on p.ProductID=oo.ProductID
inner join categories cc on cc.CategoryID=p.CategoryID and categoryname='Confections'



use library
--4.1
select m.firstname,m.lastname,j.birth_date,a.street+' '+a.city+ ' '+a.state as Address from member as m
inner join juvenile j on j.member_no=m.member_no
inner join adult a on a.member_no=j.adult_member_no

--4.2
select m.firstname,m.lastname,j.birth_date,a.street+' '+a.city+ ' '+a.state as Address, ma.firstname, ma.lastname  from member as m
inner join juvenile j on j.member_no=m.member_no
inner join adult a on a.member_no=j.adult_member_no
inner join member ma on ma.member_no=a.member_no



use northwind
--5.1
select e.firstname+' '+e.lastname, ee.firstname+' '+ee.lastname from employees as e
inner join employees as ee on ee.reportsto=e.EmployeeID
group by e.firstname+' '+e.lastname, ee.firstname+' '+ee.lastname with rollup 
having e.firstname+' '+e.lastname is not null and ee.firstname+' '+ee.lastname is not null

--5.2
select e.firstname+' '+e.lastname from employees as e
left join employees as ee on ee.reportsto=e.EmployeeID
group by e.firstname+' '+e.lastname having count(ee.employeeid)=0

use library
--5.3
select distinct a.member_no, a.street+' '+a.city+ ' '+a.state as Address from adult as a
inner join juvenile j on j.adult_member_no=a.member_no and j.birth_date < '1996/01/01'

--5.4
select distinct a.member_no, a.street+' '+a.city+ ' '+a.state as Address from adult as a
inner join juvenile j on j.adult_member_no=a.member_no and j.birth_date < '1996/01/01'
left join loan l on l.member_no=a.member_no group by a.member_no, a.street+' '+a.city+ ' '+a.state having count(l.isbn)=0



--5.1
select firstname, lastname,  a.street+' '+a.city+ ' '+a.state+' ' +a.zip from member as m
inner join adult as a on a.member_no=m.member_no

--5.2

--5.3
select m.member_no, firstname, lastname, r.isbn, r.log_date from member m
left join reservation r on r.member_no=m.member_no
where m.member_no=250 or m.member_no=342 or m.member_no=1675
group by m.member_no, firstname, lastname, r.isbn, r.log_date

--5.4
select m.member_no, m.firstname+m.lastname from member m
inner join adult a on a.member_no=m.member_no and a.state='AZ'
left join juvenile j on j.adult_member_no=a.member_no
group by m.member_no, m.firstname+m.lastname having count(j.adult_member_no)>2

--6.1
select m.member_no, m.firstname+m.lastname from member m
inner join adult a on a.member_no=m.member_no and a.state='AZ'
left join juvenile j on j.adult_member_no=a.member_no
group by m.member_no, m.firstname+m.lastname having count(j.adult_member_no)>2
UNION
select m.member_no, m.firstname+m.lastname from member m
inner join adult a on a.member_no=m.member_no and a.state='CA'
left join juvenile j on j.adult_member_no=a.member_no
group by m.member_no, m.firstname+m.lastname having count(j.adult_member_no)>3











use northwind
--5.1
select categoryname, companyname,  sum(quantity) as 'Quantity' from categories c
inner join products p on p.CategoryID=c.CategoryID
inner join [Order Details] oo on oo.ProductID=p.ProductID
inner join Orders o on o.OrderID=oo.OrderID
inner join customers cc on cc.CustomerID=o.CustomerID
group by categoryname, companyname

--5.2
select oo.OrderID, companyname, sum(quantity) as Quantity from [Order Details] oo
inner join Orders o on o.OrderID=oo.OrderID
inner join Customers c on c.CustomerID=o.CustomerID
group by oo.OrderID, c.CustomerID, companyname order by oo.OrderID

--5.3
select oo.OrderID, companyname, sum(quantity) as Quantity from [Order Details] oo
inner join Orders o on o.OrderID=oo.OrderID
inner join Customers c on c.CustomerID=o.CustomerID
group by oo.OrderID, c.CustomerID, companyname
having sum(quantity)>250
 order by oo.OrderID

--5.4
select distinct companyname, productname from customers c
inner join orders o on o.CustomerID=c.CustomerID
inner join [Order Details] oo on oo.OrderID=o.OrderID
inner join Products p on p.ProductID=oo.ProductID

--5.5
select distinct companyname, o.orderid, sum(quantity*unitprice*(1-discount)) as 'Order value' from customers c
left join orders o on o.CustomerID=c.CustomerID
left join [Order Details] oo on oo.OrderID=o.OrderID
group by companyname, o.orderid

use library
--5.6
select firstname, lastname from member m
left join loan l on l.member_no=m.member_no
left join loanhist lh on lh.member_no=m.member_no
group by m.member_no, firstname, lastname
having count(l.member_no)=0 and count(lh.member_no)=0
