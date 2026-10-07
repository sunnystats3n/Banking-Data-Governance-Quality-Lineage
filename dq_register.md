# Initial Data Quality Control Register

| ID | Dimension | Example control |
|---|---|---|
| DQ-001 | Completeness | Required field must not be NULL/blank |
| DQ-002 | Uniqueness | Identifier must not occur more than once |
| DQ-003 | Validity | Values must conform to approved domain/range/format |
| DQ-004 | Referential integrity | Foreign key must match a valid parent record |
| DQ-005 | Consistency | Related fields/tables must agree with each other |
| DQ-006 | Timeliness | Data must be updated within an agreed SLA |

Do not assume thresholds yet. In the portfolio, distinguish:
- business requirement
- DQ rule
- measured metric
- approved threshold
- exception
- owner/steward
- remediation
- monitoring frequency
