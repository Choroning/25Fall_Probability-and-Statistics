# @file    Q6.R
# @brief   HW3 Q6: gene-wise Pearson correlation tests between gene expression and
#          height at the 1% significance level
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


## 2. 유전자 변수 이름 추출
# Gene_1 ~ Gene_1274 컬럼 자동 추출
gene_cols <- grep("^Gene_", names(Q5_data), value = TRUE)
length(gene_cols)   # 유전자 개수 확인용

# 결과를 저장할 데이터프레임 생성
gene_height_result <- data.frame(
  Gene    = gene_cols,
  p_value = NA_real_,
  cor     = NA_real_,
  stringsAsFactors = FALSE
)


## 3. 유의수준 설정
# 유의수준(Significance level) = 1%
alpha <- 0.01


## 4. 각 유전자에 대해 Height와의 상관관계 검정
# 귀무가설(H0): 해당 유전자와 Height 사이의 상관계수는 0이다 (상관 없음).
# 대립가설(H1): 해당 유전자와 Height 사이의 상관계수는 0이 아니다 (상관 있음).
# Pearson 상관계수 기반 양측 검정 사용.

for (i in seq_along(gene_cols)) {
  gname <- gene_cols[i]
  
  x_gene   <- Q5_data[, gname]
  x_height <- Q5_data$Height
  
  # Pearson correlation test (양측)
  c_res <- cor.test(x_height, x_gene,
                    alternative = "two.sided",
                    method = "pearson")
  
  gene_height_result$p_value[i] <- c_res$p.value
  gene_height_result$cor[i]     <- c_res$estimate
}


## 5. 유의한 유전자 선별 및 개수 확인
# p-value < alpha 인 유전자를 Height와 관련된 유전자로 간주
sig_height_genes <- subset(gene_height_result, p_value < alpha)

n_sig_height <- nrow(sig_height_genes)
cat("Number of genes significantly associated with Height at 1% significance level:",
    n_sig_height, "\n")

# 필요하다면 p-value 기준으로 정렬하여 상위 일부 유전자 확인
head(sig_height_genes[order(sig_height_genes$p_value), ])
