WITH January_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(
            MONTH
            FROM job_posted_date
        ) = 1
)
SELECT *
FROM January_jobs;
---*************************************---
WITH February_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(
            MONTH
            FROM job_posted_date
        ) = 2
) ---*************************************---
SELECT *
FROM February_jobs ---*************************************---
SELECT company_id,
    name AS Company_name
FROM company_dim
WHERE company_id in (
        SELECT company_id
        FROM job_postings_fact
        WHERE job_no_degree_mention = TRUE
        ORDER BY company_id
    );
---*************************************---
WITH company_jobs_count AS (
    SELECT company_id,
        count(*) AS Total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT company_dim.name AS Company_name,
    Total_jobs
FROM company_dim
    LEFT JOIN company_jobs_count ON company_jobs_count.company_id = company_dim.company_id
ORDER BY Total_jobs DESC ---*************************************---
    WITH top_5_skills AS (
        SELECT skill_id,
            count(*) AS skill_counts
        FROM skills_job_dim
        GROUP BY skill_id
        ORDER BY skill_counts DESC
        LIMIT 5
    )
SELECT skills_dim.skills,
    skill_counts
FROM skills_dim
    LEFT JOIN top_5_skills ON top_5_skills.skill_id = skills_dim.skill_id
WHERE skill_counts IS NOT NULL ---*************************************---
    ---********WORK FROM HOME & DATA ANALYST********---
    WITH remote_jobs AS (
        SELECT skill_id,
            count(*) AS skill_counts
        FROM skills_job_dim
            INNER JOIN job_postings_fact as JPF ON JPF.job_id = skills_job_dim.job_id
        WHERE job_work_from_home = TRUE
            AND job_title_short = 'Data Analyst'
        GROUP BY skill_id
    )
SELECT skill.skill_id,
    skills,
    skill_counts
FROM remote_jobs
    INNER JOIN skills_dim AS skill ON skill.skill_id = remote_jobs.skill_id
ORDER BY skill_counts DESC
LIMIT 5;
---********WORK FROM HOME & DATA ANALYST********---
SELECT *
FROM skills_dim
SELECT *
FROM job_postings_fact
LIMIT 5;
---********WORK FROM HOME & DATA ANALYST********---
---********WORK FROM HOME(USA) & Business Analyst********---
WITH remote_jobs AS (
    SELECT skill_id,
        COUNT(*) AS skill_counts
    FROM skills_job_dim
        INNER JOIN job_postings_fact AS JPF ON JPF.job_id = skills_job_dim.job_id
    WHERE job_country = 'United States'
        AND job_work_from_home = TRUE
        AND job_title_short = 'Business Analyst'
    GROUP BY skill_id
)
SELECT skills_dim.skill_id,
    skills,
    skill_counts
FROM remote_jobs
    INNER JOIN skills_dim ON skills_dim.skill_id = remote_jobs.skill_id
ORDER BY skill_counts DESC
LIMIT 5;