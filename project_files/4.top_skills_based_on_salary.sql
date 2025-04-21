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