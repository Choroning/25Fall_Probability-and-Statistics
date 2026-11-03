# @file    Lab_R-Basics.R
# @brief   R basics from the first R practice class: vectors, the iris data set,
#          rep() and seq(), random numbers with rnorm(), data frames, factors,
#          and a ggplot2 box plot
# @author  Cheolwon Park
# @date    2025-09-08

# cmd + Shift + n 으로 새 파일
# cmd + Shift + c 로 주석 처리
# cmd + option + b 로 실행

############################################
# Set Repos
setRepositories(ind = 1:7)

# install.packages("data.table")
# install.packages("ggplot2")

library(data.table)
library(ggplot2)

# getwd()

############################################

numericVector <- c(1, 2, 3, 4, 5)
numericVector

characterVector <- c("One", "Two", "Three")
characterVector

logicalVector <- c("TRUE", "TRUE", "FALSE")
logicalVector

############################################

# iris
head(iris)
tail(iris)
dim(iris) # 행, 열 개수 출력
nrow(iris) # 행 개수 출력
ncol(iris) # 열 개수 출력
# View(iris)

str(iris)
summary(iris)

# rm(characterVector)

############################################

class(numericVector)
class(characterVector)
class(logicalVector)

rep(1, 3)
rep(2, 3)
rep(3, 3)

A <- c(rep(1, 3), rep(2, 3), rep(3, 3))
rep(1:3, 10)
rep(c("a", "b"), 10)

############################################

seq(from = 1, to = 10)
1:10
seq(from = 1, to = 10, by = 3)
seq(from = 1, by = 2, length = 10)

# ?seq() 로 궁금한 함수 도움말 보기 가능

############################################

tmp <- rnorm(n = 100, mean = 180, sd = 1) # 난수 생성
plot(tmp)

############################################

tmp.1 <- rnorm(n = 100, mean = 180, sd = 1)
tmp.2 <- rnorm(n = 100, mean = 150, sd = 1)

height <- c(tmp.1, tmp.2)
gender <- c(rep("male", 100), rep("female", 100))

length(height)
length(gender)

plot.df <- data.frame("height" = height,
                      "gender" = gender)

tmp.matrix <- matrix(0, nrow = 100, ncol = 5)

level.idx <- unique(plot.df$gender)
plot.df$gender <- factor(plot.df$gender, levels = level.idx)



head(plot.df)

ggplot(plot.df, aes(x = gender, y = height, color = gender, fill = gender)) +
  geom_boxplot()

############################################







