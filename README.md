# **HR ANALYSIS SQL PROJECT**



###### 

###### **Project Overview:**

This project analyzes a human resources dataset of 100,000 employees

using SQL. The goal is to uncover patterns in employee resignation,

salary, performance, and satisfaction using structured queries on a

normalized relational database.



###### **Tools Used:**

\- MySQL Workbench





###### 

###### **Dataset**

\- Source: Kaggle

\- Rows: 100,000 employees

\- Columns: 20 features including salary, performance, tenure,

&#x20; remote work, training, promotions and resignation status.



###### 

###### **Database Schema**

The flat CSV was normalized into 5 tables:



| Table               | Description                        |

|---------------------|------------------------------------|

| employees           | Core employee info and FK links    |

| department          | Department lookup table            |

| job                 | Job title lookup table             |

| work\_stats          | Salary, hours, projects, overtime  |

| employee\_outcomes   | Performance, satisfaction, resigned|



###### 

###### **Analysis Questions \& Insights**



###### **Q1: Resignation Rate by Department**

Query: resignation rate grouped by department



Highest resignation: Finance (10.54%) and HR (10.26%)

Lowest resignation:  IT (9.56%) and Engineering (9.65%)



Insight: Resignation rates are fairly uniform across all

departments (9.5% - 10.5%) suggesting resignation is not

department-specific but driven by other factors like salary,

satisfaction or overtime.



The \~1% difference between highest and lowest is too small

to conclude any department has a serious retention problem.





###### **Q2: Average Salary by Department**

Highest: Engineering ($6,417) and IT ($6,414)

Lowest:  Marketing ($6,377) and Legal ($6,391)



Insight: Salary differences across departments are extremely

small — only $40 separates the highest from lowest paid

department. This suggests the company has a standardized

salary structure not based on department but likely on

job title or performance score instead.



###### **Q3: Average Performance Score by Department**

Highest: Engineering (3.02) and Operations (3.01)

Lowest:  Marketing (2.98) and Legal (2.98)



Insight: Performance scores are almost identical across all

departments — difference of only 0.04 between highest and

lowest. This is the third consecutive analysis showing

uniformity across departments.



*Note: Combined insight from Q1, Q2, Q3:*

*Department is NOT a significant factor in this dataset.*

*Resignation rate, salary and performance all show less than*

*1% variation across departments. Analysis should focus on*

*job title, tenure, training or remote work instead for*

*more meaningful patterns.*



###### **Q4: Satisfaction Score vs Resignation**

Not Resigned (0): avg satisfaction 3.01

Resigned (1):     avg satisfaction 2.99



Insight: Almost no difference in satisfaction between employees

who resigned and those who stayed — only 0.02 gap. This is 

surprising as satisfaction is usually a key driver of attrition.



This suggests satisfaction score alone cannot predict or explain

resignation in this company. Other factors like salary, overtime

or promotions may be stronger drivers of attrition.



###### **Q5: Overtime Hours vs Resignation**

Not Resigned (0): avg overtime 14.51 hrs

Resigned (1):     avg overtime 14.58 hrs

Insight: Virtually no difference in overtime between employees

who resigned and those who stayed — only 0.07 hour gap.

Overtime is NOT a driver of resignation in this company.



*Note: Overall Pattern (Q1-Q5):*

*This dataset consistently shows near-identical values across*

*all groupings — department, salary, performance, satisfaction*

*and overtime all show minimal variation. This suggests the*

*dataset may be synthetically generated with uniform*

*distributions rather than real-world HR data.*



###### **Q6: Resignation Rate by Tenure**

Highest: 1-3 years (10.12%) and 5+ years (10.04%)

Lowest:  under 1 year (9.79%) and 3-5 years (9.90%)



Insight: Employees in their first year are least likely to quit —

still adjusting and settling in. The 1-3 year mark is the most

critical period where resignation peaks, possibly because

employees feel stuck or see no growth. Interestingly 5+ year

employees also resign at a high rate suggesting long term staff

may face burnout or hit a career ceiling. Tenure appears to be

a more meaningful predictor of resignation than department or

salary in this dataset.



###### **Q7: Training Hours vs Performance Score**

High (51-75hrs):     3.00

Very High (76-99hrs): 3.00

Low (0-24hrs):       2.99

Medium (25-50hrs):   2.99



Insight: More training does not improve performance in this 

dataset — all four groups score virtually the same (2.99-3.00).

Training hours appear to have no measurable impact on employee

performance scores.



###### **Q8: DOES Promotions REDUCES Resignation Rate?**

0 promotions: 10.00%

1 promotion:  10.00%

2 promotions: 10.00%



Insight: Promotions have zero impact on resignation in this

dataset — all three groups show identical 10% resignation rate.

This further confirms the dataset is likely synthetic with

artificially uniform distributions.

###### 

###### **Q9: Does age affect salary, performance and**

###### **resignation rate?**

Highest salary:      50+ ($6,407) and 40-50 ($6,405)

Highest resignation: 50+ (10.18%) and 40-50 (10.11%)

Lowest resignation:  Under 30 (9.84%) and 30-40 (9.89%)



Insight: Older employees earn slightly more but resign at

higher rates possibly due to retirement or career changes.

Younger employees under 30 are least likely to leave.

Performance is identical across all age groups suggesting

age has no influence on how well employees perform.





###### Q**10: Business Question: Do higher performers earn more?**



Score 5: $7,397 | Score 4: $6,897 | Score 3: $6,409

Score 2: $5,900 | Score 1: $5,422



Insight: Clear positive relationship — every step up in

performance score adds roughly $500 in monthly salary.

Top performers (score 5) earn 36% more than lowest (score 1).

First strong pattern found in this dataset.

###### 

###### 

###### **Q11:: Does remote work frequency affect performance and satisfaction?**



Insight: No — all remote work levels show near identical

performance and satisfaction scores (\~3.00).





###### **Q12: Is there a gender pay gap or performance**

###### **difference?**



Male:   $6,400 | performance 3.00

Female: $6,404 | performance 2.99

Other:  $6,414 | performance 3.00



Insight: No significant gender pay gap exists — difference

of only $14 between male and female salaries. Performance

is identical across all genders. This company appears to

have an equitable salary structure regardless of gender.







###### **Key Findings**

1\. Performance score is the strongest driver of salary —

&#x20;  each performance level adds \~$500 monthly.

2\. Tenure is the best predictor of resignation — employees

&#x20;  are most at risk between 1-3 years.

3\. Department, gender, overtime, remote work and promotions

&#x20;  show no significant impact on any outcome.

4\. Dataset shows highly uniform distributions across most

&#x20;  variables consistent with synthetic data generation.



###### &#x20;**Author:**

Sameen Omer













