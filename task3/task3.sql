CREATE TABLE Sales (
 SaleDate DATE,
 ProductID INT,
 Price INT,
 Quantity INT 
)

DELETE FROM Sales

INSERT INTO Sales
--VALUES ('2012-06-10', 1, 10, 100)
--VALUES ('2012-06-27', 2, 30, 200)
--VALUES ('2012-06-29', 2, 30, 300)
--VALUES ('2012-06-30', 1, 10, 100)
--VALUES ('2012-07-15', 1, 20, 200)
--VALUES ('2012-07-16', 2, 20, 300)
--VALUES ('2012-08-01', 1, 15, 100)
VALUES ('2012-08-10', 2, 15, 200)

SELECT * FROM Sales

CREATE TABLE Percent (
 NewPercentDate DATE,
 ProductID INT,
 Rate NUMERIC(1,1) 
)

DELETE FROM Percent

INSERT INTO Percent
--VALUES ('2012-05-01', 1, 0.1)
--VALUES ('2012-05-01', 2, 0.2)
--VALUES ('2012-06-15', 1, 0.3)
--VALUES ('2012-06-27', 1, 0.2)
--VALUES ('2012-07-12', 1, 0.2)
VALUES ('2012-07-12', 2, 0.6)

SELECT * FROM Percent


--==== task 3.1 (ReportStart / ReportEnd)

SELECT 
 ProductID, 
 SUM(Profit) AS Profit
FROM ( 
 SELECT 
  s.SaleDate, 
  s.ProductID, 
  s.Price, 
  s.Quantity, 
  MAX(p.NewPercentDate) AS RateDate, 
  p.Rate, 
  s.Price*s.Quantity*p.Rate AS Profit
 FROM Sales s, Percent p 
 WHERE s.ProductID=p.ProductID
 AND s.SaleDate>=p.NewPercentDate
 GROUP BY 
  s.SaleDate, 
  s.ProductID, 
  s.Price, 
  s.Quantity
)
WHERE SaleDate>='2012-06-01' -- ReportStart
AND SaleDate<='2012-08-31' -- ReportEnd
GROUP BY ProductID 
 

--===== task 3.2 (Quantity per month)
  
SELECT
 strftime('%m', SaleDate) AS ByMonth, 
 ProductID, 
 SUM(Profit) AS Profit
FROM ( 
 SELECT 
  s.SaleDate, 
  s.ProductID, 
  s.Price, 
  s.Quantity, 
  MAX(p.NewPercentDate) AS RateDate, 
  p.Rate, 
  s.Price*s.Quantity*p.Rate AS Profit
 FROM Sales s, Percent p 
 WHERE s.ProductID=p.ProductID
 AND s.SaleDate>=p.NewPercentDate
 GROUP BY 
  s.SaleDate, 
  s.ProductID, 
  s.Price, 
  s.Quantity
)
GROUP BY strftime('%m', SaleDate), ProductID 
HAVING SUM(Quantity)=200 -- Quantity per month
