# Credit Risk Analytics

### Customer Payment Difficulty & Credit Exposure Analysis

A finance-domain Data Analytics project using Python, PostgreSQL, SQL, and Power BI to analyze customer payment difficulty, loan exposure, financial burden, and previous credit application history.

---

## 📊 Project Overview

This project analyzes historical consumer finance application data to understand which customer and loan characteristics are associated with payment difficulties.

The analysis focuses on customer demographics, income, loan characteristics, loan-to-income burden, external risk indicators, and previous credit application history.

The project follows an end-to-end Data Analyst workflow:

**Data Understanding → Data Cleaning → Feature Engineering → SQL Analysis → KPI Development → Power BI Dashboard → Business Insights**

## 🎯 Business Problem

A consumer finance company wants to understand where payment-difficulty risk is concentrated across its customer portfolio.

The Credit Risk Manager wants answers to questions such as:

- What proportion of customers experience payment difficulty?
- Which income groups show different payment-difficulty rates?
- How does loan burden relate to payment difficulty?
- How do age, education, and income type vary across risk outcomes?
- How do external risk indicators relate to payment difficulty?
- Does previous credit application history show differences in current payment outcomes?
- Where is the company's loan exposure concentrated?

### Business Objective

Identify meaningful patterns in customer and loan characteristics that can support credit-risk monitoring and portfolio analysis.

## 📂 Dataset

The project uses the **Home Credit Default Risk** dataset.

The primary datasets used are:

### 1. application_data.csv

Contains information about current customer loan applications, including:

- Customer information
- Income
- Credit amount
- Annuity
- Demographics
- Employment
- Education
- Housing
- External risk indicators
- Payment difficulty target

### 2. previous_application.csv

Contains historical credit applications associated with customers, including:

- Previous application status
- Previous credit amounts
- Previous contract information
- Historical approval/refusal information

### 3. columns_description.csv

Provides descriptions of the dataset variables.

### Target Variable

`TARGET`

| Value | Meaning |
|---|---|
| `0` | No payment difficulty |
| `1` | Payment difficulty |

## ⚠️ Analytical Scope

This project is primarily **descriptive and diagnostic analytics**.

The analysis identifies associations and patterns in historical data. It does not claim that a particular customer characteristic directly causes payment difficulty.

For example:

> "Payment-difficulty rates vary across income groups."

is an appropriate interpretation.

A causal statement such as:

> "Low income causes payment default."

is not supported by this analysis.

Predictive modeling could be added as a separate future phase.

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Python | Data cleaning, transformation and exploratory analysis |
| Pandas | Data manipulation |
| NumPy | Numerical operations |
| Matplotlib | Data visualization |
| Seaborn | Statistical visualization |
| PostgreSQL | Relational database and SQL analysis |
| SQL | KPI calculation and business analysis |
| Power BI | Interactive dashboard and visualization |
| Git/GitHub | Version control and portfolio management |


## 🔄 Project Workflow

```text
Raw CSV Data
     │
     ▼
Python / Pandas
     │
     ├── Data Understanding
     ├── Data Quality Checks
     ├── Cleaning
     └── Feature Engineering
     │
     ▼
Processed Dataset
     │
     ├───────────────┐
     ▼               ▼
PostgreSQL        Power BI
     │               │
     ├── SQL         ├── KPI Dashboard
     ├── Segmentation├── Risk Analysis
     ├── KPIs        ├── Credit Exposure
     └── Risk Analysis└── Historical Credit Analysis
     │
     ▼
Business Insights


---

# 38.9 — Python Analysis

Add:

```markdown
## 🐍 Python Analysis

Python was used for:

- Dataset exploration
- Missing-value analysis
- Duplicate detection
- Data cleaning
- Feature engineering
- Risk segmentation
- Exploratory data analysis
- Visualization

### Key engineered features

#### Age

```text
age_years = -DAYS_BIRTH / 365.25


---

# 38.10 — Data Cleaning

Add:

```markdown
## 🧹 Data Cleaning

The following data-quality steps were performed:

- Checked dataset dimensions and data types
- Examined missing values
- Checked for duplicate records
- Replaced the special `DAYS_EMPLOYED = 365243` value with missing data
- Created business-friendly age and employment measures
- Created loan-to-income and annuity-to-income ratios
- Created income and age segments
- Retained useful external risk indicators despite missing values
- Created explicit missingness indicators for external scores

## 🗄️ SQL Analysis

PostgreSQL was used to perform structured business analysis and validate the dashboard metrics.

The SQL analysis includes:

- Portfolio-level KPIs
- Payment-difficulty rates
- Customer segmentation
- Income analysis
- Age analysis
- Education analysis
- Loan-to-income segmentation
- Loan exposure analysis
- External score analysis
- Previous credit history analysis
- Data-quality validation

### SQL techniques demonstrated

- `SELECT`
- `WHERE`
- `GROUP BY`
- `HAVING`
- `CASE`
- Aggregate functions
- Common Table Expressions (CTEs)
- Window functions
- `RANK()`
- Conditional aggregation

## 📊 Power BI Dashboard

The Power BI dashboard contains four analytical pages.

### Page 1 — Executive Overview

Provides a high-level view of the credit portfolio.

Key KPIs:

- Total Customers
- Payment Difficulty Customers
- Risk Rate
- Total Loan Exposure
- Average Loan Amount
- Average Loan-to-Income

Key visuals:

- Risk by Income Group
- Risk by Age Group
- Risk by Loan Burden
- Previous Credit History vs Risk

---

### Page 2 — Customer Risk Segmentation

Analyzes payment-difficulty rates across customer characteristics.

Includes:

- Education
- Income Group
- Occupation
- Gender
- Contract Type

---

### Page 3 — Financial & Credit Exposure

Analyzes financial exposure and customer loan burden.

Includes:

- Loan-to-income burden
- Loan amount groups
- External Score 2
- External Score 3
- Income vs Loan Exposure

---

### Page 4 — Previous Credit History & Risk Drivers

Analyzes historical credit application behavior.

Includes:

- Previous application history
- Previous approval rate
- Previous refusal rate
- Previous refusal counts
- External risk indicators

## 📸 Dashboard Preview

### Executive Overview

![Credit Risk Executive Dashboard](dashboard/executive_overview.png)

### Customer Risk Segmentation

![Customer Risk Segmentation](dashboard/customer_risk_segmentation.png)

### Financial & Credit Exposure

![Financial and Credit Exposure](dashboard/financial_credit_exposure.png)

### Previous Credit History & Risk Drivers

![Previous Credit History](dashboard/previous_credit_history.png)