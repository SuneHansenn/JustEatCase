WITH monthly_counts AS (
    SELECT
        EXTRACT(MONTH FROM order_date) AS months, 
        COUNT(order_id) FILTER (WHERE order_uses_new_service = 'no') AS count_no_service,
        COUNT(order_id) FILTER (WHERE order_uses_new_service = 'yes') AS count_yes_service
        -- COUNT(CASE WHEN order_uses_new_service = 'no' THEN order_id ELSE 0 END),
        -- COUNT(CASE WHEN order_uses_new_service = 'yes' THEN order_id ELSE 0 END)
    FROM 
        JustEatCase
    GROUP BY
        EXTRACT(MONTH FROM order_date)
    ORDER BY
        months
)

SELECT
    months,
    count_no_service,
    ROUND(((count_no_service::NUMERIC  - LAG(count_no_service) OVER (ORDER BY months)) / LAG(count_no_service) OVER (ORDER BY months)) * 100, 2) AS pct_change_no_service,
    count_yes_service,
    ROUND(((count_yes_service::NUMERIC  - LAG(count_yes_service) OVER (ORDER BY months)) / LAG(count_yes_service) OVER (ORDER BY months)) * 100, 2) AS pct_change_yes_service
FROM
    monthly_counts;