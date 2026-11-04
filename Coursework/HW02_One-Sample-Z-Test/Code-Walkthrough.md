# HW2 Code Walkthrough — One-Sample Z-Test

[Repository Guide](../../README.md) | [English](Code-Walkthrough.md) | [한국어](Code-Walkthrough.ko.md)

> **Last Updated:** 2026-11-04

> **Learning Objectives:**
> 1. Load tab-separated data with `fread()` from data.table and extract columns and subsets
> 2. Compute the sample size, the sample mean, the Z statistic, and the p-value of each direction in R code
> 3. Find tail probabilities and critical values of the standard normal distribution with `pnorm()` and `qnorm()`, avoiding the loss of precision in tail probabilities
> 4. Write code that prints decisions at given significance levels with conditionals, functions, and loops

---

## Table of Contents

- [1. Files and How to Run](#1-files-and-how-to-run)
- [2. The Common Part of the Four Scripts](#2-the-common-part-of-the-four-scripts)
  - [2.1 Preparing Packages](#21-preparing-packages)
  - [2.2 Setting the Working Directory](#22-setting-the-working-directory)
  - [2.3 Loading the Data](#23-loading-the-data)
- [3. Q1.R: Two-Sided Test](#3-q1r-two-sided-test)
- [4. Q2.R: Subsetting and a Right-Tailed Test](#4-q2r-subsetting-and-a-right-tailed-test)
- [5. Q3-4.R: Three Directions and a Decision Function](#5-q3-4r-three-directions-and-a-decision-function)
- [6. Q5.R: Decisions at Several Significance Levels](#6-q5r-decisions-at-several-significance-levels)
- [7. One Function for All Four Tests](#7-one-function-for-all-four-tests)
- [Summary](#summary)
- [Self-Check Questions](#self-check-questions)

---

<br>

## 1. Files and How to Run

Each of the four R scripts in `Solution/` performs one one-sample Z-test per problem. The statistical explanation of the problems is in the [HW2 Assignment Explanation](Assignment-Explanation.md), and this document reads the code from beginning to end.

| File | Sample | Test | Output |
|:-----|:-----|:-----|:-----|
| `Q1.R` | `sysBP` of all 8,921 subjects | Two-sided, $\alpha = 0.05$ | $Z$, p-value, decision sentence |
| `Q2.R` | `sysBP` of 4,455 COVID19 patients | Right-tailed | $Z$, p-value |
| `Q3-4.R` | `HR` of 4,834 men | Two-sided, right-tailed, left-tailed with $\alpha = 0.05, 0.10$ | $Z$, three p-values, decisions by direction |
| `Q5.R` | `Resting_SaO2` of all 8,921 subjects | Two-sided, $\alpha = 0.01, 0.05, 0.10$ | $Z$, p-value, decisions by significance level |

*Table 1. Structure of the HW2 scripts*

The scripts locate the data folder relative to their own folder, so they are run with `source()`. From an R session opened at the repository root, run them as follows, and in RStudio, opening a script and pressing the Source button runs it the same way.

```r
source("Coursework/HW02_One-Sample-Z-Test/Solution/Q1.R")
```

---

<br>

## 2. The Common Part of the Four Scripts

The four scripts differ only in the header of lines 1-5 and are otherwise the same up to line 21. Lines 1-21 of `Q1.R` serve as the example.

### 2.1 Preparing Packages

```r
# @file    Q1.R
# @brief   HW2 Q1: two-sided one-sample Z-test of whether the mean systolic blood
#          pressure of all subjects differs from the NIH reference N(128.65, 16.5^2)
# @author  Cheolwon Park
# @date    2025-12-07

## 1. 기본 환경 설정
setRepositories(ind = 1:7)
if (!require("data.table")) install.packages("data.table")
library(data.table)
```

- Lines 1-5 are a Doxygen-style header with the file name, a one-line description, the author, and the date.
- `setRepositories(ind = 1:7)` widens the repositories in which `install.packages()` searches for packages to seven: CRAN, the three Bioconductor repositories, CRAN extras, R-Forge, and rforge.net. data.table is on CRAN, so the code works without this line, but it keeps the same preamble usable for analyses with Bioconductor packages.
- `require()` loads a package and returns `TRUE` or `FALSE` to report success. If the package is not installed it returns `FALSE` with a warning, so `!` inverts the result and `install.packages()` runs only in that case. The following `library()` makes sure the package is loaded, including right after installation.

### 2.2 Setting the Working Directory

```r
########################################################
# 작업 경로 설정
WORK_DIR <- file.path(dirname(sys.frame(1)$ofile %||% "."), "../data")
if (WORK_DIR != "") setwd(WORK_DIR)
########################################################
```

- When a script is run with `source(".../Solution/Q1.R")`, the first frame of the call stack is the environment of the `source()` function, and its variable `ofile` holds the script path. `sys.frame(1)$ofile` retrieves that path.
- `dirname()` drops the file name from the path and returns the folder path (`.../Solution`), and `file.path(..., "../data")` builds the path of the `data/` folder next to it.
- `%||%`, an operator built into base R since version 4.4.0, returns the right-hand value when the left-hand value is `NULL`. The fallback `"."` (the current folder) covers the case where `ofile` does not exist.
- `setwd()` changes the working directory to the data folder, so the later `fread("Data.txt")` finds the data by file name alone.

> **Caution:** This approach works only when the script is run with `source()`. Running it line by line in the console or with `Rscript Q1.R` leaves no frame on the call stack, and `sys.frame(1)` raises an error. In that case, put the path of the data folder into `WORK_DIR` directly.

### 2.3 Loading the Data

```r
## 2. 데이터 로드
file_name <- "Data.txt"
data <- fread(file_name)
```

`fread()` is the fast file reader of the data.table package. It detects the separator (a tab here) and the header row by itself and returns a `data.table` object. `data.table` is a class that extends `data.frame`, so columns can be taken out with `$`, as in `data$sysBP`. The first three rows printed by `head(data, 3)` are as follows, and the columns that do not fit in the width of the console continue below.

```text
         ID   Age Gender  Race Height_CM Weight_KG sysBP    HR Resting_SaO2
     <char> <num>  <int> <int>     <num>     <num> <int> <int>        <int>
1: ID_00001  54.5      2     1     159.9        73   130    87           94
2: ID_00002  62.3      2     1     162.6        86   170    81           94
3: ID_00003  69.1      1     1     173.2        80   147    69           91
     BMI HaveCough  FEV1   FVC Disease
   <num>     <int> <num> <num>  <char>
1: 28.55         0 112.3 114.6 Healthy
2: 32.53         0  51.7  93.3 COVID19
3: 26.67         0  59.3  77.0 COVID19
```

The handout's `data.frame(fread("Data.txt", sep = "\t", head = T, stringsAsFactors = T))` converts the result to a plain `data.frame` and turns string columns into factors. For the computations in this assignment the two ways make no difference.

---

<br>

## 3. Q1.R: Two-Sided Test

```r
## 3. 데이터 전처리: 전체 데이터의 sysBP 사용
# (필요 시 NA 제거)
sysBP_sample <- data$sysBP
sysBP_sample <- sysBP_sample[!is.na(sysBP_sample)]
```

`data$sysBP` is an integer vector of 8,921 values. `is.na()` returns `TRUE` or `FALSE` for whether each element is missing, and indexing with the logical vector inverted by `!` keeps only the elements that are not missing. These data have no missing values, so the vector stays the same, but removing them in advance is safe because `mean()` returns `NA` when any value is missing.

```r
# Known population parameters
mu_0  <- 128.65
sigma <- 16.5
alpha <- 0.05  # Significance level

# Sample statistics (전체 표본 기준)
n     <- length(sysBP_sample)   # 표본 크기
x_bar <- mean(sysBP_sample)     # 표본 평균

# (1) Test Statistic Calculation
z_stat <- (x_bar - mu_0) / (sigma / sqrt(n))

# (2) P-value Calculation (Two-tailed test)
p_value <- 2 * (1 - pnorm(abs(z_stat)))
```

- The population mean $\mu_0$, the population standard deviation $\sigma$, and the significance level $\alpha$ are stored in variables.
- `length()` gives the sample size $n = 8921$, and `mean()` gives the sample mean $\bar{x} = 128.8486$.
- `z_stat` transcribes $Z = (\bar{x} - \mu_0)/(\sigma/\sqrt{n})$ directly.
- `pnorm(q)` is the cumulative distribution function of the standard normal distribution, $\Phi(q) = P(Z \le q)$. The two-sided p-value is the area of the two tails beyond $\lvert z \rvert$, so it is $2\lbrace1 - \Phi(\lvert z \rvert)\rbrace$.

```r
# (3) Decision at 5% significance level
decision_text <- if (p_value < alpha) {
  "At the 5% Significance level, we Reject the Null hypothesis and Select the Alternative hypothesis."
} else {
  "At the 5% Significance level, we Fail to Reject the Null hypothesis and do NOT Select the Alternative hypothesis."
}
```

In R, `if` is an expression that returns a value, so its result can be assigned to a variable directly. The decision sentences contain all five terms the assignment requires (Null hypothesis, Reject, Alternative hypothesis, Select, Significance level). The following `cat(sprintf(...))` lines print the results. In `sprintf()`, `%.2f` means two decimal places, `%d` an integer, and `%.4e` exponential notation with five significant digits.

```text
================ Analysis Result ================
Population Mean (mu): 128.65
Population SD (sigma): 16.50
Sample Size (n): 8921
Sample Mean (x_bar): 128.8486
-------------------------------------------------
(1) Test Statistic (Z): 1.1366
(2) P-value: 2.5570e-01
-------------------------------------------------
At the 5% Significance level, we Fail to Reject the Null hypothesis and do NOT Select the Alternative hypothesis. 
=================================================
```

---

<br>

## 4. Q2.R: Subsetting and a Right-Tailed Test

```r
## 3. 데이터 전처리
# subset 함수를 사용하여 Disease가 COVID19인 데이터 추출
covid_data <- subset(data, Disease == "COVID19")
sysBP_sample <- covid_data$sysBP
```

`subset(data, condition)` keeps only the rows for which the condition is `TRUE`. Inside the condition, `Disease` is interpreted as a column name of `data`, so `data$Disease` is not needed. The same result comes from `data[data$Disease == "COVID19", ]` (base R), `data[Disease == "COVID19"]` (data.table syntax), or `data$sysBP[which(data$Disease == "COVID19")]`.

```r
# (2) P-value Calculation (Right-tailed test)
p_value <- 1 - pnorm(z_stat)
```

The rest of the computation is the same as Q1, and since the test is right-tailed, the p-value is the area of the single right tail, $1 - \Phi(z)$. This script does not print a decision sentence, so the decision is made by comparing the p-value 0.000367 with the significance level 0.05.

```text
================ Analysis Result (Q2) ================
Sample Mean (x_bar): 129.4846
Sample Size (n): 4455
------------------------------------------------------
(3) Test Statistic (Z): 3.3762
(4) P-value: 3.6745e-04
======================================================
```

> **Note:** For large $z$, `1 - pnorm(z)` subtracts a number very close to 1 from 1 and loses significant digits. For example, `1 - pnorm(9)` returns 0, although the true value is about $1.13 \times 10^{-19}$. Computing tail probabilities with `pnorm(z, lower.tail = FALSE)` and two-sided p-values with `2 * pnorm(-abs(z))` avoids the problem. Every $Z$ in this assignment is below 4, so the results are unaffected.

---

<br>

## 5. Q3-4.R: Three Directions and a Decision Function

```r
male_data <- subset(data, Gender == 1)
hr_sample <- male_data$HR

mu_0 <- 74.62
# 문제에서 sigma^2 = 11.1 (분산)으로 주어졌으므로, 표준편차는 sqrt(11.1)
pop_var <- 11.1
pop_sd <- sqrt(pop_var)
```

Rows with `Gender == 1` are men. The assignment gives the variance $\sigma^2 = 11.1$, so the standard deviation for the denominator of the Z statistic is `sqrt(11.1)` = 3.3317 (Section 5.5 of the [HW2 Assignment Explanation](Assignment-Explanation.md) discusses how this value relates to the data).

```r
# 1. Two-tailed (neq)
p_two_tailed <- 2 * (1 - pnorm(abs(z_stat)))

# 2. Right-tailed (greater)
p_right_tailed <- 1 - pnorm(z_stat)

# 3. Left-tailed (less)
p_left_tailed <- pnorm(z_stat)
```

All three p-values come from the same single `z_stat`. The left-tailed p-value is the left tail $\Phi(z)$, and the right-tailed and left-tailed p-values always add up to 1.

```r
make_decision <- function(p_val, alpha, test_type) {
  cat(sprintf("\n[Decision at alpha = %.2f for %s test]\n", alpha, test_type))
  if (p_val < alpha) {
    cat("Since P-value < Significance level, Reject H0. (Select H1)\n")
  } else {
    cat("Since P-value >= Significance level, Do NOT Reject H0.\n")
  }
}
```

`make_decision()` takes a p-value, a significance level, and the name of a test and prints the decision. The same comparison is made several times, so wrapping it in a function removes the repetition. The script judges all three directions at the 0.05 level and the two-sided direction at the 0.10 level.

```text
================ Analysis Result (Q3 & Q4) ================
Population Mean (mu): 74.62
Population SD (sigma): 3.3317 (Variance=11.1)
Sample Size (n): 4834
Sample Mean (x_bar): 74.7005
-----------------------------------------------------------
Test Statistic (Z): 1.6790
-----------------------------------------------------------
[1] Two-tailed P-value: 9.3156e-02
[2] Right-tailed P-value: 4.6578e-02
[3] Left-tailed P-value: 9.5342e-01
===========================================================

<<< Q3 Decision Making (5%) >>>
[Decision at alpha = 0.05 for Two-tailed test]
Since P-value >= Significance level, Do NOT Reject H0.

[Decision at alpha = 0.05 for Right-tailed test]
Since P-value < Significance level, Reject H0. (Select H1)

[Decision at alpha = 0.05 for Left-tailed test]
Since P-value >= Significance level, Do NOT Reject H0.

<<< Q4 Decision Making (10%) >>>
[Decision at alpha = 0.10 for Two-tailed test]
Since P-value < Significance level, Reject H0. (Select H1)
```

To judge all three directions for Q4 as well, call the same function twice more. The right-tailed test rejects, and the left-tailed test does not.

```r
make_decision(p_right_tailed, 0.10, "Right-tailed")
make_decision(p_left_tailed, 0.10, "Left-tailed")
```

```text
[Decision at alpha = 0.10 for Right-tailed test]
Since P-value < Significance level, Reject H0. (Select H1)

[Decision at alpha = 0.10 for Left-tailed test]
Since P-value >= Significance level, Do NOT Reject H0.
```

---

<br>

## 6. Q5.R: Decisions at Several Significance Levels

```r
mu_0 <- 96.0245
pop_var <- 8.995
sigma <- sqrt(pop_var)
```

Q5 is also given a variance, so its square root gives the standard deviation 2.9992. The test statistic and the two-sided p-value are computed as in Q1.

```r
alpha_list <- c(0.01, 0.05, 0.10)

for (alpha in alpha_list) {
  cat(sprintf("\n[Test at Significance Level alpha = %.2f]\n", alpha))
  
  if (p_value < alpha) {
    cat(sprintf("  -> Since P-value (%.4f) < %.2f, Reject H0.\n", p_value, alpha))
    cat("  -> Conclusion: The loaded data represents an independent population.\n")
  } else {
    cat(sprintf("  -> Since P-value (%.4f) >= %.2f, Do NOT Reject H0.\n", p_value, alpha))
    cat("  -> Conclusion: There is no evidence that the loaded data is an independent population.\n")
  }
}
```

`for (alpha in alpha_list)` repeats the body with each element of the vector assigned to `alpha` in turn. It shows the decisions at three conventional significance levels at once and serves to confirm that the conclusion is the same in all three cases. The significance level of the test itself is still fixed to a single value before the analysis.

```text
================ Analysis Result (Q5) ================
Sample Mean (x_bar): 96.0666
Z-statistic: 1.3253
P-value: 0.1851
------------------------------------------------------

[Test at Significance Level alpha = 0.01]
  -> Since P-value (0.1851) >= 0.01, Do NOT Reject H0.
  -> Conclusion: There is no evidence that the loaded data is an independent population.

[Test at Significance Level alpha = 0.05]
  -> Since P-value (0.1851) >= 0.05, Do NOT Reject H0.
  -> Conclusion: There is no evidence that the loaded data is an independent population.

[Test at Significance Level alpha = 0.10]
  -> Since P-value (0.1851) >= 0.10, Do NOT Reject H0.
  -> Conclusion: There is no evidence that the loaded data is an independent population.
======================================================
```

---

<br>

## 7. One Function for All Four Tests

The four scripts differ only in the sample, $\mu_0$, $\sigma$, and the direction, and the computation is the same. Wrapping the common part in one function gives the following. `match.arg()` restricts the `alternative` argument to one of three values with the first value `"two.sided"` as the default, and `switch()` picks the p-value formula for the direction.

```r
library(data.table)
data <- fread("Data.txt")

z_test <- function(x, mu0, sigma, alternative = c("two.sided", "greater", "less")) {
  alternative <- match.arg(alternative)
  n <- length(x)
  z <- (mean(x) - mu0) / (sigma / sqrt(n))
  p <- switch(alternative,
              two.sided = 2 * pnorm(-abs(z)),
              greater   = pnorm(z, lower.tail = FALSE),
              less      = pnorm(z))
  data.frame(n = n, mean = mean(x), z = z, p.value = p)
}

male_hr <- data$HR[data$Gender == 1]
rbind(
  Q1       = z_test(data$sysBP, 128.65, 16.5),
  Q2       = z_test(data$sysBP[data$Disease == "COVID19"], 128.65, 16.5, "greater"),
  Q3_two   = z_test(male_hr, 74.62, sqrt(11.1)),
  Q3_right = z_test(male_hr, 74.62, sqrt(11.1), "greater"),
  Q3_left  = z_test(male_hr, 74.62, sqrt(11.1), "less"),
  Q5       = z_test(data$Resting_SaO2, 96.0245, sqrt(8.995))
)
```

```text
            n      mean        z      p.value
Q1       8921 128.84856 1.136616 0.2556989552
Q2       4455 129.48462 3.376220 0.0003674451
Q3_two   4834  74.70046 1.678980 0.0931559855
Q3_right 4834  74.70046 1.678980 0.0465779928
Q3_left  4834  74.70046 1.678980 0.9534220072
Q5       8921  96.06658 1.325342 0.1850577231
```

The results match the outputs of the four scripts. The boundaries of the rejection regions come from `qnorm()`. `qnorm(0.975)` is 1.959964, `qnorm(0.95)` is 1.644854, and `qnorm(0.90)` is 1.281552, the boundaries for a two-sided test at 5%, a one-sided test at 5% and a two-sided test at 10%, and a one-sided test at 10%, respectively. When the population standard deviation is unknown, `t.test(x, mu = mu0, alternative = ...)` is used in the same structure.

---

<br>

## Summary

| Concept | Key Summary |
|:-----|:-----|
| Preparing packages | The return value of `require()` reveals whether a package is installed, and `install.packages()` runs only when it is missing. |
| Working directory | `sys.frame(1)$ofile` gives the location of the script run by `source()` and sets `../data` as the working directory, and the path is entered directly when running line by line. |
| Loading data | `fread()` detects the separator and header by itself and returns a `data.table`, whose columns are taken out with `$`. |
| Subsets | `subset(data, Disease == "COVID19")` keeps only the rows where the condition is true, and base R indexing or `which()` gives the same result. |
| Z statistic | It is computed as `(mean(x) - mu0) / (sigma / sqrt(length(x)))`. |
| p-values | Two-sided is `2 * pnorm(-abs(z))`, right-tailed is `pnorm(z, lower.tail = FALSE)`, and left-tailed is `pnorm(z)`, while `1 - pnorm(z)` loses precision for large $z$. |
| Printing decisions | `if` and comparison operators compare the p-value with the significance level, and repeated decisions are wrapped in functions and `for` loops. |
| Critical values | `qnorm(1 - alpha / 2)` is the rejection boundary of a two-sided test and `qnorm(1 - alpha)` that of a one-sided test. |

---

<br>

## Self-Check Questions

1. **Missing values:** For `x <- c(120, NA, 130)`, what do `mean(x)` and `mean(x[!is.na(x)])` return?

   <details>
   <summary>Answer</summary>

   `mean(x)` returns `NA`, and `mean(x[!is.na(x)])` returns 125. `mean(x, na.rm = TRUE)` also gives 125.

   </details>

2. **Tail probabilities:** Write the R expressions for the left-tailed, right-tailed, and two-sided p-values of $z = -2.2$.

   <details>
   <summary>Answer</summary>

   Left-tailed: `pnorm(-2.2)` (0.0139). Right-tailed: `pnorm(-2.2, lower.tail = FALSE)` (0.9861). Two-sided: `2 * pnorm(-abs(-2.2))` (0.0278).

   </details>

3. **Subsets:** Write code that extracts only the `HR` of subjects who are female (`Gender == 2`) and COVID19 patients.

   <details>
   <summary>Answer</summary>

   `subset(data, Gender == 2 & Disease == "COVID19")$HR`. Both conditions must hold, so the logical AND `&` is used. In base R it is `data$HR[data$Gender == 2 & data$Disease == "COVID19"]`.

   </details>

4. **Working directory:** What happens if only line 14 of `Q1.R` is run in the console, and how can it be fixed?

   <details>
   <summary>Answer</summary>

   At the top level there is no call frame, so `sys.frame(1)` raises an error and `WORK_DIR` is not created. Put the path of the data folder in directly, as in `WORK_DIR <- "Coursework/HW02_One-Sample-Z-Test/data"`, and then run line 15.

   </details>

5. **Critical values:** Find the rejection boundaries of a two-sided test and a right-tailed test at the 1% significance level in R.

   <details>
   <summary>Answer</summary>

   Two-sided: `qnorm(0.995)` = 2.576. Right-tailed: `qnorm(0.99)` = 2.326.

   </details>
