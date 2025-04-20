WITH January_jobs AS (
    SELECT JPF.job_id,
        SJD.skill_id,
        JPF.company_id,
        JPF.job_title_short,
        JPF.salary_year_avg
    FROM job_postings_fact AS JPF
        INNER JOIN skills_job_dim AS SJD ON SJD.job_id = JPF.job_id
    WHERE EXTRACT(
            MONTH
            FROM job_posted_date
        ) = 1
),
February_jobs AS (
    SELECT JPF.job_id,
        SJD.skill_id,
        JPF.company_id,
        JPF.job_title_short,
        JPF.salary_year_avg
    FROM job_postings_fact AS JPF
        INNER JOIN skills_job_dim AS SJD ON SJD.job_id = JPF.job_id
    WHERE EXTRACT(
            MONTH
            FROM job_posted_date
        ) = 2
),
March_jobs AS (
    SELECT JPF.job_id,
        SJD.skill_id,
        JPF.company_id,
        JPF.job_title_short,
        JPF.salary_year_avg
    FROM job_postings_fact AS JPF
        INNER JOIN skills_job_dim AS SJD ON SJD.job_id = JPF.job_id
    WHERE EXTRACT(
            MONTH
            FROM job_posted_date
        ) = 3
),
first_quarter AS (
    SELECT job_id,
        skill_id,
        company_id,
        job_title_short,
        salary_year_avg
    FROM January_jobs
    UNION ALL
    SELECT job_id,
        skill_id,
        company_id,
        job_title_short,
        salary_year_avg
    FROM February_jobs
    UNION ALL
    SELECT job_id,
        skill_id,
        company_id,
        job_title_short,
        salary_year_avg
    FROM March_jobs
)
SELECT first_quarter.job_id,
    first_quarter.company_id,
    first_quarter.job_title_short,
    sd.skills,
    first_quarter.salary_year_avg
FROM first_quarter
    INNER JOIN skills_dim as sd ON sd.skill_id = first_quarter.skill_id
WHERE first_quarter.salary_year_avg > 70000;