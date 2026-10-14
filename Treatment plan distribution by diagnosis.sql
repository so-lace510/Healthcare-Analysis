SELECT 
    Diagnosis,
    Treatment_Plan,
    COUNT(Patient_ID) AS Patient_Count
FROM 
    [Healthcare Analytics].[dbo].[healthcare_dataset_cleaned]
GROUP BY 
    Diagnosis,
    Treatment_Plan
ORDER BY 
    Diagnosis, 
    Patient_Count DESC;