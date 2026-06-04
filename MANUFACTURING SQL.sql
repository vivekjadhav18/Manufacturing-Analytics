CREATE DATABASE MANUFACTURING ;
USE MANUFACTURING ;

DESCRIBE `manufacturing data`;

SELECT `Doc Date`
FROM `manufacturing data`
LIMIT 10;


-- Total Manufacture Qty (Year Filtered)
SELECT CONCAT(
ROUND(SUM(`Produced Qty`) / 1000000,2), 'M' )AS Manufacture_Qty
FROM `manufacturing data`
WHERE LEFT(`Doc Date`,10)
BETWEEN '2015-01-01' AND '2015-12-31';




-- Total Rejected Qty
SELECT CONCAT(
	ROUND(SUM(`Rejected Qty`) / 1000,2) ,'K')AS Rejected_Qty
	FROM `manufacturing data`
	WHERE LEFT(`Doc Date`,10)
	BETWEEN '2015-01-01' AND '2015-12-31';




-- Total Processed Qty
SELECT CONCAT(
	ROUND(SUM(`Processed Qty`) /1000000,2), 'M')  AS Processed_Qty
	FROM `manufacturing data`
	WHERE LEFT(`Doc Date`,10)
	BETWEEN '2015-01-01' AND '2015-12-31';




-- Wastage Qty
SELECT CONCAT(
	ROUND((SUM(`Produced Qty`) - SUM(`Processed Qty`))/1000,2),'K') AS Wastage_Qty
	FROM `manufacturing data`
	WHERE LEFT(`Doc Date`,10)
	BETWEEN '2015-01-01' AND '2015-12-31';




SELECT 
CONCAT(
    ROUND((SUM(`WO Qty`) - SUM(`Produced Qty`)) / 1000000, 2),'K') AS Total_Wastage
	FROM `manufacturing data`
	WHERE LEFT(`Doc Date`,10)	
	BETWEEN '2015-01-01' AND '2015-12-31';






-- Rejection Percentage
SELECT 
	CONCAT(ROUND(
    (SUM(`Rejected Qty`) / SUM(`Produced Qty`)) * 100, 2),'%') AS Rejection_Percentage
	FROM `manufacturing data`
	WHERE LEFT(`Doc Date`,10)
	BETWEEN '2015-01-01' AND '2015-12-31';





-- Employee Wise Rejected Qty
SELECT 
	`Emp Name`,
	CONCAT(ROUND(SUM(`Rejected Qty`)/1000,2),'K') AS Total_Rejected
	FROM `manufacturing data`
	GROUP BY `Emp Name`
	ORDER BY Total_Rejected DESC;




-- Machine Wise Rejected Qty
SELECT 
`Machine Code`,
CONCAT(ROUND(SUM(`Rejected Qty`)/1000,2),'K') AS Total_Rejected
FROM `manufacturing data`
GROUP BY `Machine Code`
ORDER BY SUM(`Rejected Qty`) DESC;




-- Manufacture Vs Rejected (Total)
SELECT 
CONCAT(ROUND(SUM(`Produced Qty`)/1000000,2),'M') AS Manufacture_Qty,
CONCAT(ROUND(SUM(`Rejected Qty`)/1000,2),'K') AS Rejected_Qty
FROM `manufacturing data`;



-- Manufacture Vs Rejected + Rejection %
SELECT 
CONCAT(ROUND(SUM(`Produced Qty`)/1000000,2),'M') AS Manufacture_Qty,
CONCAT(ROUND(SUM(`Rejected Qty`)/1000,2),'K') AS Rejected_Qty,
CONCAT(ROUND(
    (SUM(`Rejected Qty`) / SUM(`Produced Qty`)) * 100, 2),'%' ) AS Rejection_Percentage
FROM `manufacturing data`;





-- Year-wise Filtered Comparison
SELECT 
CONCAT(ROUND(SUM(`Produced Qty`) / 1000000,2 ),'M')AS Manufacture_Qty,
CONCAT(ROUND(SUM(`Rejected Qty`) / 1000,2 ),'K')AS Rejected_Qty,
CONCAT(ROUND(
    (SUM(`Rejected Qty`) / SUM(`Produced Qty`)) * 100, 2),'%') AS Rejection_Percentage
FROM `manufacturing data`
WHERE LEFT(`Doc Date`,10)
BETWEEN '2015-01-01' AND '2015-12-31';





-- Department Wise Manufacture vs Rejected
SELECT 
`Department Name`,
CONCAT(ROUND(SUM(`Produced Qty`)/1000000,2),'M') AS Manufacture_Qty,
CONCAT(ROUND(SUM(`Rejected Qty`) / 1000,2),'K') AS Rejected_Qty,
CONCAT(ROUND((SUM(`Rejected Qty`) / SUM(`Produced Qty`)) * 100,2),'%') AS Rejection_Percentage
FROM `manufacturing data`
GROUP BY `Department Name`
ORDER BY Manufacture_Qty DESC;





-- Monthly Production Trend
SELECT 
DATE_FORMAT(LEFT(`Doc Date`,10), '%Y-%m') AS Month,
CONCAT(ROUND(SUM(`Produced Qty`)/1000000,2),'M') AS Total_Produced
FROM `manufacturing data`
GROUP BY Month
ORDER BY Month;


--