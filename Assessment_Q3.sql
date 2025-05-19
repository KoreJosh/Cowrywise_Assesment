SELECT
    P.id AS plan_id,
    P.owner_id,
    'Savings' AS type, 
    MAX(S.transaction_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(S.transaction_date)) AS inactivity_days
FROM plans_plan P
LEFT JOIN savings_savingsaccount S 
    ON P.id = S.plan_id
WHERE P.status_id = 1  -- Only active plans
GROUP BY P.id, P.owner_id
HAVING 
    MAX(S.transaction_date) IS NOT NULL AND
    DATEDIFF(CURDATE(), MAX(S.transaction_date)) > 365;
