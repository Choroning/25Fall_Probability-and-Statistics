# Lecture 1 Solutions — Introduction to R Programming

[Repository Guide](../../README.md) | [English](Solutions.md) | [한국어](Solutions.ko.md)

> **Last Updated:** 2026-11-04

---

<br>

## Table of Contents

- [Exercise 1: Binding Vectors and Checking Their Size](#exercise-1-binding-vectors-and-checking-their-size)
- [Exercise 2: Creating Gender and Height Data](#exercise-2-creating-gender-and-height-data)

---

<br>

## Exercise 1: Binding Vectors and Checking Their Size

**Problem:** Create a vector `A` with the values 1 to 5 and its copy `B`, check their lengths, bind them column-wise and row-wise, and check the numbers of rows and columns of `C`, the column-wise result. The step-by-step instructions are in [Exercise 1](Exercises.md#exercise-1-binding-vectors-and-checking-their-size).

### Solution

**Approach:** A vector is created with `c()` ([Lecture 1, Section 6.1](Concepts_Lecture.md#61-vectors-and-assignment)) and copied with the assignment operator `<-`. `cbind()` (column bind) stands the vectors up as columns side by side, and `rbind()` (row bind) lays them down as rows stacked on top of each other. Both functions return a matrix, so its size is checked with `nrow()`, `ncol()`, and `dim()` ([Lecture 1, Section 7.5](Concepts_Lecture.md#75-creating-matrices)).

**Code:**

```r
A <- c(1, 2, 3, 4, 5)   # step 1 (1:5 also works)
A
B <- A                  # step 2: copy A into B
B
length(A)               # step 3
length(B)
cbind(A, B)             # step 4: column-wise
rbind(A, B)             #         row-wise
C <- cbind(A, B)        # step 5
nrow(C)                 # step 6
ncol(C)
dim(C)
class(C)
```

**Output:**

```text
[1] 1 2 3 4 5
[1] 1 2 3 4 5
[1] 5
[1] 5
     A B
[1,] 1 1
[2,] 2 2
[3,] 3 3
[4,] 4 4
[5,] 5 5
  [,1] [,2] [,3] [,4] [,5]
A    1    2    3    4    5
B    1    2    3    4    5
[1] 5
[1] 2
[1] 5 2
[1] "matrix" "array" 
```

- **Steps 1 and 2:** `A <- c(1, 2, 3, 4, 5)` creates a numeric vector of 5 elements. Writing `1:5` gives the same values (with integer type). `B <- A` copies the values of `A` into `B`.
- **Step 3:** Both vectors have 5 elements, so both lengths are 5.
- **Step 4:** `cbind(A, B)` stands `A` and `B` up as one column each, making a 5-by-2 matrix whose column names are the variable names (`A`, `B`). `rbind(A, B)` stacks the two vectors as one row each, making a 2-by-5 matrix whose row names are the variable names. The two results are transposes (`t()`) of each other.
- **Steps 5 and 6:** `C` is the result of `cbind(A, B)`, so it has 5 rows and 2 columns, and `dim(C)` returns both at once as `5 2`. As `class(C)` shows, `C` is a matrix, not a data frame.

> **Note:** In R, modifying `B` after copying it with `B <- A` does not change `A`. R actually allocates separate memory at the moment the copy is modified (copy-on-modify). In the following code, `A` stays the same even after `B[1] <- 100` runs.
>
> ```r
> B[1] <- 100
> A
> B
> ```
>
> ```text
> [1] 1 2 3 4 5
> [1] 100   2   3   4   5
> ```

---

<br>

## Exercise 2: Creating Gender and Height Data

**Problem:** Create a table of 20 rows and 2 columns consisting of gender, with Male for the first 10 and Female for the remaining 10, and height generated from $N(173, 2^2)$ for men and $N(162.3, 2^2)$ for women, and explain which structure, a matrix or a data frame, is appropriate. The conditions are in [Exercise 2](Exercises.md#exercise-2-creating-gender-and-height-data). Here $N(\mu, \sigma^2)$ denotes the normal distribution with mean $\mu$ and variance $\sigma^2$.

### Solution

**Approach:** Generate 10 heights for each group with `rnorm()` ([Lecture 1, Section 7.3](Concepts_Lecture.md#73-normal-random-numbers-rnorm)), and create the genders by repeating each value 10 times with `rep()` ([Lecture 1, Section 7.1](Concepts_Lecture.md#71-removing-objects-and-repetition-rep)). Gender is text and height is a number, so holding both variables in one table requires a **data frame** ([Lecture 1, Section 6.6](Concepts_Lecture.md#66-data-frames-versus-matrices)). Fix the seed before generating random numbers so that the results can be reproduced.

**Code:**

```r
set.seed(2025)                                         # fix the seed for reproducibility
HeightMale   <- rnorm(n = 10, mean = 173,   sd = 2)    # 10 male heights
HeightFemale <- rnorm(n = 10, mean = 162.3, sd = 2)    # 10 female heights
Gender <- factor(c(rep("Male", 10), rep("Female", 10)))
Height <- c(HeightMale, HeightFemale)
ourData <- data.frame(Gender = Gender, Height = Height)
ourData
str(ourData)
```

**Output:**

```text
   Gender   Height
1    Male 174.2415
2    Male 173.0713
3    Male 174.5463
4    Male 175.5450
5    Male 173.7420
6    Male 172.6743
7    Male 173.7942
8    Male 172.8400
9    Male 172.3101
10   Male 174.4043
11 Female 161.5086
12 Female 158.7899
13 Female 161.4581
14 Female 163.8298
15 Female 164.4323
16 Female 161.9126
17 Female 162.1957
18 Female 163.1353
19 Female 159.6746
20 Female 167.1580
'data.frame':	20 obs. of  2 variables:
 $ Gender: Factor w/ 2 levels "Female","Male": 2 2 2 2 2 2 2 2 2 2 ...
 $ Height: num  174 173 175 176 174 ...
```

- **`set.seed(2025)`:** Fixes the starting point of the random number generator. Running the same commands in the same order with the same seed reproduces the values above. Without a fixed seed, or with a different seed, the values change, but the men's heights still scatter around 173 and the women's around 162.3.
- **`rnorm(n = 10, mean = 173, sd = 2)`:** Creates 10 male heights from the normal distribution with mean 173 and standard deviation 2. The third argument is the standard deviation, not the variance. The female heights are created the same way.
- **`rep("Male", 10)`, `rep("Female", 10)`:** Repeat each string 10 times, and `c()` joins them into a gender vector of length 20. Wrapping it in `factor()` stores it as a categorical variable (a factor), whose levels are Female and Male in alphabetical order.
- **`Height <- c(HeightMale, HeightFemale)`:** Joins the heights of the two groups. The first 10 are men, matching the order of the gender vector.
- **`data.frame(Gender = Gender, Height = Height)`:** Creates a data frame whose columns are the two vectors. In the output of `str()`, `Gender` remains a factor and `Height` remains numeric, each keeping its own type.

**Matrix versus data frame:** Building the same table as a matrix with `cbind()` causes a problem. All elements of a matrix must have the same type, so the string-valued gender turns the heights into strings as well, and their mean cannot be computed.

```r
m <- cbind(Gender = c(rep("Male", 10), rep("Female", 10)),
           Height = c(HeightMale, HeightFemale))
head(m, 3)
mean(m[, "Height"])
```

```text
     Gender Height            
[1,] "Male" "174.241513471773"
[2,] "Male" "173.071282807422"
[3,] "Male" "174.546308968686"
[1] NA
Warning message:
In mean.default(m[, "Height"]) :
  argument is not numeric or logical: returning NA
```

Even if gender is supplied as a factor, a matrix turns it into integer codes (1 for Female, 2 for Male), and the category information is lost. This table, which holds variables of different types together, must therefore be a **data frame**. The sample output in the problem, with row numbers, column names, and strings without quotes, is also the printing format of a data frame.

> **Note:** The heights in the sample output given with the problem differ from the output above because the random seeds differ. In both results the men's heights lie around 170-179 and the women's around 158-168, so both satisfy the conditions.

How to compute descriptive statistics by group and plot the distributions with these data is shown in [Lecture 1, Section 8](Concepts_Lecture.md#8-descriptive-statistics-and-visualization).
