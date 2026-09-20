-- Q3: Month-over-Month Revenue Change
-- Business Question:
-- How did revenue change from one month to the next?
--
-- Method:
-- First calculate total revenue for each month.
-- Then use LAG() to retrieve the previous month's revenue.
-- Calculate both the absolute revenue change and percentage change.
-- Sort the results chronologically.

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
        SUM(p.payment_value) AS revenue
    FROM orders AS o
    INNER JOIN order_payments AS p
        ON o.order_id = p.order_id
    GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
),
revenue_with_previous AS (
    SELECT
        order_month,
        revenue,
        LAG(revenue) OVER (ORDER BY order_month) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT
    order_month,
    ROUND(revenue, 2) AS revenue,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue,
    ROUND(revenue - previous_month_revenue, 2) AS revenue_change,
    ROUND(
        (revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0) * 100,
        2
    ) AS revenue_change_pct
FROM revenue_with_previous
ORDER BY order_month;