Do customers who receive first-order incentives retain better or worse than others?

WITH delivered_orders AS (
    SELECT
        o.order_id,
        c.customer_unique_id,
        DATE(o.order_purchase_timestamp) AS order_date
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
),
ranked_orders AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY customer_unique_id
            ORDER BY order_date
        ) AS order_rank
    FROM delivered_orders
),
incentives AS (
    SELECT
        *,
        CASE
            WHEN order_rank = 1 AND (ABS(RANDOM()) % 100) < 25 THEN 'Low'
            WHEN order_rank = 1 AND (ABS(RANDOM()) % 100) < 50 THEN 'Medium'
            WHEN order_rank = 1 THEN 'High'
            ELSE 'No Incentive'
        END AS incentive_bucket
    FROM ranked_orders
),
customer_lifetime AS (
    SELECT
        customer_unique_id,
        COUNT(*) AS total_orders
    FROM incentives
    GROUP BY customer_unique_id
)
SELECT
    i.incentive_bucket,
    COUNT(DISTINCT i.customer_unique_id) AS customers,
    ROUND(
        100.0 * SUM(CASE WHEN cl.total_orders > 1 THEN 1 ELSE 0 END)
        / COUNT(DISTINCT i.customer_unique_id),
        2
    ) AS repeat_rate_pct
FROM incentives i
JOIN customer_lifetime cl
    ON i.customer_unique_id = cl.customer_unique_id
WHERE i.order_rank = 1
GROUP BY i.incentive_bucket;
