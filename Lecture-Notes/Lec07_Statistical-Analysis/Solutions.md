# Lecture 7 Solutions — Statistical Analysis

[Repository Guide](../../README.md) | [English](Solutions.md) | [한국어](Solutions.ko.md)

> **Last Updated:** 2026-11-04

---

<br>

## Table of Contents

- [Exercise 1: Choosing an Analysis Method](#exercise-1-choosing-an-analysis-method)
- [Exercise 2: Tooth Growth by Supplement Type](#exercise-2-tooth-growth-by-supplement-type)
- [Exercise 3: A Permutation Test for the Low-Dose Group](#exercise-3-a-permutation-test-for-the-low-dose-group)
- [Exercise 4: One-Way ANOVA by Hand](#exercise-4-one-way-anova-by-hand)
- [Exercise 5: Chick Weight by Feed](#exercise-5-chick-weight-by-feed)
- [Exercise 6: Waiting Time and Eruption Time of a Geyser](#exercise-6-waiting-time-and-eruption-time-of-a-geyser)
- [Exercise 7: A Chi-Squared Test on Graduate Admissions Data](#exercise-7-a-chi-squared-test-on-graduate-admissions-data)
- [Exercise 8: Fisher's Exact Test for a Small Contingency Table](#exercise-8-fishers-exact-test-for-a-small-contingency-table)
- [References](#references)

---

<br>

## Exercise 1: Choosing an Analysis Method

**Problem:** Choose the analysis type and test suited to five research situations. The problem is in [Exercise 1](Exercises.md#exercise-1-choosing-an-analysis-method).

### Solution

**Answer:**

| Situation | Dependent ~ independent | Analysis type | Test (alternative when normality is doubtful) |
|:-----|:-----|:-----|:-----|
| (a) Tooth cell length and supplement | Continuous ~ binary (two independent groups) | I | Welch t-test (Wilcoxon rank-sum test) |
| (b) Chick weight and feed | Continuous ~ categorical (six groups) | II | One-way ANOVA with a post hoc test (Kruskal-Wallis test) |
| (c) Waiting time and eruption time | Continuous ~ continuous | III | Pearson correlation and simple linear regression (Spearman rank correlation) |
| (d) Sex and admission | Categorical ~ categorical | IV | Chi-squared test of independence (Fisher's exact test if the expected counts are small) |
| (e) Two sleeping drugs on the same patients | Continuous ~ two paired conditions | I | Paired t-test (Wilcoxon signed-rank test) |

*Table 1. Analysis types and tests for the five research situations*

**Explanation:** A method is chosen by the types of the dependent and independent variables and by the independence of the observations ([Lecture 7, Section 1.2](Concepts_Lecture.md#12-choosing-by-the-types-of-the-dependent-and-independent-variables)).

- Both (a) and (e) compare two conditions, but (a) divides different animals into two groups, so the samples are independent, while in (e) the same patients took both drugs, so the samples are paired. Using an independent two-sample test on paired samples mixes the variation between patients into the standard error and greatly lowers the power.
- (b) has three or more groups, so instead of repeating t-tests it tests once with ANOVA, and which feeds differ is then checked with a post hoc test such as Tukey's HSD.
- In (c) both variables are continuous, so a correlation coefficient gives the strength of the relationship and regression gives a prediction equation.
- The two variables in (d) are nominal, so a test of independence on the contingency table is used instead of a correlation coefficient. These data are analyzed in Exercise 7.

---

<br>

## Exercise 2: Tooth Growth by Supplement Type

**Problem:** Compare `len` in `ToothGrowth` between the supplement types (OJ, VC) with the Welch t-test and the Wilcoxon rank-sum test. The problem is in [Exercise 2](Exercises.md#exercise-2-tooth-growth-by-supplement-type).

### Solution

**Answer:** The mean is 20.66 for OJ and 16.96 for VC. The p-value of the Welch t-test is 0.0606 and that of the Wilcoxon rank-sum test is 0.0645, so neither test rejects the null hypothesis at the significance level 0.05.

**Explanation:** The model formula `len ~ supp` is analysis type I, a continuous dependent variable explained by a categorical variable with two levels ([Lecture 7, Section 2.4](Concepts_Lecture.md#24-model-formulas-in-r-and-the-four-analysis-types)).

```r
tapply(ToothGrowth$len, ToothGrowth$supp, mean)               # mean by supplement
tapply(ToothGrowth$len, ToothGrowth$supp, sd)                 # standard deviation by supplement
t.test(len ~ supp, data = ToothGrowth)                        # Welch t-test
wilcox.test(len ~ supp, data = ToothGrowth, exact = FALSE)    # Wilcoxon rank-sum test
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

- `tapply(x, g, f)` splits `x` by the levels of `g` and applies the function `f` to each part.
- The Welch t statistic is $t = (20.663 - 16.963)/\sqrt{6.606^2/30 + 8.266^2/30} = 3.700/1.932 \approx 1.915$. The degrees of freedom 55.309 are approximated from the two sample variances ([Lecture 7, Section 3.2](Concepts_Lecture.md#32-the-t-test-and-the-paired-t-test)). The 95% confidence interval for the difference in means, $(-0.17, 7.57)$, just contains 0.
- The `W = 575.5` of the Wilcoxon rank-sum test is the Mann-Whitney statistic, and it has a fractional part because ties received average ranks. With ties the exact p-value cannot be computed, so `exact = FALSE` requests the normal approximation ([Lecture 7, Section 3.3](Concepts_Lecture.md#33-the-wilcoxon-test)).
- The two tests give similar p-values and the same conclusion. With 30 animals in each group, the t-test does not depend much on the normality assumption.

> **Note:** In this design each supplement was given at three doses (0.5, 1, and 2 mg) to equal numbers of animals. Comparing only the supplements while ignoring dose mixes the large variation due to dose into the error and blurs the difference. Looking only at the 0.5 mg dose, as in Exercise 3, reveals a clear difference between the supplements; to analyze both factors together, the two-way ANOVA `aov(len ~ supp * factor(dose))` is used.

---

<br>

## Exercise 3: A Permutation Test for the Low-Dose Group

**Problem:** Carry out a permutation test on the difference in means between the two supplements in the 0.5 mg group. The problem is in [Exercise 3](Exercises.md#exercise-3-a-permutation-test-for-the-low-dose-group).

### Solution

**Answer:** The observed difference in means (VC minus OJ) is -5.25, and the two-sided permutation p-value is 0.0064. This is almost identical to the Welch t-test p-value of 0.0064, and both methods reject the null hypothesis.

**Explanation:** Under the null hypothesis the supplement labels are unrelated to `len`, so the differences in means computed after shuffling the labels at random form the null distribution ([Lecture 7, Section 3.4](Concepts_Lecture.md#34-the-permutation-test)).

```r
tg <- subset(ToothGrowth, dose == 0.5)                    # the 20 animals at 0.5 mg
obs <- diff(tapply(tg$len, tg$supp, mean))                # observed difference (VC minus OJ)
set.seed(7)                                               # random seed for reproducibility
perm <- replicate(10000, diff(tapply(tg$len, sample(tg$supp), mean)))
obs
mean(abs(perm) >= abs(obs))                               # two-sided permutation p-value
t.test(len ~ supp, data = tg)$p.value                     # p-value of the Welch t-test
```

```text
   VC 
-5.25 
[1] 0.0064
[1] 0.006358607
```

- `subset()` keeps only the rows that satisfy the condition. The means returned by `tapply()` are in level order (OJ, VC), so `diff()` subtracts the mean of OJ from the mean of VC. The mean of OJ is 13.23 and that of VC is 7.98.
- `sample(tg$supp)` shuffles the order of the 20 labels at random. `perm` collects, through `replicate()`, the 10,000 differences in means computed with shuffled labels.
- Only 64 of the 10,000 had an absolute value of at least 5.25, so the p-value is 0.0064. There are $\binom{20}{10} = 184756$ ways to split 20 animals into two groups of 10, and 10,000 random permutations approximate this whole distribution.
- The p-values of the permutation test and the Welch t-test are almost the same. Both look at the same difference in means, and for these data the t distribution approximation fits well. The permutation test confirms the same conclusion without a normality assumption.

---

<br>

## Exercise 4: One-Way ANOVA by Hand

**Problem:** Compute by hand the ANOVA table of three groups with 4 observations each. The problem is in [Exercise 4](Exercises.md#exercise-4-one-way-anova-by-hand).

### Solution

**Answer:** $SSB = 18.667$, $SSW = 6$, $MSB = 9.333$, $MSW = 0.667$, and $F = 14.0$. Since $14.0 > 4.256$, the null hypothesis that the three group means are equal is rejected at the significance level 0.05 (p-value 0.0017).

**Explanation:** ANOVA splits the total variation into variation between groups and variation within groups ([Lecture 7, Section 4.1](Concepts_Lecture.md#41-analysis-of-variance-anova)).

1. **Group means and overall mean:** $\bar{y}_A = 24/4 = 6$, $\bar{y}_B = 32/4 = 8$, $\bar{y}_C = 20/4 = 5$, and the overall mean is $\bar{y} = 76/12 = 6.333$.
2. **Between-group sum of squares:** $SSB = 4\{(6 - 6.333)^2 + (8 - 6.333)^2 + (5 - 6.333)^2\} = 4(0.111 + 2.778 + 1.778) = 4 \times 4.667 = 18.667$.
3. **Within-group sum of squares:** the deviations are $-1, 1, 0, 0$ in A, $0, 1, -1, 0$ in B, and $-1, 0, 1, 0$ in C, so each group's sum of squared deviations is 2 and $SSW = 2 + 2 + 2 = 6$.
4. **Mean squares:** the degrees of freedom are $k - 1 = 2$ between groups and $N - k = 12 - 3 = 9$ within groups, so $MSB = 18.667/2 = 9.333$ and $MSW = 6/9 = 0.667$.
5. **F statistic:** $F = 9.333/0.667 = 14.0$. Under the null hypothesis it follows $F_{2, 9}$, and since it exceeds the 95% quantile 4.256, the null hypothesis is rejected.

```r
g <- factor(rep(c("A", "B", "C"), each = 4))   # group labels A, A, A, A, B, ...
y <- c(5, 7, 6, 6, 8, 9, 7, 8, 4, 5, 6, 5)     # observations
summary(aov(y ~ g))                            # ANOVA table
qf(0.95, df1 = 2, df2 = 9)                     # 95% quantile of F(2, 9)
```

```text
            Df Sum Sq Mean Sq F value  Pr(>F)   
g            2  18.67   9.333      14 0.00173 **
Residuals    9   6.00   0.667                   
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
[1] 4.256495
```

`rep(c("A", "B", "C"), each = 4)` repeats each name 4 times, and `factor()` turns the result into a categorical variable. `qf(p, df1, df2)` is the quantile function of the F distribution. R's ANOVA table agrees with the hand calculation, and the p-value is 0.00173. The higher mean of group B (8) compared with the other two groups produced the large $SSB$.

---

<br>

## Exercise 5: Chick Weight by Feed

**Problem:** Test with ANOVA and the Kruskal-Wallis test whether the mean chick weight in `chickwts` differs by feed. The problem is in [Exercise 5](Exercises.md#exercise-5-chick-weight-by-feed).

### Solution

**Answer:** The ANOVA gives $F = 15.37$ (degrees of freedom 5 and 65) with a p-value of $5.94 \times 10^{-10}$. Neither the normality of the residuals (p = 0.627) nor equal variances (p = 0.660) is rejected, and the Kruskal-Wallis test (p = $5.1 \times 10^{-7}$) gives the same conclusion, so the mean weight is concluded to differ by feed.

**Explanation:**

```r
tapply(chickwts$weight, chickwts$feed, mean)               # mean weight by feed
fit <- aov(weight ~ feed, data = chickwts)                 # one-way ANOVA
summary(fit)
shapiro.test(residuals(fit))$p.value                       # normality of the residuals
bartlett.test(weight ~ feed, data = chickwts)$p.value      # equal variances
kruskal.test(weight ~ feed, data = chickwts)               # nonparametric alternative
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

- Among the feed means, sunflower (328.9 g) and casein (323.6 g) are the largest and horsebean (160.2 g) is the smallest.
- With 6 groups and 71 chicks, the degrees of freedom are $6 - 1 = 5$ and $71 - 6 = 65$. $MSB = 231129/5 = 46226$, $MSW = 195556/65 = 3009$, and $F = 46226/3009 \approx 15.37$. ANOVA applies as it is even though the group sizes (10-14 chicks) differ.
- The Shapiro-Wilk test tests the null hypothesis that the residuals are normally distributed, and Bartlett's test the null hypothesis that the six groups have equal variances. Both p-values exceed 0.05, so there is no reason to doubt the assumptions of ANOVA.
- The Kruskal-Wallis test is the nonparametric alternative that uses only ranks ([Lecture 7, Section 4.3](Concepts_Lecture.md#43-the-kruskal-wallis-test)); comparing $H = 37.34$ with the chi-squared distribution with 5 degrees of freedom gives a very small p-value, the same conclusion as ANOVA.

Which feeds differ is checked by comparing all 15 pairs with `TukeyHSD(fit)`. The pairs with the largest differences in means are sunflower and horsebean (168.7 g) and casein and horsebean (163.4 g).

---

<br>

## Exercise 6: Waiting Time and Eruption Time of a Geyser

**Problem:** Analyze the correlation and regression between the waiting time and the eruption duration in `faithful`. The problem is in [Exercise 6](Exercises.md#exercise-6-waiting-time-and-eruption-time-of-a-geyser).

### Solution

**Answer:** (a) Pearson correlation coefficient 0.901 (p < $2.2 \times 10^{-16}$), Spearman rank correlation coefficient 0.778. (b) $\widehat{\text{eruptions}} = -1.874 + 0.0756 \times \text{waiting}$, coefficient of determination 0.811. (c) About 4.18 minutes. (d) $b_1 \approx 0.0756$, $b_0 \approx -1.872$.

**Explanation:**

```r
cor.test(faithful$waiting, faithful$eruptions)                  # Pearson correlation and test
cor(faithful$waiting, faithful$eruptions, method = "spearman")  # Spearman rank correlation
fit <- lm(eruptions ~ waiting, data = faithful)                 # simple linear regression
coef(fit)                                                       # intercept and slope
summary(fit)$r.squared                                          # coefficient of determination
predict(fit, newdata = data.frame(waiting = 80))                # prediction for an 80-minute wait
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

- **(a)** With $r = 0.901$ there is a strong positive linear relationship: the longer the wait, the longer the eruption. The test statistic is $t = r\sqrt{n-2}/\sqrt{1-r^2} = 0.9008\sqrt{270}/\sqrt{1 - 0.8115} = 14.802/0.4342 \approx 34.09$ ([Lecture 7, Section 5.1](Concepts_Lecture.md#51-the-pearson-correlation-coefficient)). The Spearman rank correlation 0.778 is smaller than the Pearson coefficient because these data split into two clusters, short waits with short eruptions and long waits with long eruptions. The Pearson coefficient is inflated by the large distance between the clusters, while ranks shrink that distance and reflect more of the weaker relationship within each cluster ([Lecture 7, Section 5.2](Concepts_Lecture.md#52-the-spearman-rank-correlation-coefficient)).
- **(b)** The slope 0.0756 means that each additional minute of waiting goes with an average increase of 0.0756 minutes (about 4.5 seconds) in eruption duration. The coefficient of determination is $0.8115 = 0.9008^2$, so about 81% of the variation in eruption duration is explained by waiting time.
- **(c)** $-1.874 + 0.07563 \times 80 = -1.874 + 6.050 = 4.176$ minutes.
- **(d)** $b_1 = r\,s_y/s_x = 0.9008 \times 1.141/13.595 = 0.0756$ and $b_0 = \bar{y} - b_1\bar{x} = 3.488 - 0.0756 \times 70.897 = 3.488 - 5.360 = -1.872$ ([Lecture 7, Section 5.3](Concepts_Lecture.md#53-simple-linear-regression)). The difference from R's -1.874 comes from computing with rounded means and standard deviations.

---

<br>

## Exercise 7: A Chi-Squared Test on Graduate Admissions Data

**Problem:** Test independence in the admission by sex table of `UCBAdmissions`, and compare with the admission rates by department. The problem is in [Exercise 7](Exercises.md#exercise-7-a-chi-squared-test-on-graduate-admissions-data).

### Solution

**Answer:** (a) The admission rate is 44.5% for men and 30.4% for women, and $X^2 = 92.2$ (1 degree of freedom, p < $2.2 \times 10^{-16}$) rejects independence. (b) By department, women have a higher admission rate than men in four of the six departments. The association in the combined data arises because women applied more to departments with low admission rates, and ignoring the third variable, department, can lead to a wrong conclusion.

**Explanation:**

```r
adm <- margin.table(UCBAdmissions, c(1, 2))         # admission by sex, departments combined
adm
test <- chisq.test(adm, correct = FALSE)            # chi-squared test without continuity correction
test
round(test$expected, 1)                             # expected counts
round(test$residuals, 2)                            # Pearson residuals
round(apply(UCBAdmissions, c(2, 3), function(x) x["Admitted"] / sum(x)), 2)  # admission rate by sex and department
margin.table(UCBAdmissions, c(2, 3))                # applicants by sex and department
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

**(a)** Of the 2,691 male applicants 1,198 were admitted ($1198/2691 = 0.445$), and of the 1,835 female applicants 557 were admitted ($557/1835 = 0.304$). The expected count of the admitted-men cell is $1755 \times 2691/4526 = 1043.5$ ([Lecture 7, Section 6.1](Concepts_Lecture.md#61-contingency-tables-and-the-chi-squared-test-of-independence)). The Pearson residual is 4.78 for admitted men and -5.79 for admitted women, so compared with independence more men and fewer women were admitted ([Lecture 7, Section 6.2](Concepts_Lecture.md#62-pearson-residuals-and-the-association-plot)). `apply(X, c(2, 3), f)` applies the function `f` (admitted divided by applicants) to each combination of sex and department in the three-dimensional table.

**(b)** By department, women have the higher admission rate in A (women 0.82, men 0.62), B, D, and F, and a slightly lower rate only in C and E. However, 51% of male applicants (1,385) applied to A and B, which have high admission rates, while only 133 women (7%) applied to A and B and most applied to C-F, which have low admission rates. The association between sex and admission seen in the combined data therefore comes mainly from the difference in choice of department.

> **Caution:** The phenomenon in which an association in a table that combines several groups disappears or reverses in the tables for the individual groups is called **Simpson's paradox**. These data are its classic example [1]. When interpreting the association of two categorical variables, check whether a third variable related to both (here, department) exists, and if necessary stratify the analysis by that variable.

---

<br>

## Exercise 8: Fisher's Exact Test for a Small Contingency Table

**Problem:** Apply Fisher's exact test to the 2 × 2 table of gene variant and treatment response for 9 patients. The problem is in [Exercise 8](Exercises.md#exercise-8-fishers-exact-test-for-a-small-contingency-table).

### Solution

**Answer:** All expected counts are below 5, so the chi-squared approximation cannot be trusted. The two-sided p-value of Fisher's exact test is $6/126 \approx 0.0476$, so the null hypothesis that variant and response are independent is rejected at the significance level 0.05.

**Explanation:**

**(1) Expected counts.** The expected count under independence is (row total × column total)/9, so the variant row has $4 \times 5/9 = 2.22$ and $4 \times 4/9 = 1.78$, and the no-variant row has $5 \times 5/9 = 2.78$ and $5 \times 4/9 = 2.22$. All four cells are below 5, so the condition for the chi-squared approximation is not met ([Lecture 7, Section 6.1](Concepts_Lecture.md#61-contingency-tables-and-the-chi-squared-test-of-independence)).

**(2) Hypergeometric distribution.** With the row and column totals fixed, the number $X$ of responders among the 4 patients with the variant equals the number of responders when 4 people are drawn without replacement from 9 people, 5 responders and 4 non-responders ([Lecture 7, Section 6.3](Concepts_Lecture.md#63-fishers-exact-test)). Since $\binom{9}{4} = 126$, the distribution is as follows.

| $x$ | 0 | 1 | 2 | 3 | 4 |
|:-----|:-----:|:-----:|:-----:|:-----:|:-----:|
| $\binom{5}{x}\binom{4}{4-x}$ | 1 | 20 | 60 | 40 | 5 |
| $P(X = x)$ | 0.0079 | 0.1587 | 0.4762 | 0.3175 | 0.0397 |

*Table 2. Hypergeometric distribution of the number of responders among the patients with the variant*

**(3) Two-sided p-value.** Fisher's exact test (R's default method) sums all probabilities no larger than the probability of the observed table, $P(X = 4) = 5/126$. These are $x = 4$ (5/126) and $x = 0$ (1/126), so the p-value is $(5 + 1)/126 = 0.0476$.

```r
gene <- matrix(c(4, 1, 0, 4), nrow = 2,                        # filled column by column
               dimnames = list(Variant = c("Yes", "No"), Response = c("Yes", "No")))
gene
round(dhyper(0:4, m = 5, n = 4, k = 4), 4)                     # hypergeometric probabilities
fisher.test(gene)                                              # two-sided Fisher test
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

`dhyper(x, m, n, k)` is the probability of getting `x` successes when `k` items are drawn without replacement from `m` successes and `n` failures. R's p-value 0.04762 matches the hand calculation. No patient with the variant failed to respond, so the odds are infinite and the estimated odds ratio is `Inf`. The p-value is below 0.05 even though the confidence interval contains 1, because R computes the two-sided p-value and the confidence interval in different ways (a sum of small probabilities versus two one-sided tests). Such borderline results should be interpreted with care, stating that the sample is small.

---

<br>

## References

1. P. J. Bickel, E. A. Hammel, and J. W. O'Connell, "Sex bias in graduate admissions: Data from Berkeley," *Science*, vol. 187, no. 4175, pp. 398-404, 1975.
