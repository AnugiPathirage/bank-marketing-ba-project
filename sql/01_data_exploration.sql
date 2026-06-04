-- ============================================================
-- FILE 01: DATA EXPLORATION & PROFILING
-- Project: Bank Marketing Campaign Analysis
-- Author:  Anugi Pathirage
-- Purpose: Understand the dataset before analysis begins.
--          A BA always profiles data first to spot quality
--          issues, understand distributions, and confirm
--          the data matches the business context.
-- ============================================================


-- ------------------------------------------------------------
-- Q1. How many records are in the dataset?
-- Business context: Confirms data loaded correctly.
-- ------------------------------------------------------------
SELECT COUNT(*) AS total_records
FROM bank_marketing;


-- ------------------------------------------------------------
-- Q2. What is the overall subscription rate?
-- Business context: This is our headline KPI — the % of
-- customers who said YES to a term deposit.
-- ------------------------------------------------------------
SELECT
    y AS subscribed,
    COUNT(*) AS total_contacts,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM bank_marketing
GROUP BY y;


-- ------------------------------------------------------------
-- Q3. What does the age distribution look like?
-- Business context: Helps identify if certain age groups
-- dominate the dataset and whether targeting is balanced.
-- ------------------------------------------------------------
SELECT
    MIN(age)  AS youngest_customer,
    MAX(age)  AS oldest_customer,
    ROUND(AVG(age), 1) AS average_age
FROM bank_marketing;


-- ------------------------------------------------------------
-- Q4. What job types are represented in the dataset?
-- Business context: Job type is a key segmentation variable
-- for financial product targeting.
-- ------------------------------------------------------------
SELECT
    job,
    COUNT(*) AS total_contacts,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bank_marketing), 2) AS pct_of_total
FROM bank_marketing
GROUP BY job
ORDER BY total_contacts DESC;


-- ------------------------------------------------------------
-- Q5. What education levels are in the dataset?
-- Business context: Education level may influence financial
-- literacy and appetite for savings products.
-- ------------------------------------------------------------
SELECT
    education,
    COUNT(*) AS total_contacts,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bank_marketing), 2) AS pct_of_total
FROM bank_marketing
GROUP BY education
ORDER BY total_contacts DESC;


-- ------------------------------------------------------------
-- Q6. Are there any data quality issues? (nulls / unknowns)
-- Business context: BAs must flag data quality issues before
-- drawing conclusions. "Unknown" values could skew results.
-- ------------------------------------------------------------
SELECT
    SUM(CASE WHEN job       = 'unknown' THEN 1 ELSE 0 END) AS unknown_job,
    SUM(CASE WHEN marital   = 'unknown' THEN 1 ELSE 0 END) AS unknown_marital,
    SUM(CASE WHEN education = 'unknown' THEN 1 ELSE 0 END) AS unknown_education,
    SUM(CASE WHEN default   = 'unknown' THEN 1 ELSE 0 END) AS unknown_default,
    SUM(CASE WHEN housing   = 'unknown' THEN 1 ELSE 0 END) AS unknown_housing,
    SUM(CASE WHEN loan      = 'unknown' THEN 1 ELSE 0 END) AS unknown_loan
FROM bank_marketing;


-- ------------------------------------------------------------
-- Q7. What contact methods were used?
-- Business context: Understanding channel mix helps assess
-- whether the bank is using the most effective methods.
-- ------------------------------------------------------------
SELECT
    contact,
    COUNT(*) AS total_contacts,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bank_marketing), 2) AS pct_of_total
FROM bank_marketing
GROUP BY contact
ORDER BY total_contacts DESC;


-- ------------------------------------------------------------
-- Q8. How many customers were contacted in previous campaigns?
-- Business context: Prior campaign history is a strong
-- predictor of current campaign success.
-- ------------------------------------------------------------
SELECT
    CASE
        WHEN pdays = 999 THEN 'Never contacted before'
        WHEN pdays <= 30  THEN 'Contacted within 30 days'
        WHEN pdays <= 90  THEN 'Contacted within 90 days'
        ELSE 'Contacted 90+ days ago'
    END AS prior_contact_recency,
    COUNT(*) AS total_customers
FROM bank_marketing
GROUP BY prior_contact_recency
ORDER BY total_customers DESC;
