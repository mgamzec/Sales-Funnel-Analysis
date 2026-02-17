WITH user_journey AS (
    SELECT 
        user_id,
        MIN(CASE WHEN event_type = 'page_view' THEN event_date END) AS view_time,
        MIN(CASE WHEN event_type = 'purchase' THEN event_date END) AS purchase_time
    FROM `analytics-automation-academy.sql_practice.user_events`
    WHERE event_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
    GROUP BY user_id
    HAVING purchase_time IS NOT NULL
)
SELECT 
    COUNT(*) AS converted_users,
    ROUND(AVG(TIMESTAMP_DIFF(purchase_time, view_time, MINUTE)), 2) AS avg_journey_minutes
FROM user_journey;
