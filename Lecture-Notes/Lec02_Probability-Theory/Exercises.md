# Lecture 2 Exercises — Probability Theory

[Repository Guide](../../README.md) | [English](Exercises.md) | [한국어](Exercises.ko.md)

> **Last Updated:** 2026-11-04

Exercises 1-9 check the probability theory of [Lecture 2](Concepts_Lecture.md) through R programming. They are solved by listing every outcome of the sample space in a data frame and counting the outcomes in an event, or by simulating the experiment with random numbers. Exercises 4-6 use the same experiment and events, and Exercises 8 and 9 use the data of the same factory.

---

<br>

## Table of Contents

- [Exercise 1: Three Events for Two Dice](#exercise-1-three-events-for-two-dice)
- [Exercise 2: Simulating the Law of Large Numbers](#exercise-2-simulating-the-law-of-large-numbers)
- [Exercise 3: Four Coin Tosses](#exercise-3-four-coin-tosses)
- [Exercise 4: Three Events for Four Dice](#exercise-4-three-events-for-four-dice)
- [Exercise 5: Probabilities of Unions](#exercise-5-probabilities-of-unions)
- [Exercise 6: Conditional Probabilities](#exercise-6-conditional-probabilities)
- [Exercise 7: Five Dice and Independence](#exercise-7-five-dice-and-independence)
- [Exercise 8: Defect Rate of Production Lines](#exercise-8-defect-rate-of-production-lines)
- [Exercise 9: The Production Line of a Defective Product](#exercise-9-the-production-line-of-a-defective-product)

---

<br>

## Exercise 1: Three Events for Two Dice

**Problem:** Simulate in R a probability experiment of throwing two dice at the same time. The two dice are not distinguished, so an outcome is recorded as a pair $(i, j)$ with the smaller face first ($i \le j$). Find the elements of the following three events.

- Event $A$: The sum of the dice values is even.
- Event $B$: The sum of the dice values is 8 or more.
- Event $C$: The difference between the two dice is at most 1.

Then find the elements of $A \cap B$, $A \cap C$, $B \cap C$, $A \cap B \cap C$, $B^c$, and $A \cap B^c$.

**[Solution](Solutions.md#exercise-1-three-events-for-two-dice)**

---

<br>

## Exercise 2: Simulating the Law of Large Numbers

**Problem:** According to the law of large numbers, the proportion of heads gradually converges to 1/2 as more fair coins are thrown. Show this by simulation in R, and plot the proportion of heads against the number of tosses.

**[Solution](Solutions.md#exercise-2-simulating-the-law-of-large-numbers)**

---

<br>

## Exercise 3: Four Coin Tosses

**Problem:** List in R the sample space of the experiment of flipping a fair coin four times, and find the following probabilities in R.

1. The probability that heads appears two or more times
2. The probability that heads appears more than two times, that is, three or more times

**[Solution](Solutions.md#exercise-3-four-coin-tosses)**

---

<br>

## Exercise 4: Three Events for Four Dice

**Problem:** In the experiment of throwing four dice simultaneously, find the following events $A$, $B$, and $C$ in R, and count the outcomes in each event and in $A \cap B$, $A \cap C$, $B \cap C$, and $A \cap B \cap C$.

- Event $A$: The sum of the numbers is 15 or more.
- Event $B$: At least one die shows 6.
- Event $C$: At least one die shows 1.

**[Solution](Solutions.md#exercise-4-three-events-for-four-dice)**

---

<br>

## Exercise 5: Probabilities of Unions

**Problem:** With the events of Exercise 4, find the following probabilities in R and check them with the addition rule.

1. $P(A \cup B)$
2. $P(A \cup C)$
3. $P(B \cup C)$
4. $P(A \cup B \cup C)$

**[Solution](Solutions.md#exercise-5-probabilities-of-unions)**

---

<br>

## Exercise 6: Conditional Probabilities

**Problem:** With the events of Exercise 4, find the following conditional probabilities in R.

1. $P(A \mid B)$
2. $P(A \mid C)$
3. $P(A \mid B \cap C)$
4. $P(A \mid B \cup C)$

**[Solution](Solutions.md#exercise-6-conditional-probabilities)**

---

<br>

## Exercise 7: Five Dice and Independence

**Problem:** When five dice are rolled, decide in R whether the following two events are independent of each other.

- Event $A$: The sum of the dice values is even.
- Event $B$: Both a 1 and a 6 appear among the dice values.

The following helper functions may be used. `pprt2()` prints the probability of event `x`, and `cprt2()` prints the conditional probability of event `a` given event `b`, as a fraction and a decimal. The arguments `a`, `b`, and `x` of the two functions are data frames whose rows are the outcomes in the event, `an`, `bn`, and `xn` are the event names used in the printout, and `n` is the number of outcomes in the sample space. `cprt2()` uses a function `intersect2()` that returns the rows common to two data frames.

```r
cprt2 <- function(a, an, b, bn) {
  ab = intersect2(a, b)
  cat(paste0("P(", an, "|", bn, ") ="), nrow(ab), "/", nrow(b),
      "=", nrow(ab) / nrow(b))
}
pprt2 <- function(x, xn, n, prt = TRUE) {
  if (prt == TRUE) cat(paste0("P(", xn, ") ="), nrow(x), "/", n,
                       "=", nrow(x) / n, "\n")
  invisible(nrow(x) / n)
}
```

**[Solution](Solutions.md#exercise-7-five-dice-and-independence)**

---

<br>

## Exercise 8: Defect Rate of Production Lines

**Problem:** A semiconductor factory has production lines A, B, C, and D, with the production ratios and defective rates below. Find in R the probability $P(F)$ that one randomly sampled product is defective.

| Line | A | B | C | D |
|:-----|:-:|:-:|:-:|:-:|
| Production ratio | 20% | 40% | 30% | 10% |
| Defective rate | 0.04 | 0.02 | 0.01 | 0.05 |

*Table 1. Production ratio and defective rate of each production line*

**[Solution](Solutions.md#exercise-8-defect-rate-of-production-lines)**

---

<br>

## Exercise 9: The Production Line of a Defective Product

**Problem:** A product sampled at random from the factory of Exercise 8 turned out to be defective. Find in R the probability that it was produced on each of the lines A, B, C, and D, and draw a plot comparing the prior probabilities (production ratios) with the posterior probabilities.

**[Solution](Solutions.md#exercise-9-the-production-line-of-a-defective-product)**
