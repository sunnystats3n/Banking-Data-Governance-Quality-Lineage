# Banking Data Governance, Quality & Lineage — Portfolio Project

## Portfolio status
**Design / practice artifact.** The Microsoft Purview implementation is intentionally not executed because the original Azure Student subscription is disabled and there is no paid Azure budget.

## What this project proves
- Data-quality analysis with SQL across synthetic banking data
- RAW → STAGING → CURATED → REPORTING lifecycle thinking
- Business glossary and critical-data-element design
- Data ownership and stewardship RACI
- Data-quality rules, thresholds, issue management and monitoring concepts
- Source-to-report lineage design
- A Purview-aligned governance model without claiming live Purview execution

## Dataset
- customers.csv — 200 records
- accounts.csv — 400 records
- transactions.csv — 1,200 records
- branches.csv — 20 records

All data is synthetic. No real customer information is used.

## DQ controls assessed
- DQ-001 Completeness
- DQ-002 Uniqueness
- DQ-003 Validity
- DQ-004 Referential integrity
- DQ-005 Consistency
- DQ-006 Timeliness
- DQ-007 Accuracy / reconciliation (design only; no independent source of truth supplied)

## Assessment timestamp
2026-10-02 12:00:00

## Key results from supplied CSVs
- 21 DQ tests executed
- 4 tests passed; 17 failed
- Customer ID: 2 missing postal codes; 1 duplicate customer ID
- Account customer reference: 1 blank + 1 non-existent customer ID
- Account branch reference: 1 non-existent branch ID
- Transaction ID: 1 duplicate
- Invalid customer/account statuses, future DOB, invalid transaction type and negative transaction amount: 5 validity exceptions
- 1 populated transaction/account currency mismatch
- Illustrative 24-hour freshness SLA: 126/200 customers and 250/400 accounts were stale as of 2026-10-02 12:00:00

## Purview-aligned design objects
- Governance domain: Retail Banking Data
- Data products: Customer & Account Data; Transaction Data; Retail Banking Reporting
- Data assets: raw files, staging tables, curated tables and reporting dataset
- Glossary: Customer, Customer ID, Bank Account, Account Balance, Transaction, Transaction Amount, Branch
- CDE candidates: customer_id, account_id, transaction_id, current_balance, transaction amount
- Classifications: personal data and financial data, subject to organizational policy
- Designed lineage: RAW → STAGING → CURATED → REPORTING

See `banking_purview_design_artifact.drawio` for the editable architecture diagram and `banking_governance_scorecard.xlsx` for computed DQ results and the stewardship RACI.
