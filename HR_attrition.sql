CREATE TABLE public.hr_attrition (
    age                         INT,
    attrition                   VARCHAR(5),
    business_travel             VARCHAR(30),
    daily_rate                  INT,
    department                  VARCHAR(50),
    distance_from_home          INT,
    education                   INT,
    education_field             VARCHAR(50),
    employee_count              INT,
    employee_number             INT,
    environment_satisfaction    INT,
    gender                      VARCHAR(10),
    hourly_rate                 INT,
    job_involvement             INT,
    job_level                   INT,
    job_role                    VARCHAR(50),
    job_satisfaction            INT,
    marital_status              VARCHAR(20),
    monthly_income              INT,
    monthly_rate                INT,
    num_companies_worked        INT,
    over18                      VARCHAR(5),
    overtime                    VARCHAR(5),
    percent_salary_hike         INT,
    performance_rating          INT,
    relationship_satisfaction   INT,
    standard_hours              INT,
    stock_option_level          INT,
    total_working_years         INT,
    training_times_last_year    INT,
    work_life_balance           INT,
    years_at_company            INT,
    years_in_current_role       INT,
    years_since_last_promotion  INT,
    years_with_curr_manager     INT
);

SELECT COUNT(*) FROM public.hr_attrition;



-- Overall attrition rate
SELECT
    attrition,
    COUNT(*)                                    AS total,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM public.hr_attrition
GROUP BY attrition;

SELECT
    COUNT(DISTINCT employee_count)  AS emp_count_unique,
    COUNT(DISTINCT standard_hours)  AS std_hours_unique,
    COUNT(DISTINCT over18)          AS over18_unique
FROM public.hr_attrition;

 --Attrition by Department
SELECT
    department,
    COUNT(*)                                            AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2)                          AS attrition_rate_pct
FROM public.hr_attrition
GROUP BY department
ORDER BY attrition_rate_pct DESC;
--Attrition by Job Role
SELECT
    job_role,
    COUNT(*)                                            AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2)                          AS attrition_rate_pct
FROM public.hr_attrition
GROUP BY job_role
ORDER BY attrition_rate_pct DESC;
--Attrition by Age Group
SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '55+'
    END                                                 AS age_group,
    COUNT(*)                                            AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2)                          AS attrition_rate_pct
FROM public.hr_attrition
GROUP BY 1
ORDER BY 1;
--Attrition by Overtime
SELECT
    overtime,
    COUNT(*)                                            AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2)                          AS attrition_rate_pct
FROM public.hr_attrition
GROUP BY overtime
ORDER BY attrition_rate_pct DESC;

 --Average Salary
SELECT
    attrition,
    ROUND(AVG(monthly_income), 2)       AS avg_monthly_income,
    ROUND(AVG(age), 1)                  AS avg_age,
    ROUND(AVG(years_at_company), 1)     AS avg_years_at_company,
    ROUND(AVG(job_satisfaction), 2)     AS avg_job_satisfaction,
    ROUND(AVG(work_life_balance), 2)    AS avg_work_life_balance,
    ROUND(AVG(distance_from_home), 1)   AS avg_distance_from_home
FROM public.hr_attrition
GROUP BY attrition;
 --Satisfaction Scores by Department
SELECT
    department,
    ROUND(AVG(job_satisfaction), 2)         AS avg_job_satisfaction,
    ROUND(AVG(environment_satisfaction), 2) AS avg_env_satisfaction,
    ROUND(AVG(work_life_balance), 2)        AS avg_work_life_balance,
    ROUND(AVG(relationship_satisfaction), 2)AS avg_relationship_satisfaction
FROM public.hr_attrition
GROUP BY department
ORDER BY avg_job_satisfaction;
--Income by Job Role
SELECT
    job_role,
    ROUND(AVG(monthly_income), 2)   AS avg_income,
    MIN(monthly_income)             AS min_income,
    MAX(monthly_income)             AS max_income,
    COUNT(*)                        AS headcount
FROM public.hr_attrition
GROUP BY job_role
ORDER BY avg_income DESC;



