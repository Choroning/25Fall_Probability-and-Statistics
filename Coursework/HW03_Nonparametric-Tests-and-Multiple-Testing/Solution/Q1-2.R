# @file    Q1-2.R
# @brief   HW3 Q1-2: pooled two-sample t-test and Wilcoxon rank-sum test of COVID-19
#          case counts between statistician and computer scientist institutions
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

## 2. 기초 통계량 및 시각화
# 집단별 요약 통계
by(Q1_data$numCOVID, Q1_data$Job, summary)

# 박스플롯으로 분포 비교
boxplot(numCOVID ~ Job,
        data = Q1_data,
        main = "Number of COVID-19 Cases by Job Group",
        xlab = "Job",
        ylab = "Number of COVID-19 cases")

## 3. 정규성 가정 점검 (참고용)
by(Q1_data$numCOVID, Q1_data$Job, shapiro.test)

par(mfrow = c(1, 2))

# Statistician
with(subset(Q1_data, Job == "Statistician"),
     qqnorm(numCOVID, main = "QQ Plot (Statistician)"))
with(subset(Q1_data, Job == "Statistician"),
     qqline(numCOVID))

# ComputerScientist
with(subset(Q1_data, Job == "ComputerScientist"),
     qqnorm(numCOVID, main = "QQ Plot (Computer Scientist)"))
with(subset(Q1_data, Job == "ComputerScientist"),
     qqline(numCOVID))

par(mfrow = c(1, 1))


## 4. 모수적 방법: 두 집단 평균 비교 t-test (독립 2표본 t-검정)

# 귀무가설(H0): 두 집단의 평균 확진자 수는 같다.
# 대립가설(H1): 두 집단의 평균 확진자 수는 다르다.
# 유의수준(Significance level): alpha = 0.05

t_res <- t.test(numCOVID ~ Job,
                data = Q1_data,
                alternative = "two.sided",   # 양측 검정
                var.equal = TRUE)            # 등분산 가정

t_res

## 5. 비모수적 방법: Wilcoxon rank-sum test

# 귀무가설(H0): 두 집단의 분포(중앙값)는 같다.
# 대립가설(H1): 두 집단의 분포(중앙값)는 다르다.
# 유의수준(Significance level): alpha = 0.05

wil_res <- wilcox.test(numCOVID ~ Job,
                       data = Q1_data,
                       alternative = "two.sided",
                       exact = FALSE,    # 표본수가 작을 때도 근사 사용
                       correct = FALSE)  # continuity correction 끔(선택)

wil_res
