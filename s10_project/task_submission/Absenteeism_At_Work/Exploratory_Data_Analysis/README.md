# Absenteeism At Work

### Overview:

This application is written with Python script using Numpy, Pandas Matplotlib and statsmodels libraries to explore data from csv file employees' absence at work from July 2007 to July 2010 at a courier company in Brazil.

Gathering, assessing and cleaning data trying to understand more details about it and identify any issues and modify the dataset for easy and fast analysis.
Explore this data and try to find patterns in it, compute statistics and visualize the relationships to answer the required questions, build linear and logistic regression models to detect the important variables and characteristics that affect employees' absence.

### The main target from this application is to answer these questions:

*  What is the most frequent reason for absences?
*  Which absence reasons have higher rate medical or non medical reasons?
*  Who are the best employees and the worst employees compared by total absence hours?
*  Which month and day have the higher total absence hours?
*  Which variables have strong correlation with absence hours?
*  Which variables are statistically significant to predict absence and total absence hours? (Regression models)

### Dataset descriptions:

 This dataset was created with records of absence at work from July 2007 to July 2010 at a courier company in Brazil.
 
### Dataset columns description:

* Individual identification (ID):the unique identifier for each employee.
* Reason for absence (ICD):
* Absences attested by the International Code of Diseases (ICD) stratified into 21 categories (I to XXI) as follows:
    - (0) There is no absence.
    - (1) Certain infectious and parasitic diseases
    - (2) Neoplasms
    - (2) Diseases of the blood and blood-forming organs and certain disorders involving the immune mechanism > * (4) Endocrine, nutritional and metabolic diseases
    - (5) Mental and behavioural disorders
    - (6) Diseases of the nervous system
    - (7) Diseases of the eye and adnexa
    - (8) Diseases of the ear and mastoid process
    - (9) Diseases of the circulatory system
    - (10) Diseases of the respiratory system
    - (11) Diseases of the digestive system
    - (12) Diseases of the skin and subcutaneous tissue
    - (13) Diseases of the musculoskeletal system and connective tissue
    - (14) Diseases of the genitourinary system
    - (15) Pregnancy, childbirth and the puerperium
    - (16) Certain conditions originating in the perinatal period
    - (17) Congenital malformations, deformations and chromosomal abnormalities
    - (18) Symptoms, signs and abnormal clinical and laboratory findings, not elsewhere classified
    - (19) Injury, poisoning and certain other consequences of external causes
    - (20) External causes of morbidity and mortality
    - (21) Factors influencing health status and contact with health services.
    - (22) Factors influencing health status and contact with health services.
* And 7 categories without (CID) patient follow-up as follows:
    - (23) blood donation.
    - (24) aboratory examination.
    - (25) unjustified absence.
    - (26) physiotherapy.
    - (27) dental consultation.
    - (28) Month of absence.
* Month of absence: (Jan (1), Feb (2), Mar (3) ... ect)
* Day of the week: (Monday (2), Tuesday (3), Wednesday (4), Thursday (5), Friday (6))
* Seasons: (summer (1), autumn (2), winter (3), spring (4))
* Transportation expense.
* Distance from Residence to Work: (kilometers)
* Service time.
* Age.
* Work load Average/day.
* Hit target.
* Disciplinary failure: (yes=1; no=0)
* Education: (high school (1), graduate (2), postgraduate (3), master and doctor (4))
* Son: (number of children)
* Social drinker: (yes=1; no=0)
* Social smoker: (yes=1; no=0)
* Pet: (number of pet)
* Weight.
* Height.
* Body mass index.
* Absenteeism time in hours.
