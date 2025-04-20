SELECT JPF.job_id,
    JPF.job_title_short,
    JPF.job_location,
    JPF.salary_year_avg,
    CM.name,
    CASE
        WHEN salary_year_avg < 70000 THEN 'Low'
        WHEN salary_year_avg BETWEEN 70000 AND 100000 THEN 'Standard'
        WHEN salary_year_avg > 100000 THEN 'High'
        ELSE 'Unknown'
    END AS salary_bucket,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'Austin, TX' THEN 'local'
        ELSE 'Onsite'
    END AS Job_location_Category
FROM job_postings_fact AS JPF
    JOIN company_dim AS CM ON CM.company_id = JPF.company_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC;