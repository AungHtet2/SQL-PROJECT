WITH skill_name AS (
    SELECT skills_job_dim.skill_id,
        skills_dim.skills AS skill,
        skills_job_dim.job_id,
        job_posting_fact.salary_year_avg,
        job_posting_fact.job_title_short,
        job_posting_fact.job_location
    FROM skills_job_dim
        LEFT JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
        LEFT JOIN job_posting_fact ON job_posting_fact.job_id = skills_job_dim.job_id
    WHERE job_posting_fact.job_title_short = 'Data Analyst'
        AND job_posting_fact.job_location = 'Anywhere'
)
SELECT skill_name.skill_id,
    skill_name.skill AS skills,
    COUNT(skill_name.job_id) AS demand_count,
    ROUND(AVG(skill_name.salary_year_avg), 2) AS average_salary_year
FROM skill_name
WHERE salary_year_avg IS NOT NULL
GROUP BY skill_name.skill_id,
    skill_name.skill
ORDER BY demand_count DESC;