# Employee-s-Training-Data-Analysis
Dataset source: Employee/HR Dataset (All in One) by Ravender Singh Rana (https://www.kaggle.com/datasets/ravindrasinghrana/employeedataset)

# Objectives 
This analysis project aims to uncover:
  1. Impact of training to employee performance
  2. Participation of different races in training program (DEI initiative)
  3. Cost optimization opportunities across business units

# Tools used
  1. MySQL - data cleaning and exploratory data analysis
  2. Power BI - data visualization and dashboarding

# Skills applied

SQL 
1. CTEs
2. Window functions (RANK, ROW_NUMBER)
3. Joins
4. Basic querying (SELECT, FROM, WHERE)
5. Sorting (ORDER BY)
6. Conditional logic (CASE WHEN)
7. Aggregations (COUNT, SUM, AVG)
8. Data transformation (calculating percentages, failure rates)

Power BI
1. Data modeling (Establishing relationships across tables with primary keys)
2. DAX (calculated columns/measures)
3. Dashboarding
4. Dynamic filtering (Slicers)

General Analytics
1. Exploratory Data Analysis
2. Cost analysis and optimization
3. DEI analytics

# Key insights
  1. Average employee ratings across business units slightly differ from each other, with PL having the highest average employee ratings. Surprisingly, PL spends less on employee trainings compared to SVG, which spends the most for employee trainings. 
Speculation: Lower employee ratings of SVG unit despite having the highest spending on trainings could suggest a potential mismatch of training programs for employees, with training programs did not tailor to their area of improvement.

  2. That being said, the performance of employees who failed their trainings are mostly satisfactory, in which most of them fully meets their KPI, with SVG and NEL units have the highest percentage of employees who exceeds their targets.
Speculation: Trainings provide mostly theoretical lessons compared to hands-on training. Employees in these units might thrive more through on-the-job tasks, mentorship or exposure to dynamic environments.

  3. In regards to losses from training failures, PL suffers the most from the losses, with losses incurred around $49.5k.
Speculation: PL employees may perform well due to strong job experience and intrinsic capabilities, which helps them to deliver their tasks well and efficient, explaining their high ratings despite their training failures. It is also possible that their employees undergo advanced-level trainings due to their strong job experience, hence explains the higher failure rate.

  4. In line with company's DEI initiative, I have also analyzed the participation in the trainings across diverse racial groups. It is found that white employees has the highest rate of training completion, followed by 'Others' category. Hispanic employees have the lowest rate of training completion out of all racial groups.
Speculation: Language barriers could exist during the training programs, and Hispanic employees may find some words and phrases used in training sessions are quite incomprehensible, not to mention the speech clarity and accent of the instructor. Besides, Hispanic employees may find training content not relevant to their background, hence reducing interest in the training program.

  5. Despite the disparity in training completion rates, the participation of training programs across racial groups are almost equal, with percentages ranging 19% to 20% across 5 racial groups in the company.

# Summary
This project explores employee training data to uncover insights on performance impact, cost optimization, and diversity in participation. Using SQL and Power BI, I analyzed how training outcomes correlate with employee ratings and business unit performance. The dashboard highlights key areas such as underperforming employees in high-spending units, failed training losses by program, and racial participation gaps aligned with the company’s DEI initiatives. The goal is to provide data-driven recommendations to optimize training investments and ensure inclusive access across the organization.

# Limitations and area of improvements
It should be noted that this is my first full-cycle data analysis project, showcasing my ability to extract, analyze, and visualize insights independently using SQL and Power BI. I'm working with a hypothetical data, which may not represent the exact same situation with real-world HR analytics. For the dataset, it is suggested to add a column for date last assessed for employee rating and performance, to fully reflect training effectiveness. Moving forward, I aim to:
  1. Work with real-world datasets to provide more accurate insights
  2. Incorporate predictive analytics to make more informed decisions based on historical data
  3. Improve dashboarding skills to enhance interactivity and data storytelling to captivate stakeholders
