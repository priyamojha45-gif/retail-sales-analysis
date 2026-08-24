# Retail Sales & Performance Analytics Dashboard

## 📊 Project Overview

An end-to-end retail sales and profitability analytics project built using **Excel, SQL, and Power BI**.

The project analyzes sales performance across time, product, category, and region, and presents the results through an interactive Power BI dashboard with KPI cards and slicers.

## 🎯 Business Objective

The objective is to understand:

- Overall sales and profitability
- Sales and profit performance by category
- Regional sales and profit performance
- Top-performing products
- Monthly sales trends
- Key business KPIs that can support performance monitoring and decision-making

## 🛠️ Tools & Technologies

- **Microsoft Excel** — data analysis, KPI calculations, pivot-style analysis and charts
- **SQL** — planned/used for structured business analysis and aggregations
- **Power BI** — interactive dashboard, KPI cards, charts and slicers
- **GitHub** — project version control and portfolio presentation

## 📁 Dataset

The source workbook contains a `Raw_Data` sheet with **1,500 retail order records** and **17 fields**:

- Order_ID
- Order_Date
- Customer_ID
- Customer_Name
- Segment
- Region
- State
- City
- Category
- Sub_Category
- Product_Name
- Quantity
- Unit_Price
- Discount
- Sales
- Profit
- Payment_Mode

## 📌 Key KPIs

| KPI | Value |
|---|---:|
| Total Sales | ₹48,375,149.13 |
| Total Profit | ₹6,923,158.34 |
| Profit Margin | 14.31% |
| Total Orders | 1,500 |
| Average Order Value | ₹32,250.10 |

## 📈 Dashboard Analysis

### Category Performance

| Category | Sales | Profit | Profit Margin |
|---|---:|---:|---:|
| Electronics | ₹38,550,939.77 | ₹5,109,995.43 | 13.26% |
| Furniture | ₹9,364,611.26 | ₹1,705,281.17 | 18.21% |
| Office Supplies | ₹459,598.10 | ₹107,881.74 | 23.47% |

**Observation:** Electronics is the largest contributor to both sales and absolute profit, while Office Supplies has the highest reported profit margin among the three categories.

### Regional Performance

| Region | Sales | Profit | Profit Margin |
|---|---:|---:|---:|
| East | ₹10,996,134.48 | ₹1,655,647.04 | 15.06% |
| North | ₹12,222,771.73 | ₹1,704,299.58 | 13.94% |
| South | ₹13,961,115.34 | ₹1,943,587.90 | 13.92% |
| West | ₹11,195,127.58 | ₹1,619,623.82 | 14.47% |

**Observation:** South has the highest sales and absolute profit, while East has the highest regional profit margin in the supplied analysis.

### Top 5 Products by Sales

| Product | Sales | Profit |
|---|---:|---:|
| Business Laptop | ₹14,208,075.40 | ₹1,964,313.76 |
| Student Laptop | ₹10,698,033.74 | ₹1,343,276.44 |
| Smartphone Pro | ₹9,132,833.34 | ₹1,201,088.20 |
| Smartphone Lite | ₹3,827,442.27 | ₹512,066.00 |
| Storage Cabinet | ₹3,494,627.21 | ₹638,095.33 |

### Monthly Sales Analysis

The dashboard includes a monthly sales trend covering **January through December**.

The supplied workbook reports the highest monthly sales in **December (₹5,074,620.46)** and the lowest in **April (₹2,790,935.36)**.

## 📊 Power BI Dashboard

The Power BI dashboard includes:

- Total Sales KPI
- Total Profit KPI
- Profit Margin KPI
- Total Orders KPI
- Average Order Value KPI
- Monthly Sales Trend
- Category Sales & Profit
- Regional Sales & Profit
- Top 5 Products by Sales
- Region slicer
- Category slicer

## 🔍 Key Insights

1. **Electronics dominates sales**, contributing approximately ₹38.55M in sales.
2. **South leads regional sales and absolute profit**, with ₹13.96M sales and ₹1.94M profit.
3. **Office Supplies has the highest reported category profit margin (23.47%)**, despite having the smallest sales volume.
4. **Business Laptop is the highest-selling product**, generating approximately ₹14.21M in sales.
5. **December has the highest reported monthly sales**, while April has the lowest.

## 📂 Project Structure

```text
Retail-Sales-Analysis/
│
├── myproject.xlsx
├── Retail_Sales_Performance_Dashboard.pbix
└── README.md
```

## 🚀 Skills Demonstrated

- Data cleaning and preparation
- Excel-based business analysis
- KPI calculation
- Sales and profitability analysis
- Aggregation and comparative analysis
- Power BI dashboard development
- Interactive filtering with slicers
- Data visualization
- Business insight generation
- Portfolio project documentation

## 📌 Note

The analysis and figures in this README are based on the supplied `myproject.xlsx` workbook and the Power BI dashboard developed from it.
