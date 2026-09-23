*/
=========================================================
CREDIT RISK ANALYTICS PROJECT
=========================================================

Business Objective:
Identify customer and loan characteristics associated
with payment difficulties and understand where credit
risk is concentrated.

Database:
credit_risk_db

Main Table:
credit_applications

Author:
Data Analyst Portfolio Project

=========================================================
*/

/*
=========================================================
SECTION 1: DATABASE VALIDATION
=========================================================
*/

SELECT current_database();

/*
=========================================================
SECTION 1: DATABASE VALIDATION
=========================================================
*/

-- Check current database
SELECT current_database();


-- Check available tables
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';


-- Check credit_applications columns
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'credit_applications'
ORDER BY ordinal_position;


-- Check number of records
SELECT COUNT(*) AS total_records
FROM credit_applications;


-- Preview the data
SELECT *
FROM credit_applications
LIMIT 10;

/*
=========================================================
SECTION 2: CORE BUSINESS KPIs
=========================================================
*/

-- KPI 1: Overall Payment Difficulty

SELECT
    COUNT(*) AS total_customers,

    SUM(payment_difficulty) AS customers_with_payment_difficulty,

    ROUND(
        100.0 * SUM(payment_difficulty) / COUNT(*),
        2
    ) AS payment_difficulty_rate

FROM credit_applications;

-- KPI 2: Payment Outcome Distribution

SELECT
    risk_outcome,
    COUNT(*) AS customer_count,

    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_customers

FROM credit_applications

GROUP BY risk_outcome

ORDER BY customer_count DESC;

-- KPI 3: Average Loan Amount by Payment Outcome

SELECT
    risk_outcome,

    COUNT(*) AS customer_count,

    ROUND(AVG(loan_amount), 2) AS average_loan_amount,

    ROUND(AVG(annual_income), 2) AS average_annual_income,

    ROUND(AVG(loan_to_income), 2) AS average_loan_to_income

FROM credit_applications

GROUP BY risk_outcome

ORDER BY average_loan_amount DESC;

/*
=========================================================
SECTION 3: CUSTOMER RISK SEGMENTATION
=========================================================
*/

-- Analysis 1: Payment Difficulty by Income Group

SELECT
    income_group,

    COUNT(*) AS customer_count,

    SUM(payment_difficulty) AS payment_difficulty_count,

    ROUND(
        100.0 * SUM(payment_difficulty) / COUNT(*),
        2
    ) AS payment_difficulty_rate

FROM credit_applications

GROUP BY income_group

ORDER BY
    CASE income_group
        WHEN 'Very Low' THEN 1
        WHEN 'Low' THEN 2
        WHEN 'Medium' THEN 3
        WHEN 'High' THEN 4
        WHEN 'Very High' THEN 5
    END;

    -- Analysis 2: Payment Difficulty by Age Group

SELECT
    age_group,

    COUNT(*) AS customer_count,

    SUM(payment_difficulty) AS payment_difficulty_count,

    ROUND(
        100.0 * SUM(payment_difficulty) / COUNT(*),
        2
    ) AS payment_difficulty_rate

FROM credit_applications

GROUP BY age_group

ORDER BY
    CASE age_group
        WHEN '18-25' THEN 1
        WHEN '26-35' THEN 2
        WHEN '36-45' THEN 3
        WHEN '46-55' THEN 4
        WHEN '56+' THEN 5
    END;

    -- Analysis 3: Payment Difficulty by Contract Type

SELECT
    contract_type,

    COUNT(*) AS customer_count,

    SUM(payment_difficulty) AS payment_difficulty_count,

    ROUND(
        100.0 * SUM(payment_difficulty) / COUNT(*),
        2
    ) AS payment_difficulty_rate

FROM credit_applications

GROUP BY contract_type

ORDER BY payment_difficulty_rate DESC;

-- Analysis 4: Payment Difficulty by Education

SELECT
    education_type,

    COUNT(*) AS customer_count,

    SUM(payment_difficulty) AS payment_difficulty_count,

    ROUND(
        100.0 * SUM(payment_difficulty) / COUNT(*),
        2
    ) AS payment_difficulty_rate

FROM credit_applications

GROUP BY education_type

ORDER BY payment_difficulty_rate DESC;

-- Analysis 5: Income Group + Contract Type

SELECT
    income_group,
    contract_type,

    COUNT(*) AS customer_count,

    SUM(payment_difficulty) AS payment_difficulty_count,

    ROUND(
        100.0 * SUM(payment_difficulty) / COUNT(*),
        2
    ) AS payment_difficulty_rate

FROM credit_applications

GROUP BY
    income_group,
    contract_type

ORDER BY
    income_group,
    payment_difficulty_rate DESC;

    -- Analysis 6: Income + Contract Type
-- Minimum segment size = 1,000 customers

SELECT
    income_group,
    contract_type,

    COUNT(*) AS customer_count,

    SUM(payment_difficulty) AS payment_difficulty_count,

    ROUND(
        100.0 * SUM(payment_difficulty) / COUNT(*),
        2
    ) AS payment_difficulty_rate

FROM credit_applications

GROUP BY
    income_group,
    contract_type

HAVING COUNT(*) >= 1000

ORDER BY payment_difficulty_rate DESC;

/*
=========================================================
SECTION 4: FINANCIAL RISK & LOAN EXPOSURE
=========================================================
*/

-- Analysis 1: Payment Difficulty by Loan-to-Income Band

SELECT
    CASE
        WHEN loan_to_income < 2 THEN '<2x'
        WHEN loan_to_income < 4 THEN '2x-4x'
        WHEN loan_to_income < 6 THEN '4x-6x'
        WHEN loan_to_income < 8 THEN '6x-8x'
        ELSE '8x+'
    END AS loan_to_income_band,

    COUNT(*) AS customer_count,

    SUM(payment_difficulty) AS payment_difficulty_count,

    ROUND(
        100.0 * SUM(payment_difficulty) / COUNT(*),
        2
    ) AS payment_difficulty_rate,

    ROUND(
        AVG(loan_amount),
        2
    ) AS average_loan_amount

FROM credit_applications

GROUP BY
    CASE
        WHEN loan_to_income < 2 THEN '<2x'
        WHEN loan_to_income < 4 THEN '2x-4x'
        WHEN loan_to_income < 6 THEN '4x-6x'
        WHEN loan_to_income < 8 THEN '6x-8x'
        ELSE '8x+'
    END

ORDER BY
    CASE
        WHEN loan_to_income < 2 THEN 1
        WHEN loan_to_income < 4 THEN 2
        WHEN loan_to_income < 6 THEN 3
        WHEN loan_to_income < 8 THEN 4
        ELSE 5
    END;

    -- Analysis 2: Payment Difficulty by Loan Amount

SELECT
    CASE
        WHEN loan_amount < 250000 THEN '<250K'
        WHEN loan_amount < 500000 THEN '250K-500K'
        WHEN loan_amount < 1000000 THEN '500K-1M'
        WHEN loan_amount < 2000000 THEN '1M-2M'
        ELSE '2M+'
    END AS loan_amount_band,

    COUNT(*) AS customer_count,

    SUM(payment_difficulty) AS payment_difficulty_count,

    ROUND(
        100.0 * SUM(payment_difficulty) / COUNT(*),
        2
    ) AS payment_difficulty_rate,

    ROUND(
        AVG(loan_to_income),
        2
    ) AS average_loan_to_income

FROM credit_applications

GROUP BY
    CASE
        WHEN loan_amount < 250000 THEN '<250K'
        WHEN loan_amount < 500000 THEN '250K-500K'
        WHEN loan_amount < 1000000 THEN '500K-1M'
        WHEN loan_amount < 2000000 THEN '1M-2M'
        ELSE '2M+'
    END

ORDER BY
    payment_difficulty_rate DESC;

    -- Analysis 3: Payment Difficulty by Annual Income Band

SELECT
    CASE
        WHEN annual_income < 100000 THEN '<100K'
        WHEN annual_income < 200000 THEN '100K-200K'
        WHEN annual_income < 500000 THEN '200K-500K'
        WHEN annual_income < 1000000 THEN '500K-1M'
        ELSE '1M+'
    END AS income_band,

    COUNT(*) AS customer_count,

    SUM(payment_difficulty) AS payment_difficulty_count,

    ROUND(
        100.0 * SUM(payment_difficulty) / COUNT(*),
        2
    ) AS payment_difficulty_rate,

    ROUND(
        AVG(loan_amount),
        2
    ) AS average_loan_amount

FROM credit_applications

GROUP BY
    CASE
        WHEN annual_income < 100000 THEN '<100K'
        WHEN annual_income < 200000 THEN '100K-200K'
        WHEN annual_income < 500000 THEN '200K-500K'
        WHEN annual_income < 1000000 THEN '500K-1M'
        ELSE '1M+'
    END

ORDER BY payment_difficulty_rate DESC;


-- Analysis 6: External Score Data Availability

SELECT
    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN external_score_2 IS NOT NULL THEN 1
            ELSE 0
        END
    ) AS score_2_available,

    SUM(
        CASE
            WHEN external_score_2 IS NULL THEN 1
            ELSE 0
        END
    ) AS score_2_missing,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN external_score_2 IS NULL THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS score_2_missing_rate

FROM credit_applications;

-- Analysis 7: Income Group and Loan-to-Income Risk

SELECT
    income_group,

    CASE
        WHEN loan_to_income < 2 THEN '<2x'
        WHEN loan_to_income < 4 THEN '2x-4x'
        WHEN loan_to_income < 6 THEN '4x-6x'
        WHEN loan_to_income < 8 THEN '6x-8x'
        ELSE '8x+'
    END AS loan_to_income_band,

    COUNT(*) AS customer_count,

    SUM(payment_difficulty) AS payment_difficulty_count,

    ROUND(
        100.0 * SUM(payment_difficulty) / COUNT(*),
        2
    ) AS payment_difficulty_rate

FROM credit_applications

GROUP BY
    income_group,

    CASE
        WHEN loan_to_income < 2 THEN '<2x'
        WHEN loan_to_income < 4 THEN '2x-4x'
        WHEN loan_to_income < 6 THEN '4x-6x'
        WHEN loan_to_income < 8 THEN '6x-8x'
        ELSE '8x+'
    END

HAVING COUNT(*) >= 500

ORDER BY
    payment_difficulty_rate DESC;

    /*
=========================================================
SECTION 5: PREVIOUS APPLICATION HISTORY
=========================================================
*/

-- Query 1: Previous Application Status Distribution

SELECT
    contract_status,
    COUNT(*) AS application_count,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_applications
FROM previous_applications
GROUP BY contract_status
ORDER BY application_count DESC;

-- Query 2: Previous Applications per Customer

SELECT
    customer_id,
    COUNT(*) AS previous_application_count,

    SUM(
        CASE
            WHEN contract_status = 'Approved'
            THEN 1
            ELSE 0
        END
    ) AS approved_previous_count,

    SUM(
        CASE
            WHEN contract_status = 'Refused'
            THEN 1
            ELSE 0
        END
    ) AS refused_previous_count

FROM previous_applications
GROUP BY customer_id
ORDER BY previous_application_count DESC
LIMIT 20;

-- Query 3: Previous Approval Rate

SELECT
    customer_id,

    COUNT(*) AS previous_application_count,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN contract_status = 'Approved'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS previous_approval_rate

FROM previous_applications

GROUP BY customer_id

HAVING COUNT(*) >= 2

ORDER BY previous_approval_rate DESC

LIMIT 20;

-- Query 4: Previous Application History vs Current Payment Difficulty

WITH previous_history AS (

    SELECT
        customer_id,

        COUNT(*) AS previous_application_count,

        SUM(
            CASE
                WHEN contract_status = 'Approved'
                THEN 1
                ELSE 0
            END
        ) AS approved_previous_count,

        SUM(
            CASE
                WHEN contract_status = 'Refused'
                THEN 1
                ELSE 0
            END
        ) AS refused_previous_count

    FROM previous_applications

    GROUP BY customer_id
)

SELECT

    CASE
        WHEN COALESCE(previous_application_count, 0) = 0
            THEN 'No Previous Application'

        WHEN previous_application_count = 1
            THEN '1 Previous Application'

        WHEN previous_application_count BETWEEN 2 AND 4
            THEN '2-4 Previous Applications'

        ELSE '5+ Previous Applications'
    END AS previous_history_group,

    COUNT(*) AS customer_count,

    SUM(c.payment_difficulty) AS payment_difficulty_count,

    ROUND(
        100.0 *
        SUM(c.payment_difficulty) /
        COUNT(*),
        2
    ) AS payment_difficulty_rate

FROM credit_applications c

LEFT JOIN previous_history p
    ON c.customer_id = p.customer_id

GROUP BY

    CASE
        WHEN COALESCE(previous_application_count, 0) = 0
            THEN 'No Previous Application'

        WHEN previous_application_count = 1
            THEN '1 Previous Application'

        WHEN previous_application_count BETWEEN 2 AND 4
            THEN '2-4 Previous Applications'

        ELSE '5+ Previous Applications'
    END

ORDER BY payment_difficulty_rate DESC;

-- Query 5: Previous Refusals vs Current Payment Difficulty

WITH previous_history AS (

    SELECT
        customer_id,

        SUM(
            CASE
                WHEN contract_status = 'Refused'
                THEN 1
                ELSE 0
            END
        ) AS refused_previous_count

    FROM previous_applications

    GROUP BY customer_id
)

SELECT

    CASE
        WHEN COALESCE(refused_previous_count, 0) = 0
            THEN 'No Previous Refusals'

        WHEN refused_previous_count = 1
            THEN '1 Previous Refusal'

        WHEN refused_previous_count BETWEEN 2 AND 3
            THEN '2-3 Previous Refusals'

        ELSE '4+ Previous Refusals'
    END AS refusal_history_group,

    COUNT(*) AS customer_count,

    SUM(c.payment_difficulty) AS payment_difficulty_count,

    ROUND(
        100.0 *
        SUM(c.payment_difficulty) /
        COUNT(*),
        2
    ) AS payment_difficulty_rate

FROM credit_applications c

LEFT JOIN previous_history p
    ON c.customer_id = p.customer_id

GROUP BY

    CASE
        WHEN COALESCE(refused_previous_count, 0) = 0
            THEN 'No Previous Refusals'

        WHEN refused_previous_count = 1
            THEN '1 Previous Refusal'

        WHEN refused_previous_count BETWEEN 2 AND 3
            THEN '2-3 Previous Refusals'

        ELSE '4+ Previous Refusals'
    END

ORDER BY payment_difficulty_rate DESC;

/*
=========================================================
SECTION 6: CUSTOMER RISK SUMMARY
=========================================================
*/

