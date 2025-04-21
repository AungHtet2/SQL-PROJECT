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