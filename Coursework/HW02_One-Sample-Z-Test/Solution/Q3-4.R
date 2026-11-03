# @file    Q3-4.R
# @brief   HW2 Q3-4: two-sided, right-tailed, and left-tailed one-sample Z-tests of
#          male heart rate against N(74.62, sigma^2 = 11.1) at the 5% and 10% levels
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

## 3. 데이터 전처리
# 남성 데이터 추출 (Gender == 1 가정)
# 만약 데이터셋의 Gender가 1(Male), 2(Female)이라고 가정함.
male_data <- subset(data, Gender == 1)
hr_sample <- male_data$HR

## 4. 가설 검정 설정 (Parameters)
# Known population parameters from NIH
mu_0 <- 74.62
# 문제에서 sigma^2 = 11.1 (분산)으로 주어졌으므로, 표준편차는 sqrt(11.1)
pop_var <- 11.1
pop_sd <- sqrt(pop_var)

# Sample statistics
n <- length(hr_sample)
x_bar <- mean(hr_sample)

# (1) Test Statistics Calculation (Z-test)
z_stat <- (x_bar - mu_0) / (pop_sd / sqrt(n))

# (2) P-value Calculation for 3 Directions
# 1. Two-tailed (neq)
p_two_tailed <- 2 * (1 - pnorm(abs(z_stat)))

# 2. Right-tailed (greater)
p_right_tailed <- 1 - pnorm(z_stat)

# 3. Left-tailed (less)
p_left_tailed <- pnorm(z_stat)

## 5. 결과 출력 (Q3 & Q4)

cat("\n================ Analysis Result (Q3 & Q4) ================\n")
cat(sprintf("Population Mean (mu): %.2f\n", mu_0))
cat(sprintf("Population SD (sigma): %.4f (Variance=%.1f)\n", pop_sd, pop_var))
cat(sprintf("Sample Size (n): %d\n", n))
cat(sprintf("Sample Mean (x_bar): %.4f\n", x_bar))
cat("-----------------------------------------------------------\n")
cat(sprintf("Test Statistic (Z): %.4f\n", z_stat))
cat("-----------------------------------------------------------\n")
cat(sprintf("[1] Two-tailed P-value: %.4e\n", p_two_tailed))
cat(sprintf("[2] Right-tailed P-value: %.4e\n", p_right_tailed))
cat(sprintf("[3] Left-tailed P-value: %.4e\n", p_left_tailed))
cat("===========================================================\n")

# Decision Making Function
make_decision <- function(p_val, alpha, test_type) {
  cat(sprintf("\n[Decision at alpha = %.2f for %s test]\n", alpha, test_type))
  if (p_val < alpha) {
    cat("Since P-value < Significance level, Reject H0. (Select H1)\n")
  } else {
    cat("Since P-value >= Significance level, Do NOT Reject H0.\n")
  }
}

# Q3 Decisions (alpha = 0.05)
cat("\n<<< Q3 Decision Making (5%) >>>")
make_decision(p_two_tailed, 0.05, "Two-tailed")
make_decision(p_right_tailed, 0.05, "Right-tailed")
make_decision(p_left_tailed, 0.05, "Left-tailed")

# Q4 Decisions (alpha = 0.10)
cat("\n<<< Q4 Decision Making (10%) >>>")
make_decision(p_two_tailed, 0.10, "Two-tailed")
# Note: Usually compare the appropriate direction based on sample mean vs mu_0