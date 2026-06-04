-- ============================================================
-- FILE 02: CUSTOMER SEGMENTATION ANALYSIS
-- Project: Bank Marketing Campaign Analysis
-- Author:  Anugi Pathirage
-- Purpose: Identify which customer profiles are most likely
--          to subscribe to a term deposit. This drives
--          targeting recommendations for the business.
-- ============================================================


-- ------------------------------------------------------------
-- Q1. Subscription rate by age group
-- Business context: Are older or younger customers more
-- likely to subscribe? This informs who to prioritise.
-- ------------------------------------------------------------
SELECT
    CASE
        WHEN age < 25              THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        WHEN age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_marketing
GROUP BY age_group
ORDER BY age_group;


-- ------------------------------------------------------------
-- Q2. Subscription rate by job type
-- Business context: Which professions should the bank
-- focus its outreach efforts on?
-- ------------------------------------------------------------
SELECT
    job,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_marketing
GROUP BY job
ORDER BY conversion_rate_pct DESC;


-- ------------------------------------------------------------
-- Q3. Subscription rate by education level
-- Business context: Does higher education correlate with
-- greater interest in term deposit products?
-- ------------------------------------------------------------
SELECT
    education,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_marketing
GROUP BY education
ORDER BY conversion_rate_pct DESC;


-- ------------------------------------------------------------
-- Q4. Subscription rate by marital status
-- Business context: Family situation may affect savings
-- behaviour and financial product appetite.
-- ------------------------------------------------------------
SELECT
    marital,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_marketing
GROUP BY marital
ORDER BY conversion_rate_pct DESC;


-- ------------------------------------------------------------
-- Q5. Impact of existing loans on subscription
-- Business context: Customers with existing financial
-- commitments may be less likely to lock money in a deposit.
-- ------------------------------------------------------------
SELECT
    housing AS has_housing_loan,
    loan    AS has_personal_loan,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_marketing
WHERE housing != 'unknown' AND loan != 'unknown'
GROUP BY housing, loan
ORDER BY conversion_rate_pct DESC;


-- ------------------------------------------------------------
-- Q6. High-value segment: who are the best customers?
-- Business context: Combine the top-performing attributes
-- to define the ideal target customer profile.
-- ------------------------------------------------------------
SELECT
    job,
    education,
    CASE
        WHEN age < 25              THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        WHEN age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
    ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate_pct
FROM bank_marketing
GROUP BY job, education, age_group
HAVING total_contacts >= 50   -- filter out tiny segments
ORDER BY conversion_rate_pct DESC
LIMIT 15;
