# HW2 Assignment Explanation — One-Sample Z-Test

[Repository Guide](../../README.md) | [English](Assignment-Explanation.md) | [한국어](Assignment-Explanation.ko.md)

> **Last Updated:** 2026-11-04

> **Learning Objectives:**
> 1. Compute the test statistic and p-value of the one-sample Z-test when the population standard deviation is known
> 2. Set the null and alternative hypotheses and the direction of the test (two-sided, right-tailed, left-tailed) to fit the research question
> 3. Decide whether to reject the null hypothesis by comparing the p-value with the significance level, and state the conclusion using all of the terms null hypothesis, alternative hypothesis, reject, select, and significance level
> 4. Explain how the choice of significance level and a choice of direction made after seeing the data affect the conclusion and the type I error
> 5. Distinguish statistical significance from the practical size of a difference in large samples

---

## Table of Contents

- [1. Assignment Structure and Data](#1-assignment-structure-and-data)
- [2. Procedure of the One-Sample Z-Test](#2-procedure-of-the-one-sample-z-test)
- [3. Q1. Systolic Blood Pressure of the Whole Sample](#3-q1-systolic-blood-pressure-of-the-whole-sample)
- [4. Q2. Systolic Blood Pressure of COVID19 Patients](#4-q2-systolic-blood-pressure-of-covid19-patients)
- [5. Q3, Q4. Three Directional Tests of Male Heart Rate](#5-q3-q4-three-directional-tests-of-male-heart-rate)
  - [5.1 Hypotheses and Test Statistic](#51-hypotheses-and-test-statistic)
  - [5.2 Conclusions at the 5% Significance Level (Q3)](#52-conclusions-at-the-5-significance-level-q3)
  - [5.3 Conclusions at the 10% Significance Level (Q4)](#53-conclusions-at-the-10-significance-level-q4)
  - [5.4 When to Choose the Direction of a Test](#54-when-to-choose-the-direction-of-a-test)
  - [5.5 Checking the Population Variance](#55-checking-the-population-variance)
- [6. Q5. Resting Oxygen Saturation](#6-q5-resting-oxygen-saturation)
- [7. Statistical Significance and Practical Size](#7-statistical-significance-and-practical-size)
- [Summary](#summary)
- [Self-Check Questions](#self-check-questions)

---

<br>

## 1. Assignment Structure and Data

The assignment applies the hypothesis testing of Lecture 6, in particular the **one-sample Z-test** with a known population standard deviation, to real clinical data in R. All five problems compare the mean of a sample with the known mean of a population, and only the direction of the test and the significance level change. A line-by-line explanation of the code is in the [HW2 Code Walkthrough](Code-Walkthrough.md).

```plaintext
Coursework/HW02_One-Sample-Z-Test/
├── Assignment-Explanation.ko.md
├── Assignment-Explanation.md
├── Code-Walkthrough.ko.md
├── Code-Walkthrough.md
├── Original/
│   └── HW2.docx                  # Assignment handout (answer template)
├── data/
│   └── Data.txt                  # Clinical data of 8,921 subjects (tab-separated)
└── Solution/
    ├── Q1.R, Q2.R, Q3-4.R, Q5.R  # R code for each problem
    └── Assignment-Report.pdf     # Submitted report
```

*Figure 1. Directory structure of HW2*

`Data.txt` is a tab-separated text file with 8,921 subjects as rows and 14 variables as columns, and it has no missing values. The variables used in this assignment are as follows.

| Variable | Description | Values |
|:-----|:-----|:-----|
| `Gender` | Sex | 1 = male (4,834), 2 = female (4,087) |
| `sysBP` | Systolic blood pressure (mmHg) | Integers |
| `HR` | Heart rate (bpm) | 40-131 |
| `Resting_SaO2` | Resting oxygen saturation (%) | 71-99 |
| `Disease` | Class label | `COVID19` (4,455), `Healthy` (4,466) |

*Table 1. Variables of Data.txt used in HW2*

The other columns are `ID`, `Age`, `Race` (1 = White, 2 = Black or African American), `Height_CM`, `Weight_KG`, `BMI`, `HaveCough` (cough, 1 = yes, 0 = no), and the lung function indices `FEV1` and `FVC` (percent of predicted). The scripts are in the `Solution/` folder and locate the data at `../data` relative to the script, so they are run with RStudio's Source button or with `source()`, as in `source("Coursework/HW02_One-Sample-Z-Test/Solution/Q1.R")`.

---

<br>

## 2. Procedure of the One-Sample Z-Test

The test decides from a sample whether the population mean $\mu$ equals a known reference value $\mu_0$. It assumes that the population standard deviation $\sigma$ is known, that the observations are independent, and that either the population is normal or the sample is large enough for the sample mean to be approximately normal by the **central limit theorem**. The samples in this assignment have thousands of subjects, so the last condition is easily met.

1. **Set the hypotheses:** State the **null hypothesis** $H_0: \mu = \mu_0$ and the **alternative hypothesis**. Depending on the research question, the alternative is one of $H_1: \mu \ne \mu_0$ (two-sided), $H_1: \mu > \mu_0$ (right-tailed), and $H_1: \mu < \mu_0$ (left-tailed).
2. **Fix the significance level:** Before looking at the data, fix the **significance level** $\alpha$, the upper bound on the probability of a **type I error**, which is rejecting the null hypothesis when it is true.
3. **Compute the test statistic:** From the sample size $n$ and the sample mean $\bar{x}$, compute the following. The denominator $\sigma/\sqrt{n}$ is the **standard error**, the standard deviation of the sample mean.

```math
Z = \frac{\bar{x} - \mu_0}{\sigma / \sqrt{n}}
```

4. **Compute the p-value:** When the null hypothesis is true, $Z$ follows the standard normal distribution $N(0, 1)$. The **p-value** is the probability, under the null hypothesis, of a test statistic as extreme as the observed one or more extreme, and it depends on the direction as follows. $\Phi$ is the cumulative distribution function of the standard normal distribution.

| Alternative | p-value | Rejection region ($`\alpha = 0.05`$) | Rejection region ($`\alpha = 0.10`$) |
|:-----|:-----|:-----|:-----|
| $\mu \ne \mu_0$ (two-sided) | $2\lbrace1 - \Phi(\lvert z \rvert)\rbrace$ | $\lvert z \rvert > 1.960$ | $\lvert z \rvert > 1.645$ |
| $\mu > \mu_0$ (right-tailed) | $1 - \Phi(z)$ | $z > 1.645$ | $z > 1.282$ |
| $\mu < \mu_0$ (left-tailed) | $\Phi(z)$ | $z < -1.645$ | $z < -1.282$ |

*Table 2. p-values and rejection regions by direction of the test*

5. **Decide and conclude:** If the p-value is smaller than the significance level, **reject** the null hypothesis and **select** the alternative hypothesis. Otherwise the null hypothesis is not rejected, which does not prove the null hypothesis true but means that the evidence is insufficient to select the alternative. Comparing the p-value with the significance level is the same decision as checking whether the test statistic falls in the **rejection region**.

> **Note:** The null hypothesis of a one-sided test is sometimes written $H_0: \mu \le \mu_0$ (right-tailed) or $H_0: \mu \ge \mu_0$ (left-tailed). The p-value is still computed at the boundary value $\mu = \mu_0$, where the probability of a type I error is largest, so the computation is the same.

---

<br>

## 3. Q1. Systolic Blood Pressure of the Whole Sample

**Problem.** According to the U.S. NIH, the systolic blood pressure of normal people follows $N(128.65, \sigma = 16.5)$. Test the null hypothesis that the collected samples are not biased against the alternative that the samples differ from the population at the 5% significance level.

**Hypotheses.** With $\mu$ the mean systolic blood pressure of the population from which the data were collected, $H_0: \mu = 128.65$ and $H_1: \mu \ne 128.65$. "Different" has no direction, so the test is two-sided.

**Computation.** The sample mean of all 8,921 subjects is $\bar{x} = 128.8486$.

```math
\frac{\sigma}{\sqrt{n}} = \frac{16.5}{\sqrt{8921}} = 0.17469, \qquad Z = \frac{128.8486 - 128.65}{0.17469} = \frac{0.19856}{0.17469} = 1.1366
```

```math
p = 2\lbrace1 - \Phi(1.1366)\rbrace = 0.2557
```

**Conclusion.** $\lvert Z \rvert = 1.137$ is below the rejection boundary 1.960, and the p-value 0.2557 is larger than the significance level 0.05. Therefore the null hypothesis is not rejected, and there is no ground to select the alternative hypothesis. There is no significant evidence that the mean systolic blood pressure of the collected sample differs from the NIH distribution of normal people, and by this criterion the sample cannot be called biased.

A confidence interval gives the same conclusion. The 95% confidence interval for the population mean, $\bar{x} \pm 1.960 \times 0.17469 = (128.51, 129.19)$, contains $\mu_0 = 128.65$, so the two-sided test at the 5% significance level does not reject. The sample standard deviation is 16.76, close to the given $\sigma = 16.5$, so the assumption of a known population standard deviation does not conflict with the data either.

> **Note:** This sample contains 4,455 COVID19 patients and 4,466 healthy subjects. Q1 tests the whole sample of both groups, and the comparison of COVID19 patients alone is Q2.

---

<br>

## 4. Q2. Systolic Blood Pressure of COVID19 Patients

**Problem.** Under the same conditions as Q1, test at the 5% significance level whether COVID19 patients have higher systolic blood pressure than the national statistics.

**Hypotheses.** The research question asks "higher", so the test is right-tailed. With $\mu$ the mean systolic blood pressure of the population of COVID19 patients, the alternative hypothesis is $H_1: \mu > 128.65$ (the mean systolic blood pressure of COVID19 patients is higher than the national statistics), and the null hypothesis is $H_0: \mu = 128.65$ (it equals the national statistics).

**Computation.** The sample mean of the 4,455 subjects with `Disease` equal to `COVID19` is $\bar{x} = 129.4846$.

```math
\frac{\sigma}{\sqrt{n}} = \frac{16.5}{\sqrt{4455}} = 0.24721, \qquad Z = \frac{129.4846 - 128.65}{0.24721} = \frac{0.83462}{0.24721} = 3.3762
```

```math
p = 1 - \Phi(3.3762) = 0.000367
```

**Conclusion.** $Z = 3.376$ exceeds the right-tailed rejection boundary 1.645, and the p-value 0.000367 is smaller than the significance level 0.05. Therefore the null hypothesis is rejected and the alternative hypothesis is selected. At the 5% significance level, the mean systolic blood pressure of COVID19 patients is judged higher than the national statistic of 128.65 mmHg.

The size of the difference, however, is about 0.83 mmHg. The 95% one-sided lower confidence bound matching the right-tailed test is $129.4846 - 1.645 \times 0.24721 = 129.08$, so the population mean is clearly above 128.65, but the difference is small, around 1 mmHg (Section 7).

---

<br>

## 5. Q3, Q4. Three Directional Tests of Male Heart Rate

### 5.1 Hypotheses and Test Statistic

**Problem.** According to the NIH, the heart rate of men follows $N(74.62, \sigma^2 = 11.1)$. Set alternative hypotheses in three directions and test each at the 5% significance level (Q3), then repeat the analysis at the 10% significance level and describe the difference and what can be learned from it (Q4).

With $\mu$ the mean heart rate of the male population, the three pairs of hypotheses are as follows.

| Direction | Null Hypothesis | Alternative Hypothesis | Question |
|:-----|:-----|:-----|:-----|
| Two-sided | $\mu = 74.62$ | $\mu \ne 74.62$ | Does the heart rate of men differ from the NIH statistic? |
| Right-tailed | $\mu = 74.62$ | $\mu > 74.62$ | Is the heart rate of men higher than the NIH statistic? |
| Left-tailed | $\mu = 74.62$ | $\mu < 74.62$ | Is the heart rate of men lower than the NIH statistic? |

*Table 3. Hypotheses of the three directions for male heart rate*

$\sigma^2 = 11.1$ is a variance, so the standard deviation is $\sigma = \sqrt{11.1} = 3.3317$. The sample mean of the 4,834 men with `Gender` equal to 1 is $\bar{x} = 74.7005$.

```math
\frac{\sigma}{\sqrt{n}} = \frac{3.3317}{\sqrt{4834}} = 0.047919, \qquad Z = \frac{74.7005 - 74.62}{0.047919} = \frac{0.08046}{0.047919} = 1.6790
```

All three directions share the same test statistic $Z = 1.679$, and only the p-values differ by direction.

```math
p_{\text{two}} = 2\lbrace1 - \Phi(1.679)\rbrace = 0.0932, \qquad p_{\text{right}} = 1 - \Phi(1.679) = 0.0466, \qquad p_{\text{left}} = \Phi(1.679) = 0.9534
```

Since $\bar{x} > \mu_0$, $Z > 0$, and then the right-tailed p-value is half the two-sided p-value and the left-tailed p-value is 1 minus the right-tailed p-value.

### 5.2 Conclusions at the 5% Significance Level (Q3)

| Direction | p-value | Decision at $\alpha = 0.05$ |
|:-----|-----:|:-----|
| Two-sided | 0.0932 | Null hypothesis not rejected |
| Right-tailed | 0.0466 | Null hypothesis rejected, alternative selected |
| Left-tailed | 0.9534 | Null hypothesis not rejected |

*Table 4. Decisions of the three directional tests at the 5% significance level*

- **Two-sided:** The p-value 0.0932 is larger than the significance level 0.05, so the null hypothesis is not rejected, and there is no ground to select the alternative that the mean heart rate of men differs from 74.62.
- **Right-tailed:** The p-value 0.0466 is smaller than the significance level 0.05, so the null hypothesis is rejected and the alternative that the mean heart rate of men is higher than 74.62 is selected.
- **Left-tailed:** The p-value 0.9534 is far larger than the significance level 0.05, so the null hypothesis is not rejected. The sample mean is above the reference value, so there is no evidence at all for the alternative "lower".

The rejection boundary is 1.960 for the two-sided test and 1.645 for the right-tailed test. $Z = 1.679$ lies between them, so at the same significance level only the test whose direction was fixed to one side rejects. A one-sided test puts the whole $\alpha$ in one tail and detects differences in that direction better, but in principle it cannot detect differences in the opposite direction.

### 5.3 Conclusions at the 10% Significance Level (Q4)

| Direction | p-value | Decision at $\alpha = 0.10$ |
|:-----|-----:|:-----|
| Two-sided | 0.0932 | Null hypothesis rejected, alternative selected |
| Right-tailed | 0.0466 | Null hypothesis rejected, alternative selected |
| Left-tailed | 0.9534 | Null hypothesis not rejected |

*Table 5. Decisions of the three directional tests at the 10% significance level*

The data, the test statistic, and the p-values are exactly the same as in Q3, and only the significance level has changed. The two-sided p-value 0.0932 is larger than 0.05 but smaller than 0.10, so the null hypothesis that was not rejected at the 5% level is rejected at the 10% level and the alternative is selected. The comparison teaches the following.

- **The decision depends on the significance level.** The p-value is determined by the data, while the significance level is the probability of a type I error that the researcher has agreed to accept. With the same evidence, a higher significance level makes rejection easier and increases the **power**, but it equally increases the probability of wrongly rejecting a true null hypothesis.
- **The significance level is fixed before seeing the data.** If the significance level is chosen after seeing the p-value to obtain a desired conclusion, it no longer means the probability of a type I error.
- **Results near a boundary are reported with the p-value itself.** For a result like 0.0932 that lies between two conventional thresholds, reporting the p-value and a confidence interval is more informative than the dichotomy "significant" or "not significant". The 95% confidence interval for the population mean, (74.607, 74.794), contains 74.62, and the 90% confidence interval, (74.622, 74.779), does not. This corresponds exactly to the split decision of the two-sided test at the two significance levels.

### 5.4 When to Choose the Direction of a Test

To conclude "the heart rate of men is higher than the NIH statistic" because only the right-tailed test rejected in Section 5.2, the right-tailed direction must have been fixed by the research question before looking at the data. Choosing the right-tailed test after seeing that the sample mean is above the reference value is equivalent to a test that rejects when $\lvert Z \rvert > 1.645$. The probability of a type I error of that test is twice the nominal significance level.

```math
P(Z > 1.645) + P(Z < -1.645) = 0.05 + 0.05 = 0.10
```

Running all three directions and taking whichever rejects as the conclusion causes the same problem. Without a prior reason for a direction, the test must be two-sided, and then the conclusion at the 5% significance level is "there is insufficient evidence that the mean heart rate of men differs from the NIH statistic".

> **Key Point:** The direction and the significance level of a test are part of the design and are set by the research question. Changing them after seeing the data makes the reported significance level smaller than the actual probability of a type I error.

### 5.5 Checking the Population Variance

The Z-test assumes that the given $\sigma$ is true, so it is worth checking whether the value agrees with the data. The sample standard deviation of the heart rates of the 4,834 men is $s = 12.99$ (sample variance 168.7), about 3.9 times $\sigma = \sqrt{11.1} = 3.33$. With a sample this large, the sample standard deviation is very close to the population standard deviation, so a variance of 11.1 does not fit these data. The standard error is computed about 3.9 times too small, and $Z$ is inflated by the same factor.

If the number 11.1 is a standard deviation rather than a variance ($`\sigma = 11.1`$), it fits the data well, and the results change as follows.

```math
\frac{\sigma}{\sqrt{n}} = \frac{11.1}{\sqrt{4834}} = 0.15965, \qquad Z = \frac{0.08046}{0.15965} = 0.504
```

The p-values are then 0.614 (two-sided), 0.307 (right-tailed), and 0.693 (left-tailed), and no direction rejects the null hypothesis at either the 5% or the 10% significance level. The one-sample t-test, which uses the sample standard deviation instead of assuming the population value, gives the same conclusion with $t = 0.431$ and a two-sided p-value of 0.667.

> **Caution:** The handout writes $\sigma^2 = 11.1$, so Sections 5.1-5.3 follow that notation. However, when a given parameter conflicts strongly with the data, the conclusion of a Z-test is hard to trust. It is a good habit to compare a given parameter with the sample standard deviation before using it, and to use the t-test when the population standard deviation is uncertain.

---

<br>

## 6. Q5. Resting Oxygen Saturation

**Problem.** In the basic health checkup statistics of Koreans surveyed by the National Health Insurance Service, resting oxygen saturation had mean 96.0245 and variance 8.995. Conclude by a hypothesis test whether the loaded `Data.txt` is a separate, independent population in terms of resting oxygen saturation. The significance level may be set at an acceptable level, but the test must lead to a statistically clean conclusion.

**Hypotheses and significance level.** With $\mu$ the mean resting oxygen saturation of the population from which the data were collected, $H_0: \mu = 96.0245$ (equal to the Korean statistic) and $H_1: \mu \ne 96.0245$ (different). There is no prior hypothesis about higher or lower, so the test is two-sided, and the significance level is fixed in advance at the conventional 5%.

**Computation.** The variance is given, so $\sigma = \sqrt{8.995} = 2.9992$, and the sample mean of all 8,921 subjects is $\bar{x} = 96.0666$.

```math
\frac{\sigma}{\sqrt{n}} = \frac{2.9992}{\sqrt{8921}} = 0.031754, \qquad Z = \frac{96.0666 - 96.0245}{0.031754} = \frac{0.04208}{0.031754} = 1.3253
```

```math
p = 2\lbrace1 - \Phi(1.3253)\rbrace = 0.1851
```

**Conclusion.** The p-value 0.1851 is larger than the significance level 0.05, so the null hypothesis is not rejected, and there is no ground to select the alternative that the data form a separate population. The conclusion is the same at the other conventional levels 0.01 and 0.10. The 95% confidence interval for the population mean, (96.004, 96.129), also contains 96.0245. The sample variance 9.035 is nearly equal to the given variance 8.995, so neither the mean nor the spread shows a notable departure from the Korean statistics.

Setting the significance level above 0.1851, for example at 0.20, would allow rejection, but that means accepting a 20% type I error, and above all it chooses the significance level after seeing the p-value, which is not a valid test. A p-value is a probability and always lies between 0 and 1, and the two-sided p-value is twice the area of one tail, $2 \times 0.09253 = 0.1851$.

> **Caution:** Failing to reject the null hypothesis does not prove "it is the same population". This test compares only means, and the result means only that no difference in means appeared even in a large sample whose standard error is just 0.032 percentage points. Oxygen saturation cannot exceed 100%, so its distribution has a long left tail (minimum 71, median 97, maximum 99), but with 8,921 subjects the normal approximation of the sample mean is not a problem.

---

<br>

## 7. Statistical Significance and Practical Size

| Problem | Comparison | $n$ | $\bar{x} - \mu_0$ | Standard Error | $Z$ | p-value |
|:-----|:-----|-----:|-----:|-----:|-----:|-----:|
| Q1 | Systolic blood pressure, all (mmHg) | 8,921 | 0.199 | 0.175 | 1.137 | 0.2557 |
| Q2 | Systolic blood pressure, COVID19 patients (mmHg) | 4,455 | 0.835 | 0.247 | 3.376 | 0.000367 |
| Q3, Q4 | Male heart rate (bpm) | 4,834 | 0.080 | 0.048 | 1.679 | 0.0932 (two-sided) |
| Q5 | Resting oxygen saturation (%) | 8,921 | 0.042 | 0.032 | 1.325 | 0.1851 |

*Table 6. Differences, standard errors, and test statistics of the four tests*

The standard error $\sigma/\sqrt{n}$ is inversely proportional to the square root of $n$, so with thousands of subjects even a tiny difference is several standard errors. The 0.83 mmHg of Q2 is highly significant statistically but smaller than the everyday variation of blood pressure measurements, and the 0.08 bpm of Q3 is clinically meaningless. A hypothesis test answers only "is the difference zero" and not "is the difference important", so a conclusion should report the size of the difference or a confidence interval along with the p-value.

---

<br>

## Summary

| Concept | Key Summary |
|:-----|:-----|
| One-sample Z-test | With a known population standard deviation $\sigma$, it tests whether the population mean equals a reference value using $Z = (\bar{x} - \mu_0)/(\sigma/\sqrt{n})$, which follows $N(0, 1)$ under the null hypothesis. |
| Direction of a test | An alternative with $\ne$, $>$, or $<$ gives a two-sided, right-tailed, or left-tailed test, and the direction is set by the research question before seeing the data. |
| p-value | It is the probability under the null hypothesis of a value as extreme as the observed one or more extreme, and for the same $Z$ a one-sided p-value is half the two-sided one or 1 minus that half. |
| Decision rule | If the p-value is smaller than the significance level, the null hypothesis is rejected and the alternative selected, and otherwise the null hypothesis is not rejected. |
| Choice of significance level | A higher significance level makes rejection easier and raises the power but also the probability of a type I error, and choosing it after seeing the data destroys its meaning. |
| Correspondence with confidence intervals | A $`100(1 - \alpha)\%`$ confidence interval for the population mean that excludes $\mu_0$ is equivalent to rejection by the two-sided test at significance level $\alpha$. |
| Checking parameter assumptions | If the given $\sigma$ differs greatly from the sample standard deviation, the conclusion of the Z-test is hard to trust, and the t-test is used instead. |
| Statistical significance and practical size | In large samples even tiny differences are significant, so the size of the difference and a confidence interval are reported together. |

---

<br>

## Self-Check Questions

1. **Test statistic:** With $\mu_0 = 100$, $\sigma = 15$, $n = 225$, and $\bar{x} = 102$, find $Z$ and the two-sided p-value and decide at the 5% significance level.

   <details>
   <summary>Answer</summary>

   The standard error is $15/\sqrt{225} = 1$, so $Z = (102 - 100)/1 = 2.0$. The two-sided p-value is $2\lbrace1 - \Phi(2.0)\rbrace = 0.0455$, smaller than 0.05, so the null hypothesis is rejected and the alternative selected.

   </details>

2. **One-sided and two-sided:** The same data give $Z = -1.8$. Find the left-tailed, right-tailed, and two-sided p-values.

   <details>
   <summary>Answer</summary>

   Left-tailed: $\Phi(-1.8) = 0.0359$. Right-tailed: $1 - \Phi(-1.8) = 0.9641$. Two-sided: $2 \times 0.0359 = 0.0719$. Only the left-tailed test rejects at the 5% significance level.

   </details>

3. **Choosing the direction afterward:** What is the actual probability of a type I error of the procedure that picks a right-tailed test at the 5% level after seeing that the sample mean exceeds the reference value?

   <details>
   <summary>Answer</summary>

   The procedure rejects when $Z > 1.645$ or $Z < -1.645$ (a negative $Z$ would have led to the left-tailed test), so the probability of rejecting a true null hypothesis is $0.05 + 0.05 = 0.10$.

   </details>

4. **Effect of sample size:** With everything else unchanged, how does $Z$ change when the sample size is multiplied by 4?

   <details>
   <summary>Answer</summary>

   The standard error $\sigma/\sqrt{n}$ halves, so for the same $\bar{x} - \mu_0$, $Z$ doubles. The real size of the difference is unchanged, but the p-value becomes smaller.

   </details>

5. **Stating the conclusion:** Why is "the null hypothesis has been proved true" wrong when the p-value is 0.30?

   <details>
   <summary>Answer</summary>

   A hypothesis test only judges whether there is enough evidence against the null hypothesis. A p-value of 0.30 means only that such evidence is lacking, and the same result occurs when the power is low because the sample or the difference is small. The correct statement is "the null hypothesis is not rejected, and there is insufficient ground to select the alternative hypothesis".

   </details>
