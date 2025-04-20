SELECT COUNT(job_id) AS job_posted_count,
    EXTRACT(
        MONTH
        FROM job_posted_date
    ) AS Month
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY Month
ORDER BY Month;