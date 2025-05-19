# Cowrywise_Assesment
📌 Per-Question Explanations:

## 1. Total Deposits per Customer
Scenario: Summarise total deposits per user, including how many savings and plan accounts each customer holds.

Approach:

Join users_customuser, savings_savingsaccount, and plans_plan.

Use COUNT(DISTINCT S.id) to count unique savings accounts.

Use COUNT(DISTINCT P.id) to count unique plans linked to users.

Calculate SUM(P.amount + S.new_balance) to compute total deposits per customer.

Group results by user using owner_id and concatenated full_name.


## 2. Customer Transaction Frequency Segmentation
Scenario: Segment users based on how frequently they transact.

Approach:

Use confirmed_amount in savings_savingsaccount to count valid transactions.

Use DATE_FORMAT(transaction_date, '%Y-%m') to get distinct active months.

Compute average transactions per month.

Classify frequency levels:

High: ≥10/month

Medium: 3–9/month

Low: ≤2/month

Output grouped summary.


## 3. Inactive Account Identification
Scenario: Identify savings or investment accounts with no inflow for over 365 days.

Approach:

Use last_charge_date from plans_plan and transaction_date from savings_savingsaccount.

Get the most recent inflow per account using MAX(transaction_date).

Filter where the last inflow is over 365 days ago.

Include owner_id, plan_id, type, last_transaction_date, and inactivity_days.



## 4. Customer Lifetime Value (CLV) Estimation
Scenario: Estimate CLV based on account tenure and transaction volume.

Approach:

Calculate account tenure as months between created_on and current date.

Count all inflow transactions (where confirmed_amount > 0).

Compute average profit per transaction: 0.1% of confirmed_amount (converted to Naira).

CLV Formula:
CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_transaction

Order by estimated_clv descending to identify top customers.


## ⚠️ Challenges & Resolutions
| Challenge                                                         | Resolution                                                                                       |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| **Date & interval calculation**                                   | Used `TIMESTAMPDIFF` and `CURDATE()` to ensure accurate month or day computations across tables. |
| **Handling zero division (CLV tenure)**                           | Used `NULLIF(..., 0)` to avoid division by zero in tenure calculations.                          |
| **Joining different time-based records (e.g., savings vs. plan)** | Used proper `JOIN` strategies and `GROUP BY` logic to ensure customer-level aggregation.         |
| **Amount fields in Kobo**                                         | Consistently divided monetary values by 100 to normalize to Naira before calculations.           |
