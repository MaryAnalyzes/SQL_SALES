
--ALL CUSTOMERS AND THEIR ORDERS
SELECT C.CustomerName, O.OrderID FROM Customers$ C
JOIN Orders$ AS O ON C.CustomerID=O.CustomerID

--TOTAL REVENUE PER CUSTOMER
SELECT C.CustomerName, sum(OrderTotal) as revenue FROM Customers$ C
JOIN Orders$ AS O ON C.CustomerID=O.CustomerID
group by CustomerName  
  
 
--THE MOST POPULAR PRODUCT
SELECT SUM(Quantity) AS QUA, C.CookieName FROM Order_Product$ Q
JOIN Product$ AS C ON Q.CookieID=C.CookieID
GROUP BY CookieName
ORDER BY QUA DESC
    

--PROFIT PER ORDER
SELECT ORDERID, (CostPerCookie*Quantity) AS COSTPERORDER, (RevenuePerCookie * Quantity) AS REVENUEPERORDER
FROM Order_Product$ AS O JOIN Product$ AS P ON O.CookieID=P.CookieID

--ALTER AND UPDATE
ALTER TABLE Order_Product$
add COSTPERORDER INT,REVENUEPERORDER INT, PROFIT INT

--UPDATE ORDERPRODUCT
UPDATE Order_Product$
SET COSTPERORDER = (CostPerCookie*Quantity) FROM Order_Product$ AS O JOIN Product$ AS P ON O.CookieID=P.CookieID

UPDATE Order_Product$
SET REVENUEPERORDER = (RevenuePerCookie * Quantity) FROM Order_Product$ AS O JOIN Product$ AS P ON O.CookieID=P.CookieID

UPDATE Order_Product$
SET PROFIT =  REVENUEPERORDER-COSTPERORDER 


SELECT OrderID, COSTPERORDER, REVENUEPERORDER, PROFIT FROM Order_Product$

SELECT CookieName, RevenuePerCookie-CostPerCookie AS PROFIT FROM Product$


--list customers with no orders
SELECT C.CustomerID, C.CustomerName, O.OrderID, O.OrderTotal
FROM Customers$ AS C  LEFT JOIN Orders$ AS O ON C.CustomerID=O.CustomerID
WHERE O.OrderTotal IS NULL


--customer details for large orders
select C.CustomerName , O.OrderTotal from Customers$ as C JOIN Orders$ AS O ON C.CustomerID=O.CustomerID
WHERE OrderTotal>500

--THE AVERAGE ORDER TOTAL PER CITY
SELECT C.City, AVG(OrderTotal) as Average FROM Customers$ AS C JOIN Orders$ AS O ON C.CustomerID=O.CustomerID
GROUP BY City


--THE MOST PROFITABLE CUSTOMER
SELECT C.CustomerID, C.CustomerName,SUM(PROFIT) AS TPROFIT FROM Customers$ AS C
JOIN Orders$ AS O ON  C.CustomerID=O.CustomerID
JOIN Order_Product$ AS P ON O.OrderID=P.OrderID
GROUP BY C.CustomerName, C.CustomerID
ORDER  BY TPROFIT DESC

SELECT * FROM Order_Product$


SELECT O.OrderID, O.Quantity, p.RevenuePerCookie , p.CostPerCookie, (Quantity*RevenuePerCookie) AS REVPERORDER, (Quantity*CostPerCookie) AS COSTPERORDER
FROM Order_Product$ AS O JOIN Product$ AS P ON O.CookieID=P.CookieID

select * from Product$
select * from Order_Product$;

--using cte (common table expression)
with profit as (
select op.CookieID, op.Quantity, op.OrderID,(p.RevenuePerCookie-p.CostPerCookie)as profitpercookie
from Order_Product$ op join Product$ p on op.CookieID=p.CookieID 
)

select pt.OrderID, pt.Quantity, (pt.profitpercookie*pt.Quantity) as profitperOrder
from profit as pt

select * from Order_Product$ as O left join Product$ as P on o.CookieID=p.CookieID;

--large order count >500 using cte
with largeordercount as (
select CustomerID, OrderTotal from Orders$
where OrderTotal>500
)

SELECT * FROM largeordercount

--LARGE ORDER COUNT >500
SELECT COUNT(*) OrderTotal FROM Orders$
WHERE OrderTotal>500  

