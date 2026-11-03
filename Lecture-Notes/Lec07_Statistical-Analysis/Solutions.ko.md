# 7강 연습 문제 풀이 — 통계 분석

[레포지토리 안내](../../README.ko.md) | [English](Solutions.md) | [한국어](Solutions.ko.md)

> **최종 수정일:** 2026-11-04

---

<br>

## 목차

- [연습 문제 1: 분석 방법 고르기](#연습-문제-1-분석-방법-고르기)
- [연습 문제 2: 보충제 종류에 따른 치아 성장 비교](#연습-문제-2-보충제-종류에-따른-치아-성장-비교)
- [연습 문제 3: 저용량 집단의 순열 검정](#연습-문제-3-저용량-집단의-순열-검정)
- [연습 문제 4: 손으로 계산하는 일원배치 분산분석](#연습-문제-4-손으로-계산하는-일원배치-분산분석)
- [연습 문제 5: 사료에 따른 병아리 무게](#연습-문제-5-사료에-따른-병아리-무게)
- [연습 문제 6: 간헐천의 대기 시간과 분출 시간](#연습-문제-6-간헐천의-대기-시간과-분출-시간)
- [연습 문제 7: 대학원 입학 자료의 카이제곱 검정](#연습-문제-7-대학원-입학-자료의-카이제곱-검정)
- [연습 문제 8: 작은 분할표의 Fisher의 정확 검정](#연습-문제-8-작은-분할표의-fisher의-정확-검정)
- [참고 문헌](#참고-문헌)

---

<br>

## 연습 문제 1: 분석 방법 고르기

**문제:** 다섯 연구 상황에 알맞은 분석 유형과 검정을 고른다. 문제는 [연습 문제 1](Exercises.ko.md#연습-문제-1-분석-방법-고르기)에 있다.

### 풀이

**정답:**

| 상황 | 종속변수 ~ 독립변수 | 분석 유형 | 검정 (정규성이 의심될 때의 대안) |
|:-----|:-----|:-----|:-----|
| (a) 치아 세포 길이와 보충제 | 연속형 ~ 이진(독립인 두 집단) | I | Welch t 검정 (Wilcoxon 순위합 검정) |
| (b) 병아리 무게와 사료 | 연속형 ~ 범주형(여섯 집단) | II | 일원배치 분산분석과 사후 검정 (Kruskal-Wallis 검정) |
| (c) 대기 시간과 분출 시간 | 연속형 ~ 연속형 | III | Pearson 상관계수와 단순 선형 회귀 (Spearman 순위상관계수) |
| (d) 성별과 합격 여부 | 범주형 ~ 범주형 | IV | 카이제곱 독립성 검정 (기대도수가 작으면 Fisher의 정확 검정) |
| (e) 같은 환자의 두 수면제 | 연속형 ~ 짝지은 두 조건 | I | 대응표본 t 검정 (Wilcoxon 부호순위 검정) |

*표 1. 다섯 연구 상황에 알맞은 분석 유형과 검정*

**해설:** 방법은 종속변수와 독립변수의 유형, 관측의 독립성으로 고른다([7강 1.2절](Concepts_Lecture.ko.md#12-종속변수와-독립변수의-유형에-따른-선택)).

- (a)와 (e)는 모두 두 조건을 비교하지만, (a)는 서로 다른 동물을 두 집단에 나누었으므로 독립 표본이고 (e)는 같은 환자가 두 약을 모두 복용했으므로 대응 표본이다. 대응 표본에 독립 2표본 검정을 쓰면 환자 사이의 변동이 표준오차에 섞여 검정력이 크게 떨어진다.
- (b)는 집단이 셋 이상이므로 t 검정을 여러 번 반복하지 않고 분산분석으로 한 번에 검정한 뒤, 어느 사료가 다른지는 Tukey HSD 같은 사후 검정으로 확인한다.
- (c)는 두 변수가 모두 연속형이므로 상관계수로 관계의 강도를, 회귀로 예측식을 구한다.
- (d)의 두 변수는 명목 척도이므로 상관계수 대신 분할표의 독립성 검정을 쓴다. 이 자료는 연습 문제 7에서 분석한다.

---

<br>

## 연습 문제 2: 보충제 종류에 따른 치아 성장 비교

**문제:** `ToothGrowth`에서 보충제 종류(OJ, VC)에 따른 `len`의 차이를 Welch t 검정과 Wilcoxon 순위합 검정으로 비교한다. 문제는 [연습 문제 2](Exercises.ko.md#연습-문제-2-보충제-종류에-따른-치아-성장-비교)에 있다.

### 풀이

**정답:** OJ의 평균은 20.66, VC의 평균은 16.96이다. Welch t 검정의 유의확률은 0.0606, Wilcoxon 순위합 검정의 유의확률은 0.0645로, 두 검정 모두 유의수준 0.05에서 귀무가설을 기각하지 못한다.

**해설:** 모형 식 `len ~ supp`는 연속형 종속변수를 두 수준의 범주형 변수로 설명하는 분석 유형 I이다([7강 2.4절](Concepts_Lecture.ko.md#24-r의-모형-식과-네-가지-분석-유형)).

```r
tapply(ToothGrowth$len, ToothGrowth$supp, mean)               # 보충제별 평균
tapply(ToothGrowth$len, ToothGrowth$supp, sd)                 # 보충제별 표준편차
t.test(len ~ supp, data = ToothGrowth)                        # Welch t 검정
wilcox.test(len ~ supp, data = ToothGrowth, exact = FALSE)    # Wilcoxon 순위합 검정
```

```text
      OJ       VC 
20.66333 16.96333 
      OJ       VC 
6.605561 8.266029 

	Welch Two Sample t-test

data:  len by supp
t = 1.9153, df = 55.309, p-value = 0.06063
alternative hypothesis: true difference in means between group OJ and group VC is not equal to 0
95 percent confidence interval:
 -0.1710156  7.5710156
sample estimates:
mean in group OJ mean in group VC 
        20.66333         16.96333 


	Wilcoxon rank sum test with continuity correction

data:  len by supp
W = 575.5, p-value = 0.06449
alternative hypothesis: true location shift is not equal to 0
```

- `tapply(x, g, f)`는 `x`를 `g`의 수준별로 나누어 함수 `f`를 적용한다.
- Welch t 통계량은 $t = (20.663 - 16.963)/\sqrt{6.606^2/30 + 8.266^2/30} = 3.700/1.932 \approx 1.915$이다. 자유도 55.309는 두 표본분산으로 근사한 값이다([7강 3.2절](Concepts_Lecture.ko.md#32-t-검정과-대응표본-t-검정)). 평균 차이의 95% 신뢰구간 $(-0.17, 7.57)$이 0을 조금 포함한다.
- Wilcoxon 순위합 검정의 `W = 575.5`는 Mann-Whitney 통계량이며, 소수점이 붙은 것은 동점에 평균 순위를 주었기 때문이다. 동점이 있으면 정확한 유의확률을 계산할 수 없으므로 `exact = FALSE`로 정규 근사를 지정하였다([7강 3.3절](Concepts_Lecture.ko.md#33-wilcoxon-검정)).
- 두 검정의 유의확률이 비슷하고 결론도 같다. 각 집단이 30마리로 커서 t 검정이 정규성 가정에 크게 의존하지 않기 때문이다.

> **참고:** 이 자료는 보충제마다 세 용량(0.5, 1, 2 mg)을 같은 수로 배정한 설계이다. 용량을 무시하고 보충제만 비교하면 용량에 따른 큰 변동이 오차에 섞여 차이가 흐려진다. 연습 문제 3처럼 용량 0.5 mg만 보면 보충제 사이의 차이가 뚜렷하게 나타나며, 두 요인을 함께 분석하려면 이원배치 분산분석 `aov(len ~ supp * factor(dose))`를 쓴다.

---

<br>

## 연습 문제 3: 저용량 집단의 순열 검정

**문제:** 용량 0.5 mg 집단에서 두 보충제의 평균 차이로 순열 검정을 수행한다. 문제는 [연습 문제 3](Exercises.ko.md#연습-문제-3-저용량-집단의-순열-검정)에 있다.

### 풀이

**정답:** 관측된 평균 차이(VC 빼기 OJ)는 -5.25이고, 양측 순열 유의확률은 0.0064이다. Welch t 검정의 유의확률 0.0064와 거의 같으며, 두 방법 모두 귀무가설을 기각한다.

**해설:** 귀무가설 아래에서는 보충제 이름표가 `len`과 무관하므로, 이름표를 무작위로 섞어 만든 평균 차이들이 귀무분포를 이룬다([7강 3.4절](Concepts_Lecture.ko.md#34-순열-검정)).

```r
tg <- subset(ToothGrowth, dose == 0.5)                    # 용량 0.5 mg인 20마리
obs <- diff(tapply(tg$len, tg$supp, mean))                # 관측 평균 차이 (VC 빼기 OJ)
set.seed(7)                                               # 재현을 위한 난수 시드
perm <- replicate(10000, diff(tapply(tg$len, sample(tg$supp), mean)))
obs
mean(abs(perm) >= abs(obs))                               # 양측 순열 p-value
t.test(len ~ supp, data = tg)$p.value                     # Welch t 검정의 p-value
```

```text
   VC 
-5.25 
[1] 0.0064
[1] 0.006358607
```

- `subset()`은 조건을 만족하는 행만 남긴다. `tapply()`가 돌려주는 평균의 순서는 수준 순서(OJ, VC)이므로 `diff()`는 VC의 평균에서 OJ의 평균을 뺀다. OJ의 평균은 13.23, VC의 평균은 7.98이다.
- `sample(tg$supp)`는 이름표 20개의 순서를 무작위로 섞는다. 섞은 이름표로 계산한 평균 차이를 `replicate()`로 10,000번 모은 것이 `perm`이다.
- 10,000번 가운데 64번만 절댓값이 5.25 이상이어서 유의확률은 0.0064이다. 20마리를 10마리씩 나누는 방법은 $\binom{20}{10} = 184756$가지이며, 10,000번의 무작위 순열은 이 전체 분포를 근사한다.
- 순열 검정과 Welch t 검정의 유의확률이 거의 같다. 두 방법은 같은 평균 차이를 보고, 이 자료에서는 t 분포 근사가 잘 맞기 때문이다. 순열 검정은 정규성 가정 없이 같은 결론을 확인해 준다.

---

<br>

## 연습 문제 4: 손으로 계산하는 일원배치 분산분석

**문제:** 세 집단(각 4개 관측)의 분산분석표를 손으로 계산한다. 문제는 [연습 문제 4](Exercises.ko.md#연습-문제-4-손으로-계산하는-일원배치-분산분석)에 있다.

### 풀이

**정답:** $SSB = 18.667$, $SSW = 6$, $MSB = 9.333$, $MSW = 0.667$, $F = 14.0$이다. $14.0 > 4.256$이므로 유의수준 0.05에서 세 집단의 평균이 같다는 귀무가설을 기각한다(유의확률 0.0017).

**해설:** 분산분석은 전체 변동을 집단 사이의 변동과 집단 안의 변동으로 나눈다([7강 4.1절](Concepts_Lecture.ko.md#41-분산분석anova)).

1. **집단 평균과 전체 평균:** $\bar{y}_A = 24/4 = 6$, $\bar{y}_B = 32/4 = 8$, $\bar{y}_C = 20/4 = 5$이고, 전체 평균은 $\bar{y} = 76/12 = 6.333$이다.
2. **집단 사이 제곱합:** $SSB = 4\{(6 - 6.333)^2 + (8 - 6.333)^2 + (5 - 6.333)^2\} = 4(0.111 + 2.778 + 1.778) = 4 \times 4.667 = 18.667$이다.
3. **집단 안 제곱합:** A의 편차는 $-1, 1, 0, 0$, B는 $0, 1, -1, 0$, C는 $-1, 0, 1, 0$이므로 각 집단의 편차제곱합이 2이고 $SSW = 2 + 2 + 2 = 6$이다.
4. **평균제곱:** 자유도는 집단 사이 $k - 1 = 2$, 집단 안 $N - k = 12 - 3 = 9$이므로 $MSB = 18.667/2 = 9.333$, $MSW = 6/9 = 0.667$이다.
5. **F 통계량:** $F = 9.333/0.667 = 14.0$이다. 귀무가설 아래에서 $F_{2, 9}$를 따르며, 95% 분위수 4.256보다 크므로 기각한다.

```r
g <- factor(rep(c("A", "B", "C"), each = 4))   # 집단 이름표 A, A, A, A, B, ...
y <- c(5, 7, 6, 6, 8, 9, 7, 8, 4, 5, 6, 5)     # 관측값
summary(aov(y ~ g))                            # 분산분석표
qf(0.95, df1 = 2, df2 = 9)                     # F(2, 9)의 95% 분위수
```

```text
            Df Sum Sq Mean Sq F value  Pr(>F)   
g            2  18.67   9.333      14 0.00173 **
Residuals    9   6.00   0.667                   
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
[1] 4.256495
```

`rep(c("A", "B", "C"), each = 4)`는 각 이름을 4번씩 반복하고, `factor()`는 이를 범주형 변수로 만든다. `qf(p, df1, df2)`는 F 분포의 분위수 함수이다. R의 분산분석표가 손 계산과 일치하며 유의확률은 0.00173이다. 집단 B의 평균(8)이 다른 두 집단보다 높은 것이 큰 $SSB$를 만들었다.

---

<br>

## 연습 문제 5: 사료에 따른 병아리 무게

**문제:** `chickwts`에서 사료에 따라 병아리의 평균 무게가 다른지 분산분석과 Kruskal-Wallis 검정으로 검정한다. 문제는 [연습 문제 5](Exercises.ko.md#연습-문제-5-사료에-따른-병아리-무게)에 있다.

### 풀이

**정답:** 분산분석의 $F = 15.37$(자유도 5, 65), 유의확률은 $5.94 \times 10^{-10}$이다. 잔차의 정규성(p = 0.627)과 등분산(p = 0.660) 가정을 기각할 근거가 없고, Kruskal-Wallis 검정(p = $5.1 \times 10^{-7}$)도 같은 결론을 주므로 사료에 따라 평균 무게가 다르다고 결론짓는다.

**해설:**

```r
tapply(chickwts$weight, chickwts$feed, mean)               # 사료별 평균 무게
fit <- aov(weight ~ feed, data = chickwts)                 # 일원배치 분산분석
summary(fit)
shapiro.test(residuals(fit))$p.value                       # 잔차의 정규성
bartlett.test(weight ~ feed, data = chickwts)$p.value      # 등분산
kruskal.test(weight ~ feed, data = chickwts)               # 비모수 대안
```

```text
   casein horsebean   linseed  meatmeal   soybean sunflower 
 323.5833  160.2000  218.7500  276.9091  246.4286  328.9167 
            Df Sum Sq Mean Sq F value   Pr(>F)    
feed         5 231129   46226   15.37 5.94e-10 ***
Residuals   65 195556    3009                     
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
[1] 0.6272233
[1] 0.6600187

	Kruskal-Wallis rank sum test

data:  weight by feed
Kruskal-Wallis chi-squared = 37.343, df = 5, p-value = 5.113e-07
```

- 사료별 평균은 sunflower(328.9 g)와 casein(323.6 g)이 가장 크고 horsebean(160.2 g)이 가장 작다.
- 집단이 6개이고 병아리가 71마리이므로 자유도는 $6 - 1 = 5$와 $71 - 6 = 65$이다. $MSB = 231129/5 = 46226$, $MSW = 195556/65 = 3009$이고 $F = 46226/3009 \approx 15.37$이다. 집단의 크기(10\~14마리)가 달라도 분산분석은 그대로 적용된다.
- Shapiro-Wilk 검정은 잔차가 정규분포를 따른다는 귀무가설을, Bartlett 검정은 여섯 집단의 분산이 같다는 귀무가설을 검정한다. 두 유의확률이 모두 0.05보다 크므로 분산분석의 가정을 의심할 근거가 없다.
- Kruskal-Wallis 검정은 순위만 쓰는 비모수 대안이며([7강 4.3절](Concepts_Lecture.ko.md#43-kruskal-wallis-검정)), $H = 37.34$를 자유도 5인 카이제곱 분포에 견준 유의확률이 매우 작아 분산분석과 같은 결론을 준다.

어느 사료끼리 다른지는 `TukeyHSD(fit)`로 15개 쌍을 모두 비교하여 확인한다. 평균의 차이가 가장 큰 쌍은 sunflower와 horsebean(168.7 g), casein과 horsebean(163.4 g)이다.

---

<br>

## 연습 문제 6: 간헐천의 대기 시간과 분출 시간

**문제:** `faithful`에서 대기 시간과 분출 지속 시간의 상관과 회귀를 분석한다. 문제는 [연습 문제 6](Exercises.ko.md#연습-문제-6-간헐천의-대기-시간과-분출-시간)에 있다.

### 풀이

**정답:** (a) Pearson 상관계수 0.901(p < $2.2 \times 10^{-16}$), Spearman 순위상관계수 0.778. (b) $\widehat{\text{eruptions}} = -1.874 + 0.0756 \times \text{waiting}$, 결정계수 0.811. (c) 약 4.18분. (d) $b_1 \approx 0.0756$, $b_0 \approx -1.872$.

**해설:**

```r
cor.test(faithful$waiting, faithful$eruptions)                  # Pearson 상관과 검정
cor(faithful$waiting, faithful$eruptions, method = "spearman")  # Spearman 순위상관
fit <- lm(eruptions ~ waiting, data = faithful)                 # 단순 선형 회귀
coef(fit)                                                       # 절편과 기울기
summary(fit)$r.squared                                          # 결정계수
predict(fit, newdata = data.frame(waiting = 80))                # 대기 80분의 예측
```

```text
	Pearson's product-moment correlation

data:  faithful$waiting and faithful$eruptions
t = 34.089, df = 270, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.8756964 0.9210652
sample estimates:
      cor 
0.9008112 

[1] 0.7779721
(Intercept)     waiting 
-1.87401599  0.07562795 
[1] 0.8114608
      1 
4.17622 
```

- **(a)** $r = 0.901$이므로 대기 시간이 길수록 분출이 오래 지속되는 강한 양의 선형 관계가 있다. 검정통계량은 $t = r\sqrt{n-2}/\sqrt{1-r^2} = 0.9008\sqrt{270}/\sqrt{1 - 0.8115} = 14.802/0.4342 \approx 34.09$이다([7강 5.1절](Concepts_Lecture.ko.md#51-pearson-상관계수)). Spearman 순위상관계수 0.778이 Pearson보다 작은 것은 이 자료가 짧은 대기와 짧은 분출, 긴 대기와 긴 분출의 두 무리로 나뉘기 때문이다. Pearson 상관계수는 두 무리 사이의 큰 거리 덕분에 커지지만, 순위는 그 거리를 줄이고 각 무리 안의 약한 관계를 더 반영한다([7강 5.2절](Concepts_Lecture.ko.md#52-spearman-순위상관계수)).
- **(b)** 기울기 0.0756은 대기 시간이 1분 늘 때 분출 지속 시간이 평균 0.0756분(약 4.5초) 늘어난다는 뜻이다. 결정계수 $0.8115 = 0.9008^2$이므로 분출 시간 변동의 약 81%가 대기 시간으로 설명된다.
- **(c)** $-1.874 + 0.07563 \times 80 = -1.874 + 6.050 = 4.176$분이다.
- **(d)** $b_1 = r\,s_y/s_x = 0.9008 \times 1.141/13.595 = 0.0756$, $b_0 = \bar{y} - b_1\bar{x} = 3.488 - 0.0756 \times 70.897 = 3.488 - 5.360 = -1.872$이다([7강 5.3절](Concepts_Lecture.ko.md#53-단순-선형-회귀)). R의 -1.874와의 차이는 평균과 표준편차를 반올림한 값으로 계산했기 때문이다.

---

<br>

## 연습 문제 7: 대학원 입학 자료의 카이제곱 검정

**문제:** `UCBAdmissions`의 합격 여부 × 성별 분할표로 독립성을 검정하고, 학과별 합격률과 비교한다. 문제는 [연습 문제 7](Exercises.ko.md#연습-문제-7-대학원-입학-자료의-카이제곱-검정)에 있다.

### 풀이

**정답:** (a) 합격률은 남성 44.5%, 여성 30.4%이고 $X^2 = 92.2$(자유도 1, p < $2.2 \times 10^{-16}$)로 독립성을 기각한다. (b) 학과별로는 여섯 학과 가운데 네 학과에서 여성의 합격률이 남성보다 높다. 전체 자료의 연관성은 여성이 합격률이 낮은 학과에 더 많이 지원한 데에서 생긴 것이며, 학과라는 제3의 변수를 고려하지 않으면 잘못된 결론을 내릴 수 있다.

**해설:**

```r
adm <- margin.table(UCBAdmissions, c(1, 2))         # 학과를 합친 합격 여부 × 성별
adm
test <- chisq.test(adm, correct = FALSE)            # 연속성 수정 없는 카이제곱 검정
test
round(test$expected, 1)                             # 기대도수
round(test$residuals, 2)                            # Pearson 잔차
round(apply(UCBAdmissions, c(2, 3), function(x) x["Admitted"] / sum(x)), 2)  # 학과별, 성별 합격률
margin.table(UCBAdmissions, c(2, 3))                # 학과별, 성별 지원자 수
```

```text
          Gender
Admit      Male Female
  Admitted 1198    557
  Rejected 1493   1278

	Pearson's Chi-squared test

data:  adm
X-squared = 92.205, df = 1, p-value < 2.2e-16

          Gender
Admit        Male Female
  Admitted 1043.5  711.5
  Rejected 1647.5 1123.5
          Gender
Admit       Male Female
  Admitted  4.78  -5.79
  Rejected -3.81   4.61
        Dept
Gender      A    B    C    D    E    F
  Male   0.62 0.63 0.37 0.33 0.28 0.06
  Female 0.82 0.68 0.34 0.35 0.24 0.07
        Dept
Gender     A   B   C   D   E   F
  Male   825 560 325 417 191 373
  Female 108  25 593 375 393 341
```

**(a)** 남성 지원자 2,691명 가운데 1,198명($1198/2691 = 0.445$), 여성 지원자 1,835명 가운데 557명($557/1835 = 0.304$)이 합격하였다. 남성 합격 칸의 기대도수는 $1755 \times 2691/4526 = 1043.5$이다([7강 6.1절](Concepts_Lecture.ko.md#61-분할표와-카이제곱-독립성-검정)). Pearson 잔차는 남성 합격 칸이 4.78, 여성 합격 칸이 -5.79로, 독립일 때보다 남성은 더 많이, 여성은 더 적게 합격하였다([7강 6.2절](Concepts_Lecture.ko.md#62-pearson-잔차와-연관성-그림)). `apply(X, c(2, 3), f)`는 3차원 표의 성별과 학과의 조합마다 함수 `f`(합격자 수를 지원자 수로 나눔)를 적용한다.

**(b)** 학과별로 보면 A(여성 0.82, 남성 0.62), B, D, F에서는 여성의 합격률이 더 높고, C와 E에서만 조금 낮다. 그런데 남성 지원자의 51%(1,385명)는 합격률이 높은 A와 B에 지원한 반면, 여성은 133명(7%)만 A와 B에 지원하고 대부분 합격률이 낮은 C\~F에 지원하였다. 따라서 전체 자료에서 보인 성별과 합격의 연관성은 주로 학과 선택의 차이에서 나온다.

> **주의:** 여러 집단을 합친 분할표의 연관성이 집단별 분할표에서는 사라지거나 반대로 나타나는 현상을 **Simpson의 역설(Simpson's paradox)** 이라 한다. 이 자료는 그 대표적인 예이다 [1]. 두 범주형 변수의 연관성을 해석할 때는 두 변수 모두와 관련된 제3의 변수(여기서는 학과)가 있는지 살피고, 필요하면 그 변수로 층을 나누어 분석한다.

---

<br>

## 연습 문제 8: 작은 분할표의 Fisher의 정확 검정

**문제:** 환자 9명의 유전자 변이와 치료 반응의 2 × 2 분할표에 Fisher의 정확 검정을 적용한다. 문제는 [연습 문제 8](Exercises.ko.md#연습-문제-8-작은-분할표의-fisher의-정확-검정)에 있다.

### 풀이

**정답:** 기대도수가 모두 5보다 작아 카이제곱 근사를 믿기 어렵다. Fisher의 정확 검정의 양측 유의확률은 $6/126 \approx 0.0476$으로, 유의수준 0.05에서 변이와 반응이 독립이라는 귀무가설을 기각한다.

**해설:**

**(1) 기대도수.** 독립일 때의 기대도수는 (행 합계 × 열 합계)/9이므로 변이 있음 행이 $4 \times 5/9 = 2.22$, $4 \times 4/9 = 1.78$, 변이 없음 행이 $5 \times 5/9 = 2.78$, $5 \times 4/9 = 2.22$이다. 네 칸 모두 5보다 작아 카이제곱 분포 근사의 조건을 만족하지 못한다([7강 6.1절](Concepts_Lecture.ko.md#61-분할표와-카이제곱-독립성-검정)).

**(2) 초기하분포.** 행과 열의 합계를 고정하면, 변이가 있는 4명 가운데 반응한 사람 수 $X$는 반응자 5명과 무반응자 4명, 모두 9명에서 4명을 비복원으로 뽑을 때의 반응자 수와 같다([7강 6.3절](Concepts_Lecture.ko.md#63-fisher의-정확-검정)). $\binom{9}{4} = 126$이므로 다음과 같다.

| $x$ | 0 | 1 | 2 | 3 | 4 |
|:-----|:-----:|:-----:|:-----:|:-----:|:-----:|
| $\binom{5}{x}\binom{4}{4-x}$ | 1 | 20 | 60 | 40 | 5 |
| $P(X = x)$ | 0.0079 | 0.1587 | 0.4762 | 0.3175 | 0.0397 |

*표 2. 변이가 있는 환자 가운데 반응자 수의 초기하분포*

**(3) 양측 유의확률.** Fisher의 정확 검정(R의 기본 방식)은 관측된 표의 확률 $P(X = 4) = 5/126$ 이하인 확률을 모두 더한다. $x = 4$(5/126)와 $x = 0$(1/126)이 해당하므로 유의확률은 $(5 + 1)/126 = 0.0476$이다.

```r
gene <- matrix(c(4, 1, 0, 4), nrow = 2,                        # 열 방향으로 채운다
               dimnames = list(Variant = c("Yes", "No"), Response = c("Yes", "No")))
gene
round(dhyper(0:4, m = 5, n = 4, k = 4), 4)                     # 초기하분포 확률
fisher.test(gene)                                              # 양측 Fisher 검정
```

```text
       Response
Variant Yes No
    Yes   4  0
    No    1  4
[1] 0.0079 0.1587 0.4762 0.3175 0.0397

	Fisher's Exact Test for Count Data

data:  gene
p-value = 0.04762
alternative hypothesis: true odds ratio is not equal to 1
95 percent confidence interval:
 0.7794899       Inf
sample estimates:
odds ratio 
       Inf 
```

`dhyper(x, m, n, k)`는 성공 `m`개와 실패 `n`개에서 `k`개를 비복원으로 뽑을 때 성공이 `x`개일 확률이다. R의 유의확률 0.04762가 손 계산과 같다. 변이가 있는 환자 중 무반응자가 0명이어서 오즈가 무한대이므로 오즈비의 추정값이 `Inf`이다. 신뢰구간이 1을 포함하는데도 유의확률이 0.05보다 작은 것은, R이 양측 유의확률과 신뢰구간을 서로 다른 방식(작은 확률의 합과 두 단측 검정)으로 계산하기 때문이다. 이렇게 경계에 가까운 결과는 표본이 작다는 점을 함께 밝혀 신중하게 해석한다.

---

<br>

## 참고 문헌

1. P. J. Bickel, E. A. Hammel, and J. W. O'Connell, "Sex bias in graduate admissions: Data from Berkeley," *Science*, vol. 187, no. 4175, pp. 398-404, 1975.
