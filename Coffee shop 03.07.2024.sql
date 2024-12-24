create	database coffee_Shop_sales_db;

use coffee_shop_sales_db;

SELECT concat(round(sum(transaction_qty * unit_price ))/1000, "K") as Total_Sales_July
from coffee_shop_sales
where month(Transactio_Date_New) = 10 ;

alter table coffee_shop_sales rename column  Transactio_Date_New  to Transaction_Date_New;

SELECT 
    MONTH(Transaction_Date_New) AS month,
    ROUND(SUM(unit_price * transaction_qty)) AS total_sales,
    (SUM(unit_price * transaction_qty) - LAG(SUM(unit_price * transaction_qty), 1)
    OVER (ORDER BY MONTH(Transaction_Date_New))) / LAG(SUM(unit_price * transaction_qty), 1) 
    OVER (ORDER BY MONTH(Transaction_Date_New)) * 100 AS mom_increase_percentage
FROM 
    coffee_shop_sales
WHERE 
    MONTH(Transaction_Date_New) IN (4, 5) 
GROUP BY 
    MONTH(Transaction_Date_New)
ORDER BY 
    MONTH(Transaction_Date_New	);
    
SELECT COUNT(transaction_id) as Total_Orders_July
FROM coffee_shop_sales 
WHERE MONTH (Transaction_Date_New)= 7 ;

SELECT 
    MONTH(Transaction_Date_New) AS month,
    ROUND(COUNT(transaction_id)) AS total_orders,
    (COUNT(transaction_id) - LAG(COUNT(transaction_id), 1) 
    OVER (ORDER BY MONTH(Transaction_Date_New))) / LAG(COUNT(transaction_id), 1) 
    OVER (ORDER BY MONTH(Transaction_Date_New)) * 100 AS mom_increase_percentage
FROM 
    coffee_shop_sales
WHERE 
    MONTH(Transaction_Date_New) IN (3, 4)
GROUP BY 
    MONTH(Transaction_Date_New)
ORDER BY 
    MONTH(Transaction_Date_New);
    
SELECT
    CONCAT(ROUND(SUM(unit_price * transaction_qty) / 1000, 1),'K') AS total_sales,
        CONCAT(ROUND(COUNT(transaction_id) / 1000, 1),'K') AS total_quantity_sold,
    CONCAT(ROUND(SUM(transaction_qty) / 1000, 1),'K') AS total_orders
FROM 
    coffee_shop_sales
WHERE 
    Transaction_Date_New = '2023-05-18'; 

SELECT round(AVG(total_sales),2) AS average_sales
FROM (
    SELECT 
        SUM(unit_price * transaction_qty) AS total_sales
    FROM 
        coffee_shop_sales
	WHERE 
        MONTH(Transaction_Date_New) = 4 
    GROUP BY 
        Transaction_Date_New
) AS internal_query;

SELECT 
    DAY(Transaction_Date_New) AS day_of_month,
    ROUND(SUM(unit_price * transaction_qty),1) AS total_sales
FROM 
	    coffee_shop_sales
WHERE 
    MONTH(Transaction_Date_New) = 6
GROUP BY 
    DAY(Transaction_Date_New)
ORDER BY 
    DAY(Transaction_Date_New);

SELECT 
    day_of_month,
    CASE 
        WHEN total_sales > avg_sales THEN 'Above Average'
        WHEN total_sales < avg_sales THEN 'Below Average'
        ELSE 'Average'
    END AS sales_status,
    total_sales
FROM (
    SELECT 
        DAY(Transaction_Date_New) AS day_of_month,
        round(SUM(unit_price * transaction_qty),2) AS total_sales,
        AVG(SUM(unit_price * transaction_qty)) OVER () AS avg_sales
    FROM 
        coffee_shop_sales
    WHERE 
        MONTH(Transaction_Date_New) = 6  -- Filter for May
    GROUP BY 
        DAY(Transaction_Date_New)
) AS sales_data
ORDER BY 
    day_of_month;

SELECT 
    CASE 
        WHEN DAYOFWEEK(Transaction_Date_New) IN (1, 7) THEN 'Weekends'
        ELSE 'Weekdays'
    END AS day_type,
    ROUND(SUM(unit_price * transaction_qty),2) AS total_sales
FROM 
    coffee_shop_sales
WHERE 
    MONTH(Transaction_Date_New) = 6 
GROUP BY 
    CASE 
        WHEN DAYOFWEEK(Transaction_Date_New) IN (1, 7) THEN 'Weekends'
        ELSE 'Weekdays'
    END;

select *
from coffee_shop_sales;    
   
   SELECT 
	store_location,
	round(SUM(unit_price * transaction_qty),2) as Total_Sales
FROM coffee_shop_sales
WHERE
	MONTH(Transaction_Date_New) =5 
GROUP BY store_location
ORDER BY 	SUM(unit_price * transaction_qty) DESC;

SELECT 
	product_category,
	ROUND(SUM(unit_price * transaction_qty),1) as Total_Sales
FROM coffee_shop_sales
WHERE
	MONTH(Transaction_Date_New) = 5 
GROUP BY product_category
ORDER BY SUM(unit_price * transaction_qty) DESC;

SELECT 
	product_type,
	ROUND(SUM(unit_price * transaction_qty),1) as Total_Sales
FROM coffee_shop_sales
WHERE
	MONTH(Transaction_Date_New) = 5 
GROUP BY product_type
ORDER BY SUM(unit_price * transaction_qty) DESC
LIMIT 10;

SELECT 
	product_type,
	ROUND(SUM(unit_price * transaction_qty),1) as Total_Sales
FROM coffee_shop_sales
WHERE
	MONTH(Transaction_Date_New) = 5 
GROUP BY product_type
ORDER BY SUM(unit_price * transaction_qty) DESC
LIMIT 10;

SELECT 
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales,
    SUM(transaction_qty) AS Total_Quantity,
    COUNT(*) AS Total_Orders
FROM 
    coffee_shop_sales
WHERE 
    DAYOFWEEK(Transaction_Date_New) = 3 -- Filter for Tuesday 
    AND HOUR(Transactio_Time_New) = 8 -- Filter for hour number 8
    AND MONTH(Transaction_Date_New) = 5; ; -- Filter for May 
    
    SELECT 
    CASE 
        WHEN DAYOFWEEK(Transaction_Date_New) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(Transaction_Date_New) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(Transaction_Date_New) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(Transaction_Date_New) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(Transaction_Date_New) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(Transaction_Date_New) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END AS Day_of_Week,
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM 
    coffee_shop_sales
WHERE 
    MONTH(Transaction_Date_New) = 5 -- Filter for May
GROUP BY 
    CASE 
        WHEN DAYOFWEEK(Transaction_Date_New) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(Transaction_Date_New) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(Transaction_Date_New) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(Transaction_Date_New) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(Transaction_Date_New) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(Transaction_Date_New) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END;

SELECT 
    HOUR(Transactio_Time_New) AS Hour_of_Day,
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM 
    coffee_shop_sales
WHERE 
    MONTH(Transaction_Date_New) = 5 -- Filter for May (month number 5)
GROUP BY 
    HOUR(Transactio_Time_New)
ORDER BY 
    HOUR(Transactio_Time_New);
