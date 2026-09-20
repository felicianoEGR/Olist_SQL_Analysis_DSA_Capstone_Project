-- Q8: Top Product Category by Revenue Share
-- Business Question:
-- Which product category generates the largest share of total sales value?
--
-- Method:
-- Calculate sales value for each product category.
-- Calculate the total sales value across all categories.
-- Rank categories from highest to lowest.
-- Calculate the top category's percentage share of total sales value.

WITH category_revenue AS (
    SELECT
        COALESCE(
            NULLIF(TRIM(t.product_category_name_english), ''),
            NULLIF(TRIM(p.product_category_name), ''),
            '[Unknown/Blank]'
        ) AS product_category,
        SUM(oi.price) AS category_revenue
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
),
ranked_categories AS (
    SELECT
        product_category,
        category_revenue,
        ROW_NUMBER() OVER (
            ORDER BY category_revenue DESC, product_category
        ) AS rn,
        SUM(category_revenue) OVER () AS total_revenue
    FROM category_revenue
)
SELECT
    product_category AS top_category,
    ROUND(category_revenue, 2) AS top_category_revenue,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(
        category_revenue / NULLIF(total_revenue, 0) * 100,
        2
    ) AS revenue_share_pct
FROM ranked_categories
WHERE rn = 1;