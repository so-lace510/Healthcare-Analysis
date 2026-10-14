SELECT 
    t1.Patient_ID,
    t1.Diagnosis,
    t1.Follow_Up_Date AS Previous_Discharge,
    t2.Follow_Up_Date AS Readmit_Date,
    DATEDIFF(day, t1.Follow_Up_Date, t2.Follow_Up_Date) AS Days_Between_Visits,
    t2.Treatment_Plan
FROM 
    [Healthcare Analytics].[dbo].[healthcare_dataset_cleaned] 
JOIN 
    [Healthcare Analytics].[dbo].[healthcare_dataset_cleaned] t2 
    ON t1.Patient_ID = t2.Patient_ID
    -- Ensures we are looking at a subsequent visit, not the same row
    AND t2.Follow_Up_Date > t1.Follow_Up_Date
    -- Filters for readmissions occurring between 1 and 30 days later
    AND DATEDIFF(day, t1.Follow_Up_Date, t2.Follow_Up_Date) BETWEEN 1 AND 30;