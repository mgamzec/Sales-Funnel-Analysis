WITH source_funnel AS (
    SELECT 
        traffic_source,
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS views,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchases
    FROM `analytics-automation-academy.sql_practice.user_events`
    WHERE event_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
    GROUP BY traffic_source
)
SELECT 
    traffic_source,
    views,
    purchases,
    ROUND(purchases * 100 / views, 2) AS conversion_rate
FROM source_funnel
ORDER BY purchases DESC;
