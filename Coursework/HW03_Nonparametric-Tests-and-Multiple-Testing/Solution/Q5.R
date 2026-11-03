# @file    Q5.R
# @brief   HW3 Q5: gene-wise Welch two-sample t-tests between the cancer and healthy
#          groups at the 1% significance level
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
Q5_data <- read.table("Q5_Data.tsv",
                      header = TRUE,
                      sep = "\t",
                      stringsAsFactors = TRUE)

str(Q5_data)
table(Q5_data$Disease)   # Cancer / Healthy 여부 확인


## 2. 유전자 변수 이름 추출
# Gene_1 ~ Gene_1274 컬럼을 자동으로 찾기
gene_cols <- grep("^Gene_", names(Q5_data), value = TRUE)
length(gene_cols)        # 유전자 개수 확인용

# 결과를 저장할 데이터프레임 생성
gene_result <- data.frame(
  Gene         = gene_cols,
  p_value      = NA_real_,
  mean_Cancer  = NA_real_,
  mean_Healthy = NA_real_,
  stringsAsFactors = FALSE
)


## 3. 유의수준 설정 및 그룹 인덱스
alpha <- 0.01   # Significance level = 1%

idx_cancer  <- Q5_data$Disease == "Cancer"
idx_healthy <- Q5_data$Disease == "Healthy"   # normal-group에 해당


## 4. 각 유전자에 대해 2표본 t-test 수행
# 귀무가설(H0): Cancer-group과 Healthy-group의 해당 유전자 평균은 같다.
# 대립가설(H1): 두 집단의 해당 유전자 평균은 다르다. (양측 검정)

for (i in seq_along(gene_cols)) {
  gname <- gene_cols[i]
  
  x_cancer  <- Q5_data[idx_cancer,  gname]
  x_healthy <- Q5_data[idx_healthy, gname]
  
  # Welch's two-sample t-test (var.equal = FALSE가 기본)
  t_res <- t.test(x_cancer, x_healthy,
                  alternative = "two.sided")
  
  gene_result$p_value[i]      <- t_res$p.value
  gene_result$mean_Cancer[i]  <- mean(x_cancer)
  gene_result$mean_Healthy[i] <- mean(x_healthy)
}

## 5. 유의한 유전자 선별 및 개수 확인
sig_genes <- subset(gene_result, p_value < alpha)

n_sig <- nrow(sig_genes)
cat("Number of significant genes at 1% significance level:", n_sig, "\n")

# 필요하다면 유의한 유전자 상위 일부를 확인
head(sig_genes[order(sig_genes$p_value), ])
