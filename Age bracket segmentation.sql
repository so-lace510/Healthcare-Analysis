SELECT 
    Diagnosis,
    CASE 
        WHEN Age < 35 THEN 'Under 35'
        WHEN Age BETWEEN 35 AND 50 THEN '35-50'
        WHEN Age BETWEEN 51 AND 65 THEN '51-65'
        ELSE '65+' 
    END AS Age_Group,
    COUNT(Patient_ID) AS Patient_Count
FROM 
    [Healthcare Analytics].[dbo].[healthcare_dataset_cleaned]
GROUP BY 
    Diagnosis,
    CASE 
        WHEN Age < 35 THEN 'Under 35'
        WHEN Age BETWEEN 35 AND 50 THEN '35-50'
        WHEN Age BETWEEN 51 AND 65 THEN '51-65'
        ELSE '65+' 
    END
ORDER BY 
    Diagnosis, 
    Patient_Count DESC;