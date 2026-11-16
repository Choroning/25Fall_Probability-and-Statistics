# HW2 Assignment Handout — One-Sample Z-Test

[Repository Guide](../../../README.md) | [English](Assignment.md) | [한국어](Assignment.ko.md)

> **Last Updated:** 2026-11-16

This is the second assignment of Probability and Statistics. Its purpose is to apply the statistical hypothesis tests learned in class to real medical data through R programming. Students must also learn how to import data by searching the web or referring to the course textbooks, such as https://rafalab.github.io/dsbook/importing-data.html. The final exam is also a practical exam, so students must study how to import data. The distributed answer form is [HW2.docx](HW2.docx).

- **Data:** Unpacking the compressed file downloaded from Blackboard gives the data file `Data.txt`. In this repository it is at [`data/Data.txt`](../data/Data.txt).
- **Collaboration:** Students may consult with a friend, but copying R code is absolutely prohibited. Copying is a shortcut to an F grade.
- **Submission:** Fill in the blanks of the report below, then compress and submit this report (.docx) and the entire R code (.R file) you wrote. The R code must be executable when the TA runs it, and the compressed file (.zip) must be named `HW2_YourID_Yourname.zip`.

---

<br>

## Importing the Data

Placing `Data.txt` in the working directory (`setwd(XXX)`) and using the `fread()` function of the data.table package as follows loads the data.

```r
library(data.table)
data <- data.frame(fread("Data.txt", sep = "\t", head=T, stringsAsFactors = T))
dim(data)
```

```text
> dim(data)
[1] 8921   14
```

The following features can be observed in the data, and all of them are values actually used in clinical practice.

| Feature | Description |
|:-----|:-----|
| Age | Age at current visit |
| Gender | Gender (1 = Male, 2 = Female) |
| Race | Race of subject (1 = White, 2 = Black or African American) |
| Height | Height, cm |
| Weight | Weight, kg |
| sysBP | Systolic blood pressure, mmHg |
| HR | Heart rate (bpm) |
| Resting_SaO2 | Resting SaO2, % |
| BMI | BMI |
| HaveCough | Do you usually have a cough (exclude clearing of throat), 1 = Yes, 0 = No |
| FEV1 | FEV1 % pred, post-Utah |
| FVC | FVC % pred, post-Utah |
| FEV1_FVC | FEV1/FVC, post-Utah |
| Disease | Class label |

*Table 1. Features of the data and their descriptions*

> **Note:** In `data/Data.txt` the actual column names are `Height_CM` instead of `Height` and `Weight_KG` instead of `Weight`, there is no `FEV1_FVC` column, and an `ID` column comes first.

Solve the problems below in this state. In the decision (Decision Making) of each problem, the statistical conclusion must use all of the terms "Null hypothesis", "Reject", "Alternative hypothesis", "Select", and "Significance level."

---

<br>

## Q1. Comparison with the Systolic Blood Pressure of Normal People

According to the NIH of the United States, the systolic blood pressure of normal people follows the distribution sysBP ~ N(128.65, σ = 16.5). Perform the following hypothesis test at the 5% significance level to find evidence that COVID19 patients are different from the loaded data.

```math
H_0: \text{Collected samples are not biased}
```

```math
H_1: \text{The sample collected will be different from the population}
```

$H_0$ states that the collected samples are not biased, and $H_1$ states that the collected sample will be different from the population. The boxes of the answer form are as follows.

- (1) Test statistics
- (4) P-value
- (5) Decision Making at 5% significance level

---

<br>

## Q2. Systolic Blood Pressure of COVID19 Patients

Under the same conditions as Q1, test statistically at the 5% significance level whether COVID19 patients show higher systolic blood pressure than the known national statistics. The `subset()` or `which()` function can be used to extract the COVID19 subjects.

- (1) Alternative Hypothesis
- (2) Null Hypothesis
- (3) Test statistics
- (4) P-value
- (5) Decision Making at 5% significance level

---

<br>

## Q3. Tests of Male Heart Rate in Three Directions

According to the National Institutes of Health (NIH) of the United States, the heart rate of men follows the distribution HR_male ~ N(74.62, σ² = 11.1). Based on this, set up alternative hypotheses in three different directions and test each at the 5% significance level. Then interpret the final outcome of the analysis clearly in statistical terms.

---

<br>

## Q4. The Same Analysis at the 10% Significance Level

Perform the same analysis as in Q3 at the 10% significance level. Then describe what is different from Q3 and what can be learned from it.

---

<br>

## Q5. Resting Oxygen Saturation

In the basic health checkup of Koreans surveyed by Korea's National Health Insurance Service, resting SaO2 is known to have a mean of 96.0245 and a variance of 8.995. Based on this, perform a hypothesis test to conclude whether the currently loaded `Data.txt` is an independent population in terms of resting SaO2. The significance level may be set freely at an acceptable level, but the test must lead cleanly to the statistically correct conclusion.

---

<br>

After solving the problems, see the [assignment explanation](../Assignment-Explanation.md) for the answers and solutions and the [code walkthrough](../Code-Walkthrough.md) for the complete code.
