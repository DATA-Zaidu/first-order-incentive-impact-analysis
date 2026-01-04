# first-order-incentive-impact-analysis
E-commerce companies often use heavy first-order discounts to acquire new customers. While this strategy boosts short-term orders, its long-term impact on customer quality and revenue is unclear.  This project analyzes whether first-order incentives create long-term customer value or attract low-quality, one-time buyers.

First-Order Incentive Impact Analysis

🎯 **Business Problem**

The company is investing significantly in first-order incentives without clear evidence that these customers:

Stay longer

Generate higher lifetime value

Contribute to sustainable revenue growth

The key concern:

Are we buying growth, or are we buying churn?

❓ **Key Business Questions**

This analysis answers the following questions:

Do customers who receive first-order incentives retain better or worse than others?

How does 30-day and 90-day LTV differ by incentive level?

Are high discounts attracting low-quality customers who churn early?

Should the business reduce, maintain, or redesign its first-order incentive strategy?

📐 **Metrics Used (Deliberately Chosen)**

To avoid misleading conclusions, this project focuses on quality-driven metrics:

Customer Retention Rate

30-Day LTV

90-Day LTV

Orders per Customer

Revenue per Retained Customer

**❌ Excluded on purpose:**

Total revenue

Total orders

(These metrics hide churn and overstate success.)

**🧪 Analytical Approach**

Filtered only delivered orders

Identified first order per customer to define acquisition cohorts

Modeled first-order incentive buckets (No / Low / Medium / High)

Tracked customer behavior after acquisition

Calculated LTV at the customer level to avoid double counting

Compared retention and LTV across incentive segments

Derived business recommendations, not just charts

⚠️ **Data Assumptions & Limitations**

The dataset does not contain explicit discount information.

To address this:

Incentives were modeled only for first orders

Incentive buckets were designed to reflect realistic promotional strategies

All assumptions are clearly documented to maintain analytical integrity

This approach mirrors real-world analytics, where promotional data is often incomplete.

📦 **Dataset**

Source: Olist Brazilian E-commerce Dataset

Format: SQLite database

Tables used:

orders

customers

order_items

order_payments

🛠 **Tools**

SQL (SQLite)

DB Browser for SQLite

GitHub (documentation & versioning)

The analysis logic is engine-agnostic and transferable to BigQuery, PostgreSQL, or Snowflake.


## Results Snapshot

- Baseline retention: ~3% (97% churn after first order)
- Repeat rate by incentive: ~3% across all levels
- 90-day LTV: ~125 across all incentive buckets
- Conclusion: First-order incentives increase volume, not long-term value



