# Lecture 3 Exercises — Random Variables and Probability Distributions

[Repository Guide](../../README.md) | [English](Exercises.md) | [한국어](Exercises.ko.md)

> **Last Updated:** 2026-11-04

Each exercise asks for probability distributions, expected values, and variances computed from their definitions and checked with R. The concepts needed are in the [Lecture 3 notes](Concepts_Lecture.md).

---

<br>

## Table of Contents

- [Exercise 1: Distribution of the Number of Heads in Three Tosses](#exercise-1-distribution-of-the-number-of-heads-in-three-tosses)
- [Exercise 2: Distribution of the Sum of Four Dice](#exercise-2-distribution-of-the-sum-of-four-dice)
- [Exercise 3: CDF of the Number of Tails in Three Tosses](#exercise-3-cdf-of-the-number-of-tails-in-three-tosses)
- [Exercise 4: Joint Distribution of the Maximum and Minimum of Two Dice](#exercise-4-joint-distribution-of-the-maximum-and-minimum-of-two-dice)
- [Exercise 5: Expected Profit of a Coin Game](#exercise-5-expected-profit-of-a-coin-game)
- [Exercise 6: Expected Value and Variance of One Roll of a Die](#exercise-6-expected-value-and-variance-of-one-roll-of-a-die)
- [Exercise 7: Expected Value and Variance of a Linearly Transformed Random Variable](#exercise-7-expected-value-and-variance-of-a-linearly-transformed-random-variable)

---

<br>

## Exercise 1: Distribution of the Number of Heads in Three Tosses

**Problem:** Let the random variable $X$ be the number of heads in three tosses of a coin.

1. Write the sample space and the value of $X$ for each outcome, and find the probability distribution $f(x) = P(X = x)$ of $X$.
2. Verify that $\sum_x f(x) = 1$.
3. Enumerate the sample space in R to obtain the distribution of $X$, and plot it.

**[Solution](Solutions.md#exercise-1-distribution-of-the-number-of-heads-in-three-tosses)**

---

<br>

## Exercise 2: Distribution of the Sum of Four Dice

**Problem:** Let the random variable $X$ be the sum of the numbers in an experiment of rolling a die four times.

1. Find the size of the sample space and the range of values of $X$.
2. Find the probability distribution of $X$ with R.
3. Find the expected value $E(X)$ and the standard deviation $D(X) = \sqrt{\mathrm{Var}(X)}$ of $X$.
4. Overlay a normal curve with the same mean and standard deviation on the bar plot of the distribution, and describe the shape of the distribution.

**[Solution](Solutions.md#exercise-2-distribution-of-the-sum-of-four-dice)**

---

<br>

## Exercise 3: CDF of the Number of Tails in Three Tosses

**Problem:** Let the random variable $X$ be the number of tails observed in a probability experiment of tossing a coin three times.

1. Find the probability distribution of $X$.
2. Write the cumulative distribution function $F(x) = P(X \le x)$ of $X$ piecewise for every real $x$.
3. Draw the CDF as a step function in R, and show the expected value and standard deviation on the plot.

**[Solution](Solutions.md#exercise-3-cdf-of-the-number-of-tails-in-three-tosses)**

---

<br>

## Exercise 4: Joint Distribution of the Maximum and Minimum of Two Dice

**Problem:** In a trial of rolling a die twice, let $X$ be the larger and $Y$ the smaller of the two numbers. If the two numbers are equal, $X = Y$.

1. Find the number of outcomes $n(x, y)$ giving each $(x, y)$, and express the joint probability distribution $f(x, y)$ as a formula.
2. Obtain the joint frequency table and the joint probability distribution with R.
3. Find the marginal distributions of $X$ and $Y$, and decide whether $X$ and $Y$ are independent.

**[Solution](Solutions.md#exercise-4-joint-distribution-of-the-maximum-and-minimum-of-two-dice)**

---

<br>

## Exercise 5: Expected Profit of a Coin Game

**Problem:** In a game, a coin is tossed three times; the player receives 100 won for each head and pays 100 won for each tail. Let the profit be the random variable $X = 100 \times (\text{number of heads} - \text{number of tails})$.

1. Find the values $X$ takes and their probabilities.
2. Find the expected value of $X$, and decide whether the game is fair.
3. Find the variance and standard deviation of $X$, and check the results with R.

**[Solution](Solutions.md#exercise-5-expected-profit-of-a-coin-game)**

---

<br>

## Exercise 6: Expected Value and Variance of One Roll of a Die

**Problem:** Let the random variable $X$ be the number shown in one roll of a die. Find the expected value and variance of $X$ as fractions, and check them with R.

**[Solution](Solutions.md#exercise-6-expected-value-and-variance-of-one-roll-of-a-die)**

---

<br>

## Exercise 7: Expected Value and Variance of a Linearly Transformed Random Variable

**Problem:** Consider the random variable $Y = 100X - 400$, obtained by multiplying the number $X$ shown in one roll of a die by 100 and subtracting 400.

1. Using the result of Exercise 6 and the properties of linear transformations, find the expected value and variance of $Y$.
2. Compute the expected value and variance directly from the values of $Y$ and their probabilities, and compare with the result of part 1.

**[Solution](Solutions.md#exercise-7-expected-value-and-variance-of-a-linearly-transformed-random-variable)**

---
