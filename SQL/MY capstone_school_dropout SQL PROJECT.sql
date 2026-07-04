USE capstone_school_dropout;
SELECT *
FROM capstone_school_dropout;

#TOTAL NUMBER OF STUDENT(STUDENT ANALYSIS)
SELECT count(*) as total_student
FROM capstone_school_dropout;

#AVERAGE GPA (GPA ANALYSIS)
SELECT AVG(GPA), ROUND(AVG(GPA), 3)
FROM capstone_school_dropout;

#AVERAGE GPA BY DEPARTMENT(GPA ANALYSIS)
SELECT Department, AVG(GPA), ROUND(AVG(GPA), 3)
FROM capstone_school_dropout
GROUP BY department;

#DEPARTMENT WITH THE HIGHEST DROP OUT(DROPOUT ANALYSIS) 
SELECT Department, 
COUNT(*)
FROM capstone_school_dropout
WHERE dropout=1
GROUP BY Department
ORDER BY COUNT(*)DESC;

#DEPARTMENT WITH HIGHEST IN-STUDENT (ACTIVE STUDENT ANALYSIS)
SELECT Department, 
COUNT(*)
FROM capstone_school_dropout
WHERE dropout=0
GROUP BY Department
ORDER BY COUNT(*)DESC;

#TOTAL NUMBER OF STUDENT IN EACH DEPARTMENT(DEPARTMENTAL ANALYSIS)
SELECT Department,
COUNT(Student_ID) AS total_students
FROM capstone_school_dropout
GROUP BY department 
ORDER BY total_students DESC;

#TOTAL NUMBER OF STUDENTS BY GENDER(GENDER ANALYSIS)
SELECT Gender,
COUNT(Student_ID) AS Total_student
FROM capstone_school_dropout
GROUP BY Gender
ORDER BY Total_student DESC;

#AVERAGE STRESS INDEX LEVEL FOR EACH GENDER(STRESS ANALYSIS)
SELECT Gender,
ROUND(AVG(stress_index), 2) AS Average_stress_index
FROM capstone_school_dropout
GROUP BY Gender
ORDER BY Average_stress_index DESC;

#STUDENT WITH STRESS INDEX ABOVE THE AVERAGE STRESS INDEX FOR EACH GENDER(STRESS ANALYSIS)
SELECT student_ID,
gender,
stress_index
FROM capstone_school_dropout
WHERE stress_index > (SELECT AVG(stress_index)
FROM capstone_school_dropout)
ORDER BY stress_index DESC
LIMIT 20;

#AVERAGE AGE BY DEPARTMENT(AGE ANALYSIS)
SELECT department,
ROUND(AVG(age),2) AS Average_age
FROM capstone_school_dropout
GROUP BY department
ORDER BY Average_age DESC;

#HIGHEST FAMILY INCOME BY DEPARTMENT (FAMILY INCOME ANALYSIS)
SELECT department, 
MAX(Family_Income) AS highest_family_income
FROM capstone_school_dropout
GROUP BY department
ORDER BY highest_family_income DESC;

#STUDENT WITH HIGHEST FAMILY INCOME IN EACH DEPARTMENT(FAMILY INCOME ANALYSIS)
WITH RankedIncome AS (
SELECT 
student_id, 
department,
family_income,
ROW_NUMBER() OVER (
PARTITION BY department
ORDER BY family_income DESC
) AS rankno
FROM capstone_school_dropout
)
SELECT
student_id,
department,
family_income
FROM RankedIncome
WHERE rankno=1
ORDER BY family_income DESC;

#GPA BY PARENTAL EDUCATION(PARENTAL EDUCATION ANALYSIS)
SELECT parental_education,
ROUND(AVG(GPA),2) AS Average_GPA
FROM capstone_school_dropout
GROUP BY parental_education
ORDER BY Average_GPA DESC;

#GPA BY PART TIME JOB(PART TIME ANALYSIS)
SELECT part_time_job,
ROUND(AVG(GPA),2) AS Average_GPA
FROM capstone_school_dropout
GROUP BY part_time_job;

#STUDENT WITH AND WITHOUT INTERNET(INTERNET ANALYSIS)
SELECT internet_access,
COUNT(*) AS total
FROM capstone_school_dropout
GROUP BY internet_access;

#AVERAGE GPA BY INTERNET ACCESS(INTERNET ACCESS ANALYSIS)
WITH RankedStudents AS (
    SELECT
        Student_ID,
        Department,
        Internet_Access,
        GPA,
        ROW_NUMBER() OVER (
            PARTITION BY Department
            ORDER BY GPA DESC
        ) AS RankNo
    FROM capstone_school_dropout
)
SELECT
    Department,
    Internet_Access,
    ROUND(AVG(GPA),2) AS Average_GPA
FROM RankedStudents
WHERE RankNo <= 10
GROUP BY Department, Internet_Access
ORDER BY Department, Average_GPA DESC;

#COMPARISM OF AVERAGE GPA OF STUDENT WITH OR WITHOUT SCHOLARSHIP(SCHOLARSHIP ANALYSIS)
WITH Rankedstudents AS (
SELECT
        Student_ID,
        Department,
        Scholarship,
        GPA,
        ROW_NUMBER() OVER (
            PARTITION BY Department
            ORDER BY GPA DESC
        ) AS RankNo
    FROM capstone_school_dropout
    )
SELECT
    Department,
    Scholarship,
    ROUND(AVG(GPA), 2) AS Average_GPA
FROM RankedStudents
WHERE RankNo >= 10
GROUP BY Department, Scholarship
ORDER BY Department, Average_GPA DESC;

#TOP STUDENT WITH HIGHEST CGPA BY DEPARTMENT
WITH RankedStudents AS (
    SELECT
        Student_ID,
        Department,
        Gender,
        CGPA,
        ROW_NUMBER() OVER (
            PARTITION BY Department
            ORDER BY CGPA DESC
        ) AS RankNo
    FROM capstone_school_dropout
)
 
SELECT
    Student_ID,
    Department,
    Gender,
    CGPA
FROM RankedStudents
WHERE RankNo = 1
ORDER BY CGPA DESC;