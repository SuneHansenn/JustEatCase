-- Order per customer 
WITH 
order_pattern AS (
    SELECT
        customer_id,
        customer_segment,
        COUNT(order_id) AS orders_per_customer
    FROM JustEatCase
    GROUP BY customer_id, customer_segment
)
SELECT DISTINCT
    orders_per_customer AS orders, 
    COUNT(orders_per_customer) AS customers,
    COUNT(orders_per_customer) FILTER (WHERE customer_segment = 'adopter') AS yes_new_service,
    COUNT(orders_per_customer) FILTER (WHERE customer_segment = 'non-adopter') AS no_new_service
FROM order_pattern
GROUP BY orders_per_customer
ORDER BY orders_per_customer;
-- Average
WITH 
order_pattern AS (
    SELECT
        customer_id,
        customer_segment,
        COUNT(order_id) AS orders_per_customer
    FROM JustEatCase
    GROUP BY customer_id, customer_segment
)
SELECT
    AVG(orders_per_customer) avg_retention,
    AVG(orders_per_customer) FILTER (WHERE customer_segment = 'adopter') AS avg_yes_new_service,
    AVG(orders_per_customer) FILTER (WHERE customer_segment = 'non-adopter') AS avg_no_new_service
FROM order_pattern;

-- What customers typically order
SELECT
    restaurant_cuisine,
    COUNT(gross_order_value) AS times_ordered,
    SUM(gross_order_value) AS sum_order,
    ROUND(AVG(gross_order_value), 2) AS avg_order_size
FROM JustEatCase
GROUP BY
    restaurant_cuisine
ORDER BY    
    COUNT(gross_order_value) DESC
LIMIT 10;

-- Delivery time (proxy for distance assuming fastest route taken)
;

-- Average customer value
