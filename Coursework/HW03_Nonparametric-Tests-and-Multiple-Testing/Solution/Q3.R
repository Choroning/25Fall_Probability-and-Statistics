# @file    Q3.R
# @brief   HW3 Q3: exact permutation test with the Seo statistic, the absolute
#          difference between the two group medians, at the 10% significance level
# @author  Cheolwon Park
# @date    2025-12-08

## 1. 기본 설정 및 데이터 불러오기
setRepositories(ind = 1:7)

################################################################
# 작업 경로 설정
WORK_DIR <- file.path(dirname(sys.frame(1)$ofile %||% "."), "../data")
if (WORK_DIR != "") setwd(WORK_DIR)
################################################################

# 데이터 로드
Q1_data <- read.table("Q1_Data.tsv",
                      header = TRUE,
                      sep = "\t",
                      stringsAsFactors = TRUE)

str(Q1_data)
table(Q1_data$Job)


## 2. Seo-Stat 계산
# Seo-Stat = | Median(A group) - Median(B group) |
# 여기서는 A = "ComputerScientist", B = "Statistician"으로 설정

group_A <- "ComputerScientist"
group_B <- "Statistician"

x_A <- Q1_data$numCOVID[Q1_data$Job == group_A]
x_B <- Q1_data$numCOVID[Q1_data$Job == group_B]

median_A <- median(x_A)
median_B <- median(x_B)

Seo_obs <- abs(median_A - median_B)

cat("Median (", group_A, ") =", median_A, "\n")
cat("Median (", group_B, ") =", median_B, "\n")
cat("Observed Seo-Stat =", Seo_obs, "\n\n")


## 3. 가설 설정 및 유의수준
# 귀무가설(H0): 두 직업 집단의 중앙값(분포 위치)은 같다.
# 대립가설(H1): 두 직업 집단의 중앙값(분포 위치)은 다르다.
# 검정통계량: Seo-Stat = |median_A - median_B|
# 유의수준(Significance level): alpha = 0.10

alpha <- 0.10


## 4. Permutation test를 이용한 Seo-Stat 검정
# 전체 관측값에서 임의로 9개를 선택하여 A그룹, 나머지를 B그룹으로 두고
# 각 분할마다 Seo-Stat을 계산하여 귀무가설 하에서의 분포를 근사/계산

values <- Q1_data$numCOVID
n <- length(values)   # 18개

# 18개 중 9개를 고르는 모든 조합 생성 (각 열이 A그룹의 인덱스 집합)
combs <- combn(n, n / 2)

Seo_perm <- apply(combs, 2, function(idx_A) {
  med_A <- median(values[idx_A])
  med_B <- median(values[-idx_A])
  abs(med_A - med_B)
})

# p-value 계산 (양측: 관측 Seo-Stat 이상인 경우의 비율)
p_value <- mean(Seo_perm >= Seo_obs - 1e-12)

cat("Seo-Stat permutation test p-value =", p_value, "\n\n")


## 5. 결론 출력
cat("Significance level (alpha) =", alpha, "\n")

if (p_value < alpha) {
  cat("At the 10% significance level, we Reject the Null hypothesis\n")
  cat("and Select the Alternative hypothesis.\n")
  cat("=> Seo-Stat 기준으로 두 직업 집단의 중앙값(분포 위치)은 다르다고 볼 통계적 근거가 있습니다.\n")
} else {
  cat("At the 10% significance level, we fail to Reject the Null hypothesis.\n")
  cat("=> Seo-Stat 기준으로 두 직업 집단의 중앙값(분포 위치)이 다르다고 결론 내릴 만한 통계적 근거는 부족합니다.\n")
}
