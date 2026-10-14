SELECT 
    Diagnosis,
    Gender,
    COUNT(Patient_ID) AS Total_Patients,
    ROUND(AVG(CAST(Age AS FLOAT)), 1) AS Avg_Age,
    ROUND(AVG(BMI), 1) AS Avg_BMI,
    ROUND(AVG(CAST(Cholesterol_Level AS FLOAT)), 1) AS Avg_Cholesterol
FROM 
    [Healthcare Analytics].[dbo].[healthcare_dataset_cleaned]
GROUP BY 
    Diagnosis,
    Gender
ORDER BY 
    Diagnosis, 
    Gender;