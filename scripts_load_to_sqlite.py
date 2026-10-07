import csv
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parent
DATA = ROOT / "data" / "raw"
DB = ROOT / "banking_governance.sqlite"

TABLES = {
    "customers": "customers.csv",
    "accounts": "accounts.csv",
    "transactions": "transactions.csv",
    "branches": "branches.csv",
}

with sqlite3.connect(DB) as conn:
    cur = conn.cursor()
    for table, filename in TABLES.items():
        path = DATA / filename
        with path.open(newline="", encoding="utf-8") as f:
            reader = csv.DictReader(f)
            headers = reader.fieldnames or []
            rows = list(reader)
        cur.execute(f'DROP TABLE IF EXISTS "{table}"')
        ddl = ", ".join(f'"{h}" TEXT' for h in headers)
        cur.execute(f'CREATE TABLE "{table}" ({ddl})')
        placeholders = ",".join("?" for _ in headers)
        cur.executemany(
            f'INSERT INTO "{table}" VALUES ({placeholders})',
            [[row[h] for h in headers] for row in rows],
        )
    conn.commit()

print(f"Created {DB}")
