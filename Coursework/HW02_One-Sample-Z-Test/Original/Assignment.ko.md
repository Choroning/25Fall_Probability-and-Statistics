# HW2 과제 안내문 — 단일 표본 Z 검정

[레포지토리 안내](../../../README.ko.md) | [English](Assignment.md) | [한국어](Assignment.ko.md)

> **최종 수정일:** 2026-11-16

확률및통계 2차 과제이다. 수업에서 배운 통계적 가설검정을 R 프로그래밍으로 실제 의료 데이터에 적용하는 것이 목적이다. 데이터를 불러오는 방법도 검색이나 수업 교재(예: https://rafalab.github.io/dsbook/importing-data.html)를 참고해 익혀야 한다. 기말고사도 실습 시험이므로 데이터를 불러오는 방법을 반드시 공부해야 한다. 배포된 답안 양식은 [HW2.docx](HW2.docx)이다.

- **데이터:** Blackboard에서 내려받은 압축 파일을 풀면 데이터 파일 `Data.txt`가 있다. 이 레포지토리에서는 [`data/Data.txt`](../data/Data.txt)에 있다.
- **협업:** 친구와 상의할 수는 있지만 R 코드를 베끼는 것은 절대 금지한다. 베끼면 F 학점으로 가는 지름길이다.
- **제출 방법:** 아래 보고서의 빈칸을 채운 뒤, 이 보고서(.docx)와 작성한 R 코드 전체(.R 파일)를 압축해 제출한다. R 코드는 조교가 실행했을 때 실행되어야 하며, 압축 파일(.zip)의 이름은 `HW2_YourID_Yourname.zip`이어야 한다.

---

<br>

## 데이터 불러오기

`Data.txt`를 작업 디렉토리(`setwd(XXX)`)에 두고 다음과 같이 data.table 패키지의 `fread()` 함수를 쓰면 데이터를 불러올 수 있다.

```r
library(data.table)
data <- data.frame(fread("Data.txt", sep = "\t", head=T, stringsAsFactors = T))
dim(data)
```

```text
> dim(data)
[1] 8921   14
```

데이터에서는 다음 변수의 값을 볼 수 있으며, 모두 실제 임상에서 쓰는 값이다.

| 변수 | 설명 |
|:-----|:-----|
| Age | 방문 당시 나이 |
| Gender | 성별 (1 = 남성, 2 = 여성) |
| Race | 대상자의 인종 (1 = 백인, 2 = 흑인 또는 아프리카계 미국인) |
| Height | 키, cm |
| Weight | 몸무게, kg |
| sysBP | 수축기 혈압, mmHg |
| HR | 심박수 (bpm) |
| Resting_SaO2 | 안정 시 산소포화도, % |
| BMI | BMI |
| HaveCough | 평소 기침을 하는가 (헛기침은 제외), 1 = 예, 0 = 아니요 |
| FEV1 | FEV1 % pred, post-Utah |
| FVC | FVC % pred, post-Utah |
| FEV1_FVC | FEV1/FVC, post-Utah |
| Disease | 분류 레이블 |

*표 1. 데이터의 변수와 설명*

> **참고:** `data/Data.txt`의 실제 열 이름은 `Height` 대신 `Height_CM`, `Weight` 대신 `Weight_KG`이고, `FEV1_FVC` 열은 없으며, 맨 앞에 `ID` 열이 있다.

이 상태에서 아래 문제를 푼다. 각 문항의 결정(Decision Making)에서는 "Null hypothesis", "Reject", "Alternative hypothesis", "Select", "Significance level"(귀무가설, 기각, 대립가설, 채택, 유의수준)이라는 용어를 모두 써서 통계적 결론을 내려야 한다.

---

<br>

## Q1. 정상인의 수축기 혈압 분포와의 비교

미국 NIH에 따르면 정상인의 수축기 혈압은 sysBP ~ N(128.65, σ = 16.5)의 분포를 따른다. COVID19 환자가 불러온 데이터와 다르다는 증거를 찾기 위해, 유의수준 5%에서 다음 가설검정을 하라.

```math
H_0: \text{Collected samples are not biased}
```

```math
H_1: \text{The sample collected will be different from the population}
```

$H_0$은 수집한 표본이 치우치지 않았다는 가설이고, $H_1$은 수집한 표본이 모집단과 다를 것이라는 가설이다. 답안 양식의 칸은 다음과 같다.

- (1) Test statistics (검정통계량)
- (4) P-value (유의확률)
- (5) Decision Making at 5% significance level (유의수준 5%에서의 결정)

---

<br>

## Q2. COVID19 환자의 수축기 혈압

Q1과 같은 조건에서, COVID19 환자의 수축기 혈압이 알려진 국가 통계보다 높은지를 유의수준 5%에서 통계적으로 검정하라. COVID19 대상자를 추출할 때는 `subset()`이나 `which()` 함수를 쓸 수 있다.

- (1) Alternative Hypothesis (대립가설)
- (2) Null Hypothesis (귀무가설)
- (3) Test statistics (검정통계량)
- (4) P-value (유의확률)
- (5) Decision Making at 5% significance level (유의수준 5%에서의 결정)

---

<br>

## Q3. 남성 심박수의 세 방향 검정

미국 국립보건원(NIH)에 따르면 남성의 심박수는 HR_male ~ N(74.62, σ² = 11.1)의 분포를 따른다. 이를 바탕으로 서로 다른 세 방향의 대립가설을 세우고 각각 유의수준 5%에서 검정하라. 그리고 분석을 통해 최종 결과를 통계적으로 명확히 해석하라.

---

<br>

## Q4. 유의수준 10%에서의 같은 분석

Q3와 같은 분석을 유의수준 10%에서 하라. 그다음 Q3와 무엇이 다른지, 그로부터 무엇을 배울 수 있는지 서술하라.

---

<br>

## Q5. 안정 시 산소포화도

국민건강보험공단이 조사한 한국인 기본 건강검진에서 안정 시 산소포화도(resting SaO2)는 평균 96.0245, 분산 8.995로 알려져 있다. 이를 바탕으로, 현재 불러온 `Data.txt`가 안정 시 산소포화도의 관점에서 독립된 모집단인지 결론 내리는 가설검정을 하라. 유의수준은 받아들일 수 있는 수준에서 자유롭게 정하되, 통계적으로 깔끔하게 올바른 결론에 이르러야 한다.

---

<br>

문제를 풀어 본 뒤 [과제 해설](../Assignment-Explanation.ko.md)에서 정답과 풀이를, [코드 총정리](../Code-Walkthrough.ko.md)에서 작성한 코드 전체를 볼 수 있다.
