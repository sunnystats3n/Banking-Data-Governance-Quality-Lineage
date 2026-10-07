-- Banking Data Governance Portfolio Project
-- Assessment timestamp: 2026-10-02 12:00:00

-- DQ-001 Completeness
SELECT COUNT(*) - COUNT(customer_id) AS missing_customer_id FROM customers;
SELECT COUNT(*) - COUNT(NULLIF(TRIM(postal_code),'')) AS missing_postal_code FROM customers;
SELECT COUNT(*) - COUNT(NULLIF(TRIM(customer_id),'')) AS missing_account_customer_id FROM accounts;
SELECT COUNT(*) - COUNT(NULLIF(TRIM(account_type),'')) AS missing_account_type FROM accounts;
SELECT COUNT(*) - COUNT(NULLIF(TRIM(currency),'')) AS missing_transaction_currency FROM transactions;

-- DQ-002 Uniqueness
SELECT customer_id, COUNT(*) AS n FROM customers GROUP BY customer_id HAVING COUNT(*) > 1;
SELECT account_id, COUNT(*) AS n FROM accounts GROUP BY account_id HAVING COUNT(*) > 1;
SELECT transaction_id, COUNT(*) AS n FROM transactions GROUP BY transaction_id HAVING COUNT(*) > 1;
SELECT branch_id, COUNT(*) AS n FROM branches GROUP BY branch_id HAVING COUNT(*) > 1;

-- DQ-003 Validity
SELECT customer_id, customer_status FROM customers WHERE customer_status NOT IN ('ACTIVE','INACTIVE');
SELECT customer_id, date_of_birth FROM customers WHERE date_of_birth > '2026-10-02';
SELECT account_id, account_status FROM accounts WHERE account_status NOT IN ('ACTIVE','CLOSED','SUSPENDED');
SELECT transaction_id, transaction_type FROM transactions WHERE transaction_type NOT IN ('PURCHASE','PAYMENT','WITHDRAWAL','DEPOSIT','FEE','TRANSFER');
SELECT transaction_id, amount FROM transactions WHERE CAST(amount AS REAL) <= 0;

-- DQ-004 Referential integrity
SELECT a.account_id, a.customer_id
FROM accounts a LEFT JOIN customers c ON a.customer_id=c.customer_id
WHERE TRIM(COALESCE(a.customer_id,''))='' OR c.customer_id IS NULL;

SELECT a.account_id, a.branch_id
FROM accounts a LEFT JOIN branches b ON a.branch_id=b.branch_id
WHERE b.branch_id IS NULL;

SELECT t.transaction_id, t.account_id
FROM transactions t LEFT JOIN accounts a ON t.account_id=a.account_id
WHERE a.account_id IS NULL;

-- DQ-005 Consistency
SELECT t.transaction_id, t.account_id, t.currency, a.currency AS account_currency
FROM transactions t JOIN accounts a ON t.account_id=a.account_id
WHERE TRIM(COALESCE(t.currency,'')) <> ''
  AND TRIM(COALESCE(a.currency,'')) <> ''
  AND t.currency <> a.currency;

SELECT COUNT(*)
FROM accounts
WHERE (account_type='CREDIT_CARD' AND (credit_limit IS NULL OR TRIM(credit_limit)=''))
   OR (account_type<>'CREDIT_CARD' AND TRIM(COALESCE(credit_limit,''))<>'');

-- DQ-006 Timeliness: illustrative 24-hour master-data freshness SLA.
SELECT COUNT(*) FROM customers
WHERE last_updated < datetime('2026-10-02 12:00:00','-24 hours');

SELECT COUNT(*) FROM accounts
WHERE last_updated < datetime('2026-10-02 12:00:00','-24 hours');
