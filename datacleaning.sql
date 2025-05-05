-- Data Cleaning

-- 1. Change date format and data type

UPDATE employee_data 
SET `StartDate` = str_to_date(`StartDate`, '%d-%b-%Y'),
`ExitDate` = CASE
    WHEN `ExitDate` IS NULL OR `ExitDate` IN ('', 'N/A', 'Unknown') THEN NULL
    WHEN STR_TO_DATE(`ExitDate`, '%d-%b-%Y') IS NOT NULL THEN STR_TO_DATE(`ExitDate`, '%d-%b-%Y')
    ELSE NULL
END;

ALTER TABLE employee_data
MODIFY COLUMN `StartDate` DATE NULL,
MODIFY COLUMN `ExitDate` DATE NULL;

-- 2. Checking for duplicates
SELECT employee_id, ROW_NUMBER() OVER (PARTITION BY employee_id) AS row_num
FROM employee_data;

WITH cte AS
(SELECT employee_id, ROW_NUMBER() OVER (PARTITION BY employee_id) AS row_num
FROM employee_data)
SELECT employee_id, row_num
FROM cte
WHERE row_num >= 2;

SELECT Trainer, ROW_NUMBER() OVER (PARTITION BY Trainer) AS row_num
FROM training_and_development_data;

WITH cte2 AS
(SELECT Trainer, ROW_NUMBER() OVER (PARTITION BY Trainer) AS row_num
FROM training_and_development_data)
SELECT Trainer, row_num
FROM cte2
WHERE row_num >= 2
-- Duplicates based on trainers are acceptable since they may teach different classes/batches of students.