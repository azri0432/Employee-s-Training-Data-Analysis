-- Exploratory Data Analysis

-- 1a. Failed training losses by training program
SELECT 
Training_Program_Name,
Training_Outcome,
SUM(Training_Cost) AS Failed_Training_Losses
FROM training_and_development_data
WHERE Training_Outcome = 'Failed'
GROUP BY Training_Program_Name, Training_Outcome;

-- 1b. Cost Optimization
SELECT 
Training_Program_Name,
ROUND(SUM(Training_Cost)) AS Failed_Training_Losses,
ROUND(SUM(CASE WHEN Training_Outcome = 'Failed' THEN 1 ELSE 0 END) / COUNT(employee_id) * 100, 2) AS Failure_Percentage
FROM training_and_development_data
GROUP BY Training_Program_Name
ORDER BY Failure_Percentage DESC;

-- 2a. Employees that fail their training and their job performance
SELECT 
e.employee_id,
e.FirstName,
e.LastName,
e.BusinessUnit,
e.Division,
e.Performance_Score,
e.Current_Employee_Rating,
e.ExitDate,
t.Training_Program_Name,
t.Training_Outcome
FROM employee_data e
JOIN training_and_development_data t ON e.employee_id = t.employee_id
WHERE t.Training_Outcome = 'Failed'
ORDER BY e.Current_Employee_Rating ASC;

-- 2b. Number of terminated employees who failed their training

SELECT 
e.employee_id,
e.FirstName,
e.LastName,
e.BusinessUnit,
e.Division,
e.Performance_Score,
e.TerminationType,
e.Current_Employee_Rating,
e.ExitDate,
t.Training_Program_Name,
t.Training_Outcome
FROM employee_data e
JOIN training_and_development_data t ON e.employee_id = t.employee_id
WHERE t.Training_Outcome = 'Failed' AND e.ExitDate IS NOT NULL
ORDER BY e.Current_Employee_Rating ASC;

-- 2c. Training programs that employees fail the most
SELECT 	Training_Program_Name, 
		COUNT(*) AS failed_employees 
FROM training_and_development_data
WHERE Training_Outcome = 'Failed'
GROUP BY Training_Program_Name
ORDER BY failed_employees DESC;

-- 2d. Percentage of employee failure by training program
SELECT 	t.Training_Program_Name,
		COUNT(t.employee_id) AS total_employees,
        SUM(CASE WHEN t.Training_Outcome = 'Failed' THEN 1
			ELSE 0
        END) AS failed_employees,
        ROUND(
        SUM(CASE WHEN t.Training_Outcome = 'Failed' THEN 1
			ELSE 0
        END) / COUNT(*) * 100,
        2) AS failure_percentage
FROM training_and_development_data t
JOIN employee_data e ON t.employee_id = e.employee_id
GROUP BY t.Training_Program_Name
ORDER BY failure_percentage DESC;

-- 3. Terminated employees
SELECT
	employee_id, FirstName, LastName, StartDate, ExitDate, Title, Supervisor, EmployeeStatus, 
	TerminationType, Performance_Score, Current_Employee_Rating
FROM employee_data
WHERE EmployeeStatus LIKE '%Terminated%'
ORDER BY Current_Employee_Rating ASC;

-- 4a. Business Units with most number of employees undergoing training
SELECT COUNT(e.employee_id) AS total_employees_with_training, e.BusinessUnit
FROM employee_data e
JOIN training_and_development_data t ON e.employee_id = t.employee_id
GROUP BY e.BusinessUnit
ORDER BY total_employees_with_training DESC;

-- 4b. Training needs of staffs by title
SELECT e.Title, t.Training_Program_Name, COUNT(e.employee_id) AS no_of_employees
FROM employee_data e
JOIN training_and_development_data t ON e.employee_id = t.employee_id
GROUP BY e.Title, t.Training_Program_Name
ORDER BY no_of_employees DESC;

-- 5a. Distribution of races in training programmes
-- DISCLAIMER: This query is specially purposed to find out underrepresented groups, in order to accommodate them better and drive higher productivity,
-- in line with ESG & DEI policy.
SELECT e.RaceDesc, COUNT(e.RaceDesc) AS total_trainees
FROM employee_data e
JOIN training_and_development_data t ON e.employee_id = t.employee_id
GROUP BY e.RaceDesc;

-- 5b. Count of employees who completed trainings per Race
SELECT e.RaceDesc, COUNT(t.Training_Outcome)
FROM employee_data e
JOIN training_and_development_data t ON e.employee_id = t.employee_id
WHERE t.Training_Outcome = 'Completed' OR t.Training_Outcome = 'Passed'
GROUP BY e.RaceDesc;

-- 5c. Percentage of completed trainings by Race
SELECT e.RaceDesc, COUNT(e.RaceDesc) AS total_trainees,
		SUM(CASE WHEN Training_Outcome = 'Completed' OR Training_Outcome = 'Passed' THEN 1 ELSE 0
			END) AS completed_trainees, 
		ROUND(
        (SUM(CASE WHEN Training_Outcome = 'Completed' OR Training_Outcome = 'Passed' THEN 1 
        ELSE 0
        END) / COUNT(e.RaceDesc)) * 100, 
        2) AS completion_percentage
FROM employee_data e
JOIN training_and_development_data t ON e.employee_id = t.employee_id
GROUP BY e.RaceDesc                                                                                                          
ORDER BY completion_percentage DESC;

-- 6a. Training costs and average employee ratings by business unit
SELECT e.BusinessUnit,
		AVG(e.Current_Employee_Rating) AS average_employee_ratings,
		ROUND(SUM(t.Training_Cost), 2) AS total_cost
FROM training_and_development_data t
JOIN employee_data e ON t.employee_id = e.employee_id
GROUP BY e.BusinessUnit
ORDER BY total_cost DESC;

-- 6b. High spending, high ratings?
WITH ratings_and_costs AS
(
	SELECT e.BusinessUnit,
		AVG(e.Current_Employee_Rating) AS average_employee_ratings,
		ROUND(SUM(t.Training_Cost), 2) AS total_cost
FROM training_and_development_data t
JOIN employee_data e ON t.employee_id = e.employee_id
GROUP BY e.BusinessUnit
)
SELECT *,
RANK() OVER (ORDER BY average_employee_ratings DESC) AS ratings_rank,
RANK() OVER (ORDER BY total_cost DESC) AS spendings_rank
FROM ratings_and_costs;

-- 6c. Employees in high-spending units that are underperforming
WITH costs_by_unit AS
(
	SELECT e.BusinessUnit,
		ROUND(SUM(t.Training_Cost), 2) AS total_cost
FROM training_and_development_data t
JOIN employee_data e ON t.employee_id = e.employee_id
GROUP BY e.BusinessUnit
),
unit_ranks_by_costs AS
(
	SELECT *,
    RANK() OVER (ORDER BY total_cost DESC) AS spending_ranks
    FROM costs_by_unit
)
SELECT 
e.employee_id, e.FirstName, e.LastName, e.Supervisor, e.BusinessUnit, e.Current_Employee_Rating, e.Performance_Score,
t.Training_Date, t.Training_Program_Name, t.Training_Cost, ru.spending_ranks
FROM training_and_development_data t
JOIN employee_data e ON t.employee_id = e.employee_id
JOIN unit_ranks_by_costs ru ON e.BusinessUnit = ru.BusinessUnit
WHERE ru.spending_ranks <= 3
	AND e.Performance_Score = 'Needs Improvement'
ORDER BY ru.spending_ranks ASC;










