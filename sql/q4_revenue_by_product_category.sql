-- Q4: Revenue by Product Category
-- Business Question:
-- Which product categories generate the most sales value?
--
-- Method:
-- Join order items with products and the category translation table.
-- Use the English category name when available.
-- Treat blank category values as [Unknown/Blank].
-- Sum product prices for each category.
-- Sort categories from highest to lowest sales value.

SELECT
    COALESCE(
        NULLIF(TRIM(t.product_category_name_english), ''),
        NULLIF(TRIM(p.product_category_name), ''),
        '[Unknown/Blank]'
    ) AS product_category,
    ROUND(SUM(oi.price), 2) AS category_revenue
FROM order_items AS oi
INNER JOIN products AS p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_translation AS t
    ON p.product_category_name = t.product_category_name
GROUP BY
    COALESCE(
        NULLIF(TRIM(t.product_category_name_english), ''),
        NULLIF(TRIM(p.product_category_name), ''),
        '[Unknown/Blank]'
    )
ORDER BY category_revenue DESC;