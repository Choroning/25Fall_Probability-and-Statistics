# HW1 Assignment Handout — Probability and Random Variables

[Repository Guide](../../../README.md) | [English](Assignment.md) | [한국어](Assignment.ko.md)

> **Last Updated:** 2026-11-16

This is the first assignment of Probability and Statistics. It consists of 14 problems on probability, random variables, discrete probability distributions, and joint distributions, solved by hand without R code and written in the answer box of each problem in the distributed answer form [HW1.docx](HW1.docx). The points differ by problem and total 100.

- **Answers:** Read the questions carefully and answer neatly in Korean or English. An answer that the grader cannot recognize immediately is counted as incorrect.
- **Calculation errors:** Simple calculation errors in answers that clearly show the whole process are not penalized.
- **Fractions:** A final result in fractional form does not need to be reduced.

---

<br>

## Q1. Unknown Constants in a Probability Table

The probability distribution of the discrete random variable $X$ is as follows. If $E(X^2) = a + 5$, find the value of $b - a$, where $a$ and $b$ are constants. (5 points)

| $X$ | 1 | 2 | 3 |
|:-----:|:-----:|:-----:|:-----:|
| $P(X = x)$ | $a$ | $a + b$ | $b$ |

*Table 1. Probability distribution of the discrete random variable X*

---

<br>

## Q2. The Sexes of Two Children

A family has 2 children. Given that one of the children is a boy, find the probability that the other child is also a boy. (5 points)

Hint: use the concept of conditional probability.

---

<br>

## Q3. The Number of Phone Calls in a Day

A household receives an average of four phone calls per day. Answer the following subquestions to find the probability that this household will receive exactly 2 phone calls tomorrow. (10 points, 2 points each)

1. (Q3-1) The notation of the random variable in this problem
2. (Q3-2) The probability mass function (P.D.F., that is, P.M.F.) of the given situation
3. (Q3-3) $E(X)$
4. (Q3-4) $\mathrm{Var}(X)$
5. (Q3-5) $P(X = 2)$

Operations that are hard to compute by hand, such as square roots or combinations, need not be completed. In that case, show the exact process up to the form just before the final computation.

---

<br>

## Q4. A Random Variable Defined by the Number of Heads

Let the random variable $X$ be the number of coins that come up heads when four coins are tossed simultaneously, and define the discrete random variable $Y$ as follows. Find the value of $E(Y)$. (5 points)

```math
Y = \begin{cases} X & (X = 0, 1) \\ 2 & (X \ge 2) \end{cases}
```

---

<br>

## Q5. Cans Taken out of a Refrigerator

There are 9 cans of cola in the refrigerator: 3 are Pepsi and 6 are Coca-Cola. In this situation, answer the following subquestions to find the probability that there are 3 Coca-Cola cans when Seo takes out 4 cans. (10 points, 2 points each)

1. (Q5-1) The notation of the random variable in this problem
2. (Q5-2) The probability mass function (P.D.F., that is, P.M.F.) of the given situation
3. (Q5-3) $E(X)$
4. (Q5-4) $\mathrm{Var}(X)$
5. (Q5-5) $P(X = 3)$

Operations that are hard to compute by hand, such as square roots or combinations, need not be completed. In that case, show the exact process up to the form just before the final computation.

---

<br>

## Q6. The Largest Number on the Drawn Balls

A bag contains five balls labeled 1, 2, 3, 4, and 5, one number each. Three balls are taken out of the bag at random at the same time. Let the random variable $X$ be the largest number on the three balls taken out. Complete the probability distribution table of $X$, and then find the values of $E(4X + 3)$ and $\mathrm{Var}(2X + 2)$. (10 points, 3 points each)

1. (Q6-1) Probability distribution
2. (Q6-2) $E(4X + 3)$
3. (Q6-3) $\mathrm{Var}(2X + 2)$

---

<br>

## Q7. The Number of Games Won

Seo plays LOL and on average wins 3 out of 5 games. Answer the following subquestions to find the probability that Seo will win 70 times out of 100 rounds of the game. (10 points, 2 points each)

1. (Q7-1) The notation of the random variable in this problem
2. (Q7-2) The probability mass function (P.D.F., that is, P.M.F.) of the given situation
3. (Q7-3) $E(X)$
4. (Q7-4) $\mathrm{Var}(X)$
5. (Q7-5) $P(X \ge 70)$

Operations that are hard to compute by hand, such as square roots or combinations, need not be completed. In that case, show the exact process up to the form just before the final computation.

---

<br>

## Q8. Two Independent Events

The two events $A$ and $B$ are independent of each other. When the probability of event $A$ is 0.3 and the probability of event $B$ is 0.4, find $P(A \cap B)$. (5 points)

---

<br>

## Q9. A Binomial Distribution with a Given Variance

$X \sim B(n, \frac{1}{3})$ and $\mathrm{Var}(2X) = 40$. Find the value of $n$. (5 points)

---

<br>

## Q10. Bayes' Theorem in One Sentence

Bayes' theorem can be defined simply in one sentence, "inferred [ ] based on [ ]." The Korean sentence is "[ ]에 기초하여 [ ]를 추론한다." Write the suitable term for each blank. The answer form has two boxes, Answer1 and Answer2. (5 points)

---

<br>

## Q11. A Statement about the Expectation of a Square

Prove simply whether the following statement is true or false. The derivation must be clear. (10 points)

```math
E[X^2] = \mathrm{Sd}(X)^2 + \mu^2
```

---

<br>

## Common Data for Q12 and Q13

The joint P.M.F. $p_{X,Y}(x, y)$ of the two random variables $X$ and $Y$ is as follows.

| | $y = 6$ | $y = 8$ | $y = 10$ | $p_X(x)$ |
|:-----:|:-----:|:-----:|:-----:|:-----:|
| $x = 1$ | $\frac{1}{5}$ | 0 | $\frac{1}{5}$ | $\frac{2}{5}$ |
| $x = 2$ | 0 | $\frac{1}{5}$ | 0 | $\frac{1}{5}$ |
| $x = 3$ | $\frac{1}{5}$ | 0 | $\frac{1}{5}$ | $\frac{2}{5}$ |
| $p_Y(y)$ | $\frac{2}{5}$ | $\frac{1}{5}$ | $\frac{2}{5}$ | 1 |

*Table 2. Joint probability mass function of X and Y*

## Q12. The Joint Cumulative Distribution Function

Under this condition, complete the joint C.M.F. $F_{X,Y}(x, y) \equiv P(X \le x, Y \le y)$ of the random variables $X$ and $Y$. (5 points)

## Q13. The Product of Expectations and Independence

Calculate $E[X]$, $E[Y]$, and $E[XY]$, and then check whether $E[XY] = E[X]E[Y]$ holds. Finally, decide whether $X$ and $Y$ are independent of each other. (5 points)

---

<br>

## Q14. A Mind Map of the Material before the Midterm

Organize what you learned before the midterm, to the extent you remember, as a mind map within one page. Examples were shown several times in class. Points from 0 to 10 are allocated according to how well it is organized.

---

<br>

After solving the problems, see the [assignment explanation](../Assignment-Explanation.md) for the answers and solutions.
