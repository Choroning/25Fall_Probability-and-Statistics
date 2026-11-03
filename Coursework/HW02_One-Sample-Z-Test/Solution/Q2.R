# @file    Q2.R
# @brief   HW2 Q2: right-tailed one-sample Z-test of whether COVID19 patients have
#          a higher mean systolic blood pressure than the NIH reference
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
# subset 함수를 사용하여 Disease가 COVID19인 데이터 추출
covid_data <- subset(data, Disease == "COVID19")
sysBP_sample <- covid_data$sysBP


## 4. 가설 검정 (Hypothesis Test: One-sample Z-test, Right-tailed)
# H0: mu = 128.65
# H1: mu > 128.65 (Higher than national statistics)

# Known population parameters
mu_0 <- 128.65
sigma <- 16.5

# Sample statistics
n <- length(sysBP_sample)
x_bar <- mean(sysBP_sample)

# (1) Test Statistics Calculation
z_stat <- (x_bar - mu_0) / (sigma / sqrt(n))

# (2) P-value Calculation (Right-tailed test)
p_value <- 1 - pnorm(z_stat)

# 결과 출력
cat("\n================ Analysis Result (Q2) ================\n")
cat(sprintf("Sample Mean (x_bar): %.4f\n", x_bar))
cat(sprintf("Sample Size (n): %d\n", n))
cat("------------------------------------------------------\n")
cat(sprintf("(3) Test Statistic (Z): %.4f\n", z_stat))
cat(sprintf("(4) P-value: %.4e\n", p_value))
cat("======================================================\n")