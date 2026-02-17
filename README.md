# Sales Funnel Analysis

E-Commerce Data Analytics: End-to-End SQL ProjectThis project demonstrates a complete data analytics workflow using e-commerce user event data. Using SQL in Google BigQuery, I analyzed the sales funnel, marketing channel performance, and key financial metrics to derive actionable business insights.Project OverviewThe goal is to transform raw event data into strategic recommendations for stakeholders in UX, Marketing, and Finance.Tech StackPlatform: Google BigQueryLanguage: Standard SQLDataset: analytics-automation-academy.sql_practice.user_eventsAnalysis and SQL Queries1. Sales Funnel AnalysisThis query tracks the user journey from the initial page view to the final purchase, identifying where the biggest drops occur.SQLWITH funnel_stages AS (
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
    stage_1_views AS views,
    stage_2_cart AS cart,
    stage_5_purchase AS purchases,
    ROUND(stage_2_cart * 100 / stage_1_views, 2) AS view_to_cart_rate,
    ROUND(stage_5_purchase * 100 / stage_1_views, 2) AS overall_conversion_rate
FROM funnel_stages;
2. Marketing Channel PerformanceAnalyzing which traffic sources drive the most value and highest conversion rates.SQLWITH source_funnel AS (
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
Analysis Results (Sample Output)Based on the queries above, the following data was generated:Funnel MetricsStageUser CountConversion Rate (Step)Page View4,250100%Add to Cart1,32031.06%Purchase71016.71% (Overall)Traffic Source PerformanceSourceTotal ViewsPurchasesConversion RateEmail85021024.71%Organic1,50018512.33%Paid Ads90016518.33%Social1,00015015.00%

