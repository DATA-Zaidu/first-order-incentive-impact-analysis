Are high discounts attracting low-quality customers who churn early?

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS total_orders
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    CASE WHEN total_orders = 1 THEN 'Churned' ELSE 'Retained' END AS status,
    COUNT(*) AS customers
FROM customer_orders
GROUP BY status;
