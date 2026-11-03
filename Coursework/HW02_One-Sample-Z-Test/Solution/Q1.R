# @file    Q1.R
# @brief   HW2 Q1: two-sided one-sample Z-test of whether the mean systolic blood
#          pressure of all subjects differs from the NIH reference N(128.65, 16.5^2)
# @author  Cheolwon Park
# @date    2025-12-07

## 1. 기본 환경 설정
setRepositories(ind = 1:7)
if (!require("data.table")) install.packages("data.table")
library(data.table)

########################################################
# 작업 경로 설정
WORK_DIR <- file.path(dirname(sys.frame(1)$ofile %||% "."), "../data")
if (WORK_DIR != "") setwd(WORK_DIR)
########################################################


## 2. 데이터 로드
file_name <- "Data.txt"
data <- fread(file_name)


## 3. 데이터 전처리: 전체 데이터의 sysBP 사용
# (필요 시 NA 제거)
sysBP_sample <- data$sysBP
sysBP_sample <- sysBP_sample[!is.na(sysBP_sample)]


## 4. 가설 검정 (Hypothesis Test: One-sample Z-test)
# H0: mu = 128.65 (Collected Samples are not biased)
# H1: mu != 128.65 (Different from the population)

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

# (3) Decision at 5% significance level
decision_text <- if (p_value < alpha) {
  "At the 5% Significance level, we Reject the Null hypothesis and Select the Alternative hypothesis."
} else {
  "At the 5% Significance level, we Fail to Reject the Null hypothesis and do NOT Select the Alternative hypothesis."
}

# 결과 출력
cat("\n================ Analysis Result ================\n")
cat(sprintf("Population Mean (mu): %.2f\n", mu_0))
cat(sprintf("Population SD (sigma): %.2f\n", sigma))
cat(sprintf("Sample Size (n): %d\n", n))
cat(sprintf("Sample Mean (x_bar): %.4f\n", x_bar))
cat("-------------------------------------------------\n")
cat(sprintf("(1) Test Statistic (Z): %.4f\n", z_stat))
cat(sprintf("(2) P-value: %.4e\n", p_value))
cat("-------------------------------------------------\n")
cat(decision_text, "\n")
cat("=================================================\n")
