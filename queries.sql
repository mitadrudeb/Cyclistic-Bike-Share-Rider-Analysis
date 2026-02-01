-- =====================================================
-- CYCLISTIC BIKE-SHARE ANALYSIS - SQL QUERIES
-- =====================================================
-- Purpose: Analyze member vs casual rider behavior
-- Database: cyclistic_db
-- Table: bike_trips
-- =====================================================

-- Query 1: Total rides by member type
-- Business Question: How many rides did each user type take?

SELECT 
    member_casual,
    COUNT(*) AS total_rides,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bike_trips), 2) AS percentage
FROM bike_trips
GROUP BY member_casual;


-- Query 2: Average ride duration by member type
-- Business Question: How long do different user types ride?

SELECT 
    member_casual,
    ROUND(AVG(ride_length), 2) AS avg_duration_minutes,
    ROUND(MIN(ride_length), 2) AS min_duration,
    ROUND(MAX(ride_length), 2) AS max_duration
FROM bike_trips
GROUP BY member_casual;


-- Query 3: Most popular days for each member type
-- Business Question: Which days are most popular for each user type?

SELECT 
    member_casual,
    CASE day_of_week
        WHEN 0 THEN 'Monday'
        WHEN 1 THEN 'Tuesday'
        WHEN 2 THEN 'Wednesday'
        WHEN 3 THEN 'Thursday'
        WHEN 4 THEN 'Friday'
        WHEN 5 THEN 'Saturday'
        WHEN 6 THEN 'Sunday'
    END AS day_name,
    COUNT(*) AS total_rides
FROM bike_trips
GROUP BY member_casual, day_of_week
ORDER BY member_casual, total_rides DESC;


-- Query 4: Peak hours for each member type
-- Business Question: When do different users ride the most?

SELECT 
    member_casual,
    hour,
    COUNT(*) AS total_rides
FROM bike_trips
GROUP BY member_casual, hour
ORDER BY member_casual, total_rides DESC;


-- Query 5: Monthly usage patterns
-- Business Question: How does usage vary by month?

SELECT 
    CASE month
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February'
        WHEN 3 THEN 'March'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'June'
        WHEN 7 THEN 'July'
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END AS month_name,
    member_casual,
    COUNT(*) AS total_rides
FROM bike_trips
GROUP BY month, member_casual
ORDER BY month, member_casual;


-- Query 6: Bike type preferences
-- Business Question: Which bike types do users prefer?

SELECT 
    member_casual,
    rideable_type,
    COUNT(*) AS total_rides,
    ROUND(AVG(ride_length), 2) AS avg_duration
FROM bike_trips
GROUP BY member_casual, rideable_type
ORDER BY member_casual, total_rides DESC;


-- Query 7: Weekday vs Weekend comparison
-- Business Question: Do usage patterns differ between weekdays and weekends?

SELECT 
    member_casual,
    CASE 
        WHEN day_of_week IN (5, 6) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS total_rides,
    ROUND(AVG(ride_length), 2) AS avg_duration
FROM bike_trips
GROUP BY member_casual, day_type
ORDER BY member_casual, day_type;


-- Query 8: Top 10 starting stations for casual riders
-- Business Question: Where do casual riders start their trips most often?

SELECT 
    start_station_name,
    COUNT(*) AS total_rides
FROM bike_trips
WHERE member_casual = 'casual'
    AND start_station_name IS NOT NULL
GROUP BY start_station_name
ORDER BY total_rides DESC
LIMIT 10;


-- Query 9: Top 10 starting stations for members
-- Business Question: Where do members start their trips most often?

SELECT 
    start_station_name,
    COUNT(*) AS total_rides
FROM bike_trips
WHERE member_casual = 'member'
    AND start_station_name IS NOT NULL
GROUP BY start_station_name
ORDER BY total_rides DESC
LIMIT 10;


-- Query 10: Summary statistics
-- Business Question: What are the overall usage statistics?

SELECT 
    COUNT(*) AS total_rides,
    ROUND(AVG(ride_length), 2) AS overall_avg_duration,
    COUNT(DISTINCT start_station_name) AS unique_start_stations,
    COUNT(DISTINCT rideable_type) AS bike_types
FROM bike_trips;