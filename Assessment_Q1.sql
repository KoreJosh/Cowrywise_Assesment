SELECT 
    S.owner_id,
    CONCAT(C.first_name, ' ', C.last_name) AS full_name,
    COUNT(DISTINCT S.id) AS savings_count,
    COUNT(DISTINCT P.id) AS plans_count,
    SUM(P.amount + S.new_balance) AS total_deposit
FROM adashi_staging.users_customuser C
JOIN savings_savingsaccount S
    ON S.owner_id = C.id
JOIN plans_plan P
    ON S.plan_id = P.id
GROUP BY S.owner_id, full_name;


