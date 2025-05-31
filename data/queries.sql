SELECT name FROM sqlite_master WHERE type='table';

SELECT * FROM deliveries;

-- Avg delivery time for each area (urban, semi-urban, metropolitan)

SELECT City, AVG(Time_taken) AS avg_time
FROM deliveries
GROUP BY City
ORDER BY avg_time DESC;

-- How much traffic affects deliveries 

SELECT Road_traffic_density, AVG(Time_taken) AS avg_time
FROM deliveries
GROUP BY Road_traffic_density
ORDER BY avg_time DESC;

-- Does it matter what vehicle is being used ?

SELECT Type_of_vehicle, AVG(Time_taken) AS avg_time
FROM deliveries
GROUP BY Type_of_vehicle
ORDER BY avg_time;

-- Multiple deliveries vs single deliveries

SELECT multiple_deliveries, COUNT(*) AS num_orders, AVG(Time_taken) AS avg_time
FROM deliveries
GROUP BY multiple_deliveries;

-- Top 5 delivery guys/girls

SELECT Delivery_person_ID, AVG(Time_taken) AS avg_time
FROM deliveries
GROUP BY Delivery_person_ID
ORDER BY avg_time
LIMIT 5;

-- Creating new view with time interval

CREATE VIEW deliveries_with_interval AS
SELECT 
  *,
  CASE 
    WHEN Hour_order BETWEEN 0 AND 5 THEN 'Night'
    WHEN Hour_order BETWEEN 6 AND 11 THEN 'Morning'
    WHEN Hour_order BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN Hour_order BETWEEN 18 AND 23 THEN 'Evening'
    ELSE 'Unknown'
  END AS time_interval
FROM deliveries;

-- Seeing when is best to place an order

SELECT 
  time_interval,
  COUNT(*) AS num_orders,
  ROUND(AVG(Time_taken), 2) AS avg_time_taken
FROM deliveries_with_interval
GROUP BY time_interval
ORDER BY avg_time_taken DESC;