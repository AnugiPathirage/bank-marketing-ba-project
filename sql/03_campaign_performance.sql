-- ============================================================
-- FILE 03: CAMPAIGN PERFORMANCE ANALYSIS
-- Project: Bank Marketing Campaign Analysis
-- Author:  Anugi Pathirage
-- Purpose: Evaluate how the campaign was run — timing,
--          contact frequency, and channel effectiveness.
--          This identifies operational improvements the
--          bank can make to future campaigns.
-- ============================================================


-- ------------------------------------------------------------
-- Q1. Subscription rate by month
-- Business context: Are certain months significantly better
-- for running term deposit campaigns?
-- ------------------------------------------------------------
SELECT
    month,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_marketing
GROUP BY month
ORDER BY conversion_rate_pct DESC;


-- ------------------------------------------------------------
-- Q2. Subscription rate by day of the week
-- Business context: Is there a better day to call customers?
-- Timing can significantly affect willingness to engage.
-- ------------------------------------------------------------
SELECT
    day_of_week,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_marketing
GROUP BY day_of_week
ORDER BY conversion_rate_pct DESC;


-- ------------------------------------------------------------
-- Q3. Impact of contact frequency on conversion
-- Business context: Is there a point where calling customers
-- more actually HURTS conversion? This has major cost
-- implications for the campaign budget.
-- ------------------------------------------------------------
SELECT
    campaign AS number_of_calls,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_marketing
WHERE campaign <= 10   -- focus on meaningful volumes
GROUP BY campaign
ORDER BY campaign;


-- ------------------------------------------------------------
-- Q4. What is the optimal number of calls to make?
-- Business context: Summarise the diminishing returns
-- finding into a clear business recommendation.
-- ------------------------------------------------------------
SELECT
    CASE
        WHEN campaign = 1          THEN '1 call'
        WHEN campaign = 2          THEN '2 calls'
        WHEN campaign = 3          THEN '3 calls'
        WHEN campaign BETWEEN 4 AND 6 THEN '4-6 calls'
        ELSE '7+ calls'
    END AS contact_frequency,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_marketing
GROUP BY contact_frequency
ORDER BY conversion_rate_pct DESC;


-- ------------------------------------------------------------
-- Q5. Does call duration predict subscription?
-- Business context: Longer calls may indicate genuine
-- interest. This helps agents identify promising leads
-- early in a conversation.
-- ------------------------------------------------------------
SELECT
    CASE
        WHEN duration < 60  THEN 'Under 1 min'
        WHEN duration < 180 THEN '1-3 mins'
        WHEN duration < 300 THEN '3-5 mins'
        WHEN duration < 600 THEN '5-10 mins'
        ELSE 'Over 10 mins'
    END AS call_duration,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_marketing
GROUP BY call_duration
ORDER BY conversion_rate_pct DESC;


-- ------------------------------------------------------------
-- Q6. Contact channel effectiveness
-- Business context: Cellular vs telephone — which channel
-- delivers better ROI for the campaign?
-- ------------------------------------------------------------
SELECT
    contact AS channel,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_marketing
GROUP BY contact
ORDER BY conversion_rate_pct DESC;
