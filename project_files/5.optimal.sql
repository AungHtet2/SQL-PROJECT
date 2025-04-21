WITH skill_name AS(
    SELECT skills_job_dim.*,
        skills_dim.skills,
        job_posting_fact.salary_year_avg
    FROM skills_job_dim
        LEFT JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
        LEFT JOIN job_posting_fact ON job_posting_fact.job_id = skills_job_dim.job_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
)
SELECT skill_id,
    skills,
    COUNT(skill_name.job_id) AS Demand_count,
    ROUND(AVG(salary_year_avg), 2) AS Average_Salary_Year
FROM skill_name
GROUP BY (skill_id, skills)
ORDER BY Demand_count DESC,
    Average_Salary_Year DESC
LIMIT 25;