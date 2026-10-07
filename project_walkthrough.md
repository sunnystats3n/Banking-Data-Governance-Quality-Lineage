# Banking Data Governance, Quality & Lineage — Simple Project Walkthrough

## 1. What problem does this project solve?

A bank has customer, account, transaction and branch data. Before the bank uses the data for reporting and analytics, governance needs to answer:

- What data do we have?
- What does each field mean?
- Which data is critical?
- Can we trust the data?
- Who owns it?
- Who fixes quality problems?
- Where did a reported number come from?
- What downstream reports would be affected if a source field changed?

This project demonstrates how to answer those questions with a combination of SQL-based data-quality work and a governance design aligned to Microsoft Purview.

## 2. The data

Synthetic data only:

- customers.csv — 200 rows
- accounts.csv — 400 rows
- transactions.csv — 1,200 rows
- branches.csv — 20 rows

## 3. The data lifecycle

### RAW
The source files are preserved as received. RAW is about preservation and traceability, not fixing the data.

### STAGING
The source data is loaded into SQL tables so it can be queried, profiled and processed. Staging can still contain errors.

### DQ / TRANSFORM
Business rules are tested with SQL. Exceptions are quantified and investigated. Approved standardization/remediation logic is applied.

### CURATED
The curated layer is the business-ready representation used for governed downstream consumption. The raw source is not overwritten.

### REPORTING
Approved curated data feeds a reporting/BI output.

## 4. Data quality controls

- DQ-001 Completeness — required values are populated.
- DQ-002 Uniqueness — identifiers are not duplicated where uniqueness is required.
- DQ-003 Validity — values obey approved domains, ranges or formats.
- DQ-004 Referential integrity — relationships between tables point to valid records.
- DQ-005 Consistency — related fields/tables agree when they should.
- DQ-006 Timeliness — data is refreshed within an approved freshness SLA.
- DQ-007 Accuracy/reconciliation — values reconcile to a trusted reference or control total when one exists.

## 5. Governance layer

The project is mapped to Microsoft Purview concepts without claiming live Purview execution:

- Governance domain — Retail Banking Data
- Data products — Customer & Account Data, Transaction Data, Retail Banking Reporting
- Business glossary — Customer, Customer ID, Account, Account Balance, Transaction, Transaction Amount, Branch
- Candidate CDEs — customer_id, account_id, transaction_id, current_balance, transaction amount
- Classifications — personal/PII and financial/confidential, subject to organizational policy
- Ownership/stewardship — Data Owner, Data Steward, DQ Analyst, Data Engineer, Data Product Owner, Security/Privacy
- Lineage — RAW → STAGING → DQ/TRANSFORM → CURATED → REPORTING

Microsoft Purview defines Data Map as the technical metadata layer and Unified Catalog as the business/governance experience. Governance domains contain concepts such as data products, glossary terms and critical data elements. Purview describes lineage as how data transforms and flows from origin to destination, supporting troubleshooting and impact analysis. See Microsoft Learn sources in the project README.

## 6. Actual data-quality evidence

The supplied CSVs were tested with SQL. Summary:

- 21 DQ controls executed
- 4 passed
- 17 failed
- 200 customers, 400 accounts, 1,200 transactions, 20 branches

Key findings:

- Completeness: missing postal codes, a missing account customer reference, a missing account type, and a missing transaction currency.
- Uniqueness: one duplicate customer ID and one duplicate transaction ID.
- Validity: invalid status values, a future DOB, an invalid transaction type, and a negative amount.
- Referential integrity: an account without a valid customer, an account with an invalid branch, and a transaction without a valid account.
- Consistency: one populated transaction/account currency mismatch.
- Timeliness: under the illustrative 24-hour freshness assumption, 126/200 customers and 250/400 accounts were stale at the assessment timestamp.

The timeliness SLA is explicitly an illustrative sandbox assumption; a real organization would approve the SLA and threshold.

## 7. The lineage story

The project's primary lineage is:

RAW source file → STAGING SQL table → DQ/TRANSFORM process → CURATED SQL table → REPORTING/BI output

The point of lineage is not simply to draw arrows. It lets a governance professional answer:

- Where did this number originate?
- What transformations were applied?
- Which curated asset depends on this source field?
- Which report would be affected by a change?
- Who owns the affected asset?

Because the banking implementation was not executed in Azure/Purview, this is documented design lineage rather than live-captured Purview lineage.
