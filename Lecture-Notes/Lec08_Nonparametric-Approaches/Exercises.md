# Lecture 8 Exercises — Nonparametric Approaches

[Repository Guide](../../README.md) | [English](Exercises.md) | [한국어](Exercises.ko.md)

> **Last Updated:** 2026-11-04

Exercises 1-8 ask you to compute the t-test and the Wilcoxon tests by hand, and to carry out normality checks, transformations, and power simulations in R. The required concepts are in the [Lecture 8 note](Concepts_Lecture.md), and base R functions are enough to solve them.

---

<br>

## Table of Contents

- [Exercise 1: A Two-Sample t-Test by Hand](#exercise-1-a-two-sample-t-test-by-hand)
- [Exercise 2: Two Insecticides with Different Variances](#exercise-2-two-insecticides-with-different-variances)
- [Exercise 3: A Paired t-Test on Blood Pressure](#exercise-3-a-paired-t-test-on-blood-pressure)
- [Exercise 4: Normality and Transformation of Ozone Levels](#exercise-4-normality-and-transformation-of-ozone-levels)
- [Exercise 5: A Wilcoxon Rank-Sum Test by Hand](#exercise-5-a-wilcoxon-rank-sum-test-by-hand)
- [Exercise 6: A Rank-Sum Test with Ties](#exercise-6-a-rank-sum-test-with-ties)
- [Exercise 7: A Signed-Rank Test on the Blood Pressure Data](#exercise-7-a-signed-rank-test-on-the-blood-pressure-data)
- [Exercise 8: Power Under a Heavy-Tailed Distribution](#exercise-8-power-under-a-heavy-tailed-distribution)

---

<br>

## Exercise 1: A Two-Sample t-Test by Hand

**Problem:** The following values were obtained from two independent groups.

- Group A: 12, 15, 11, 14, 13
- Group B: 16, 18, 15, 17, 19, 17

Assuming equal variances in the two groups, compute by hand the sample means, the sums of squared deviations, the pooled standard deviation $s_p$, the standard error, the t statistic, and the degrees of freedom. Use $t_{0.025, 9} = 2.262$ to draw the conclusion of a two-sided test at the significance level 0.05, and check with R's `t.test()`.

**[Solution](Solutions.md#exercise-1-a-two-sample-t-test-by-hand)**

---

<br>

## Exercise 2: Two Insecticides with Different Variances

**Problem:** In R's `InsectSprays` data, compare the insect counts in the plots treated with insecticides A and C (12 plots each). Find the mean and standard deviation of each group, and test with the F test whether the two variances are equal. Based on the result, decide whether Student's t-test or the Welch t-test is appropriate, and compare the t statistics, degrees of freedom, and p-values of the two tests.

**[Solution](Solutions.md#exercise-2-two-insecticides-with-different-variances)**

---

<br>

## Exercise 3: A Paired t-Test on Blood Pressure

**Problem:** The systolic blood pressure (mmHg) of 8 patients was measured before and 4 weeks after they started a new drug.

| Patient | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
|:-----|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|
| Before | 140 | 152 | 138 | 145 | 160 | 148 | 155 | 142 |
| After | 132 | 147 | 139 | 139 | 151 | 145 | 148 | 138 |

*Table 1. Systolic blood pressure of 8 patients before and after the drug*

Compute by hand the mean and standard deviation of the differences $d_i$ (before minus after) and the paired t statistic with its degrees of freedom, and use $t_{0.025, 7} = 2.365$ to draw the conclusion of a two-sided test at the significance level 0.05. Check with R, and compare with the p-value of the independent two-sample t-test that ignores the pairing.

**[Solution](Solutions.md#exercise-3-a-paired-t-test-on-blood-pressure)**

---

<br>

## Exercise 4: Normality and Transformation of Ozone Levels

**Problem:** `Ozone` in R's `airquality` data is the mean ozone level (ppb) measured each day from 1 p.m. to 3 p.m. in New York, United States, from May to September 1973, and it contains missing values (`NA`). After removing the missing values, find the number of observations and the summary statistics, and compare the Shapiro-Wilk p-values of the original data, the square-root transformation, and the log transformation. Draw normal Q-Q plots of the original and log-transformed data and explain the effect of the transformation.

**[Solution](Solutions.md#exercise-4-normality-and-transformation-of-ozone-levels)**

---

<br>

## Exercise 5: A Wilcoxon Rank-Sum Test by Hand

**Problem:** The following values were obtained from two independent groups.

- Group 1: 3.1, 4.5, 2.8, 5.0
- Group 2: 6.2, 4.9, 7.1, 5.8, 6.6

Rank the pooled sample to find the rank sum $W$ of group 1, and find $\mu_W$, $\sigma_W$, the $z$ of the normal approximation, and the two-sided p-value, both without and with the continuity correction. Also find the exact two-sided p-value by counting all possible rank combinations, and compare with R's `wilcox.test()`.

**[Solution](Solutions.md#exercise-5-a-wilcoxon-rank-sum-test-by-hand)**

---

<br>

## Exercise 6: A Rank-Sum Test with Ties

**Problem:** The following values were obtained from two independent groups.

- Group 1: 10, 12, 12, 15
- Group 2: 12, 14, 15, 18, 20

Handle the ties with average ranks to find the rank sum $W$ of group 1, and compute by hand the tie-corrected $\sigma_W$, the continuity-corrected $z$, and the two-sided p-value. Explain the `W` and p-value reported by R's `wilcox.test()`.

**[Solution](Solutions.md#exercise-6-a-rank-sum-test-with-ties)**

---

<br>

## Exercise 7: A Signed-Rank Test on the Blood Pressure Data

**Problem:** Apply the Wilcoxon signed-rank test to the blood pressure data of Exercise 3. Rank the absolute differences to find $T^+$, and compute by hand the exact two-sided p-value using the $2^8 = 256$ sign patterns that are possible under the null hypothesis. Compare with R's result and with the p-value of the paired t-test.

**[Solution](Solutions.md#exercise-7-a-signed-rank-test-on-the-blood-pressure-data)**

---

<br>

## Exercise 8: Power Under a Heavy-Tailed Distribution

**Problem:** Using the simulation function `power_sim()` of Lecture 8, Section 5.3, find the rejection rates of the t-test and the Wilcoxon rank-sum test for two groups (20 each) drawn from the t distribution with 3 degrees of freedom (`rt(n, df = 3)`), with shifts 0 and 0.8 and 2,000 repetitions each (random seed 42). Compare the results with those for the normal and lognormal distributions.

**[Solution](Solutions.md#exercise-8-power-under-a-heavy-tailed-distribution)**
