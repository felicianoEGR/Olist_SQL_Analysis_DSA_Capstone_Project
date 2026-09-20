Olist SQL Analysis DSA Capstone Project



Overview



This project analyzes the Brazilian Olist e-commerce dataset using MySQL to answer business questions about customers, revenue, products, product categories, and purchasing behavior. The dataset contains 99,441 customers and 99,441 orders, with order data covering September 2016 through October 2018. The analysis uses relevant tables including customers, orders, order payments, order items, products, and product category translation. Data quality considerations include multiple payment records for some orders, one order without a matching payment record, and blank product-category values that were handled explicitly in the category analyses.



Business Questions

Which customers have spent the most?

How much revenue was generated each month?

How did revenue change from one month to the next?

Which product categories generate the most sales value?

Which three products generate the most sales value within each category?

How are customers distributed across Low, Medium, and High spending tiers?

How many customers are repeat buyers versus one-time buyers?

Which product category generates the largest share of total sales value?



Key Findings

Q1 The highest-spending customer in the Q1 result spent 13,664.08.

Q2 November 2017 recorded the highest monthly payment revenue in the Q2 result at 1,194,882.80.

Q3 Revenue increased by 53.25% from October to November 2017 in the Q3 result.

Q4 identified health and beauty as the category with the highest product sales value, at 1,258,681.34.

Q5 identifies the top three products within each product category.

Q6 identified 4,296 customers in the High spending tier, with average spending of 929.94.

Q7 classified all 99,441 customers as one-time buyers within the available customer and order records.

Q8 identified health and beauty as the top category by product sales value, representing 9.26% of total category sales value.



Recommendations

1\. Improve Customer Retention



The business could develop follow-up campaigns after a customer's first purchase and study the products and categories associated with higher customer spending. This is supported by the spending-tier results in Q6 and the one-time-buyer finding in Q7.



2\. Focus on High-Performing Categories and Products



The business could review demand for health and beauty products, monitor leading products, and use these findings to support inventory and merchandising decisions. This is supported by Q8's finding that health\_beauty generated 9.26% of total category sales value and by the product-level rankings in Q5.



Data Quality Notes

The dataset contains 99,441 customers and 99,441 orders.

Some orders have multiple payment records, so payment analyses use the sum of payment values.

One order does not have a matching payment record.

Some product-category values are blank and were handled explicitly in the category analyses.

Q1, Q2, Q3, and Q6 use order\_payments.payment\_value.

Q4, Q5, and Q8 use order\_items.price as product sales value.

The first and last periods of the order data contain partial months and should not be interpreted as normal full-month performance.



Tools \& Skills

MySQL 8.0

MySQL Workbench

SQL

INNER JOIN and LEFT JOIN

GROUP BY and aggregate functions

Common Table Expressions (CTEs)

CASE statements

Window functions

LAG()

ROW\_NUMBER()

Data cleaning and validation



Business analysis and communication

Files

sql/q1\_top\_customers.sql — Top 10 customers by spending

sql/q2\_monthly\_revenue.sql — Monthly revenue

sql/q3\_month\_over\_month\_revenue.sql — Month-over-month revenue change

sql/q4\_revenue\_by\_product\_category.sql — Revenue by product category

sql/q5\_top\_3\_products\_per\_category.sql — Top 3 products within each category

sql/q6\_customer\_spending\_tiers.sql — Customer spending tiers

sql/q7\_repeat\_vs\_one\_time\_buyers.sql — Repeat versus one-time buyers

sql/q8\_top\_category\_revenue\_share.sql — Top category revenue share



Project Purpose



The purpose of this project is to demonstrate how SQL can be used to transform raw e-commerce data into business insights and actionable recommendations.



Querying is not analysis until it is communicated.

