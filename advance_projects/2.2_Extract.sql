SELECT job_id,
    job_title_short,
    job_location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST',
    EXTRACT(
        MONTH
        FROM job_posted_date
    ) AS Month,
    EXTRACT(
        YEAR
        FROM job_posted_date
    ) AS Year
FROM job_postings_fact
LIMIT 50;