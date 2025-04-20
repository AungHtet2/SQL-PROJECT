SELECT job_id,
    job_title_short,
    job_location,
    job_posted_date::DATE AS Date
FROM job_postings_fact
LIMIT 50;