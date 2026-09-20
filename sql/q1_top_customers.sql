-- Q1: Top 10 Customers by Total Spending
-- Business Question:
-- Which customers have spent the most on the Olist platform?
--
-- Method:
-- Join customers, orders, and payment records.
-- Calculate total spending for each customer.
-- Sort customers from highest to lowest spending.
-- Return the top 10 customers.

SELECT
    c.customer_id,
    ROUND(SUM(p.payment_value), 2) AS total_spent
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN order_payments AS p
    ON o.order_id = p.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 10;