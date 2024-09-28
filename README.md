# Pizza_Sales_SQL

This project analyzes pizza sales data using SQL to extract key business insights. The questions are categorized into Basic, Intermediate, and Advanced levels, covering a range of SQL operations from basic retrievals to complex aggregations.

1)Pizza Category Sales Analysis:
Insight: By grouping pizzas into categories (e.g., Vegetarian, Non-Vegetarian, etc.), we can determine which category generates the most sales. This helps the store identify popular pizza preferences and optimize inventory accordingly.
SQL Method: Using GROUP BY on pizza categories and applying the SUM() function to calculate total quantities sold per category. This would involve joining the pizza and order tables.


2)Number of Customers Per Day:
Insight: Analyzing the number of customers or orders per day helps track store traffic and customer behavior. This can inform staffing and operational decisions.
SQL Method: By grouping orders by date, we can use COUNT() to calculate the number of distinct customers or orders.


3)Hourly Pizza Sales (Footfall Analysis):
Insight: Understanding peak hours of pizza sales helps determine the time of day with the highest footfall, allowing the store to manage resources like staff and inventory more effectively.
SQL Method: Grouping orders by hour (HOUR()) and applying COUNT() or SUM() to identify which hour sees the most sales.


4)Pizza Size Sales Analysis:
Insight: Identifying which pizza size (Small, Medium, Large) sells the most allows the store to adjust pricing strategies and inventory based on customer preferences.
SQL Method: Grouping by pizza size and using SUM() on the quantity sold.

