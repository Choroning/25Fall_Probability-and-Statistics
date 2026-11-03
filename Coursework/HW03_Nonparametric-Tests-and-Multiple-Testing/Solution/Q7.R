# @file    Q7.R
# @brief   HW3 Q7: Bonferroni and Benjamini-Hochberg multiple testing correction of
#          the gene-wise p-values from Q5
# @author  Cheolwon Park
# @date    2025-12-09


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


## 2. 유전자 변수 이름 추출 및 Q5와 동일한 t-test 결과 계산
gene_cols <- grep("^Gene_", names(Q5_data), value = TRUE)
length(gene_cols)        # 유전자 개수 확인용

gene_result <- data.frame(
  Gene         = gene_cols,
  p_value      = NA_real_,
  mean_Cancer  = NA_real_,
  mean_Healthy = NA_real_,
  stringsAsFactors = FALSE
)

alpha <- 0.01   # Q5에서 사용한 Significance level

idx_cancer  <- Q5_data$Disease == "Cancer"
idx_healthy <- Q5_data$Disease == "Healthy"

# 각 유전자에 대해 Welch의 two-sample t-test 수행 (Q5와 동일)
for (i in seq_along(gene_cols)) {
  gname <- gene_cols[i]
  
  x_cancer  <- Q5_data[idx_cancer,  gname]
  x_healthy <- Q5_data[idx_healthy, gname]
  
  t_res <- t.test(x_cancer, x_healthy,
                  alternative = "two.sided")
  
  gene_result$p_value[i]      <- t_res$p.value
  gene_result$mean_Cancer[i]  <- mean(x_cancer)
  gene_result$mean_Healthy[i] <- mean(x_healthy)
}

# 보정 전 유의한 유전자 개수 (Q5 결과 확인용)
n_sig_raw <- sum(gene_result$p_value < alpha)
cat("Q5 - Number of significant genes at 1% level (raw p):",
    n_sig_raw, "\n")


## 3. 다중 가설검정 보정 (Bonferroni, Benjamini-Hochberg)
m <- nrow(gene_result)  # 총 가설 수 (1274개)

gene_result$p_bonf <- p.adjust(gene_result$p_value, method = "bonferroni")
gene_result$p_bh   <- p.adjust(gene_result$p_value, method = "BH")


## 4. 보정 후 유의한 유전자 개수 비교
# Bonferroni 보정: family-wise error rate 제어
n_sig_bonf <- sum(gene_result$p_bonf < alpha)
cat("Q7 - Number of significant genes at 1% level (Bonferroni):",
    n_sig_bonf, "\n")

# Benjamini-Hochberg 보정: false discovery rate 제어
n_sig_bh <- sum(gene_result$p_bh < alpha)
cat("Q7 - Number of significant genes at 1% level (BH / FDR):",
    n_sig_bh, "\n")


## 5. 가장 유의한 유전자들 확인 (선택 사항)
# Bonferroni 기준 상위 유전자
head(gene_result[order(gene_result$p_bonf), ])

# BH(FDR) 기준 상위 유전자
head(gene_result[order(gene_result$p_bh), ])
