# @file    Q5.R
# @brief   HW2 Q5: two-sided one-sample Z-test of resting SaO2 against the Korean
#          health checkup reference at the 1%, 5%, and 10% significance levels
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
# 전체 데이터 대상
sao2_sample <- data$Resting_SaO2
# 존재할 수 있는 결측치 제거
sao2_sample <- sao2_sample[!is.na(sao2_sample)]


## 4. 가설 검정 (One-sample Z-test)
# H0: mu = 96.0245
# H1: mu != 96.0245

# Known population parameters
mu_0 <- 96.0245
pop_var <- 8.995
sigma <- sqrt(pop_var)

# Sample statistics
n <- length(sao2_sample)
x_bar <- mean(sao2_sample)

# (1) Test Statistics Calculation
z_stat <- (x_bar - mu_0) / (sigma / sqrt(n))

# (2) P-value Calculation (Two-tailed)
p_value <- 2 * (1 - pnorm(abs(z_stat)))


## 5. 결과 출력
cat("\n================ Analysis Result (Q5) ================\n")
cat(sprintf("Sample Mean (x_bar): %.4f\n", x_bar))
cat(sprintf("Z-statistic: %.4f\n", z_stat))
cat(sprintf("P-value: %.4f\n", p_value))
cat("------------------------------------------------------\n")

# 검증할 유의 수준 목록 정의 (1%, 5%, 10%)
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
cat("======================================================\n")