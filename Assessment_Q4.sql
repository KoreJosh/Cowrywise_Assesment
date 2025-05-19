SELECT
    C.id AS customer_id,
    CONCAT(C.first_name, ' ', C.last_name) AS name,
    TIMESTAMPDIFF(MONTH, C.created_on, CURDATE()) AS tenure_months,
    COUNT(S.id) AS total_transactions,
    
    ROUND(
        (
            COUNT(S.id) / NULLIF(TIMESTAMPDIFF(MONTH, C.created_on, CURDATE()), 0)
        ) * 12 *
        AVG((S.confirmed_amount / 100) * 0.001),
        2
    ) AS estimated_clv

FROM users_customuser C
JOIN savings_savingsaccount S 
    ON C.id = S.owner_id
WHERE S.confirmed_amount > 0  -- considing only inflow transactions
GROUP BY C.id, name, tenure_months
ORDER BY estimated_clv DESC;
