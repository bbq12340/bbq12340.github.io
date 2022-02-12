---
layout: post
title: Linear Algebra pt. 1
---
# Introduction
The note is based on the lecture, [Matrix Methods in Data Analysis, Signal Processing and Machine Learning](https://www.youtube.com/watch?v=Cx5Z-OslNWE&list=PLUl4u3cNGP63oMNUHXqIUcrkS2PivhN3k) taught by Gilbert Strang, M.I.T. The class material is [here](https://math.mit.edu/~gs/learningfromdata/). This note is to get a more clear idea about linear algebra and its understanding.

# Matrix-vector multiplication using Column Space of A
### Column Space
When we face $A\boldsymbol{x}=\boldsymbol{b}$ where $\boldsymbol{b}$ is non-zero, we've been calculating the multiplication by row times column; dot product. However, it seems very useful when we think vector-wise; column times row.
$$
given,\ \boldsymbol{x}\in\boldsymbol{R}^3
$$
$$
A\boldsymbol{x}=\begin{bmatrix}2&1&3\\
    3&1&4\\5&7&12
\end{bmatrix}\begin{bmatrix}x_1\\
    x_2\\x_3
\end{bmatrix}=\begin{bmatrix}
    2\\3\\5
\end{bmatrix}x_1+\begin{bmatrix}
    1\\1\\7
\end{bmatrix}x_2+\begin{bmatrix}
    3\\4\\12
\end{bmatrix}x_3
$$
$$
=combinations\ of\ columns\ of\ A
$$
When we think of all possible $A\boldsymbol{x}=\boldsymbol{b}$,
$$
all\ combinations\ of\ columns\ of\ A
$$
and let us denote this as,
$$
= C(A) = Column\ Space\ of\ A 
$$
in this case, the column space of A would be a plane since the $rank(A)=2$ which is a plane, a subspace of $\boldsymbol{R}^3$.
Thus, **The combinations of columns fills out the column space.**
+ Why is this important?
  When A is too big, and x=rand(m,1). We can sample 100 random x to have a broad idea about the columns of A.
+ Is $ABC\boldsymbol{x}$ columns of A? 
  yes. $A(BC)\boldsymbol{x}$

### Rank Theorem; rank(col)=rank(row)
We can factor A easily by
$$
A = CR \\
C:basis\ of\ the\ column\ space \\
$$
Since the dimension of column space of A and C is the same; rank = the number of independent columns,
$$
column\ rank = dim\ of\ column\ space = rank(A) \\
row\ space = all\ combination\ of\ rows = column\ space\ of\ A^T = C(A^T) \\
row\ rank = dim\ of\ row\ space=rank(A^T) \\
column\ rank=row\ rank=r
$$
Thus, **The number of independent columns equals to the number of independent rows.**
+ Why is this important?
  When A is 50x100 matrix, we know that the number of independent columns are equal or lower than 50.
+ What is matrix R?
  $R = row\ reduced\ echelon\ form\ of\ A$

### Counting Theorem; dim(col sp.) + dim(null sp.) = # of cols
From above, we now know that
$$
number\ of\ independent\ solutions\ for\ A\boldsymbol{x}=\boldsymbol{b}\\
= dim\ of\ column\ space\\
= rank(A) = r
$$
let us not forget that A is m x n matrix and $\boldsymbol{x}\in\boldsymbol{R}^n$. Besides column space, there is null space; all independent solutions to $A\boldsymbol{x}=\bold{0}$. So, since there are $n$ independent solutions in total, 
$$ 
number\ of\ independent\ solutions\ for\ A\boldsymbol{x}=\bold{0}\\
= n-r \\
= dim\ of\ null\ space
$$
And since, null space is orthogonal to row space of A,
$$
A\boldsymbol{x}=row_1\boldsymbol{x}+...+row_m\boldsymbol{x}=\begin{bmatrix}
    0\\.\\.\\.\\0
\end{bmatrix}\\
\lrArr\\
N(A)\perp C(A^T)
$$
We can then organize this thought just like below,
$$
Column\ Space: C(A)\\
Row\ Space: C(A^T)\\
Null\ Space: N(A)\\
Null\ Space\ of\ A^T: N(A^T)
$$
![4 fund subspaces](../images/fund_subspaces.jpeg)
Thus, these are called, **the 4 Fundamental Subspaces**.

We can also expand this vector-wise i.e. outerproduct perspective to the next step.
# Matrix-Matrix Multiplication
### Outer Product Approach
$$
A_{m\times n} B_{n\times p} = \begin{bmatrix}
    col_1&...&col_n
\end{bmatrix}\begin{bmatrix}
    row_1\\...\\row_m
\end{bmatrix}=sum\ of\ (col_k^A)\times(row_k^B)\\
\\
$$
Don't forget that the rank of each of columns and rows is 1. So,
$$
AB = sum\ of\ rank\ 1\ blocks
$$
I used blocks to express matrices just so to have a clearer picture. Coming back to the simple factorization using column space is also,
$$
A = CR = sum\ of\ (ind.\ col_k\ of\ A)\times(row_k\ of\ R)\\
= sum\ of\ rank\ 1\ blocks
$$
So, unlike dot product (inner product) where we have to calculate the whole matrix, outer produc approach allows us to see the matrix in broad idea with less calculation. We will see how useful it is by looking over to the next key step.

# The Five Key Factorization
1. Elimination $A=LU$
2. Gram-Schmidt $A=QR$
3. Spectural Theorem $S=Q\Delta Q^T$
4. $A=X\Delta X^T$
5. SVD $A=U\Sigma V^T$

### Elimination
$$
A = LU =\begin{bmatrix}
    1&&&0\\&.&&\\&&.&\\&&&1
\end{bmatrix}\begin{bmatrix}
    1&&&\\&.&&\\&&.&\\0&&&1
\end{bmatrix}
$$
In outer product perspective the equation above would be,
$$
A = sum\ of\ (col_k^L)\times(row_k^U)
$$
This in case would have a result like below,
$$
A = col_1\times row_1 + \begin{bmatrix}
    0&.&.&.&0\\ .\\ .&&A_2\\ .\\0
\end{bmatrix}=
col_1\times row_1 + col_2\times row_2 + \begin{bmatrix}
    0&.&.&.&0\\ .\\ .&&A_2\\ .\\0
\end{bmatrix}
$$