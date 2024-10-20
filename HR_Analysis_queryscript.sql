Create database HRAnalysis;
use HRAnalysis;

/* Renaming the Table name*/
Rename table `ibm-hr-employee-attrition-data` to hrdata;
SELECT 
    *
FROM
    hrdata;

/* Changing Column name*/
alter table hrdata
change ï»¿Age Age int;

show columns from hrdata;
/*Finding Null Values*/
SELECT 
    COUNT(CASE
        WHEN age IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN Attrition IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN BusinessTravel IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN DailyRate IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN Department IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN DistanceFromHome IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN Education IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN EducationField IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN EmployeeCount IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN EmployeeNumber IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN EnvironmentSatisfaction IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN Gender IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN HourlyRate IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN JobInvolvement IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN JobLevel IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN JobRole IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN JobSatisfaction IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN MaritalStatus IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN MonthlyIncome IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN MonthlyRate IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN NumCompaniesWorked IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN Over18 IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN OverTime IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN PercentSalaryHike IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN PerformanceRating IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN RelationshipSatisfaction IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN StandardHours IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN StockOptionLevel IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN TotalWorkingYears IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN TrainingTimesLastYear IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN WorkLifeBalance IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN YearsAtCompany IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN YearsInCurrentRole IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN YearsSinceLastPromotion IS NULL THEN 1
        ELSE 0
    END),
    COUNT(CASE
        WHEN YearsWithCurrManager IS NULL THEN 1
        ELSE 0
    END)
FROM
    hrdata; 
/* No Null Values are found in the given dataset*/

/* Total employees by Gender*/
SELECT 
    gender, COUNT(gender) AS countofEmployees
FROM
    hrdata
GROUP BY gender; 
/* Total employees by gender and department*/
SELECT 
    department, Gender, COUNT(EmployeeNumber) AS count
FROM
    hrdata
GROUP BY gender , department
ORDER BY 1;
  /* JOblevel count of employees*/
SELECT 
    joblevel, gender, COUNT(*) AS count
FROM
    hrdata
GROUP BY joblevel , gender
ORDER BY 1;

/* Counting attrition rate by Department*/
SELECT 
    department, sum(case when attrition= 'yes' then 1 else 0 end) AS AttritionRate
FROM
    hrdata
    group by department;


/* businesstravel count  */
SELECT 
    businesstravel, COUNT(businesstravel) AS EmployeeTravelCount
FROM
    hrdata
GROUP BY businesstravel;

/* Employee with Educationfield*/
SELECT 
    employeenumber, education, educationfield
FROM
    hrdata
WHERE
    educationfield = 'Life Sciences';

/*Attrition Rate*/
SELECT 
    attrition,
    (COUNT(attrition) / (SELECT 
            COUNT(attrition)
        FROM
            hrdata)) AS AttritionRate
FROM
    hrdata
GROUP BY attrition;

/*This helps to understand which age group is having highest attribution rate*/
SELECT 
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        ELSE '46 and above'
    END AS AgeGroup,
    ROUND(SUM(CASE
                WHEN Attrition = 'Yes' THEN 1
            END) * 100.0 / COUNT(*),
            2) AS AttritionRate
FROM
    hrdata
GROUP BY AgeGroup
ORDER BY 1;

/*This helps to undestand that how long the employees are staying in the company */
SELECT 
    YearsAtCompany,
    round(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS AttritionRate
FROM 
    hrdata
GROUP BY 
    YearsAtCompany
    order by 2;
    
/*this helps which department is having highest attribution rate*/
SELECT 
    Department,
    ROUND(COUNT(CASE
                WHEN Attrition = 'Yes' THEN 1
            END) * 100.0 / COUNT(*),
            2) AS AttritionRate
FROM
    hrdata
GROUP BY department;

/*male Attrition rate is more compare with female*/
SELECT 
    Gender,
    round(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS AttritionRate
FROM 
    hrdata
GROUP BY 
    Gender;

/*Employee Satisfaction Rate */
SELECT 
    environmentsatisfaction AS Rate,
    COUNT(environmentsatisfaction) AS Environmentsatisfaction
FROM
    hrdata
GROUP BY 1
ORDER BY 1 ASC;
    
SELECT 
    jobsatisfaction, COUNT(jobsatisfaction) AS Jobsatisfaction
FROM
    hrdata
GROUP BY 1
ORDER BY 1;
    
SELECT 
    relationshipsatisfaction,
    COUNT(RelationshipSatisfaction) AS RelationshipSatisfaction
FROM
    hrdata
GROUP BY 1
ORDER BY 1;
    
    SELECT 
    performancerating AS Rate,
    COUNT(PerformanceRating) AS PerformanceRating
FROM
    hrdata
GROUP BY 1
ORDER BY 1 ASC;
 
SELECT 
    jobsatisfaction, COUNT(*)
FROM
    hrdata
GROUP BY jobsatisfaction
ORDER BY 1;
 
 /*Salary for each employee along with hike*/
SELECT 
    employeenumber, MonthlyIncome, percentsalaryhike
FROM
    hrdata;
 
 /*Average of total woking years and years at company by department*/
 SELECT 
   department, ROUND(AVG(totalworkingyears), 2) as Avgtotalworkingyears,
    ROUND(AVG(yearsatcompany), 2) as avgyearsatcompany
FROM
    hrdata
    group by department;
    
    /*Relationship with manager sometime leads to Attrition*/
SELECT 
    JobRole, 
    AVG(YearsWithCurrManager) AS AvgYearsWithCurrManager
FROM 
    hrdata
GROUP BY 
    JobRole;
    
    /* Promotion Rate by department */
SELECT 
    Department, 
    round(COUNT(CASE WHEN YearsSinceLastPromotion = 0 THEN 1 END) / COUNT(*) * 100,2) AS PromotionRate
FROM 
    hrdata
GROUP BY 
    Department;

 /*Salary based on peformance rating*/
 SELECT 
    PerformanceRating, AVG(MonthlyIncome) AS AvgIncome
FROM
    hrdata
GROUP BY PerformanceRating;
    
    /*Stocklevel & performancerating -- employeecount */
SELECT 
    StockOptionLevel,
    PerformanceRating,
    COUNT(*) AS EmployeeCount
FROM
    hrdata
GROUP BY StockOptionLevel , PerformanceRating;

  /* Average Monthysalary based on Jobsatisfaction*/
SELECT 
    jobsatisfaction, AVG(monthlyincome) As AvgIncome
FROM
    hrdata
GROUP BY 1
ORDER BY 1;

/* Age Distribution*/
SELECT 
    age, COUNT(employeenumber) AS EmployeeAge_count
FROM
    hrdata
GROUP BY age;

/* Job switching Tendency*/
SELECT 
    employeenumber,
    numcompaniesworked,
    yearsatcompany,
    (CASE
        WHEN numcompaniesworked > 3 THEN 'High'
        ELSE 'Less'
    END) AS Job_switching
FROM
    hrdata;
    
/*Attrition by Distance From home*/
SELECT 
    DistanceFromHome, 
    COUNT(EmployeeNumber) AS TotalEmployees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions
FROM 
    hrdata
GROUP BY 
    DistanceFromHome
ORDER BY 
    DistanceFromHome;

   /* overtime rate*/ 
    SELECT 
    overtime, COUNT(employeenumber)
FROM
    hrdata
WHERE
    overtime = 'yes'
GROUP BY overtime;

/* Daily Rate*/
SELECT 
    employeenumber, dailyrate, hourlyrate, standardhours
FROM
    hrdata;
