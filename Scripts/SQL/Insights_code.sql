--Q1:- Which regions drive the most revenue, and which are the most profitable?

SELECT r.region,
       ROUND(SUM(od.sales)::numeric, 2) AS total_sales,
       ROUND(SUM(od.profit)::numeric, 2) AS total_profit,
       ROUND((SUM(od.profit)::numeric / NULLIF(SUM(od.sales)::numeric, 0))::numeric, 2) AS profit_margin_pct
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN regions r ON o.region_id = r.region_id
GROUP BY r.region
ORDER BY total_sales DESC;

-- Q2:- Who are our most valuable customers?

SELECT c.customer_name,
	ROUND(SUM(od.sales)::numeric,2) Total_sales,
	ROUND(SUM(od.profit)::numeric,2) Total_profit
	FROM customers c
	JOIN orders o ON o.customer_id = c.customer_id
	JOIN order_details od ON o.order_id = od.order_id
	GROUP BY c.customer_name
	ORDER BY Total_sales DESC
	LIMIT 10;

-- Q3:- Do discounts actually help or hurt profits?

SELECT od.discount*100 as "discount%",
       ROUND(SUM(od.sales)::numeric, 2) AS total_sales,
       ROUND(SUM(od.profit)::numeric, 2) AS total_profit,
       ROUND(AVG(od.profit::numeric), 2) AS avg_profit
FROM order_details od
GROUP BY od.discount
ORDER BY od.discount;


--Q4  Seasonal sales trends – Which months perform the best?

SELECT TO_CHAR(o.order_date, 'Month') AS month,
       ROUND(SUM(od.sales)::numeric, 2) AS total_sales,
       ROUND(SUM(od.profit)::numeric, 2) AS total_profit
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY TO_CHAR(o.order_date, 'Month'), DATE_PART('month', o.order_date)
ORDER BY DATE_PART('month', o.order_date);

--Q5 Which regions depend heavily on discounts for sales?

SELECT r.region,
       ROUND(SUM(od.sales)::numeric, 2) AS total_sales,
       ROUND(SUM(od.discount)::numeric, 2) AS total_discounts,
       ROUND(SUM(od.profit)::numeric, 2) AS total_profit,
       ROUND((SUM(od.profit)::numeric / NULLIF(SUM(od.sales)::numeric, 0))::numeric, 2) AS profit_margin_pct
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN regions r ON o.region_id = r.region_id
GROUP BY r.region
ORDER BY total_discounts DESC;


--Q6  Are repeat customers more profitable than one-time customers?

WITH customer_orders AS (
    SELECT c.customer_id, COUNT(DISTINCT o.order_id) AS total_orders
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id)
SELECT CASE WHEN co.total_orders > 1 THEN 'Repeat Customer' ELSE 'One-time Customer' END AS customer_type,
       ROUND(SUM(od.sales)::numeric, 2) AS total_sales,
       ROUND(SUM(od.profit)::numeric, 2) AS total_profit,
       ROUND(AVG(od.profit)::numeric, 2) AS avg_profit_per_customer
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN customer_orders co ON c.customer_id = co.customer_id
GROUP BY customer_type;
