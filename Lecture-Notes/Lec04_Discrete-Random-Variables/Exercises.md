# Lecture 4 Exercises — Discrete Random Variables

[Repository Guide](../../README.md) | [English](Exercises.md) | [한국어](Exercises.ko.md)

> **Last Updated:** 2026-11-04

Each exercise asks you to choose a discrete distribution, compute its probability mass function, expected value, variance, and probabilities, and check the results with R. The concepts needed are in the [Lecture 4 notes](Concepts_Lecture.md).

---

<br>

## Table of Contents

- [Exercise 1: Discrete Uniform Distribution of Numbered Balls](#exercise-1-discrete-uniform-distribution-of-numbered-balls)
- [Exercise 2: Three Binomial Distributions with Different Success Probabilities](#exercise-2-three-binomial-distributions-with-different-success-probabilities)
- [Exercise 3: Number of Defectives in a Process with Defect Rate 0.03](#exercise-3-number-of-defectives-in-a-process-with-defect-rate-003)
- [Exercise 4: Hypergeometric Distributions from Three Finite Populations](#exercise-4-hypergeometric-distributions-from-three-finite-populations)
- [Exercise 5: Number of Defectives in a Sample from 1000 Products](#exercise-5-number-of-defectives-in-a-sample-from-1000-products)
- [Exercise 6: Three Poisson Distributions with Different Means](#exercise-6-three-poisson-distributions-with-different-means)
- [Exercise 7: Poisson Distribution of Defects per Unit](#exercise-7-poisson-distribution-of-defects-per-unit)
- [Exercise 8: Three Geometric Distributions with Different Success Probabilities](#exercise-8-three-geometric-distributions-with-different-success-probabilities)
- [Exercise 9: Number of Rolls Until a 6 Appears](#exercise-9-number-of-rolls-until-a-6-appears)
- [Exercise 10: Negative Binomial Distributions Until the 1st, 2nd, and 4th Successes](#exercise-10-negative-binomial-distributions-until-the-1st-2nd-and-4th-successes)
- [Exercise 11: Number of Projects Until Three Hit Songs](#exercise-11-number-of-projects-until-three-hit-songs)

---

<br>

## Exercise 1: Discrete Uniform Distribution of Numbered Balls

**Problem:** One ball is drawn at random from a box containing 20 identical balls numbered 1 to 20, and its number is checked. Let the random variable $X$ be that number.

1. Find the probability mass function of $X$.
2. Find $E(X)$ and $\mathrm{Var}(X)$.
3. Find the probability of drawing a number of 15 or more.
4. Check the results with R.

**[Solution](Solutions.md#exercise-1-discrete-uniform-distribution-of-numbered-balls)**

---

<br>

## Exercise 2: Three Binomial Distributions with Different Success Probabilities

**Problem:** Find the probability distributions of the number of successes when samples of 10 are taken from three infinite populations with success probabilities 0.2, 0.5, and 0.8, respectively.

1. Write the distribution and probability mass function for each case.
2. Obtain the probability tables and plots of the three distributions with R.
3. Find the expected values and variances of the three distributions and compare their shapes.

**[Solution](Solutions.md#exercise-2-three-binomial-distributions-with-different-success-probabilities)**

---

<br>

## Exercise 3: Number of Defectives in a Process with Defect Rate 0.03

**Problem:** Let the random variable $X$ be the number of defectives found when 20 samples are taken and inspected from a process with a defect rate of 0.03.

1. Find the probability mass function of $X$.
2. Find $E(X)$ and $\mathrm{Var}(X)$.
3. Find the probability $P(X = 2)$ of finding exactly 2 defectives.
4. Find the probability $P(X \ge 3)$ of finding 3 or more defectives.
5. Compute parts 3 and 4 with R, the latter in two ways.

**[Solution](Solutions.md#exercise-3-number-of-defectives-in-a-process-with-defect-rate-003)**

---

<br>

## Exercise 4: Hypergeometric Distributions from Three Finite Populations

**Problem:** Three finite populations each consist of 50 individuals, of which 10, 25, and 40, respectively, are successes. Find the probability distribution of the number of successes in a sample of 10 drawn without replacement from each population.

1. Write the distribution and probability mass function for each case.
2. Obtain the probability tables, expected values, and variances of the three distributions with R.
3. Compare them with the binomial distributions $B(10, p)$ with the same success proportions.

**[Solution](Solutions.md#exercise-4-hypergeometric-distributions-from-three-finite-populations)**

---

<br>

## Exercise 5: Number of Defectives in a Sample from 1000 Products

**Problem:** A production line consists of 1000 products with a 5% defect rate. Let the random variable $X$ be the number of defectives when 30 samples are drawn without replacement.

1. Find the probability mass function of $X$.
2. Find $E(X)$ and $\mathrm{Var}(X)$.
3. Find $P(X = 3)$ and $P(X \le 3)$.
4. Compare the results with the binomial approximation.

**[Solution](Solutions.md#exercise-5-number-of-defectives-in-a-sample-from-1000-products)**

---

<br>

## Exercise 6: Three Poisson Distributions with Different Means

**Problem:** Find the Poisson probability distributions of the number of occurrences when a sample of a certain unit is taken from three infinite populations with 2, 5, and 8 average occurrences per unit, respectively.

1. Write the probability mass function for each case.
2. Obtain the probability tables, expected values, and variances of the three distributions with R.
3. Compare them with the hypergeometric distributions of Exercise 4 and the binomial distributions of Exercise 2.

**[Solution](Solutions.md#exercise-6-three-poisson-distributions-with-different-means)**

---

<br>

## Exercise 7: Poisson Distribution of Defects per Unit

**Problem:** Sampling inspection is performed in a process that produces products with an average of 1.5 defects per unit. Let the random variable $X$ be the number of defects found in one unit.

1. Find the probability mass function of $X$.
2. Find $E(X)$ and $\mathrm{Var}(X)$.
3. Find the probability of finding exactly two defects.
4. Find the probability of finding three or more defects.

**[Solution](Solutions.md#exercise-7-poisson-distribution-of-defects-per-unit)**

---

<br>

## Exercise 8: Three Geometric Distributions with Different Success Probabilities

**Problem:** Find the distributions of the number of trials until the first success in three infinite populations with success probabilities 0.1, 0.3, and 0.5, respectively.

1. Write the probability mass function for each case.
2. Plot the three distributions with R and check their expected values and variances.

**[Solution](Solutions.md#exercise-8-three-geometric-distributions-with-different-success-probabilities)**

---

<br>

## Exercise 9: Number of Rolls Until a 6 Appears

**Problem:** In an experiment where one die is rolled repeatedly until a 6 is observed, let the random variable $X$ be the total number of rolls.

1. Find the probability mass function of $X$.
2. Find $E(X)$ and $\mathrm{Var}(X)$.
3. Find the probability that a 6 is observed within 3 rolls.

**[Solution](Solutions.md#exercise-9-number-of-rolls-until-a-6-appears)**

---

<br>

## Exercise 10: Negative Binomial Distributions Until the 1st, 2nd, and 4th Successes

**Problem:** Find the distributions of the number of trials until 1, 2, and 4 successes, respectively, in an infinite population with success probability 0.4.

1. Write the distribution and probability mass function for each case.
2. Plot the three distributions with R and check their expected values and variances.

**[Solution](Solutions.md#exercise-10-negative-binomial-distributions-until-the-1st-2nd-and-4th-successes)**

---

<br>

## Exercise 11: Number of Projects Until Three Hit Songs

**Problem:** Each song composed by an agency becomes a hit with probability 0.1, independently of the other songs. Let the random variable $X$ be the number of projects (songs) planned until three songs become hits.

1. Find the probability mass function of $X$.
2. Find $E(X)$ and $\mathrm{Var}(X)$.
3. Find the probability that the third hit comes exactly on the 10th project.

**[Solution](Solutions.md#exercise-11-number-of-projects-until-three-hit-songs)**

---
