# 🚖 Ride-Sharing Platform Analysis – SQL Project  

## 📌 Project Overview  
This project analyzes a **ride-sharing dataset** to uncover insights about **users, drivers, vehicles, rides, and ratings**.  
The goal is to simulate a **real-world data pipeline workflow** using SQL — from **staging raw data** → **cleaning & validation** → **business analysis**.  

### 📂 Datasets Used  
- `users.csv`  
- `drivers.csv`  
- `vehicles.csv`  
- `rides.csv`  
- `ratings.csv`  

---

## ⚙️ Project Workflow  

### 1️⃣ Data Staging  
- Created **staging tables** using `NVARCHAR` for all columns.  
- Bulk inserted raw CSV data (`users.csv`, `drivers.csv`, `vehicles.csv`, `rides.csv`, `ratings.csv`). 

### 2️⃣ Data Validation  
- Row counts and schema checks.  
- Verified nulls, duplicates, and formatting issues.

### 3️⃣ Data Cleaning  
- Created clean views with correct data types.  
- Fixed parsing issues (e.g., vehicles with combined year & capacity `2009,3` → `year=2009`, `capacity=3`).  
- Final views ready for analysis.  

### 4️⃣ Business Analysis  
- Wrote SQL queries to answer **business objectives**.  
- Insights summarized in [`reports/insights.md`](reports/insights.md).

---

## 🎯 Business Objectives & Key Questions  

### 🔹 Sales & Revenue Performance  
1. What is the total revenue generated?  
2. What is the average fare per ride and per km?  
3. Which month had the highest total revenue?  
4. Who are the top 10 drivers by revenue?  

### 🔹 Rider Insights  
1. How many unique riders are there?  
2. What is the average number of rides per rider?  
3. Who are the top 10 riders by total spending?  
4. What is the repeat rate (riders who booked more than once)?  

### 🔹 Driver Insights  
1. How many active drivers are there?  
2. Who are the top 10 drivers by average rating?  
3. Do drivers with more rides tend to have higher or lower ratings?  
4. Which drivers are at risk (low ratings)?  

### 🔹 Ratings & Satisfaction  
1. What is the average rider rating given to drivers?  
2. Which riders give the most ratings (top 10)?  
3. What is the distribution of ratings (1–5)?  
4. Which drivers received the most ratings (top 10)?  
5. What is the monthly trend of average ratings?  

### 🔹 Trends & Patterns  
1. What is the daily and monthly trend of rides?  
2. What are the peak hours of demand?  
3. Which days of the week see the most rides?  
4. Is there a relationship between ride distance and rating?  

---

## 🛠️ Tools & Skills Used  
- **SQL Server (T-SQL)** for ETL & analytics  
- **Bulk Insert** for staging raw data  
- **Validation Checks** (row counts, nulls, duplicates, regex formatting)  
- **Data Cleaning** with views (casting data types, handling missing values, fixing vehicle fields)  
- **SQL Analytics** (aggregate & window functions, joins, grouping)  

---

## 📂 Repository Structure  
```
Ride-Sharing-Analysis/
│
├── datasets/                  
│   └── csv_files/
|       ├── users.csv        
│       ├── drivers.csv
│       ├── vehicles.csv
│       ├── rides.csv
│       └── ratings.csv
│
├── scripts/
│   ├── setup/
│   │   ├── 01_bulk_insert.sql       # Staging tables & raw load
│   │   ├── 02_validation.sql        # Row counts, null checks, duplicates
│   │   └── 03_clean_views.sql       # Data cleaning & final views
│   │
│   └── analysis/
│       ├── 01_users_analysis.sql
│       ├── 02_drivers_analysis.sql
│       ├── 03_rides_revenue.sql
│       ├── 04_ratings_analysis.sql
│       └── 05_trends_patterns.sql
│
├── reports/
│   └── insights.md                  # Final summarized insights
│
└── README.md                        # Project documentation
```

---

## ✅ Conclusion  
This project demonstrates a **full SQL data workflow**:  
- Ingest raw data into **staging tables**  
- Perform **validation & cleaning**  
- Conduct **business-driven analysis** to extract insights  

By structuring the project this way, it mirrors **real-world data engineering + analytics practices**.  

---

## 🛡️ License  
This project is licensed under the **MIT License**.  

---

## 🌟 About Me  
Hi there! I'm **Mohammad Junaid**, passionate about **data, analytics, and real-world problem solving**. 

I enjoy working on projects that allow me to:  
- Explore real-world datasets  
- Improve my technical skills  
- Deliver valuable insights through analytics  

Always curious and committed to growth, I’m on a continuous journey of learning and applying practical knowledge in tech.

