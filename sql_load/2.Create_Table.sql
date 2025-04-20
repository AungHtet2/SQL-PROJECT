CREATE TABLE public.company_dim (
    company_id INT PRIMARY KEY,
    name TEXT,
    link TEXT,
    link_google TEXT,
    thumbnail TEXT
);
CREATE TABLE public.job_posting_fact (
    job_id INT PRIMARY KEY,
    company_id INT,
    job_title_short TEXT,
    job_title TEXT,
    job_location TEXT,
    job_via TEXT,
    job_schedule_type TEXT,
    job_work_from_home BOOLEAN,
    search_location TEXT,
    job_posted_date DATE,
    job_no_degree_mention BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country TEXT,
    salary_rate TEXT,
    salary_year_avg NUMERIC,
    salary_hour_avg NUMERIC,
    FOREIGN KEY (company_id) REFERENCES public.company_dim(company_id)
);
CREATE TABLE public.skills_dim(
    skill_id INT PRIMARY KEY,
    skills TEXT,
    type TEXT
);
CREATE TABLE public.skills_job_dim(
    job_id INT,
    skill_id INT,
    PRIMARY KEY(job_id, skill_id),
    FOREIGN KEY (job_id) REFERENCES public.job_posting_fact(job_id),
    FOREIGN KEY (skill_id) REFERENCES public.skills_dim(skill_id)
);
-- 🔒 Set all table owners at the end
ALTER TABLE public.company_dim OWNER TO postgres;
ALTER TABLE public.job_posting_fact OWNER TO postgres;
ALTER TABLE public.skills_dim OWNER TO postgres;
ALTER TABLE public.skills_job_dim OWNER TO postgres;
-- 🔍 Indexes for foreign keys
CREATE INDEX idx_job_posting_fact_company_id ON public.job_posting_fact(company_id);
CREATE INDEX idx_skills_job_dim_job_id ON public.skills_job_dim(job_id);
CREATE INDEX idx_skills_job_dim_skill_id ON public.skills_job_dim(skill_id);