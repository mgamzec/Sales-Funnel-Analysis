WITH funnel_stages AS (
    SELECT 
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS stage_1_views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS stage_2_cart,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS stage_3_checkout,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS stage_4_payment,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS stage_5_purchase
    FROM `analytics-automation-academy.sql_practice.user_events`
    WHERE event_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
)
SELECT 
    stage_1_views AS total_views,
    ROUND(stage_2_cart * 100 / stage_1_views, 2) AS view_to_cart_rate,
    ROUND(stage_3_checkout * 100 / stage_2_cart, 2) AS cart_to_checkout_rate,
    ROUND(stage_5_purchase * 100 / stage_4_payment, 2) AS payment_to_purchase_rate,
    ROUND(stage_5_purchase * 100 / stage_1_views, 2) AS overall_conversion_rate
FROM funnel_stages;
