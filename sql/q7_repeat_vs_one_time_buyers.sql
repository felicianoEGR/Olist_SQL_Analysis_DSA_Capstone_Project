-- Q7: Repeat vs One-Time Buyers
-- Business Question:
-- How many customers are repeat buyers versus one-time buyers?
--
-- Method:
-- Count the number of distinct orders for each customer.
-- Classify customers with more than one order as repeat buyers.
-- Classify customers with one or fewer orders as one-time buyers.
-- Calculate the number and percentage of customers in each group.

WITH customer_orders AS (
    SELECT
        c.customer_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
)
SELECT
    CASE
        WHEN order_count > 1 THEN 'Repeat buyer'
        ELSE 'One-time buyer'
    END AS buyer_type,
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percent_of_customers
FROM customer_orders
GROUP BY
    CASE
        WHEN order_count > 1 THEN 'Repeat buyer'
        ELSE 'One-time buyer'
    END
ORDER BY buyer_type;