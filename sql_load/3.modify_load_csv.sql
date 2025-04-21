COPY company_dim
FROM 'D:\DA_Portfolio\SQL-PROJECT\csv_files\company_dim.csv' DELIMITER ',' CSV HEADER;
COPY job_posting_fact
FROM 'D:\DA_Portfolio\SQL-PROJECT\csv_files\job_postings_fact.csv' DELIMITER ',' CSV HEADER;
COPY skills_dim
FROM 'D:\DA_Portfolio\SQL-PROJECT\csv_files\skills_dim.csv' DELIMITER ',' CSV HEADER;
COPY skills_job_dim
FROM 'D:\DA_Portfolio\SQL-PROJECT\csv_files\skills_job_dim.csv' DELIMITER ',' CSV HEADER;