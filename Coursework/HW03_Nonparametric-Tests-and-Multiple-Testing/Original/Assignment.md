# HW3 Assignment Handout — Nonparametric Tests and Multiple Testing

[Repository Guide](../../../README.md) | [English](Assignment.md) | [한국어](Assignment.ko.md)

> **Last Updated:** 2026-11-16

This is the third assignment of Probability and Statistics. It consists of 8 problems that analyze two data files with R, and the points differ by problem and total 100. The distributed answer form is [HW3.docx](HW3.docx).

- **Answers:** Read the questions and answer carefully, in English or Korean.
- **Submission:** The R code must run without problems when the TA runs it, and the submitted compressed file (.zip) must be named `HW3_YourID_Yourname.zip`.
- **Partial credit:** Partial credit is given, so attempt each problem as far as possible even if it cannot be solved completely.

---

<br>

## Common Data for Q1-Q4

Load the file [`Q1_Data.tsv`](../data/Q1_Data.tsv). It holds the number of confirmed COVID-19 cases from 18 independent institutions in the variable `numCOVID`. It also records in the variable `Job` whether each institution is a statistician group or a computer science group. When answering about the results, draw the conclusion logically using all of the terms "Null hypothesis", "Reject", "Alternative hypothesis", "Select", and "Significance level."

## Q1. Differences in Case Counts by Occupation

Perform a hypothesis test of whether occupations have different numbers of COVID-19 cases, using one parametric and one nonparametric approach at the 5% significance level. (10 points)

## Q2. The Preferable Test

Among the hypothesis tests performed in Q1, which test is preferable? Why? (20 points)

## Q3. A Test with the Seo Statistic

Professor Seo developed a new Seo statistic (Seo-Stat) to compare the two groups. Its form is the absolute value of the difference between the medians of the two groups, as shown below. Using it as the test statistic, perform the same hypothesis test as Q1 at the 10% significance level following the logic of hypothesis testing, and reach a conclusion. (10 points)

```math
\text{Seo-Stat} = \lvert \mathrm{Median}(A\ \text{group}) - \mathrm{Median}(B\ \text{group}) \rvert
```

## Q4. Limits of the Seo Statistic

What are the limits of the Seo test statistic when it is used to test for differences between two groups? Compare it with the form of the statistics already known. (20 points)

---

<br>

## Common Data for Q5-Q8

Load the file [`Q5_Data.tsv`](../data/Q5_Data.tsv). It records, for a total of 72 people, disease information (variable `Disease`), height information (variable `Height`), and 1,724 pieces of genomic information (variables `Gene_1`, `Gene_2`, ..., `Gene_1724`). All genomic data are continuous random variables. When answering about the results, draw the conclusion logically using all of the terms "Null hypothesis", "Reject", "Alternative hypothesis", "Select", and "Significance level."

> **Note:** The gene columns actually in `data/Q5_Data.tsv` are the 1,274 columns from `Gene_1` to `Gene_1274`.

A `for()` loop in R can be used as follows.

```r
for(i in 1:nrow(data)) {
data[,i]
}
```

## Q5. Genes That Differ between the Cancer and Normal Groups

Using a hypothesis test at the 1% significance level, identify the genes that differ between the cancer group and the normal group. Describe how many genes are found. (10 points)

## Q6. Genes Related to Height

Using hypothesis testing at the 1% significance level, identify the genes related to height. Describe how many genes are found. (10 points)

## Q7. The Problem of Testing Many Hypotheses Together

Multiple hypothesis tests on the same data raise a certain statistical issue because of the concept of the "significance level." It was not covered in class, but it is one of the most important issues of statistical analysis in the era of modern data science, and anyone who has followed the course normally can understand it with a little study. After studying the issue through web searches, describe what causes the problem in Q5. Also, if possible, find a solution, modify the P-values of Q5, and describe the result. There are many correction methods, such as the Bonferroni, Scheffe, Sidak, and Benjamini & Hochberg methods, and they are implemented in R. The answer is limited to one page. (10 points)

## Q8. Uses of the Significant Results

The technique applied in Q5 and Q6 is currently used as a very important technique in the fields of artificial intelligence and data science. Describe logically how the statistically significant results obtained in Q5 and Q6 could be applied in real industrial and academic fields. Explaining first what the statistically significant results of Q5 and Q6 each mean makes it possible to draw the uses of those results from that explanation. The answer is limited to one page. (10 points)

---

<br>

After solving the problems, see the [assignment explanation](../Assignment-Explanation.md) for the answers and solutions and the [code walkthrough](../Code-Walkthrough.md) for the complete code.
