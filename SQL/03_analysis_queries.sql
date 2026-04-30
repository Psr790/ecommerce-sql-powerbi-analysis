/*************************************************************************************************************************************************************

 Name: Pushpendra Singh Rathore
 Date: 30.04.2026
 Project: E-COMMERCE ANALYSIS QUERIES

 *************************************************************************************************************************************************************/

1. Total Revenue 

		Select Sum(payment_value) As Total_Revenue
		From order_payments

2. Orders by state

		Select c.customer_state, COUNT(o.order_id) AS total_orders 
		From Customers c
		Join orders o ON c.customer_id = o.customer_id
		Group by c.customer_state
		order by total_orders DESC;

3. Top Selling Products

		Select p.product_id, Count(o.order_id) AS Total_Sold
		from order_items o
		Join Products p on o .Products_id  = p.product_id 
		Group by p_product _id 
		Order by Total_Sold Desc;

4. Delivery delay 
		with delivery as 
		(Select order_id,
			   DATEDIFF(day, order_estimated_delivery_date, order_delivered_customer_date) as Delay_days 
		from orders
		where order_delivered_customer_date is not null)
		select COUNT(*) as total_orders,
		avg(delay_days) as avg_delay
		from delivery;

5. Repeat Customers

		Select c.customer_unique_id, COUNT(o.order_id) AS Total_Orders
		from Customers c 
		join orders o on c.customer_id = o.customer_id
		group by c.customer_unique_id 
		having count (o.order_id) > 1
		order by total_orders Desc;

6. View

		Create View delivery_performance AS 
		Select o.order_id,
			   c.customer_state,
			   DATEDIFF(day, o.order_estimated_delivery_date, o.order_delivered_customer_date) as delay_days
			   from orders o 
			   join customers c on o.customer_id = c.customer_id;

			   select * from delivery_performance

7. CTE

		WITH delivery_analysis AS (
    SELECT 
        o.order_id,
        c.customer_state,
        DATEDIFF(day, o.order_estimated_delivery_date, o.order_delivered_customer_date) AS delay_days
    FROM orders o
    JOIN Customers c ON o.customer_id = c.customer_id
    WHERE o.order_delivered_customer_date IS NOT NULL
)
SELECT 
    customer_state,
    AVG(delay_days) AS avg_delay,
    COUNT(*) AS total_orders
FROM delivery_analysis
GROUP BY customer_state
ORDER BY avg_delay DESC;
