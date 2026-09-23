/*
=========================================================
CREDIT RISK ANALYTICS
DASHBOARD KPI QUERIES
=========================================================

Purpose:
Provide SQL-based KPI calculations used to validate
the Power BI dashboard.

Table:
credit_applications
=========================================================
*/

KPI 1 — Portfolio size
SELECT
    COUNT(*) AS total_customers
FROM credit_applications;
KPI 2 — Payment difficulty customers
SELECT
    SUM(payment_difficulty) AS payment_difficulty_customers
FROM credit_applications;
KPI 3 — Overall risk rate
SELECT
    ROUND(
        100.0 * SUM(payment_difficulty) / COUNT(*),
        2
    ) AS risk_rate
FROM credit_applications;
KPI 4 — Total loan exposure
SELECT
    ROUND(SUM(loan_amount), 2) AS total_loan_exposure
FROM credit_applications;
KPI 5 — Average loan
SELECT
    ROUND(AVG(loan_amount), 2) AS average_loan_amount
FROM credit_applications;
KPI 6 — Average loan-to-income
SELECT
    ROUND(AVG(loan_to_income), 2) AS average_loan_to_income
FROM credit_applications;
36.11 — One final executive query

Add this at the bottom:

-- Executive portfolio summary

SELECT
    COUNT(*) AS total_customers,

    SUM(payment_difficulty) AS payment_difficulty_customers,

    ROUND(
        100.0 * SUM(payment_difficulty) / COUNT(*),
        2
    ) AS risk_rate,

    ROUND(
        SUM(loan_amount),
        2
    ) AS total_loan_exposure,

    ROUND(
        AVG(loan_amount),
        2
    ) AS average_loan_amount,

    ROUND(
        AVG(annual_income),
        2
    ) AS average_annual_income,

    ROUND(
        AVG(loan_to_income),
        2
    ) AS average_loan_to_income

FROM credit_applications;