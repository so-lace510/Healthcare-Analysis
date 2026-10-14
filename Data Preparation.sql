SELECT * FROM [Healthcare Analytics].[dbo].[healthcare_dataset]

-- ============================================================================
-- STEP 1: INSPECT DUPLICATES (Does not alter any data)
-- ============================================================================
SELECT 
    Patient_ID, 
    Follow_Up_Date, 
    COUNT(*) AS occurrence_count
FROM [Healthcare Analytics].[dbo].[healthcare_dataset]
GROUP BY Patient_ID, Follow_Up_Date
HAVING COUNT(*) > 1;


-- ============================================================================
-- STEP 2: RE-CREATE CLEANED TABLE WITH ALL COLUMNS
-- ============================================================================
DROP TABLE IF EXISTS [Healthcare Analytics].dbo.healthcare_dataset_cleaned;

WITH RankedData AS (
    SELECT 
        CAST(Patient_ID AS INT) AS Patient_ID,
        Age,
        TRIM(Gender) AS Gender,
        Blood_Pressure,
        Heart_Rate,
        Cholesterol_Level,
        ROUND(BMI, 2) AS BMI,
        TRIM(Diagnosis) AS Diagnosis,
        TRIM(Treatment_Plan) AS Treatment_Plan,
        Follow_Up_Date,
        ROW_NUMBER() OVER (
            PARTITION BY Patient_ID, Follow_Up_Date 
            ORDER BY Follow_Up_Date DESC
        ) AS row_num
    FROM [Healthcare Analytics].[dbo].[healthcare_dataset]
    WHERE Patient_ID IS NOT NULL 
      AND TRIM(CAST(Patient_ID AS VARCHAR(50))) NOT IN ('', 'n/a', 'none', 'null', 'unknown')
)
SELECT 
    Patient_ID,
    Age,
    Gender,
    Blood_Pressure,
    Heart_Rate,
    Cholesterol_Level,
    BMI,
    Diagnosis,
    Treatment_Plan,
    Follow_Up_Date
INTO [Healthcare Analytics].dbo.healthcare_dataset_cleaned
FROM RankedData
WHERE row_num = 1;


-- ============================================================================
-- STEP 3: VERIFY RESULTS
-- ============================================================================
-- Compare total row counts
SELECT COUNT(*) AS raw_count FROM [Healthcare Analytics].[dbo].[healthcare_dataset];
SELECT COUNT(*) AS clean_count FROM [Healthcare Analytics].dbo.healthcare_dataset_cleaned;

-- View sample rows of the newly created full table
SELECT TOP 20 * 
FROM [Healthcare Analytics].dbo.healthcare_dataset_cleaned;


SELECT COUNT(*) AS raw_count FROM [Healthcare Analytics].[dbo].[healthcare_dataset];
SELECT COUNT(*) AS clean_count FROM [Healthcare Analytics].[dbo].[healthcare_dataset_cleaned];


SELECT 
    SUM(CASE WHEN Patient_ID IS NULL THEN 1 ELSE 0 END) AS null_patients,
    SUM(CASE WHEN Diagnosis IS NULL THEN 1 ELSE 0 END) AS null_diagnoses
FROM [Healthcare Analytics].[dbo].[healthcare_dataset_cleaned];


SELECT TOP 20 * 
FROM [Healthcare Analytics].dbo.healthcare_dataset_cleaned;


SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME IN ('Patients', 'Doctors', 'Admissions', 'Appointments', 'Hospital_Beds');


SELECT 'Patients' AS Table_Name, COUNT(*) AS Total_Rows FROM Patients
UNION ALL
SELECT 'Doctors', COUNT(*) FROM Doctors
UNION ALL
SELECT 'Admissions', COUNT(*) FROM Admissions
UNION ALL
SELECT 'Appointments', COUNT(*) FROM Appointments
UNION ALL
SELECT 'Hospital_Beds', COUNT(*) FROM Hospital_Beds;


SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'healthcare_dataset_cleaned';



