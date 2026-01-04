How does 30-day and 90-day LTV differ by incentive level?



WITH delivered_orders AS (
    SELECT
        o.order_id,
        c.customer_unique_id,
        DATE(o.order_purchase_timestamp) AS order_date,
        oi.price AS revenue
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
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
first_order AS (
    SELECT
        customer_unique_id,
        MIN(order_date) AS first_order_date
    FROM incentives
    GROUP BY customer_unique_id
)
SELECT
    i.incentive_bucket,
    ROUND(SUM(
        CASE
            WHEN julianday(i.order_date) - julianday(f.first_order_date) <= 90
            THEN i.revenue ELSE 0
        END
    ) / COUNT(DISTINCT i.customer_unique_id), 2) AS ltv_90
FROM incentives i
JOIN first_order f
    ON i.customer_unique_id = f.customer_unique_id
WHERE i.order_rank = 1
GROUP BY i.incentive_bucket;
