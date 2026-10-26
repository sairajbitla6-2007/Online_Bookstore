# Online Bookstore SQL Analysis

An end-to-end MySQL project that models an online bookstore and uses SQL to explore its books, customers, orders, sales, and inventory.

## Table of Contents

- [Overview and Business Problem](#overview-and-business-problem)
- [Dataset](#dataset)
- [Tools and Technologies](#tools-and-technologies)
- [Project Structure](#project-structure)
- [Project Steps](#project-steps)
- [Analysis](#analysis)
- [Dashboard](#dashboard)
- [How to Run](#how-to-run)
- [Results and Future Work](#results-and-future-work)
- [Author and Contact](#author-and-contact)

## Overview and Business Problem

The project creates a relational database for a bookstore and answers practical questions about sales and inventory. It demonstrates how to load related CSV data, connect tables with primary and foreign keys, and use joins, aggregations, subqueries, and filtering to support business analysis.

## Dataset

The project includes three CSV files, each containing 500 records:

- `data/books.csv` — book titles, authors, genres, publication years, prices, and stock.
- `data/customers.csv` — customer names and contact and location fields.
- `data/orders.csv` — order dates, customers, books, quantities, and order totals.

## Tools and Technologies

- MySQL
- SQL
- CSV

## Project Structure

```text
.
├── data/
│   ├── books.csv
│   ├── customers.csv
│   └── orders.csv
├── scripts/
│   └── onlinebook_store.sql
├── .gitignore
└── README.md
```

## Project Steps

1. Create the bookstore database and its books, customers, and orders tables.
2. Define primary and foreign keys to represent relationships between records.
3. Load the CSV files into the corresponding tables.
4. Run basic and advanced SQL queries to examine sales, customer orders, and inventory.

## Analysis

The query set includes questions such as:

- Which genres and books are available, and which books have the highest prices?
- How many orders and book units were sold, and what is the total order revenue?
- Which customers or cities account for the most spending?
- Which books have not been ordered, and what stock remains after sales?

The complete queries are in [`scripts/onlinebook_store.sql`](scripts/onlinebook_store.sql).

## Dashboard

No dashboard or visualization files are included in this SQL project.

## How to Run

1. Install and start MySQL, then clone this repository.
2. Open a terminal in the repository root, where the `data` directory is located.
3. Enable `LOCAL INFILE` for both the MySQL server and client if it is not already enabled. The client command below enables it for the client connection.
4. Run the script with a MySQL account that can create databases and tables:

   ```sh
   mysql --local-infile=1 -u YOUR_MYSQL_USERNAME -p < scripts/onlinebook_store.sql
   ```

Run the command from the repository root so the script can find the CSV files at `data/books.csv`, `data/customers.csv`, and `data/orders.csv`. MySQL prompts for the account password; enter it at the prompt rather than putting it in the command.

The script creates or reuses the `books` database, drops and recreates its `orders`, `books`, and `customers` tables, imports all three CSV files, and runs the included queries. **Running it replaces the contents of those tables in the `books` database.** Back up any existing data first. The MySQL account must be allowed to create/use the database and tables and load local data. The MySQL client option enables `LOCAL INFILE` for the client; if the server also disables local data loading, enable `local_infile` in the server configuration.

## Results and Future Work

The SQL file contains example queries for bookstore sales, customer activity, and stock analysis. Future work could add data-quality checks, indexes for common joins, and a dashboard built from the query results.

## Author and Contact

[GitHub profile](https://github.com/sairajbitla6-2007)
