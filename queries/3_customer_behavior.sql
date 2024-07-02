-- Count of orders per service and status
SELECT
    order_uses_new_service,
    order_status_type,
    COUNT(order_id)
FROM JustEatCase
GROUP BY order_uses_new_service, order_status_type
ORDER BY order_uses_new_service, order_status_type;

-- Frequency use of service
WITH service_use AS (
    SELECT
        customer_id,
        COUNT(order_id) FILTER (WHERE order_uses_new_service = 'yes') AS order_with_new_service,
        COUNT(order_id) AS total_orders
    FROM JustEatCase
    GROUP BY customer_id
)
SELECT
    order_with_new_service,
    COUNT(order_with_new_service) AS customers,
    ROUND(AVG(total_orders), 2) avg_total_orders
FROM service_use
GROUP BY order_with_new_service
ORDER BY order_with_new_service
LIMIT 5;
