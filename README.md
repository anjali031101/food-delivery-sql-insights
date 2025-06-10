
SQL-based customer insights and performance analysis for a food delivery launch in Barcelona. Includes user acquisition trends, restaurant performance, promo usage, and engagement patterns.
# Customer Insights & Performance Analytics – Food Delivery Launch

This SQL project analyzes customer behavior and restaurant performance data after a food delivery launch in Barcelona.

🔍 Key Insights Extracted:
- Daily new user count from the launch date
- Top 3 restaurants by cuisine type (without using LIMIT or TOP)
- Users acquired in Jan 2025 who ordered only once
- Customers inactive in last 7 days but active a month ago (with promo use)
- Customers after every third order (for personalized targeting)
- Customers who always used promo codes
- Percentage of users acquired without any promo (organic)

 🛠 SQL Concepts Used
- Common Table Expressions (CTEs)
- Window Functions (`ROW_NUMBER`)
- Aggregation (`COUNT`, `MIN`, `MAX`)
- Filtering (`WHERE`, `HAVING`, `NOT IN`, `IS NOT NULL`)
- Conditional Logic (`CASE WHEN`)
- Date Functions (`DATEADD`, `MONTH`, `YEAR`, `CAST`)
- Modular Arithmetic (`%`)
- Subqueries

 📁 File
food_insights_queries.sql`: Contains all 7 queries with comments and logic

💡 Sample Use Case
This type of analysis can help food delivery platforms understand user behavior, optimize marketing campaigns, and improve restaurant recommendations.

