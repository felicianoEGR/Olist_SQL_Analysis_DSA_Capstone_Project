-- Q5: Top 3 Products Within Each Category
-- Business Question:
-- Which three products generate the most sales value within each category?
--
-- Method:
-- Calculate total sales value for each product.
-- Assign each product to its product category.
-- Use ROW_NUMBER() to rank products within each category.
-- Return only the top three products per category.

WITH product_revenue AS (
    SELECT
        COALESCE(
            NULLIF(TRIM(t.product_category_name_english), ''),
            NULLIF(TRIM(p.product_category_name), ''),
            '[Unknown/Blank]'
        ) AS product_category,
        oi.product_id,
        SUM(oi.price) AS product_revenue
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
        ),
        oi.product_id
),
ranked_products AS (
    SELECT
        product_category,
        product_id,
        product_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY product_category
            ORDER BY product_revenue DESC, product_id
        ) AS rn
    FROM product_revenue
)
SELECT
    product_category,
    product_id,
    ROUND(product_revenue, 2) AS product_revenue,
    rn AS category_rank
FROM ranked_products
WHERE rn <= 3
ORDER BY product_category, category_rank;