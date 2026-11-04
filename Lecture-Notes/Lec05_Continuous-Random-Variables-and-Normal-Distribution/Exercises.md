# Lecture 5 Exercises — Continuous Random Variables and the Normal Distribution

[Repository Guide](../../README.md) | [English](Exercises.md) | [한국어](Exercises.ko.md)

> **Last Updated:** 2026-11-04

Exercises 1-8 are R problems that compute probabilities of the normal, chi-square, and t distributions, draw their graphs, and check the central limit theorem by simulation. The required concepts are in the [Lecture 5 notes](Concepts_Lecture.md), and every problem can be solved with base R functions only.

---

<br>

## Table of Contents

- [Exercise 1: Comparing the Shapes of Normal PDFs](#exercise-1-comparing-the-shapes-of-normal-pdfs)
- [Exercise 2: An Interval Probability of a Normal Distribution](#exercise-2-an-interval-probability-of-a-normal-distribution)
- [Exercise 3: Building a Standard Normal Table](#exercise-3-building-a-standard-normal-table)
- [Exercise 4: Heights of Men in Their Twenties](#exercise-4-heights-of-men-in-their-twenties)
- [Exercise 5: Rolling a Die and the Normal Approximation](#exercise-5-rolling-a-die-and-the-normal-approximation)
- [Exercise 6: PDFs of Chi-Square Distributions](#exercise-6-pdfs-of-chi-square-distributions)
- [Exercise 7: Comparing t Distributions with the Standard Normal](#exercise-7-comparing-t-distributions-with-the-standard-normal)
- [Exercise 8: Simulating the Central Limit Theorem](#exercise-8-simulating-the-central-limit-theorem)

---

<br>

## Exercise 1: Comparing the Shapes of Normal PDFs

**Problem:** Compute the PDFs of the four normal distributions $N(0, 1)$, $N(0, 4)$, $N(2, 1)$, and $N(2, 4)$ in R on the interval $[-7, 7]$, plot them in a 2-by-2 layout, and mark each mean with a dashed line. Compare how the position, width, and height of the curve change as the mean and variance change. The second value in the notation $N(\mu, \sigma^2)$ is the variance.

**[Solution](Solutions.md#exercise-1-comparing-the-shapes-of-normal-pdfs)**

---

<br>

## Exercise 2: An Interval Probability of a Normal Distribution

**Problem:** For $X \sim N(2, 4)$, find $P(-1 < X < 4)$. First standardize and express it with $\Phi$, compute it with the standard normal table, and then confirm the value with R's `pnorm()` in two ways (using the standardized values, and using the mean and standard deviation of the original distribution).

**[Solution](Solutions.md#exercise-2-an-interval-probability-of-a-normal-distribution)**

---

<br>

## Exercise 3: Building a Standard Normal Table

**Problem:** Like the normal tables printed at the back of statistics textbooks, build in R a 30-by-10 table of the cumulative probabilities $\Phi(z)$ for $z = 0.00, 0.01, \ldots, 2.99$, with $z$ up to the first decimal place in the rows (0, 0.1, ..., 2.9) and the second decimal place in the columns (0, 0.01, ..., 0.09), and print it to four decimal places.

**[Solution](Solutions.md#exercise-3-building-a-standard-normal-table)**

---

<br>

## Exercise 4: Heights of Men in Their Twenties

**Problem:** Suppose the heights (cm) of Korean men in their twenties follow $X \sim N(175, 8^2)$. Find the proportion of men whose height is between 180 cm and 185 cm. Compute it by hand with the standard normal table and linear interpolation, and confirm it in R.

**[Solution](Solutions.md#exercise-4-heights-of-men-in-their-twenties)**

---

<br>

## Exercise 5: Rolling a Die and the Normal Approximation

**Problem:** A fair die is rolled 100 times, and $X$ is the number of rolls showing 4 or more. Find the probability that $X$ is at least 40 and at most 45 (1) exactly with the binomial distribution and (2) with the normal approximation and continuity correction. Also compare with the approximation without the continuity correction.

**[Solution](Solutions.md#exercise-5-rolling-a-die-and-the-normal-approximation)**

---

<br>

## Exercise 6: PDFs of Chi-Square Distributions

**Problem:** Plot in R the PDFs of chi-square distributions with 5, 10, 15, and 20 degrees of freedom. Let the horizontal axis run from 0 to the 99% quantile of the chi-square distribution with 20 degrees of freedom, and mark the degrees of freedom on each graph with a dashed line. Explain how the shape changes as the degrees of freedom grow.

**[Solution](Solutions.md#exercise-6-pdfs-of-chi-square-distributions)**

---

<br>

## Exercise 7: Comparing t Distributions with the Standard Normal

**Problem:** Overlay the PDFs of the standard normal distribution and of t distributions with 1, 5, 10, and 30 degrees of freedom on one graph over the interval $[-4, 4]$. Draw the same curves on a graph with a logarithmic vertical axis, and compare the shapes of the distributions in the two graphs.

**[Solution](Solutions.md#exercise-7-comparing-t-distributions-with-the-standard-normal)**

---

<br>

## Exercise 8: Simulating the Central Limit Theorem

**Problem:** Write an R function `plotForCLT()` that takes a random number generator `r.dist` and a sample size `n`, computes the mean of a sample of size `n` 1,000 times, standardizes these sample means, and draws side by side (1) a histogram overlaid with a kernel density curve and the PDF of $N(0, 1)$ and (2) a normal Q-Q plot. Apply the function to the following populations and observe how the distribution of the sample mean changes with the sample size.

- Chi-square distribution with 1 degree of freedom: $n = 1, 10, 20, 30, 100$
- Bernoulli distribution with success probability 0.5 (binomial with `size = 1`): $n = 1, 10, 20, 30, 50, 100$
- Poisson distribution with mean 1: $n = 1, 10, 20, 30, 40$
- Negative binomial distribution with `size = 1` and success probability 0.5: $n = 1, 10, 20, 30$

**[Solution](Solutions.md#exercise-8-simulating-the-central-limit-theorem)**
