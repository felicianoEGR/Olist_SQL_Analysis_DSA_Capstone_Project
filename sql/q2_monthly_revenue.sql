-- Q2: Monthly Revenue
-- Business Question:
-- How much revenue was generated in each month?
--
-- Method:
-- Join orders with payment records.
-- Extract the year and month from the order purchase date.
-- Sum payment values for each month.
-- Sort the results chronologically.

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    ROUND(SUM(p.payment_value), 2) AS monthly_revenue
FROM orders AS o
INNER JOIN order_payments AS p
    ON o.order_id = p.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;