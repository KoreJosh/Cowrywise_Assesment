WITH user_tx_counts AS (
    SELECT
        S.owner_id,
        COUNT(*) AS total_transactions,
        ROUND(COUNT(*) / 104.0, 2) AS avg_tx_per_month  -- Fixed to 104 months
    FROM adashi_staging.users_customuser C
    JOIN savings_savingsaccount S ON S.owner_id = C.id
    WHERE C.created_on BETWEEN '2016-08-01' AND '2025-04-30'
    GROUP BY S.owner_id
),
categorized_users AS (
    SELECT
        owner_id,
        avg_tx_per_month,
        CASE 
            WHEN avg_tx_per_month >= 10 THEN 'High Frequency'
            WHEN avg_tx_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM user_tx_counts
)
SELECT
    frequency_category,
    COUNT(owner_id) AS customer_count,
    ROUND(AVG(avg_tx_per_month), 1) AS avg_transactions_per_month
FROM categorized_users
GROUP BY frequency_category
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
