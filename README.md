# E-Commerce Data Analytics: End-to-End SQL Project

This project demonstrates a complete data analytics workflow using e-commerce user event data. Using SQL in Google BigQuery, I analyzed the sales funnel, marketing channel performance, and key financial metrics to derive actionable business insights.

## Project Overview
The goal is to transform raw event data into strategic recommendations for stakeholders in UX, Marketing, and Finance.

## Tech Stack
* **Platform:** Google BigQuery
* **Language:** Standard SQL
* **Dataset:** `analytics-automation-academy.sql_practice.user_events`

---

## 1. Initial Data Exploration
Before starting the analysis, we check the raw data structure to understand event types and user attributes.

```sql
SELECT * FROM `analytics-automation-academy.sql_practice.user_events` 
LIMIT 100;
