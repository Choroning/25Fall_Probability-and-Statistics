# Lecture 7 Exercises — Statistical Analysis

[Repository Guide](../../README.md) | [English](Exercises.md) | [한국어](Exercises.ko.md)

> **Last Updated:** 2026-11-04

Exercises 1-8 ask you to choose analysis methods and to compute the tests of the four analysis types by hand or carry them out on built-in R data. The required concepts are in the [Lecture 7 note](Concepts_Lecture.md), and base R functions are enough to solve them.

---

<br>

## Table of Contents

- [Exercise 1: Choosing an Analysis Method](#exercise-1-choosing-an-analysis-method)
- [Exercise 2: Tooth Growth by Supplement Type](#exercise-2-tooth-growth-by-supplement-type)
- [Exercise 3: A Permutation Test for the Low-Dose Group](#exercise-3-a-permutation-test-for-the-low-dose-group)
- [Exercise 4: One-Way ANOVA by Hand](#exercise-4-one-way-anova-by-hand)
- [Exercise 5: Chick Weight by Feed](#exercise-5-chick-weight-by-feed)
- [Exercise 6: Waiting Time and Eruption Time of a Geyser](#exercise-6-waiting-time-and-eruption-time-of-a-geyser)
- [Exercise 7: A Chi-Squared Test on Graduate Admissions Data](#exercise-7-a-chi-squared-test-on-graduate-admissions-data)
- [Exercise 8: Fisher's Exact Test for a Small Contingency Table](#exercise-8-fishers-exact-test-for-a-small-contingency-table)

---

<br>

## Exercise 1: Choosing an Analysis Method

**Problem:** For each of the following five research situations, identify the types of the dependent and independent variables, state which of the four analysis types of Lecture 7 applies, and choose a suitable test (including the alternative when normality is doubtful).

- (a) Compare the tooth cell lengths of 30 guinea pigs given vitamin C as orange juice and 30 given it as ascorbic acid.
- (b) Compare whether chick weight differs among six types of feed.
- (c) Analyze the relationship between the time a geyser was waited for before erupting and the duration of the eruption.
- (d) Analyze whether the sex of graduate applicants is associated with admission.
- (e) Give both of two sleeping drugs to the same 10 patients and compare the extra hours of sleep.

**[Solution](Solutions.md#exercise-1-choosing-an-analysis-method)**

---

<br>

## Exercise 2: Tooth Growth by Supplement Type

**Problem:** R's `ToothGrowth` data give vitamin C to 60 guinea pigs as orange juice (`supp = "OJ"`) or as ascorbic acid (`supp = "VC"`) and measure the length of the cells responsible for tooth growth (`len`) (30 animals each). Find the mean and standard deviation for each supplement, and at the significance level 0.05 test whether the mean `len` differs between the supplements with the Welch t-test and whether the distributions differ with the Wilcoxon rank-sum test. Compare the two results.

**[Solution](Solutions.md#exercise-2-tooth-growth-by-supplement-type)**

---

<br>

## Exercise 3: A Permutation Test for the Low-Dose Group

**Problem:** From `ToothGrowth`, select only the 20 guinea pigs that received 0.5 mg per day (10 per supplement) and carry out a permutation test with 10,000 repetitions (random seed 7) whose statistic is the difference in mean `len` between the two supplements. Find the two-sided permutation p-value and compare it with the p-value of the Welch t-test.

**[Solution](Solutions.md#exercise-3-a-permutation-test-for-the-low-dose-group)**

---

<br>

## Exercise 4: One-Way ANOVA by Hand

**Problem:** Four observations were obtained from each of three groups.

| Group | Observations |
|:-----|:-----|
| A | 5, 7, 6, 6 |
| B | 8, 9, 7, 8 |
| C | 4, 5, 6, 5 |

*Table 1. Observations of the three groups*

Compute by hand the between-group sum of squares $SSB$, the within-group sum of squares $SSW$, the mean squares, and the $F$ statistic, and draw a conclusion at the significance level 0.05 by comparing with 4.256, the 95% quantile of the $F_{2, 9}$ distribution. Check the result with R's `aov()`.

**[Solution](Solutions.md#exercise-4-one-way-anova-by-hand)**

---

<br>

## Exercise 5: Chick Weight by Feed

**Problem:** R's `chickwts` data are the weights (`weight`, g) of 71 newly hatched chicks after they were randomly divided into six feed groups (`feed`) and raised for six weeks. Find the mean weight for each feed and test with one-way ANOVA whether the mean weight differs by feed. Check the normality of the residuals (Shapiro-Wilk test) and the equality of variances (Bartlett's test), and compare with the result of the Kruskal-Wallis test.

**[Solution](Solutions.md#exercise-5-chick-weight-by-feed)**

---

<br>

## Exercise 6: Waiting Time and Eruption Time of a Geyser

**Problem:** R's `faithful` data record, for 272 eruptions of the Old Faithful geyser in Yellowstone National Park in the United States, the waiting time before the eruption (`waiting`, minutes) and the duration of the eruption (`eruptions`, minutes). Find the following.

- (a) The Pearson correlation coefficient of the two variables with its test, and the Spearman rank correlation coefficient
- (b) The simple linear regression equation explaining `eruptions` by `waiting`, and its coefficient of determination
- (c) The predicted eruption duration for a waiting time of 80 minutes
- (d) The regression coefficients computed by hand from the mean 70.897 and standard deviation 13.595 of `waiting` and the mean 3.488 and standard deviation 1.141 of `eruptions`

**[Solution](Solutions.md#exercise-6-waiting-time-and-eruption-time-of-a-geyser)**

---

<br>

## Exercise 7: A Chi-Squared Test on Graduate Admissions Data

**Problem:** R's `UCBAdmissions` data are a three-dimensional table that counts the applicants to the six largest departments of the graduate school of UC Berkeley in the United States in 1973 by admission (`Admit`), sex (`Gender`), and department (`Dept`). Form the 2 × 2 contingency table of admission by sex, combining the departments, and answer the following.

- (a) Find the admission rate by sex, and test whether the two variables are independent with the chi-squared test (without continuity correction). Also find the expected counts and Pearson residuals.
- (b) Find the admission rates by department and sex, and explain what one must be careful about when comparing them with the conclusion of (a).

**[Solution](Solutions.md#exercise-7-a-chi-squared-test-on-graduate-admissions-data)**

---

<br>

## Exercise 8: Fisher's Exact Test for a Small Contingency Table

**Problem:** Among 9 patients with a rare disease, all 4 with a gene variant responded to treatment, while only 1 of the 5 without the variant responded.

| Variant \ Response | Response | No response | Total |
|:-----|:-----:|:-----:|:-----:|
| Yes | 4 | 0 | 4 |
| No | 1 | 4 | 5 |
| Total | 5 | 4 | 9 |

*Table 2. Contingency table of gene variant and treatment response*

Find the expected count of each cell and explain why the chi-squared test is not appropriate. Then compute all hypergeometric probabilities for the number of responders among the patients with the variant, compute the two-sided p-value of Fisher's exact test by hand, and check it with R's `fisher.test()`.

**[Solution](Solutions.md#exercise-8-fishers-exact-test-for-a-small-contingency-table)**
