-- ============================================================
-- FILE 04: CONVERSION & RECOMMENDATION ANALYSIS
-- Project: Bank Marketing Campaign Analysis
-- Author:  Anugi Pathirage
-- Purpose: Deep dive into what drives final subscription.
--          These queries feed directly into the business
--          recommendation document and executive summary.
-- ============================================================


-- ------------------------------------------------------------
-- Q1. How powerful is a previous successful campaign?
-- Business context: If a customer said YES before, how
-- likely are they to say YES again? This is a key insight
-- for building a re-engagement list.
-- ------------------------------------------------------------
SELECT
    poutcome AS previous_campaign_outcome,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_marketing
GROUP BY poutcome
ORDER BY conversion_rate_pct DESC;


-- ------------------------------------------------------------
-- Q2. Does the economic environment affect subscriptions?
-- Business context: Term deposits compete with other
-- investments. When consumer confidence is low, are
-- customers more likely to choose safe savings products?
-- ------------------------------------------------------------
SELECT
    CASE
        WHEN cons.conf.idx < -50 THEN 'Very Low Confidence'
        WHEN cons.conf.idx < -40 THEN 'Low Confidence'
        WHEN cons.conf.idx < -30 THEN 'Moderate Confidence'
        ELSE 'Higher Confidence'
    END AS consumer_confidence_band,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_marketing
GROUP BY consumer_confidence_band
ORDER BY conversion_rate_pct DESC;


-- ------------------------------------------------------------
-- Q3. Priority customer list — re-engagement candidates
-- Business context: These are customers who previously
-- subscribed and should be the FIRST group contacted in
-- any future campaign. High ROI, low effort.
-- ------------------------------------------------------------
SELECT
    job,
    education,
    CASE
        WHEN age < 35 THEN 'Under 35'
        WHEN age < 55 THEN '35-54'
        ELSE '55+'
    END AS age_band,
    COUNT(*) AS total_in_segment,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS current_subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_marketing
WHERE poutcome = 'success'
GROUP BY job, education, age_band
HAVING total_in_segment >= 10
ORDER BY conversion_rate_pct DESC;


-- ------------------------------------------------------------
-- Q4. Wasted effort analysis — low conversion segments
-- Business context: Where is the bank spending call centre
-- resources with very little return? Reducing outreach to
-- these groups frees up budget for high-value targeting.
-- ------------------------------------------------------------
SELECT
    job,
    campaign AS avg_calls,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_marketing
WHERE campaign >= 4
GROUP BY job
HAVING total_contacts >= 100
ORDER BY conversion_rate_pct ASC
LIMIT 10;


-- ------------------------------------------------------------
-- Q5. Executive summary — key metrics in one query
-- Business context: This single query produces the headline
-- numbers used in the business recommendation document.
-- ------------------------------------------------------------
SELECT
    COUNT(*)                                                                AS total_customers_contacted,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END)                            AS total_subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS overall_conversion_rate_pct,
    ROUND(AVG(campaign), 1)                                                AS avg_calls_per_customer,
    ROUND(AVG(CASE WHEN y = 'yes' THEN duration ELSE NULL END), 0)         AS avg_call_duration_subscribers_secs,
    ROUND(AVG(CASE WHEN y = 'no'  THEN duration ELSE NULL END), 0)         AS avg_call_duration_non_subscribers_secs,
    SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END)                  AS prior_success_customers,
    ROUND(SUM(CASE WHEN poutcome = 'success' AND y = 'yes' THEN 1 ELSE 0 END) * 100.0
          / NULLIF(SUM(CASE WHEN poutcome = 'success' THEN 1 ELSE 0 END), 0), 2) AS prior_success_conversion_rate_pct
FROM bank_marketing;
