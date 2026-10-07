# Banking Data Governance, Quality & Lineage

## Portfolio status
**Design / practice artifact.** The banking project was built from synthetic data and SQL. The Microsoft Purview portion is a **design-aligned artifact, not a live Purview implementation**, because the Azure environment became unavailable after the Azure for Students credits were exhausted.

This distinction is intentional: the repository does not claim platform execution that did not occur.

## Objective
Demonstrate how a Data Governance / Data Steward / Data Quality Analyst can govern a banking data estate from source to reporting:

**RAW → STAGING → DQ / TRANSFORM → CURATED → REPORTING**

The governance layer is designed around concepts that map naturally to Microsoft Purview Data Map and Unified Catalog:

- Governance domain: **Retail Banking Data**
- Data products: **Customer & Account Data**, **Transaction Data**, **Retail Banking Reporting**
- Business glossary: Customer, Customer ID, Account, Account Balance, Transaction, Transaction Amount, Branch
- Candidate CDEs: customer_id, account_id, transaction_id, current_balance, transaction amount
- Classifications: personal/PII and financial/confidential, subject to organizational policy
- Stewardship: Data Owner, Data Steward, DQ Analyst, Data Engineer, Data Product Owner, Security/Privacy
- Lineage: **RAW → STAGING → DQ / TRANSFORM → CURATED → REPORTING**

## Dataset
All data is synthetic. No real customer information is used.

| File | Records |
|---|---:| 
| customers.csv | 200 |
| accounts.csv | 400 |
| transactions.csv | 1,200 |
| branches.csv | 20 |

The data intentionally contains controlled DQ defects so that the project demonstrates detection and investigation rather than only a clean demo.

## Data-quality framework

| ID | Dimension | Example control |
|---        |---           |---                                   |
| DQ-001    | Completeness | Required data elements are populated |
| DQ-002    | Uniqueness   | Identifier values are unique where required |
| DQ-003    | Validity     | Values conform to approved domains/ranges |
| DQ-004    | Referential integrity | Foreign keys resolve to valid parent records |
| DQ-005    | Consistency   | Related values agree across tables |
| DQ-006    | Timeliness   | Data is refreshed within an approved SLA |
| DQ-007    | Accuracy / reconciliation | Values reconcile to an independent trusted reference where available |

## Actual assessment
The supplied CSVs were tested with 21 SQL controls.

- 21 controls executed
- 4 passed
- 17 failed
- Customer IDs: 0 missing; 1 duplicate
- Postal codes: 2 missing customer values
- Account customer reference: 1 blank + 1 non-existent customer ID
- Account branch reference: 1 non-existent branch ID
- Transaction ID: 1 duplicate
- Validity: invalid status values, future DOB, invalid transaction type and negative amount
- Consistency: 1 populated transaction/account currency mismatch
- Timeliness: using an **illustrative** 24-hour freshness assumption, 126/200 customers and 250/400 accounts were stale at the assessment timestamp

The scorecard deliberately does **not** call 4/21 a formal enterprise "data quality score" because real organizations should weight controls based on business criticality, approved thresholds and impact.

## Repository structure

```text
.
├── README.md
├── scripts_load_to_sqlite.py
├── data/
│   └── raw/
│       ├── customers.csv
│       ├── accounts.csv
│       ├── transactions.csv
│       └── branches.csv
├── sql/
│   └── dq_controls.sql
├── governance/
│   └── dq_scorecard_and_raci.xlsx
├── design/
│   ├── banking_data_governance_lineage_design.drawio
│   ├── banking_data_governance_lineage_design.png
│   ├── purview_governance_model.drawio
│   └── purview_governance_model.png
└── docs/
    ├── data_dictionary.md
    ├── dq_register.md
    ├── project_walkthrough.md
    ├── interview_questions.md
    └── original_project_readme.md
```

## Lineage

```text
Source / RAW
    ↓
STAGING (SQL)
    ↓
DQ / TRANSFORM
    ↓
CURATED (SQL)
    ↓
REPORTING / BI
```

The lineage is documented as the target architecture. Live Purview lineage was not captured because the Azure environment was unavailable.

## How to reproduce the SQL work
1. Clone/download this repository.
2. Run `python scripts_load_to_sqlite.py`.
3. Open `banking_governance.sqlite` in SQLite/DB Browser for SQLite.
4. Run `sql/dq_controls.sql` against the four loaded tables.
5. Compare the results with `governance/dq_scorecard_and_raci.xlsx`.

## Why this project matters for Data Governance
This project demonstrates:

- translating business rules into measurable DQ controls;
- profiling and investigating data rather than blindly cleaning it;
- distinguishing Data Owner, Data Steward, DQ Analyst and Data Engineer responsibilities;
- identifying candidate CDEs based on business criticality;
- understanding RAW vs STAGING vs CURATED layers;
- documenting source-to-report lineage and impact analysis;
- mapping a platform-neutral governance model to Microsoft Purview concepts without live implementation.
