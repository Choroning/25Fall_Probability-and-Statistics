# HW2 코드 총정리 — 단일 표본 Z 검정

[레포지토리 안내](../../README.ko.md) | [English](Code-Walkthrough.md) | [한국어](Code-Walkthrough.ko.md)

> **최종 수정일:** 2026-11-04

> **학습 목표:**
> 1. data.table의 `fread()`로 탭 구분 데이터를 불러오고 열과 부분집합을 추출할 수 있다
> 2. 표본 크기, 표본평균, Z 통계량, 방향별 유의확률을 R 코드로 계산할 수 있다
> 3. `pnorm()`과 `qnorm()`으로 표준정규분포의 꼬리 확률과 임계값을 구하고, 꼬리 확률의 수치 정밀도 문제를 피할 수 있다
> 4. 조건문, 함수, 반복문으로 유의수준에 따른 결정을 출력하는 코드를 작성할 수 있다

---

## 목차

- [1. 파일 구성과 실행 방법](#1-파일-구성과-실행-방법)
- [2. 네 스크립트의 공통 부분](#2-네-스크립트의-공통-부분)
  - [2.1 패키지 준비](#21-패키지-준비)
  - [2.2 작업 경로 설정](#22-작업-경로-설정)
  - [2.3 데이터 불러오기](#23-데이터-불러오기)
- [3. Q1.R: 양측 검정](#3-q1r-양측-검정)
- [4. Q2.R: 부분집합과 우측 검정](#4-q2r-부분집합과-우측-검정)
- [5. Q3-4.R: 세 방향 검정과 결정 함수](#5-q3-4r-세-방향-검정과-결정-함수)
- [6. Q5.R: 여러 유의수준에서의 결정](#6-q5r-여러-유의수준에서의-결정)
- [7. 네 검정을 하나의 함수로 묶기](#7-네-검정을-하나의-함수로-묶기)
- [요약](#요약)
- [점검 문제](#점검-문제)

---

<br>

## 1. 파일 구성과 실행 방법

`Solution/`의 R 스크립트 네 개는 문항마다 하나의 단일 표본 Z 검정을 수행한다. 문항의 통계적 해설은 [HW2 과제 해설](Assignment-Explanation.ko.md)에 있고, 이 문서는 코드를 처음부터 끝까지 읽는다.

| 파일 | 대상 표본 | 검정 | 출력 |
|:-----|:-----|:-----|:-----|
| `Q1.R` | 전체 8,921명의 `sysBP` | 양측, $\alpha = 0.05$ | $Z$, 유의확률, 결정 문장 |
| `Q2.R` | COVID19 환자 4,455명의 `sysBP` | 우측 | $Z$, 유의확률 |
| `Q3-4.R` | 남성 4,834명의 `HR` | 양측, 우측, 좌측과 $\alpha = 0.05, 0.10$ | $Z$, 세 유의확률, 방향별 결정 |
| `Q5.R` | 전체 8,921명의 `Resting_SaO2` | 양측, $\alpha = 0.01, 0.05, 0.10$ | $Z$, 유의확률, 유의수준별 결정 |

*표 1. HW2 스크립트의 구성*

스크립트는 자신이 있는 폴더를 기준으로 데이터 폴더를 찾으므로 `source()`로 실행한다. 레포지토리 루트에서 R을 열었다면 다음과 같이 실행하고, RStudio에서는 스크립트를 연 뒤 Source 버튼을 누르면 같은 방식으로 실행된다.

```r
source("Coursework/HW02_One-Sample-Z-Test/Solution/Q1.R")
```

---

<br>

## 2. 네 스크립트의 공통 부분

네 스크립트의 앞부분 20여 줄은 같다. `Q1.R`의 1\~21행을 예로 든다.

### 2.1 패키지 준비

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

- 1\~5행은 파일 이름, 한 줄 설명, 작성자, 작성일을 적은 Doxygen 스타일 헤더이다.
- `setRepositories(ind = 1:7)`은 `install.packages()`가 패키지를 찾을 저장소를 CRAN, Bioconductor의 세 저장소, CRAN extras, R-Forge, rforge.net의 일곱 곳으로 넓힌다. data.table은 CRAN에 있으므로 이 줄이 없어도 동작하지만, Bioconductor 패키지를 쓰는 분석에서도 같은 머리말을 쓸 수 있게 둔 줄이다.
- `require()`는 패키지를 불러오면서 성공 여부를 `TRUE`나 `FALSE`로 돌려준다. 패키지가 설치되어 있지 않으면 경고와 함께 `FALSE`를 돌려주므로 `!`로 뒤집어 그때만 `install.packages()`를 실행한다. 이어지는 `library()`는 설치 직후의 경우까지 포함해 패키지를 확실히 불러온다.

### 2.2 작업 경로 설정

```r
########################################################
# 작업 경로 설정
WORK_DIR <- file.path(dirname(sys.frame(1)$ofile %||% "."), "../data")
if (WORK_DIR != "") setwd(WORK_DIR)
########################################################
```

- `source(".../Solution/Q1.R")`로 스크립트를 실행하면 호출 스택의 첫 프레임은 `source()` 함수의 실행 환경이고, 그 안의 변수 `ofile`에 스크립트 경로가 들어 있다. `sys.frame(1)$ofile`은 이 경로를 꺼낸다.
- `dirname()`은 경로에서 파일 이름을 뗀 폴더 경로(`.../Solution`)를 돌려주고, `file.path(..., "../data")`는 그 옆의 `data/` 폴더 경로를 만든다.
- `%||%`는 R 4.4.0부터 기본으로 제공되는 연산자로, 왼쪽 값이 `NULL`이면 오른쪽 값을 돌려준다. `ofile`이 없을 때를 대비한 대체값 `"."`(현재 폴더)이다.
- `setwd()`로 작업 디렉토리를 데이터 폴더로 바꾸므로, 이후의 `fread("Data.txt")`는 파일 이름만으로 데이터를 찾는다.

> **주의:** 이 방식은 스크립트를 `source()`로 실행할 때만 동작한다. 콘솔에서 한 줄씩 실행하거나 `Rscript Q1.R`로 실행하면 호출 스택에 프레임이 없어 `sys.frame(1)`이 오류를 낸다. 그때는 `WORK_DIR`에 데이터 폴더의 경로를 직접 넣으면 된다.

### 2.3 데이터 불러오기

```r
## 2. 데이터 로드
file_name <- "Data.txt"
data <- fread(file_name)
```

`fread()`는 data.table 패키지의 빠른 파일 읽기 함수로, 구분자(여기서는 탭)와 머리글 행을 스스로 판단해 `data.table` 객체를 돌려준다. `data.table`은 `data.frame`을 확장한 클래스여서 `data$sysBP`처럼 `$`로 열을 꺼낼 수 있다. 앞의 세 행은 다음과 같다.

```text
         ID   Age Gender  Race Height_CM Weight_KG sysBP    HR Resting_SaO2
     <char> <num>  <int> <int>     <num>     <num> <int> <int>        <int>
1: ID_00001  54.5      2     1     159.9        73   130    87           94
2: ID_00002  62.3      2     1     162.6        86   170    81           94
3: ID_00003  69.1      1     1     173.2        80   147    69           91
```

과제 원본이 보인 `data.frame(fread("Data.txt", sep = "\t", head = T, stringsAsFactors = T))`는 결과를 일반 `data.frame`으로 바꾸고 문자열 열을 팩터로 만든다. 이 과제의 계산에는 두 방식의 차이가 없다.

---

<br>

## 3. Q1.R: 양측 검정

```r
## 3. 데이터 전처리: 전체 데이터의 sysBP 사용
# (필요 시 NA 제거)
sysBP_sample <- data$sysBP
sysBP_sample <- sysBP_sample[!is.na(sysBP_sample)]
```

`data$sysBP`는 8,921개의 정수 벡터이다. `is.na()`는 원소마다 결측 여부를 `TRUE`나 `FALSE`로 돌려주고, `!`로 뒤집은 논리 벡터로 인덱싱하면 결측이 아닌 원소만 남는다. 이 데이터에는 결측값이 없으므로 벡터가 그대로 유지되지만, 결측값이 있으면 `mean()`이 `NA`를 돌려주므로 미리 지우는 것이 안전하다.

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

- 모평균 $\mu_0$, 모표준편차 $\sigma$, 유의수준 $\alpha$를 변수로 둔다.
- `length()`는 표본 크기 $n = 8921$, `mean()`은 표본평균 $\bar{x} = 128.8486$을 준다.
- `z_stat`은 $Z = (\bar{x} - \mu_0)/(\sigma/\sqrt{n})$을 그대로 옮긴 식이다.
- `pnorm(q)`는 표준정규분포의 누적분포함수 $\Phi(q) = P(Z \le q)$이다. 양측 유의확률은 $\lvert z \rvert$보다 바깥쪽 두 꼬리의 넓이이므로 $2\{1 - \Phi(\lvert z \rvert)\}$이다.

```r
# (3) Decision at 5% significance level
decision_text <- if (p_value < alpha) {
  "At the 5% Significance level, we Reject the Null hypothesis and Select the Alternative hypothesis."
} else {
  "At the 5% Significance level, we Fail to Reject the Null hypothesis and do NOT Select the Alternative hypothesis."
}
```

R의 `if`는 값을 돌려주는 식이므로 그 결과를 바로 변수에 대입할 수 있다. 결정 문장에는 과제가 요구한 다섯 용어(Null hypothesis, Reject, Alternative hypothesis, Select, Significance level)가 모두 들어 있다. 이어지는 `cat(sprintf(...))` 줄은 결과를 출력한다. `sprintf()`의 `%.2f`는 소수점 아래 두 자리, `%d`는 정수, `%.4e`는 유효숫자 다섯 자리의 지수 표기이다.

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

## 4. Q2.R: 부분집합과 우측 검정

```r
## 3. 데이터 전처리
# subset 함수를 사용하여 Disease가 COVID19인 데이터 추출
covid_data <- subset(data, Disease == "COVID19")
sysBP_sample <- covid_data$sysBP
```

`subset(data, 조건)`은 조건이 `TRUE`인 행만 남긴다. 조건 안의 `Disease`는 `data`의 열 이름으로 해석되므로 `data$Disease`라고 쓰지 않아도 된다. 같은 결과를 `data[data$Disease == "COVID19", ]`(기본 R), `data[Disease == "COVID19"]`(data.table 문법), `data$sysBP[which(data$Disease == "COVID19")]`로도 얻을 수 있다.

```r
# (2) P-value Calculation (Right-tailed test)
p_value <- 1 - pnorm(z_stat)
```

나머지 계산은 Q1과 같고, 우측 검정이므로 유의확률은 오른쪽 꼬리 하나의 넓이 $1 - \Phi(z)$이다. 이 스크립트는 결정 문장을 출력하지 않으므로 결정은 유의확률 0.000367과 유의수준 0.05를 비교해 내린다.

```text
================ Analysis Result (Q2) ================
Sample Mean (x_bar): 129.4846
Sample Size (n): 4455
------------------------------------------------------
(3) Test Statistic (Z): 3.3762
(4) P-value: 3.6745e-04
======================================================
```

> **참고:** `1 - pnorm(z)`는 $z$가 크면 1에 매우 가까운 수를 1에서 빼므로 유효숫자를 잃는다. 예를 들어 `1 - pnorm(9)`는 0을 돌려주지만 실제 값은 약 $1.13 \times 10^{-19}$이다. 꼬리 확률은 `pnorm(z, lower.tail = FALSE)`로, 양측 유의확률은 `2 * pnorm(-abs(z))`로 계산하면 이 문제가 없다. 이 과제의 $Z$는 모두 4보다 작아 결과에 차이가 없다.

---

<br>

## 5. Q3-4.R: 세 방향 검정과 결정 함수

```r
male_data <- subset(data, Gender == 1)
hr_sample <- male_data$HR

mu_0 <- 74.62
# 문제에서 sigma^2 = 11.1 (분산)으로 주어졌으므로, 표준편차는 sqrt(11.1)
pop_var <- 11.1
pop_sd <- sqrt(pop_var)
```

`Gender == 1`인 행이 남성이다. 과제는 분산 $\sigma^2 = 11.1$을 주었으므로 Z 통계량의 분모에 쓸 표준편차는 `sqrt(11.1)` = 3.3317이다(이 값과 자료의 관계는 [HW2 과제 해설](Assignment-Explanation.ko.md)의 5.5절).

```r
# 1. Two-tailed (neq)
p_two_tailed <- 2 * (1 - pnorm(abs(z_stat)))

# 2. Right-tailed (greater)
p_right_tailed <- 1 - pnorm(z_stat)

# 3. Left-tailed (less)
p_left_tailed <- pnorm(z_stat)
```

같은 `z_stat` 하나에서 세 방향의 유의확률을 모두 구한다. 좌측 유의확률은 왼쪽 꼬리 $\Phi(z)$이고, 우측과 좌측 유의확률의 합은 항상 1이다.

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

`make_decision()`은 유의확률, 유의수준, 검정 이름을 받아 결정을 출력하는 함수이다. 같은 비교를 여러 번 하므로 함수로 묶어 중복을 없앴다. 스크립트는 유의수준 0.05에서 세 방향을, 0.10에서 양측 방향을 판정한다.

```text
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

Q4도 세 방향을 모두 판정하려면 같은 함수를 두 번 더 부르면 된다. 결과는 우측 기각, 좌측 기각하지 못함이다.

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

## 6. Q5.R: 여러 유의수준에서의 결정

```r
mu_0 <- 96.0245
pop_var <- 8.995
sigma <- sqrt(pop_var)
```

Q5도 분산이 주어졌으므로 제곱근을 취해 표준편차 2.9992를 얻는다. 검정통계량과 양측 유의확률의 계산은 Q1과 같다.

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

`for (alpha in alpha_list)`는 벡터의 원소를 차례로 `alpha`에 넣으며 본문을 반복한다. 관례적인 세 유의수준에서의 결정을 한 번에 보여 주며, 세 경우 모두 결론이 같다는 것을 확인하는 용도이다. 검정 자체의 유의수준은 분석 전에 하나로 정한다.

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

## 7. 네 검정을 하나의 함수로 묶기

네 스크립트는 표본, $\mu_0$, $\sigma$, 방향만 다르고 계산은 같다. 이 공통 부분을 함수 하나로 묶으면 다음과 같다. `match.arg()`는 `alternative` 인자를 세 값 중 하나로 제한하고 기본값을 첫째 값 `"two.sided"`로 정하며, `switch()`는 방향에 맞는 유의확률 식을 고른다.

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

결과는 네 스크립트의 출력과 같다. 기각역의 경계값은 `qnorm()`으로 구한다. `qnorm(0.975)`는 1.959964, `qnorm(0.95)`는 1.644854, `qnorm(0.90)`은 1.281552이며, 각각 유의수준 5% 양측, 5% 단측과 10% 양측, 10% 단측 검정의 경계이다. 모표준편차를 모를 때는 같은 구조에서 `t.test(x, mu = mu0, alternative = ...)`를 쓴다.

---

<br>

## 요약

| 개념 | 핵심 요약 |
|:-----|:-----|
| 패키지 준비 | `require()`의 반환값으로 설치 여부를 확인하고, 없을 때만 `install.packages()`를 실행한다. |
| 작업 경로 | `sys.frame(1)$ofile`로 `source()`된 스크립트의 위치를 얻어 `../data`를 작업 디렉토리로 정하며, 한 줄씩 실행할 때는 경로를 직접 넣는다. |
| 데이터 불러오기 | `fread()`는 구분자와 머리글을 스스로 판단해 `data.table`을 돌려주고, 열은 `$`로 꺼낸다. |
| 부분집합 | `subset(data, Disease == "COVID19")`처럼 조건이 참인 행만 남기며, 기본 R 인덱싱이나 `which()`로도 같은 결과를 얻는다. |
| Z 통계량 | `(mean(x) - mu0) / (sigma / sqrt(length(x)))`로 계산한다. |
| 유의확률 | 양측은 `2 * pnorm(-abs(z))`, 우측은 `pnorm(z, lower.tail = FALSE)`, 좌측은 `pnorm(z)`이며, `1 - pnorm(z)`는 큰 $z$에서 정밀도를 잃는다. |
| 결정 출력 | `if`와 비교 연산으로 유의확률과 유의수준을 비교하고, 반복되는 결정은 함수와 `for` 반복문으로 묶는다. |
| 임계값 | `qnorm(1 - alpha / 2)`는 양측, `qnorm(1 - alpha)`는 단측 검정의 기각 경계이다. |

---

<br>

## 점검 문제

1. **결측값:** `x <- c(120, NA, 130)`일 때 `mean(x)`와 `mean(x[!is.na(x)])`의 결과는?

   <details>
   <summary>정답</summary>

   `mean(x)`는 `NA`이고, `mean(x[!is.na(x)])`는 125이다. `mean(x, na.rm = TRUE)`도 125를 준다.

   </details>

2. **꼬리 확률:** $z = -2.2$의 좌측, 우측, 양측 유의확률을 구하는 R 식을 각각 쓰라.

   <details>
   <summary>정답</summary>

   좌측은 `pnorm(-2.2)`(0.0139), 우측은 `pnorm(-2.2, lower.tail = FALSE)`(0.9861), 양측은 `2 * pnorm(-abs(-2.2))`(0.0278)이다.

   </details>

3. **부분집합:** 여성(`Gender == 2`)이면서 COVID19 환자인 대상자의 `HR`만 꺼내는 코드를 쓰라.

   <details>
   <summary>정답</summary>

   `subset(data, Gender == 2 & Disease == "COVID19")$HR`이다. 두 조건을 모두 만족해야 하므로 논리곱 `&`를 쓴다. 기본 R로는 `data$HR[data$Gender == 2 & data$Disease == "COVID19"]`이다.

   </details>

4. **작업 경로:** 콘솔에서 `Q1.R`의 14행을 한 줄만 실행하면 어떤 일이 생기며, 어떻게 고쳐 실행할 수 있는가?

   <details>
   <summary>정답</summary>

   최상위 수준에는 호출 프레임이 없어 `sys.frame(1)`이 오류를 내고 `WORK_DIR`이 만들어지지 않는다. `WORK_DIR <- "Coursework/HW02_One-Sample-Z-Test/data"`처럼 데이터 폴더의 경로를 직접 넣은 뒤 15행을 실행하면 된다.

   </details>

5. **임계값:** 유의수준 1%의 양측 검정과 우측 검정의 기각 경계를 R로 구하라.

   <details>
   <summary>정답</summary>

   양측은 `qnorm(0.995)` = 2.576이고, 우측은 `qnorm(0.99)` = 2.326이다.

   </details>
