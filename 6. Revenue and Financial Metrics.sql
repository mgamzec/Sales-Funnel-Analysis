WITH funnel_revenue AS (
    SELECT 
        COUNT(DISTINCT user_id) AS total_visitors,
        SUM(CASE WHEN event_type = 'purchase' THEN amount END) AS total_revenue,
        COUNT(CASE WHEN event_type = 'purchase' THEN 1 END) AS total_orders
    FROM `analytics-automation-academy.sql_practice.user_events`
    WHERE event_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
)
SELECT 
    total_revenue,
    ROUND(total_revenue / total_orders, 2) AS average_order_value,
    ROUND(total_revenue / total_visitors, 2) AS revenue_per_visitor
FROM funnel_revenue;
