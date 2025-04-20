SELECT COUNT(job_id) AS Job_count,
    AVG(salary_year_avg) AS salary_year_avg,
    MAX(salary_year_avg) AS Max_salary_year_avg,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'Austin, TX' THEN 'local'
        ELSE 'Onsite'
    END AS Job_location_Category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY Job_location_Category;