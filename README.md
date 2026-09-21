# E-Commerce SQL Analysis

I built this project to get better at SQL. Took a realistic e-commerce dataset with 4 related tables and wrote 16 queries — starting from simple filters and going up to window functions.

## Why I made this

Most beginner SQL projects have just one table. Real work involves joining multiple tables and thinking about business questions. I wanted to practice that, not just syntax.

## The data

4 tables with proper relationships:

| Table | Rows | What's in it |
|:---|:---|:---|
| customers | 30 | Customer info, city, state, segment |
| products | 15 | Category, subcategory, price, cost |
| orders | 60 | Order date, ship mode, payment method |
| order_items | 98 | Line items linking orders and products |

Relationship:
customers ──< orders ──< order_items >── products

text

## What's in this repo
├── data/
│ ├── customers.csv
│ ├── products.csv
│ ├── orders.csv
│ └── order_items.csv
├── queries.sql
└── README.md

text

## Query coverage

**Basic (Q1–Q5)**
SELECT, WHERE, ORDER BY, GROUP BY, LIMIT

**Joins & Aggregations (Q6–Q10)**
INNER JOIN, multi-table joins, HAVING, ROUND, conditional calculation with discount

**Subqueries (Q11–Q13)**
IN, NOT IN, scalar subqueries

**Window Functions (Q14–Q16)**
ROW_NUMBER, RANK, PARTITION BY, LAG

## A few things I noticed

- Revenue is concentrated in a few categories. Electronics and Clothing carry most of it.
- Several customers never placed an order at all — I found this with a NOT IN subquery.
- Some products were never ordered either. Useful for inventory calls.
- Average order value varies by ship mode.
- UPI came out on top for payment method, which I didn't expect.

## One thing about revenue

All revenue calculations include the discount:

```sql
SUM(quantity * unit_price * (1 - discount_pct/100.0))
Without this, numbers are ~10% higher than actual revenue. Easy mistake to make.

How to run
Clone the repo

Import the 4 CSVs into MySQL (or SQLite)

Run queries from queries.sql

For MySQL:

sql
CREATE DATABASE ecommerce_db;
USE ecommerce_db;
-- Then import each CSV via Table Data Import Wizard
What I'd add next
RFM segmentation for customers

Cohort retention — do customers come back?

Market basket analysis — what sells together

About me
Mohd. Yusuf — building projects, learning data analytics, looking for my first role.

GitHub: @codewithmorcous

Built September 2026. Dataset is fictional, made for practice.

text

---

## 📌 Repository Description (GitHub "About" field)
SQL analysis of an e-commerce dataset with 4 related tables. 16 queries coveri
