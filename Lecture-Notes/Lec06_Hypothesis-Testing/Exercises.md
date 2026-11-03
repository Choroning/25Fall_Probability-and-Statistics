# Lecture 6 Exercises — Hypothesis Testing

[Repository Guide](../../README.md) | [English](Exercises.md) | [한국어](Exercises.ko.md)

> **Last Updated:** 2026-11-04

Exercises 1-3 check the sampling distribution of the sample mean by simulation and perform a one-sample Z-test and an independent two-sample t-test in R. The required concepts are in the [Lecture 6 notes](Concepts_Lecture.md).

---

<br>

## Table of Contents

- [Exercise 1: Simulating the Distribution of the Sample Mean](#exercise-1-simulating-the-distribution-of-the-sample-mean)
- [Exercise 2: A One-Sample Z-Test of Men's Heights](#exercise-2-a-one-sample-z-test-of-mens-heights)
- [Exercise 3: An Independent Two-Sample t-Test of Heights by Gender](#exercise-3-an-independent-two-sample-t-test-of-heights-by-gender)

---

<br>

## Exercise 1: Simulating the Distribution of the Sample Mean

**Problem:** From a normal population with mean 100 and variance 100, repeat 10,000 times the task of randomly drawing 10 observations and computing their sample mean, and find the distribution of the sample mean. In theory, the following holds.

$$
\bar{X} = \frac{1}{n}\sum_{i=1}^{n} X_i \sim N\left(100, \frac{100}{10}\right), \qquad \frac{\bar{X} - 100}{10/\sqrt{10}} \sim N(0, 1)
$$

Write an R function `testSampleMeanDist()` that takes the sample size `ns`, population mean `mu`, population standard deviation `sig`, number of repetitions `N`, number of histogram bars `ng`, random seed `seed`, and number of printed digits `dig` as arguments. The function should do the following.

- Compute `N` sample means and their standardized values.
- Compare the mean and standard deviation of the sample means with the theoretical values.
- At several points, compute the cumulative probability of the sample mean both theoretically (normal distribution) and by simulation (proportion), and print them as a table.
- Draw a histogram of the sample means overlaid with the population PDF and the theoretical PDF of the sample mean, and a histogram of the standardized sample means overlaid with the PDF of $N(0, 1)$.

**[Solution](Solutions.md#exercise-1-simulating-the-distribution-of-the-sample-mean)**

---

<br>

## Exercise 2: A One-Sample Z-Test of Men's Heights

**Problem:** In 1998, the average height of Korean men was 169.3 cm with a standard deviation of 5.4 cm. We want to test whether data collected in 2020 differ from the past. Suppose the heights of 30 men were measured in 2020, and use the following simulated data.

```r
Height_2020yr <- c(178.4, 168.0, 173.0, 174.4, 173.2, 170.4, 179.2, 170.5, 181.9, 170.7,
                   178.0, 183.3, 163.5, 169.5, 170.3, 174.4, 169.5, 156.7, 157.8, 178.1,
                   169.3, 161.4, 170.1, 177.6, 181.2, 168.7, 169.6, 161.5, 173.5, 167.5)
```

The hypotheses are as follows. Assume that the population standard deviation is known to be the 1998 value, 5.4 cm.

$$
H_0:\ \mu_{2020} = 169.3 \qquad \text{vs} \qquad H_1:\ \mu_{2020} \neq 169.3,\quad H_1:\ \mu_{2020} > 169.3,\quad H_1:\ \mu_{2020} < 169.3
$$

1. Implement the Z statistic formula directly as an R function `z.test()` that takes a data vector `input`, the null mean `mu`, and the population variance `var` and returns the Z statistic.
2. Compute the Z statistic with this function. What does its value mean?
3. Find the p-value for each of the three alternative hypotheses and draw conclusions at significance level 0.05.
4. If more data were collected in 2020 (only the sample size grows while the mean stays the same), how would the Z statistic and the conclusion change?

**[Solution](Solutions.md#exercise-2-a-one-sample-z-test-of-mens-heights)**

---

<br>

## Exercise 3: An Independent Two-Sample t-Test of Heights by Gender

**Problem:** Create tabular data consisting of two variables, height (`Height`) and gender (`Gender`). Generate the heights of 100 men from a normal distribution with mean 173 and standard deviation 2, and those of 100 women from a normal distribution with mean 162.3 and standard deviation 2 (run `set.seed(2025)` first for reproducibility).

```r
set.seed(2025)
Gender <- factor(c(rep("Male", 100), rep("Female", 100)))
Height <- c(rnorm(100, 173, 2), rnorm(100, 162.3, 2))

Data <- data.frame(Height, Gender)
dim(Data)
```

We want to test with these data whether the heights of men and women differ.

$$
H_0:\ \mu_{\text{Male}} = \mu_{\text{Female}} \qquad \text{vs} \qquad H_1:\ \mu_{\text{Male}} \neq \mu_{\text{Female}}
$$

1. Perform the two-sided test with `t.test()` and interpret the result.
2. Also test with `alternative = "less"` and `alternative = "greater"`, and state precisely what each alternative hypothesis is.
3. How does the test performed by `t.test()` with its default settings differ from the pooled-variance t-test of Lecture 6, Section 8.2? Compare the results of the two tests.

**[Solution](Solutions.md#exercise-3-an-independent-two-sample-t-test-of-heights-by-gender)**
