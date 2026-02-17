# Sales Funnel Analysis

# E-Commerce Data Analytics: End-to-End SQL Project

This project demonstrates a complete data analytics workflow using e-commerce user event data. Using SQL in Google BigQuery, I analyzed the sales funnel, marketing channel performance, and key financial metrics to derive actionable business insights.

## Project Overview
The goal is to transform raw event data into strategic recommendations for stakeholders in UX, Marketing, and Finance.

## Tech Stack
* Platform: Google BigQuery
* Language: Standard SQL
* Dataset: `analytics-automation-academy.sql_practice.user_events`

---

## Analysis and SQL Queries

### 1. Sales Funnel Analysis
This query tracks the user journey from the initial page view to the final purchase, identifying where the biggest drops occur.

```sql
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
    stage_1_views AS views,
    stage_2_cart AS cart,
    stage_5_purchase AS purchases,
    ROUND(stage_2_cart * 100 / stage_1_views, 2) AS view_to_cart_rate,
    ROUND(stage_5_purchase * 100 / stage_1_views, 2) AS overall_conversion_rate
FROM funnel_stages;
