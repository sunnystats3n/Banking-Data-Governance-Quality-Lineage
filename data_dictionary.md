# Banking Sandbox Data Dictionary

## customers
- customer_id: Unique identifier intended to identify a customer
- first_name: Customer first name
- last_name: Customer last name
- date_of_birth: Customer date of birth
- customer_type: INDIVIDUAL or BUSINESS
- country: Country code
- postal_code: Mailing postal code
- phone_number: Contact telephone number
- email: Contact email
- customer_status: ACTIVE or INACTIVE
- created_date: Customer record creation date
- last_updated: Source-system update timestamp

## accounts
- account_id: Unique identifier for an account
- customer_id: Customer associated with the account
- account_type: CHEQUING, SAVINGS, CREDIT_CARD, or LOAN
- account_status: ACTIVE, CLOSED, or SUSPENDED
- currency: Account currency
- open_date: Account opening date
- credit_limit: Credit limit where applicable
- current_balance: Current reported account balance
- branch_id: Servicing branch identifier
- last_updated: Source-system update timestamp

## transactions
- transaction_id: Unique transaction identifier
- account_id: Account associated with transaction
- transaction_date: Business transaction date
- transaction_type: PURCHASE, PAYMENT, WITHDRAWAL, DEPOSIT, FEE, TRANSFER
- amount: Monetary transaction amount
- currency: Currency of transaction
- merchant_category: Broad merchant classification
- transaction_status: POSTED, PENDING, REVERSED
- created_timestamp: Record creation timestamp

## branches
- branch_id: Branch identifier
- branch_name: Branch name
- province: Province code
- postal_code: Branch postal code
