-- Value difference on orders using new service
WITH avg_order AS (
    SELECT
        order_uses_new_service,
        AVG(gross_order_value) AS avg_order_size,
        ROUND(AVG(gross_order_value * (pct_commission_on_gross_order_value::NUMERIC / 100)), 2) AS avg_order_gain
    FROM JustEatCase
    GROUP BY
        order_uses_new_service, customer_id
)
SELECT
    order_uses_new_service,
    ROUND(AVG(avg_order_size), 2) AS avg_size,
    ROUND(AVG(avg_order_gain), 2) AS avg_gain
FROM
    avg_order
GROUP BY 
    order_uses_new_service;


-- Same view but grouped on before / after adoption (no difference)
WITH
first_adoption AS (
    SELECT
        customer_id,
        MIN(customer_nth_order) AS first_adoption_order
    FROM JustEatCase
    WHERE order_uses_new_service = 'yes'
    GROUP BY customer_id
),
before_after_adoption AS (
    SELECT
        j.customer_id, j.order_id, j.order_date,
        j.customer_nth_order, f.first_adoption_order,
        j.gross_order_value, j.pct_commission_on_gross_order_value,
        CASE
            WHEN f.first_adoption_order IS NULL THEN 'No adoption'
            WHEN j.customer_nth_order < f.first_adoption_order THEN 'Not yet adopted'
            WHEN j.customer_nth_order = f.first_adoption_order THEN 'Adoption'
            ELSE 'Adopted' END AS service_adoption
    FROM JustEatCase AS j LEFT JOIN first_adoption AS f ON j.customer_id = f.customer_id
)
SELECT
    service_adoption,
    COUNT(gross_order_value) AS order_count,
    AVG(gross_order_value) AS avg_gross_value
FROM before_after_adoption
GROUP BY service_adoption