# Lecture 1 Exercises — Introduction to R Programming

[Repository Guide](../../README.md) | [English](Exercises.md) | [한국어](Exercises.ko.md)

> **Last Updated:** 2026-11-04

Exercise 1 practices the vectors and matrices of Section 6 of [Lecture 1](Concepts_Lecture.md), and Exercise 2 practices generating values and data frames from Sections 7 and 8. Solve every exercise in R and check the output.

---

<br>

## Table of Contents

- [Exercise 1: Binding Vectors and Checking Their Size](#exercise-1-binding-vectors-and-checking-their-size)
- [Exercise 2: Creating Gender and Height Data](#exercise-2-creating-gender-and-height-data)

---

<br>

## Exercise 1: Binding Vectors and Checking Their Size

**Problem:** Run the following steps in R in order.

1. Create a variable `A` with the values 1, 2, 3, 4, 5.
2. Copy variable `A` to create variable `B`.
3. Check the lengths of `A` and `B`.
4. Bind `A` and `B` column-wise and row-wise with `cbind()` and `rbind()`, respectively.
5. Combine `A` and `B` column by column and assign the result to variable `C`.
6. Check the numbers of columns and rows of `C`.

**[Solution](Solutions.md#exercise-1-binding-vectors-and-checking-their-size)**

---

<br>

## Exercise 2: Creating Gender and Height Data

**Problem:** Create in R a table of 20 rows and 2 columns that meets the following conditions. Also explain, with reasons, whether the table should be built as a matrix or as a data frame.

- The total sample size is 20.
- There are two variables, gender (`Gender`) and height (`Height`).
- In `Gender`, the first 10 samples are Male and the last 10 samples are Female.
- The men's heights are generated from the normal distribution with mean 173 and standard deviation 2.
- The women's heights are generated from the normal distribution with mean 162.3 and standard deviation 2.

Printing the table gives output in the following format. The heights are random numbers, so the values differ from run to run.

```text
   Gender   Height
1    Male 171.9894
2    Male 173.8171
3    Male 173.0632
4    Male 175.8147
5    Male 175.7834
6    Male 176.3334
7    Male 178.5585
8    Male 174.9075
9    Male 174.3359
10   Male 170.7448
11 Female 161.7243
12 Female 160.6768
13 Female 163.5238
14 Female 164.7577
15 Female 162.9114
16 Female 164.3985
17 Female 161.3359
18 Female 162.8363
19 Female 163.3933
20 Female 163.0774
```

**[Solution](Solutions.md#exercise-2-creating-gender-and-height-data)**
