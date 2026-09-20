-- Q6: Customer Spending Tiers
-- Business Question:
-- How are customers distributed across Low, Medium, and High spending tiers?
--
-- Method:
-- Calculate total spending for each customer.
-- Assign customers to spending tiers using CASE.
-- Count customers and total revenue within each tier.
-- Calculate the average customer spending for each tier.

WITH customer_spend AS (
    SELECT
        c.customer_id,
        COALESCE(SUM(p.payment_value), 0) AS total_spent
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_payments AS p
        ON o.order_id = p.order_id
    GROUP BY c.customer_id
),
customer_tiers AS (
    SELECT
        customer_id,
        total_spent,
        CASE
            WHEN total_spent < 100 THEN 'Low'
            WHEN total_spent < 500 THEN 'Medium'
            ELSE 'High'
        END AS spend_tier
    FROM customer_spend
)
SELECT
    spend_tier,
    COUNT(*) AS customer_count,
    ROUND(SUM(total_spent), 2) AS tier_revenue,
    ROUND(AVG(total_spent), 2) AS average_customer_spend
FROM customer_tiers
GROUP BY spend_tier
ORDER BY
    CASE spend_tier
        WHEN 'Low' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'High' THEN 3
    END;