# Introduction

This project explores the relationship between technical skills and salary for **Data Analyst** roles, specifically focusing on remote positions (`job_location = 'Anywhere'`). By analyzing job postings and their associated skills, we identify which are the **top paying jobs** in the industry and which skills are most **in-demand** and which command the **highest salaries**.

sql queries - [project_files folder](/project_files/)

# Background

In today’s data-driven world, Data Analysts are expected to be proficient in a wide range of tools and technologies. With thousands of job postings available online, it’s important to know which skills not only boost your chances of employment but also lead to higher compensation.

This project is based on a job postings dataset which includes salary data, job locations, and associated skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis

## 1. Top Paying Data Analyst Jobs (Remote)

```sql
SELECT job_id,
    name AS company_name,
    job_title,
    job_location,
    job_schedule_type,
    job_no_degree_mention,
    salary_year_avg,
    job_posted_date::DATE AS Date
FROM job_posting_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_posting_fact.company_id
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```

| Company                                 | Job Title                                       | Salary (USD/year) | No Degree Mention | Posted Date |
| --------------------------------------- | ----------------------------------------------- | ----------------- | ----------------- | ----------- |
| Mantys                                  | Data Analyst                                    | $650,000          | ✅                | 2023-02-20  |
| Meta                                    | Director of Analytics                           | $336,500          | ✅                | 2023-08-23  |
| AT&T                                    | Associate Director - Data Insights              | $255,829.50       | ❌                | 2023-06-18  |
| Pinterest Job Advertisements            | Data Analyst, Marketing                         | $232,423          | ❌                | 2023-12-05  |
| Uclahealthcareers                       | Data Analyst (Hybrid/Remote)                    | $217,000          | ❌                | 2023-01-17  |
| SmartAsset                              | Principal Data Analyst (Remote)                 | $205,000          | ❌                | 2023-08-09  |
| Inclusively                             | Director, Data Analyst - HYBRID                 | $189,309          | ❌                | 2023-12-07  |
| Motional                                | Principal Data Analyst, AV Performance Analysis | $189,000          | ❌                | 2023-01-05  |
| SmartAsset                              | Principal Data Analyst                          | $186,000          | ❌                | 2023-07-11  |
| Get It Recruit - Information Technology | ERM Data Analyst                                | $184,000          | ❌                | 2023-06-09  |

Here's the breakdown of the top data analyst jobs in 2023:

- Wide Salary Range: The top 10 remote data analyst roles offered salaries between $184,000 and $650,000, showing how lucrative this field can be—especially for experienced or specialized professionals.

- Diverse Employers: High-paying roles came from companies like Mantys, Meta, SmartAsset, and AT&T, highlighting strong demand across tech, finance, healthcare, and telecom industries.

- Varied Job Titles: Titles ranged from Data Analyst to Director of Analytics and Associate Director of Data Insights, revealing a wide spectrum of responsibilities and seniority within the data analytics domain.

## 2. Top skills for Data Analyst Jobs (Remote)

```sql
WITH top_paying_jobs AS(
    SELECT job_id,
        name AS company_name,
        job_title,
        salary_year_avg
    FROM job_posting_fact
        LEFT JOIN company_dim ON company_dim.company_id = job_posting_fact.company_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = top_paying_jobs.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY salary_year_avg DESC
```

| Job Title                                       | Company     | Avg. Salary (USD) | Required Skills |
| ----------------------------------------------- | ----------- | ----------------- | --------------- |
| Associate Director - Data Insights              | AT&T        | $255,829.50       | SQL, Python, R  |
| Data Analyst, Marketing                         | Pinterest   | $232,423.00       | SQL, Python     |
| Data Analyst (Hybrid/Remote)                    | UCLA Health | $217,000.00       | SQL, Oracle     |
| Principal Data Analyst (Remote)                 | SmartAsset  | $205,000.00       | SQL, Python     |
| Principal Data Analyst, AV Performance Analysis | Motional    | $189,000.00       | SQL             |

The table provides job listings with the following details: the job title (e.g., Data Analyst), the company name (e.g., AT&T), the average annual salary for the position (e.g., $255,829.50), and the skills required for the role (e.g., SQL, Python). Each entry represents a specific job opening with the associated salary and required skills.

## 3. Most Demand Skills For Data Analyst

```sql
WITH skill_name AS (
    SELECT skills_job_dim.*,
        skills_dim.skills AS skills
    FROM skills_job_dim
        LEFT JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
)
SELECT skill_name.skills AS skills,
    count(skill_name.job_id) AS Demand_count
FROM skill_name
    LEFT JOIN job_posting_fact ON job_posting_fact.job_id = skill_name.job_id
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
GROUP BY skills
ORDER BY Demand_count DESC
LIMIT 5
```

| **Skills** | **Demand Count** |
| ---------- | ---------------- |
| SQL        | 7291             |
| Excel      | 4611             |
| Python     | 4330             |
| Tableau    | 3745             |
| Power BI   | 2609             |

The demand for these skills reflects current industry trends and the technological needs of companies. Here's why each of these skills has a significant presence:

- **SQL** (7,291 job postings): SQL is fundamental for managing databases and is crucial in roles like data analysis, software engineering, and database administration. Almost every data-driven company needs professionals who can work with relational databases.

- **Excel** (4,611 job postings): Excel remains one of the most widely used tools for data analysis, especially for financial analysts, project managers, and those in administrative roles. It's often considered the entry-level tool for working with data.

- **Python** (4,330 job postings): Python is extremely versatile and is widely used in data analysis, machine learning, web development, and automation. Its demand continues to rise due to its ease of use and application across many fields.

- **Tableau** (3,745 job postings): Tableau is one of the most popular data visualization tools. It helps organizations present complex data in a visual format that’s easy to understand, driving its demand in data analytics and business intelligence roles.

- **Power BI** (2,609 job postings): Like Tableau, Power BI is a powerful business intelligence tool used for data analysis and visualization. It integrates well with other Microsoft products, which makes it particularly valuable in organizations that use the Microsoft ecosystem.

## 4. Top Skills Based On Salary

```sql
WITH skill_name AS (
    SELECT skills_job_dim.*,
        skills_dim.skills AS skills
    FROM skills_job_dim
        LEFT JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
)
SELECT skill_name.skills AS skills,
    ROUND(AVG(salary_year_avg), 2) AS Average_Salary_Year
FROM skill_name
    LEFT JOIN job_posting_fact ON job_posting_fact.job_id = skill_name.job_id
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY Average_Salary_Year DESC
LIMIT 10
```

| **Skill**     | **Average Salary (Year)** |
| ------------- | ------------------------- |
| Pyspark       | $208,172.25               |
| Bitbucket     | $189,154.50               |
| Watson        | $160,515.00               |
| Couchbase     | $160,515.00               |
| Datarobot     | $155,485.50               |
| Gitlab        | $154,500.00               |
| Swift         | $153,750.00               |
| Jupyter       | $152,776.50               |
| Pandas        | $151,821.33               |
| Elasticsearch | $145,000.00               |

- Pyspark: $208,172.25
  High demand for big data expertise, particularly in data engineering roles.

- Bitbucket: $189,154.50
  Crucial for version control and collaboration in software development projects.

- Watson: $160,515.00
  Popular AI and machine learning platform for cognitive computing and analytics.

- Couchbase: $160,515.00
  Demand for NoSQL database specialists, particularly in distributed systems and big data applications.

- Datarobot: $155,485.50
  Key platform for AI and machine learning automation, driving interest in data-driven models.

- Gitlab: $154,500.00
  Widely adopted for DevOps, CI/CD, and collaborative development workflows.

- Swift: $153,750.00
  Critical for iOS and macOS development, ensuring high demand in mobile app development.

- Jupyter: $152,776.50
  Essential tool for data science and machine learning, heavily used for interactive analysis.

- Pandas: $151,821.33
  Core Python library for data manipulation and analysis, a must-have skill for data scientists.

- Elasticsearch: $145,000.00
  Popular for enterprise-level search and analytics solutions, leading to strong demand for experts.

# What I Learned

## SQL Skills

- Writing SQL queries for data extraction, including aggregations (e.g., AVG(), COUNT()), joins (e.g., LEFT JOIN), and grouping (e.g., GROUP BY).

- Working with subqueries and common table expressions (CTEs) to organize and simplify complex queries.

- Filtering data with WHERE clauses to refine results (e.g., matching specific job titles or locations).

- Sorting results using ORDER BY to prioritize data, such as ranking skills by average salary.

- Using LIMIT to restrict the number of results returned.

# Conclusions

## Insights

This project analyzed Data Analyst job postings to uncover key trends related to salaries and skills.

1. Key Insights:
   High-Paying Jobs: Salaries ranged from $184,000 to $650,000, highlighting lucrative opportunities for experienced professionals.

2. In-Demand Skills: SQL, Excel, Python, Tableau, and Power BI are essential for Data Analyst roles, with SQL being the most widely required skill.

3. Salary-Boosting Skills: Specialized skills like Pyspark, Bitbucket, and Watson command higher salaries, showing the value of expertise in advanced tools.

## Closing Thoughts:

The analysis reveals the importance of mastering both foundational and specialized skills. Data analysts looking to maximize career growth should focus on these high-demand skills to stay competitive and increase their earning potential. This project reinforced the value of SQL in extracting actionable insights from data.
