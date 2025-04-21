WITH skill_name AS (
    SELECT skills_job_dim.*,
        skills_dim.skills AS skills
    FROM skills_job_dim
        LEFT JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
)
SELECT skill_name.skills AS skills,
    count(skills) AS skills_count
FROM skill_name
    LEFT JOIN job_posting_fact ON job_posting_fact.job_id = skill_name.job_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY skills_count DESC
LIMIT 10