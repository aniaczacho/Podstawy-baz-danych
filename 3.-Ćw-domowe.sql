use northwind

--1.1
SELECT Orders.OrderID, SUM(Quantity) AS 'Laczna liczba zamowionych jednostek'
FROM Orders
INNER JOIN [Order Details] OD on Orders.OrderID = OD.OrderID
GROUP BY Orders.OrderID;

--1.2
SELECT Orders.OrderID, SUM(Quantity) AS 'llzj'
FROM Orders
INNER JOIN [Order Details] OD on Orders.OrderID = OD.OrderID
GROUP BY Orders.OrderID
HAVING SUM(Quantity) > 250;

--1.3
SELECT Orders.OrderID, SUM(UnitPrice*Quantity*(1-Discount)) AS 'Wartosc',
C.CompanyName
FROM Orders
INNER JOIN [Order Details] [O D] on Orders.OrderID = [O D].OrderID
INNER JOIN Customers C on Orders.CustomerID = C.CustomerID
GROUP BY Orders.OrderID, C.CompanyName
ORDER BY Orders.OrderID;

--1.4
SELECT Orders.OrderID, SUM(UnitPrice*Quantity*(1-Discount)) AS 'Wartosc',
C.CompanyName
FROM Orders
INNER JOIN [Order Details] [O D] on Orders.OrderID = [O D].OrderID
INNER JOIN Customers C on Orders.CustomerID = C.CustomerID
GROUP BY Orders.OrderID, C.CompanyName
HAVING SUM(Quantity) > 250
ORDER BY Orders.OrderID;

--1.5
SELECT Orders.OrderID, SUM(UnitPrice*Quantity*(1-Discount)) AS 'Wartosc',
C.CompanyName, E.FirstName + ' ' + E.LastName AS 'Pracownik'
FROM Orders
INNER JOIN [Order Details] [O D] on Orders.OrderID = [O D].OrderID
INNER JOIN Customers C on Orders.CustomerID = C.CustomerID
INNER JOIN Employees E ON E.EmployeeID = Orders.EmployeeID
GROUP BY Orders.OrderID, C.CompanyName, E.FirstName + ' ' + E.LastName
HAVING SUM(Quantity) > 250
ORDER BY Orders.OrderID;

--2.1
SELECT CategoryName, SUM(Quantity) AS 'llzj'
FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = Products.ProductID
GROUP BY CategoryName;

--2.2
SELECT CategoryName, SUM(OD.UnitPrice*Quantity*(1-Discount)) AS 'lwz'
FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = Products.ProductID
GROUP BY CategoryName;

--2.3
SELECT CategoryName, SUM(OD.UnitPrice*Quantity*(1-Discount)) AS 'lwz'
FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = Products.ProductID
GROUP BY CategoryName
ORDER BY lwz DESC;

SELECT CategoryName, SUM(OD.UnitPrice*Quantity*(1-Discount)) AS 'lwz',
SUM(Quantity) AS 'llzj'
FROM Categories
INNER JOIN Products
ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = Products.ProductID
GROUP BY CategoryName
ORDER BY llzj;

--2.4


--3.1
SELECT CompanyName, COUNT(OrderID) AS 'amount of orders'
FROM Shippers
INNER JOIN Orders
ON Orders.ShipVia = Shippers.ShipperID
WHERE year(Orders.ShippedDate) = 1997
GROUP BY CompanyName;

--3.2
SELECT TOP 1 CompanyName, COUNT(OrderID) AS 'amount of orders'
FROM Shippers
INNER JOIN Orders
ON Orders.ShipVia = Shippers.ShipperID
WHERE year(Orders.ShippedDate) = 1997
GROUP BY CompanyName
ORDER BY [amount of orders] DESC;

--3.3
SELECT FirstName + '' + LastName, SUM(OD.UnitPrice*Quantity*(1-Discount))
FROM Employees
INNER JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN [Order Details] AS OD
ON OD.OrderID = Orders.OrderID
GROUP BY FirstName + '' + LastName;

--3.4
select top 1 firstname, lastname from employees e
inner join orders o on o.EmployeeID=e.EmployeeID and year(o.ShippedDate)=1997
group by e.EmployeeID, firstname, lastname order by count(o.orderid) desc

--3.5
SELECT TOP 1 FirstName + '' + LastName,
SUM(OD.UnitPrice*Quantity*(1-Discount)) AS 'lwz'
FROM Employees
INNER JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN [Order Details] AS OD
ON OD.OrderID = Orders.OrderID
WHERE year(Orders.ShippedDate) = 1997
GROUP BY FirstName + '' + LastName
ORDER BY lwz DESC;

--4.1
SELECT A.FirstName + '' + A.LastName AS 'name',
SUM(OD.UnitPrice*Quantity*(1-Discount))
FROM Employees AS A
INNER JOIN Employees AS B
ON A.EmployeeID = B.ReportsTo
INNER JOIN Orders
ON Orders.EmployeeID = A.EmployeeID
INNER JOIN [Order Details] AS OD
ON OD.OrderID = Orders.OrderID
GROUP BY A.FirstName + '' + A.LastName;

SELECT A.FirstName + '' + A.LastName AS 'name',
SUM(OD.UnitPrice*Quantity*(1-Discount))
FROM Employees AS A
LEFT JOIN Employees AS B
ON A.EmployeeID = B.ReportsTo
INNER JOIN Orders
ON Orders.EmployeeID = A.EmployeeID
INNER JOIN [Order Details] AS OD
ON OD.OrderID = Orders.OrderID
WHERE B.ReportsTo IS NULL
GROUP BY A.FirstName + '' + A.LastName;

