 

--Each customer's revenue
select c.CustomerID, sum(TotalAmount) as revenuepercustomer from Customers as c
join Orders$ as o on c.CustomerID=o.CustomerID
group by c.CustomerID;

--Total Revenue 
select sum(TotalAmount) as TotalRevenue from Orders$;

--Customer with the highest order
select Top 1 concat(FirstName,'',LastName) as FullName,c.CustomerID, sum(TotalAmount) as revenuepercustomer from Customers as c
join Orders$ as o on c.CustomerID=o.CustomerID
group by c.CustomerID,concat(FirstName,'',LastName)
order by revenuepercustomer desc;

--Product with the highest order and its category
select Top 1 o.ProductID,sum(TotalPrice) as Totalorder,p.ProductName,p.Category from OrderDetails$ 
as o join Products as p on o.ProductID=p.ProductID
group by o.ProductID,p.ProductName,p.Category
order by Totalorder desc;

--Orders with totalamount >1000 and year date=2023
select * from Orders$
where TotalAmount>1000
and YEAR(OrderDate)=2023;


-- Avgprice by category
select Category, AVG(price) as avgprice from Products
group by Category;


--Orders by orderdate desc
SELECT * FROM Orders$
ORDER BY OrderDate DESC;
 

--category with avg price greater than 500   
SELECT Category, avg (price) as avgprice FROM Products
group by Category
Having AVG(Price) > 500;

--Top 10 category by revenue
select top 10 Category, Price*StockQuantity as revenue from Products
 order  by Revenue desc;


--create a new from existing table

--create a table with category below 500 avgprice

select Category, avg(price) as avgprice 
into product_Categorybelow500 from Products
group by Category
having AVG(price) <500;


--create a table with category above 500 avgprice

select Category, avg(price) as avgprice 
into product_Categoryabove500 from Products
group by Category
having AVG(price) >500;


--union the 2 table
select Category, avgprice from product_Categoryabove500

union

select Category, avgprice from product_Categorybelow500;


-- CREATE A TABLE FOR TOP10 REVENUE DESC

select top 10 Category, price*StockQuantity as revenue 
into RevenueT from Products
ORDER BY revenue DESC;

--CREATE A TABLE FOR TOP10 REVENUE ASC
select top 10 Category, price*StockQuantity as revenue 
into RevenueA from Products
ORDER BY revenue ASC;


--UNION THE 2 REVENUE TABLE

SELECT Category, revenue  FROM RevenueA

UNION

SELECT Category, revenue FROM RevenueT;




