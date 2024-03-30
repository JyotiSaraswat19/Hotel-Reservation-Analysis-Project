create database hotel_reservation;

use hotel_reservation;

select * FROM hotel_reservation;
select distinct * from hotel_reservation;

-- QUES) What is the total number of reservations in the dataset?


Select count(Booking_ID) AS total_number_of_reservations 
from hotel_reservation;


-- Ques) Which meal plan is the most popular among guests?


select type_of_meal_plan , count(type_of_meal_plan) as count
from hotel_reservation
group by type_of_meal_plan
order by count desc ;



-- the percentage of guests that preferred particular meal plan

SELECT 
    type_of_meal_plan,
    COUNT(*) AS plan_count,
    ((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM hotel_reservation)) AS percentage
FROM hotel_reservation
GROUP BY type_of_meal_plan
ORDER BY plan_count DESC;


-- Ques) What is the average price per room for reservations involving children?


SELECT AVG(avg_price_per_room) AS average_price_per_room_with_children
FROM hotel_reservation
WHERE no_of_children > 0;



-- Ques) How many reservations were made for the year 20XX (replace XX with the desired year)?

-- for 2017
SELECT count(arrival_date) AS count_2017
FROM hotel_reservation
WHERE YEAR(STR_TO_DATE(arrival_date, '%d-%m-%Y')) = 2017;

-- for 2018
SELECT count(arrival_date) AS count_2018
FROM hotel_reservation
WHERE YEAR(STR_TO_DATE(arrival_date, '%d-%m-%Y')) = 2018;



-- percentage increase in no. of reservations
SELECT 
    ((count_2018 - count_2017) / count_2017) * 100 AS percentage_increase
FROM
    (SELECT COUNT(arrival_date) AS count_2017
    FROM hotel_reservation
    WHERE YEAR(STR_TO_DATE(arrival_date, '%d-%m-%Y')) = 2017) AS reservations_2017,
    (SELECT COUNT(arrival_date) AS count_2018
    FROM hotel_reservation
    WHERE YEAR(STR_TO_DATE(arrival_date, '%d-%m-%Y')) = 2018) AS reservations_2018;



-- Ques) What is the most commonly booked room type?


select room_type_reserved , count(room_type_reserved) as count
from hotel_reservation
group by room_type_reserved
order by count desc;


-- Ques)How many reservations fall on a weekend (no_of_weekend_nights > 0)?


select count(*)
from hotel_reservation
where no_of_weekend_nights>0;


-- Ques) What is the highest and lowest lead time for reservations?

select
 max(lead_time) as highest_lead_time , 
min(lead_time) as lowest_lead_time
 from hotel_reservation;
 
 
 -- Ques)What is the most common market segment type for reservations?
 
 select market_segment_type , count(market_segment_type) as count
 from hotel_reservation
 group by market_segment_type
order by count desc ;


-- Ques) How many reservations have a booking status of "Confirmed"?

select count(booking_status )
from hotel_reservation
where booking_status="Confirmed";


-- No. of reservations based on booking status.

select booking_status ,count(booking_status ) as count 
from hotel_reservation
group by booking_status 
order by count desc;


-- booking status percentage
SELECT 
   booking_status,
    COUNT(*) AS booking_count,
    ((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM hotel_reservation)) AS percentage
FROM hotel_reservation
GROUP BY booking_status
ORDER BY booking_count DESC;




-- Ques) What is the total number of adults and children across all reservations?

select sum(no_of_children) as total_no_of_children, 
sum(no_of_adults) as total_no_adults
from hotel_reservation;


-- Ques) What is the average number of weekend nights for reservations involving children?


select avg(no_of_weekend_nights) as avg_weekend_nights_with_children 
from hotel_reservation
where no_of_children>0;


-- Ques)How many reservations were made in each month of the year?

SELECT 
    COUNT(*) AS reservations_count,
    EXTRACT(MONTH FROM STR_TO_DATE(arrival_date, '%d-%m-%Y')) AS month,
    EXTRACT(YEAR FROM STR_TO_DATE(arrival_date, '%d-%m-%Y')) AS year
FROM 
    hotel_reservation
GROUP BY 
    EXTRACT(MONTH FROM STR_TO_DATE(arrival_date, '%d-%m-%Y')),
    EXTRACT(YEAR FROM STR_TO_DATE(arrival_date, '%d-%m-%Y'))
ORDER BY 
      year, month;



-- Ques) What is the average number of nights (both weekend and weekday) spent by guests for each room type?

select room_type_reserved , avg(no_of_weekend_nights + no_of_week_nights) as avg_no_of_nights 
from hotel_reservation
group by room_type_reserved
order by room_type_reserved asc;


-- Ques) For reservations involving children, what is the most common room type, and what is the average price for that room type?


SELECT 
    room_type_reserved, count(*) as no_of_reservations,
    avg(avg_price_per_room) 
FROM 
    hotel_reservation
WHERE 
    no_of_children > 0
GROUP BY 
    room_type_reserved
ORDER BY 
    COUNT(*) DESC;
    

-- Ques) Find the market segment type that generates the highest average price per room.

select market_segment_type , avg(avg_price_per_room) as highest_avg_price
from hotel_reservation
group by market_segment_type 
order by highest_avg_price desc;





